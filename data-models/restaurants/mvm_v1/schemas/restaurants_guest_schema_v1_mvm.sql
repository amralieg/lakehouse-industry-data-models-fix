-- Schema for Domain: guest | Business: Restaurants | Version: v1_mvm
-- Generated on: 2026-05-06 04:01:08

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `restaurants_ecm`.`guest` COMMENT 'Single source of truth for customer identity, profiles, preferences, demographics, segments, loyalty membership, and guest engagement across all channels (dine-in, drive-thru, online ordering). Manages CSAT, NPS, lifetime value, and consent/privacy management. Master record for WHO the business serves.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `restaurants_ecm`.`guest`.`profile` (
    `profile_id` BIGINT COMMENT 'Unique surrogate key for the guest profile record.',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Franchisee‑level loyalty aggregation report needs each guest linked to the franchisee that owns their primary restaurant.',
    `location_profile_id` BIGINT COMMENT 'Identifier of the location the guest most frequently visits.',
    `program_id` BIGINT COMMENT 'Identifier of the loyalty program membership associated with the guest.',
    `unit_id` BIGINT COMMENT 'Identifier of the specific store the guest prefers.',
    `profile_unit_id` BIGINT COMMENT 'Identifier of the specific store the guest prefers.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Assigning guest to a profit_center enables revenue attribution in multi‑brand restaurant profit reporting.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to guest.guest_guest_segment. Business justification: guest_segment_membership must reference the specific segment definition within the guest domain.',
    `address_line1` STRING COMMENT 'First line of the guests street address.',
    `address_line2` STRING COMMENT 'Second line of the guests street address (apartment, suite, etc.).',
    `average_check_value` DECIMAL(18,2) COMMENT 'Average monetary value per transaction for the guest.',
    `birthday_day` STRING COMMENT 'Day of month (1‑31) of the guests birth date.',
    `birthday_month` STRING COMMENT 'Numeric month (1‑12) of the guests birth date, used for birthday promotions.',
    `city` STRING COMMENT 'City component of the guests mailing address.',
    `consent_email` BOOLEAN COMMENT 'Guests consent to receive marketing emails.',
    `consent_privacy` BOOLEAN COMMENT 'Indicates whether the guest has consented to privacy policy and data processing.',
    `consent_sms` BOOLEAN COMMENT 'Guests consent to receive marketing SMS messages.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the guests residence. [ENUM-REF-CANDIDATE: USA|CAN|MEX|GBR|FRA|DEU|JPN|CHN|IND|BRA — 10 candidates stripped; promote to reference product]',
    `data_source` STRING COMMENT 'System of record that supplied the guest data.. Valid values are `salesforce|olo|micros|other`',
    `data_source_code` STRING COMMENT 'Original identifier of the guest in the source system.',
    `date_of_birth` DATE COMMENT 'Guests birth date for age verification and personalization.',
    `email_address` STRING COMMENT 'Primary email used for electronic communication and marketing.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `first_name` STRING COMMENT 'Given name of the guest.',
    `full_name` STRING COMMENT 'Complete legal name of the guest as stored in the master record.',
    `gender` STRING COMMENT 'Self‑declared gender of the guest for demographic analysis.. Valid values are `male|female|non_binary|prefer_not_to_say`',
    `guest_type` STRING COMMENT 'Classification of the guest based on relationship to the business.. Valid values are `guest|employee|vendor|franchisee|loyalty_member`',
    `last_name` STRING COMMENT 'Family name of the guest.',
    `last_visit_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent guest interaction.',
    `loyalty_tier` STRING COMMENT 'Current tier level of the guest within the loyalty program.. Valid values are `bronze|silver|gold|platinum`',
    `marketing_opt_in` BOOLEAN COMMENT 'Overall opt‑in flag for marketing communications across all channels.',
    `marketing_source` STRING COMMENT 'Origin channel through which the guest was first acquired.. Valid values are `in_store|online|app|third_party`',
    `notes` STRING COMMENT 'Unstructured notes entered by staff about the guest.',
    `phone_number` STRING COMMENT 'Main telephone number for SMS, voice contact, and verification.. Valid values are `^+?[0-9]{7,15}$`',
    `picture_url` STRING COMMENT 'Link to the guests profile image stored in the digital asset system.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the guests mailing address.',
    `preferred_language` STRING COMMENT 'Language the guest prefers for communications. [ENUM-REF-CANDIDATE: en|es|fr|de|zh|ja|pt — 7 candidates stripped; promote to reference product]',
    `primary_contact_method` STRING COMMENT 'Channel the guest most frequently uses for contact.. Valid values are `email|phone|sms|app_notification`',
    `profile_status` STRING COMMENT 'Current lifecycle status of the guest profile.. Valid values are `active|inactive|prospect|blocked|deceased`',
    `record_audit_created` TIMESTAMP COMMENT 'Date and time when the profile record was first created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Date and time of the most recent modification to the profile.',
    `state` STRING COMMENT 'State or province of the guests mailing address.',
    `total_lifetime_visits` STRING COMMENT 'Cumulative count of all visits (in‑store, drive‑thru, online) made by the guest.',
    `total_spent` DECIMAL(18,2) COMMENT 'Aggregate monetary amount the guest has spent across all transactions.',
    CONSTRAINT pk_profile PRIMARY KEY(`profile_id`)
) COMMENT 'Master record for every guest identity across all service channels (dine-in, drive-thru, OLO, 3PD). Single source of truth for WHO the business serves — captures full identity and demographic attributes including name, contact details, date of birth, language preference, age band, gender identity, household income band, education level, employment status, geographic market classification, demographic data source (self-declared vs. third-party enrichment), enrichment provider and date. Also owns digital account attributes: username, account status (active/suspended/deactivated), registration date, registration channel, last login timestamp, device type, app version, two-factor authentication status, and account tier. Sourced primarily from Salesforce CRM, Olo Digital Ordering Platform, and brand mobile app. This is the anchor entity for the entire guest domain.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`guest`.`address` (
    `address_id` BIGINT COMMENT 'System-generated unique identifier for the address record.',
    `profile_id` BIGINT COMMENT 'Unique identifier of the guest to whom this address belongs.',
    `address_profile_id` BIGINT COMMENT 'Unique identifier of the guest to whom this address belongs.',
    `owner_profile_id` BIGINT COMMENT 'Identifier of the owning entity (guest, restaurant, etc.).',
    `address_status` STRING COMMENT 'Current lifecycle status of the address record.. Valid values are `active|inactive|invalid|pending`',
    `address_type` STRING COMMENT 'Classification of the address purpose.. Valid values are `home|work|delivery|billing|other`',
    `building_name` STRING COMMENT 'Name of the building, if applicable.',
    `city` STRING COMMENT 'City or municipality of the address.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code.. Valid values are `^[A-Z]{3}$`',
    `county` STRING COMMENT 'County or equivalent administrative area.',
    `created_timestamp` TIMESTAMP COMMENT 'When the address record was first created in the system.',
    `delivery_instructions` STRING COMMENT 'Special instructions for delivering to this address (e.g., gate code, porch).',
    `district` STRING COMMENT 'Sub‑municipal district or neighborhood.',
    `geocode_accuracy` STRING COMMENT 'Quality level of the geocoding result.. Valid values are `high|medium|low`',
    `is_primary` BOOLEAN COMMENT 'Indicates whether this is the guests primary address.',
    `landmark` STRING COMMENT 'Nearby landmark or point of reference to aid delivery.',
    `last_verified` DATE COMMENT 'Date of the most recent successful verification.',
    `latitude` DOUBLE COMMENT 'Geographic latitude coordinate of the address.',
    `line1` STRING COMMENT 'Primary street address line (e.g., house number and street name).',
    `line2` STRING COMMENT 'Secondary address information such as apartment, suite, or unit.',
    `longitude` DOUBLE COMMENT 'Geographic longitude coordinate of the address.',
    `owner_type` STRING COMMENT 'Entity type that owns or uses the address.. Valid values are `guest|restaurant|franchise|vendor`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the address.. Valid values are `^[A-Za-z0-9 -]{3,10}$`',
    `region` STRING COMMENT 'Broad geographic region (e.g., Midwest, West Coast).',
    `source_system` STRING COMMENT 'Originating system that supplied the address (e.g., OLO, POS, CRM).',
    `state_province` STRING COMMENT 'State, province, or region of the address.',
    `suite_number` STRING COMMENT 'Suite, unit, or floor number within a building.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the address location.',
    `updated_timestamp` TIMESTAMP COMMENT 'Most recent date and time the address record was modified.',
    `validation_status` STRING COMMENT 'Result of the most recent address validation attempt.. Valid values are `validated|unvalidated|failed`',
    `validation_timestamp` TIMESTAMP COMMENT 'Date and time when the address was last validated.',
    `validity_flag` BOOLEAN COMMENT 'True if the address is currently considered valid for delivery.',
    `verification_method` STRING COMMENT 'Method used to verify the address.. Valid values are `postal|third_party|self_report`',
    `verification_score` DECIMAL(18,2) COMMENT 'Numeric confidence score (0‑100) from the verification service.',
    CONSTRAINT pk_address PRIMARY KEY(`address_id`)
) COMMENT 'Stores all physical and delivery addresses associated with a guest profile, including home address, saved delivery addresses, and billing addresses. Captures address type, street, city, state/province, postal code, country, geolocation coordinates, delivery instructions, and validation status. Supports OLO delivery fulfillment and personalized marketing by geography.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`guest`.`preference` (
    `preference_id` BIGINT COMMENT 'Primary key for preference record. _canonical_skip_reason: Entity does not fit standard master or transaction roles; treated as OTHER.',
    `allergen_declaration_id` BIGINT COMMENT 'Foreign key linking to menu.allergen_declaration. Business justification: Cross-referencing a guests allergen profile against the active allergen declaration powers safe-ordering recommendations at POS/OLO and satisfies FDA menu labeling compliance. Foodservice allergen ma',
    `ingredient_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient. Business justification: Required for allergy compliance: linking each guests allergen profile to the ingredient master enables order screening and regulatory reporting of allergen exposure.',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: Tier-based personalization (e.g., Gold members receive different offer preferences) requires a normalized FK to loyalty.tier. The existing plain-text loyalty_tier column is a denormalized representa',
    `menu_item_id` BIGINT COMMENT 'Identifier of the guests most frequently ordered menu item.',
    `profile_id` BIGINT COMMENT 'Unique identifier of the guest to whom this preference belongs.',
    `preference_profile_id` BIGINT COMMENT 'Unique identifier of the guest to whom this preference belongs.',
    `preference_unsafe_menu_item_id` BIGINT COMMENT 'Foreign key linking to menu.menu_item. Business justification: Real-time allergen-safe item filtering at POS and OLO requires linking a guests allergen profile directly to unsafe menu items. This enables items to avoid warnings during ordering — a named food s',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Multi-brand operators (RBI, Yum! Brands) use brand-level preference for cross-brand marketing suppression and brand-specific loyalty segmentation. A guest may prefer Brand A over Brand B; this drives ',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Location-based personalization engine uses a guests preferred unit to deliver unit-specific offers, push notifications, and menu recommendations. Distinct from profile.preferred_store_unit_id — prefe',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.program. Business justification: In multi-program restaurant groups, guest communication and dietary preferences are scoped per loyalty program (e.g., email opt-in for Program A differs from Program B). Program-specific preference ma',
    `stock_item_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_item. Business justification: Allergy‑management process needs to map each guests allergen profile to specific stock items containing the allergen for safe‑menu recommendations.',
    `communication_channel_preference` STRING COMMENT 'Guests preferred channel for receiving communications.. Valid values are `email|sms|push|none`',
    `consent_given` BOOLEAN COMMENT 'Indicates whether the guest has given consent for storing this preference.',
    `consent_timestamp` TIMESTAMP COMMENT 'Timestamp when consent was recorded.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the preference record was first created.',
    `data_source_timestamp` TIMESTAMP COMMENT 'Timestamp when the source system recorded the preference.',
    `device_preference` STRING COMMENT 'Preferred device type for digital interactions.. Valid values are `kiosk|mobile|tablet`',
    `effective_from` DATE COMMENT 'Date from which the preference is considered effective.',
    `effective_until` DATE COMMENT 'Date after which the preference is no longer effective (null if open-ended).',
    `favorite_cuisine` STRING COMMENT 'Guests preferred cuisine type (e.g., Italian, Mexican).',
    `has_dairy_allergy` BOOLEAN COMMENT 'Indicates if the guest has a dairy allergy.',
    `has_gluten_allergy` BOOLEAN COMMENT 'Indicates if the guest has a gluten allergy.',
    `has_nut_allergy` BOOLEAN COMMENT 'Indicates if the guest has a nut allergy.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the preference is currently active.',
    `is_halal` BOOLEAN COMMENT 'Indicates if the guest requires halal meals.',
    `is_kosher` BOOLEAN COMMENT 'Indicates if the guest requires kosher meals.',
    `is_vegan` BOOLEAN COMMENT 'Indicates if the guest prefers vegan meals.',
    `is_vegetarian` BOOLEAN COMMENT 'Indicates if the guest prefers vegetarian meals.',
    `language_preference` STRING COMMENT 'Guests preferred language for communications.',
    `marketing_opt_in` BOOLEAN COMMENT 'Indicates if the guest has opted in to receive marketing communications.',
    `marketing_opt_out_reason` STRING COMMENT 'Reason provided by the guest for opting out of marketing communications.',
    `notes` STRING COMMENT 'Free-form notes or comments about the preference.',
    `origin` STRING COMMENT 'How the preference was captured.. Valid values are `manual|system|survey`',
    `preference_status` STRING COMMENT 'Current lifecycle status of the preference record.. Valid values are `active|inactive|archived`',
    `preference_type` STRING COMMENT 'Category of the preference indicating its domain. [ENUM-REF-CANDIDATE: dietary|cuisine|menu_item|service_channel|daypart|communication|marketing|loyalty|other — promote to reference product]',
    `preference_value` DECIMAL(18,2) COMMENT 'The actual value or description of the preference, such as "no peanuts" or "Italian".',
    `preferred_daypart` STRING COMMENT 'Time of day the guest most often dines.. Valid values are `breakfast|brunch|lunch|dinner|late_night`',
    `preferred_payment_method` STRING COMMENT 'Guests favored payment method.. Valid values are `cash|card|mobilepay`',
    `preferred_seating` STRING COMMENT 'Guests favored seating location within the restaurant.. Valid values are `indoor|outdoor|bar|window`',
    `preferred_service_channel` STRING COMMENT 'Guests preferred way to receive service.. Valid values are `dine_in|drive_thru|online|delivery`',
    `privacy_consent_version` STRING COMMENT 'Version of the privacy consent agreement under which the preference was collected.',
    `source_system` STRING COMMENT 'System that supplied the preference data.. Valid values are `salesforce|olo|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the preference record.',
    CONSTRAINT pk_preference PRIMARY KEY(`preference_id`)
) COMMENT 'Captures all guest-stated and inferred preferences, dietary restrictions, and food allergen declarations. Covers FDA major allergens (milk, eggs, fish, shellfish, tree nuts, peanuts, wheat, soybeans, sesame) with severity levels (intolerance vs. allergy), dietary restriction types (vegetarian, vegan, halal, kosher, gluten-free), declaration source (self-declared, healthcare provider), cuisine preferences, favorite menu items, preferred service channel (dine-in, DT, OLO), preferred daypart, communication channel preferences (email, SMS, push), and marketing opt-in/opt-out flags. Sourced from Salesforce CRM, Olo guest data, and guest self-declaration. Drives personalization, targeted marketing, and HACCP-aligned guest food safety compliance including FDA allergen labeling requirements.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`guest`.`consent_record` (
    `consent_record_id` BIGINT COMMENT 'System-generated unique identifier for the consent record.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: GDPR/CCPA compliance requires brand-scoped consent records in multi-brand operators — consent for Brand As marketing does not extend to Brand B. Regulatory audits and data subject access requests req',
    `profile_id` BIGINT COMMENT 'Unique identifier of the guest to whom this consent applies.',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.program. Business justification: GDPR/CCPA compliance requires consent records to be scoped to the specific loyalty program under which consent was obtained. Program-scoped consent management enables accurate consent audit trails, pr',
    `consent_expiry_date` DATE COMMENT 'Date when the consent automatically expires, if applicable.',
    `consent_language` STRING COMMENT 'Two‑letter language code of the consent notice presented to the guest.. Valid values are `^[a-z]{2}$`',
    `consent_method` STRING COMMENT 'Method by which the guest expressed consent (opt‑in, opt‑out, implied).. Valid values are `opt_in|opt_out|implied`',
    `consent_purpose` STRING COMMENT 'Free‑text description of the business purpose for which consent was obtained.',
    `consent_revoked_reason` STRING COMMENT 'Free‑text reason provided by the guest for withdrawing consent, if any.',
    `consent_revoked_timestamp` TIMESTAMP COMMENT 'Timestamp when the guest withdrew the consent.',
    `consent_source_channel` STRING COMMENT 'Channel through which the guest provided consent.. Valid values are `online|in_store|mobile_app|call_center|email`',
    `consent_status` STRING COMMENT 'Current lifecycle status of the consent.. Valid values are `granted|withdrawn|expired|pending`',
    `consent_timestamp` TIMESTAMP COMMENT 'Date and time when the consent was originally given.',
    `consent_type` STRING COMMENT 'Category of consent (e.g., marketing, SMS, email, data sharing, profiling).. Valid values are `marketing|sms|email|data_sharing|profiling`',
    `consent_version` STRING COMMENT 'Version identifier of the privacy policy or consent notice at the time of consent.',
    `created` TIMESTAMP COMMENT 'Timestamp when the consent record was first created in the system.',
    `data_processing_scope` STRING COMMENT 'Scope of data processing covered by the consent.. Valid values are `full|limited|custom`',
    `data_sharing_consent` BOOLEAN COMMENT 'True if the guest consented to internal data sharing for analytics or personalization.',
    `device_code` STRING COMMENT 'Identifier of the device used to capture consent (e.g., mobile device ID).',
    `effective_from` DATE COMMENT 'Date from which the consent is considered active.',
    `effective_until` DATE COMMENT 'Date until which the consent remains valid (null if open‑ended).',
    `email_consent` BOOLEAN COMMENT 'True if the guest consented to receive email communications.',
    `ip_address` STRING COMMENT 'IP address from which the consent was captured.. Valid values are `^([0-9]{1,3}.){3}[0-9]{1,3}$`',
    `marketing_consent` BOOLEAN COMMENT 'True if the guest consented to receive marketing communications.',
    `privacy_notice_version` STRING COMMENT 'Identifier of the privacy notice version referenced by this consent.',
    `sms_consent` BOOLEAN COMMENT 'True if the guest consented to receive SMS messages.',
    `third_party_consent` BOOLEAN COMMENT 'True if the guest consented to share data with approved third parties.',
    `updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the consent record.',
    CONSTRAINT pk_consent_record PRIMARY KEY(`consent_record_id`)
) COMMENT 'Authoritative record of guest consent and privacy elections per regulatory requirement (GDPR, CCPA, CAN-SPAM). Tracks consent type (marketing email, SMS, data sharing, profiling), consent status (granted/withdrawn), consent timestamp, consent source channel, consent version/policy version, and expiry date. Mandatory for compliance with FDA labeling, FTC advertising regulations, and applicable data privacy laws. Immutable audit trail of all consent changes.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`guest`.`segment` (
    `segment_id` BIGINT COMMENT 'Unique identifier for the guest_guest_segment data product (auto-inserted pre-linking).',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: In multi-brand operators, guest segments are brand-specific (e.g., Lapsed Burger Fan belongs to a specific brand). Segment activation, suppression logic, and brand-level audience sizing all require ',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.program. Business justification: Guest segments in restaurant CRM are defined within loyalty program scope (e.g., lapsed Gold members in Program X). A program FK on guest_segment enables program-specific segment targeting for loyal',
    CONSTRAINT pk_segment PRIMARY KEY(`segment_id`)
) COMMENT 'Defines guest segmentation classifications used for targeted marketing, personalization, and operational planning. Captures segment name, segment type (behavioral, demographic, value-based, lifecycle stage), definition criteria, effective date range, segment owner (marketing vs. operations), and channel applicability. Examples include high-frequency QSR visitors, lapsed guests, LTO responders, and high-ACV guests. Managed in Salesforce CRM.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`guest`.`lifetime_value` (
    `lifetime_value_id` BIGINT COMMENT 'Unique identifier for the lifetime value record.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Multi-brand operators calculate LTV per brand separately (a guest may have high LTV at Brand A and low at Brand B). Brand-level LTV reporting drives brand portfolio investment decisions and brand-spec',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: LTV snapshots are calculated and reported against specific fiscal periods for franchise financial planning and period-over-period guest value trend analysis. Foodservice finance teams require LTV figu',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Unit-level LTV attribution is required for franchisee royalty calculations and unit-level revenue reporting. Finance teams attribute guest lifetime value to a home unit to measure unit contribution to',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: The plain-text ltv_tier column is a denormalized representation of the loyalty tier entity. A normalized FK to loyalty.tier supports tier-based LTV cohort analysis, tier upgrade threshold modeling, ',
    `profile_id` BIGINT COMMENT 'Unique identifier of the guest to whom this lifetime value belongs.',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.program. Business justification: LTV calculations in restaurant CRM are program-scoped — predicted_future_value, total_historical_spend, and ltv_tier are meaningful only within a specific loyalty program context. Multi-program operat',
    `average_check_value` DECIMAL(18,2) COMMENT 'Average monetary value of a single transaction for the guest.',
    `average_transactions_per_month` DECIMAL(18,2) COMMENT 'Mean count of transactions the guest completes each month.',
    `consent_opt_in` BOOLEAN COMMENT 'True if the guest has opted in to data collection and marketing communications.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the LTV record was first created in the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter currency identifier for all monetary fields.. Valid values are `[A-Z]{3}`',
    `data_refresh_cycle` STRING COMMENT 'Scheduled frequency at which the LTV metrics are recomputed.. Valid values are `daily|weekly|monthly|quarterly`',
    `days_since_last_visit` STRING COMMENT 'Number of days between today and the most recent visit date.',
    `first_visit_date` DATE COMMENT 'Calendar date of the guests inaugural purchase.',
    `loyalty_member_flag` BOOLEAN COMMENT 'True if the guest is enrolled in the restaurants loyalty program.',
    `ltv_calculation_date` DATE COMMENT 'Calendar date on which the LTV metrics were most recently refreshed.',
    `ltv_last_updated` TIMESTAMP COMMENT 'Exact moment the LTV record was last refreshed.',
    `ltv_status` STRING COMMENT 'Current lifecycle state of the LTV record.. Valid values are `active|inactive|archived`',
    `most_recent_visit_date` DATE COMMENT 'Calendar date of the guests latest purchase.',
    `notes` STRING COMMENT 'Additional commentary or observations about the LTV record.',
    `predicted_future_value` DECIMAL(18,2) COMMENT 'Forecasted monetary contribution of the guest over the next 12 months.',
    `segment` STRING COMMENT 'Analytical segment assigned to the guest for targeting.. Valid values are `high_value|medium_value|low_value|new|churn_risk`',
    `source_system` STRING COMMENT 'Originating operational system for the transaction data used in LTV calculation.. Valid values are `micros|olo|salesforce|other`',
    `total_historical_spend` DECIMAL(18,2) COMMENT 'Cumulative monetary amount the guest has spent across all transactions to date.',
    `total_visits` STRING COMMENT 'Total number of distinct visits (in‑store, drive‑thru, or online) recorded for the guest.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the LTV record.',
    CONSTRAINT pk_lifetime_value PRIMARY KEY(`lifetime_value_id`)
) COMMENT 'Stores calculated and periodically refreshed guest lifetime value (LTV) metrics at the individual profile level. Captures total historical spend, visit frequency, average check value (ACV), average transaction count (ATC), predicted future value, LTV tier classification, first visit date, most recent visit date, and days since last visit. Refreshed on a scheduled cadence from order domain transactional data. Supports retention prioritization and loyalty tier management.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` (
    `satisfaction_survey_id` BIGINT COMMENT 'Unique identifier for each satisfaction survey instance.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Brand-level NPS and CSAT reporting aggregate survey scores by brand for executive brand health dashboards. Multi-brand operators (e.g., Inspire Brands) require brand-scoped satisfaction KPIs to alloca',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Post-campaign satisfaction surveys measure campaign effectiveness via CSAT/NPS. Linking survey to the triggering campaign enables campaign-level satisfaction reporting — a named restaurant marketing m',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Franchisee satisfaction KPI dashboard aggregates survey results per franchisee for performance monitoring.',
    `guest_order_id` BIGINT COMMENT 'Foreign key linking to order.guest_order. Business justification: Post-transaction CSAT/NPS surveys are triggered by specific order events. Linking satisfaction_survey to guest_order enables order-level feedback analysis, complaint root-cause investigation, and oper',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Post-redemption and post-visit NPS/CSAT surveys are analyzed by loyalty tier to measure program health and member satisfaction. Linking satisfaction_survey directly to loyalty.member enables tier-stra',
    `menu_item_id` BIGINT COMMENT 'Foreign key linking to menu.menu_item. Business justification: Item-level satisfaction scoring is a core menu engineering input in QSR/casual dining. Surveys tied to a specific menu item drive CSAT-by-item reports and menu engineering classification decisions. An',
    `performance_scorecard_id` BIGINT COMMENT 'Foreign key linking to franchise.performance_scorecard. Business justification: Franchisor performance scorecards store customer_satisfaction_score and net_promoter_score derived from guest surveys. Linking each survey to its evaluation period scorecard enables auditors and franc',
    `profile_id` BIGINT COMMENT 'Unique identifier of the guest who received the survey.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where the guest experience occurred.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Needed for Service Quality Dashboard linking survey scores to the serving employee, supporting performance coaching and bonus calculations.',
    `shift_id` BIGINT COMMENT 'Foreign key linking to workforce.shift. Business justification: Service-quality reporting in QSR operations correlates CSAT/NPS scores with the specific shift (daypart, staffing level, shift type) during which the guest was served. This shift-quality correlation r',
    `tertiary_satisfaction_unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where the guest experience occurred.',
    `visit_id` BIGINT COMMENT 'Foreign key linking to guest.guest_visit. Business justification: A satisfaction survey is triggered by a specific guest visit. Linking satisfaction_survey.guest_visit_id to guest_visit.guest_visit_id establishes the causal relationship between the visit event and t',
    `comments` STRING COMMENT 'Free‑text comments entered by the guest.',
    `completion_status` STRING COMMENT 'Indicates whether the guest completed, partially completed, declined, or never received the survey.. Valid values are `completed|partial|declined|not_sent`',
    `consent_given` BOOLEAN COMMENT 'Indicates whether the guest consented to be surveyed and to have their responses stored.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the survey record was first created in the lakehouse.',
    `csat_score` STRING COMMENT 'CSAT rating provided by the guest, typically on a 1‑5 scale.',
    `daypart` STRING COMMENT 'Business day segment during which the visit occurred.. Valid values are `breakfast|lunch|dinner|late_night`',
    `delivery_channel` STRING COMMENT 'Channel used to deliver the survey to the guest.. Valid values are `email|sms|in_app|receipt_qr`',
    `delivery_timestamp` TIMESTAMP COMMENT 'Date‑time when the survey was sent to the guest.',
    `language` STRING COMMENT 'ISO language code of the survey presented to the guest.',
    `nps_score` STRING COMMENT 'NPS rating provided by the guest on a scale of 0‑10.',
    `response_timestamp` TIMESTAMP COMMENT 'Date‑time when the guest submitted the survey response.',
    `satisfaction_survey_status` STRING COMMENT 'Current lifecycle status of the survey record.. Valid values are `active|inactive|archived`',
    `source_system` STRING COMMENT 'System of record that originated the survey record.. Valid values are `salesforce|olo|custom`',
    `survey_type` STRING COMMENT 'Classification of the survey (Customer Satisfaction, Net Promoter Score, or post‑delivery feedback).. Valid values are `csat|nps|post_delivery`',
    `survey_version` STRING COMMENT 'Version identifier of the survey questionnaire used.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the survey record.',
    `visit_date` DATE COMMENT 'Calendar date of the guests visit, derived from visit_timestamp.',
    `visit_timestamp` TIMESTAMP COMMENT 'Date‑time when the guests visit or order took place.',
    CONSTRAINT pk_satisfaction_survey PRIMARY KEY(`satisfaction_survey_id`)
) COMMENT 'Records guest satisfaction survey instances with full question-level response detail. Captures survey type (CSAT, NPS, post-delivery, post-visit), delivery channel (email, SMS, in-app, receipt QR), delivery timestamp, completion status, NPS score (0-10), CSAT score, restaurant unit, daypart, and respondent profile. Includes granular question-level data: question text, question type (rating, open-text, multiple-choice), response value, response timestamp, and sentiment classification for open-text responses. Sourced from Salesforce CRM and Olo guest feedback flows. Enables CSAT/NPS driver analysis at both survey and question level, supporting operational improvement across FOH and BOH.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`guest`.`complaint` (
    `complaint_id` BIGINT COMMENT 'System-generated unique identifier for the complaint record.',
    `profile_id` BIGINT COMMENT 'Unique identifier of the guest who raised the complaint.',
    `complaint_profile_id` BIGINT COMMENT 'Unique identifier of the guest who raised the complaint.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the complaint originated.',
    `complaint_unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the complaint originated.',
    `compliance_audit_id` BIGINT COMMENT 'Foreign key linking to franchise.compliance_audit. Business justification: Guest complaints (especially food safety and brand standards violations) are reviewed and cited during franchise compliance audits. Auditors reference specific complaint records when scoring franchise',
    `equipment_asset_id` BIGINT COMMENT 'Foreign key linking to restaurant.equipment_asset. Business justification: HACCP and health department regulations require linking food safety complaints (temperature abuse, equipment malfunction causing illness) to the specific equipment asset. Food safety officers and regu',
    `facility_id` BIGINT COMMENT 'Foreign key linking to realestate.facility. Business justification: Guest complaints about physical conditions (broken equipment, cleanliness, ADA issues, unsafe premises) must be linked to the specific facility to trigger maintenance work orders and track facility-le',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Franchisee complaint management system tracks complaints per franchisee to meet service quality standards.',
    `guest_order_id` BIGINT COMMENT 'Identifier of the order associated with the complaint, if applicable.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required for Complaint Resolution Report that assigns a responsible employee to each complaint, enabling accountability and SLA tracking.',
    `health_inspection_id` BIGINT COMMENT 'Foreign key linking to foodsafety.health_inspection. Business justification: Guest food safety complaints escalated to health authorities can trigger or be referenced in a health inspection. Foodservice regulatory practice requires linking the originating guest complaint to th',
    `illness_report_id` BIGINT COMMENT 'Foreign key linking to foodsafety.illness_report. Business justification: When a guest complaint is categorized as a foodborne illness complaint, it must reference the resulting illness_report for regulatory traceability and health department notification. Foodservice compl',
    `ingredient_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient. Business justification: Needed for food safety incident tracking: associating complaints with the specific ingredient allows root‑cause analysis, recall decisions, and FDA reporting.',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Loyalty member complaints require tier-aware resolution workflows — Gold/Platinum members receive priority handling and points compensation. A direct FK to loyalty.member on complaint enables tier-bas',
    `order_item_id` BIGINT COMMENT 'Foreign key linking to order.order_item. Business justification: Complaints are frequently about a specific menu item (wrong item, food quality, allergen incident). Linking complaint to order_item enables item-level complaint analysis, supplier quality reporting, a',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to marketing.promotion. Business justification: Complaints are frequently triggered by promotion misapplication, incorrect discounts, or coupon fraud. Linking complaint to the specific promotion enables promotion quality review, compliance tracking',
    `recall_event_id` BIGINT COMMENT 'Foreign key linking to supply.recall_event. Business justification: Food safety complaint management requires linking guest complaints directly to active recall events for FDA/USDA regulatory reporting, liability tracking, and root-cause analysis. Foodservice operatio',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Complaint resolution payouts (resolution_amount already on complaint) must be posted to a specific GL account for expense recognition and P&L reporting. Foodservice controllers require GL account assi',
    `satisfaction_survey_id` BIGINT COMMENT 'Foreign key linking to guest.satisfaction_survey. Business justification: A complaint case is frequently triggered by a low-scoring satisfaction survey response (e.g., NPS detractor or low CSAT). Linking complaint.satisfaction_survey_id to satisfaction_survey.satisfaction_s',
    `shift_id` BIGINT COMMENT 'Foreign key linking to workforce.shift. Business justification: Root-cause analysis of guest complaints requires linking the incident to the shift during which it occurred — enabling QSR operations managers to identify whether complaint spikes correlate with speci',
    `stock_item_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_item. Business justification: Food safety complaint traceability: when a guest complaint involves a contaminated or spoiled product, operators must trace it to the specific inventory stock item for recall management and FDA tracea',
    `visit_id` BIGINT COMMENT 'Foreign key linking to guest.guest_visit. Business justification: A guest complaint is typically raised about a specific visit experience. Linking complaint.guest_visit_id to guest_visit.guest_visit_id allows the business to trace every complaint back to the exact v',
    `channel` STRING COMMENT 'Channel through which the complaint was received.. Valid values are `in_store|drive_thru|phone|online|social_media|other`',
    `complaint_category` STRING COMMENT 'Primary classification of the complaint reason.. Valid values are `food_quality|speed_of_service|order_accuracy|cleanliness|staff_behavior|other`',
    `complaint_description` STRING COMMENT 'Free‑text description provided by the guest detailing the issue.',
    `complaint_number` STRING COMMENT 'Human‑readable business identifier assigned to the complaint (e.g., C‑20231234).',
    `complaint_status` STRING COMMENT 'Current lifecycle state of the complaint.. Valid values are `open|in_progress|resolved|closed|escalated`',
    `complaint_timestamp` TIMESTAMP COMMENT 'Date and time when the complaint was initially recorded.',
    `consent_given` BOOLEAN COMMENT 'Indicates whether the guest consented to store and process their personal data for this complaint.',
    `csat_score` STRING COMMENT 'Post‑resolution CSAT rating provided by the guest (1‑10).',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the resolution amount.',
    `escalated_to` BIGINT COMMENT 'Identifier of the employee or manager to whom the complaint was escalated.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the complaint was escalated to higher management.',
    `feedback_comments` STRING COMMENT 'Additional free‑text feedback from the guest regarding the complaint handling.',
    `nps_score` STRING COMMENT 'NPS rating captured after resolution (0‑10).',
    `privacy_consent_timestamp` TIMESTAMP COMMENT 'Timestamp when the guest provided privacy consent.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp when the complaint record was first persisted in the data lake.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp of the most recent update to the complaint record.',
    `resolution_amount` DECIMAL(18,2) COMMENT 'Monetary value associated with the resolution (e.g., refund amount).',
    `resolution_status` STRING COMMENT 'Current status of the complaint resolution process.. Valid values are `pending|resolved|closed|escalated`',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the complaint was resolved.',
    `resolution_type` STRING COMMENT 'Method used to resolve the complaint.. Valid values are `refund|replacement|apology|comp|none`',
    `severity_level` STRING COMMENT 'Business‑defined severity indicating impact on guest experience.. Valid values are `low|medium|high|critical`',
    `source_system` STRING COMMENT 'Originating operational system (e.g., Salesforce Service Cloud).',
    CONSTRAINT pk_complaint PRIMARY KEY(`complaint_id`)
) COMMENT 'Operational record of a guest complaint or service recovery case raised through any channel (in-restaurant, phone, digital, social media). Captures complaint category (food quality, speed of service/SOS, order accuracy, cleanliness, staff behavior), severity level, channel of receipt, restaurant unit, associated order reference, resolution status, resolution type (refund, replacement, apology), resolution timestamp, and escalation flag. Managed in Salesforce CRM service cloud.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`guest`.`channel_identity` (
    `channel_identity_id` BIGINT COMMENT 'System-generated unique identifier for each channel identity record.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Channel identities (loyalty card, app ID, social login) are brand-specific in multi-brand operators. A guest holds separate channel identities per brand. Brand-scoped identity resolution is standard i',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Omnichannel loyalty identity resolution maps POS card numbers, app IDs, and third-party delivery identifiers directly to loyalty member accounts. This FK enables real-time member lookup at point of sa',
    `profile_id` BIGINT COMMENT 'Reference to the canonical guest profile that this channel identity belongs to.',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.program. Business justification: Channel identities (POS card, app login, web account) are enrolled in specific loyalty programs. Linking channel_identity to program supports multi-program enrollment tracking, channel-level program a',
    `channel_identity_status` STRING COMMENT 'Current lifecycle status of the channel identity record.. Valid values are `active|inactive|suspended|pending`',
    `channel_name` STRING COMMENT 'Logical name of the channel source (e.g., POS, Online Ordering, CRM, Third‑Party Delivery, Loyalty App).. Valid values are `POS|OLO|Salesforce|ThirdParty|LoyaltyApp|Other`',
    `channel_user_email` STRING COMMENT 'Email address of the guest in the source channel.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `channel_user_name` STRING COMMENT 'Display name of the guest as known in the source channel.',
    `channel_user_phone` STRING COMMENT 'Phone number of the guest in the source channel.',
    `consent_opt_in` BOOLEAN COMMENT 'Guests consent to receive marketing communications via this channel.',
    `created_by_system` STRING COMMENT 'Name of the source system that initially created the channel identity record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the channel identity record was first created in the lakehouse.',
    `effective_from` DATE COMMENT 'Date when the external identifier became valid for the guest.',
    `effective_until` DATE COMMENT 'Date when the external identifier ceased to be valid (null if still active).',
    `external_identifier` STRING COMMENT 'Identifier assigned to the guest in the source system (e.g., email address, loyalty card number, device ID).',
    `identifier_type` STRING COMMENT 'Category describing the nature of the external identifier.. Valid values are `email|phone|loyalty_card|device_id|third_party_id|account_number`',
    `is_active` BOOLEAN COMMENT 'Indicates whether the channel identity is currently active for the guest.',
    `is_primary` BOOLEAN COMMENT 'Indicates whether this channel is the primary identity source for the guest.',
    `is_test_account` BOOLEAN COMMENT 'Indicates whether the record belongs to a test or sandbox account.',
    `last_updated_by_system` STRING COMMENT 'Name of the system that performed the most recent update.',
    `last_verified_timestamp` TIMESTAMP COMMENT 'When the external identifier was last verified as belonging to the guest.',
    `loyalty_tier` STRING COMMENT 'Guests loyalty tier as recorded in the channel (if applicable).. Valid values are `bronze|silver|gold|platinum`',
    `notes` STRING COMMENT 'Optional free‑text comments or remarks about the channel identity.',
    `privacy_status` STRING COMMENT 'Current privacy state for the channel identity (consented, revoked, unknown).',
    `record_status` STRING COMMENT 'Operational status of the record within the data lake (e.g., current, archived, deleted).. Valid values are `current|archived|deleted`',
    `record_version` STRING COMMENT 'Monotonically increasing version number for optimistic concurrency control.',
    `source_system` STRING COMMENT 'Technical system that originated the external identifier.. Valid values are `Oracle MICROS|Olo|Salesforce CRM|Third‑Party Delivery|Loyalty Application|Other`',
    `source_system_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the source system first created the external identifier.',
    `source_system_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent change to the external identifier in the source system.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the channel identity record.',
    `verification_method` STRING COMMENT 'Method used to verify the external identifier.. Valid values are `email|sms|phone|in_store|none`',
    CONSTRAINT pk_channel_identity PRIMARY KEY(`channel_identity_id`)
) COMMENT 'Stores channel-specific guest identifiers that map back to the canonical guest profile. Captures the source system (Oracle MICROS POS, Olo, Salesforce CRM, 3PD partner, loyalty app), the external identifier in that system, identifier type (email, phone, loyalty card number, device ID, 3PD customer ID), creation date, and active status. Enables cross-channel identity stitching and supports the identity resolution process.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`guest`.`visit` (
    `visit_id` BIGINT COMMENT 'Unique identifier for the guest_visit data product (auto-inserted pre-linking).',
    `digital_account_id` BIGINT COMMENT 'Foreign key linking to guest.digital_account. Business justification: Guest visits originating from digital channels (mobile app, web OLO) are initiated through a registered digital account. Linking guest_visit.digital_account_id to digital_account.digital_account_id en',
    `guest_order_id` BIGINT COMMENT 'Foreign key linking to order.guest_order. Business justification: Every restaurant visit is anchored to a transaction. Linking guest_visit to guest_order enables visit-level SOS reporting, loyalty point attribution, and dine-in analytics. A foodservice domain expert',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Guest Flow Management records which host/hostess greeted the guest, essential for staffing analysis and guest experience metrics.',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Guest visits are the primary loyalty points-earning events. Linking guest_visit directly to loyalty.member supports visit-based accrual attribution, visit count tracking for tier qualification, and vi',
    `pos_terminal_id` BIGINT COMMENT 'Foreign key linking to restaurant.pos_terminal. Business justification: Transaction reconciliation, fraud investigation, and loss prevention require linking each guest visit to the specific POS terminal that processed it. Audit and finance teams use this daily for chargeb',
    `profile_id` BIGINT COMMENT 'Foreign key linking to guest.profile. Business justification: guest_visit must reference the guest profile to associate each visit with a guest.',
    `shift_id` BIGINT COMMENT 'Foreign key linking to workforce.shift. Business justification: Labor-per-cover and throughput-per-shift are core foodservice operational KPIs. Linking guest_visit to the active shift enables calculation of covers-per-labor-hour, service-time benchmarking by shift',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Visit analytics require linking each guest visit to the exact restaurant unit for performance dashboards and service‑speed KPI calculations.',
    CONSTRAINT pk_visit PRIMARY KEY(`visit_id`)
) COMMENT 'Captures each confirmed guest visit to a restaurant unit across all service modes (dine-in, DT, OLO, 3PD). Distinct from the order domains order transaction — this is the guest-centric visit record that may span multiple orders or be a zero-spend visit (e.g., complaint resolution visit). Captures visit date, daypart, service mode, restaurant unit, party size (cover count), table number (dine-in), DT lane (drive-thru), visit duration, and whether the visit was incentivized by a promotion.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`guest`.`digital_account` (
    `digital_account_id` BIGINT COMMENT 'System-generated unique identifier for the digital account record.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: In multi-brand digital ecosystems, each digital account is scoped to a specific brand app (McDonalds app vs. Burger King app). Brand-level digital account counts and engagement metrics drive app inve',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Required for app login to map to loyalty member for point accrual and redemption; the restaurants loyalty program uses digital accounts to identify members during orders.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to guest.profile. Business justification: digital_account must be linked to the guest profile to associate digital activity with the correct guest.',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Unit-level digital adoption reporting tracks where digital accounts were created (kiosk, in-store tablet, drive-thru) for marketing ROI and technology investment decisions. Operations teams use this t',
    `account_number` STRING COMMENT 'External account number assigned to the digital account, used for customer service and reporting.',
    `account_tier` STRING COMMENT 'Membership tier that determines benefits and loyalty program eligibility.. Valid values are `basic|silver|gold|platinum`',
    `app_version` STRING COMMENT 'Software version of the mobile or web app used during the last login.',
    `consent_marketing` BOOLEAN COMMENT 'Guests consent to receive marketing communications.',
    `consent_third_party` BOOLEAN COMMENT 'Guests consent to share data with approved third‑party partners.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the digital account record was first inserted into the lakehouse.',
    `device_type` STRING COMMENT 'Category of device used for the last login (e.g., mobile, tablet).. Valid values are `mobile|tablet|desktop|kiosk`',
    `digital_account_status` STRING COMMENT 'Current operational state of the digital account.. Valid values are `active|suspended|deactivated|pending`',
    `effective_from` DATE COMMENT 'Date when the digital account became active.',
    `effective_until` DATE COMMENT 'Date when the digital account is scheduled to be terminated or expired; null for indefinite.',
    `email` STRING COMMENT 'Primary email address associated with the digital account for communication and password recovery.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `failed_login_attempts` STRING COMMENT 'Count of consecutive unsuccessful login attempts since the last successful login.',
    `last_login_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent successful authentication to the digital account.',
    `lockout_timestamp` TIMESTAMP COMMENT 'Timestamp when the account was locked due to security policy; null if not locked.',
    `password_last_changed` DATE COMMENT 'Date when the account password was most recently updated.',
    `phone_number` STRING COMMENT 'Primary telephone number linked to the digital account for SMS alerts and two‑factor authentication.. Valid values are `^+?[0-9]{7,15}$`',
    `privacy_opt_out` BOOLEAN COMMENT 'Indicates whether the guest has opted out of data collection beyond required operational purposes.',
    `registration_channel` STRING COMMENT 'Channel through which the guest originally registered the digital account.. Valid values are `app|website|olo|kiosk|in_store`',
    `two_factor_enabled` BOOLEAN COMMENT 'Indicates whether two‑factor authentication is active for the account.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the digital account record.',
    `username` STRING COMMENT 'Unique login name chosen by the guest for digital access.',
    CONSTRAINT pk_digital_account PRIMARY KEY(`digital_account_id`)
) COMMENT 'Represents a guests registered digital account on the brands owned digital channels (mobile app, website, OLO platform). Captures account username, account status (active, suspended, deactivated), registration date, registration channel, last login timestamp, device type, app version, two-factor authentication status, and account tier. Distinct from the guest profile (identity) — this is the digital access credential and session management record sourced from Olo Digital Ordering Platform.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ADD CONSTRAINT `fk_guest_profile_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `restaurants_ecm`.`guest`.`segment`(`segment_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`address` ADD CONSTRAINT `fk_guest_address_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `restaurants_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`address` ADD CONSTRAINT `fk_guest_address_address_profile_id` FOREIGN KEY (`address_profile_id`) REFERENCES `restaurants_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`address` ADD CONSTRAINT `fk_guest_address_owner_profile_id` FOREIGN KEY (`owner_profile_id`) REFERENCES `restaurants_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `restaurants_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_preference_profile_id` FOREIGN KEY (`preference_profile_id`) REFERENCES `restaurants_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ADD CONSTRAINT `fk_guest_consent_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `restaurants_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ADD CONSTRAINT `fk_guest_lifetime_value_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `restaurants_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ADD CONSTRAINT `fk_guest_satisfaction_survey_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `restaurants_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ADD CONSTRAINT `fk_guest_satisfaction_survey_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `restaurants_ecm`.`guest`.`visit`(`visit_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `restaurants_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_complaint_profile_id` FOREIGN KEY (`complaint_profile_id`) REFERENCES `restaurants_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_satisfaction_survey_id` FOREIGN KEY (`satisfaction_survey_id`) REFERENCES `restaurants_ecm`.`guest`.`satisfaction_survey`(`satisfaction_survey_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `restaurants_ecm`.`guest`.`visit`(`visit_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ADD CONSTRAINT `fk_guest_channel_identity_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `restaurants_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`visit` ADD CONSTRAINT `fk_guest_visit_digital_account_id` FOREIGN KEY (`digital_account_id`) REFERENCES `restaurants_ecm`.`guest`.`digital_account`(`digital_account_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`visit` ADD CONSTRAINT `fk_guest_visit_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `restaurants_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ADD CONSTRAINT `fk_guest_digital_account_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `restaurants_ecm`.`guest`.`profile`(`profile_id`);

-- ========= TAGS =========
ALTER SCHEMA `restaurants_ecm`.`guest` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `restaurants_ecm`.`guest` SET TAGS ('dbx_domain' = 'guest');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` SET TAGS ('dbx_subdomain' = 'guest_identity');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Identifier');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `location_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Location Identifier (PREFERRED_LOCATION_ID)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Identifier (LOYALTY_ID)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Store Identifier (PREFERRED_STORE_ID)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `profile_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Store Identifier (PREFERRED_STORE_ID)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Guest Segment Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (ADDRESS_LINE1)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (ADDRESS_LINE2)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `average_check_value` SET TAGS ('dbx_business_glossary_term' = 'Average Check Value (AVG_CHECK)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `average_check_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `average_check_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `birthday_day` SET TAGS ('dbx_business_glossary_term' = 'Birthday Day (BIRTH_DAY)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `birthday_day` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `birthday_day` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `birthday_month` SET TAGS ('dbx_business_glossary_term' = 'Birthday Month (BIRTH_MONTH)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `birthday_month` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `birthday_month` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (CITY)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `consent_email` SET TAGS ('dbx_business_glossary_term' = 'Email Marketing Consent (CONSENT_EMAIL)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `consent_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `consent_privacy` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Flag (CONSENT_PRIVACY)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `consent_privacy` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `consent_sms` SET TAGS ('dbx_business_glossary_term' = 'SMS Marketing Consent (CONSENT_SMS)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `consent_sms` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (COUNTRY_CODE)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Source System (DATA_SOURCE)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'salesforce|olo|micros|other');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `data_source_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (DATA_SOURCE_ID)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth (DOB)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Guest Email Address (EMAIL)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Guest First Name (FIRST_NAME)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Guest Full Name (FULL_NAME)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Guest Gender (GENDER)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|prefer_not_to_say');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `guest_type` SET TAGS ('dbx_business_glossary_term' = 'Guest Type (TYPE)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `guest_type` SET TAGS ('dbx_value_regex' = 'guest|employee|vendor|franchisee|loyalty_member');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Guest Last Name (LAST_NAME)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `last_visit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Visit Timestamp (LAST_VISIT)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier (LOYALTY_TIER)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_business_glossary_term' = 'General Marketing Opt‑In (MARKETING_OPT_IN)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `marketing_source` SET TAGS ('dbx_business_glossary_term' = 'Marketing Source (MARKETING_SOURCE)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `marketing_source` SET TAGS ('dbx_value_regex' = 'in_store|online|app|third_party');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Free‑Form Notes (NOTES)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Guest Primary Phone Number (PHONE)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{7,15}$');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `picture_url` SET TAGS ('dbx_business_glossary_term' = 'Profile Picture URL (PROFILE_PIC_URL)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (POSTAL_CODE)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language (LANGUAGE)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method (CONTACT_METHOD)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|sms|app_notification');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Guest Status (STATUS)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|prospect|blocked|deceased');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_AT)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_AT)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State/Province (STATE)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `total_lifetime_visits` SET TAGS ('dbx_business_glossary_term' = 'Total Lifetime Visits (LIFETIME_VISITS)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `total_spent` SET TAGS ('dbx_business_glossary_term' = 'Total Lifetime Spend (TOTAL_SPENT)');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `total_spent` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ALTER COLUMN `total_spent` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`guest`.`address` SET TAGS ('dbx_subdomain' = 'guest_identity');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Address Identifier');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Identifier');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `address_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Identifier');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `owner_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Address Owner Identifier');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_business_glossary_term' = 'Address Status');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_value_regex' = 'active|inactive|invalid|pending');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'home|work|delivery|billing|other');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `building_name` SET TAGS ('dbx_business_glossary_term' = 'Building Name');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `building_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `building_name` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `county` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `county` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Address Creation Timestamp');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_business_glossary_term' = 'Delivery Instructions');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `district` SET TAGS ('dbx_business_glossary_term' = 'District');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `district` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `district` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `geocode_accuracy` SET TAGS ('dbx_business_glossary_term' = 'Geocode Accuracy');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `geocode_accuracy` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `geocode_accuracy` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `geocode_accuracy` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Flag');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `landmark` SET TAGS ('dbx_business_glossary_term' = 'Landmark');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `landmark` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `landmark` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `last_verified` SET TAGS ('dbx_business_glossary_term' = 'Address Last Verified Date');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (Decimal Degrees)');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (Decimal Degrees)');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `owner_type` SET TAGS ('dbx_business_glossary_term' = 'Address Owner Type');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `owner_type` SET TAGS ('dbx_value_regex' = 'guest|restaurant|franchise|vendor');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9 -]{3,10}$');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `region` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `region` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Address Source System');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `suite_number` SET TAGS ('dbx_business_glossary_term' = 'Suite Number');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `suite_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `suite_number` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `time_zone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `time_zone` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Address Last Updated Timestamp');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Status');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|unvalidated|failed');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Timestamp');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `validity_flag` SET TAGS ('dbx_business_glossary_term' = 'Address Validity Flag');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Address Verification Method');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'postal|third_party|self_report');
ALTER TABLE `restaurants_ecm`.`guest`.`address` ALTER COLUMN `verification_score` SET TAGS ('dbx_business_glossary_term' = 'Address Verification Score');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` SET TAGS ('dbx_subdomain' = 'guest_identity');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `preference_id` SET TAGS ('dbx_business_glossary_term' = 'Preference ID');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `allergen_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Favorite Menu Item Identifier');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Identifier');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `preference_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Identifier');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `preference_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `preference_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `preference_unsafe_menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Unsafe Menu Item Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Brand Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Unit Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `communication_channel_preference` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel Preference (Email, SMS, Push, None)');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `communication_channel_preference` SET TAGS ('dbx_value_regex' = 'email|sms|push|none');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `consent_given` SET TAGS ('dbx_business_glossary_term' = 'Consent Given Flag');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `consent_given` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `consent_given` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Preference Record Creation Timestamp');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `data_source_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Source System Timestamp for Preference Record');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `device_preference` SET TAGS ('dbx_business_glossary_term' = 'Device Preference (Kiosk, Mobile, Tablet)');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `device_preference` SET TAGS ('dbx_value_regex' = 'kiosk|mobile|tablet');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Preference Effective Start Date');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Preference Effective End Date');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `favorite_cuisine` SET TAGS ('dbx_business_glossary_term' = 'Favorite Cuisine Preference');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `has_dairy_allergy` SET TAGS ('dbx_business_glossary_term' = 'Dairy Allergy Preference Flag');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `has_gluten_allergy` SET TAGS ('dbx_business_glossary_term' = 'Gluten Allergy Preference Flag');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `has_nut_allergy` SET TAGS ('dbx_business_glossary_term' = 'Nut Allergy Preference Flag');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Preference Active Flag');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `is_halal` SET TAGS ('dbx_business_glossary_term' = 'Halal Preference Flag');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `is_kosher` SET TAGS ('dbx_business_glossary_term' = 'Kosher Preference Flag');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `is_vegan` SET TAGS ('dbx_business_glossary_term' = 'Vegan Preference Flag');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `is_vegetarian` SET TAGS ('dbx_business_glossary_term' = 'Vegetarian Preference Flag');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Flag');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `marketing_opt_out_reason` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-Out Reason');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Preference Notes');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `origin` SET TAGS ('dbx_business_glossary_term' = 'Preference Origin (Manual, System, Survey)');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `origin` SET TAGS ('dbx_value_regex' = 'manual|system|survey');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `preference_status` SET TAGS ('dbx_business_glossary_term' = 'Preference Status (Active, Inactive, Archived)');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `preference_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `preference_type` SET TAGS ('dbx_business_glossary_term' = 'Preference Type (e.g., Dietary, Cuisine, Menu Item, Service Channel, Daypart, Communication, Marketing, Loyalty, Other)');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `preference_value` SET TAGS ('dbx_business_glossary_term' = 'Preference Value (raw value or description)');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `preferred_daypart` SET TAGS ('dbx_business_glossary_term' = 'Preferred Daypart (Breakfast, Brunch, Lunch, Dinner, Late Night)');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `preferred_daypart` SET TAGS ('dbx_value_regex' = 'breakfast|brunch|lunch|dinner|late_night');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `preferred_payment_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Payment Method (Cash, Card, Mobile Pay)');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `preferred_payment_method` SET TAGS ('dbx_value_regex' = 'cash|card|mobilepay');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `preferred_seating` SET TAGS ('dbx_business_glossary_term' = 'Preferred Seating Preference');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `preferred_seating` SET TAGS ('dbx_value_regex' = 'indoor|outdoor|bar|window');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `preferred_service_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Service Channel (Dine-In, Drive-Thru, Online, Delivery)');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `preferred_service_channel` SET TAGS ('dbx_value_regex' = 'dine_in|drive_thru|online|delivery');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `privacy_consent_version` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Version Identifier');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `privacy_consent_version` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `privacy_consent_version` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (originating system for the preference)');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce|olo|other');
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Preference Record Last Updated Timestamp');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` SET TAGS ('dbx_subdomain' = 'engagement_analytics');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record ID');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `consent_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiry Date');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `consent_language` SET TAGS ('dbx_business_glossary_term' = 'Consent Language');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `consent_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Method');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_value_regex' = 'opt_in|opt_out|implied');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `consent_purpose` SET TAGS ('dbx_business_glossary_term' = 'Consent Purpose');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `consent_revoked_reason` SET TAGS ('dbx_business_glossary_term' = 'Consent Revoked Reason');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `consent_revoked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Revoked Timestamp');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `consent_source_channel` SET TAGS ('dbx_business_glossary_term' = 'Consent Source Channel');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `consent_source_channel` SET TAGS ('dbx_value_regex' = 'online|in_store|mobile_app|call_center|email');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|withdrawn|expired|pending');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'marketing|sms|email|data_sharing|profiling');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `created` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Created Timestamp');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `data_processing_scope` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Scope');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `data_processing_scope` SET TAGS ('dbx_value_regex' = 'full|limited|custom');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `data_sharing_consent` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Consent Flag');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `device_code` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `device_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `device_code` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `email_consent` SET TAGS ('dbx_business_glossary_term' = 'Email Consent Flag');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `email_consent` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `email_consent` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_value_regex' = '^([0-9]{1,3}.){3}[0-9]{1,3}$');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `marketing_consent` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent Flag');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `privacy_notice_version` SET TAGS ('dbx_business_glossary_term' = 'Privacy Notice Version');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `sms_consent` SET TAGS ('dbx_business_glossary_term' = 'SMS Consent Flag');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `third_party_consent` SET TAGS ('dbx_business_glossary_term' = 'Third‑Party Data Sharing Consent Flag');
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ALTER COLUMN `updated` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Updated Timestamp');
ALTER TABLE `restaurants_ecm`.`guest`.`segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `restaurants_ecm`.`guest`.`segment` SET TAGS ('dbx_subdomain' = 'engagement_analytics');
ALTER TABLE `restaurants_ecm`.`guest`.`segment` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for guest_guest_segment');
ALTER TABLE `restaurants_ecm`.`guest`.`segment` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`segment` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` SET TAGS ('dbx_subdomain' = 'engagement_analytics');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `lifetime_value_id` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Value Record Identifier');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Home Unit Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Identifier');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `average_check_value` SET TAGS ('dbx_business_glossary_term' = 'Average Check Value (USD)');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `average_check_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `average_check_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `average_transactions_per_month` SET TAGS ('dbx_business_glossary_term' = 'Average Transactions Per Month');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `consent_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Data Consent Opt‑In Flag');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `data_refresh_cycle` SET TAGS ('dbx_business_glossary_term' = 'Data Refresh Cycle');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `data_refresh_cycle` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `days_since_last_visit` SET TAGS ('dbx_business_glossary_term' = 'Days Since Last Visit');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `first_visit_date` SET TAGS ('dbx_business_glossary_term' = 'First Visit Date');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `loyalty_member_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Membership Flag');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `ltv_calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Value Calculation Date');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `ltv_last_updated` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Value Last Updated Timestamp');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `ltv_status` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Value Status');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `ltv_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `most_recent_visit_date` SET TAGS ('dbx_business_glossary_term' = 'Most Recent Visit Date');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `predicted_future_value` SET TAGS ('dbx_business_glossary_term' = 'Predicted Future Lifetime Value (USD)');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `predicted_future_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `predicted_future_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Guest Segment');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `segment` SET TAGS ('dbx_value_regex' = 'high_value|medium_value|low_value|new|churn_risk');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'micros|olo|salesforce|other');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `total_historical_spend` SET TAGS ('dbx_business_glossary_term' = 'Total Historical Spend (USD)');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `total_historical_spend` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `total_historical_spend` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `total_visits` SET TAGS ('dbx_business_glossary_term' = 'Total Visits');
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` SET TAGS ('dbx_subdomain' = 'engagement_analytics');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `satisfaction_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Satisfaction Survey ID');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Order Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Item Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `performance_scorecard_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Scorecard Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Identifier');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Identifier');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Server Employee Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `tertiary_satisfaction_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Identifier');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Visit Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Survey Comments');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'completed|partial|declined|not_sent');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `consent_given` SET TAGS ('dbx_business_glossary_term' = 'Consent Given');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `csat_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Score');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late_night');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_value_regex' = 'email|sms|in_app|receipt_qr');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Survey Language');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `satisfaction_survey_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `satisfaction_survey_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce|olo|custom');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'csat|nps|post_delivery');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `survey_version` SET TAGS ('dbx_business_glossary_term' = 'Survey Version');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `visit_date` SET TAGS ('dbx_business_glossary_term' = 'Visit Date');
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ALTER COLUMN `visit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Visit Timestamp');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` SET TAGS ('dbx_subdomain' = 'engagement_analytics');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint ID');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `complaint_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `complaint_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `complaint_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `complaint_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `compliance_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Asset Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Handling Employee Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Health Inspection Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `illness_report_id` SET TAGS ('dbx_business_glossary_term' = 'Illness Report Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `order_item_id` SET TAGS ('dbx_business_glossary_term' = 'Order Item Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `recall_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Event Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Resolution Gl Account Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `satisfaction_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Satisfaction Survey Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Visit Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Complaint Channel');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'in_store|drive_thru|phone|online|social_media|other');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `complaint_category` SET TAGS ('dbx_business_glossary_term' = 'Complaint Category');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `complaint_category` SET TAGS ('dbx_value_regex' = 'food_quality|speed_of_service|order_accuracy|cleanliness|staff_behavior|other');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `complaint_description` SET TAGS ('dbx_business_glossary_term' = 'Complaint Description');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `complaint_number` SET TAGS ('dbx_business_glossary_term' = 'Complaint Number');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `complaint_status` SET TAGS ('dbx_business_glossary_term' = 'Complaint Status');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `complaint_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed|escalated');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `complaint_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Complaint Timestamp');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `consent_given` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Given');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `csat_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Score');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `escalated_to` SET TAGS ('dbx_business_glossary_term' = 'Escalated To Employee ID');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `feedback_comments` SET TAGS ('dbx_business_glossary_term' = 'Feedback Comments');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `privacy_consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Timestamp');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `resolution_amount` SET TAGS ('dbx_business_glossary_term' = 'Resolution Amount (USD)');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `resolution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `resolution_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'pending|resolved|closed|escalated');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `resolution_type` SET TAGS ('dbx_business_glossary_term' = 'Resolution Type');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `resolution_type` SET TAGS ('dbx_value_regex' = 'refund|replacement|apology|comp|none');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Complaint Severity Level');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` SET TAGS ('dbx_subdomain' = 'guest_identity');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `channel_identity_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Identity ID');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `channel_identity_status` SET TAGS ('dbx_business_glossary_term' = 'Channel Identity Status');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `channel_identity_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `channel_name` SET TAGS ('dbx_business_glossary_term' = 'Channel Name');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `channel_name` SET TAGS ('dbx_value_regex' = 'POS|OLO|Salesforce|ThirdParty|LoyaltyApp|Other');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `channel_user_email` SET TAGS ('dbx_business_glossary_term' = 'Channel User Email');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `channel_user_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `channel_user_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `channel_user_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `channel_user_name` SET TAGS ('dbx_business_glossary_term' = 'Channel User Name');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `channel_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `channel_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `channel_user_phone` SET TAGS ('dbx_business_glossary_term' = 'Channel User Phone Number');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `channel_user_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `channel_user_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `consent_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent Opt‑In');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `created_by_system` SET TAGS ('dbx_business_glossary_term' = 'Created By System');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `external_identifier` SET TAGS ('dbx_business_glossary_term' = 'External Identifier');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `external_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `external_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `identifier_type` SET TAGS ('dbx_business_glossary_term' = 'Identifier Type');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `identifier_type` SET TAGS ('dbx_value_regex' = 'email|phone|loyalty_card|device_id|third_party_id|account_number');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Channel Flag');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `is_test_account` SET TAGS ('dbx_business_glossary_term' = 'Is Test Account Flag');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `last_updated_by_system` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By System');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `last_verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Timestamp');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Channel Identity Notes');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `privacy_status` SET TAGS ('dbx_business_glossary_term' = 'Privacy Status');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'current|archived|deleted');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version Number');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Oracle MICROS|Olo|Salesforce CRM|Third‑Party Delivery|Loyalty Application|Other');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `source_system_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Source System Creation Timestamp');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `source_system_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Source System Update Timestamp');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'email|sms|phone|in_store|none');
ALTER TABLE `restaurants_ecm`.`guest`.`visit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`guest`.`visit` SET TAGS ('dbx_subdomain' = 'engagement_analytics');
ALTER TABLE `restaurants_ecm`.`guest`.`visit` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for guest_visit');
ALTER TABLE `restaurants_ecm`.`guest`.`visit` ALTER COLUMN `digital_account_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Account Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`visit` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Order Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Host Employee Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`visit` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`visit` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`visit` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`visit` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Terminal Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`visit` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`visit` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`visit` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` SET TAGS ('dbx_subdomain' = 'guest_identity');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `digital_account_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Account ID');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Member Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Unit Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number (ACC_NUM)');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `account_tier` SET TAGS ('dbx_business_glossary_term' = 'Account Tier (TIER)');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `account_tier` SET TAGS ('dbx_value_regex' = 'basic|silver|gold|platinum');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `app_version` SET TAGS ('dbx_business_glossary_term' = 'Application Version (APP_VER)');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `consent_marketing` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent (MKT_CONSENT)');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `consent_third_party` SET TAGS ('dbx_business_glossary_term' = 'Third‑Party Data Sharing Consent (3P_CONSENT)');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type (DEV_TYPE)');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'mobile|tablet|desktop|kiosk');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `digital_account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status (STATUS)');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `digital_account_status` SET TAGS ('dbx_value_regex' = 'active|suspended|deactivated|pending');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFF_FROM)');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFF_UNTIL)');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Email Address (EMAIL)');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `failed_login_attempts` SET TAGS ('dbx_business_glossary_term' = 'Failed Login Attempts (FAIL_LOGIN)');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `last_login_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Login Timestamp (LAST_LOGIN)');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `lockout_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Account Lockout Timestamp (LOCKOUT)');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `password_last_changed` SET TAGS ('dbx_business_glossary_term' = 'Password Last Changed Date (PWD_CHG)');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number (PHONE)');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{7,15}$');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `privacy_opt_out` SET TAGS ('dbx_business_glossary_term' = 'Privacy Opt‑Out (PRIV_OPT_OUT)');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `registration_channel` SET TAGS ('dbx_business_glossary_term' = 'Registration Channel (REG_CHAN)');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `registration_channel` SET TAGS ('dbx_value_regex' = 'app|website|olo|kiosk|in_store');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `two_factor_enabled` SET TAGS ('dbx_business_glossary_term' = 'Two‑Factor Authentication Enabled (2FA_EN)');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `username` SET TAGS ('dbx_business_glossary_term' = 'Username (UN)');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `username` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ALTER COLUMN `username` SET TAGS ('dbx_pii_identifier' = 'true');
