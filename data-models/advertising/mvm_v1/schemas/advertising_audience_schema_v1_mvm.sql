-- Schema for Domain: audience | Business: Advertising | Version: v1_mvm
-- Generated on: 2026-05-08 03:52:16

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `advertising_ecm`.`audience` COMMENT 'SSOT for audience definition, segmentation, and targeting data used across campaigns. Manages first-party, second-party, and third-party audience segments, personas, behavioral profiles, demographic attributes, psychographic insights, DMP/CDP integrations, and privacy-compliant consent records (GDPR, CCPA). Integrates with Nielsen, Comscore, and DSP audience tools.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `advertising_ecm`.`audience`.`segment` (
    `segment_id` BIGINT COMMENT 'Unique identifier for the audience segment. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Audience segment data acquisition and maintenance costs are allocated to cost centers for internal P&L reporting and chargeback. Advertising agencies track which department owns each segment. owning_',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Audience segments are frequently sourced from or enriched by third-party data suppliers. Supplier FK on audience_segment enables data sourcing cost attribution, vendor performance evaluation for data ',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Audience segments often governed by master agreements defining data usage rights, licensing terms, geographic restrictions, and activation permissions. Critical for compliance tracking, data rights ma',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Campaign-specific custom segments are frequently defined as SOW deliverables with specific build criteria, acceptance thresholds, and delivery timelines. Essential for scope validation, deliverable tr',
    `taxonomy_id` BIGINT COMMENT 'Foreign key linking to audience.audience_taxonomy. Business justification: Segments should be formally classified using the standardized audience taxonomy (aligned to IAB Audience Taxonomy per audience_taxonomy product description). The segment table currently has iab_taxon',
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
    `parental_status` STRING COMMENT 'Indicates whether segment targets parents, non-parents, or all. Nullable if parental status is not a qualification criterion.. Valid values are `parent|non_parent|all|unknown`',
    `purchase_history_flag` BOOLEAN COMMENT 'Indicates whether segment qualification includes past purchase behavior from CRM or e-commerce data.',
    `refresh_cadence` STRING COMMENT 'Frequency at which segment membership is recalculated and updated: real-time (streaming), hourly, daily, weekly, monthly, or static (one-time build).. Valid values are `real_time|hourly|daily|weekly|monthly|static`',
    `rfm_score` STRING COMMENT 'RFM segmentation score (e.g., 555 for best customers, 111 for low-value) used for behavioral qualification. Nullable if RFM is not a qualification criterion.',
    `search_intent_keywords` STRING COMMENT 'Comma-separated list of search keywords or intent signals used for behavioral qualification (e.g., luxury cars, mortgage refinance). Nullable if search intent is not a qualification criterion.',
    `size` BIGINT COMMENT 'Total count of unique users, devices, or households currently qualifying for this segment.',
    `vals_segment` STRING COMMENT 'VALS psychographic segmentation classification (e.g., Innovators, Thinkers, Achievers, Experiencers) used for psychographic qualification. Nullable if VALS is not a qualification criterion. [ENUM-REF-CANDIDATE: innovators|thinkers|achievers|experiencers|believers|strivers|makers|survivors — promote to reference product]',
    CONSTRAINT pk_segment PRIMARY KEY(`segment_id`)
) COMMENT 'Master record and SSOT for all audience segments — first-party, second-party, and third-party — used across campaigns. Captures segment name, type (behavioral, demographic, psychographic, contextual, lookalike), data source (1P/2P/3P), segment size, creation method (rules-based, ML-modeled, imported), activation status, refresh cadence, expiry date, IAB taxonomy classification, and owning team. Embeds full qualification criteria spanning demographic attributes (age band, gender, income tier, DMA, education, marital/parental status, language), behavioral signals (browsing categories, purchase history, RFM scores, app usage, cross-device activity, search intent, content consumption), and psychographic dimensions (VALS, brand affinity, lifestyle segments, interest taxonomies, purchase motivations, personality indicators, media attitudes). Qualification criteria are sourced from Nielsen, Comscore, first-party CRM, DMP/CDP integrations, survey data, and social listening. SSOT for all audience segment definitions, targeting rules, and profile-level qualification logic in the advertising platform.';

CREATE OR REPLACE TABLE `advertising_ecm`.`audience`.`persona` (
    `persona_id` BIGINT COMMENT 'Unique identifier for the audience persona profile. Primary key.',
    `behavioral_profile_id` BIGINT COMMENT 'Foreign key linking to audience.behavioral_profile. Business justification: Personas currently have digital_behavior_profile (string) and related behavioral attributes. behavioral_profile is a structured, reusable behavioral profile with detailed behavioral data. Normalizing ',
    `brand_id` BIGINT COMMENT 'Foreign key linking to client.client_brand. Business justification: Consumer personas are defined per brand for creative strategy, messaging frameworks, and brand planning. Brand planners and strategists need to retrieve all personas associated with a specific brand. ',
    `demographic_profile_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_profile. Business justification: Personas currently have embedded demographic attributes (age_range_min/max, gender_profile, income_bracket, education_level, geographic_focus, household_composition). demographic_profile is a structur',
    `segment_id` BIGINT COMMENT 'Foreign key linking to audience.audience_segment. Business justification: A persona is a synthesized archetypal audience profile that is built from and represents one or more audience segments. The primary_audience_segment_id FK establishes the foundational segment from whi',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Persona development is a scoped deliverable in advertising SOWs — agencies are contracted to build specific personas for client campaigns. Linking persona to sow enables SOW deliverable tracking, bill',
    `taxonomy_id` BIGINT COMMENT 'Foreign key linking to audience.taxonomy. Business justification: A persona represents an archetypal audience group and should be classified under the standardized IAB Audience Taxonomy for cross-platform consistency, DMP/CDP integration alignment, and regulatory re',
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
    `segment_id` BIGINT COMMENT 'External segment identifier from the Data Management Platform (DMP) system. Used for DMP integration and cross-platform targeting.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Demographic profiles are sourced from third-party data vendors (Experian, Acxiom, etc.). Supplier FK is required for data lineage, vendor cost attribution, GDPR data processor tracking, and data quali',
    `taxonomy_id` BIGINT COMMENT 'Foreign key linking to audience.audience_taxonomy. Business justification: audience_taxonomy provides standardized audience classification categories aligned to IAB Audience Taxonomy. demographic_profile should be classified using this standardized taxonomy for consistency a',
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
    `segment_id` BIGINT COMMENT 'Reference to the parent audience segment this behavioral profile belongs to.',
    `taxonomy_id` BIGINT COMMENT 'Foreign key linking to audience.audience_taxonomy. Business justification: behavioral_profile has browsing_category_primary and browsing_category_secondary (strings). audience_taxonomy provides standardized audience classification. Adding primary_taxonomy_id (FK to audience_',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Behavioral profiles are built from data sourced from third-party data suppliers (DMPs, data brokers). data_source_description is a denormalization signal. Supplier FK enables data lineage tracking, GD',
    `tertiary_behavioral_lookalike_seed_segment_audience_segment_id` BIGINT COMMENT 'Reference to the seed audience segment used to generate this lookalike behavioral profile, if applicable.',
    `app_usage_pattern` STRING COMMENT 'Description of observed mobile app usage patterns (e.g., Gaming Apps, Shopping Apps, News Apps, Social Media Apps).',
    `brand_affinity_category` STRING COMMENT 'Category of brands or products the user has shown affinity toward based on observed behavior (e.g., Luxury Brands, Eco-Friendly Products, Tech Gadgets).',
    `browsing_category_primary` STRING COMMENT 'The primary content category observed in the users browsing behavior (e.g., Automotive, Travel, Finance, Health & Wellness).',
    `browsing_category_secondary` STRING COMMENT 'The secondary content category observed in the users browsing behavior, indicating additional interests.',
    `consent_status` STRING COMMENT 'Privacy consent status for behavioral data collection and usage, ensuring compliance with GDPR, CCPA, and other privacy regulations.. Valid values are `granted|denied|pending|withdrawn|not_required`',
    `consent_timestamp` TIMESTAMP COMMENT 'Timestamp when consent was granted or last updated for this behavioral profile.',
    `content_consumption_category` STRING COMMENT 'Category of content consumed by the user (e.g., Video, Articles, Podcasts, Social Media).',
    `cross_device_activity_flag` BOOLEAN COMMENT 'Indicates whether the behavioral profile includes cross-device activity tracking and identity resolution.',
    `data_retention_expiry_date` DATE COMMENT 'Date when this behavioral profile data must be purged or anonymized per privacy regulations and data retention policies.',
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

CREATE OR REPLACE TABLE `advertising_ecm`.`audience`.`segment_membership` (
    `segment_membership_id` BIGINT COMMENT 'Unique identifier for the segment membership record. Primary key for the segment membership association.',
    `budget_line_id` BIGINT COMMENT 'Foreign key linking to finance.budget_line. Business justification: Segment membership has cost_per_member indicating data costs that must be tracked against a budget line. Audience data spend management requires linking membership costs to approved budget lines for v',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Segment membership records carry cost_per_member and currency_code, indicating per-member data costs. Cost center attribution is required for internal billing and data cost allocation reporting across',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Segment membership records are generated during initiative execution (e.g., audience onboarding initiative, data partnership initiative). Linking membership to the originating initiative enables attri',
    `segment_id` BIGINT COMMENT 'Reference to the specific audience segment that this identifier belongs to. Links to the audience segment definition in the DMP or CDP.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Segment membership data is sourced from third-party data suppliers. Media planners need supplier attribution per membership record for data cost reconciliation, quality audits, and GDPR data processor',
    `tech_partner_id` BIGINT COMMENT 'Foreign key linking to vendor.tech_partner. Business justification: Segment memberships are activated via DSP/tech platforms. dsp_platform is a plain-text denormalization of the tech partner. Linking to tech_partner enables platform fee reconciliation, activation trou',
    `activation_status` STRING COMMENT 'The status of this segment membership in the DSP or activation platform. Activated indicates the membership is live and available for targeting. Pending indicates activation is in progress. Failed indicates activation encountered an error. Deactivated indicates the membership has been removed from the activation platform.. Valid values are `activated|pending|failed|deactivated`',
    `activation_timestamp` TIMESTAMP COMMENT 'The timestamp when this segment membership was successfully activated in the DSP or targeting platform. Used for activation latency analysis and real-time audience availability reporting.',
    `audience_identifier` STRING COMMENT 'The individual audience identifier (cookie ID, device ID, hashed email, MAID, or other pseudonymous identifier) that is a member of the segment. This is the core identifier used for targeting and activation across DSP, DMP, and CDP platforms.',
    `confidence_score` DECIMAL(18,2) COMMENT 'A numeric score between 0 and 1 representing the confidence or probability that the audience identifier truly belongs to this segment. Higher scores indicate stronger membership signals. Used for quality filtering and bid optimization in programmatic campaigns.',
    `cost_per_member` DECIMAL(18,2) COMMENT 'The cost paid to acquire or license this specific segment membership from a third-party data provider, expressed in the campaign currency. Null for first-party segments. Used for data cost attribution and ROI analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this segment membership record was first created in the system. Used for audit trails and membership lifecycle tracking.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the cost per member amount (e.g., USD, EUR, GBP). Used for multi-currency data cost reporting and financial reconciliation.. Valid values are `^[A-Z]{3}$`',
    `device_type` STRING COMMENT 'The type of device associated with this audience identifier. Desktop indicates traditional computer. Mobile indicates smartphone. Tablet indicates tablet device. CTV indicates Connected TV. OTT indicates Over-The-Top streaming device. Other indicates unclassified device. Used for device-specific targeting and cross-device attribution.. Valid values are `desktop|mobile|tablet|ctv|ott|other`',
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

CREATE OR REPLACE TABLE `advertising_ecm`.`audience`.`activation` (
    `activation_id` BIGINT COMMENT 'Unique identifier for the audience activation record. Primary key.',
    `segment_id` BIGINT COMMENT 'External identifier assigned by the target platform (DSP/SSP) for this activated audience segment.',
    `activation_segment_id` BIGINT COMMENT 'Reference to the audience segment being activated for targeting.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to creative.creative_asset. Business justification: Activations push segments to DSPs/SSPs with specific creative; programmatic campaigns require asset-segment pairing for trafficking, and activation records must track which creative serves to each aud',
    `budget_line_id` BIGINT COMMENT 'Foreign key linking to finance.budget_line. Business justification: Each audience activation to a DSP/platform consumes a specific budget line (media spend allocation). Finance teams reconcile activation costs against budget lines. This link enables activation-level s',
    `campaign_id` BIGINT COMMENT 'Reference to the campaign for which this audience segment is being activated.',
    `contract_insertion_order_id` BIGINT COMMENT 'Foreign key linking to contract.contract_insertion_order. Business justification: Activations are executed under a contract insertion order that authorizes spend, flight dates, and placement specs. Linking activation to contract_insertion_order enables contractual compliance tracki',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Activations carry cost_cpm and currency_code indicating direct media/data costs. Cost center attribution for audience activation spend is required for internal cost allocation, P&L reporting, and char',
    `creative_deliverable_id` BIGINT COMMENT 'Foreign key linking to creative.creative_deliverable. Business justification: Activations reference deliverables for media plan execution; trafficking workflows map segments to specific creative deliverables to ensure correct creative versions serve to each audience across chan',
    `flight_id` BIGINT COMMENT 'Foreign key linking to campaign.flight. Business justification: Audience activations are executed within specific campaign flights. Linking activation to flight enables flight-level audience delivery reporting, frequency management, and reach measurement within sc',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Audience activations are often executed as part of broader project initiatives for budget tracking, timeline management, and deliverable coordination. Agencies track which project initiative funded an',
    `line_item_id` BIGINT COMMENT 'Foreign key linking to campaign.line_item. Business justification: Programmatic audience activations are executed at the line-item level. Buyers need to reconcile which audience activations drove delivery against specific line items for billing verification, performa',
    `lookalike_model_id` BIGINT COMMENT 'Foreign key linking to audience.lookalike_model. Business justification: When an audience activation pushes a lookalike-generated segment to a DSP or SSP, the activation record should reference the lookalike_model that produced the expanded audience. This enables performan',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Activations are executed through platform vendors (DSPs, social platforms, DMPs). Tracking which supplier/platform executed each activation is fundamental to reconciliation, performance reporting, inv',
    `suppression_list_id` BIGINT COMMENT 'Foreign key linking to audience.suppression_list. Business justification: audience_activation pushes segments to DSPs/SSPs. suppression_list defines identifiers to exclude from targeting. An activation should reference which suppression list was applied to ensure excluded i',
    `tech_partner_id` BIGINT COMMENT 'Foreign key linking to vendor.tech_partner. Business justification: Audience activations are executed through DSP/tech platforms. Knowing which tech partner executed each activation is required for platform fee reconciliation, troubleshooting sync errors (retry_count,',
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

CREATE OR REPLACE TABLE `advertising_ecm`.`audience`.`lookalike_model` (
    `lookalike_model_id` BIGINT COMMENT 'Unique identifier for the lookalike audience model record. Primary key for the lookalike model entity.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser or client account that owns this lookalike model for campaign use and billing purposes.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to client.client_brand. Business justification: Lookalike models are built for specific brands to expand reach among new audiences resembling existing brand customers. Brand managers need to track which lookalike models are active for their brand f',
    `campaign_id` BIGINT COMMENT 'Optional reference to a specific campaign for which this lookalike model was created, enabling campaign-specific audience modeling strategies.',
    `contract_insertion_order_id` BIGINT COMMENT 'Foreign key linking to contract.contract_insertion_order. Business justification: Lookalike models are commissioned and billed under specific contract IOs in programmatic advertising. Linking to contract_insertion_order enables cost attribution, IO-level model performance reporting',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Lookalike models carry model_cost and currency_code attributes. Cost center attribution for model development and licensing costs is required for internal P&L reporting and chargeback in agencies that',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Lookalike model development is a distinct project deliverable with dedicated timelines, resources, and budgets. Agencies track which initiative funded model creation for cost recovery and to manage da',
    `segment_id` BIGINT COMMENT 'Reference to the source audience segment used as the foundation for building the lookalike model. The seed segment contains high-value users whose characteristics are modeled.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Lookalike models are frequently built by third-party data science platforms or DSPs (e.g., Facebook, Trade Desk, LiveRamp). Tracking the supplier is essential for cost allocation, model performance at',
    `taxonomy_id` BIGINT COMMENT 'Foreign key linking to audience.taxonomy. Business justification: A lookalike model is built to expand a seed audience into a broader audience within a specific audience category. The taxonomy_id FK classifies the lookalike model under the standardized IAB Audience ',
    `tech_partner_id` BIGINT COMMENT 'Foreign key linking to vendor.tech_partner. Business justification: Lookalike models are built and hosted on specific DSP/ML tech platforms. platform_name is a plain-text denormalization of the tech partner. FK enables model governance, platform fee tracking, and plat',
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
    `refresh_frequency_days` STRING COMMENT 'Number of days between scheduled model retraining cycles to maintain accuracy and relevance as audience behaviors evolve.',
    `similarity_threshold` DECIMAL(18,2) COMMENT 'Minimum similarity score (0.0000 to 1.0000) required for a user to be included in the lookalike audience. Higher thresholds produce smaller, more similar audiences.',
    `training_date` DATE COMMENT 'Date when the lookalike model was trained on the seed segment data. Critical for understanding model freshness and performance decay over time.',
    `validation_accuracy` DECIMAL(18,2) COMMENT 'Model accuracy score (0.0000 to 1.0000) measured on a holdout validation dataset, indicating how well the model predicts high-value user characteristics.',
    CONSTRAINT pk_lookalike_model PRIMARY KEY(`lookalike_model_id`)
) COMMENT 'Operational record of a lookalike audience model built from a seed segment — capturing seed segment reference, model algorithm type (cosine similarity, gradient boosting, neural net), expansion ratio, similarity threshold, model training date, model version, platform (The Trade Desk, DV360), estimated reach, validation accuracy, and model status. Enables scale expansion of high-value audience segments for prospecting campaigns.';

CREATE OR REPLACE TABLE `advertising_ecm`.`audience`.`suppression_list` (
    `suppression_list_id` BIGINT COMMENT 'Unique identifier for the suppression list record. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Identifier of the advertiser to which this suppression list is scoped. Nullable if the list is shared across multiple advertisers.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to client.client_brand. Business justification: Suppression lists are brand-specific in multi-brand advertisers — Brand As opted-out customers must not suppress Brand B campaigns. Brand-level suppression management is a standard privacy compliance',
    `campaign_id` BIGINT COMMENT 'Identifier of the specific campaign to which this suppression list is applied. Nullable if the list is applied at advertiser or account level.',
    `contract_insertion_order_id` BIGINT COMMENT 'Foreign key linking to contract.contract_insertion_order. Business justification: Suppression lists are applied at the IO level in media buying — the IO specifies which suppression lists govern a given buy to prevent serving ads to opted-out or excluded audiences. This link enables',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to project.initiative. Business justification: Suppression list creation and maintenance is often a project task within compliance or campaign setup initiatives. Agencies track which project funded list development for billing and to manage data o',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: data_provider on suppression_list is a plain-text denormalization of the vendor supplier. Suppression list data is sourced from specific vendors (opt-out providers, CRM data vendors). FK enables vendo',
    `tech_partner_id` BIGINT COMMENT 'Foreign key linking to vendor.tech_partner. Business justification: Suppression lists are synced to and enforced by specific DSP/tech platforms. platform_integration_status and platform_sync_timestamp on suppression_list confirm a platform relationship exists. Complia',
    `flight_id` BIGINT COMMENT 'Foreign key linking to campaign.flight. Business justification: Suppression lists are applied at the flight level to exclude opted-out users or existing customers from specific flight executions. Media planners need flight-level suppression control for granular au',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Suppression obligations are frequently contractually mandated (competitor exclusions, brand safety requirements, regulatory compliance). Critical for compliance verification, audit trails, and ensurin',
    `segment_id` BIGINT COMMENT 'Foreign key linking to audience.segment. Business justification: Suppression lists are often derived from segments (e.g., suppress all users who converted or suppress all users in segment X). Adding source_segment_id tracks which segment the suppression list wa',
    `approval_status` STRING COMMENT 'Approval workflow status for the suppression list (approved, pending, rejected). Lists must be approved before activation in campaigns.. Valid values are `approved|pending|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the suppression list was approved for use in campaigns.',
    `archive_date` DATE COMMENT 'Date when the suppression list was archived and removed from active campaign targeting systems.',
    `consent_withdrawal_flag` BOOLEAN COMMENT 'Indicates whether the suppression list contains identifiers for users who have withdrawn marketing consent (True/False).',
    `data_cost` DECIMAL(18,2) COMMENT 'Cost incurred to acquire or license the suppression list data from a third-party provider, in US Dollars (USD).',
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

CREATE OR REPLACE TABLE `advertising_ecm`.`audience`.`taxonomy` (
    `taxonomy_id` BIGINT COMMENT 'Unique identifier for the audience taxonomy node. Primary key for the audience taxonomy reference structure.',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `advertising_ecm`.`audience`.`segment` ADD CONSTRAINT `fk_audience_segment_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `advertising_ecm`.`audience`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `advertising_ecm`.`audience`.`persona` ADD CONSTRAINT `fk_audience_persona_behavioral_profile_id` FOREIGN KEY (`behavioral_profile_id`) REFERENCES `advertising_ecm`.`audience`.`behavioral_profile`(`behavioral_profile_id`);
ALTER TABLE `advertising_ecm`.`audience`.`persona` ADD CONSTRAINT `fk_audience_persona_demographic_profile_id` FOREIGN KEY (`demographic_profile_id`) REFERENCES `advertising_ecm`.`audience`.`demographic_profile`(`demographic_profile_id`);
ALTER TABLE `advertising_ecm`.`audience`.`persona` ADD CONSTRAINT `fk_audience_persona_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `advertising_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `advertising_ecm`.`audience`.`persona` ADD CONSTRAINT `fk_audience_persona_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `advertising_ecm`.`audience`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ADD CONSTRAINT `fk_audience_demographic_profile_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `advertising_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ADD CONSTRAINT `fk_audience_demographic_profile_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `advertising_ecm`.`audience`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ADD CONSTRAINT `fk_audience_behavioral_profile_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `advertising_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ADD CONSTRAINT `fk_audience_behavioral_profile_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `advertising_ecm`.`audience`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ADD CONSTRAINT `fk_audience_behavioral_profile_tertiary_behavioral_lookalike_seed_segment_audience_segment_id` FOREIGN KEY (`tertiary_behavioral_lookalike_seed_segment_audience_segment_id`) REFERENCES `advertising_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ADD CONSTRAINT `fk_audience_segment_membership_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `advertising_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `advertising_ecm`.`audience`.`activation` ADD CONSTRAINT `fk_audience_activation_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `advertising_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `advertising_ecm`.`audience`.`activation` ADD CONSTRAINT `fk_audience_activation_activation_segment_id` FOREIGN KEY (`activation_segment_id`) REFERENCES `advertising_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `advertising_ecm`.`audience`.`activation` ADD CONSTRAINT `fk_audience_activation_lookalike_model_id` FOREIGN KEY (`lookalike_model_id`) REFERENCES `advertising_ecm`.`audience`.`lookalike_model`(`lookalike_model_id`);
ALTER TABLE `advertising_ecm`.`audience`.`activation` ADD CONSTRAINT `fk_audience_activation_suppression_list_id` FOREIGN KEY (`suppression_list_id`) REFERENCES `advertising_ecm`.`audience`.`suppression_list`(`suppression_list_id`);
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ADD CONSTRAINT `fk_audience_lookalike_model_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `advertising_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ADD CONSTRAINT `fk_audience_lookalike_model_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `advertising_ecm`.`audience`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ADD CONSTRAINT `fk_audience_suppression_list_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `advertising_ecm`.`audience`.`segment`(`segment_id`);
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ADD CONSTRAINT `fk_audience_taxonomy_parent_taxonomy_id` FOREIGN KEY (`parent_taxonomy_id`) REFERENCES `advertising_ecm`.`audience`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ADD CONSTRAINT `fk_audience_taxonomy_primary_replacement_taxonomy_id` FOREIGN KEY (`primary_replacement_taxonomy_id`) REFERENCES `advertising_ecm`.`audience`.`taxonomy`(`taxonomy_id`);

-- ========= TAGS =========
ALTER SCHEMA `advertising_ecm`.`audience` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `advertising_ecm`.`audience` SET TAGS ('dbx_domain' = 'audience');
ALTER TABLE `advertising_ecm`.`audience`.`segment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`audience`.`segment` SET TAGS ('dbx_subdomain' = 'audience_segmentation');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Data Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Master Agreement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Taxonomy Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `activation_status` SET TAGS ('dbx_business_glossary_term' = 'Activation Status');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `activation_status` SET TAGS ('dbx_value_regex' = 'activated|not_activated|pending_activation');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `age_band_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Age Band');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `age_band_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Band');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `app_usage_flag` SET TAGS ('dbx_business_glossary_term' = 'App Usage Flag');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `audience_segment_description` SET TAGS ('dbx_business_glossary_term' = 'Segment Description');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `audience_segment_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Name');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `audience_segment_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Status');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `audience_segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived|expired');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `audience_segment_type` SET TAGS ('dbx_business_glossary_term' = 'Segment Type');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `audience_segment_type` SET TAGS ('dbx_value_regex' = 'behavioral|demographic|psychographic|contextual|lookalike|geographic');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `brand_affinity_list` SET TAGS ('dbx_business_glossary_term' = 'Brand Affinity List');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `browsing_categories` SET TAGS ('dbx_business_glossary_term' = 'Browsing Categories');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `ccpa_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Compliant Flag');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'consented|not_consented|pending|withdrawn');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `content_consumption_topics` SET TAGS ('dbx_business_glossary_term' = 'Content Consumption Topics');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `creation_method` SET TAGS ('dbx_business_glossary_term' = 'Segment Creation Method');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `creation_method` SET TAGS ('dbx_value_regex' = 'rules_based|ml_modeled|imported|survey_derived|manual');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `cross_device_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Device Flag');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `data_source_tier` SET TAGS ('dbx_business_glossary_term' = 'Data Source Tier');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `data_source_tier` SET TAGS ('dbx_value_regex' = 'first_party|second_party|third_party');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `dma_codes` SET TAGS ('dbx_business_glossary_term' = 'Designated Market Area (DMA) Codes');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `education_level` SET TAGS ('dbx_business_glossary_term' = 'Education Level');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `external_code` SET TAGS ('dbx_business_glossary_term' = 'External Segment Code');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `gdpr_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliant Flag');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|all|unknown');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `income_tier` SET TAGS ('dbx_business_glossary_term' = 'Income Tier');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `interest_taxonomy` SET TAGS ('dbx_business_glossary_term' = 'Interest Taxonomy');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `lifestyle_segment` SET TAGS ('dbx_business_glossary_term' = 'Lifestyle Segment');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `marital_status` SET TAGS ('dbx_business_glossary_term' = 'Marital Status');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `marital_status` SET TAGS ('dbx_value_regex' = 'single|married|divorced|widowed|all|unknown');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `marital_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `marital_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `parental_status` SET TAGS ('dbx_business_glossary_term' = 'Parental Status');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `parental_status` SET TAGS ('dbx_value_regex' = 'parent|non_parent|all|unknown');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `purchase_history_flag` SET TAGS ('dbx_business_glossary_term' = 'Purchase History Flag');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `refresh_cadence` SET TAGS ('dbx_business_glossary_term' = 'Refresh Cadence');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `refresh_cadence` SET TAGS ('dbx_value_regex' = 'real_time|hourly|daily|weekly|monthly|static');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `rfm_score` SET TAGS ('dbx_business_glossary_term' = 'Recency Frequency Monetary (RFM) Score');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `search_intent_keywords` SET TAGS ('dbx_business_glossary_term' = 'Search Intent Keywords');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `size` SET TAGS ('dbx_business_glossary_term' = 'Segment Size');
ALTER TABLE `advertising_ecm`.`audience`.`segment` ALTER COLUMN `vals_segment` SET TAGS ('dbx_business_glossary_term' = 'Values and Lifestyles (VALS) Segment');
ALTER TABLE `advertising_ecm`.`audience`.`persona` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`audience`.`persona` SET TAGS ('dbx_subdomain' = 'audience_segmentation');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `persona_id` SET TAGS ('dbx_business_glossary_term' = 'Persona Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `behavioral_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Behavioral Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `demographic_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Profile Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Audience Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`persona` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Id (Foreign Key)');
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
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` SET TAGS ('dbx_subdomain' = 'audience_segmentation');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `demographic_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Profile Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Data Management Platform (DMP) Segment Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`demographic_profile` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Taxonomy Id (Foreign Key)');
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
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` SET TAGS ('dbx_subdomain' = 'audience_segmentation');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `behavioral_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Behavioral Profile ID');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment ID');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Taxonomy Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`behavioral_profile` ALTER COLUMN `tertiary_behavioral_lookalike_seed_segment_audience_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Lookalike Seed Segment ID');
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
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` SET TAGS ('dbx_subdomain' = 'targeting_activation');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `segment_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`segment_membership` ALTER COLUMN `tech_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Tech Partner Id (Foreign Key)');
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
ALTER TABLE `advertising_ecm`.`audience`.`activation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `advertising_ecm`.`audience`.`activation` SET TAGS ('dbx_subdomain' = 'targeting_activation');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `activation_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Activation ID');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Audience ID');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `activation_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment ID');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `contract_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `creative_deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Deliverable Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `flight_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Line Item Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `lookalike_model_id` SET TAGS ('dbx_business_glossary_term' = 'Lookalike Model Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `suppression_list_id` SET TAGS ('dbx_business_glossary_term' = 'Suppression List Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`activation` ALTER COLUMN `tech_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Tech Partner Id (Foreign Key)');
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
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` SET TAGS ('dbx_subdomain' = 'targeting_activation');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `lookalike_model_id` SET TAGS ('dbx_business_glossary_term' = 'Lookalike Model Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `contract_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Development Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Seed Segment Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `tech_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Tech Partner Id (Foreign Key)');
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
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `refresh_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Refresh Frequency (Days)');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `similarity_threshold` SET TAGS ('dbx_business_glossary_term' = 'Similarity Threshold');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `training_date` SET TAGS ('dbx_business_glossary_term' = 'Model Training Date');
ALTER TABLE `advertising_ecm`.`audience`.`lookalike_model` ALTER COLUMN `validation_accuracy` SET TAGS ('dbx_business_glossary_term' = 'Validation Accuracy');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` SET TAGS ('dbx_subdomain' = 'targeting_activation');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `suppression_list_id` SET TAGS ('dbx_business_glossary_term' = 'Suppression List Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Client Brand Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `contract_insertion_order_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Insertion Order Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Creation Initiative Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Data Supplier Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `tech_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Tech Partner Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `flight_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Governing Agreement Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Source Segment Id (Foreign Key)');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `archive_date` SET TAGS ('dbx_business_glossary_term' = 'Archive Date');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `consent_withdrawal_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Flag');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `data_cost` SET TAGS ('dbx_business_glossary_term' = 'Data Cost');
ALTER TABLE `advertising_ecm`.`audience`.`suppression_list` ALTER COLUMN `data_cost` SET TAGS ('dbx_confidential' = 'true');
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
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` SET TAGS ('dbx_subdomain' = 'audience_segmentation');
ALTER TABLE `advertising_ecm`.`audience`.`taxonomy` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Taxonomy Identifier (ID)');
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
