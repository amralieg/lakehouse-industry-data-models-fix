-- Schema for Domain: guest | Business: Restaurants | Version: v2_mvm
-- Generated on: 2026-06-22 16:55:45

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`guest` COMMENT 'Single source of truth for customer identity, profiles, preferences, demographics, segments, loyalty membership, and guest engagement across all channels (dine-in, drive-thru, online ordering). Manages CSAT, NPS, lifetime value, and consent/privacy management. Master record for WHO the business serves.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`profile` (
    `profile_id` BIGINT COMMENT 'Unique surrogate key for the guest profile record.',
    `location_profile_id` BIGINT COMMENT 'Identifier of the location the guest most frequently visits.',
    `program_id` BIGINT COMMENT 'Identifier of the loyalty program membership associated with the guest.',
    `unit_id` BIGINT COMMENT 'Identifier of the specific store the guest prefers.',
    `profile_unit_id` BIGINT COMMENT 'Identifier of the specific store the guest prefers.',
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
    `created_timestamp` TIMESTAMP COMMENT '',
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
    `total_lifetime_visits` DECIMAL(18,2) COMMENT 'Cumulative count of all visits (in‑store, drive‑thru, online) made by the guest.',
    `total_spent` DECIMAL(18,2) COMMENT 'Aggregate monetary amount the guest has spent across all transactions.',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_profile PRIMARY KEY(`profile_id`)
) COMMENT 'Master record for every guest identity across all service channels (dine-in, drive-thru, OLO, 3PD). Single source of truth for WHO the business serves — captures full identity and demographic attributes including name, contact details, date of birth, language preference, age band, gender identity, household income band, education level, employment status, geographic market classification, demographic data source (self-declared vs. third-party enrichment), enrichment provider and date. Also owns digital account attributes: username, account status (active/suspended/deactivated), registration date, registration channel, last login timestamp, device type, app version, two-factor authentication status, and account tier. Sourced primarily from Salesforce CRM, Olo Digital Ordering Platform, and brand mobile app. This is the anchor entity for the entire guest domain.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`address` (
    `address_id` BIGINT COMMENT 'System-generated unique identifier for the address record.',
    `profile_id` BIGINT COMMENT 'Unique identifier of the guest to whom this address belongs.',
    `address_profile_id` BIGINT COMMENT 'Unique identifier of the guest to whom this address belongs.',
    `normalized_address_id` BIGINT COMMENT 'Surrogate FK resolving the address natural key to its canonical address_id, replacing the denormalized natural-key usage.',
    `owner_profile_id` BIGINT COMMENT 'Identifier of the owning entity (guest, restaurant, etc.).',
    `address_status` STRING COMMENT 'Current lifecycle status of the address record.. Valid values are `active|inactive|invalid|pending`',
    `address_type` STRING COMMENT 'Classification of the address purpose.. Valid values are `home|work|delivery|billing|other`',
    `building_name` STRING COMMENT 'Name of the building, if applicable.',
    `city` STRING COMMENT 'City or municipality of the address.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code. Denormalized country natural key; authoritative source is guest.country via country_id FK.. Valid values are `^[A-Z]{3}$`',
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
) COMMENT 'Stores all physical and delivery addresses associated with a guest profile, including home address, saved delivery addresses, and billing addresses. Captures address type, street, city, state/province, postal code, country, geolocation coordinates, delivery instructions, and validation status. Supports OLO delivery fulfillment and personalized marketing by geography. Natural key declared via address_natural_key (denormalized natural key warning resolved). Address natural key normalized into guest.address_key surrogate reference (address_key_id).';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`preference` (
    `preference_id` BIGINT COMMENT 'Primary key for preference record. _canonical_skip_reason: Entity does not fit standard master or transaction roles; treated as OTHER.',
    `menu_item_id` BIGINT COMMENT 'Identifier of the guests most frequently ordered menu item.',
    `profile_id` BIGINT COMMENT 'Unique identifier of the guest to whom this preference belongs.',
    `preference_profile_id` BIGINT COMMENT 'Unique identifier of the guest to whom this preference belongs.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Multi-brand CRM personalization: guest brand preference drives targeted marketing campaigns and offer segmentation by brand. A restaurant CRM expert expects brand-level preference tracking to route co',
    `channel_id` BIGINT COMMENT 'Foreign key linking to order.channel. Business justification: Guest preferred service channel (dine-in, drive-thru, delivery, mobile order) must reference the canonical channel registry to enable channel-affinity segmentation, personalized marketing by channel, ',
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
    `preferred_daypart` STRING COMMENT 'Time of day the guest most often dines.. Valid values are `breakfast|brunch|lunch|dinner|late_night`',
    `preferred_payment_method` DECIMAL(18,2) COMMENT 'Guests favored payment method.',
    `preferred_seating` STRING COMMENT 'Guests favored seating location within the restaurant.. Valid values are `indoor|outdoor|bar|window`',
    `privacy_consent_version` STRING COMMENT 'Version of the privacy consent agreement under which the preference was collected.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the preference record.',
    `value` DECIMAL(18,2) COMMENT 'The actual value or description of the preference, such as "no peanuts" or "Italian".',
    CONSTRAINT pk_preference PRIMARY KEY(`preference_id`)
) COMMENT 'Captures all guest-stated and inferred preferences, dietary restrictions, and food allergen declarations. Covers FDA major allergens (milk, eggs, fish, shellfish, tree nuts, peanuts, wheat, soybeans, sesame) with severity levels (intolerance vs. allergy), dietary restriction types (vegetarian, vegan, halal, kosher, gluten-free), declaration source (self-declared, healthcare provider), cuisine preferences, favorite menu items, preferred service channel (dine-in, DT, OLO), preferred daypart, communication channel preferences (email, SMS, push), and marketing opt-in/opt-out flags. Sourced from Salesforce CRM, Olo guest data, and guest self-declaration. Drives personalization, targeted marketing, and HACCP-aligned guest food safety compliance including FDA allergen labeling requirements.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`consent_record` (
    `consent_record_id` BIGINT COMMENT 'System-generated unique identifier for the consent record.',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.program. Business justification: GDPR/CCPA compliance requires tracking consent per loyalty program (e.g., consent for program-specific marketing, data sharing with program partners). Regulators and auditors expect consent records to',
    `profile_id` BIGINT COMMENT 'Unique identifier of the guest to whom this consent applies.',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`household` (
    `household_id` BIGINT COMMENT 'System-generated unique identifier for the household master record.',
    `address_id` BIGINT COMMENT 'FK to guest.address',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.program. Business justification: Household-level loyalty enrollment management requires linking a household to the specific program it is enrolled in. Supports household loyalty analytics, program-level household segmentation, and re',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Household-level preferred store assignment drives local marketing, delivery radius matching, and household-level sales attribution. A loyalty/CRM expert expects a households home unit for targeted lo',
    `member_id` BIGINT COMMENT 'Identifier of the primary guest/member designated for the household.',
    `profile_id` BIGINT COMMENT 'Identifier of the primary guest/member designated for the household.',
    `address_verification_date` DATE COMMENT 'Date when the household address was last verified.',
    `address_verified` BOOLEAN COMMENT 'Indicates whether the household address has been validated.',
    `average_check_value` DECIMAL(18,2) COMMENT 'Average monetary value of transactions per visit for the household.',
    `average_transaction_count` STRING COMMENT 'Average number of transactions per defined period for the household.',
    `consent_privacy` BOOLEAN COMMENT 'Indicates whether the household has given consent for data processing under privacy regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the household record was first created.',
    `dissolution_date` DATE COMMENT 'Date when the household was closed or merged; null if still active.',
    `estimated_income_band` DECIMAL(18,2) COMMENT 'Income bracket estimate for the household used for segmentation.',
    `formation_date` DATE COMMENT 'Date when the household was first created in the system.',
    `household_status` STRING COMMENT 'Current lifecycle status of the household record.. Valid values are `active|inactive|closed|pending`',
    `household_type` STRING COMMENT 'Classification of the household composition.. Valid values are `family|single|group|other`',
    `last_transaction_date` DATE COMMENT 'Date of the most recent transaction recorded for the household.',
    `last_update_timestamp` TIMESTAMP COMMENT 'Date‑time when the household record was last modified.',
    `loyalty_enrolled` BOOLEAN COMMENT 'Indicates whether the household participates in the loyalty program.',
    `marketing_opt_in` BOOLEAN COMMENT 'Indicates whether the household has opted in to receive marketing communications.',
    `household_name` STRING COMMENT 'Human‑readable name for the household (e.g., Smith Family, Johnson Household).',
    `notes` STRING COMMENT 'Free‑form notes or comments about the household.',
    `preferred_channel` STRING COMMENT 'Channel most frequently used by the household for ordering.. Valid values are `dine_in|drive_thru|online|mobile|third_party`',
    `primary_contact_method` STRING COMMENT 'Preferred channel for primary household communications.. Valid values are `email|phone|mail`',
    `primary_email` STRING COMMENT 'Primary email address used to contact the household.',
    `primary_phone` STRING COMMENT 'Primary telephone number for the household.',
    `segment` STRING COMMENT 'Analytical segment used for marketing and forecasting.. Valid values are `high_value|mid_value|low_value|new|churn_risk`',
    `size` STRING COMMENT 'Number of individuals associated with the household.',
    `total_spend` DECIMAL(18,2) COMMENT 'Cumulative monetary spend of the household across all channels.',
    `total_transactions` DECIMAL(18,2) COMMENT 'Cumulative count of all transactions associated with the household.',
    CONSTRAINT pk_household PRIMARY KEY(`household_id`)
) COMMENT 'Groups individual guest profiles into household units for family-level analytics, shared loyalty benefits, and targeted household marketing. Captures household name, household size, estimated household income band, residential address, and household formation/dissolution dates. Includes member-level detail: member role (primary, secondary, dependent), relationship type, join/departure dates, and primary loyalty account holder designation. Supports cover count analysis, household-level ACV/ATC calculations, multi-member loyalty benefit sharing, and household spend aggregation.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` (
    `satisfaction_survey_id` BIGINT COMMENT 'Unique identifier for each satisfaction survey instance.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to order.channel. Business justification: NPS and CSAT reporting by channel (app, kiosk, email, third-party delivery) is a standard restaurant CX KPI. delivery_channel on satisfaction_survey is a plain text denormalization of order.channel; n',
    `profile_id` BIGINT COMMENT 'Unique identifier of the guest who received the survey.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where the guest experience occurred.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Needed for Service Quality Dashboard linking survey scores to the serving employee, supporting performance coaching and bonus calculations.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Brand-level NPS/CSAT reporting is a named business process in multi-brand restaurant enterprises. Survey responses must be aggregated by brand for brand health dashboards and executive reporting. No e',
    `shift_id` BIGINT COMMENT 'Foreign key linking to workforce.shift. Business justification: Shift-level CSAT/NPS quality reporting: restaurant quality managers analyze satisfaction scores by shift to identify underperforming shifts and staff. This link enables the standard shift-quality dash',
    `tertiary_satisfaction_unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where the guest experience occurred.',
    `visit_id` BIGINT COMMENT 'Foreign key linking to guest.guest_visit. Business justification: A satisfaction survey is triggered by and belongs to a specific guest visit. This 1:N FK (many surveys per visit, though typically one) anchors the survey to the operational visit record, enabling acc',
    `comments` STRING COMMENT 'Free‑text comments entered by the guest.',
    `completion_status` STRING COMMENT 'Indicates whether the guest completed, partially completed, declined, or never received the survey.. Valid values are `completed|partial|declined|not_sent`',
    `consent_given` BOOLEAN COMMENT 'Indicates whether the guest consented to be surveyed and to have their responses stored.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the survey record was first created in the lakehouse.',
    `csat_score` DECIMAL(18,2) COMMENT 'CSAT rating provided by the guest, typically on a 1‑5 scale.',
    `daypart` STRING COMMENT 'Business day segment during which the visit occurred.. Valid values are `breakfast|lunch|dinner|late_night`',
    `delivery_timestamp` TIMESTAMP COMMENT 'Date‑time when the survey was sent to the guest.',
    `language` STRING COMMENT 'ISO language code of the survey presented to the guest.',
    `nps_score` DECIMAL(18,2) COMMENT 'NPS rating provided by the guest on a scale of 0‑10.',
    `response_timestamp` TIMESTAMP COMMENT 'Date‑time when the guest submitted the survey response.',
    `satisfaction_survey_status` STRING COMMENT 'Current lifecycle status of the survey record.. Valid values are `active|inactive|archived`',
    `survey_type` STRING COMMENT 'Classification of the survey (Customer Satisfaction, Net Promoter Score, or post‑delivery feedback).. Valid values are `csat|nps|post_delivery`',
    `survey_version` STRING COMMENT 'Version identifier of the survey questionnaire used.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the survey record.',
    CONSTRAINT pk_satisfaction_survey PRIMARY KEY(`satisfaction_survey_id`)
) COMMENT 'Records guest satisfaction survey instances with full question-level response detail. Captures survey type (CSAT, NPS, post-delivery, post-visit), delivery channel (email, SMS, in-app, receipt QR), delivery timestamp, completion status, NPS score (0-10), CSAT score, restaurant unit, daypart, and respondent profile. Includes granular question-level data: question text, question type (rating, open-text, multiple-choice), response value, response timestamp, and sentiment classification for open-text responses. Sourced from Salesforce CRM and Olo guest feedback flows. Enables CSAT/NPS driver analysis at both survey and question level, supporting operational improvement across FOH and BOH.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`complaint` (
    `complaint_id` BIGINT COMMENT 'System-generated unique identifier for the complaint record.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Brand-level complaint tracking and escalation routing is standard in multi-brand QSR/casual dining. Brand operations teams own complaint resolution SLAs; complaints must be attributed to a brand for b',
    `channel_id` BIGINT COMMENT 'Foreign key linking to order.channel. Business justification: Complaint volume and resolution time by channel (drive-thru, delivery app, phone, in-store) is a core restaurant operations report. The plain text channel column on complaint is a denormalization of',
    `profile_id` BIGINT COMMENT 'Unique identifier of the guest who raised the complaint.',
    `complaint_profile_id` BIGINT COMMENT 'Unique identifier of the guest who raised the complaint.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the complaint originated.',
    `complaint_unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the complaint originated.',
    `guest_order_id` BIGINT COMMENT 'Identifier of the order associated with the complaint, if applicable.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required for Complaint Resolution Report that assigns a responsible employee to each complaint, enabling accountability and SLA tracking.',
    `illness_report_id` BIGINT COMMENT 'Foreign key linking to foodsafety.illness_report. Business justification: Guest foodborne illness complaints directly trigger illness_report investigations. Regulatory traceability requires linking the guest complaint record to the formal illness_report filed with health au',
    `ingredient_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient. Business justification: Needed for food safety incident tracking: associating complaints with the specific ingredient allows root‑cause analysis, recall decisions, and FDA reporting.',
    `ingredient_lot_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient_lot. Business justification: Food safety traceability regulations (FDA, HACCP) require linking guest complaints about illness or contamination to the specific ingredient lot served. This enables recall management, root cause anal',
    `menu_item_id` BIGINT COMMENT 'Foreign key linking to menu.menu_item. Business justification: Complaint resolution, food safety incident tracking, and menu quality reporting all require knowing which menu item triggered the complaint. Restaurant ops teams run item-level complaint rate reports ',
    `shift_id` BIGINT COMMENT 'Foreign key linking to workforce.shift. Business justification: Shift-level incident and complaint reporting: restaurant operations track complaints by shift to identify problem shifts, staff accountability, and recurring quality issues. This enables the standard ',
    `stock_item_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_item. Business justification: Food safety and allergen complaint traceability: when a guest reports a foreign object, allergen reaction, or spoilage issue, operations must trace the exact stock_item (with lot number, HACCP temps, ',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: Supplier accountability tracking: when a guest complaint is traced to a specific suppliers ingredient (contamination, foreign object, spoilage), restaurant operations and regulatory reporting require',
    `visit_id` BIGINT COMMENT 'Foreign key linking to guest.guest_visit. Business justification: A guest complaint is typically raised about a specific visit experience (food quality, service, wait time, etc.). Linking complaint to guest_visit enables service recovery analytics at the visit level',
    `complaint_category` STRING COMMENT 'Primary classification of the complaint reason.. Valid values are `food_quality|speed_of_service|order_accuracy|cleanliness|staff_behavior|other`',
    `complaint_number` STRING COMMENT 'Human‑readable business identifier assigned to the complaint (e.g., C‑20231234).',
    `complaint_status` STRING COMMENT 'Current lifecycle state of the complaint.. Valid values are `open|in_progress|resolved|closed|escalated`',
    `complaint_timestamp` TIMESTAMP COMMENT 'Date and time when the complaint was initially recorded.',
    `consent_given` BOOLEAN COMMENT 'Indicates whether the guest consented to store and process their personal data for this complaint.',
    `csat_score` DECIMAL(18,2) COMMENT 'Post‑resolution CSAT rating provided by the guest (1‑10).',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the resolution amount.',
    `complaint_description` STRING COMMENT 'Free‑text description provided by the guest detailing the issue.',
    `escalated_to` BIGINT COMMENT 'Identifier of the employee or manager to whom the complaint was escalated.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the complaint was escalated to higher management.',
    `feedback_comments` DECIMAL(18,2) COMMENT 'Additional free‑text feedback from the guest regarding the complaint handling.',
    `nps_score` DECIMAL(18,2) COMMENT 'NPS rating captured after resolution (0‑10).',
    `privacy_consent_timestamp` TIMESTAMP COMMENT 'Timestamp when the guest provided privacy consent.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp when the complaint record was first persisted in the data lake.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp of the most recent update to the complaint record.',
    `resolution_amount` DECIMAL(18,2) COMMENT 'Monetary value associated with the resolution (e.g., refund amount).',
    `resolution_status` STRING COMMENT 'Current status of the complaint resolution process.. Valid values are `pending|resolved|closed|escalated`',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the complaint was resolved.',
    `resolution_type` STRING COMMENT 'Method used to resolve the complaint.. Valid values are `refund|replacement|apology|comp|none`',
    `severity_level` STRING COMMENT 'Business‑defined severity indicating impact on guest experience.. Valid values are `low|medium|high|critical`',
    CONSTRAINT pk_complaint PRIMARY KEY(`complaint_id`)
) COMMENT 'Operational record of a guest complaint or service recovery case raised through any channel (in-restaurant, phone, digital, social media). Captures complaint category (food quality, speed of service/SOS, order accuracy, cleanliness, staff behavior), severity level, channel of receipt, restaurant unit, associated order reference, resolution status, resolution type (refund, replacement, apology), resolution timestamp, and escalation flag. Managed in Salesforce CRM service cloud.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`interaction` (
    `interaction_id` BIGINT COMMENT 'Unique identifier for the interaction event.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Brand-level interaction analytics (app opens, kiosk touches, loyalty check-ins by brand) is a named reporting requirement in multi-brand enterprises. Brand marketing teams need interaction counts per ',
    `channel_id` BIGINT COMMENT 'Foreign key linking to order.channel. Business justification: Guest interaction channel (phone, web chat, in-app, in-store) must reference the canonical channel registry for omnichannel CRM reporting and contact center analytics. The plain text channel column ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: In‑Restaurant Interaction Log tracks the employee handling each guest interaction, required for training effectiveness and KPI reporting.',
    `guest_order_id` BIGINT COMMENT 'Foreign key linking to order.guest_order. Business justification: Customer service teams link interactions (calls, chats, in-app messages) to the specific order being discussed — order inquiry resolution, complaint escalation, and service recovery workflows all requ',
    `profile_id` BIGINT COMMENT 'Surrogate identifier of the guest who generated the interaction.',
    `interaction_profile_id` BIGINT COMMENT 'Surrogate identifier of the guest who generated the interaction.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where the interaction took place, if applicable.',
    `interaction_unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where the interaction took place, if applicable.',
    `menu_item_id` BIGINT COMMENT 'Foreign key linking to menu.menu_item. Business justification: Digital engagement analytics and customer service resolution tracking require linking guest interactions (app browses, kiosk views, service calls) to specific menu items. This drives personalization, ',
    `pos_terminal_id` BIGINT COMMENT 'Foreign key linking to restaurant.pos_terminal. Business justification: Kiosk/POS terminal-level interaction tracking enables channel analytics (self-service vs. cashier), PCI audit trails, and terminal throughput reporting. A restaurant IT/operations expert expects guest',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the interaction record was first created in the lakehouse.',
    `device_code` STRING COMMENT 'Identifier of the device or terminal that recorded the interaction (e.g., POS terminal, kiosk).',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the interaction occurred.',
    `interaction_type` STRING COMMENT 'Nature of the interaction event (e.g., email open, app click, order placement).. Valid values are `open|click|view|order|checkin|visit`',
    `is_test` BOOLEAN COMMENT 'Indicates whether the interaction is a test event (true) or a production event (false).',
    `outcome` STRING COMMENT 'Result of the interaction, indicating whether it succeeded or failed.. Valid values are `success|failure|skip|bounce|partial|unknown`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the interaction record.',
    CONSTRAINT pk_interaction PRIMARY KEY(`interaction_id`)
) COMMENT 'Unified event stream capturing every recorded touchpoint between the brand and a guest across all channels. Covers inbound interactions (app sessions, loyalty check-ins, drive-thru visits, dine-in visits, OLO sessions, 3PD orders) and outbound communications (marketing emails, SMS messages, push notifications, direct mail). Captures interaction type, direction (inbound/outbound), channel, timestamp, restaurant unit (if applicable), campaign or trigger reference, subject/content reference, delivery status, open status, click-through status, unsubscribe action, and interaction outcome. Sourced from Salesforce CRM marketing automation, Oracle MICROS POS, and Olo. Provides the raw engagement timeline for RFM modeling, communication frequency capping, suppression list management, and guest engagement scoring.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`demographic` (
    `demographic_id` BIGINT COMMENT 'Unique identifier for the demographic record.',
    `profile_id` BIGINT COMMENT 'Identifier of the guest to which this demographic profile belongs.',
    `demographic_profile_id` BIGINT COMMENT 'Identifier of the guest to which this demographic profile belongs.',
    `age_band` STRING COMMENT 'Age range classification for the guest.',
    `consent_opt_in` BOOLEAN COMMENT 'Indicates whether the guest has opted in to marketing communications.',
    `consent_opt_out` BOOLEAN COMMENT 'Indicates whether the guest has opted out of marketing communications.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_source` STRING COMMENT 'Indicates whether the demographic data was self‑declared by the guest or supplied by a third‑party enrichment provider.. Valid values are `self_declared|third_party`',
    `demographic_type` STRING COMMENT 'High‑level classification of the guest for analytics (e.g., resident, visitor).. Valid values are `resident|visitor|tourist|employee|contractor|other`',
    `education_level` STRING COMMENT 'Highest education attained by the guest. [ENUM-REF-CANDIDATE: no_formal|high_school|some_college|bachelor|master|doctorate|other — promote to reference product]',
    `email_address` STRING COMMENT 'Primary email address for guest communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `employment_status` STRING COMMENT 'Current employment situation of the guest.. Valid values are `employed|unemployed|student|retired|self_employed|other`',
    `enrichment_date` DATE COMMENT 'Date on which the demographic enrichment was applied.',
    `enrichment_provider` STRING COMMENT 'Name of the third‑party vendor that supplied the enriched demographic data.',
    `ethnicity` STRING COMMENT 'Ethnic background of the guest. [ENUM-REF-CANDIDATE: asian|black|hispanic|white|native_american|middle_eastern|other — promote to reference product]',
    `ethnicity_source` STRING COMMENT 'Origin of the ethnicity information.. Valid values are `self|inferred|third_party`',
    `full_name` STRING COMMENT 'Legal full name of the individual.',
    `gender_identity` STRING COMMENT 'Self‑declared gender identity of the guest.. Valid values are `male|female|nonbinary|prefer_not_to_say|other`',
    `geographic_market` STRING COMMENT 'Market classification based on the guests primary location.. Valid values are `urban|suburban|rural|airport|college_town|other`',
    `household_income_band` DECIMAL(18,2) COMMENT 'Income range of the guests household.',
    `language_preference` STRING COMMENT 'Preferred language for communications.. Valid values are `en|es|fr|de|zh|other`',
    `marital_status` STRING COMMENT 'Current marital status of the guest.. Valid values are `single|married|divorced|widowed|partnered|other`',
    `notes` STRING COMMENT 'Free‑form comments or observations about the demographic record.',
    `number_of_children` STRING COMMENT 'Count of dependent children reported by the guest.',
    `phone_number` STRING COMMENT 'Primary telephone number for the guest.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the demographic record was first created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the demographic record.',
    `record_status` STRING COMMENT 'Current lifecycle status of the demographic record.. Valid values are `active|inactive|archived`',
    CONSTRAINT pk_demographic PRIMARY KEY(`demographic_id`)
) COMMENT 'Stores structured demographic attributes for a guest profile including age band, gender identity, ethnicity (where permitted and consented), household income band, education level, employment status, and geographic market classification. Captures data source (self-declared vs. third-party enrichment), enrichment provider, and enrichment date. Supports targeted marketing, menu development, and site selection analytics in conjunction with the realestate domain.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`visit` (
    `visit_id` BIGINT COMMENT 'Unique identifier for the guest_visit data product (auto-inserted pre-linking).',
    `channel_id` BIGINT COMMENT 'Foreign key linking to order.channel. Business justification: Visit-level channel analytics (dine-in vs. drive-thru vs. delivery vs. app) require a normalized channel reference. visit_channel is a plain text denormalization of order.channel. Channel-level visit ',
    `guest_order_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Guest Flow Management records which host/hostess greeted the guest, essential for staffing analysis and guest experience metrics.',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: At POS/kiosk, visits are identified by loyalty card scan — member_id is the primary identifier used operationally. Direct FK enables visit-based points accrual audits and tier qualification period vis',
    `menu_id` BIGINT COMMENT 'Foreign key linking to menu.menu. Business justification: Menu engineering and LTO performance analysis require knowing which menu version (daypart, channel, LTO) was active during a guest visit. Restaurant analysts use this to correlate menu changes with vi',
    `pos_terminal_id` BIGINT COMMENT 'Foreign key linking to restaurant.pos_terminal. Business justification: POS terminal-level visit/transaction reconciliation is a named operational process: each visits check is tendered on a specific terminal, enabling terminal throughput analysis, cash reconciliation, a',
    `profile_id` BIGINT COMMENT 'Foreign key linking to guest.profile. Business justification: guest_visit must reference the guest profile to associate each visit with a guest.',
    `shift_id` BIGINT COMMENT 'Foreign key linking to workforce.shift. Business justification: Labor efficiency reporting: linking guest visits to the shift during which they occurred enables core restaurant KPIs — covers per shift, revenue per labor hour, and guest throughput per shift. Restau',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Visit analytics require linking each guest visit to the exact restaurant unit for performance dashboards and service‑speed KPI calculations.',
    `amount` DECIMAL(18,2) COMMENT '',
    `channel` STRING COMMENT '',
    `check_amount` DECIMAL(18,2) COMMENT '',
    `check_total` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `datetime` TIMESTAMP COMMENT '',
    `daypart` STRING COMMENT '',
    `duration_minutes` STRING COMMENT 'Business attribute visit_duration_minutes derived from business context.',
    `dwell_minutes` STRING COMMENT '',
    `dwell_time_minutes` STRING COMMENT '',
    `is_first_visit` BOOLEAN COMMENT '',
    `is_repeat_visit` BOOLEAN COMMENT '',
    `item_count` STRING COMMENT '',
    `party_size` STRING COMMENT '',
    `satisfaction_rating` STRING COMMENT '',
    `satisfaction_score` DECIMAL(18,2) COMMENT '',
    `spend_amount` DECIMAL(18,2) COMMENT '',
    `table_number` STRING COMMENT '',
    `ticket_amount` DECIMAL(18,2) COMMENT '',
    `total_spend_amount` DECIMAL(18,2) COMMENT 'Total spend amount',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `visit_date` DATE COMMENT '',
    `visit_time` TIMESTAMP COMMENT 'Business attribute visit_time for guest_visit',
    `visit_timestamp` TIMESTAMP COMMENT '',
    `visit_type` STRING COMMENT '',
    CONSTRAINT pk_visit PRIMARY KEY(`visit_id`)
) COMMENT 'Captures each confirmed guest visit to a restaurant unit across all service modes (dine-in, DT, OLO, 3PD). Distinct from the order domains order transaction — this is the guest-centric visit record that may span multiple orders or be a zero-spend visit (e.g., complaint resolution visit). Captures visit date, daypart, service mode, restaurant unit, party size (cover count), table number (dine-in), DT lane (drive-thru), visit duration, and whether the visit was incentivized by a promotion. [SSOT: authoritative owner is loyalty.loyalty_visit] establish single authoritative owner';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`digital_account` (
    `digital_account_id` BIGINT COMMENT 'System-generated unique identifier for the digital account record.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: In multi-brand restaurant enterprises, a digital account belongs to a specific brands app/platform (e.g., Brand A loyalty app vs. Brand B app). Brand-level digital account management, app analytics, ',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Required for app login to map to loyalty member for point accrual and redemption; the restaurants loyalty program uses digital accounts to identify members during orders.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to guest.profile. Business justification: digital_account must be linked to the guest profile to associate digital activity with the correct guest.',
    `account_number` STRING COMMENT 'External account number assigned to the digital account, used for customer service and reporting.',
    `account_status` STRING COMMENT '',
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
    `registration_channel` DECIMAL(18,2) COMMENT 'Channel through which the guest originally registered the digital account.',
    `two_factor_enabled` DECIMAL(18,2) COMMENT 'Indicates whether two‑factor authentication is active for the account.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the digital account record.',
    `username` STRING COMMENT 'Unique login name chosen by the guest for digital access.',
    CONSTRAINT pk_digital_account PRIMARY KEY(`digital_account_id`)
) COMMENT 'Represents a guests registered digital account on the brands owned digital channels (mobile app, website, OLO platform). Captures account username, account status (active, suspended, deactivated), registration date, registration channel, last login timestamp, device type, app version, two-factor authentication status, and account tier. Distinct from the guest profile (identity) — this is the digital access credential and session management record sourced from Olo Digital Ordering Platform.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ADD CONSTRAINT `fk_guest_address_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ADD CONSTRAINT `fk_guest_address_address_profile_id` FOREIGN KEY (`address_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ADD CONSTRAINT `fk_guest_address_normalized_address_id` FOREIGN KEY (`normalized_address_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`address`(`address_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ADD CONSTRAINT `fk_guest_address_owner_profile_id` FOREIGN KEY (`owner_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_preference_profile_id` FOREIGN KEY (`preference_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ADD CONSTRAINT `fk_guest_consent_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ADD CONSTRAINT `fk_guest_household_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`address`(`address_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ADD CONSTRAINT `fk_guest_household_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ADD CONSTRAINT `fk_guest_satisfaction_survey_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ADD CONSTRAINT `fk_guest_satisfaction_survey_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`visit`(`visit_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_complaint_profile_id` FOREIGN KEY (`complaint_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`visit`(`visit_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ADD CONSTRAINT `fk_guest_interaction_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ADD CONSTRAINT `fk_guest_interaction_interaction_profile_id` FOREIGN KEY (`interaction_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ADD CONSTRAINT `fk_guest_demographic_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ADD CONSTRAINT `fk_guest_demographic_demographic_profile_id` FOREIGN KEY (`demographic_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ADD CONSTRAINT `fk_guest_visit_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ADD CONSTRAINT `fk_guest_digital_account_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`guest` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_restaurants_v1`.`guest` SET TAGS ('dbx_domain' = 'guest');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` SET TAGS ('dbx_subdomain' = 'guest_identity');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `location_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Location Identifier (PREFERRED_LOCATION_ID)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Identifier (LOYALTY_ID)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Store Identifier (PREFERRED_STORE_ID)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `profile_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Store Identifier (PREFERRED_STORE_ID)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (ADDRESS_LINE1)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (ADDRESS_LINE2)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `address_line2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `average_check_value` SET TAGS ('dbx_business_glossary_term' = 'Average Check Value (AVG_CHECK)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `average_check_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `average_check_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `birthday_day` SET TAGS ('dbx_business_glossary_term' = 'Birthday Day (BIRTH_DAY)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `birthday_day` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `birthday_day` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `birthday_month` SET TAGS ('dbx_business_glossary_term' = 'Birthday Month (BIRTH_MONTH)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `birthday_month` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `birthday_month` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (CITY)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `consent_email` SET TAGS ('dbx_business_glossary_term' = 'Email Marketing Consent (CONSENT_EMAIL)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `consent_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `consent_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `consent_privacy` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Flag (CONSENT_PRIVACY)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `consent_privacy` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `consent_sms` SET TAGS ('dbx_business_glossary_term' = 'SMS Marketing Consent (CONSENT_SMS)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `consent_sms` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (COUNTRY_CODE)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Source System (DATA_SOURCE)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'salesforce|olo|micros|other');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `data_source_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (DATA_SOURCE_ID)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth (DOB)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Guest Email Address (EMAIL)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Guest First Name (FIRST_NAME)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `first_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Guest Full Name (FULL_NAME)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `full_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Guest Gender (GENDER)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|prefer_not_to_say');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `gender` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `guest_type` SET TAGS ('dbx_business_glossary_term' = 'Guest Type (TYPE)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `guest_type` SET TAGS ('dbx_value_regex' = 'guest|employee|vendor|franchisee|loyalty_member');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Guest Last Name (LAST_NAME)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `last_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `last_visit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Visit Timestamp (LAST_VISIT)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier (LOYALTY_TIER)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_business_glossary_term' = 'General Marketing Opt‑In (MARKETING_OPT_IN)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `marketing_source` SET TAGS ('dbx_business_glossary_term' = 'Marketing Source (MARKETING_SOURCE)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `marketing_source` SET TAGS ('dbx_value_regex' = 'in_store|online|app|third_party');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Free‑Form Notes (NOTES)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Guest Primary Phone Number (PHONE)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{7,15}$');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `picture_url` SET TAGS ('dbx_business_glossary_term' = 'Profile Picture URL (PROFILE_PIC_URL)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (POSTAL_CODE)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language (LANGUAGE)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method (CONTACT_METHOD)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|sms|app_notification');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Guest Status (STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|prospect|blocked|deceased');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_AT)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_AT)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State/Province (STATE)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `total_lifetime_visits` SET TAGS ('dbx_business_glossary_term' = 'Total Lifetime Visits (LIFETIME_VISITS)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `total_spent` SET TAGS ('dbx_business_glossary_term' = 'Total Lifetime Spend (TOTAL_SPENT)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `total_spent` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `total_spent` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` SET TAGS ('dbx_subdomain' = 'guest_identity');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Address Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `profile_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `profile_id` SET TAGS ('dbx_data_classification' = 'confidential');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_profile_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `normalized_address_id` SET TAGS ('dbx_business_glossary_term' = 'Normalized Address Reference');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `normalized_address_id` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `normalized_address_id` SET TAGS ('dbx_surrogate_ref' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `normalized_address_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `normalized_address_id` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `owner_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Address Owner Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_business_glossary_term' = 'Address Status');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_value_regex' = 'active|inactive|invalid|pending');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'home|work|delivery|billing|other');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `building_name` SET TAGS ('dbx_business_glossary_term' = 'Building Name');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `building_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `building_name` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `building_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `building_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `building_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `city` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_normalized_via' = 'country_id');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_normalize_via' = 'guest.country');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Address Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_business_glossary_term' = 'Delivery Instructions');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `district` SET TAGS ('dbx_business_glossary_term' = 'District');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `geocode_accuracy` SET TAGS ('dbx_business_glossary_term' = 'Geocode Accuracy');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `geocode_accuracy` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `landmark` SET TAGS ('dbx_business_glossary_term' = 'Landmark');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `last_verified` SET TAGS ('dbx_business_glossary_term' = 'Address Last Verified Date');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (Decimal Degrees)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_['sensitivity' = 'pii]');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_pii_category' = 'postal_address');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_['sensitivity' = 'pii]');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_pii_category' = 'postal_address');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (Decimal Degrees)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `owner_type` SET TAGS ('dbx_business_glossary_term' = 'Address Owner Type');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `owner_type` SET TAGS ('dbx_value_regex' = 'guest|restaurant|franchise|vendor');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9 -]{3,10}$');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_['sensitivity' = 'pii]');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_category' = 'postal_address');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `suite_number` SET TAGS ('dbx_business_glossary_term' = 'Suite Number');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `suite_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Address Last Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Status');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|unvalidated|failed');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `validity_flag` SET TAGS ('dbx_business_glossary_term' = 'Address Validity Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Address Verification Method');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'postal|third_party|self_report');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `verification_score` SET TAGS ('dbx_business_glossary_term' = 'Address Verification Score');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` SET TAGS ('dbx_subdomain' = 'guest_identity');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `preference_id` SET TAGS ('dbx_business_glossary_term' = 'Preference ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Favorite Menu Item Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `preference_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `preference_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `preference_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Brand Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Service Channel Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `communication_channel_preference` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel Preference (Email, SMS, Push, None)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `communication_channel_preference` SET TAGS ('dbx_value_regex' = 'email|sms|push|none');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `consent_given` SET TAGS ('dbx_business_glossary_term' = 'Consent Given Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `consent_given` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `consent_given` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Preference Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `data_source_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Source System Timestamp for Preference Record');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `device_preference` SET TAGS ('dbx_business_glossary_term' = 'Device Preference (Kiosk, Mobile, Tablet)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `device_preference` SET TAGS ('dbx_value_regex' = 'kiosk|mobile|tablet');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Preference Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Preference Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `favorite_cuisine` SET TAGS ('dbx_business_glossary_term' = 'Favorite Cuisine Preference');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `has_dairy_allergy` SET TAGS ('dbx_business_glossary_term' = 'Dairy Allergy Preference Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `has_gluten_allergy` SET TAGS ('dbx_business_glossary_term' = 'Gluten Allergy Preference Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `has_nut_allergy` SET TAGS ('dbx_business_glossary_term' = 'Nut Allergy Preference Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Preference Active Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `is_halal` SET TAGS ('dbx_business_glossary_term' = 'Halal Preference Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `is_kosher` SET TAGS ('dbx_business_glossary_term' = 'Kosher Preference Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `is_vegan` SET TAGS ('dbx_business_glossary_term' = 'Vegan Preference Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `is_vegetarian` SET TAGS ('dbx_business_glossary_term' = 'Vegetarian Preference Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `marketing_opt_out_reason` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-Out Reason');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Preference Notes');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `origin` SET TAGS ('dbx_business_glossary_term' = 'Preference Origin (Manual, System, Survey)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `origin` SET TAGS ('dbx_value_regex' = 'manual|system|survey');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `preference_status` SET TAGS ('dbx_business_glossary_term' = 'Preference Status (Active, Inactive, Archived)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `preference_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `preference_type` SET TAGS ('dbx_business_glossary_term' = 'Preference Type (e.g., Dietary, Cuisine, Menu Item, Service Channel, Daypart, Communication, Marketing, Loyalty, Other)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `preferred_daypart` SET TAGS ('dbx_business_glossary_term' = 'Preferred Daypart (Breakfast, Brunch, Lunch, Dinner, Late Night)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `preferred_daypart` SET TAGS ('dbx_value_regex' = 'breakfast|brunch|lunch|dinner|late_night');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `preferred_payment_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Payment Method (Cash, Card, Mobile Pay)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `preferred_seating` SET TAGS ('dbx_business_glossary_term' = 'Preferred Seating Preference');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `preferred_seating` SET TAGS ('dbx_value_regex' = 'indoor|outdoor|bar|window');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `privacy_consent_version` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Version Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `privacy_consent_version` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `privacy_consent_version` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Preference Record Last Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `value` SET TAGS ('dbx_business_glossary_term' = 'Preference Value (raw value or description)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` SET TAGS ('dbx_subdomain' = 'engagement_analytics');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiry Date');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_language` SET TAGS ('dbx_business_glossary_term' = 'Consent Language');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Method');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_value_regex' = 'opt_in|opt_out|implied');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_purpose` SET TAGS ('dbx_business_glossary_term' = 'Consent Purpose');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_revoked_reason` SET TAGS ('dbx_business_glossary_term' = 'Consent Revoked Reason');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_revoked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Revoked Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_source_channel` SET TAGS ('dbx_business_glossary_term' = 'Consent Source Channel');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_source_channel` SET TAGS ('dbx_value_regex' = 'online|in_store|mobile_app|call_center|email');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|withdrawn|expired|pending');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'marketing|sms|email|data_sharing|profiling');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `created` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `data_processing_scope` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Scope');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `data_processing_scope` SET TAGS ('dbx_value_regex' = 'full|limited|custom');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `data_sharing_consent` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Consent Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `device_code` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `device_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `device_code` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `email_consent` SET TAGS ('dbx_business_glossary_term' = 'Email Consent Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `email_consent` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `email_consent` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `email_consent` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_value_regex' = '^([0-9]{1,3}.){3}[0-9]{1,3}$');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `marketing_consent` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `privacy_notice_version` SET TAGS ('dbx_business_glossary_term' = 'Privacy Notice Version');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `sms_consent` SET TAGS ('dbx_business_glossary_term' = 'SMS Consent Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `third_party_consent` SET TAGS ('dbx_business_glossary_term' = 'Third‑Party Data Sharing Consent Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `updated` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` SET TAGS ('dbx_subdomain' = 'guest_identity');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Address Id');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `address_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `address_id` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Unit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Member Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Member Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `address_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Address Verification Date');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `address_verification_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `address_verification_date` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `address_verification_date` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `address_verified` SET TAGS ('dbx_business_glossary_term' = 'Address Verified Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `address_verified` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `address_verified` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `address_verified` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `average_check_value` SET TAGS ('dbx_business_glossary_term' = 'Average Check Value (ACV)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `average_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Average Transaction Count (ATC)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `consent_privacy` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `dissolution_date` SET TAGS ('dbx_business_glossary_term' = 'Household Dissolution Date');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `estimated_income_band` SET TAGS ('dbx_business_glossary_term' = 'Estimated Income Band');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `formation_date` SET TAGS ('dbx_business_glossary_term' = 'Household Formation Date');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `household_status` SET TAGS ('dbx_business_glossary_term' = 'Household Status');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `household_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|pending');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `household_type` SET TAGS ('dbx_business_glossary_term' = 'Household Type');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `household_type` SET TAGS ('dbx_value_regex' = 'family|single|group|other');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `last_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Date');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `last_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `loyalty_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Enrolled Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt‑In Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `household_name` SET TAGS ('dbx_business_glossary_term' = 'Household Name');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `household_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `preferred_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Service Channel');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `preferred_channel` SET TAGS ('dbx_value_regex' = 'dine_in|drive_thru|online|mobile|third_party');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|mail');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `primary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `primary_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `primary_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Household Segment');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `segment` SET TAGS ('dbx_value_regex' = 'high_value|mid_value|low_value|new|churn_risk');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `size` SET TAGS ('dbx_business_glossary_term' = 'Household Size');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `total_spend` SET TAGS ('dbx_business_glossary_term' = 'Total Spend');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `total_transactions` SET TAGS ('dbx_business_glossary_term' = 'Total Transaction Count');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` SET TAGS ('dbx_subdomain' = 'engagement_analytics');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `satisfaction_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Satisfaction Survey ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Server Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Brand Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Shift Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `tertiary_satisfaction_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Visit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Survey Comments');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'completed|partial|declined|not_sent');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `consent_given` SET TAGS ('dbx_business_glossary_term' = 'Consent Given');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `csat_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Score');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late_night');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Survey Language');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `satisfaction_survey_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `satisfaction_survey_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'csat|nps|post_delivery');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `survey_version` SET TAGS ('dbx_business_glossary_term' = 'Survey Version');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` SET TAGS ('dbx_subdomain' = 'engagement_analytics');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Brand Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `complaint_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `complaint_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `complaint_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `complaint_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Handling Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `illness_report_id` SET TAGS ('dbx_business_glossary_term' = 'Illness Report Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `ingredient_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Ingredient Lot Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Menu Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Shift Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Stock Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Supply Supplier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Guest Visit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `complaint_category` SET TAGS ('dbx_business_glossary_term' = 'Complaint Category');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `complaint_category` SET TAGS ('dbx_value_regex' = 'food_quality|speed_of_service|order_accuracy|cleanliness|staff_behavior|other');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `complaint_number` SET TAGS ('dbx_business_glossary_term' = 'Complaint Number');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `complaint_status` SET TAGS ('dbx_business_glossary_term' = 'Complaint Status');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `complaint_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed|escalated');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `complaint_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Complaint Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `consent_given` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Given');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `csat_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Score');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `complaint_description` SET TAGS ('dbx_business_glossary_term' = 'Complaint Description');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `escalated_to` SET TAGS ('dbx_business_glossary_term' = 'Escalated To Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `feedback_comments` SET TAGS ('dbx_business_glossary_term' = 'Feedback Comments');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `privacy_consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `resolution_amount` SET TAGS ('dbx_business_glossary_term' = 'Resolution Amount (USD)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `resolution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `resolution_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'pending|resolved|closed|escalated');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `resolution_type` SET TAGS ('dbx_business_glossary_term' = 'Resolution Type');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `resolution_type` SET TAGS ('dbx_value_regex' = 'refund|replacement|apology|comp|none');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Complaint Severity Level');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` SET TAGS ('dbx_subdomain' = 'engagement_analytics');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Interaction ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Interaction Brand Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Interaction Guest Order Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `interaction_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `interaction_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Terminal Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `device_code` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interaction Event Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `interaction_type` SET TAGS ('dbx_business_glossary_term' = 'Interaction Type');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `interaction_type` SET TAGS ('dbx_value_regex' = 'open|click|view|order|checkin|visit');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `is_test` SET TAGS ('dbx_business_glossary_term' = 'Test Interaction Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Interaction Outcome');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'success|failure|skip|bounce|partial|unknown');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` SET TAGS ('dbx_subdomain' = 'guest_identity');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `demographic_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `demographic_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `age_band` SET TAGS ('dbx_business_glossary_term' = 'Age Band (AGE_BAND)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `consent_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Consent Opt‑In (CONSENT_OPT_IN)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `consent_opt_out` SET TAGS ('dbx_business_glossary_term' = 'Consent Opt‑Out (CONSENT_OPT_OUT)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source (DATA_SOURCE)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'self_declared|third_party');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `demographic_type` SET TAGS ('dbx_business_glossary_term' = 'Demographic Type (DEMOGRAPHIC_TYPE)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `demographic_type` SET TAGS ('dbx_value_regex' = 'resident|visitor|tourist|employee|contractor|other');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `education_level` SET TAGS ('dbx_business_glossary_term' = 'Education Level (EDUCATION_LEVEL)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address (EMAIL_ADDRESS)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `email_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status (EMPLOYMENT_STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'employed|unemployed|student|retired|self_employed|other');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `enrichment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrichment Date (ENRICHMENT_DATE)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `enrichment_provider` SET TAGS ('dbx_business_glossary_term' = 'Enrichment Provider (ENRICHMENT_PROVIDER)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Ethnicity (ETHNICITY)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `ethnicity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `ethnicity` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `ethnicity_source` SET TAGS ('dbx_business_glossary_term' = 'Ethnicity Source (ETHNICITY_SOURCE)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `ethnicity_source` SET TAGS ('dbx_value_regex' = 'self|inferred|third_party');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `ethnicity_source` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `ethnicity_source` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Full Name (FULL_NAME)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `full_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `gender_identity` SET TAGS ('dbx_business_glossary_term' = 'Gender Identity (GENDER_IDENTITY)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `gender_identity` SET TAGS ('dbx_value_regex' = 'male|female|nonbinary|prefer_not_to_say|other');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `gender_identity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `gender_identity` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `gender_identity` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `geographic_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market Classification (GEOGRAPHIC_MARKET)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `geographic_market` SET TAGS ('dbx_value_regex' = 'urban|suburban|rural|airport|college_town|other');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `household_income_band` SET TAGS ('dbx_business_glossary_term' = 'Household Income Band (HOUSEHOLD_INCOME_BAND)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference (LANGUAGE_PREFERENCE)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = 'en|es|fr|de|zh|other');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `marital_status` SET TAGS ('dbx_business_glossary_term' = 'Marital Status (MARITAL_STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `marital_status` SET TAGS ('dbx_value_regex' = 'single|married|divorced|widowed|partnered|other');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `marital_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `marital_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `number_of_children` SET TAGS ('dbx_business_glossary_term' = 'Number of Children (NUMBER_OF_CHILDREN)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number (PHONE_NUMBER)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `phone_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created (RECORD_AUDIT_CREATED)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated (RECORD_AUDIT_UPDATED)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status (RECORD_STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` SET TAGS ('dbx_subdomain' = 'engagement_analytics');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for guest_visit');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Host Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Member Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `menu_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Terminal Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Shift Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` SET TAGS ('dbx_subdomain' = 'guest_identity');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `digital_account_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Account ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Member Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number (ACC_NUM)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `account_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `account_number` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `account_tier` SET TAGS ('dbx_business_glossary_term' = 'Account Tier (TIER)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `account_tier` SET TAGS ('dbx_value_regex' = 'basic|silver|gold|platinum');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `app_version` SET TAGS ('dbx_business_glossary_term' = 'Application Version (APP_VER)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `consent_marketing` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent (MKT_CONSENT)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `consent_third_party` SET TAGS ('dbx_business_glossary_term' = 'Third‑Party Data Sharing Consent (3P_CONSENT)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type (DEV_TYPE)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'mobile|tablet|desktop|kiosk');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `digital_account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status (STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `digital_account_status` SET TAGS ('dbx_value_regex' = 'active|suspended|deactivated|pending');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFF_FROM)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFF_UNTIL)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Email Address (EMAIL)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `failed_login_attempts` SET TAGS ('dbx_business_glossary_term' = 'Failed Login Attempts (FAIL_LOGIN)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `last_login_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Login Timestamp (LAST_LOGIN)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `lockout_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Account Lockout Timestamp (LOCKOUT)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `password_last_changed` SET TAGS ('dbx_business_glossary_term' = 'Password Last Changed Date (PWD_CHG)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number (PHONE)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{7,15}$');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `phone_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `privacy_opt_out` SET TAGS ('dbx_business_glossary_term' = 'Privacy Opt‑Out (PRIV_OPT_OUT)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `registration_channel` SET TAGS ('dbx_business_glossary_term' = 'Registration Channel (REG_CHAN)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `two_factor_enabled` SET TAGS ('dbx_business_glossary_term' = 'Two‑Factor Authentication Enabled (2FA_EN)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `username` SET TAGS ('dbx_business_glossary_term' = 'Username (UN)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `username` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `username` SET TAGS ('dbx_pii_identifier' = 'true');
