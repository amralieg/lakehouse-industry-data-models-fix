-- Schema for Domain: audience | Business: Advertising | Version: v1_ecm
-- Generated on: 2026-05-08 02:28:04

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `advertising_ecm`.`audience` COMMENT 'SSOT for audience definition, segmentation, and targeting data used across campaigns. Manages first-party, second-party, and third-party audience segments, personas, behavioral profiles, demographic attributes, psychographic insights, DMP/CDP integrations, and privacy-compliant consent records (GDPR, CCPA). Integrates with Nielsen, Comscore, and DSP audience tools.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `advertising_ecm`.`audience`.`audience_segment` (
    `audience_segment_id` BIGINT COMMENT 'Unique identifier for the audience segment. Primary key.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Segments are built to target specific brand audiences. Brand managers need to see which segments support their brand strategy. Campaign planning, media buying, and audience activation all require know',
    `worker_id` BIGINT COMMENT 'Foreign key linking to talent.worker. Business justification: Segments are strategic audience assets requiring ownership tracking for governance, approval workflows, quality control, and accountability. Every segment creation in advertising operations must be at',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Audience segments often governed by master agreements defining data usage rights, licensing terms, geographic restrictions, and activation permissions. Critical for compliance tracking, data rights ma',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Campaign-specific custom segments are frequently defined as SOW deliverables with specific build criteria, acceptance thresholds, and delivery timelines. Essential for scope validation, deliverable tr',
    `taxonomy_id` BIGINT COMMENT 'Foreign key linking to audience.audience_taxonomy. Business justification: Segments should be formally classified using the standardized audience taxonomy (aligned to IAB Audience Taxonomy per audience_taxonomy product description). The segment table currently has iab_taxon',
    `third_party_feed_id` BIGINT COMMENT 'Foreign key linking to audience.third_party_feed. Business justification: segment has data_source_tier (first-party, second-party, third-party). For third-party segments, tracking which third_party_feed sourced the segment is critical for data lineage, cost allocation, and ',
    `activation_status` STRING COMMENT 'Indicates whether the segment has been pushed to DSPs, ad servers, or activation platforms for live campaign use.. Valid values are `activated|not_activated|pending_activation`',
    `age_band_max` STRING COMMENT 'Upper bound of the age range for demographic qualification (e.g., 24 for 18-24 age band). Nullable if age is not a qualification criterion.',
    `age_band_min` STRING COMMENT 'Lower bound of the age range for demographic qualification (e.g., 18 for 18-24 age band). Nullable if age is not a qualification criterion.',
    `app_usage_flag` BOOLEAN COMMENT 'Indicates whether segment qualification includes mobile app usage or in-app behavior signals.',
    `audience_segment_description` STRING COMMENT 'Detailed business description of the segment purpose, target audience characteristics, and intended use cases for campaign targeting.',
    `audience_segment_name` STRING COMMENT 'Human-readable name of the audience segment used for identification and campaign targeting.',
    `audience_segment_status` STRING COMMENT 'Current lifecycle status of the segment: active (available for targeting), inactive (paused), draft (under development), archived (historical reference), or expired (past validity period).. Valid values are `active|inactive|draft|archived|expired`',
    `audience_segment_type` STRING COMMENT 'Classification of the segment based on the primary targeting methodology: behavioral (actions/browsing), demographic (age/gender/income), psychographic (attitudes/values), contextual (content affinity), lookalike (modeled similarity), or geographic (location-based).. Valid values are `behavioral|demographic|psychographic|contextual|lookalike|geographic`',
    `brand_affinity_list` STRING COMMENT 'Comma-separated list of brands that segment members have shown affinity toward through engagement, purchase, or social signals. Nullable if brand affinity is not a qualification criterion.',
    `browsing_categories` STRING COMMENT 'Comma-separated list of IAB content categories or site categories that segment members have browsed (e.g., IAB1 for Automotive, IAB3 for Business). Nullable if browsing behavior is not a qualification criterion.',
    `ccpa_compliant_flag` BOOLEAN COMMENT 'Indicates whether the segment meets CCPA requirements for consumer opt-out rights and data sale restrictions.',
    `consent_status` STRING COMMENT 'Privacy consent status for segment members under GDPR, CCPA, or other privacy regulations: consented (explicit opt-in), not_consented (no consent), pending (consent requested), or withdrawn (consent revoked).. Valid values are `consented|not_consented|pending|withdrawn`',
    `content_consumption_topics` STRING COMMENT 'Comma-separated list of content topics or themes consumed by segment members (e.g., sports, finance, travel). Nullable if content affinity is not a qualification criterion.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the segment record was first created in the system.',
    `creation_method` STRING COMMENT 'Methodology used to build the segment: rules-based (Boolean logic), ML-modeled (algorithmic clustering/propensity), imported (from external platform), survey-derived (research panel), or manual (curated list).. Valid values are `rules_based|ml_modeled|imported|survey_derived|manual`',
    `cross_device_flag` BOOLEAN COMMENT 'Indicates whether segment uses cross-device identity resolution to track users across desktop, mobile, tablet, and CTV.',
    `data_source_tier` STRING COMMENT 'Origin tier of the segment data: first-party (owned CRM/web/app data), second-party (partner-shared data), or third-party (purchased from data providers).. Valid values are `first_party|second_party|third_party`',
    `dma_codes` STRING COMMENT 'Comma-separated list of Nielsen DMA codes (e.g., 501 for New York) used for geographic targeting. Nullable if geography is not a qualification criterion.',
    `education_level` STRING COMMENT 'Highest education attainment level used for demographic qualification (e.g., high school, bachelor, graduate). Nullable if education is not a qualification criterion. [ENUM-REF-CANDIDATE: less_than_high_school|high_school|some_college|associate|bachelor|graduate|postgraduate — promote to reference product]',
    `effective_date` DATE COMMENT 'Date when the segment becomes available for targeting and activation.',
    `expiry_date` DATE COMMENT 'Date when the segment is no longer valid for targeting, either due to data staleness, consent expiration, or campaign end. Nullable for evergreen segments.',
    `external_code` STRING COMMENT 'External identifier or code used by DSPs, DMPs, CDPs, and third-party platforms to reference this segment.',
    `gdpr_compliant_flag` BOOLEAN COMMENT 'Indicates whether the segment meets GDPR requirements for lawful processing, consent, and data subject rights.',
    `gender` STRING COMMENT 'Gender demographic filter applied to segment qualification. Nullable if gender is not a qualification criterion.. Valid values are `male|female|non_binary|all|unknown`',
    `income_tier` STRING COMMENT 'Household income bracket or tier used for demographic qualification (e.g., <50K, 50K-100K, 100K+). Nullable if income is not a qualification criterion. [ENUM-REF-CANDIDATE: <25K|25K-50K|50K-75K|75K-100K|100K-150K|150K-250K|250K+ — promote to reference product]',
    `interest_taxonomy` STRING COMMENT 'Comma-separated list of interest categories or hobbies (e.g., fitness, gaming, cooking) used for psychographic qualification. Nullable if interests are not a qualification criterion.',
    `language_preference` STRING COMMENT 'Primary language preference for segment members (ISO 639-1 codes: EN, ES, FR, etc.). Nullable if language is not a qualification criterion.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the segment record was last modified, including membership recalculation or metadata updates.',
    `lifestyle_segment` STRING COMMENT 'Lifestyle or life-stage classification (e.g., young professionals, empty nesters, urban millennials) used for psychographic qualification. Nullable if lifestyle is not a qualification criterion.',
    `marital_status` STRING COMMENT 'Marital status demographic filter applied to segment qualification. Nullable if marital status is not a qualification criterion.. Valid values are `single|married|divorced|widowed|all|unknown`',
    `owning_team` STRING COMMENT 'Business unit, account team, or data science team responsible for creating, maintaining, and governing this segment.',
    `parental_status` STRING COMMENT 'Indicates whether segment targets parents, non-parents, or all. Nullable if parental status is not a qualification criterion.. Valid values are `parent|non_parent|all|unknown`',
    `purchase_history_flag` BOOLEAN COMMENT 'Indicates whether segment qualification includes past purchase behavior from CRM or e-commerce data.',
    `refresh_cadence` STRING COMMENT 'Frequency at which segment membership is recalculated and updated: real-time (streaming), hourly, daily, weekly, monthly, or static (one-time build).. Valid values are `real_time|hourly|daily|weekly|monthly|static`',
    `rfm_score` STRING COMMENT 'RFM segmentation score (e.g., 555 for best customers, 111 for low-value) used for behavioral qualification. Nullable if RFM is not a qualification criterion.',
    `search_intent_keywords` STRING COMMENT 'Comma-separated list of search keywords or intent signals used for behavioral qualification (e.g., luxury cars, mortgage refinance). Nullable if search intent is not a qualification criterion.',
    `size` BIGINT COMMENT 'Total count of unique users, devices, or households currently qualifying for this segment.',
    `vals_segment` STRING COMMENT 'VALS psychographic segmentation classification (e.g., Innovators, Thinkers, Achievers, Experiencers) used for psychographic qualification. Nullable if VALS is not a qualification criterion. [ENUM-REF-CANDIDATE: innovators|thinkers|achievers|experiencers|believers|strivers|makers|survivors — promote to reference product]',
    CONSTRAINT pk_audience_segment PRIMARY KEY(`audience_segment_id`)
) COMMENT 'Master record and SSOT for all audience segments — first-party, second-party, and third-party — used across campaigns. Captures segment name, type (behavioral, demographic, psychographic, contextual, lookalike), data source (1P/2P/3P), segment size, creation method (rules-based, ML-modeled, imported), activation status, refresh cadence, expiry date, IAB taxonomy classification, and owning team. Embeds full qualification criteria spanning demographic attributes (age band, gender, income tier, DMA, education, marital/parental status, language), behavioral signals (browsing categories, purchase history, RFM scores, app usage, cross-device activity, search intent, content consumption), and psychographic dimensions (VALS, brand affinity, lifestyle segments, interest taxonomies, purchase motivations, personality indicators, media attitudes). Qualification criteria are sourced from Nielsen, Comscore, first-party CRM, DMP/CDP integrations, survey data, and social listening. SSOT for all audience segment definitions, targeting rules, and profile-level qualification logic in the advertising platform.';

CREATE OR REPLACE TABLE `advertising_ecm`.`audience`.`persona` (
    `persona_id` BIGINT COMMENT 'Unique identifier for the audience persona profile. Primary key.',
    `behavioral_profile_id` BIGINT COMMENT 'Foreign key linking to audience.behavioral_profile. Business justification: Personas currently have digital_behavior_profile (string) and related behavioral attributes. behavioral_profile is a structured, reusable behavioral profile with detailed behavioral data. Normalizing ',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Personas are developed in the context of brand positioning and target audience definition. Brand teams create personas to guide messaging and creative strategy. Linking persona to brand enables brand ',
    `worker_id` BIGINT COMMENT 'Foreign key linking to talent.worker. Business justification: Personas are high-value strategic frameworks authored by specific strategists or planners. Tracking authorship supports expertise mapping, quality assurance, and intellectual property management. Repl',
    `demographic_profile_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_profile. Business justification: Personas currently have embedded demographic attributes (age_range_min/max, gender_profile, income_bracket, education_level, geographic_focus, household_composition). demographic_profile is a structur',
    `psychographic_profile_id` BIGINT COMMENT 'Foreign key linking to audience.psychographic_profile. Business justification: Personas currently have psychographic_traits (string) and related psychographic attributes. psychographic_profile is a structured, reusable psychographic profile with detailed VALS and lifestyle data.',
    `ccpa_opt_out_eligible` BOOLEAN COMMENT 'Indicates whether individuals matching this persona have CCPA opt-out rights for data sale.',
    `cdp_audience_key` STRING COMMENT 'Reference key for this persona in the Customer Data Platform for cross-channel activation.',
    `cltv_estimate` DECIMAL(18,2) COMMENT 'Projected lifetime value in USD for customers matching this persona profile.',
    `consent_compliant_flag` BOOLEAN COMMENT 'Indicates whether this persona profile is built exclusively from privacy-compliant, consented data sources.',
    `content_preferences` STRING COMMENT 'Types of content and messaging styles that resonate with this persona (e.g., Educational, Humorous, Inspirational).',
    `conversion_propensity` DECIMAL(18,2) COMMENT 'Likelihood score (0-100) that this persona will convert based on historical campaign performance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this persona profile was first created in the system.',
    `data_source_type` STRING COMMENT 'Classification of the primary data source used to construct this persona profile.. Valid values are `first_party|second_party|third_party|synthesized`',
    `dmp_segment_ids` STRING COMMENT 'Comma-separated list of DMP segment IDs that map to this persona for programmatic activation.',
    `estimated_reach` BIGINT COMMENT 'Estimated total addressable audience size for this persona across all available channels.',
    `gdpr_lawful_basis` STRING COMMENT 'Legal basis under GDPR for processing personal data associated with this persona.. Valid values are `consent|legitimate_interest|contract|legal_obligation|not_applicable`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this persona profile was most recently modified or refreshed.',
    `last_validated_date` DATE COMMENT 'Date when this persona profile was last reviewed and validated by strategy or account teams.',
    `narrative_description` STRING COMMENT 'Rich narrative description of the persona, including lifestyle, values, and behavioral characteristics used by creative teams.',
    `owning_team` STRING COMMENT 'Business unit or account team responsible for maintaining and using this persona profile.',
    `pain_points` STRING COMMENT 'Key challenges, frustrations, or unmet needs that this persona experiences, used to inform messaging strategy.',
    `persona_code` STRING COMMENT 'Short alphanumeric code used for quick reference in campaign planning and media buying systems.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `persona_name` STRING COMMENT 'The archetypal name or label assigned to this persona (e.g., Tech-Savvy Millennial, Budget-Conscious Parent).',
    `persona_status` STRING COMMENT 'Current lifecycle status of the persona profile.. Valid values are `active|inactive|draft|archived|under_review`',
    `preferred_channels` STRING COMMENT 'Comma-separated list of most effective marketing channels for reaching this persona (e.g., Social Media, CTV, Digital Display).',
    `social_media_platforms` STRING COMMENT 'Comma-separated list of social media platforms where this persona is most active (e.g., Facebook, Instagram, TikTok).',
    `usage_count` STRING COMMENT 'Number of campaigns or media plans that have actively targeted this persona.',
    CONSTRAINT pk_persona PRIMARY KEY(`persona_id`)
) COMMENT 'Synthesized audience persona profiles representing archetypal target audience groups for campaign planning and creative strategy. Captures persona name, narrative description, demographic summary, psychographic traits, media consumption habits, purchase intent signals, pain points, motivations, and associated brand affinity scores. Used by account teams and strategists to align creative briefs and media plans to defined audience archetypes.';

CREATE OR REPLACE TABLE `advertising_ecm`.`audience`.`demographic_profile` (
    `demographic_profile_id` BIGINT COMMENT 'Unique identifier for the demographic profile record. Primary key for the demographic profile entity.',
    `audience_segment_id` BIGINT COMMENT 'External segment identifier from the Data Management Platform (DMP) system. Used for DMP integration and cross-platform targeting.',
    `taxonomy_id` BIGINT COMMENT 'Foreign key linking to audience.audience_taxonomy. Business justification: audience_taxonomy provides standardized audience classification categories aligned to IAB Audience Taxonomy. demographic_profile should be classified using this standardized taxonomy for consistency a',
    `third_party_feed_id` BIGINT COMMENT 'Foreign key linking to audience.third_party_feed. Business justification: demographic_profile has data_source and data_provider (strings). For third-party demographic data, tracking which third_party_feed sourced the profile is critical for data lineage and cost allocation.',
    `age_band` STRING COMMENT 'Age range classification for the demographic profile. Standard age cohorts used for audience segmentation and targeting.. Valid values are `18-24|25-34|35-44|45-54|55-64|65+`',
    `children_age_range` STRING COMMENT 'Age range of children in household (e.g., 0-5, 6-12, 13-17). Used for family and parenting-focused targeting. Null if parental_status is non_parent.',
    `consent_date` DATE COMMENT 'Date when consent was obtained for use of this demographic data. Required for GDPR and CCPA audit trails.',
    `consent_expiration_date` DATE COMMENT 'Date when consent expires and data can no longer be used for targeting. Null if consent does not expire.',
    `consent_status` STRING COMMENT 'Privacy consent status for use of this demographic data in targeting. Critical for GDPR and CCPA compliance.. Valid values are `consented|not_consented|pending|withdrawn`',
    `country_code` STRING COMMENT 'Three-letter ISO country code (e.g., USA, CAN, GBR). Used for international campaign targeting and compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this demographic profile record was first created in the system. Used for audit and data lineage.',
    `dma_code` STRING COMMENT 'Nielsen Designated Market Area code representing the geographic television market. Critical for broadcast and OOH media planning.',
    `dma_name` STRING COMMENT 'Human-readable name of the Nielsen DMA (e.g., New York, Los Angeles, Chicago). Used for media planning and reporting.',
    `education_level` STRING COMMENT 'Highest level of education attained. Used for audience segmentation and targeting strategies.. Valid values are `high_school|some_college|bachelors|masters|doctorate|other`',
    `employment_category` STRING COMMENT 'Employment status classification. Used for socioeconomic and lifestyle-based audience segmentation. [ENUM-REF-CANDIDATE: employed_full_time|employed_part_time|self_employed|unemployed|retired|student|undisclosed — 7 candidates stripped; promote to reference product]',
    `estimated_population_size` BIGINT COMMENT 'Estimated number of individuals matching this demographic profile. Used for reach estimation and media planning.',
    `ethnicity` STRING COMMENT 'Ethnic or cultural background classification where legally permissible and consented. Used for culturally relevant targeting. Subject to GDPR, CCPA, and local privacy regulations.',
    `gender` STRING COMMENT 'Gender classification for the demographic profile. Used for audience targeting and campaign personalization.. Valid values are `male|female|non-binary|undisclosed`',
    `geographic_region` STRING COMMENT 'Broad geographic region classification within the country. Used for regional media planning and geo-targeting.. Valid values are `northeast|southeast|midwest|southwest|west|other`',
    `homeownership_status` STRING COMMENT 'Indicates whether the individual owns or rents their residence. Used for real estate, home services, and financial product targeting.. Valid values are `owner|renter|undisclosed`',
    `household_income_tier` STRING COMMENT 'Household income bracket classification. Used for socioeconomic targeting and media planning. Sourced from Nielsen, Comscore, and first-party CRM data.. Valid values are `under_25k|25k_50k|50k_75k|75k_100k|100k_150k|over_150k`',
    `household_size` STRING COMMENT 'Number of individuals in the household. Used for household composition analysis and targeting.',
    `last_verified_date` DATE COMMENT 'Date when the demographic profile data was last verified or updated. Used for data freshness assessment.',
    `marital_status` STRING COMMENT 'Marital status classification for the demographic profile. Used for household-based targeting and lifestyle segmentation.. Valid values are `single|married|divorced|widowed|undisclosed`',
    `occupation_category` STRING COMMENT 'Broad occupational category (e.g., Professional, Management, Service, Sales, Technical). Used for B2B and professional targeting.',
    `parental_status` STRING COMMENT 'Indicates whether the individual is a parent. Used for family-oriented campaign targeting.. Valid values are `parent|non_parent|undisclosed`',
    `postal_code` STRING COMMENT 'Postal code (ZIP code in U.S.) for geographic targeting and localization. Used for hyper-local campaign targeting.',
    `primary_language` STRING COMMENT 'Primary language spoken by the demographic segment (e.g., English, Spanish, Mandarin). Used for creative localization and media channel selection.',
    `profile_code` STRING COMMENT 'Standardized code or identifier used across systems to reference this demographic profile (e.g., DEM-001, PROF-URBAN-25-34).',
    `profile_confidence_score` DECIMAL(18,2) COMMENT 'Confidence score (0-100) indicating the accuracy and completeness of the demographic profile data. Used for data quality assessment and targeting precision.',
    `profile_description` STRING COMMENT 'Detailed textual description of the demographic profile, including key characteristics and targeting use cases.',
    `profile_name` STRING COMMENT 'Human-readable name or label for this demographic profile segment (e.g., Affluent Urban Millennials, Suburban Families).',
    `profile_status` STRING COMMENT 'Current lifecycle status of the demographic profile. Indicates whether the profile is available for targeting.. Valid values are `active|inactive|archived|pending_review`',
    `psychographic_segment` STRING COMMENT 'Psychographic or lifestyle segment classification (e.g., Early Adopters, Value Seekers, Luxury Enthusiasts). Used for behavioral and attitudinal targeting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this demographic profile record was last modified. Used for audit and data lineage.',
    `urbanicity` STRING COMMENT 'Classification of residential area type. Used for lifestyle-based targeting and media channel selection.. Valid values are `urban|suburban|rural`',
    `vehicle_ownership` STRING COMMENT 'Indicates whether the individual owns a vehicle. Used for automotive, insurance, and transportation-related targeting.. Valid values are `owns_vehicle|no_vehicle|undisclosed`',
    CONSTRAINT pk_demographic_profile PRIMARY KEY(`demographic_profile_id`)
) COMMENT 'Structured demographic attribute set for audience definitions — including age band, gender, household income tier, education level, marital status, parental status, geographic region, DMA (Designated Market Area), language, ethnicity (where legally permissible), and employment category. Sourced from Nielsen, Comscore, and first-party CRM data. Serves as the demographic dimension for segment qualification and targeting criteria.';

CREATE OR REPLACE TABLE `advertising_ecm`.`audience`.`behavioral_profile` (
    `behavioral_profile_id` BIGINT COMMENT 'Unique identifier for the behavioral audience profile record. Primary key.',
    `audience_segment_id` BIGINT COMMENT 'Reference to the parent audience segment this behavioral profile belongs to.',
    `taxonomy_id` BIGINT COMMENT 'Foreign key linking to audience.audience_taxonomy. Business justification: behavioral_profile has browsing_category_primary and browsing_category_secondary (strings). audience_taxonomy provides standardized audience classification. Adding primary_taxonomy_id (FK to audience_',
    `tertiary_behavioral_lookalike_seed_segment_audience_segment_id` BIGINT COMMENT 'Reference to the seed audience segment used to generate this lookalike behavioral profile, if applicable.',
    `third_party_feed_id` BIGINT COMMENT 'Foreign key linking to audience.third_party_feed. Business justification: behavioral_profile has dmp_source_platform (string). For third-party behavioral data, tracking which third_party_feed sourced the profile is critical for data lineage. Adding third_party_feed_id enabl',
    `app_usage_pattern` STRING COMMENT 'Description of observed mobile app usage patterns (e.g., Gaming Apps, Shopping Apps, News Apps, Social Media Apps).',
    `brand_affinity_category` STRING COMMENT 'Category of brands or products the user has shown affinity toward based on observed behavior (e.g., Luxury Brands, Eco-Friendly Products, Tech Gadgets).',
    `browsing_category_primary` STRING COMMENT 'The primary content category observed in the users browsing behavior (e.g., Automotive, Travel, Finance, Health & Wellness).',
    `browsing_category_secondary` STRING COMMENT 'The secondary content category observed in the users browsing behavior, indicating additional interests.',
    `consent_status` STRING COMMENT 'Privacy consent status for behavioral data collection and usage, ensuring compliance with GDPR, CCPA, and other privacy regulations.. Valid values are `granted|denied|pending|withdrawn|not_required`',
    `consent_timestamp` TIMESTAMP COMMENT 'Timestamp when consent was granted or last updated for this behavioral profile.',
    `content_consumption_category` STRING COMMENT 'Category of content consumed by the user (e.g., Video, Articles, Podcasts, Social Media).',
    `cross_device_activity_flag` BOOLEAN COMMENT 'Indicates whether the behavioral profile includes cross-device activity tracking and identity resolution.',
    `data_retention_expiry_date` DATE COMMENT 'Date when this behavioral profile data must be purged or anonymized per privacy regulations and data retention policies.',
    `data_source_description` STRING COMMENT 'Detailed description of the data sources contributing to this behavioral profile (e.g., Website pixel data, mobile app SDK, CRM integration).',
    `day_of_week_preference` STRING COMMENT 'Observed preference for day of week when the user is most active online.. Valid values are `weekday|weekend|mixed`',
    `device_type_primary` STRING COMMENT 'The primary device type observed in the users digital behavior.. Valid values are `desktop|mobile|tablet|ctv|ott|unknown`',
    `engagement_level` STRING COMMENT 'Overall engagement level classification based on interaction frequency, depth, and duration.. Valid values are `very_high|high|medium|low|very_low`',
    `frequency_score` STRING COMMENT 'Frequency component of RFM scoring model, indicating how often the user exhibits the behavior (scale 1-5, 5 being most frequent).',
    `geographic_behavior_pattern` STRING COMMENT 'Description of observed geographic or location-based behavior patterns (e.g., Urban Commuter, Frequent Traveler, Suburban Resident).',
    `last_observed_behavior_date` DATE COMMENT 'Date when the most recent behavioral signal was observed for this profile.',
    `lookalike_similarity_score` DECIMAL(18,2) COMMENT 'Similarity score (0.00 to 100.00) indicating how closely this profile matches the seed segment for lookalike modeling.',
    `monetary_score` STRING COMMENT 'Monetary component of RFM scoring model, indicating the value associated with the users behavior (scale 1-5, 5 being highest value).',
    `notes` STRING COMMENT 'Free-text notes or comments about this behavioral profile for internal reference and documentation.',
    `privacy_jurisdiction` STRING COMMENT 'Primary privacy jurisdiction applicable to this behavioral profile (e.g., EU, California, Global).',
    `profile_creation_date` DATE COMMENT 'Date when this behavioral profile was first created in the system.',
    `profile_last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this behavioral profile was last updated with new behavioral signals or attributes.',
    `profile_name` STRING COMMENT 'Human-readable name or label for this behavioral profile (e.g., High-Intent Auto Shoppers, Frequent Travelers).',
    `profile_quality_score` DECIMAL(18,2) COMMENT 'Quality score (0.00 to 100.00) indicating the accuracy, completeness, and reliability of the behavioral profile data.',
    `profile_reach_estimate` BIGINT COMMENT 'Estimated number of unique users or devices matching this behavioral profile, used for campaign planning and media buying.',
    `profile_status` STRING COMMENT 'Current lifecycle status of the behavioral profile indicating availability for targeting.. Valid values are `active|inactive|archived|pending_review|deprecated`',
    `profile_type` STRING COMMENT 'Classification of the behavioral profile based on data source and construction method.. Valid values are `first_party|second_party|third_party|modeled|lookalike`',
    `purchase_intent_signal` STRING COMMENT 'Derived signal indicating the likelihood of purchase behavior based on observed actions (e.g., cart additions, product page views, price comparisons).. Valid values are `high|medium|low|none`',
    `recency_score` STRING COMMENT 'Recency component of RFM (Recency, Frequency, Monetary) scoring model, indicating how recently the user exhibited the behavior (scale 1-5, 5 being most recent).',
    `search_intent_keywords` STRING COMMENT 'Comma-separated list of observed search keywords or phrases indicating user intent and interests.',
    `seasonal_behavior_pattern` STRING COMMENT 'Description of observed seasonal or cyclical behavior patterns (e.g., Holiday Shopper, Back-to-School, Summer Traveler).',
    `targeting_eligibility_flag` BOOLEAN COMMENT 'Indicates whether this behavioral profile is currently eligible for use in campaign targeting based on quality, consent, and compliance checks.',
    `time_of_day_preference` STRING COMMENT 'Observed preference for time of day when the user is most active online.. Valid values are `morning|afternoon|evening|night|mixed`',
    CONSTRAINT pk_behavioral_profile PRIMARY KEY(`behavioral_profile_id`)
) COMMENT 'Behavioral audience profile capturing observed digital and offline behaviors — including browsing categories, purchase history signals, app usage patterns, content consumption categories, search intent signals, recency/frequency/monetary (RFM) scores, and cross-device activity. Sourced from DMP/CDP integrations, The Trade Desk audience data, and first-party behavioral signals. Used for behavioral targeting and lookalike modeling.';

CREATE OR REPLACE TABLE `advertising_ecm`.`audience`.`psychographic_profile` (
    `psychographic_profile_id` BIGINT COMMENT 'Unique identifier for the psychographic profile record. Primary key.',
    `audience_segment_id` BIGINT COMMENT 'Reference to the audience segment this psychographic profile belongs to.',
    `taxonomy_id` BIGINT COMMENT 'Foreign key linking to audience.audience_taxonomy. Business justification: psychographic_profile has lifestyle_category and primary_interest_category (strings). audience_taxonomy provides standardized audience classification. Adding primary_taxonomy_id (FK to audience_taxono',
    `third_party_feed_id` BIGINT COMMENT 'Foreign key linking to audience.third_party_feed. Business justification: psychographic_profile has data_source_type and data_provider_name (strings). For third-party psychographic data, tracking which third_party_feed sourced the profile is critical for data lineage and co',
    `brand_affinity_tier` STRING COMMENT 'Consumer preference tier for brand positioning and pricing sensitivity.. Valid values are `luxury|premium|mid_market|value|discount|unbranded`',
    `brand_loyalty_score` DECIMAL(18,2) COMMENT 'Score (0-100) indicating tendency toward brand loyalty versus brand switching behavior.',
    `consent_compliant_flag` BOOLEAN COMMENT 'Indicates whether this profile was constructed using only data from individuals who provided appropriate consent under GDPR, CCPA, and other privacy regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this psychographic profile record was first created in the system.',
    `cultural_orientation` STRING COMMENT 'Cultural identity and orientation influencing media preferences and brand affinity.. Valid values are `individualist|collectivist|traditional|progressive|multicultural|cosmopolitan`',
    `digital_engagement_level` STRING COMMENT 'Level of engagement with digital media and online platforms.. Valid values are `very_high|high|moderate|low|very_low`',
    `effective_end_date` DATE COMMENT 'Date after which this psychographic profile is no longer valid for targeting (nullable for open-ended profiles).',
    `effective_start_date` DATE COMMENT 'Date from which this psychographic profile became valid and available for campaign targeting.',
    `environmental_consciousness_score` DECIMAL(18,2) COMMENT 'Score (0-100) indicating level of environmental and sustainability concern in purchase decisions.',
    `geographic_scope` STRING COMMENT 'Geographic coverage level for which this psychographic profile is applicable.. Valid values are `global|regional|national|local|dma|metro`',
    `innovation_adoption_index` DECIMAL(18,2) COMMENT 'Index score (0-100) measuring propensity to adopt new products and technologies.',
    `last_refresh_date` DATE COMMENT 'Date when the psychographic profile data was last updated or refreshed from source systems.',
    `lifestyle_category` STRING COMMENT 'Broad lifestyle classification (e.g., Urban Professional, Suburban Family, Rural Traditional, Digital Nomad). [ENUM-REF-CANDIDATE: urban_professional|suburban_family|rural_traditional|digital_nomad|active_retiree|student|young_single|empty_nester — promote to reference product]',
    `media_consumption_attitude` STRING COMMENT 'Attitude toward new media channels and advertising formats.. Valid values are `early_adopter|mainstream|late_adopter|traditional|skeptical|enthusiast`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this psychographic profile record was last modified.',
    `opinion_leader_indicator` BOOLEAN COMMENT 'Flag indicating whether this profile represents opinion leaders or influencers within their social networks.',
    `personality_archetype` STRING COMMENT 'Primary personality archetype based on Jungian or brand personality frameworks (e.g., Explorer, Caregiver, Hero, Rebel). [ENUM-REF-CANDIDATE: explorer|caregiver|hero|rebel|creator|sage|innocent|ruler|magician|lover|jester|everyman — promote to reference product]',
    `price_sensitivity_index` DECIMAL(18,2) COMMENT 'Index score (0-100) measuring responsiveness to price changes and promotional offers.',
    `primary_interest_category` STRING COMMENT 'Top-level interest category based on IAB Content Taxonomy (e.g., Automotive, Travel, Technology, Health & Fitness). [ENUM-REF-CANDIDATE: automotive|travel|technology|health_fitness|food_dining|home_garden|sports|entertainment — promote to reference product]',
    `privacy_classification` STRING COMMENT 'Classification of data privacy level and party relationship for this psychographic profile.. Valid values are `first_party|second_party|third_party|anonymous|pseudonymous`',
    `profile_code` STRING COMMENT 'Short alphanumeric code used to reference this profile in campaign systems and reporting.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `profile_confidence_score` DECIMAL(18,2) COMMENT 'Statistical confidence score (0-100) indicating the reliability and accuracy of the psychographic profile based on sample size and data quality.',
    `profile_description` STRING COMMENT 'Detailed narrative description of the psychographic profile characteristics, behaviors, and targeting recommendations for creative and strategy teams.',
    `profile_name` STRING COMMENT 'Human-readable name or label for this psychographic profile (e.g., Eco-Conscious Millennials, Luxury Seekers).',
    `profile_status` STRING COMMENT 'Current lifecycle status of the psychographic profile for campaign targeting use.. Valid values are `active|inactive|deprecated|under_review|draft`',
    `purchase_motivation_primary` STRING COMMENT 'Primary driver behind purchase decisions for this psychographic segment. [ENUM-REF-CANDIDATE: quality|price|convenience|status|innovation|sustainability|tradition — 7 candidates stripped; promote to reference product]',
    `purchase_motivation_secondary` STRING COMMENT 'Secondary driver influencing purchase behavior. [ENUM-REF-CANDIDATE: quality|price|convenience|status|innovation|sustainability|tradition — 7 candidates stripped; promote to reference product]',
    `risk_tolerance_level` STRING COMMENT 'Consumer risk tolerance in purchase decisions and product trials.. Valid values are `very_high|high|moderate|low|very_low`',
    `sample_size` STRING COMMENT 'Number of individuals or data points used to construct this psychographic profile.',
    `secondary_interest_category` STRING COMMENT 'Secondary interest category providing additional targeting depth.',
    `social_media_activity_score` DECIMAL(18,2) COMMENT 'Normalized score (0-100) representing social media engagement and influence level derived from social listening data.',
    `usage_restriction_notes` STRING COMMENT 'Free-text notes describing any contractual or regulatory restrictions on the use of this psychographic profile in campaigns.',
    `vals_framework_segment` STRING COMMENT 'Primary VALS psychographic segment classification based on consumer motivations and resources. [ENUM-REF-CANDIDATE: innovators|thinkers|achievers|experiencers|believers|strivers|makers|survivors — 8 candidates stripped; promote to reference product]',
    `values_orientation` STRING COMMENT 'Core values orientation (e.g., Achievement, Security, Benevolence, Hedonism, Tradition, Self-Direction). [ENUM-REF-CANDIDATE: achievement|security|benevolence|hedonism|tradition|self_direction|universalism|power|stimulation|conformity — promote to reference product]',
    CONSTRAINT pk_psychographic_profile PRIMARY KEY(`psychographic_profile_id`)
) COMMENT 'Psychographic audience profile capturing values, attitudes, interests, and lifestyle (VALS) attributes — including brand affinity categories, lifestyle segments, interest taxonomies, personality indicators, purchase motivations, and media attitude scores. Derived from survey data, social listening, and third-party psychographic data providers. Used for brand strategy alignment and creative message targeting.';

CREATE OR REPLACE TABLE `advertising_ecm`.`audience`.`segment_membership` (
    `segment_membership_id` BIGINT COMMENT 'Unique identifier for the segment membership record. Primary key for the segment membership association.',
    `audience_consent_record_id` BIGINT COMMENT 'Foreign key linking to audience.audience_consent_record. Business justification: segment_membership has audience_identifier and consent_status (string). audience_consent_record is the authoritative SSOT for consent status by identifier. Adding audience_consent_record_id links segm',
    `audience_segment_id` BIGINT COMMENT 'Reference to the specific audience segment that this identifier belongs to. Links to the audience segment definition in the DMP or CDP.',
    `third_party_feed_id` BIGINT COMMENT 'Reference to the third-party data provider or DMP that supplied this segment membership, if applicable. Null for first-party segments. Used for data lineage, cost attribution, and vendor performance analysis.',
    `activation_status` STRING COMMENT 'The status of this segment membership in the DSP or activation platform. Activated indicates the membership is live and available for targeting. Pending indicates activation is in progress. Failed indicates activation encountered an error. Deactivated indicates the membership has been removed from the activation platform.. Valid values are `activated|pending|failed|deactivated`',
    `activation_timestamp` TIMESTAMP COMMENT 'The timestamp when this segment membership was successfully activated in the DSP or targeting platform. Used for activation latency analysis and real-time audience availability reporting.',
    `audience_identifier` STRING COMMENT 'The individual audience identifier (cookie ID, device ID, hashed email, MAID, or other pseudonymous identifier) that is a member of the segment. This is the core identifier used for targeting and activation across DSP, DMP, and CDP platforms.',
    `confidence_score` DECIMAL(18,2) COMMENT 'A numeric score between 0 and 1 representing the confidence or probability that the audience identifier truly belongs to this segment. Higher scores indicate stronger membership signals. Used for quality filtering and bid optimization in programmatic campaigns.',
    `cost_per_member` DECIMAL(18,2) COMMENT 'The cost paid to acquire or license this specific segment membership from a third-party data provider, expressed in the campaign currency. Null for first-party segments. Used for data cost attribution and ROI analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this segment membership record was first created in the system. Used for audit trails and membership lifecycle tracking.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the cost per member amount (e.g., USD, EUR, GBP). Used for multi-currency data cost reporting and financial reconciliation.. Valid values are `^[A-Z]{3}$`',
    `device_type` STRING COMMENT 'The type of device associated with this audience identifier. Desktop indicates traditional computer. Mobile indicates smartphone. Tablet indicates tablet device. CTV indicates Connected TV. OTT indicates Over-The-Top streaming device. Other indicates unclassified device. Used for device-specific targeting and cross-device attribution.. Valid values are `desktop|mobile|tablet|ctv|ott|other`',
    `dsp_platform` STRING COMMENT 'The name or identifier of the DSP platform where this segment membership is activated for programmatic buying (e.g., The Trade Desk, Google DV360, Amazon DSP). Used for cross-platform segment distribution tracking and activation reconciliation.',
    `frequency_cap` STRING COMMENT 'The maximum number of times this audience identifier should be exposed to ads from campaigns targeting this segment within a defined time period. Used for frequency management and preventing ad fatigue. Nullable if no cap is applied.',
    `geographic_region` STRING COMMENT 'The geographic region or market associated with this segment membership, if the segment has geographic targeting criteria. Used for geo-targeted campaign planning and regional audience analysis.',
    `identifier_type` STRING COMMENT 'The type of audience identifier used for this membership record. Indicates whether the identifier is a cookie ID, mobile advertising ID (MAID), device ID, hashed email, customer ID, or household ID.. Valid values are `cookie_id|device_id|maid|hashed_email|customer_id|household_id`',
    `inclusion_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this is an inclusion (true) or exclusion (false) membership. Inclusion memberships are targeted in campaigns; exclusion memberships are suppressed. Supports negative targeting and suppression list management.',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'The timestamp when this segment membership record was last refreshed or re-evaluated. Critical for real-time segment population tracking and ensuring audience data freshness for DSP activation.',
    `match_rate` DECIMAL(18,2) COMMENT 'The rate at which this audience identifier successfully matched to the segment criteria, expressed as a decimal between 0 and 1. Used for data quality assessment and segment match performance analysis across DMP and CDP integrations.',
    `membership_expiry_date` DATE COMMENT 'The date when the segment membership expires or is scheduled to expire. Nullable for evergreen segments. Used for time-bound segment management and automated exclusion workflows.',
    `membership_source` STRING COMMENT 'The origin or derivation method of the segment membership. First-party indicates data collected directly by the advertiser. Second-party indicates data shared by a partner. Third-party indicates data purchased from a data provider. Modeled indicates membership derived from predictive modeling. Lookalike indicates membership based on similarity to a seed audience. Behavioral indicates membership based on observed actions. Contextual indicates membership based on content consumption. [ENUM-REF-CANDIDATE: first_party|second_party|third_party|modeled|lookalike|behavioral|contextual — 7 candidates stripped; promote to reference product]',
    `membership_start_date` DATE COMMENT 'The date when the audience identifier first became a member of this segment. Used for recency analysis and segment freshness reporting.',
    `membership_status` STRING COMMENT 'Current lifecycle status of the segment membership. Active indicates the identifier is currently in the segment and eligible for targeting. Expired indicates membership has lapsed. Excluded indicates the identifier has been explicitly removed. Pending indicates membership is being processed. Suppressed indicates the identifier is blocked from targeting due to consent or compliance rules.. Valid values are `active|expired|excluded|pending|suppressed`',
    `recency_days` STRING COMMENT 'The number of days since the audience identifier last exhibited the behavior or attribute that qualifies them for this segment. Used for recency-based targeting strategies and segment decay analysis.',
    `segment_priority` STRING COMMENT 'A numeric priority ranking for this segment membership when the audience identifier belongs to multiple overlapping segments. Higher values indicate higher priority. Used for bid decisioning and creative selection when multiple segments apply.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this segment membership record was last updated or modified. Used for change tracking and data freshness monitoring.',
    CONSTRAINT pk_segment_membership PRIMARY KEY(`segment_membership_id`)
) COMMENT 'Association record linking individual audience identifiers (cookie IDs, device IDs, hashed emails, MAIDs) to specific audience segments. Captures membership start date, expiry date, membership source, confidence score, inclusion/exclusion flag, and last refresh timestamp. Enables real-time segment population tracking and audience size reporting across DMP, CDP, and DSP platforms including The Trade Desk.';

CREATE OR REPLACE TABLE `advertising_ecm`.`audience`.`audience_consent_record` (
    `audience_consent_record_id` BIGINT COMMENT 'Unique identifier for the audience consent record. Primary key for the consent record entity.',
    `audience_identifier` STRING COMMENT 'Unique identifier for the audience member or device (e.g., hashed email, device ID, cookie ID, customer ID). This is the subject of the consent record.',
    `cdp_profile_sync_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether this audience identifier is enabled for synchronization with Customer Data Platforms for unified profile building.',
    `consent_channel` STRING COMMENT 'Channel or interface through which the consent was captured (e.g., web, mobile app, email, call center, in-person, API, partner portal). [ENUM-REF-CANDIDATE: web|mobile_app|email|call_center|in_person|api|partner_portal — 7 candidates stripped; promote to reference product]',
    `consent_expiry_date` DATE COMMENT 'Date when the consent expires and must be re-confirmed. Null if consent does not expire or is perpetual until withdrawn.',
    `consent_language` STRING COMMENT 'Two-letter ISO 639-1 language code representing the language in which the consent notice was presented to the audience member.. Valid values are `^[a-z]{2}$`',
    `consent_method` STRING COMMENT 'Method by which consent was obtained (e.g., explicit opt-in, implicit opt-in, opt-out, pre-checked box, granular choice, bundled consent). Critical for GDPR compliance assessment.. Valid values are `explicit_opt_in|implicit_opt_in|opt_out|pre_checked|granular_choice|bundled`',
    `consent_notice_url` STRING COMMENT 'URL or reference to the full privacy notice or consent text that was presented to the audience member. Provides traceability to the exact terms accepted.',
    `consent_notice_version` STRING COMMENT 'Version identifier of the privacy notice or consent text that was presented to the audience member at the time of consent capture. Used for audit and compliance tracking.',
    `consent_proof_document_url` STRING COMMENT 'URL or storage path to the archived proof of consent (e.g., screenshot, signed form, audit log entry). Used for regulatory audit and dispute resolution.',
    `consent_scope_analytics` BOOLEAN COMMENT 'Boolean flag indicating whether consent has been granted for analytics and measurement purposes.',
    `consent_scope_data_sharing` BOOLEAN COMMENT 'Boolean flag indicating whether consent has been granted for sharing audience data with third parties or partners.',
    `consent_scope_personalization` BOOLEAN COMMENT 'Boolean flag indicating whether consent has been granted for content personalization and recommendation purposes.',
    `consent_scope_targeting` BOOLEAN COMMENT 'Boolean flag indicating whether consent has been granted for audience targeting and personalized advertising purposes.',
    `consent_source` STRING COMMENT 'Source system or channel through which the consent was captured (e.g., Consent Management Platform, preference center, opt-in form, registration flow, API integration, data import, or default setting). [ENUM-REF-CANDIDATE: cmp|preference_center|opt_in_form|registration|api|import|default — 7 candidates stripped; promote to reference product]',
    `consent_source_system` STRING COMMENT 'Name or identifier of the specific system or platform that captured the consent (e.g., OneTrust, TrustArc, Salesforce Marketing Cloud, custom CMP).',
    `consent_status` STRING COMMENT 'Current status of the consent for this audience identifier. Indicates whether consent has been granted, denied, withdrawn, expired, is pending user action, or is not required for this use case.. Valid values are `granted|denied|withdrawn|expired|pending|not_required`',
    `consent_timestamp` TIMESTAMP COMMENT 'Date and time when the consent was originally granted or denied by the audience member. This is the primary business event timestamp for the consent action.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this consent record was first created in the system. Used for audit trail and data lineage.',
    `dmp_segment_sync_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether this audience identifier is enabled for synchronization with Data Management Platforms for segment targeting.',
    `do_not_sell_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the audience member has exercised their right to opt out of the sale of personal information under CCPA. True means do not sell.',
    `global_privacy_control_signal` BOOLEAN COMMENT 'Boolean flag indicating whether a Global Privacy Control signal was detected from the users browser or device at the time of consent capture. True means GPC signal was present.',
    `identifier_type` STRING COMMENT 'Type of audience identifier used in this consent record (e.g., email hash, device ID, cookie ID, customer ID, mobile advertising ID, CRM ID).. Valid values are `email_hash|device_id|cookie_id|customer_id|mobile_ad_id|crm_id`',
    `ip_address` STRING COMMENT 'IP address of the device or user at the time consent was captured. Used for audit trail and fraud detection. May be considered PII in some jurisdictions.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this consent record is currently active and should be enforced. False indicates the record is superseded or archived.',
    `is_minor` BOOLEAN COMMENT 'Boolean flag indicating whether the audience member is a minor (under age of consent in their jurisdiction). Triggers additional COPPA or GDPR Article 8 protections.',
    `jurisdiction` STRING COMMENT 'Primary privacy regulation or jurisdiction governing this consent record (e.g., GDPR for European Union, CCPA for California, COPPA for children under 13, LGPD for Brazil, PIPEDA for Canada, APPI for Japan, POPIA for South Africa). [ENUM-REF-CANDIDATE: GDPR|CCPA|COPPA|LGPD|PIPEDA|APPI|POPIA — 7 candidates stripped; promote to reference product]',
    `jurisdiction_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the country or region where the consent was captured or where the audience member resides.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this consent record was last modified or updated. Used for audit trail and change tracking.',
    `last_verification_timestamp` TIMESTAMP COMMENT 'Date and time when the consent status was last verified or re-confirmed with the audience member. Used for periodic consent refresh workflows.',
    `notes` STRING COMMENT 'Optional free-text notes or comments about this consent record. Used for documenting special circumstances, exceptions, or additional context.',
    `parental_consent_required` BOOLEAN COMMENT 'Boolean flag indicating whether parental or guardian consent is required for this audience member due to age restrictions.',
    `parental_consent_timestamp` TIMESTAMP COMMENT 'Date and time when parental or guardian consent was obtained. Null if not applicable or not yet obtained.',
    `tcf_consent_string` STRING COMMENT 'IAB Transparency and Consent Framework encoded consent string capturing granular vendor and purpose consents. Used for programmatic advertising compliance.',
    `third_party_sharing_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether audience data associated with this identifier can be shared with third-party partners or vendors.',
    `user_agent` STRING COMMENT 'Browser or application user agent string at the time consent was captured. Provides technical context for the consent event.',
    `withdrawal_reason` STRING COMMENT 'Optional free-text or coded reason provided by the audience member for withdrawing consent. Used for compliance documentation and user experience improvement.',
    `withdrawal_timestamp` TIMESTAMP COMMENT 'Date and time when the consent was withdrawn by the audience member. Null if consent has not been withdrawn.',
    CONSTRAINT pk_audience_consent_record PRIMARY KEY(`audience_consent_record_id`)
) COMMENT 'Privacy consent and preference record for audience identifiers — capturing consent status (granted/denied/withdrawn), consent scope (targeting, analytics, personalization, data sharing), consent source (CMP, preference center, opt-in form), jurisdiction (GDPR, CCPA, COPPA), consent timestamp, expiry date, version of consent notice presented, and withdrawal timestamp. SSOT for privacy-compliant audience data usage governance.';

CREATE OR REPLACE TABLE `advertising_ecm`.`audience`.`identity_graph` (
    `identity_graph_id` BIGINT COMMENT 'Unique identifier for the identity graph record linking multiple audience identifiers to a unified person-level entity.',
    `third_party_feed_id` BIGINT COMMENT 'Foreign key linking to audience.third_party_feed. Business justification: identity_graph has identity_provider (string) indicating which third-party identity resolution provider sourced the identity linkage. third_party_feed tracks external data integrations. Adding third_p',
    `browser` STRING COMMENT 'Web browser associated with the cookie ID (e.g., Chrome, Safari, Firefox, Edge). Used for browser-specific targeting and tracking compatibility.',
    `consent_status` STRING COMMENT 'Privacy consent status for using this identity link for advertising purposes. Must comply with GDPR, CCPA, and other privacy regulations.. Valid values are `granted|denied|withdrawn|not_required|pending`',
    `consent_timestamp` TIMESTAMP COMMENT 'Timestamp when user consent was captured or last updated. Required for GDPR and CCPA compliance auditing.',
    `cookie_identifier` STRING COMMENT 'Browser cookie identifier used for web-based tracking and targeting. May be first-party or third-party cookie.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this identity graph record was first created in the data platform. Used for audit trails and data lineage tracking.',
    `crm_identifier` STRING COMMENT 'First-party CRM system identifier linking the identity graph to known customer records in Salesforce or other CRM platforms.',
    `ctv_device_identifier` STRING COMMENT 'Device identifier for Connected TV and Over-the-Top (OTT) platforms used for CTV advertising targeting and measurement.',
    `data_source` STRING COMMENT 'Origin of the identity data. First-party from owned properties, second-party from partners, third-party from data providers, DMP/CDP from platform integrations. [ENUM-REF-CANDIDATE: first_party|second_party|third_party|dmp|cdp|publisher|advertiser — 7 candidates stripped; promote to reference product]',
    `device_type` STRING COMMENT 'Type of device associated with this identity link. Used for cross-device frequency capping and device-specific targeting strategies. [ENUM-REF-CANDIDATE: desktop|mobile|tablet|ctv|smart_speaker|wearable|gaming_console|other — 8 candidates stripped; promote to reference product]',
    `first_seen_timestamp` TIMESTAMP COMMENT 'Timestamp when this identifier was first observed in the advertising ecosystem. Used for recency/frequency analysis and new-user identification.',
    `geographic_country_code` STRING COMMENT 'Three-letter ISO country code derived from IP address or device location. Used for geographic targeting and compliance with regional privacy laws.. Valid values are `^[A-Z]{3}$`',
    `geographic_dma_code` STRING COMMENT 'Nielsen Designated Market Area code for US-based identities. Used for local media planning and TV/digital convergence strategies.',
    `geographic_region` STRING COMMENT 'State, province, or region derived from IP address or device location. Used for regional targeting and local campaign optimization.',
    `hashed_email` STRING COMMENT 'SHA-256 hashed email address used for privacy-safe identity matching and audience targeting across platforms.',
    `household_identifier` STRING COMMENT 'Identifier representing the household-level entity for household-based targeting and frequency management. Multiple unified person IDs may share the same household ID.',
    `identity_graph_status` STRING COMMENT 'Current lifecycle status of the identity link. Active links are used for targeting; inactive/expired links are retained for historical analysis; suppressed links honor opt-out requests; revoked links have been invalidated.. Valid values are `active|inactive|expired|suppressed|pending_verification|revoked`',
    `identity_provider_version` STRING COMMENT 'Version or release identifier of the identity provider technology used for the match. Enables tracking of algorithm changes and match quality over time.',
    `ip_address` STRING COMMENT 'Internet Protocol address used for geographic targeting and device identification. May be IPv4 or IPv6 format.',
    `last_seen_timestamp` TIMESTAMP COMMENT 'Timestamp when this identifier was most recently observed in ad serving or campaign activity. Used for recency targeting and inactive user suppression.',
    `link_creation_date` DATE COMMENT 'Date when the identity link was first established in the graph. Used for recency analysis and link decay modeling.',
    `link_expiration_date` DATE COMMENT 'Date when the identity link is scheduled to expire if not reverified. Used for data retention policies and GDPR/CCPA compliance.',
    `link_last_verified_date` DATE COMMENT 'Date when the identity link was most recently verified or refreshed through observed user activity or deterministic match.',
    `match_confidence_score` DECIMAL(18,2) COMMENT 'Confidence score (0.0000 to 1.0000) indicating the reliability of the identity link. Higher scores indicate stronger match confidence. Used for quality filtering in targeting and attribution.',
    `match_method` STRING COMMENT 'Method used to link identifiers to the unified person entity. Deterministic uses exact matches (e.g., logged-in user data), probabilistic uses statistical modeling, hybrid combines both approaches.. Valid values are `deterministic|probabilistic|hybrid`',
    `mobile_advertising_identifier` STRING COMMENT 'Device-level mobile advertising identifier (IDFA for iOS, GAID for Android) used for mobile app targeting and attribution.',
    `notes` STRING COMMENT 'Free-text field for additional context, data quality flags, or operational notes about this identity link. Used for troubleshooting and quality assurance.',
    `operating_system` STRING COMMENT 'Operating system of the device (e.g., iOS, Android, Windows, macOS, tvOS, Roku OS). Used for OS-level targeting and compatibility analysis.',
    `opt_out_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the user has opted out of cross-device tracking or targeted advertising. True means user has opted out.',
    `opt_out_timestamp` TIMESTAMP COMMENT 'Timestamp when the user opted out of tracking or targeting. Used for compliance reporting and suppression list management.',
    `privacy_framework` STRING COMMENT 'Applicable privacy regulation or framework governing this identity link (e.g., GDPR, CCPA, IAB TCF v2.0, NAI Code). Used for compliance segmentation and reporting.',
    `total_linked_identifiers` STRING COMMENT 'Count of distinct identifiers (cookies, MAIDs, emails, etc.) linked to this unified person entity. Higher counts indicate richer cross-device profiles.',
    `unified_person_code` STRING COMMENT 'Master identifier representing the unified person-level entity across all linked identifiers. This is the canonical ID used for people-based targeting and cross-device attribution.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this identity graph record was last modified. Used for change tracking and incremental processing.',
    `version` STRING COMMENT 'Version identifier of the identity graph algorithm or model used to create this link. Enables A/B testing of graph strategies and historical analysis.',
    CONSTRAINT pk_identity_graph PRIMARY KEY(`identity_graph_id`)
) COMMENT 'Cross-device and cross-channel identity resolution record linking multiple audience identifiers to a unified person-level entity — including cookie IDs, device IDs (MAIDs), hashed emails (SHA-256), CRM IDs, household IDs, IP addresses, and Connected TV (CTV) device IDs. Captures match method (deterministic/probabilistic), match confidence score, identity provider (LiveRamp, Unified ID 2.0, publisher first-party), link creation date, and active/inactive status. Enables people-based targeting, cross-device frequency management, and household-level audience resolution.';

CREATE OR REPLACE TABLE `advertising_ecm`.`audience`.`activation` (
    `activation_id` BIGINT COMMENT 'Unique identifier for the audience activation record. Primary key.',
    `audience_segment_id` BIGINT COMMENT 'Reference to the audience segment being activated for targeting.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Activations execute brand campaigns across platforms. Brand managers need to track which audiences are activated for their brand, monitor reach, match rates, and activation costs. Essential for brand-',
    `budget_line_id` BIGINT COMMENT 'Foreign key linking to finance.budget_line. Business justification: Each audience activation to a DSP/platform consumes a specific budget line (media spend allocation). Finance teams reconcile activation costs against budget lines. This link enables activation-level s',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign for which this audience segment is being activated.',
    `creative_asset_id` BIGINT COMMENT 'Foreign key linking to creative.creative_asset. Business justification: Activations push segments to DSPs/SSPs with specific creative; programmatic campaigns require asset-segment pairing for trafficking, and activation records must track which creative serves to each aud',
    `creative_deliverable_id` BIGINT COMMENT 'Foreign key linking to creative.creative_deliverable. Business justification: Activations reference deliverables for media plan execution; trafficking workflows map segments to specific creative deliverables to ensure correct creative versions serve to each audience across chan',
    `dmp_integration_id` BIGINT COMMENT 'Foreign key linking to audience.dmp_integration. Business justification: audience_activation has target_platform (string) indicating which DSP/SSP/DMP the segment was activated to. dmp_integration is the configuration record for DMP/CDP platforms. Adding dmp_integration_id',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Audience activations are often executed as part of broader project initiatives for budget tracking, timeline management, and deliverable coordination. Agencies track which project initiative funded an',
    `media_insertion_order_id` BIGINT COMMENT 'Foreign key linking to media.media_insertion_order. Business justification: Audience segments are activated through specific insertion orders for campaign delivery. Ad ops teams link activations to IOs for budget tracking, delivery pacing, and reconciliation of audience-targe',
    `platform_audience_audience_segment_id` BIGINT COMMENT 'External identifier assigned by the target platform (DSP/SSP) for this activated audience segment.',
    `platform_integration_id` BIGINT COMMENT 'Technical identifier for the API integration or connection used to push data to the target platform.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Activations are executed through platform vendors (DSPs, social platforms, DMPs). Tracking which supplier/platform executed each activation is fundamental to reconciliation, performance reporting, inv',
    `suppression_list_id` BIGINT COMMENT 'Foreign key linking to audience.suppression_list. Business justification: audience_activation pushes segments to DSPs/SSPs. suppression_list defines identifiers to exclude from targeting. An activation should reference which suppression list was applied to ensure excluded i',
    `worker_id` BIGINT COMMENT 'Reference to the user or system account that initiated the audience activation.',
    `activation_date` DATE COMMENT 'Date when the audience segment was activated and pushed to the target platform.',
    `activation_method` STRING COMMENT 'Technical method used to push the audience segment to the target platform. API = Application Programming Interface, S2S = Server-to-Server integration.. Valid values are `API|S2S|Pixel|File Upload|Manual`',
    `activation_name` STRING COMMENT 'Business-friendly name or label for this activation instance.',
    `activation_status` STRING COMMENT 'Current operational status of the audience activation in its lifecycle.. Valid values are `Pending|Active|Paused|Expired|Failed|Cancelled`',
    `activation_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the activation was initiated and the segment push began.',
    `activation_type` STRING COMMENT 'Classification of the activation purpose and targeting strategy.. Valid values are `Standard|Lookalike|Suppression|Retargeting|Prospecting`',
    `bid_modifier` DECIMAL(18,2) COMMENT 'Multiplier applied to base bid amounts for this audience segment (e.g., 1.25 = 25% bid increase, 0.80 = 20% bid decrease).',
    `consent_framework` STRING COMMENT 'Privacy consent framework applied to this activation. IAB TCF = Interactive Advertising Bureau Transparency and Consent Framework.. Valid values are `IAB TCF 2.0|CCPA|GDPR|Custom`',
    `consent_status` STRING COMMENT 'Privacy consent status for the audience segment members at the time of activation, ensuring GDPR and CCPA compliance.. Valid values are `Verified|Pending|Expired|Revoked`',
    `cost_cpm` DECIMAL(18,2) COMMENT 'Cost per thousand impressions charged by the data provider or platform for activating this audience segment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audience activation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for activation costs (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `data_source_type` STRING COMMENT 'Origin classification of the audience data being activated (first-party = owned, second-party = partner, third-party = purchased).. Valid values are `First-Party|Second-Party|Third-Party`',
    `effective_end_date` DATE COMMENT 'Date when the activated audience segment expires and is no longer available for targeting. Nullable for open-ended activations.',
    `effective_start_date` DATE COMMENT 'Date when the activated audience segment becomes available for targeting in campaigns.',
    `error_message` STRING COMMENT 'Detailed error or failure message if the activation encountered issues during processing or sync.',
    `estimated_reach` BIGINT COMMENT 'Estimated number of unique users or devices in the activated audience segment available for targeting.',
    `frequency_cap` STRING COMMENT 'Maximum number of times an individual user in the activated segment should be exposed to campaign creative within the frequency window.',
    `frequency_cap_window_hours` STRING COMMENT 'Time window in hours over which the frequency cap is applied.',
    `last_sync_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful synchronization of audience data to the target platform.',
    `match_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of audience segment records successfully matched and recognized by the target platform, expressed as a decimal (e.g., 75.50 for 75.5%).',
    `matched_user_count` BIGINT COMMENT 'Actual number of users or devices successfully matched by the target platform during activation.',
    `next_sync_timestamp` TIMESTAMP COMMENT 'Scheduled timestamp for the next audience data synchronization to the target platform.',
    `notes` STRING COMMENT 'Free-form notes or comments about this activation for operational context and troubleshooting.',
    `priority_level` STRING COMMENT 'Business priority assigned to this activation for resource allocation and optimization decisions.. Valid values are `High|Medium|Low`',
    `retry_count` STRING COMMENT 'Number of retry attempts made for failed activations before marking as permanently failed.',
    `sync_frequency` STRING COMMENT 'Cadence at which the audience segment membership is refreshed and re-synced to the target platform.. Valid values are `Real-Time|Hourly|Daily|Weekly|On-Demand`',
    `unmatched_user_count` BIGINT COMMENT 'Number of users or devices from the segment that could not be matched by the target platform.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this audience activation record was last modified.',
    CONSTRAINT pk_activation PRIMARY KEY(`activation_id`)
) COMMENT 'Operational record of an audience segment being activated (pushed) to a specific DSP, SSP, or media platform for campaign targeting. Captures activation date, target platform (The Trade Desk, DV360, Meta, etc.), segment ID, activation status (pending/active/expired/paused), estimated reach, match rate, activation method (pixel, API, S2S), and associated campaign reference. Tracks the operational lifecycle of audience deployment.';

CREATE OR REPLACE TABLE `advertising_ecm`.`audience`.`third_party_feed` (
    `third_party_feed_id` BIGINT COMMENT 'Unique identifier for the third-party audience data feed integration record.',
    `dmp_integration_id` BIGINT COMMENT 'Foreign key linking to audience.dmp_integration. Business justification: third_party_feed has platform_type, sync_method, sync_frequency (strings) describing how the feed is integrated. dmp_integration is the configuration record for DMP/CDP platform integrations. Many thi',
    `worker_id` BIGINT COMMENT 'Foreign key linking to talent.worker. Business justification: Data feed integrations require technical ownership for vendor management, SLA monitoring, credential rotation, and incident response. Every production integration must have an accountable owner for op',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Third-party audience data feeds are provided by vendors (DMPs, data brokers, etc.). Currently provider_name and provider_code are stored as strings. Normalizing to supplier_id FK enables joining to ve',
    `activated_timestamp` TIMESTAMP COMMENT 'Timestamp when the feed integration was activated and began syncing data.',
    `api_endpoint_url` STRING COMMENT 'API endpoint URL used for data synchronization when sync method is API-based.',
    `authentication_method` STRING COMMENT 'Authentication mechanism used to secure the data feed connection.. Valid values are `oauth|api_key|basic_auth|certificate|saml`',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews upon expiration.',
    `ccpa_compliant_flag` BOOLEAN COMMENT 'Indicates whether the data feed is certified as compliant with CCPA requirements.',
    `contract_end_date` DATE COMMENT 'Date when the data provider contract expires or is scheduled for renewal.',
    `contract_start_date` DATE COMMENT 'Date when the data provider contract became effective.',
    `cost_model` STRING COMMENT 'Pricing model for the data feed: Cost Per Mille (CPM), flat fee, usage-based, subscription, revenue share, or free.. Valid values are `cpm|flat_fee|usage_based|subscription|revenue_share|free`',
    `cpm_rate` DECIMAL(18,2) COMMENT 'Cost per thousand impressions or records for CPM-based pricing models.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the third-party feed integration record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts associated with this feed.. Valid values are `^[A-Z]{3}$`',
    `data_expiry_days` STRING COMMENT 'Number of days after which the third-party data must be purged or refreshed per provider policy and privacy regulations.',
    `data_retention_days` STRING COMMENT 'Number of days the synced data is retained in internal systems before archival or deletion per compliance policy.',
    `data_taxonomy_version` STRING COMMENT 'Version identifier of the data taxonomy or classification schema used by the provider for audience segment categorization.',
    `data_volume_mb` DECIMAL(18,2) COMMENT 'Total data volume in megabytes transferred in the last synchronization.',
    `error_count` STRING COMMENT 'Number of errors encountered during the last synchronization attempt.',
    `feed_type` STRING COMMENT 'Classification of the audience data feed by the type of data provided.. Valid values are `demographic|behavioral|intent|contextual|geographic|psychographic`',
    `gdpr_compliant_flag` BOOLEAN COMMENT 'Indicates whether the data feed is certified as compliant with GDPR requirements.',
    `integration_direction` STRING COMMENT 'Direction of data flow: inbound (receiving data from provider), outbound (sending data to provider), or bidirectional (two-way sync).. Valid values are `inbound|outbound|bidirectional`',
    `integration_health_score` DECIMAL(18,2) COMMENT 'Calculated health score (0-100) reflecting sync success rate, data quality, latency, and error frequency for this feed.',
    `integration_status` STRING COMMENT 'Overall lifecycle status of the third-party feed integration.. Valid values are `active|inactive|testing|deprecated|suspended`',
    `last_error_message` STRING COMMENT 'Detailed error message or code from the most recent failed synchronization event.',
    `last_sync_record_count` BIGINT COMMENT 'Number of records processed in the most recent synchronization event.',
    `last_sync_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful data synchronization event.',
    `licensing_terms` STRING COMMENT 'Summary of contractual licensing terms governing the use of the third-party data, including usage restrictions, redistribution rights, and compliance obligations.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the third-party feed integration record was last modified.',
    `monthly_cost_amount` DECIMAL(18,2) COMMENT 'Fixed or estimated monthly cost for the data feed in the contract currency.',
    `next_scheduled_sync_timestamp` TIMESTAMP COMMENT 'Timestamp when the next data synchronization is scheduled to occur.',
    `pii_handling_classification` STRING COMMENT 'Classification of how the feed handles PII: no PII present, pseudonymized identifiers, hashed identifiers, fully anonymized, or contains direct PII.. Valid values are `no_pii|pseudonymized|hashed|anonymized|contains_pii`',
    `segment_mapping_configuration` STRING COMMENT 'JSON or structured configuration defining how provider segments map to internal audience taxonomy and targeting rules.',
    `sync_status` STRING COMMENT 'Current operational status of the data feed synchronization.. Valid values are `active|paused|failed|pending|disabled`',
    `total_records_synced` BIGINT COMMENT 'Cumulative count of audience records or segments synchronized from this feed since activation.',
    CONSTRAINT pk_third_party_feed PRIMARY KEY(`third_party_feed_id`)
) COMMENT 'Master record and SSOT for all external audience data integrations — including third-party data feeds, DMP (Data Management Platform) connections, and CDP (Customer Data Platform) platform syncs. Covers providers such as Nielsen, Comscore, Oracle Data Cloud, Acxiom, Experian, Adobe Audience Manager, Salesforce DMP, Tealium, Segment.io, and The Trade Desk. Captures provider name, feed type (demographic, behavioral, intent, contextual), platform type (DMP/CDP/data marketplace), integration direction (inbound/outbound/bidirectional), sync method (API, S3, pixel, batch), sync frequency, last sync timestamp, sync status, data taxonomy version, licensing terms, cost model (CPM-based), data expiry policy, PII handling classification, segment mapping configuration, data volume metrics, and integration health indicators. SSOT for external audience data sourcing, all DMP/CDP platform integration operations, and third-party data connectivity monitoring.';

CREATE OR REPLACE TABLE `advertising_ecm`.`audience`.`lookalike_model` (
    `lookalike_model_id` BIGINT COMMENT 'Unique identifier for the lookalike audience model record. Primary key for the lookalike model entity.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser or client account that owns this lookalike model for campaign use and billing purposes.',
    `audience_insight_id` BIGINT COMMENT 'Foreign key linking to analytics.audience_insight. Business justification: Insights evaluate lookalike model performance, expansion quality, similarity accuracy, and activation recommendations. Analysis informs model tuning and expansion ratio optimization.',
    `audience_segment_id` BIGINT COMMENT 'Reference to the source audience segment used as the foundation for building the lookalike model. The seed segment contains high-value users whose characteristics are modeled.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Lookalike models find new audiences similar to a brands existing customers. Brand teams need to track which lookalike models support their acquisition strategy. Essential for brand-level audience exp',
    `budget_line_id` BIGINT COMMENT 'Foreign key linking to finance.budget_line. Business justification: Lookalike model creation and deployment incur platform fees (e.g., Facebook, Google) charged against campaign budget lines. Finance teams track model costs per campaign. This link enables model cost a',
    `campaign_id` BIGINT COMMENT 'Optional reference to a specific campaign for which this lookalike model was created, enabling campaign-specific audience modeling strategies.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Lookalike model development is a distinct project deliverable with dedicated timelines, resources, and budgets. Agencies track which initiative funded model creation for cost recovery and to manage da',
    `media_insertion_order_id` BIGINT COMMENT 'Foreign key linking to media.media_insertion_order. Business justification: Lookalike audiences are activated via specific insertion orders for campaign execution. Buyers use lookalike models to expand reach within IO budget and targeting parameters, requiring explicit IO lin',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Custom lookalike modeling is often scoped as a discrete SOW deliverable with specific acceptance criteria, training data requirements, and performance thresholds. Required for deliverable tracking, bi',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Lookalike models are frequently built by third-party data science platforms or DSPs (e.g., Facebook, Trade Desk, LiveRamp). Tracking the supplier is essential for cost allocation, model performance at',
    `worker_id` BIGINT COMMENT 'Identifier of the data scientist, analyst, or platform user who created the lookalike model configuration.',
    `algorithm_type` STRING COMMENT 'Machine learning algorithm used to build the lookalike model. Determines the mathematical approach for identifying similar audience members. [ENUM-REF-CANDIDATE: cosine_similarity|gradient_boosting|neural_network|random_forest|logistic_regression|collaborative_filtering|k_nearest_neighbors|decision_tree|support_vector_machine — promote to reference product]. Valid values are `cosine_similarity|gradient_boosting|neural_network|random_forest|logistic_regression|collaborative_filtering`',
    `baseline_performance_value` DECIMAL(18,2) COMMENT 'Benchmark performance metric value from the seed segment, used to compare lookalike audience performance against the original high-value segment.',
    `consent_compliant_flag` BOOLEAN COMMENT 'Indicates whether the lookalike model was built using only users who provided explicit consent for data usage under GDPR, CCPA, or other privacy regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the lookalike model record was first created in the system. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the model cost and related financial metrics.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `data_source_type` STRING COMMENT 'Classification of the data used to build the seed segment and train the model. First-party is owned data; second-party is partner data; third-party is purchased data.. Valid values are `first_party|second_party|third_party|hybrid`',
    `estimated_reach` BIGINT COMMENT 'Projected number of unique users or devices in the lookalike audience available for targeting across campaigns.',
    `expansion_ratio` DECIMAL(18,2) COMMENT 'Multiplier indicating how many times larger the lookalike audience is compared to the seed segment (e.g., 10.00 means the lookalike is 10x the seed size). Used to balance reach vs. similarity.',
    `expiration_date` DATE COMMENT 'Date when the lookalike model is scheduled to expire and become unavailable for targeting unless refreshed or extended.',
    `feature_set` STRING COMMENT 'Comma-separated list of data attributes used as input features for model training (e.g., demographics, behavioral signals, purchase history, engagement metrics).',
    `geographic_scope` STRING COMMENT 'Geographic boundary for the lookalike audience (e.g., USA, CAN, GBR, global). Uses ISO 3166-1 alpha-3 country codes or global for worldwide reach.',
    `last_refresh_date` DATE COMMENT 'Date when the lookalike model was most recently retrained or refreshed with updated seed segment data.',
    `model_cost` DECIMAL(18,2) COMMENT 'Total cost incurred to build and deploy the lookalike model, including data acquisition, platform fees, and computational resources.',
    `model_description` STRING COMMENT 'Detailed business description of the lookalike model purpose, target use cases, and strategic rationale for campaign planners and media buyers.',
    `model_name` STRING COMMENT 'Business-friendly name assigned to the lookalike model for identification and campaign planning purposes.',
    `model_status` STRING COMMENT 'Current lifecycle state of the lookalike model. Active models are available for campaign targeting; expired models require retraining.. Valid values are `draft|training|active|paused|expired|archived`',
    `model_version` STRING COMMENT 'Version identifier for the lookalike model, enabling tracking of model iterations and A/B testing across versions.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the lookalike model configuration or metadata. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `next_refresh_date` DATE COMMENT 'Scheduled date for the next model retraining cycle based on the refresh frequency policy.',
    `performance_metric_type` STRING COMMENT 'Primary Key Performance Indicator (KPI) used to evaluate the lookalike model effectiveness in campaigns. CTR = Click-Through Rate, CVR = Conversion Rate, ROAS = Return on Ad Spend, CPA = Cost Per Acquisition, LTV = Lifetime Value.. Valid values are `ctr|cvr|roas|cpa|engagement_rate|ltv`',
    `platform_name` STRING COMMENT 'Programmatic platform or Data Management Platform (DMP) where the lookalike model is deployed for audience targeting. [ENUM-REF-CANDIDATE: the_trade_desk|dv360|amazon_dsp|facebook|google_ads|adobe_audience_manager|linkedin|twitter|snapchat — promote to reference product]. Valid values are `the_trade_desk|dv360|amazon_dsp|facebook|google_ads|adobe_audience_manager`',
    `refresh_frequency_days` STRING COMMENT 'Number of days between scheduled model retraining cycles to maintain accuracy and relevance as audience behaviors evolve.',
    `similarity_threshold` DECIMAL(18,2) COMMENT 'Minimum similarity score (0.0000 to 1.0000) required for a user to be included in the lookalike audience. Higher thresholds produce smaller, more similar audiences.',
    `training_date` DATE COMMENT 'Date when the lookalike model was trained on the seed segment data. Critical for understanding model freshness and performance decay over time.',
    `validation_accuracy` DECIMAL(18,2) COMMENT 'Model accuracy score (0.0000 to 1.0000) measured on a holdout validation dataset, indicating how well the model predicts high-value user characteristics.',
    CONSTRAINT pk_lookalike_model PRIMARY KEY(`lookalike_model_id`)
) COMMENT 'Operational record of a lookalike audience model built from a seed segment — capturing seed segment reference, model algorithm type (cosine similarity, gradient boosting, neural net), expansion ratio, similarity threshold, model training date, model version, platform (The Trade Desk, DV360), estimated reach, validation accuracy, and model status. Enables scale expansion of high-value audience segments for prospecting campaigns.';

CREATE OR REPLACE TABLE `advertising_ecm`.`audience`.`suppression_list` (
    `suppression_list_id` BIGINT COMMENT 'Unique identifier for the suppression list record. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Identifier of the advertiser to which this suppression list is scoped. Nullable if the list is shared across multiple advertisers.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Suppression lists are often derived from segments (e.g., suppress all users who converted or suppress all users in segment X). Adding source_segment_id tracks which segment the suppression list wa',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Suppression lists prevent brand fatigue and manage brand-specific frequency caps. Brand managers define suppression rules based on brand guidelines and customer experience strategy. Essential for bran',
    `campaign_id` BIGINT COMMENT 'Identifier of the specific campaign to which this suppression list is applied. Nullable if the list is applied at advertiser or account level.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Suppression list creation and maintenance is often a project task within compliance or campaign setup initiatives. Agencies track which project funded list development for billing and to manage data o',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Suppression obligations are frequently contractually mandated (competitor exclusions, brand safety requirements, regulatory compliance). Critical for compliance verification, audit trails, and ensurin',
    `media_insertion_order_id` BIGINT COMMENT 'Foreign key linking to media.media_insertion_order. Business justification: Suppression lists are applied at insertion order level to exclude audiences from campaigns (frequency cap overrides, opt-outs, competitive exclusions). Ad ops requires IO linkage for suppression rule ',
    `worker_id` BIGINT COMMENT 'User ID or email of the business user responsible for maintaining and approving the suppression list.',
    `approval_status` STRING COMMENT 'Approval workflow status for the suppression list (approved, pending, rejected). Lists must be approved before activation in campaigns.. Valid values are `approved|pending|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the suppression list was approved for use in campaigns.',
    `archive_date` DATE COMMENT 'Date when the suppression list was archived and removed from active campaign targeting systems.',
    `consent_withdrawal_flag` BOOLEAN COMMENT 'Indicates whether the suppression list contains identifiers for users who have withdrawn marketing consent (True/False).',
    `data_cost` DECIMAL(18,2) COMMENT 'Cost incurred to acquire or license the suppression list data from a third-party provider, in US Dollars (USD).',
    `data_provider` STRING COMMENT 'Name of the third-party data provider or vendor that supplied the suppression list, if applicable (e.g., Nielsen, Comscore, LiveRamp).',
    `effective_end_date` DATE COMMENT 'Date when the suppression list expires and is no longer applied to campaign targeting. Nullable for indefinite suppression lists.',
    `effective_start_date` DATE COMMENT 'Date from which the suppression list becomes active and is applied to campaign targeting.',
    `frequency_cap_period` STRING COMMENT 'Time period over which the frequency cap threshold is measured (hour, day, week, month, campaign lifetime).. Valid values are `hour|day|week|month|campaign_lifetime`',
    `frequency_cap_threshold` STRING COMMENT 'Maximum number of impressions or interactions allowed before an identifier is added to the suppression list. Applicable for frequency-capped suppression types.',
    `hashing_algorithm` STRING COMMENT 'Cryptographic hashing algorithm applied to identifiers for privacy protection (SHA256, MD5, SHA1, none if identifiers are not hashed).. Valid values are `SHA256|MD5|SHA1|none`',
    `identifier_type` STRING COMMENT 'Type of identifier stored in the suppression list (hashed email, cookie ID, Mobile Advertising ID (MAID), device ID, customer ID, IP address). Determines matching strategy in Demand-Side Platforms (DSPs) and Supply-Side Platforms (SSPs).. Valid values are `hashed_email|cookie_id|mobile_advertising_id|device_id|customer_id|ip_address`',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent data refresh or sync operation for this suppression list.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the suppression list record or its identifier membership.',
    `list_code` STRING COMMENT 'Unique business code or external identifier for the suppression list used in campaign systems and Data Management Platforms (DMPs).',
    `list_name` STRING COMMENT 'Business-friendly name of the suppression list (e.g., Q4 Converted Customers, GDPR Opt-Out Master, Competitor Employees).',
    `list_size` BIGINT COMMENT 'Total count of unique identifiers in the suppression list. Used for reach estimation and media planning.',
    `list_status` STRING COMMENT 'Current lifecycle status of the suppression list (active, inactive, expired, pending approval, archived). Only active lists are applied to campaign targeting.. Valid values are `active|inactive|expired|pending_approval|archived`',
    `match_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of identifiers in the suppression list that successfully matched against campaign targeting pools in Demand-Side Platforms (DSPs) or Data Management Platforms (DMPs). Used to assess list quality and reach impact.',
    `notes` STRING COMMENT 'Free-form notes or comments about the suppression list for internal reference, including special handling instructions or business context.',
    `platform_integration_status` STRING COMMENT 'Status of the suppression list synchronization with downstream advertising platforms such as Demand-Side Platforms (DSPs), Supply-Side Platforms (SSPs), or ad servers (synced, pending sync, sync failed, not applicable).. Valid values are `synced|pending_sync|sync_failed|not_applicable`',
    `platform_sync_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful synchronization of the suppression list to downstream advertising platforms.',
    `privacy_compliance_flag` BOOLEAN COMMENT 'Indicates whether the suppression list was created to satisfy privacy regulations such as General Data Protection Regulation (GDPR) or California Consumer Privacy Act (CCPA) opt-out requests (True/False).',
    `refresh_frequency` STRING COMMENT 'Cadence at which the suppression list is refreshed or re-synced from the source system (daily, weekly, monthly, quarterly, on-demand, real-time).. Valid values are `daily|weekly|monthly|quarterly|on_demand|real_time`',
    `retention_period_days` STRING COMMENT 'Number of days the suppression list and its identifiers are retained before automatic archival or deletion, per data retention policies and privacy regulations.',
    `scope_level` STRING COMMENT 'Organizational level at which the suppression list is applied (global across all advertisers, advertiser-specific, campaign-specific, line-item-specific).. Valid values are `global|advertiser|campaign|line_item`',
    `source_file_name` STRING COMMENT 'Name of the file or data feed from which the suppression list was ingested, if applicable. Supports audit and lineage tracking.',
    `source_system` STRING COMMENT 'Originating system or platform that generated the suppression list (e.g., Salesforce CRM, The Trade Desk, Adobe Audience Manager, Google Campaign Manager 360, Internal CRM).',
    `suppression_list_description` STRING COMMENT 'Detailed business description of the suppression list purpose, use case, and any special handling instructions.',
    `suppression_type` STRING COMMENT 'Category of suppression defining why identifiers are excluded from targeting (converted customer, opted-out user, frequency-capped audience, competitor employee, brand safety exclusion, fraud prevention).. Valid values are `converted_customer|opted_out|frequency_capped|competitor_employee|brand_safety|fraud_prevention`',
    `creation_date` DATE COMMENT 'Date when the suppression list was first created in the system.',
    CONSTRAINT pk_suppression_list PRIMARY KEY(`suppression_list_id`)
) COMMENT 'Audience suppression list record defining identifiers to be excluded from campaign targeting — including converted customers, opted-out users, competitor employees, brand safety exclusions, and frequency-capped audiences. Captures list name, suppression type, identifier type (hashed email, cookie, MAID), list size, source system, creation date, expiry date, and associated campaign or advertiser scope. Critical for privacy compliance and media efficiency.';

CREATE OR REPLACE TABLE `advertising_ecm`.`audience`.`dmp_integration` (
    `dmp_integration_id` BIGINT COMMENT 'Unique identifier for the DMP or CDP integration configuration record.',
    `worker_id` BIGINT COMMENT 'Foreign key linking to talent.worker. Business justification: DMP platform integrations require dedicated technical ownership for API maintenance, authentication management, sync monitoring, and vendor escalation. Critical for operational continuity and incident',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: DMP platforms are vendor suppliers. Tracking which supplier provides each DMP integration is essential for vendor management, cost reconciliation, contract compliance, and performance evaluation in ad',
    `vendor_contract_id` BIGINT COMMENT 'Unique identifier of the commercial contract or service agreement governing the use of this DMP or CDP platform.',
    `api_endpoint_url` STRING COMMENT 'Base URL of the API endpoint used for programmatic data exchange with the DMP or CDP platform.',
    `api_version` STRING COMMENT 'Version number of the API specification being used for integration (e.g., v2.0, v3.1).',
    `authentication_method` STRING COMMENT 'Security authentication protocol used to authorize API access: OAuth2, API Key, Basic Authentication, JWT (JSON Web Token), or SAML (Security Assertion Markup Language).. Valid values are `OAuth2|API-Key|Basic-Auth|JWT|SAML`',
    `consent_framework_compliance` STRING COMMENT 'Privacy regulation frameworks that this integration adheres to: GDPR (General Data Protection Regulation), CCPA (California Consumer Privacy Act), LGPD (Brazilian General Data Protection Law), PIPEDA (Canadian Personal Information Protection), or Multiple for multi-jurisdiction compliance.. Valid values are `GDPR|CCPA|LGPD|PIPEDA|None|Multiple`',
    `consent_string_format` STRING COMMENT 'Standard format used for encoding user consent signals: IAB Transparency & Consent Framework v2 (IAB-TCF-v2), IAB US Privacy String (IAB-USP), or Custom proprietary format.. Valid values are `IAB-TCF-v2|IAB-USP|Custom`',
    `cost_per_sync_usd` DECIMAL(18,2) COMMENT 'Cost incurred per data synchronization operation, measured in US dollars, based on the platforms pricing model (per-call, per-record, or per-volume).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this integration configuration record was first created in the system.',
    `credential_expiry_date` DATE COMMENT 'Date when the authentication credentials (API keys, tokens, certificates) expire and require renewal.',
    `data_retention_days` STRING COMMENT 'Number of days that audience data is retained in the platform before automatic purging, in compliance with privacy regulations and data governance policies.',
    `data_volume_mb` DECIMAL(18,2) COMMENT 'Total volume of data transferred in the most recent sync operation, measured in megabytes (MB).',
    `dmp_integration_status` STRING COMMENT 'Current operational state of the integration: active (running), inactive (disabled), paused (temporarily suspended), error (failed), or pending (awaiting activation).. Valid values are `active|inactive|paused|error|pending`',
    `error_log_path` STRING COMMENT 'File system path or cloud storage location where integration error logs and sync failure details are stored for troubleshooting and audit purposes.',
    `integration_type` STRING COMMENT 'Direction of data flow: inbound (data coming into the platform), outbound (data sent to external systems), or bidirectional (two-way sync).. Valid values are `inbound|outbound|bidirectional`',
    `is_production` BOOLEAN COMMENT 'Boolean flag indicating whether this integration is configured for the production environment (True) or a non-production environment such as development, staging, or testing (False).',
    `last_sync_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful data synchronization event between the platform and external systems.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this integration configuration record was last modified or updated.',
    `monthly_cost_cap_usd` DECIMAL(18,2) COMMENT 'Maximum monthly expenditure limit for this integration in US dollars, used to prevent budget overruns and trigger alerts when approaching the cap.',
    `next_scheduled_sync_timestamp` TIMESTAMP COMMENT 'Timestamp when the next scheduled data synchronization is planned to occur.',
    `notes` STRING COMMENT 'Free-text field for capturing additional operational notes, configuration details, known issues, or special handling instructions for this integration.',
    `notification_email` STRING COMMENT 'Email address of the technical contact or team to be notified of integration failures, sync errors, or credential expiry warnings.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `platform_name` STRING COMMENT 'Name of the DMP or CDP platform (e.g., Adobe Audience Manager, Salesforce DMP, Tealium AudienceStream, Segment.io, Oracle BlueKai, Lotame, LiveRamp).',
    `platform_type` STRING COMMENT 'Classification of the platform: DMP (Data Management Platform), CDP (Customer Data Platform), DSP (Demand-Side Platform), SSP (Supply-Side Platform), or Hybrid.. Valid values are `DMP|CDP|DSP|SSP|Hybrid`',
    `rate_limit_requests_per_minute` STRING COMMENT 'Maximum number of API requests permitted per minute as defined by the platforms rate limiting policy to prevent service throttling.',
    `records_failed_count` BIGINT COMMENT 'Total number of audience records that failed to synchronize in the most recent sync operation due to errors or validation failures.',
    `records_synced_count` BIGINT COMMENT 'Total number of audience records successfully synchronized in the most recent sync operation.',
    `retry_attempts_max` STRING COMMENT 'Maximum number of automatic retry attempts for failed sync operations before escalating to manual intervention.',
    `segment_mapping_config` STRING COMMENT 'JSON or XML configuration defining how audience segments are mapped between the internal taxonomy and the external platforms segment structure. Contains mapping rules, transformation logic, and segment ID translations.',
    `sync_frequency` STRING COMMENT 'Cadence at which data synchronization occurs between systems: real-time streaming, hourly batch, daily batch, weekly batch, or on-demand manual trigger.. Valid values are `real-time|hourly|daily|weekly|on-demand`',
    `sync_method` STRING COMMENT 'Technical method used for data synchronization: pixel (tracking tag), API (Application Programming Interface), batch file transfer, webhook callback, SFTP (Secure File Transfer Protocol), or S3 bucket transfer.. Valid values are `pixel|API|batch|webhook|SFTP|S3`',
    `sync_status` STRING COMMENT 'Outcome status of the most recent sync attempt: success (completed without errors), failed (encountered errors), partial (some records synced), or in-progress (currently running).. Valid values are `success|failed|partial|in-progress`',
    `timeout_seconds` STRING COMMENT 'Maximum number of seconds to wait for an API response before timing out and marking the sync attempt as failed.',
    CONSTRAINT pk_dmp_integration PRIMARY KEY(`dmp_integration_id`)
) COMMENT 'Configuration and operational record for DMP (Data Management Platform) and CDP (Customer Data Platform) integrations — capturing platform name (Adobe Audience Manager, Salesforce DMP, Tealium, Segment.io), integration type (inbound/outbound/bidirectional), sync method (pixel, API, batch), sync frequency, last sync timestamp, sync status, segment mapping configuration, and data volume metrics. Manages the technical and operational parameters of audience data exchange.';

CREATE OR REPLACE TABLE `advertising_ecm`.`audience`.`taxonomy` (
    `taxonomy_id` BIGINT COMMENT 'Unique identifier for the audience taxonomy node. Primary key for the audience taxonomy reference structure.',
    `worker_id` BIGINT COMMENT 'Foreign key linking to talent.worker. Business justification: Taxonomies are strategic classification frameworks requiring governance and change management. Tracking the responsible worker supports standards enforcement, version control, and cross-functional ali',
    `parent_taxonomy_id` BIGINT COMMENT 'Reference to the parent node in the taxonomy hierarchy. Null for top-level (tier 1) categories. Enables hierarchical navigation and roll-up reporting.',
    `primary_replacement_taxonomy_id` BIGINT COMMENT 'Reference to the taxonomy node that replaces this deprecated category. Null for active categories or deprecated categories without direct replacement. Enables automated migration of historical segments.',
    `applicable_platforms` STRING COMMENT 'Comma-separated list of digital platforms and channels where this taxonomy category is applicable (e.g., display, video, social, search, CTV, DOOH). Guides media planners on appropriate channel selection.',
    `average_cpm_usd` DECIMAL(18,2) COMMENT 'Average cost per thousand impressions in US dollars for media buys targeting this audience category. Based on historical campaign data and current market rates. Used for budget planning and cost estimation.',
    `category_description` STRING COMMENT 'Detailed description of the audience category, including defining characteristics, typical behaviors, and use cases. Provides guidance for media planners and data analysts on appropriate segment application.',
    `category_name` STRING COMMENT 'Human-readable name of the audience taxonomy category. Used in campaign planning interfaces, reporting dashboards, and client presentations.',
    `cdp_integration_enabled` BOOLEAN COMMENT 'Indicates whether this taxonomy category is integrated with Customer Data Platform for unified customer profile enrichment and personalization. True enables real-time audience orchestration across owned channels.',
    `comscore_compatible` BOOLEAN COMMENT 'Indicates whether this taxonomy category can be mapped to Comscore digital audience measurement segments for cross-platform analytics and validation. True enables independent third-party audience verification.',
    `consent_required` BOOLEAN COMMENT 'Indicates whether explicit user consent is required under GDPR, CCPA, or other privacy regulations before using this audience category for targeting. True requires documented consent; false indicates legitimate interest or non-regulated data.',
    `cpm_last_updated_date` DATE COMMENT 'Date when the average CPM value was last refreshed from campaign performance data and market intelligence. Indicates pricing data freshness.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this taxonomy record was first created in the system. Supports audit trail and data lineage tracking.',
    `data_source_type` STRING COMMENT 'Classification of the data source origin for this audience category. First-party data is owned by the advertiser, second-party is partner-shared, third-party is purchased from data providers. Deterministic uses known identifiers; probabilistic uses inferred signals.. Valid values are `first_party|second_party|third_party|deterministic|probabilistic`',
    `data_type` STRING COMMENT 'Primary data classification type for this audience category. Indicates the source and nature of the audience signal used for segmentation and targeting.. Valid values are `behavioral|demographic|contextual|psychographic|geographic|technographic`',
    `deprecation_reason` STRING COMMENT 'Explanation for why this taxonomy category was deprecated or retired. Includes migration guidance to replacement categories. Null for active categories.',
    `dmp_integration_enabled` BOOLEAN COMMENT 'Indicates whether this taxonomy category is integrated with the agency Data Management Platform for audience activation and cross-platform targeting. True enables automated segment sync to DSPs and SSPs.',
    `dsp_activation_enabled` BOOLEAN COMMENT 'Indicates whether this taxonomy category is available for programmatic activation via Demand-Side Platforms such as The Trade Desk. True enables real-time bidding and automated audience targeting in programmatic campaigns.',
    `effective_end_date` DATE COMMENT 'Date when this taxonomy category was deprecated or retired. Null for currently active categories. Supports historical campaign analysis and taxonomy lifecycle management.',
    `effective_start_date` DATE COMMENT 'Date when this taxonomy category became available for use. Supports historical analysis and version control of taxonomy evolution.',
    `estimated_reach` BIGINT COMMENT 'Estimated total addressable audience size (unique users or devices) for this taxonomy category across all integrated platforms. Updated periodically based on DMP and CDP data. Used for media planning and feasibility assessment.',
    `exclusion_categories` STRING COMMENT 'Comma-separated list of taxonomy codes that should be excluded when this category is used, to prevent audience overlap or conflicting targeting logic. Enforces mutually exclusive segment rules.',
    `iab_standard_code` STRING COMMENT 'Official IAB Audience Taxonomy standard code for this category. Null for custom agency extensions not covered by IAB standard. Enables industry-standard audience classification and cross-publisher comparison.. Valid values are `^(IAB[0-9]{1,4}(-[0-9]{1,4})?)?$`',
    `is_active` BOOLEAN COMMENT 'Indicates whether this taxonomy category is currently active and available for use in campaign planning and targeting. False indicates deprecated or sunset categories that should not be used in new campaigns.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this taxonomy record was last updated. Supports change tracking and data quality monitoring.',
    `last_reviewed_date` DATE COMMENT 'Date when this taxonomy category was last reviewed for accuracy, relevance, and compliance. Supports taxonomy governance and quality assurance processes.',
    `minimum_segment_size` STRING COMMENT 'Minimum number of unique users or devices required for this audience category to be activated in campaigns. Enforces privacy thresholds and prevents re-identification risk. Typically set to 1000+ for GDPR compliance and platform minimums.',
    `nielsen_compatible` BOOLEAN COMMENT 'Indicates whether this taxonomy category can be mapped to Nielsen audience measurement segments for GRP and TRP calculation. True enables cross-platform reach and frequency planning using Nielsen Ad Intel data.',
    `path` STRING COMMENT 'Full hierarchical path from root to this node, using forward-slash delimiter (e.g., Demographics/Age/18-24). Enables breadcrumb navigation and full-path filtering in reporting tools.',
    `privacy_classification` STRING COMMENT 'Privacy sensitivity level of the audience data in this category. Non-PII contains no personal identifiers, pseudonymous uses hashed or tokenized IDs, PII-based includes direct identifiers, sensitive includes special category data under GDPR Article 9.. Valid values are `non_pii|pseudonymous|pii_based|sensitive`',
    `reach_last_updated_date` DATE COMMENT 'Date when the estimated reach value was last refreshed from source systems. Indicates data freshness for media planning decisions.',
    `taxonomy_code` STRING COMMENT 'Unique alphanumeric code identifying this taxonomy node. Used for system integration and cross-platform mapping. Follows agency naming convention.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `taxonomy_level` STRING COMMENT 'Hierarchical tier level of this taxonomy node. Tier 1 represents top-level categories, tier 2 represents sub-categories, tier 3 represents granular segments. Supports drill-down analysis and hierarchical reporting.',
    `usage_guidelines` STRING COMMENT 'Best practice guidance and restrictions for using this audience category in campaigns. Includes recommended use cases, exclusion scenarios, and compliance considerations. Supports media planners and account teams in appropriate segment application.',
    `version_number` STRING COMMENT 'Version identifier for this taxonomy node, following semantic versioning convention (major.minor.patch). Tracks taxonomy evolution and enables version-specific reporting and analysis.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    CONSTRAINT pk_taxonomy PRIMARY KEY(`taxonomy_id`)
) COMMENT 'Reference taxonomy for standardized audience classification categories — aligned to IAB Audience Taxonomy v1.1 and custom agency extensions. Captures taxonomy node ID, parent node, category name, category level (tier 1/2/3), IAB standard code, description, applicable data types (behavioral/demographic/contextual), and active status. Provides the controlled vocabulary for consistent segment classification across campaigns, platforms, and reporting.';

CREATE OR REPLACE TABLE `advertising_ecm`.`audience`.`pixel` (
    `pixel_id` BIGINT COMMENT 'Unique identifier for the tracking pixel or tag. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser or client who owns this pixel.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Pixels collect data to build/refine segments; conversion and event pixels feed segment membership logic, and tracking which segment a pixel is designed to populate is essential for audience data gover',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Pixels collect brand-specific conversion and engagement data. Brand teams need to track which pixels belong to their brand for data governance, privacy compliance, and measurement. Essential for brand',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign this pixel is associated with, if applicable.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Pixel deployment is a standard project deliverable requiring technical implementation, QA testing, and client approval. Agencies track which initiative governs pixel deployment for timeline management',
    `worker_id` BIGINT COMMENT 'Foreign key linking to talent.worker. Business justification: Pixel implementations require technical ownership for deployment QA, troubleshooting, compliance verification, and tag management. Essential for incident response and data quality accountability. Repl',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Pixel deployment, tag implementation, and data collection infrastructure are commonly scoped as SOW deliverables with specific technical specifications, acceptance criteria, and QA requirements. Essen',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Pixels are often provided/managed by third-party tag management vendors (e.g., Tealium, Ensighten, Google Tag Manager). Tracking the supplier enables vendor performance evaluation, troubleshooting, an',
    `tracking_pixel_id` BIGINT COMMENT 'Foreign key linking to performance.tracking_pixel. Business justification: Audience pixels (data collection for segmentation) often share deployment infrastructure with performance tracking pixels (conversion tracking). Links pixel configuration to tracking implementation, e',
    `activated_date` DATE COMMENT 'Date when this pixel was first activated and began firing events.',
    `consent_category` STRING COMMENT 'The consent category under which this pixel operates, determining the level of user consent required: strictly necessary, functional, analytics, advertising, or personalization.. Valid values are `strictly_necessary|functional|analytics|advertising|personalization`',
    `consent_required` BOOLEAN COMMENT 'Indicates whether user consent is required before this pixel can fire, based on applicable privacy regulations (GDPR, CCPA, ePrivacy Directive).',
    `container_code` STRING COMMENT 'The unique identifier of the tag container in which this pixel is deployed, used for container-level tracking and governance.',
    `container_tag_manager` STRING COMMENT 'The tag management system used to deploy and manage this pixel (e.g., Google Tag Manager, Adobe Launch, Tealium, Ensighten).',
    `conversion_value_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for conversion values tracked by this pixel (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pixel record was first created in the system.',
    `cross_domain_tracking_enabled` BOOLEAN COMMENT 'Indicates whether this pixel supports cross-domain tracking to follow users across multiple domains or subdomains.',
    `data_collected` STRING COMMENT 'Description of the data elements captured by the pixel, such as page views, events, conversions, user identifiers, device attributes, or geographic location.',
    `data_retention_days` STRING COMMENT 'Number of days that event data captured by this pixel is retained before being purged or anonymized, per privacy and data governance policies.',
    `deactivated_date` DATE COMMENT 'Date when this pixel was deactivated or archived, if applicable.',
    `deployment_domain` STRING COMMENT 'The root domain where the pixel is deployed, used for domain-level tracking and reporting.',
    `deployment_url` STRING COMMENT 'The URL or domain where the pixel is deployed or embedded, typically a client or agency-managed digital property.',
    `event_schema_definition` STRING COMMENT 'Technical specification or schema definition for the events captured by this pixel, including field names, data types, and required vs. optional attributes.',
    `event_types_captured` STRING COMMENT 'Comma-separated list or description of the specific event types this pixel is configured to capture (e.g., page_view, add_to_cart, purchase, lead_submit, video_view).',
    `firing_rule` STRING COMMENT 'Business logic or conditions that determine when the pixel fires (e.g., on page load, on button click, on form submission, on purchase completion).',
    `first_party_cookie` BOOLEAN COMMENT 'Indicates whether this pixel sets first-party cookies (owned by the advertiser domain) rather than third-party cookies, important for privacy and browser compatibility.',
    `health_status` STRING COMMENT 'Current health status of the pixel based on monitoring and validation checks: healthy (firing as expected), warning (potential issues detected), error (not firing or misconfigured), or inactive (not deployed).. Valid values are `healthy|warning|error|inactive`',
    `identifiers_captured` STRING COMMENT 'Description of the user or device identifiers captured by the pixel, such as cookie IDs, mobile advertising IDs (IDFA, AAID), hashed emails, or platform-specific user IDs.',
    `last_event_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent event captured by this pixel, used for health monitoring and activity tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this pixel record was last modified.',
    `lookback_window_days` STRING COMMENT 'Number of days in the attribution lookback window for this pixel, determining how far back in time conversions can be attributed to ad interactions.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context about this pixel, such as deployment instructions, troubleshooting history, or business rationale.',
    `pixel_code` STRING COMMENT 'Unique external code or identifier for the pixel, often used in platform integrations and trafficking systems.',
    `pixel_name` STRING COMMENT 'Human-readable name or label for the tracking pixel, used for identification and reporting purposes.',
    `pixel_status` STRING COMMENT 'Current operational status of the pixel in its lifecycle: active (live and firing), paused (temporarily disabled), archived (retired), testing (under validation), or pending approval.. Valid values are `active|paused|archived|testing|pending_approval`',
    `pixel_type` STRING COMMENT 'Classification of the pixel based on its primary business purpose: retargeting, conversion tracking, audience building, measurement, view-through tracking, or click-through tracking.. Valid values are `retargeting|conversion|audience_building|measurement|view_through|click_through`',
    `platform` STRING COMMENT 'The advertising platform or technology provider that hosts or serves this pixel (e.g., Google Campaign Manager 360, The Trade Desk, Meta, TikTok, LinkedIn, Amazon DSP).',
    `privacy_policy_url` STRING COMMENT 'URL to the privacy policy that governs the data collection and usage for this pixel, required for transparency and compliance.',
    `server_side_enabled` BOOLEAN COMMENT 'Indicates whether this pixel uses server-side tracking (as opposed to client-side browser-based tracking) for improved data accuracy and privacy compliance.',
    `total_events_captured` BIGINT COMMENT 'Cumulative count of all events captured by this pixel since activation, used for volume tracking and performance monitoring.',
    CONSTRAINT pk_pixel PRIMARY KEY(`pixel_id`)
) COMMENT 'Master record for audience tracking pixels and tags deployed on client or agency-managed digital properties, including their event capture specifications and transactional event stream. Captures pixel name, pixel type (retargeting, conversion, audience building, measurement), platform (Google CM360, The Trade Desk, Meta, TikTok), deployment URL/domain, firing rules, data collected (page views, events, conversions), pixel status (active/paused/archived), associated advertiser, container tag management details, event schema definitions (event types, captured identifiers, device/geo attributes), and individual firing event records (event timestamp, event type, identifier captured, referring URL, device type, browser, geographic location). Owns pixel configuration, event specification, and the raw event stream that feeds first-party audience segment building and conversion attribution. Enables unified pixel health monitoring, event volume tracking, and first-party audience data collection governance.';

CREATE OR REPLACE TABLE `advertising_ecm`.`audience`.`pixel_event` (
    `pixel_event_id` BIGINT COMMENT 'Unique identifier for the pixel firing event. Primary key for the pixel event transactional record.',
    `ad_id` BIGINT COMMENT 'Reference to the specific ad creative that led to this pixel firing event. Used for creative-level performance attribution.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Events contribute to segment qualification; real-time segmentation and audience building require mapping events to segments they qualify users for, enabling dynamic audience updates and personalizatio',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Pixel events measure brand-specific user interactions and conversions. Brand managers need to analyze event data to understand brand engagement, build retargeting audiences, and measure campaign effec',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign associated with the pixel event. Links the event to campaign performance and attribution analysis.',
    `conversion_event_id` BIGINT COMMENT 'Foreign key linking to performance.conversion_event. Business justification: Pixel events trigger conversions - direct attribution path for pixel-based conversion tracking. Essential for validating conversion attribution, debugging tracking discrepancies, and reconciling audie',
    `media_placement_id` BIGINT COMMENT 'Reference to the media placement or ad slot associated with the pixel event. Links event to media buy and publisher context.',
    `pixel_id` BIGINT COMMENT 'Reference to the deployed tracking pixel or tag that captured this event. Links to the pixel configuration and deployment metadata.',
    `browser` STRING COMMENT 'Web browser application used by the user at the time of pixel firing. Parsed from user agent string.',
    `browser_version` STRING COMMENT 'Version number of the browser application. Used for technical compatibility analysis and fraud detection.',
    `ccpa_opt_out` BOOLEAN COMMENT 'Flag indicating whether the user has exercised CCPA opt-out rights for sale of personal information. True if user has opted out.',
    `consent_status` STRING COMMENT 'User consent status for tracking and data collection at the time of pixel firing. Critical for GDPR and CCPA compliance.. Valid values are `granted|denied|not_required|unknown`',
    `conversion_flag` BOOLEAN COMMENT 'Boolean indicator of whether this pixel event represents a conversion action as defined by campaign KPI targets. True for conversion events.',
    `cookie_identifier` STRING COMMENT 'Browser cookie identifier captured at the time of pixel firing. Used for cross-session user recognition and audience segment assignment.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this pixel event record was first ingested into the data platform. Distinct from event_timestamp which represents the user interaction time.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the event_value. Used when pixel events capture cross-border transactions or multi-currency campaigns.. Valid values are `^[A-Z]{3}$`',
    `device_type` STRING COMMENT 'Category of device from which the pixel event was fired. Used for device-based audience segmentation and cross-device attribution.. Valid values are `desktop|mobile|tablet|ctv|other`',
    `event_source` STRING COMMENT 'Channel or platform from which the pixel event originated. Distinguishes web-based tracking from mobile app or Connected TV (CTV) tracking.. Valid values are `web|mobile_app|ctv|email|other`',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when the pixel firing event occurred in the users browser or device. Represents the real-world moment of user interaction.',
    `event_type` STRING COMMENT 'Type of user interaction or behavior captured by the pixel firing event. Discriminates the business action that triggered the pixel.. Valid values are `page_view|add_to_cart|purchase|form_submit|video_view|click`',
    `event_value` DECIMAL(18,2) COMMENT 'Monetary value associated with the pixel event, if applicable. For purchase events, represents transaction amount. For other events, may represent estimated conversion value.',
    `gdpr_applies` BOOLEAN COMMENT 'Flag indicating whether GDPR regulations apply to this pixel event based on user location and consent framework signals.',
    `geographic_city` STRING COMMENT 'City where the pixel event originated, inferred from IP address geolocation.',
    `geographic_country` STRING COMMENT 'Country where the pixel event originated, inferred from IP address geolocation. Three-letter ISO country code.',
    `geographic_region` STRING COMMENT 'State, province, or region where the pixel event originated, inferred from IP address geolocation.',
    `hashed_email` STRING COMMENT 'One-way cryptographic hash of the users email address captured during pixel firing. Used for privacy-compliant audience matching and cross-device identity resolution.',
    `ip_address` STRING COMMENT 'Internet Protocol address of the device that fired the pixel. Used for geographic location inference and fraud detection. May be considered PII under GDPR.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the pixel event location, inferred from IP geolocation or device GPS when available.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the pixel event location, inferred from IP geolocation or device GPS when available.',
    `mobile_advertising_identifier` STRING COMMENT 'Mobile device advertising identifier (IDFA for iOS, AAID for Android) captured from mobile app or mobile web pixel firing. Used for mobile audience targeting and attribution.',
    `operating_system` STRING COMMENT 'Operating system of the device that fired the pixel event. Parsed from user agent string.',
    `operating_system_version` STRING COMMENT 'Version number of the operating system. Used for device profiling and technical segmentation.',
    `page_url` STRING COMMENT 'Canonical URL of the page where the event was captured. May differ from referring_url in redirect scenarios.',
    `postal_code` STRING COMMENT 'Postal or ZIP code where the pixel event originated, inferred from IP address geolocation. Used for hyper-local audience targeting.',
    `referring_url` STRING COMMENT 'Full URL of the web page where the pixel firing event occurred. Captures the context and content environment of the user interaction.',
    `session_identifier` STRING COMMENT 'Identifier for the user browsing session during which the pixel event occurred. Used to group events into session-based behavioral sequences.',
    `user_agent` STRING COMMENT 'Full user agent string captured from the HTTP request header at pixel firing time. Contains device, browser, and OS information in raw format.',
    `user_identifier` STRING COMMENT 'Captured identifier for the user who triggered the event. May be a cookie ID, Mobile Advertising ID (MAID), hashed email, or other first-party identifier depending on tracking method and consent.',
    CONSTRAINT pk_pixel_event PRIMARY KEY(`pixel_event_id`)
) COMMENT 'Transactional record of individual pixel firing events captured from deployed tracking tags — including event type (page view, add-to-cart, purchase, form submit, video view), event timestamp, identifier captured (cookie ID, MAID, hashed email), referring URL, device type, browser, geographic location, and associated pixel reference. Raw event stream that feeds first-party audience segment building and conversion attribution.';

CREATE OR REPLACE TABLE `advertising_ecm`.`audience`.`clean_room` (
    `clean_room_id` BIGINT COMMENT 'Unique identifier for the clean room collaboration instance.',
    `advertiser_id` BIGINT COMMENT 'Reference to the primary advertiser or brand client sponsoring or participating in this clean room collaboration.',
    `agreement_id` BIGINT COMMENT 'Reference to the legal contract, insertion order, or statement of work governing the terms, pricing, and obligations of this clean room collaboration.',
    `audience_segment_id` BIGINT COMMENT 'Reference identifier for the audience segment or data asset produced as output from this clean room collaboration, used for downstream activation.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Clean rooms enable privacy-safe data collaboration for brand measurement and audience building. Brand teams participate in clean room collaborations with publishers and platforms to measure brand lift',
    `budget_line_id` BIGINT COMMENT 'Foreign key linking to finance.budget_line. Business justification: Clean room collaborations (e.g., AWS Clean Rooms, Snowflake Data Clean Rooms) incur direct costs (query fees, platform fees) allocated to campaign budget lines. Finance tracks clean room spend for cos',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign associated with this clean room collaboration, used for campaign measurement and attribution analysis.',
    `insight_report_id` BIGINT COMMENT 'Foreign key linking to analytics.insight_report. Business justification: Clean room collaboration results (match rates, audience overlap, incremental reach, activation outcomes) are reported to clients. Reports justify clean room investment and inform collaboration strateg',
    `last_modified_by_user_worker_id` BIGINT COMMENT 'Identifier of the user or system account that performed the most recent modification to this clean room collaboration record.',
    `creative_asset_id` BIGINT COMMENT 'Foreign key linking to creative.creative_asset. Business justification: Clean rooms match audiences with creative exposure data; privacy-safe measurement collaborations require asset-level attribution to analyze which creative drove outcomes for matched audiences, essenti',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Clean room collaborations are complex multi-party projects requiring legal review, technical integration, and data governance setup. Agencies track which initiative governs clean room establishment fo',
    `plan_id` BIGINT COMMENT 'Foreign key linking to media.media_plan. Business justification: Clean room collaborations inform media planning with privacy-safe matched audience insights. Planners use clean room outputs to refine targeting strategies and validate audience reach assumptions for ',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Data clean room collaborations are typically scoped as discrete SOW engagements defining match methodology, output specifications, data governance rules, and deliverable timelines. Required for projec',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Clean room collaborations are hosted on vendor platforms (e.g., Snowflake, LiveRamp, Habu, InfoSum). Tracking the platform supplier is required for cost management, contract compliance, and vendor per',
    `worker_id` BIGINT COMMENT 'Identifier of the user or system account that initiated and created this clean room collaboration record.',
    `federated_clean_room_id` BIGINT COMMENT 'Self-referencing FK on clean_room (federated_clean_room_id)',
    `activation_permissions` STRING COMMENT 'Defined permissions and restrictions governing how the matched audience output can be used, activated, or exported by participating parties.. Valid values are `read only|activation allowed|measurement only|no export|full access`',
    `api_endpoint_url` STRING COMMENT 'API endpoint URL used to programmatically access, query, or manage this clean room collaboration and its data outputs.',
    `authentication_method` STRING COMMENT 'Security authentication mechanism used to verify identity and authorize access to the clean room platform and collaboration data.. Valid values are `OAuth 2.0|API key|SAML|JWT|mutual TLS|basic auth`',
    `ccpa_compliant_flag` BOOLEAN COMMENT 'Indicates whether this clean room collaboration meets CCPA requirements for consumer privacy rights, opt-out mechanisms, and data sale restrictions.',
    `collaboration_code` STRING COMMENT 'External reference code or identifier used to track this clean room collaboration across systems and with external partners.',
    `collaboration_cost_amount` DECIMAL(18,2) COMMENT 'Total cost or fee associated with this clean room collaboration, expressed in the specified currency.',
    `collaboration_end_date` DATE COMMENT 'Date when the clean room collaboration is scheduled to end or was terminated, after which data access and activation permissions expire.',
    `collaboration_name` STRING COMMENT 'Business-friendly name assigned to this clean room collaboration for identification and reporting purposes.',
    `collaboration_start_date` DATE COMMENT 'Date when the clean room collaboration became active and data matching or analysis began.',
    `collaboration_status` STRING COMMENT 'Current lifecycle state of the clean room collaboration indicating operational readiness and availability.. Valid values are `draft|pending approval|active|paused|completed|terminated`',
    `collaboration_type` STRING COMMENT 'Primary business purpose or use case for this clean room collaboration (e.g., audience enrichment, campaign measurement, attribution analysis). [ENUM-REF-CANDIDATE: audience enrichment|campaign measurement|attribution analysis|lookalike modeling|reach and frequency|overlap analysis|conversion lift|brand lift — promote to reference product]. Valid values are `audience enrichment|campaign measurement|attribution analysis|lookalike modeling|reach and frequency|overlap analysis`',
    `consent_framework_compliance` STRING COMMENT 'Privacy and consent framework(s) that this clean room collaboration adheres to, ensuring lawful data processing and user consent requirements are met.. Valid values are `GDPR|CCPA|TCF 2.0|LGPD|PIPEDA|not applicable`',
    `cost_model` STRING COMMENT 'Pricing structure applied to this clean room collaboration, defining how costs are calculated and billed to participating parties. [ENUM-REF-CANDIDATE: CPM|flat fee|per query|per match|subscription|revenue share|tiered pricing — promote to reference product]. Valid values are `CPM|flat fee|per query|per match|subscription|revenue share`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this clean room collaboration record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the currency used for financial transactions and cost reporting in this clean room collaboration.. Valid values are `^[A-Z]{3}$`',
    `data_governance_rules` STRING COMMENT 'Structured description or reference to the data usage policies, access controls, and governance framework applied within this clean room to ensure privacy compliance and data protection.',
    `data_retention_days` STRING COMMENT 'Number of days that matched audience data and collaboration outputs are retained within the clean room environment before automatic deletion or archival.',
    `data_volume_mb` DECIMAL(18,2) COMMENT 'Total volume of data processed or stored within this clean room collaboration, measured in megabytes, for capacity planning and cost allocation.',
    `encryption_standard` STRING COMMENT 'Cryptographic encryption standard applied to protect data at rest and in transit within the clean room environment.. Valid values are `AES-256|TLS 1.2|TLS 1.3|RSA-2048|not specified`',
    `gdpr_compliant_flag` BOOLEAN COMMENT 'Indicates whether this clean room collaboration meets GDPR requirements for lawful data processing, user consent, and data subject rights.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update or modification to this clean room collaboration record.',
    `last_query_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent query or data analysis operation performed within this clean room collaboration.',
    `match_methodology` STRING COMMENT 'Technical approach used to match and link audience identifiers across participating parties within the clean room environment. [ENUM-REF-CANDIDATE: hashed email|hashed phone|cookie sync|mobile ad ID|household ID|probabilistic|deterministic|CRM ID|universal ID — promote to reference product]',
    `match_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of records successfully matched between participating parties, indicating data overlap quality and collaboration effectiveness.',
    `matched_audience_count` BIGINT COMMENT 'Total number of unique audience members or identifiers successfully matched across all participating parties in the clean room.',
    `notes` STRING COMMENT 'Free-text field for additional context, operational notes, or business commentary related to this clean room collaboration.',
    `owning_team` STRING COMMENT 'Business team, department, or organizational unit responsible for managing and overseeing this clean room collaboration.',
    `participating_parties` STRING COMMENT 'Comma-separated list or structured representation of all organizations, advertisers, publishers, or data partners participating in this clean room collaboration.',
    `provider_platform` STRING COMMENT 'Technology platform or vendor providing the privacy-safe clean room environment for data collaboration. [ENUM-REF-CANDIDATE: InfoSum|Habu|LiveRamp|AWS Clean Rooms|Google Ads Data Hub|Snowflake Data Clean Room|Meta Advanced Analytics|The Trade Desk Data Alliance — promote to reference product]. Valid values are `InfoSum|Habu|LiveRamp|AWS Clean Rooms|Google Ads Data Hub|Snowflake Data Clean Room`',
    `query_count` STRING COMMENT 'Total number of queries or analysis requests executed within this clean room collaboration, used for usage tracking and billing purposes.',
    CONSTRAINT pk_clean_room PRIMARY KEY(`clean_room_id`)
) COMMENT 'Operational record for privacy-safe audience data collaboration environments — capturing clean room provider (InfoSum, Habu, LiveRamp, AWS Clean Rooms), participating parties, matched audience output, match methodology, data governance rules applied, activation permissions, collaboration start/end dates, and output segment references. Enables privacy-compliant second-party audience enrichment and measurement without raw data sharing.';

CREATE OR REPLACE TABLE `advertising_ecm`.`audience`.`holdout_group` (
    `holdout_group_id` BIGINT COMMENT 'Unique identifier for the holdout group. Primary key for the holdout group entity used in campaign measurement and incrementality testing.',
    `audience_segment_id` BIGINT COMMENT 'Reference to the parent audience segment from which this holdout group was derived. Establishes the source population for the test/control split.',
    `brand_lift_study_id` BIGINT COMMENT 'Foreign key linking to analytics.brand_lift_study. Business justification: Brand lift studies use holdout groups as unexposed control for lift measurement. The holdout group receives no ad exposure, enabling causal measurement of brand metric lift.',
    `brand_profile_id` BIGINT COMMENT 'Foreign key linking to brand.brand_profile. Business justification: Holdout groups measure incremental brand lift by comparing exposed vs. unexposed audiences. Brand managers need to track holdout tests to prove campaign effectiveness and justify media spend. Essentia',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign being measured through this holdout group. Links the group to the specific advertising initiative under test.',
    `experiment_incrementality_test_id` BIGINT COMMENT 'Reference to the parent experiment or test design that this holdout group belongs to. Links the group to the broader measurement framework.',
    `incrementality_test_id` BIGINT COMMENT 'Foreign key linking to analytics.incrementality_test. Business justification: Holdout groups are the control mechanism for incrementality tests measuring causal lift. The holdout defines the unexposed control group for treatment vs. control comparison.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Holdout group design and implementation is a project task within test-and-learn or measurement initiatives. Agencies track which initiative funded holdout setup for cost allocation and to manage analy',
    `worker_id` BIGINT COMMENT 'Identifier of the user or system account that created this holdout group record. Supports accountability and audit requirements.',
    `parent_holdout_group_id` BIGINT COMMENT 'Self-referencing FK on holdout_group (parent_holdout_group_id)',
    `activation_status` STRING COMMENT 'Current operational state of the holdout group. Active groups are in use for measurement, inactive groups are paused, pending groups await deployment, completed groups have finished their measurement period, archived groups are retained for historical analysis.. Valid values are `active|inactive|pending|completed|archived`',
    `ccpa_compliant_flag` BOOLEAN COMMENT 'Indicates whether the holdout group respects California Consumer Privacy Act opt-out rights and data sale restrictions for California residents.',
    `confidence_level` DECIMAL(18,2) COMMENT 'Target statistical confidence level for the experiment design, typically expressed as a percentage (e.g., 95.00 for 95% confidence). Determines the rigor of incrementality conclusions.',
    `consent_compliant_flag` BOOLEAN COMMENT 'Indicates whether all audience members in this holdout group have provided appropriate consent for inclusion in measurement activities under applicable privacy regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this holdout group record was first created in the system. Supports audit trail and data lineage tracking.',
    `data_retention_days` STRING COMMENT 'Number of days that holdout group membership data and associated measurement results will be retained before automatic deletion or anonymization per privacy policy.',
    `dsp_platform_name` STRING COMMENT 'Name of the Demand-Side Platform where this holdout group is activated for campaign suppression or exposure control. Examples include The Trade Desk, Google DV360, Amazon DSP.',
    `effective_end_date` DATE COMMENT 'Date when the holdout group measurement period concludes. Defines the endpoint for data collection and analysis. Nullable for ongoing tests.',
    `effective_start_date` DATE COMMENT 'Date when the holdout group becomes active for measurement purposes. Marks the beginning of the test period for incrementality analysis.',
    `estimated_reach` BIGINT COMMENT 'Projected number of unique individuals or households that this holdout group represents. May differ from group size due to identity resolution and cross-device considerations.',
    `gdpr_compliant_flag` BOOLEAN COMMENT 'Indicates whether the holdout group composition and processing comply with European Union General Data Protection Regulation requirements for lawful data processing.',
    `geographic_scope` STRING COMMENT 'Geographic boundaries or Designated Market Area (DMA) codes defining the spatial extent of this holdout group. Relevant for geo-based split methodologies.',
    `group_code` STRING COMMENT 'Short alphanumeric code used for system integration and external reference. Enables consistent identification across platforms.',
    `group_name` STRING COMMENT 'Human-readable name for the holdout group. Provides clear identification for reporting and analysis purposes.',
    `group_size` BIGINT COMMENT 'Total number of audience members or identifiers included in this holdout group. Represents the actual population count for statistical power calculations.',
    `group_type` STRING COMMENT 'Classification of the group role in the experiment. Exposed groups receive campaign exposure, holdout/control groups do not, test groups receive variant treatments, baseline groups represent standard conditions.. Valid values are `exposed|holdout|control|test|baseline`',
    `holdout_group_description` STRING COMMENT 'Detailed narrative description of the holdout group purpose, composition criteria, and measurement objectives. Provides context for analysts and stakeholders.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this holdout group record. Tracks changes to group configuration, status, or metadata over time.',
    `last_sync_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent synchronization of this holdout group to external platforms (DSP, DMP, measurement vendor). Indicates data freshness for activation.',
    `match_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of audience identifiers successfully matched and activated across target platforms. Indicates data quality and integration effectiveness for measurement.',
    `measurement_vendor` STRING COMMENT 'Third-party measurement provider responsible for incrementality analysis and reporting. Examples include Nielsen, Comscore, or specialized attribution vendors.',
    `minimum_detectable_effect` DECIMAL(18,2) COMMENT 'Smallest effect size that the experiment is powered to detect with statistical significance. Expressed as a percentage lift, guiding sample size requirements.',
    `notes` STRING COMMENT 'Free-form notes capturing operational details, special considerations, or issues encountered during holdout group setup and execution. Supports audit trail and knowledge transfer.',
    `owning_team` STRING COMMENT 'Name of the business team or organizational unit responsible for managing this holdout group and its associated measurement activities. Typically the analytics or insights team.',
    `platform_integration_status` STRING COMMENT 'Status of holdout group synchronization with Demand-Side Platforms (DSP), Data Management Platforms (DMP), or measurement platforms. Synced indicates successful deployment, pending indicates in-progress, failed indicates integration errors.. Valid values are `synced|pending|failed|not_applicable`',
    `randomization_seed` STRING COMMENT 'Seed value used for random assignment algorithm. Ensures reproducibility of the split methodology and enables audit verification of group assignments.',
    `split_methodology` STRING COMMENT 'Method used to divide the parent segment into test and control groups. Random ensures unbiased distribution, stratified maintains demographic balance, geographic uses location-based splits, behavioral uses engagement patterns, demographic uses audience attributes, matched pairs creates comparable groups.. Valid values are `random|stratified|geographic|behavioral|demographic|matched_pairs`',
    `split_percentage` DECIMAL(18,2) COMMENT 'Percentage of the parent segment allocated to this holdout group. Expressed as a decimal value between 0 and 100, enabling precise control group sizing for statistical validity.',
    `stratification_variables` STRING COMMENT 'Comma-separated list of demographic or behavioral attributes used for stratified sampling. Ensures balanced representation across key audience dimensions.',
    `creation_date` DATE COMMENT 'Date when the holdout group was initially created and defined. Establishes the baseline for measurement period tracking.',
    CONSTRAINT pk_holdout_group PRIMARY KEY(`holdout_group_id`)
) COMMENT 'Test/control audience group definition for campaign measurement and incrementality testing — capturing group name, group type (exposed/holdout/control), parent segment reference, split methodology (random, stratified, geographic), split percentage, group size, creation date, experiment reference, and activation status. Enables scientific measurement of advertising effectiveness through audience-level experimental design.';

CREATE OR REPLACE TABLE `advertising_ecm`.`audience`.`segment_activation` (
    `segment_activation_id` BIGINT COMMENT 'Unique identifier for this segment activation record. Primary key.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to the audience segment being activated in this insertion order',
    `contract_insertion_order_id` BIGINT COMMENT 'Foreign key linking to the insertion order authorizing this segment activation',
    `activation_end_date` DATE COMMENT 'Date when this specific segment stops being targeted within this insertion order. May differ from the IO flight_end_date if segments are phased out or rotated during the campaign. Segment-level flight control.',
    `activation_start_date` DATE COMMENT 'Date when this specific segment becomes active for targeting within this insertion order. May differ from the IO flight_start_date if segments are phased in during the campaign flight. Segment-level flight control.',
    `activation_status` STRING COMMENT 'Current operational status of this segment activation. active: segment is live and serving; paused: temporarily stopped; completed: activation period ended; cancelled: activation terminated before completion. Independent of both segment.status and io_status.',
    `allocated_budget` DECIMAL(18,2) COMMENT 'Portion of the insertion orders total_authorized_spend allocated to this segment. Used for budget pacing and segment-level ROI tracking. Sum of allocated_budget across all segments should not exceed the IOs total_authorized_spend.',
    `allocated_impressions` BIGINT COMMENT 'Number of impressions allocated to this segment within the insertion orders total committed impressions. Used for pacing and delivery forecasting. Sum of allocated_impressions across all segments should not exceed the IOs committed_impressions.',
    `bid_modifier` DECIMAL(18,2) COMMENT 'Multiplier applied to the base bid rate for this segment within this insertion order. Values >1.0 increase bids for high-value segments; values <1.0 decrease bids. Example: 1.25 means bid 25% higher for this segment. This is segment-specific bid optimization within the IOs rate structure.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this segment activation record was created in the system. Audit trail for activation setup.',
    `frequency_cap` STRING COMMENT 'Maximum number of impressions to serve to a single user within this segment for this insertion order during the frequency cap window. Prevents over-exposure and controls user experience. Enforced at the segment-IO level, independent of campaign-level frequency caps.',
    `frequency_cap_window_hours` STRING COMMENT 'Time window in hours over which the frequency cap is enforced. Example: frequency_cap=3 with window=24 means max 3 impressions per user per 24 hours for this segment-IO combination.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this segment activation. Audit trail for changes.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this segment activation record. Tracks changes to bid modifiers, frequency caps, or budget allocations.',
    `segment_priority` STRING COMMENT 'Priority ranking for this segment within the insertion order when multiple segments are activated. Lower numbers indicate higher priority for impression allocation and bid decisioning. Used by DSPs and ad servers to resolve conflicts when a user qualifies for multiple segments.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this segment activation. Audit trail for accountability.',
    CONSTRAINT pk_segment_activation PRIMARY KEY(`segment_activation_id`)
) COMMENT 'This association product represents the activation contract between an audience segment and an insertion order. It captures the operational configuration for how a specific segment is targeted within a specific IO flight, including bid adjustments, frequency controls, budget allocation, and flight timing. Each record links one segment to one insertion order with attributes that exist only in the context of this media activation relationship. This is the authoritative record for segment-level media buying parameters and performance tracking.. Existence Justification: In advertising operations, insertion orders routinely activate multiple audience segments simultaneously (demographic + behavioral + lookalike targeting), and high-value segments are reused across multiple insertion orders for different campaigns, flights, and media vendors. Each segment-IO pairing requires its own operational configuration including bid modifiers, frequency caps, impression allocations, budget splits, and segment-specific flight dates that cannot be stored on either the segment master record or the insertion order contract record.';

CREATE OR REPLACE TABLE `advertising_ecm`.`audience`.`segment_usage` (
    `segment_usage_id` BIGINT COMMENT 'Unique identifier for this segment usage record. Primary key.',
    `audience_segment_id` BIGINT COMMENT 'Foreign key linking to the audience segment being used in this initiative',
    `worker_id` BIGINT COMMENT 'Reference to the employee (audience strategist, media planner, or project manager) who created this segment usage assignment.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to the project initiative in which this segment is being used',
    `activation_status` STRING COMMENT 'Current activation state of this segment within the initiative: planned (not yet live), activated (currently targeting), paused (temporarily stopped), completed (initiative ended), cancelled (removed from initiative). Identified in detection phase as core relationship data.',
    `actual_spend` DECIMAL(18,2) COMMENT 'Actual media spend incurred targeting this segment within this initiative, in the initiatives currency. May differ from budget_allocated.',
    `budget_allocated` DECIMAL(18,2) COMMENT 'Portion of the initiative budget allocated specifically to targeting this segment, in the initiatives currency. Identified in detection phase as core relationship data.',
    `clicks_delivered` BIGINT COMMENT 'Total number of clicks generated from this segment within this initiative. Populated from ad server or DSP reporting.',
    `conversions_delivered` BIGINT COMMENT 'Total number of conversions attributed to this segment within this initiative. Populated from attribution platform.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment usage record was created in the system.',
    `impressions_delivered` BIGINT COMMENT 'Total number of ad impressions delivered to this segment within this initiative. Populated from ad server or DSP reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment usage record was last updated (e.g., status change, budget adjustment).',
    `priority_tier` STRING COMMENT 'Priority ranking of this segment within the initiative for budget allocation and optimization decisions. Tier 1 = highest priority. Identified in detection phase as core relationship data.',
    `segment_role` STRING COMMENT 'The tactical role this segment plays within the initiative: primary_target (main audience), secondary_target (additional reach), exclusion (negative targeting), lookalike_seed (modeling source), suppression (frequency cap), control_group, or test_group. Identified in detection phase as core relationship data.',
    `usage_end_date` DATE COMMENT 'Date when this segment usage ended or is planned to end for this initiative. Nullable if ongoing. Identified in detection phase as core relationship data.',
    `usage_start_date` DATE COMMENT 'Date when this segment was first activated or is planned to be activated for this initiative. Identified in detection phase as core relationship data.',
    CONSTRAINT pk_segment_usage PRIMARY KEY(`segment_usage_id`)
) COMMENT 'This association product represents the operational assignment and activation of audience segments within agency project initiatives. It captures which segments are targeted in which initiatives, the role each segment plays (primary target, exclusion list, lookalike seed, suppression), budget allocation per segment, activation timing, and performance tracking. Each record links one segment to one initiative with attributes that exist only in the context of this specific usage relationship. This is the SSOT for segment-level campaign planning, budget allocation, and activation orchestration across the agencys project portfolio.. Existence Justification: In advertising agency operations, initiatives routinely target multiple audience segments simultaneously (e.g., a brand awareness campaign targeting High-Income Millennials, Urban Parents, and Tech Early Adopters), and individual segments are reused across multiple initiatives over time (e.g., the High-Value Customers segment used in retention, upsell, cross-sell, and win-back initiatives). Agencies actively manage these segment-initiative assignments as operational records, tracking which segments are used in which initiatives, the tactical role each segment plays (primary target vs. exclusion vs. lookalike seed), budget allocated per segment, activation dates, and performance metrics (impressions, clicks, conversions) at the segment-initiative level.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ADD CONSTRAINT `fk_audience_audience_segment_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `advertising_ecm`.`audience`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ADD CONSTRAINT `fk_audience_audience_segment_third_party_feed_id` FOREIGN KEY (`third_party_feed_id`) REFERENCES `advertising_ecm`.`audience`.`third_party_feed`(`third_party_feed_id`);
ALTER TABLE `advertising_ecm`.`audience`.`persona` ADD CONSTRAINT `fk_audience_persona_behavioral_profile_id` FOREIGN KEY (`behavioral_profile_id`) REFERENCES `advertising_ecm`.`audience`.`behavioral_profile`(`behavioral_profile_id`);
ALTER TABLE `advertising_ecm`.`audience`.`persona` ADD CONSTRAINT `fk_audience_persona_demographic_profile_id` FOREIGN KEY (`demographic_profile_id`) REFERENCES `advertising_ecm`.`audience`.`demographic_profile`(`demographic_profile_id`);
ALTER TABLE `advertising_ecm`.`audience`.`persona` ADD CONSTRAINT `fk_audience_persona_psychographic_profile_id` FOREIGN KEY (`psychographic_profile_id`) REFERENCES `advertising_ecm`.`audience`.`psychographic_profile`(`psychographic_profile_id`);
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ADD CONSTRAINT `fk_audience_demographic_profile_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ADD CONSTRAINT `fk_audience_demographic_profile_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `advertising_ecm`.`audience`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ADD CONSTRAINT `fk_audience_demographic_profile_third_party_feed_id` FOREIGN KEY (`third_party_feed_id`) REFERENCES `advertising_ecm`.`audience`.`third_party_feed`(`third_party_feed_id`);
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ADD CONSTRAINT `fk_audience_behavioral_profile_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ADD CONSTRAINT `fk_audience_behavioral_profile_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `advertising_ecm`.`audience`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ADD CONSTRAINT `fk_audience_behavioral_profile_tertiary_behavioral_lookalike_seed_segment_audience_segment_id` FOREIGN KEY (`tertiary_behavioral_lookalike_seed_segment_audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ADD CONSTRAINT `fk_audience_behavioral_profile_third_party_feed_id` FOREIGN KEY (`third_party_feed_id`) REFERENCES `advertising_ecm`.`audience`.`third_party_feed`(`third_party_feed_id`);
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ADD CONSTRAINT `fk_audience_psychographic_profile_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ADD CONSTRAINT `fk_audience_psychographic_profile_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `advertising_ecm`.`audience`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ADD CONSTRAINT `fk_audience_psychographic_profile_third_party_feed_id` FOREIGN KEY (`third_party_feed_id`) REFERENCES `advertising_ecm`.`audience`.`third_party_feed`(`third_party_feed_id`);
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ADD CONSTRAINT `fk_audience_segment_membership_audience_consent_record_id` FOREIGN KEY (`audience_consent_record_id`) REFERENCES `advertising_ecm`.`audience`.`audience_consent_record`(`audience_consent_record_id`);
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ADD CONSTRAINT `fk_audience_segment_membership_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ADD CONSTRAINT `fk_audience_segment_membership_third_party_feed_id` FOREIGN KEY (`third_party_feed_id`) REFERENCES `advertising_ecm`.`audience`.`third_party_feed`(`third_party_feed_id`);
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ADD CONSTRAINT `fk_audience_identity_graph_third_party_feed_id` FOREIGN KEY (`third_party_feed_id`) REFERENCES `advertising_ecm`.`audience`.`third_party_feed`(`third_party_feed_id`);
ALTER TABLE `advertising_ecm`.`audience`.`activation` ADD CONSTRAINT `fk_audience_activation_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`audience`.`activation` ADD CONSTRAINT `fk_audience_activation_dmp_integration_id` FOREIGN KEY (`dmp_integration_id`) REFERENCES `advertising_ecm`.`audience`.`dmp_integration`(`dmp_integration_id`);
ALTER TABLE `advertising_ecm`.`audience`.`activation` ADD CONSTRAINT `fk_audience_activation_platform_audience_audience_segment_id` FOREIGN KEY (`platform_audience_audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`audience`.`activation` ADD CONSTRAINT `fk_audience_activation_platform_integration_id` FOREIGN KEY (`platform_integration_id`) REFERENCES `advertising_ecm`.`audience`.`dmp_integration`(`dmp_integration_id`);
ALTER TABLE `advertising_ecm`.`audience`.`activation` ADD CONSTRAINT `fk_audience_activation_suppression_list_id` FOREIGN KEY (`suppression_list_id`) REFERENCES `advertising_ecm`.`audience`.`suppression_list`(`suppression_list_id`);
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ADD CONSTRAINT `fk_audience_third_party_feed_dmp_integration_id` FOREIGN KEY (`dmp_integration_id`) REFERENCES `advertising_ecm`.`audience`.`dmp_integration`(`dmp_integration_id`);
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ADD CONSTRAINT `fk_audience_lookalike_model_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ADD CONSTRAINT `fk_audience_suppression_list_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ADD CONSTRAINT `fk_audience_taxonomy_parent_taxonomy_id` FOREIGN KEY (`parent_taxonomy_id`) REFERENCES `advertising_ecm`.`audience`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ADD CONSTRAINT `fk_audience_taxonomy_primary_replacement_taxonomy_id` FOREIGN KEY (`primary_replacement_taxonomy_id`) REFERENCES `advertising_ecm`.`audience`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ADD CONSTRAINT `fk_audience_pixel_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ADD CONSTRAINT `fk_audience_pixel_event_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ADD CONSTRAINT `fk_audience_pixel_event_pixel_id` FOREIGN KEY (`pixel_id`) REFERENCES `advertising_ecm`.`audience`.`pixel`(`pixel_id`);
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ADD CONSTRAINT `fk_audience_clean_room_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ADD CONSTRAINT `fk_audience_clean_room_federated_clean_room_id` FOREIGN KEY (`federated_clean_room_id`) REFERENCES `advertising_ecm`.`audience`.`clean_room`(`clean_room_id`);
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ADD CONSTRAINT `fk_audience_holdout_group_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ADD CONSTRAINT `fk_audience_holdout_group_parent_holdout_group_id` FOREIGN KEY (`parent_holdout_group_id`) REFERENCES `advertising_ecm`.`audience`.`holdout_group`(`holdout_group_id`);
ALTER TABLE `advertising_ecm`.`audience`.`segment_activation` ADD CONSTRAINT `fk_audience_segment_activation_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);
ALTER TABLE `advertising_ecm`.`audience`.`segment_usage` ADD CONSTRAINT `fk_audience_segment_usage_audience_segment_id` FOREIGN KEY (`audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`audience_segment`(`audience_segment_id`);

-- ========= TAGS =========
ALTER SCHEMA `advertising_ecm`.`audience` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `advertising_ecm`.`audience` SET TAGS ('dbx_domain' = 'audience');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` SET TAGS ('dbx_subdomain' = 'segment_management');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Worker Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Master Agreement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Taxonomy Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `third_party_feed_id` SET TAGS ('dbx_business_glossary_term' = 'Third Party Feed Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `activation_status` SET TAGS ('dbx_business_glossary_term' = 'Activation Status');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `activation_status` SET TAGS ('dbx_value_regex' = 'activated|not_activated|pending_activation');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `age_band_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Age Band');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `age_band_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Band');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `app_usage_flag` SET TAGS ('dbx_business_glossary_term' = 'App Usage Flag');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `audience_segment_description` SET TAGS ('dbx_business_glossary_term' = 'Segment Description');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `audience_segment_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Name');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `audience_segment_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Status');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `audience_segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived|expired');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `audience_segment_type` SET TAGS ('dbx_business_glossary_term' = 'Segment Type');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `audience_segment_type` SET TAGS ('dbx_value_regex' = 'behavioral|demographic|psychographic|contextual|lookalike|geographic');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `brand_affinity_list` SET TAGS ('dbx_business_glossary_term' = 'Brand Affinity List');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `browsing_categories` SET TAGS ('dbx_business_glossary_term' = 'Browsing Categories');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `ccpa_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Compliant Flag');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'consented|not_consented|pending|withdrawn');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `content_consumption_topics` SET TAGS ('dbx_business_glossary_term' = 'Content Consumption Topics');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `creation_method` SET TAGS ('dbx_business_glossary_term' = 'Segment Creation Method');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `creation_method` SET TAGS ('dbx_value_regex' = 'rules_based|ml_modeled|imported|survey_derived|manual');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `cross_device_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Device Flag');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `data_source_tier` SET TAGS ('dbx_business_glossary_term' = 'Data Source Tier');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `data_source_tier` SET TAGS ('dbx_value_regex' = 'first_party|second_party|third_party');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `dma_codes` SET TAGS ('dbx_business_glossary_term' = 'Designated Market Area (DMA) Codes');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `education_level` SET TAGS ('dbx_business_glossary_term' = 'Education Level');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `external_code` SET TAGS ('dbx_business_glossary_term' = 'External Segment Code');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `gdpr_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliant Flag');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|all|unknown');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `income_tier` SET TAGS ('dbx_business_glossary_term' = 'Income Tier');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `interest_taxonomy` SET TAGS ('dbx_business_glossary_term' = 'Interest Taxonomy');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `lifestyle_segment` SET TAGS ('dbx_business_glossary_term' = 'Lifestyle Segment');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `marital_status` SET TAGS ('dbx_business_glossary_term' = 'Marital Status');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `marital_status` SET TAGS ('dbx_value_regex' = 'single|married|divorced|widowed|all|unknown');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `marital_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `marital_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Team');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `parental_status` SET TAGS ('dbx_business_glossary_term' = 'Parental Status');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `parental_status` SET TAGS ('dbx_value_regex' = 'parent|non_parent|all|unknown');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `purchase_history_flag` SET TAGS ('dbx_business_glossary_term' = 'Purchase History Flag');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `refresh_cadence` SET TAGS ('dbx_business_glossary_term' = 'Refresh Cadence');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `refresh_cadence` SET TAGS ('dbx_value_regex' = 'real_time|hourly|daily|weekly|monthly|static');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `rfm_score` SET TAGS ('dbx_business_glossary_term' = 'Recency Frequency Monetary (RFM) Score');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `search_intent_keywords` SET TAGS ('dbx_business_glossary_term' = 'Search Intent Keywords');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `size` SET TAGS ('dbx_business_glossary_term' = 'Segment Size');
ALTER TABLE `advertising_ecm`.`audience`.`audience_segment` ALTER COLUMN `vals_segment` SET TAGS ('dbx_business_glossary_term' = 'Values and Lifestyles (VALS) Segment');
ALTER TABLE `advertising_ecm`.`audience`.`persona` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`audience`.`persona` SET TAGS ('dbx_subdomain' = 'segment_management');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `persona_id` SET TAGS ('dbx_business_glossary_term' = 'Persona Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `behavioral_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Behavioral Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Worker Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `demographic_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `psychographic_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Psychographic Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `ccpa_opt_out_eligible` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Opt-Out Eligible');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `cdp_audience_key` SET TAGS ('dbx_business_glossary_term' = 'Customer Data Platform (CDP) Audience Key');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `cltv_estimate` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifetime Value (CLTV) Estimate');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `consent_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Compliant Flag');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `content_preferences` SET TAGS ('dbx_business_glossary_term' = 'Content Preferences');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `conversion_propensity` SET TAGS ('dbx_business_glossary_term' = 'Conversion Propensity');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `data_source_type` SET TAGS ('dbx_business_glossary_term' = 'Data Source Type');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `data_source_type` SET TAGS ('dbx_value_regex' = 'first_party|second_party|third_party|synthesized');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `dmp_segment_ids` SET TAGS ('dbx_business_glossary_term' = 'Data Management Platform (DMP) Segment Identifiers (IDs)');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `estimated_reach` SET TAGS ('dbx_business_glossary_term' = 'Estimated Reach');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `gdpr_lawful_basis` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Lawful Basis');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `gdpr_lawful_basis` SET TAGS ('dbx_value_regex' = 'consent|legitimate_interest|contract|legal_obligation|not_applicable');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `last_validated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Validated Date');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `narrative_description` SET TAGS ('dbx_business_glossary_term' = 'Narrative Description');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Team');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `pain_points` SET TAGS ('dbx_business_glossary_term' = 'Pain Points');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `persona_code` SET TAGS ('dbx_business_glossary_term' = 'Persona Code');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `persona_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `persona_name` SET TAGS ('dbx_business_glossary_term' = 'Persona Name');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `persona_status` SET TAGS ('dbx_business_glossary_term' = 'Persona Status');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `persona_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived|under_review');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `preferred_channels` SET TAGS ('dbx_business_glossary_term' = 'Preferred Channels');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `social_media_platforms` SET TAGS ('dbx_business_glossary_term' = 'Social Media Platforms');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` SET TAGS ('dbx_subdomain' = 'segment_management');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `demographic_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Profile Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Data Management Platform (DMP) Segment Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Taxonomy Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `third_party_feed_id` SET TAGS ('dbx_business_glossary_term' = 'Third Party Feed Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `age_band` SET TAGS ('dbx_business_glossary_term' = 'Age Band');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `age_band` SET TAGS ('dbx_value_regex' = '18-24|25-34|35-44|45-54|55-64|65+');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `children_age_range` SET TAGS ('dbx_business_glossary_term' = 'Children Age Range');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `consent_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiration Date');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'consented|not_consented|pending|withdrawn');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `dma_code` SET TAGS ('dbx_business_glossary_term' = 'Designated Market Area (DMA) Code');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `dma_name` SET TAGS ('dbx_business_glossary_term' = 'Designated Market Area (DMA) Name');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `education_level` SET TAGS ('dbx_business_glossary_term' = 'Education Level');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `education_level` SET TAGS ('dbx_value_regex' = 'high_school|some_college|bachelors|masters|doctorate|other');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `employment_category` SET TAGS ('dbx_business_glossary_term' = 'Employment Category');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `estimated_population_size` SET TAGS ('dbx_business_glossary_term' = 'Estimated Population Size');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Ethnicity');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `ethnicity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|non-binary|undisclosed');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `geographic_region` SET TAGS ('dbx_value_regex' = 'northeast|southeast|midwest|southwest|west|other');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `homeownership_status` SET TAGS ('dbx_business_glossary_term' = 'Homeownership Status');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `homeownership_status` SET TAGS ('dbx_value_regex' = 'owner|renter|undisclosed');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `household_income_tier` SET TAGS ('dbx_business_glossary_term' = 'Household Income Tier');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `household_income_tier` SET TAGS ('dbx_value_regex' = 'under_25k|25k_50k|50k_75k|75k_100k|100k_150k|over_150k');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `household_income_tier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `household_size` SET TAGS ('dbx_business_glossary_term' = 'Household Size');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `marital_status` SET TAGS ('dbx_business_glossary_term' = 'Marital Status');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `marital_status` SET TAGS ('dbx_value_regex' = 'single|married|divorced|widowed|undisclosed');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `marital_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `marital_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `occupation_category` SET TAGS ('dbx_business_glossary_term' = 'Occupation Category');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `parental_status` SET TAGS ('dbx_business_glossary_term' = 'Parental Status');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `parental_status` SET TAGS ('dbx_value_regex' = 'parent|non_parent|undisclosed');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Language');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_business_glossary_term' = 'Demographic Profile Code');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `profile_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Profile Confidence Score');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `profile_description` SET TAGS ('dbx_business_glossary_term' = 'Profile Description');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_business_glossary_term' = 'Demographic Profile Name');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Profile Status');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|pending_review');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `psychographic_segment` SET TAGS ('dbx_business_glossary_term' = 'Psychographic Segment');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `urbanicity` SET TAGS ('dbx_business_glossary_term' = 'Urbanicity');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `urbanicity` SET TAGS ('dbx_value_regex' = 'urban|suburban|rural');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `vehicle_ownership` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Ownership');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `vehicle_ownership` SET TAGS ('dbx_value_regex' = 'owns_vehicle|no_vehicle|undisclosed');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` SET TAGS ('dbx_subdomain' = 'segment_management');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `behavioral_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Behavioral Profile ID');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment ID');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Taxonomy Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `tertiary_behavioral_lookalike_seed_segment_audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Lookalike Seed Segment ID');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `third_party_feed_id` SET TAGS ('dbx_business_glossary_term' = 'Third Party Feed Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `app_usage_pattern` SET TAGS ('dbx_business_glossary_term' = 'App Usage Pattern');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `brand_affinity_category` SET TAGS ('dbx_business_glossary_term' = 'Brand Affinity Category');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `browsing_category_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Browsing Category');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `browsing_category_secondary` SET TAGS ('dbx_business_glossary_term' = 'Secondary Browsing Category');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|denied|pending|withdrawn|not_required');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `content_consumption_category` SET TAGS ('dbx_business_glossary_term' = 'Content Consumption Category');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `cross_device_activity_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Device Activity Flag');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `data_retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Expiry Date');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `data_source_description` SET TAGS ('dbx_business_glossary_term' = 'Data Source Description');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `day_of_week_preference` SET TAGS ('dbx_business_glossary_term' = 'Day of Week Preference');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `day_of_week_preference` SET TAGS ('dbx_value_regex' = 'weekday|weekend|mixed');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `device_type_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Device Type');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `device_type_primary` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|ctv|ott|unknown');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `engagement_level` SET TAGS ('dbx_business_glossary_term' = 'Engagement Level');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `engagement_level` SET TAGS ('dbx_value_regex' = 'very_high|high|medium|low|very_low');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `frequency_score` SET TAGS ('dbx_business_glossary_term' = 'Frequency Score');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `geographic_behavior_pattern` SET TAGS ('dbx_business_glossary_term' = 'Geographic Behavior Pattern');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `last_observed_behavior_date` SET TAGS ('dbx_business_glossary_term' = 'Last Observed Behavior Date');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `lookalike_similarity_score` SET TAGS ('dbx_business_glossary_term' = 'Lookalike Similarity Score');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `monetary_score` SET TAGS ('dbx_business_glossary_term' = 'Monetary Score');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Profile Notes');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `privacy_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Privacy Jurisdiction');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `profile_creation_date` SET TAGS ('dbx_business_glossary_term' = 'Profile Creation Date');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `profile_last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Last Updated Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_business_glossary_term' = 'Behavioral Profile Name');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `profile_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Profile Quality Score');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `profile_reach_estimate` SET TAGS ('dbx_business_glossary_term' = 'Profile Reach Estimate');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Behavioral Profile Status');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|pending_review|deprecated');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `profile_type` SET TAGS ('dbx_business_glossary_term' = 'Behavioral Profile Type');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `profile_type` SET TAGS ('dbx_value_regex' = 'first_party|second_party|third_party|modeled|lookalike');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `purchase_intent_signal` SET TAGS ('dbx_business_glossary_term' = 'Purchase Intent Signal');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `purchase_intent_signal` SET TAGS ('dbx_value_regex' = 'high|medium|low|none');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `recency_score` SET TAGS ('dbx_business_glossary_term' = 'Recency Score');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `search_intent_keywords` SET TAGS ('dbx_business_glossary_term' = 'Search Intent Keywords');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `seasonal_behavior_pattern` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Behavior Pattern');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `targeting_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Targeting Eligibility Flag');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `time_of_day_preference` SET TAGS ('dbx_business_glossary_term' = 'Time of Day Preference');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `time_of_day_preference` SET TAGS ('dbx_value_regex' = 'morning|afternoon|evening|night|mixed');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` SET TAGS ('dbx_subdomain' = 'segment_management');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `psychographic_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Psychographic Profile ID');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment ID');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Taxonomy Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `third_party_feed_id` SET TAGS ('dbx_business_glossary_term' = 'Third Party Feed Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `brand_affinity_tier` SET TAGS ('dbx_business_glossary_term' = 'Brand Affinity Tier');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `brand_affinity_tier` SET TAGS ('dbx_value_regex' = 'luxury|premium|mid_market|value|discount|unbranded');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `brand_loyalty_score` SET TAGS ('dbx_business_glossary_term' = 'Brand Loyalty Score');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `consent_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Compliant Flag');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `cultural_orientation` SET TAGS ('dbx_business_glossary_term' = 'Cultural Orientation');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `cultural_orientation` SET TAGS ('dbx_value_regex' = 'individualist|collectivist|traditional|progressive|multicultural|cosmopolitan');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `digital_engagement_level` SET TAGS ('dbx_business_glossary_term' = 'Digital Engagement Level');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `digital_engagement_level` SET TAGS ('dbx_value_regex' = 'very_high|high|moderate|low|very_low');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `environmental_consciousness_score` SET TAGS ('dbx_business_glossary_term' = 'Environmental Consciousness Score');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'global|regional|national|local|dma|metro');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `innovation_adoption_index` SET TAGS ('dbx_business_glossary_term' = 'Innovation Adoption Index');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `last_refresh_date` SET TAGS ('dbx_business_glossary_term' = 'Last Refresh Date');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `lifestyle_category` SET TAGS ('dbx_business_glossary_term' = 'Lifestyle Category');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `media_consumption_attitude` SET TAGS ('dbx_business_glossary_term' = 'Media Consumption Attitude');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `media_consumption_attitude` SET TAGS ('dbx_value_regex' = 'early_adopter|mainstream|late_adopter|traditional|skeptical|enthusiast');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `opinion_leader_indicator` SET TAGS ('dbx_business_glossary_term' = 'Opinion Leader Indicator');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `personality_archetype` SET TAGS ('dbx_business_glossary_term' = 'Personality Archetype');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `price_sensitivity_index` SET TAGS ('dbx_business_glossary_term' = 'Price Sensitivity Index');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `primary_interest_category` SET TAGS ('dbx_business_glossary_term' = 'Primary Interest Category');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `privacy_classification` SET TAGS ('dbx_business_glossary_term' = 'Privacy Classification');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `privacy_classification` SET TAGS ('dbx_value_regex' = 'first_party|second_party|third_party|anonymous|pseudonymous');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_business_glossary_term' = 'Profile Code');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `profile_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Profile Confidence Score');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `profile_description` SET TAGS ('dbx_business_glossary_term' = 'Profile Description');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_business_glossary_term' = 'Profile Name');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Profile Status');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|under_review|draft');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `purchase_motivation_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Purchase Motivation');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `purchase_motivation_secondary` SET TAGS ('dbx_business_glossary_term' = 'Secondary Purchase Motivation');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `risk_tolerance_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Tolerance Level');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `risk_tolerance_level` SET TAGS ('dbx_value_regex' = 'very_high|high|moderate|low|very_low');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `secondary_interest_category` SET TAGS ('dbx_business_glossary_term' = 'Secondary Interest Category');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `social_media_activity_score` SET TAGS ('dbx_business_glossary_term' = 'Social Media Activity Score');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `usage_restriction_notes` SET TAGS ('dbx_business_glossary_term' = 'Usage Restriction Notes');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `vals_framework_segment` SET TAGS ('dbx_business_glossary_term' = 'Values Attitudes and Lifestyles (VALS) Framework Segment');
ALTER TABLE `advertising_ecm`.`audience`.`psychographic_profile` ALTER COLUMN `values_orientation` SET TAGS ('dbx_business_glossary_term' = 'Values Orientation');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` SET TAGS ('dbx_subdomain' = 'segment_management');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `segment_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `audience_consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Consent Record Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `third_party_feed_id` SET TAGS ('dbx_business_glossary_term' = 'Data Provider Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `activation_status` SET TAGS ('dbx_business_glossary_term' = 'Activation Status');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `activation_status` SET TAGS ('dbx_value_regex' = 'activated|pending|failed|deactivated');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activation Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `audience_identifier` SET TAGS ('dbx_business_glossary_term' = 'Audience Identifier');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `audience_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `audience_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `cost_per_member` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Member (CPM)');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `cost_per_member` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|ctv|ott|other');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `dsp_platform` SET TAGS ('dbx_business_glossary_term' = 'Demand-Side Platform (DSP) Platform');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `frequency_cap` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `identifier_type` SET TAGS ('dbx_business_glossary_term' = 'Identifier Type');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `identifier_type` SET TAGS ('dbx_value_regex' = 'cookie_id|device_id|maid|hashed_email|customer_id|household_id');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Flag');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `last_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Refresh Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `match_rate` SET TAGS ('dbx_business_glossary_term' = 'Match Rate');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `membership_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Expiry Date');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `membership_source` SET TAGS ('dbx_business_glossary_term' = 'Membership Source');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `membership_start_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Start Date');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_value_regex' = 'active|expired|excluded|pending|suppressed');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `recency_days` SET TAGS ('dbx_business_glossary_term' = 'Recency Days');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `segment_priority` SET TAGS ('dbx_business_glossary_term' = 'Segment Priority');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` SET TAGS ('dbx_subdomain' = 'identity_resolution');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `audience_consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Consent Record Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `audience_identifier` SET TAGS ('dbx_business_glossary_term' = 'Audience Identifier');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `audience_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `audience_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `cdp_profile_sync_enabled` SET TAGS ('dbx_business_glossary_term' = 'Customer Data Platform (CDP) Profile Sync Enabled');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `consent_channel` SET TAGS ('dbx_business_glossary_term' = 'Consent Channel');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `consent_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiry Date');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `consent_language` SET TAGS ('dbx_business_glossary_term' = 'Consent Language');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `consent_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Method');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_value_regex' = 'explicit_opt_in|implicit_opt_in|opt_out|pre_checked|granular_choice|bundled');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `consent_notice_url` SET TAGS ('dbx_business_glossary_term' = 'Consent Notice Uniform Resource Locator (URL)');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `consent_notice_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Notice Version');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `consent_proof_document_url` SET TAGS ('dbx_business_glossary_term' = 'Consent Proof Document Uniform Resource Locator (URL)');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `consent_scope_analytics` SET TAGS ('dbx_business_glossary_term' = 'Consent Scope - Analytics');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `consent_scope_data_sharing` SET TAGS ('dbx_business_glossary_term' = 'Consent Scope - Data Sharing');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `consent_scope_personalization` SET TAGS ('dbx_business_glossary_term' = 'Consent Scope - Personalization');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `consent_scope_targeting` SET TAGS ('dbx_business_glossary_term' = 'Consent Scope - Targeting');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `consent_source` SET TAGS ('dbx_business_glossary_term' = 'Consent Source');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `consent_source_system` SET TAGS ('dbx_business_glossary_term' = 'Consent Source System');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|denied|withdrawn|expired|pending|not_required');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `dmp_segment_sync_enabled` SET TAGS ('dbx_business_glossary_term' = 'Data Management Platform (DMP) Segment Sync Enabled');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `do_not_sell_flag` SET TAGS ('dbx_business_glossary_term' = 'Do Not Sell Flag');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `global_privacy_control_signal` SET TAGS ('dbx_business_glossary_term' = 'Global Privacy Control (GPC) Signal');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `identifier_type` SET TAGS ('dbx_business_glossary_term' = 'Identifier Type');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `identifier_type` SET TAGS ('dbx_value_regex' = 'email_hash|device_id|cookie_id|customer_id|mobile_ad_id|crm_id');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `is_minor` SET TAGS ('dbx_business_glossary_term' = 'Is Minor');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `jurisdiction_country_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Code');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `jurisdiction_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `last_verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `parental_consent_required` SET TAGS ('dbx_business_glossary_term' = 'Parental Consent Required');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `parental_consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Parental Consent Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `tcf_consent_string` SET TAGS ('dbx_business_glossary_term' = 'Transparency and Consent Framework (TCF) Consent String');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `third_party_sharing_enabled` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Sharing Enabled');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `advertising_ecm`.`audience`.`audience_consent_record` ALTER COLUMN `withdrawal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` SET TAGS ('dbx_subdomain' = 'identity_resolution');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `identity_graph_id` SET TAGS ('dbx_business_glossary_term' = 'Identity Graph ID');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `third_party_feed_id` SET TAGS ('dbx_business_glossary_term' = 'Third Party Feed Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `browser` SET TAGS ('dbx_business_glossary_term' = 'Browser');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'User Consent Status');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|denied|withdrawn|not_required|pending');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `cookie_identifier` SET TAGS ('dbx_business_glossary_term' = 'Cookie ID');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `cookie_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `cookie_identifier` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `crm_identifier` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) ID');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `crm_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `crm_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `ctv_device_identifier` SET TAGS ('dbx_business_glossary_term' = 'Connected TV (CTV) Device ID');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `ctv_device_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `ctv_device_identifier` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `first_seen_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Seen Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `geographic_country_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Country Code');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `geographic_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `geographic_dma_code` SET TAGS ('dbx_business_glossary_term' = 'Designated Market Area (DMA) Code');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `hashed_email` SET TAGS ('dbx_business_glossary_term' = 'Hashed Email Address (SHA-256)');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `hashed_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `hashed_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `household_identifier` SET TAGS ('dbx_business_glossary_term' = 'Household ID');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `household_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `household_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `identity_graph_status` SET TAGS ('dbx_business_glossary_term' = 'Identity Link Status');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `identity_graph_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|suppressed|pending_verification|revoked');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `identity_provider_version` SET TAGS ('dbx_business_glossary_term' = 'Identity Provider Version');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `last_seen_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Seen Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `link_creation_date` SET TAGS ('dbx_business_glossary_term' = 'Link Creation Date');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `link_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Link Expiration Date');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `link_last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Link Last Verified Date');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `match_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Match Confidence Score');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `match_method` SET TAGS ('dbx_business_glossary_term' = 'Identity Match Method');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `match_method` SET TAGS ('dbx_value_regex' = 'deterministic|probabilistic|hybrid');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `mobile_advertising_identifier` SET TAGS ('dbx_business_glossary_term' = 'Mobile Advertising ID (MAID)');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `mobile_advertising_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `mobile_advertising_identifier` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Identity Graph Notes');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Flag');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `opt_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `privacy_framework` SET TAGS ('dbx_business_glossary_term' = 'Privacy Framework');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `total_linked_identifiers` SET TAGS ('dbx_business_glossary_term' = 'Total Linked Identifiers');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `unified_person_code` SET TAGS ('dbx_business_glossary_term' = 'Unified Person ID');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `unified_person_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `unified_person_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`identity_graph` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Identity Graph Version');
ALTER TABLE `advertising_ecm`.`audience`.`activation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`audience`.`activation` SET TAGS ('dbx_subdomain' = 'platform_activation');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `activation_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Activation ID');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment ID');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `creative_deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Deliverable Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `dmp_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Dmp Integration Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `platform_audience_audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Audience ID');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `platform_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Integration ID');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `suppression_list_id` SET TAGS ('dbx_business_glossary_term' = 'Suppression List Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Activated By User ID');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `activation_method` SET TAGS ('dbx_business_glossary_term' = 'Activation Method');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `activation_method` SET TAGS ('dbx_value_regex' = 'API|S2S|Pixel|File Upload|Manual');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `activation_name` SET TAGS ('dbx_business_glossary_term' = 'Activation Name');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `activation_status` SET TAGS ('dbx_business_glossary_term' = 'Activation Status');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `activation_status` SET TAGS ('dbx_value_regex' = 'Pending|Active|Paused|Expired|Failed|Cancelled');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activation Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `activation_type` SET TAGS ('dbx_business_glossary_term' = 'Activation Type');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `activation_type` SET TAGS ('dbx_value_regex' = 'Standard|Lookalike|Suppression|Retargeting|Prospecting');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `bid_modifier` SET TAGS ('dbx_business_glossary_term' = 'Bid Modifier');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `consent_framework` SET TAGS ('dbx_business_glossary_term' = 'Consent Framework');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `consent_framework` SET TAGS ('dbx_value_regex' = 'IAB TCF 2.0|CCPA|GDPR|Custom');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'Verified|Pending|Expired|Revoked');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `cost_cpm` SET TAGS ('dbx_business_glossary_term' = 'Activation Cost CPM (Cost Per Mille)');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `cost_cpm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Activation Currency Code');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `data_source_type` SET TAGS ('dbx_business_glossary_term' = 'Data Source Type');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `data_source_type` SET TAGS ('dbx_value_regex' = 'First-Party|Second-Party|Third-Party');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `estimated_reach` SET TAGS ('dbx_business_glossary_term' = 'Estimated Reach');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `frequency_cap` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `frequency_cap_window_hours` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Window Hours');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `last_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Sync Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `match_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Match Rate Percentage');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `matched_user_count` SET TAGS ('dbx_business_glossary_term' = 'Matched User Count');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `next_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Sync Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Activation Notes');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'High|Medium|Low');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `sync_frequency` SET TAGS ('dbx_business_glossary_term' = 'Sync Frequency');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `sync_frequency` SET TAGS ('dbx_value_regex' = 'Real-Time|Hourly|Daily|Weekly|On-Demand');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `unmatched_user_count` SET TAGS ('dbx_business_glossary_term' = 'Unmatched User Count');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` SET TAGS ('dbx_subdomain' = 'platform_activation');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `third_party_feed_id` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Feed ID');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `dmp_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Dmp Integration Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Integration Owner Worker Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activated Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `api_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Endpoint Uniform Resource Locator (URL)');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `api_endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'oauth|api_key|basic_auth|certificate|saml');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `ccpa_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Compliant Flag');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `cost_model` SET TAGS ('dbx_business_glossary_term' = 'Cost Model');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `cost_model` SET TAGS ('dbx_value_regex' = 'cpm|flat_fee|usage_based|subscription|revenue_share|free');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `cost_model` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `cpm_rate` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM) Rate');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `cpm_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `data_expiry_days` SET TAGS ('dbx_business_glossary_term' = 'Data Expiry Days');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `data_retention_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Days');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `data_taxonomy_version` SET TAGS ('dbx_business_glossary_term' = 'Data Taxonomy Version');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `data_volume_mb` SET TAGS ('dbx_business_glossary_term' = 'Data Volume Megabytes (MB)');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `error_count` SET TAGS ('dbx_business_glossary_term' = 'Error Count');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `feed_type` SET TAGS ('dbx_business_glossary_term' = 'Feed Type');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `feed_type` SET TAGS ('dbx_value_regex' = 'demographic|behavioral|intent|contextual|geographic|psychographic');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `gdpr_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliant Flag');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `integration_direction` SET TAGS ('dbx_business_glossary_term' = 'Integration Direction');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `integration_direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound|bidirectional');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `integration_health_score` SET TAGS ('dbx_business_glossary_term' = 'Integration Health Score');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `integration_health_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `integration_health_score` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `integration_status` SET TAGS ('dbx_business_glossary_term' = 'Integration Status');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `integration_status` SET TAGS ('dbx_value_regex' = 'active|inactive|testing|deprecated|suspended');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `last_error_message` SET TAGS ('dbx_business_glossary_term' = 'Last Error Message');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `last_sync_record_count` SET TAGS ('dbx_business_glossary_term' = 'Last Synchronization Record Count');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `last_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Synchronization Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `licensing_terms` SET TAGS ('dbx_business_glossary_term' = 'Licensing Terms');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `licensing_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `monthly_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Cost Amount');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `monthly_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `next_scheduled_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Synchronization Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `pii_handling_classification` SET TAGS ('dbx_business_glossary_term' = 'Personally Identifiable Information (PII) Handling Classification');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `pii_handling_classification` SET TAGS ('dbx_value_regex' = 'no_pii|pseudonymized|hashed|anonymized|contains_pii');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `segment_mapping_configuration` SET TAGS ('dbx_business_glossary_term' = 'Segment Mapping Configuration');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `sync_status` SET TAGS ('dbx_business_glossary_term' = 'Synchronization Status');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `sync_status` SET TAGS ('dbx_value_regex' = 'active|paused|failed|pending|disabled');
ALTER TABLE `advertising_ecm`.`audience`.`third_party_feed` ALTER COLUMN `total_records_synced` SET TAGS ('dbx_business_glossary_term' = 'Total Records Synced');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` SET TAGS ('dbx_subdomain' = 'segment_management');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `lookalike_model_id` SET TAGS ('dbx_business_glossary_term' = 'Lookalike Model Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `audience_insight_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Insight Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Seed Segment Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Development Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Source Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `algorithm_type` SET TAGS ('dbx_business_glossary_term' = 'Algorithm Type');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `algorithm_type` SET TAGS ('dbx_value_regex' = 'cosine_similarity|gradient_boosting|neural_network|random_forest|logistic_regression|collaborative_filtering');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `baseline_performance_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Performance Value');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `consent_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Compliant Flag');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `data_source_type` SET TAGS ('dbx_business_glossary_term' = 'Data Source Type');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `data_source_type` SET TAGS ('dbx_value_regex' = 'first_party|second_party|third_party|hybrid');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `estimated_reach` SET TAGS ('dbx_business_glossary_term' = 'Estimated Reach');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `expansion_ratio` SET TAGS ('dbx_business_glossary_term' = 'Expansion Ratio');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `feature_set` SET TAGS ('dbx_business_glossary_term' = 'Feature Set');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `last_refresh_date` SET TAGS ('dbx_business_glossary_term' = 'Last Refresh Date');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `model_cost` SET TAGS ('dbx_business_glossary_term' = 'Model Cost');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `model_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `model_description` SET TAGS ('dbx_business_glossary_term' = 'Model Description');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Lookalike Model Name');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `model_status` SET TAGS ('dbx_business_glossary_term' = 'Model Status');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `model_status` SET TAGS ('dbx_value_regex' = 'draft|training|active|paused|expired|archived');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `next_refresh_date` SET TAGS ('dbx_business_glossary_term' = 'Next Refresh Date');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `performance_metric_type` SET TAGS ('dbx_business_glossary_term' = 'Performance Metric Type');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `performance_metric_type` SET TAGS ('dbx_value_regex' = 'ctr|cvr|roas|cpa|engagement_rate|ltv');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `platform_name` SET TAGS ('dbx_business_glossary_term' = 'Demand-Side Platform (DSP) Name');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `platform_name` SET TAGS ('dbx_value_regex' = 'the_trade_desk|dv360|amazon_dsp|facebook|google_ads|adobe_audience_manager');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `refresh_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Refresh Frequency (Days)');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `similarity_threshold` SET TAGS ('dbx_business_glossary_term' = 'Similarity Threshold');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `training_date` SET TAGS ('dbx_business_glossary_term' = 'Model Training Date');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `validation_accuracy` SET TAGS ('dbx_business_glossary_term' = 'Validation Accuracy');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` SET TAGS ('dbx_subdomain' = 'segment_management');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `suppression_list_id` SET TAGS ('dbx_business_glossary_term' = 'Suppression List Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Source Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Creation Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Governing Agreement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `media_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Applied Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Owner User Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `archive_date` SET TAGS ('dbx_business_glossary_term' = 'Archive Date');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `consent_withdrawal_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Flag');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `data_cost` SET TAGS ('dbx_business_glossary_term' = 'Data Cost');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `data_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `data_provider` SET TAGS ('dbx_business_glossary_term' = 'Data Provider');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `frequency_cap_period` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Period');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `frequency_cap_period` SET TAGS ('dbx_value_regex' = 'hour|day|week|month|campaign_lifetime');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `frequency_cap_threshold` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Threshold');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `hashing_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Hashing Algorithm');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `hashing_algorithm` SET TAGS ('dbx_value_regex' = 'SHA256|MD5|SHA1|none');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `identifier_type` SET TAGS ('dbx_business_glossary_term' = 'Identifier Type');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `identifier_type` SET TAGS ('dbx_value_regex' = 'hashed_email|cookie_id|mobile_advertising_id|device_id|customer_id|ip_address');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `last_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Refresh Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `list_code` SET TAGS ('dbx_business_glossary_term' = 'Suppression List Code');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `list_name` SET TAGS ('dbx_business_glossary_term' = 'Suppression List Name');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `list_size` SET TAGS ('dbx_business_glossary_term' = 'List Size');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `list_status` SET TAGS ('dbx_business_glossary_term' = 'List Status');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `list_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|pending_approval|archived');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `match_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Match Rate Percentage');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `platform_integration_status` SET TAGS ('dbx_business_glossary_term' = 'Platform Integration Status');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `platform_integration_status` SET TAGS ('dbx_value_regex' = 'synced|pending_sync|sync_failed|not_applicable');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `platform_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Platform Sync Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `privacy_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Privacy Compliance Flag');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_business_glossary_term' = 'Refresh Frequency');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|on_demand|real_time');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Days');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `scope_level` SET TAGS ('dbx_business_glossary_term' = 'Scope Level');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `scope_level` SET TAGS ('dbx_value_regex' = 'global|advertiser|campaign|line_item');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `source_file_name` SET TAGS ('dbx_business_glossary_term' = 'Source File Name');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `suppression_list_description` SET TAGS ('dbx_business_glossary_term' = 'Suppression List Description');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `suppression_type` SET TAGS ('dbx_business_glossary_term' = 'Suppression Type');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `suppression_type` SET TAGS ('dbx_value_regex' = 'converted_customer|opted_out|frequency_capped|competitor_employee|brand_safety|fraud_prevention');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `creation_date` SET TAGS ('dbx_business_glossary_term' = 'Creation Date');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` SET TAGS ('dbx_subdomain' = 'platform_activation');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `dmp_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Data Management Platform (DMP) Integration ID');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Integration Owner Worker Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract ID');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `api_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Endpoint URL');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `api_endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `api_version` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Version');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'OAuth2|API-Key|Basic-Auth|JWT|SAML');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `consent_framework_compliance` SET TAGS ('dbx_business_glossary_term' = 'Consent Framework Compliance');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `consent_framework_compliance` SET TAGS ('dbx_value_regex' = 'GDPR|CCPA|LGPD|PIPEDA|None|Multiple');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `consent_string_format` SET TAGS ('dbx_business_glossary_term' = 'Consent String Format');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `consent_string_format` SET TAGS ('dbx_value_regex' = 'IAB-TCF-v2|IAB-USP|Custom');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `cost_per_sync_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Synchronization (United States Dollars)');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `cost_per_sync_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `credential_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Credential Expiry Date');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `credential_expiry_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `data_retention_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Days)');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `data_volume_mb` SET TAGS ('dbx_business_glossary_term' = 'Data Volume (Megabytes)');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `dmp_integration_status` SET TAGS ('dbx_business_glossary_term' = 'Integration Status');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `dmp_integration_status` SET TAGS ('dbx_value_regex' = 'active|inactive|paused|error|pending');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `error_log_path` SET TAGS ('dbx_business_glossary_term' = 'Error Log Path');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `integration_type` SET TAGS ('dbx_business_glossary_term' = 'Integration Type');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `integration_type` SET TAGS ('dbx_value_regex' = 'inbound|outbound|bidirectional');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `is_production` SET TAGS ('dbx_business_glossary_term' = 'Is Production Environment');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `last_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Synchronization Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `monthly_cost_cap_usd` SET TAGS ('dbx_business_glossary_term' = 'Monthly Cost Cap (United States Dollars)');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `monthly_cost_cap_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `next_scheduled_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Synchronization Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Integration Notes');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `notification_email` SET TAGS ('dbx_business_glossary_term' = 'Notification Email Address');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `notification_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `notification_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `notification_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `platform_name` SET TAGS ('dbx_business_glossary_term' = 'Platform Name');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `platform_type` SET TAGS ('dbx_value_regex' = 'DMP|CDP|DSP|SSP|Hybrid');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `rate_limit_requests_per_minute` SET TAGS ('dbx_business_glossary_term' = 'Rate Limit (Requests Per Minute)');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `records_failed_count` SET TAGS ('dbx_business_glossary_term' = 'Records Failed Count');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `records_synced_count` SET TAGS ('dbx_business_glossary_term' = 'Records Synced Count');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `retry_attempts_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Retry Attempts');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `segment_mapping_config` SET TAGS ('dbx_business_glossary_term' = 'Segment Mapping Configuration');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `segment_mapping_config` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `sync_frequency` SET TAGS ('dbx_business_glossary_term' = 'Synchronization Frequency');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `sync_frequency` SET TAGS ('dbx_value_regex' = 'real-time|hourly|daily|weekly|on-demand');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `sync_method` SET TAGS ('dbx_business_glossary_term' = 'Synchronization Method');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `sync_method` SET TAGS ('dbx_value_regex' = 'pixel|API|batch|webhook|SFTP|S3');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `sync_status` SET TAGS ('dbx_business_glossary_term' = 'Synchronization Status');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `sync_status` SET TAGS ('dbx_value_regex' = 'success|failed|partial|in-progress');
ALTER TABLE `advertising_ecm`.`audience`.`dmp_integration` ALTER COLUMN `timeout_seconds` SET TAGS ('dbx_business_glossary_term' = 'Timeout Duration (Seconds)');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` SET TAGS ('dbx_subdomain' = 'segment_management');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Taxonomy Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Owner Worker Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `parent_taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Taxonomy Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `primary_replacement_taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Taxonomy Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `applicable_platforms` SET TAGS ('dbx_business_glossary_term' = 'Applicable Platforms');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `average_cpm_usd` SET TAGS ('dbx_business_glossary_term' = 'Average Cost Per Mille (CPM) United States Dollars (USD)');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `average_cpm_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `category_description` SET TAGS ('dbx_business_glossary_term' = 'Category Description');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `category_name` SET TAGS ('dbx_business_glossary_term' = 'Category Name');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `cdp_integration_enabled` SET TAGS ('dbx_business_glossary_term' = 'Customer Data Platform (CDP) Integration Enabled Flag');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `comscore_compatible` SET TAGS ('dbx_business_glossary_term' = 'Comscore Compatible Flag');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `consent_required` SET TAGS ('dbx_business_glossary_term' = 'Consent Required Flag');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `cpm_last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM) Last Updated Date');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `data_source_type` SET TAGS ('dbx_business_glossary_term' = 'Data Source Type');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `data_source_type` SET TAGS ('dbx_value_regex' = 'first_party|second_party|third_party|deterministic|probabilistic');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `data_type` SET TAGS ('dbx_business_glossary_term' = 'Data Type');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `data_type` SET TAGS ('dbx_value_regex' = 'behavioral|demographic|contextual|psychographic|geographic|technographic');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `deprecation_reason` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Reason');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `dmp_integration_enabled` SET TAGS ('dbx_business_glossary_term' = 'Data Management Platform (DMP) Integration Enabled Flag');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `dsp_activation_enabled` SET TAGS ('dbx_business_glossary_term' = 'Demand-Side Platform (DSP) Activation Enabled Flag');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `estimated_reach` SET TAGS ('dbx_business_glossary_term' = 'Estimated Reach');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `exclusion_categories` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Categories');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `iab_standard_code` SET TAGS ('dbx_business_glossary_term' = 'Interactive Advertising Bureau (IAB) Standard Code');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `iab_standard_code` SET TAGS ('dbx_value_regex' = '^(IAB[0-9]{1,4}(-[0-9]{1,4})?)?$');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Flag');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `minimum_segment_size` SET TAGS ('dbx_business_glossary_term' = 'Minimum Segment Size');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `nielsen_compatible` SET TAGS ('dbx_business_glossary_term' = 'Nielsen Compatible Flag');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `path` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Path');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `privacy_classification` SET TAGS ('dbx_business_glossary_term' = 'Privacy Classification');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `privacy_classification` SET TAGS ('dbx_value_regex' = 'non_pii|pseudonymous|pii_based|sensitive');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `reach_last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Reach Last Updated Date');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `taxonomy_code` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Code');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `taxonomy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `taxonomy_level` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Level');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `usage_guidelines` SET TAGS ('dbx_business_glossary_term' = 'Usage Guidelines');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` SET TAGS ('dbx_subdomain' = 'identity_resolution');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `pixel_id` SET TAGS ('dbx_business_glossary_term' = 'Pixel Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Seed Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Deployment Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Implementation Owner Worker Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `tracking_pixel_id` SET TAGS ('dbx_business_glossary_term' = 'Tracking Pixel Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `activated_date` SET TAGS ('dbx_business_glossary_term' = 'Activated Date');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `consent_category` SET TAGS ('dbx_business_glossary_term' = 'Consent Category');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `consent_category` SET TAGS ('dbx_value_regex' = 'strictly_necessary|functional|analytics|advertising|personalization');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `consent_required` SET TAGS ('dbx_business_glossary_term' = 'Consent Required Flag');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `container_code` SET TAGS ('dbx_business_glossary_term' = 'Container Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `container_tag_manager` SET TAGS ('dbx_business_glossary_term' = 'Container Tag Manager');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `conversion_value_currency` SET TAGS ('dbx_business_glossary_term' = 'Conversion Value Currency');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `conversion_value_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `cross_domain_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Cross-Domain Tracking Enabled Flag');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `data_collected` SET TAGS ('dbx_business_glossary_term' = 'Data Collected');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `data_retention_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Days');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `deactivated_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivated Date');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `deployment_domain` SET TAGS ('dbx_business_glossary_term' = 'Deployment Domain');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `deployment_url` SET TAGS ('dbx_business_glossary_term' = 'Deployment Uniform Resource Locator (URL)');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `event_schema_definition` SET TAGS ('dbx_business_glossary_term' = 'Event Schema Definition');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `event_types_captured` SET TAGS ('dbx_business_glossary_term' = 'Event Types Captured');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `firing_rule` SET TAGS ('dbx_business_glossary_term' = 'Firing Rule');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `first_party_cookie` SET TAGS ('dbx_business_glossary_term' = 'First-Party Cookie Flag');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `health_status` SET TAGS ('dbx_business_glossary_term' = 'Health Status');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `health_status` SET TAGS ('dbx_value_regex' = 'healthy|warning|error|inactive');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `health_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `health_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `identifiers_captured` SET TAGS ('dbx_business_glossary_term' = 'Identifiers Captured');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `identifiers_captured` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `last_event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Event Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `lookback_window_days` SET TAGS ('dbx_business_glossary_term' = 'Lookback Window Days');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `pixel_code` SET TAGS ('dbx_business_glossary_term' = 'Pixel Code');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `pixel_name` SET TAGS ('dbx_business_glossary_term' = 'Pixel Name');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `pixel_status` SET TAGS ('dbx_business_glossary_term' = 'Pixel Status');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `pixel_status` SET TAGS ('dbx_value_regex' = 'active|paused|archived|testing|pending_approval');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `pixel_type` SET TAGS ('dbx_business_glossary_term' = 'Pixel Type');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `pixel_type` SET TAGS ('dbx_value_regex' = 'retargeting|conversion|audience_building|measurement|view_through|click_through');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Platform');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `privacy_policy_url` SET TAGS ('dbx_business_glossary_term' = 'Privacy Policy Uniform Resource Locator (URL)');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `server_side_enabled` SET TAGS ('dbx_business_glossary_term' = 'Server-Side Enabled Flag');
ALTER TABLE `advertising_ecm`.`audience`.`pixel` ALTER COLUMN `total_events_captured` SET TAGS ('dbx_business_glossary_term' = 'Total Events Captured');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` SET TAGS ('dbx_subdomain' = 'identity_resolution');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `pixel_event_id` SET TAGS ('dbx_business_glossary_term' = 'Pixel Event ID');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `ad_id` SET TAGS ('dbx_business_glossary_term' = 'Ad ID');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `conversion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Event Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `media_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `pixel_id` SET TAGS ('dbx_business_glossary_term' = 'Pixel ID');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `browser` SET TAGS ('dbx_business_glossary_term' = 'Browser');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `browser_version` SET TAGS ('dbx_business_glossary_term' = 'Browser Version');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `ccpa_opt_out` SET TAGS ('dbx_business_glossary_term' = 'CCPA (California Consumer Privacy Act) Opt-Out');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|denied|not_required|unknown');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `conversion_flag` SET TAGS ('dbx_business_glossary_term' = 'Conversion Flag');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `cookie_identifier` SET TAGS ('dbx_business_glossary_term' = 'Cookie ID');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `cookie_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `cookie_identifier` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|ctv|other');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `event_source` SET TAGS ('dbx_business_glossary_term' = 'Event Source');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `event_source` SET TAGS ('dbx_value_regex' = 'web|mobile_app|ctv|email|other');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'page_view|add_to_cart|purchase|form_submit|video_view|click');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `event_value` SET TAGS ('dbx_business_glossary_term' = 'Event Value');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `gdpr_applies` SET TAGS ('dbx_business_glossary_term' = 'GDPR (General Data Protection Regulation) Applies');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `geographic_city` SET TAGS ('dbx_business_glossary_term' = 'Geographic City');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `geographic_country` SET TAGS ('dbx_business_glossary_term' = 'Geographic Country');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `hashed_email` SET TAGS ('dbx_business_glossary_term' = 'Hashed Email Address');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `hashed_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `hashed_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP (Internet Protocol) Address');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `mobile_advertising_identifier` SET TAGS ('dbx_business_glossary_term' = 'Mobile Advertising ID (MAID)');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `mobile_advertising_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `mobile_advertising_identifier` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System (OS)');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `operating_system_version` SET TAGS ('dbx_business_glossary_term' = 'Operating System (OS) Version');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `page_url` SET TAGS ('dbx_business_glossary_term' = 'Page URL (Uniform Resource Locator)');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `referring_url` SET TAGS ('dbx_business_glossary_term' = 'Referring URL (Uniform Resource Locator)');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `session_identifier` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `user_identifier` SET TAGS ('dbx_business_glossary_term' = 'User Identifier');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `user_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`pixel_event` ALTER COLUMN `user_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` SET TAGS ('dbx_subdomain' = 'identity_resolution');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `clean_room_id` SET TAGS ('dbx_business_glossary_term' = 'Clean Room Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `agreement_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Output Segment Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `insight_report_id` SET TAGS ('dbx_business_glossary_term' = 'Insight Report Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `last_modified_by_user_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `last_modified_by_user_worker_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `last_modified_by_user_worker_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Measured Creative Asset Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Setup Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Source Media Plan Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `worker_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `worker_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `federated_clean_room_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `activation_permissions` SET TAGS ('dbx_business_glossary_term' = 'Activation Permissions');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `activation_permissions` SET TAGS ('dbx_value_regex' = 'read only|activation allowed|measurement only|no export|full access');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `api_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Endpoint Uniform Resource Locator (URL)');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `api_endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'OAuth 2.0|API key|SAML|JWT|mutual TLS|basic auth');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `ccpa_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Compliant Flag');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `collaboration_code` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Code');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `collaboration_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Cost Amount');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `collaboration_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `collaboration_end_date` SET TAGS ('dbx_business_glossary_term' = 'Collaboration End Date');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `collaboration_name` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Name');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `collaboration_start_date` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Start Date');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `collaboration_status` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Status');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `collaboration_status` SET TAGS ('dbx_value_regex' = 'draft|pending approval|active|paused|completed|terminated');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `collaboration_type` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Type');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `collaboration_type` SET TAGS ('dbx_value_regex' = 'audience enrichment|campaign measurement|attribution analysis|lookalike modeling|reach and frequency|overlap analysis');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `consent_framework_compliance` SET TAGS ('dbx_business_glossary_term' = 'Consent Framework Compliance');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `consent_framework_compliance` SET TAGS ('dbx_value_regex' = 'GDPR|CCPA|TCF 2.0|LGPD|PIPEDA|not applicable');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `cost_model` SET TAGS ('dbx_business_glossary_term' = 'Cost Model');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `cost_model` SET TAGS ('dbx_value_regex' = 'CPM|flat fee|per query|per match|subscription|revenue share');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `cost_model` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `data_governance_rules` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Rules');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `data_retention_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Days');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `data_volume_mb` SET TAGS ('dbx_business_glossary_term' = 'Data Volume Megabytes (MB)');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `encryption_standard` SET TAGS ('dbx_business_glossary_term' = 'Encryption Standard');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `encryption_standard` SET TAGS ('dbx_value_regex' = 'AES-256|TLS 1.2|TLS 1.3|RSA-2048|not specified');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `gdpr_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliant Flag');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `last_query_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Query Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `match_methodology` SET TAGS ('dbx_business_glossary_term' = 'Match Methodology');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `match_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Match Rate Percentage');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `matched_audience_count` SET TAGS ('dbx_business_glossary_term' = 'Matched Audience Count');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Team');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `participating_parties` SET TAGS ('dbx_business_glossary_term' = 'Participating Parties');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `participating_parties` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `provider_platform` SET TAGS ('dbx_business_glossary_term' = 'Clean Room Provider Platform');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `provider_platform` SET TAGS ('dbx_value_regex' = 'InfoSum|Habu|LiveRamp|AWS Clean Rooms|Google Ads Data Hub|Snowflake Data Clean Room');
ALTER TABLE `advertising_ecm`.`audience`.`clean_room` ALTER COLUMN `query_count` SET TAGS ('dbx_business_glossary_term' = 'Query Count');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` SET TAGS ('dbx_subdomain' = 'segment_management');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `holdout_group_id` SET TAGS ('dbx_business_glossary_term' = 'Holdout Group Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Segment Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `brand_lift_study_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Lift Study Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `brand_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `experiment_incrementality_test_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `incrementality_test_id` SET TAGS ('dbx_business_glossary_term' = 'Incrementality Test Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Setup Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `parent_holdout_group_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `activation_status` SET TAGS ('dbx_business_glossary_term' = 'Activation Status');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `activation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|completed|archived');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `ccpa_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Compliant Flag');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Statistical Confidence Level');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `consent_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Compliant Flag');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `data_retention_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Days');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `dsp_platform_name` SET TAGS ('dbx_business_glossary_term' = 'Demand-Side Platform (DSP) Name');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `estimated_reach` SET TAGS ('dbx_business_glossary_term' = 'Estimated Reach');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `gdpr_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliant Flag');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `group_code` SET TAGS ('dbx_business_glossary_term' = 'Holdout Group Code');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `group_name` SET TAGS ('dbx_business_glossary_term' = 'Holdout Group Name');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `group_size` SET TAGS ('dbx_business_glossary_term' = 'Holdout Group Size');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `group_type` SET TAGS ('dbx_business_glossary_term' = 'Holdout Group Type');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `group_type` SET TAGS ('dbx_value_regex' = 'exposed|holdout|control|test|baseline');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `holdout_group_description` SET TAGS ('dbx_business_glossary_term' = 'Holdout Group Description');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `last_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Synchronization Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `match_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Match Rate Percentage');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `measurement_vendor` SET TAGS ('dbx_business_glossary_term' = 'Measurement Vendor');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `minimum_detectable_effect` SET TAGS ('dbx_business_glossary_term' = 'Minimum Detectable Effect (MDE)');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Holdout Group Notes');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Team');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `platform_integration_status` SET TAGS ('dbx_business_glossary_term' = 'Platform Integration Status');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `platform_integration_status` SET TAGS ('dbx_value_regex' = 'synced|pending|failed|not_applicable');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `randomization_seed` SET TAGS ('dbx_business_glossary_term' = 'Randomization Seed');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `split_methodology` SET TAGS ('dbx_business_glossary_term' = 'Split Methodology');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `split_methodology` SET TAGS ('dbx_value_regex' = 'random|stratified|geographic|behavioral|demographic|matched_pairs');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `split_percentage` SET TAGS ('dbx_business_glossary_term' = 'Split Percentage');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `stratification_variables` SET TAGS ('dbx_business_glossary_term' = 'Stratification Variables');
ALTER TABLE `advertising_ecm`.`audience`.`holdout_group` ALTER COLUMN `creation_date` SET TAGS ('dbx_business_glossary_term' = 'Creation Date');
ALTER TABLE `advertising_ecm`.`audience`.`segment_activation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`audience`.`segment_activation` SET TAGS ('dbx_subdomain' = 'platform_activation');
ALTER TABLE `advertising_ecm`.`audience`.`segment_activation` SET TAGS ('dbx_association_edges' = 'audience.segment,contract.insertion_order');
ALTER TABLE `advertising_ecm`.`audience`.`segment_activation` ALTER COLUMN `segment_activation_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Activation ID');
ALTER TABLE `advertising_ecm`.`audience`.`segment_activation` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Activation - Segment Id');
ALTER TABLE `advertising_ecm`.`audience`.`segment_activation` ALTER COLUMN `contract_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Activation - Contract Insertion Order Id');
ALTER TABLE `advertising_ecm`.`audience`.`segment_activation` ALTER COLUMN `activation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Activation End Date');
ALTER TABLE `advertising_ecm`.`audience`.`segment_activation` ALTER COLUMN `activation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Start Date');
ALTER TABLE `advertising_ecm`.`audience`.`segment_activation` ALTER COLUMN `activation_status` SET TAGS ('dbx_business_glossary_term' = 'Activation Status');
ALTER TABLE `advertising_ecm`.`audience`.`segment_activation` ALTER COLUMN `allocated_budget` SET TAGS ('dbx_business_glossary_term' = 'Allocated Budget');
ALTER TABLE `advertising_ecm`.`audience`.`segment_activation` ALTER COLUMN `allocated_impressions` SET TAGS ('dbx_business_glossary_term' = 'Allocated Impressions');
ALTER TABLE `advertising_ecm`.`audience`.`segment_activation` ALTER COLUMN `bid_modifier` SET TAGS ('dbx_business_glossary_term' = 'Bid Modifier');
ALTER TABLE `advertising_ecm`.`audience`.`segment_activation` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `advertising_ecm`.`audience`.`segment_activation` ALTER COLUMN `frequency_cap` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap');
ALTER TABLE `advertising_ecm`.`audience`.`segment_activation` ALTER COLUMN `frequency_cap_window_hours` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap Window');
ALTER TABLE `advertising_ecm`.`audience`.`segment_activation` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `advertising_ecm`.`audience`.`segment_activation` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `advertising_ecm`.`audience`.`segment_activation` ALTER COLUMN `segment_priority` SET TAGS ('dbx_business_glossary_term' = 'Segment Priority');
ALTER TABLE `advertising_ecm`.`audience`.`segment_activation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `advertising_ecm`.`audience`.`segment_usage` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`audience`.`segment_usage` SET TAGS ('dbx_subdomain' = 'platform_activation');
ALTER TABLE `advertising_ecm`.`audience`.`segment_usage` SET TAGS ('dbx_association_edges' = 'audience.segment,project.initiative');
ALTER TABLE `advertising_ecm`.`audience`.`segment_usage` ALTER COLUMN `segment_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Usage ID');
ALTER TABLE `advertising_ecm`.`audience`.`segment_usage` ALTER COLUMN `audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Usage - Segment Id');
ALTER TABLE `advertising_ecm`.`audience`.`segment_usage` ALTER COLUMN `worker_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Worker ID');
ALTER TABLE `advertising_ecm`.`audience`.`segment_usage` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Usage - Initiative Id');
ALTER TABLE `advertising_ecm`.`audience`.`segment_usage` ALTER COLUMN `activation_status` SET TAGS ('dbx_business_glossary_term' = 'Activation Status');
ALTER TABLE `advertising_ecm`.`audience`.`segment_usage` ALTER COLUMN `actual_spend` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend');
ALTER TABLE `advertising_ecm`.`audience`.`segment_usage` ALTER COLUMN `budget_allocated` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocated');
ALTER TABLE `advertising_ecm`.`audience`.`segment_usage` ALTER COLUMN `clicks_delivered` SET TAGS ('dbx_business_glossary_term' = 'Clicks Delivered');
ALTER TABLE `advertising_ecm`.`audience`.`segment_usage` ALTER COLUMN `conversions_delivered` SET TAGS ('dbx_business_glossary_term' = 'Conversions Delivered');
ALTER TABLE `advertising_ecm`.`audience`.`segment_usage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`segment_usage` ALTER COLUMN `impressions_delivered` SET TAGS ('dbx_business_glossary_term' = 'Impressions Delivered');
ALTER TABLE `advertising_ecm`.`audience`.`segment_usage` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`segment_usage` ALTER COLUMN `priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Priority Tier');
ALTER TABLE `advertising_ecm`.`audience`.`segment_usage` ALTER COLUMN `segment_role` SET TAGS ('dbx_business_glossary_term' = 'Segment Role');
ALTER TABLE `advertising_ecm`.`audience`.`segment_usage` ALTER COLUMN `usage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Usage End Date');
ALTER TABLE `advertising_ecm`.`audience`.`segment_usage` ALTER COLUMN `usage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Usage Start Date');
