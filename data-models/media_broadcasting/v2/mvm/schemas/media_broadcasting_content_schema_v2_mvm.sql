-- Schema for Domain: content | Business: Media_Broadcasting | Version: v2_mvm
-- Generated on: 2026-06-23 04:24:39

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`content` COMMENT 'Single source of truth for all content assets across the enterprise — covering titles, episodes, series, films, clips, music, news segments, and live events. Manages content metadata (EIDR, ISAN, ISRC identifiers), format specifications, versioning, localization, MPA ratings, genre classification, and content lifecycle from acquisition through archival. Serves as the master catalog referenced by scheduling, distribution, rights, and digital asset domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`title` (
    `title_id` BIGINT COMMENT 'Unique identifier for the content title. Primary key for the title master catalog. Serves as the universal join point referenced by scheduling, distribution, rights, digital asset, and advertising domains.',
    `genre_id` BIGINT COMMENT 'FK to content.genre',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Title-level rights clearance status reports require knowing the governing license agreement at the title level. Rights operations teams produce title-level rights summaries for content catalogs; witho',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Title-level master asset reference is standard in broadcast MAM/CMS integration for rights clearance reports, archive management, and asset-to-title reconciliation. A domain expert expects the canonic',
    `holder_id` BIGINT COMMENT 'Foreign key linking to rights.rights_holder. Business justification: Tracks who owns/controls rights to each title - essential for royalty payments, clearance workflows, and determining who must approve licensing deals. Rights holder is the starting point for all right',
    `rating_id` BIGINT COMMENT 'Official content rating assigned by the Motion Picture Association or television rating authority. Determines audience suitability, broadcast restrictions, and parental control settings. [ENUM-REF-CANDIDATE: G|PG|PG-13|R|NC-17|TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA|NR — 12 candidates stripped; promote to reference product]',
    `series_id` BIGINT COMMENT 'Foreign key reference to the parent series for episodic content. Null for standalone films, clips, and non-episodic content.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Titles have primary production/distribution territories that affect rights clearance, regulatory compliance (content ratings), and default licensing assumptions. Clearance workflows validate against t',
    `acquisition_date` DATE COMMENT 'Date when the content rights were acquired by the organization. Used for rights lifecycle tracking, amortization calculations, and contract management.',
    `archive_date` DATE COMMENT 'Date when the content was moved to archived status. Used for content lifecycle management and digital asset retention policies.',
    `aspect_ratio` DECIMAL(18,2) COMMENT 'Display aspect ratio of the content. Determines presentation format for broadcast, streaming, and theatrical distribution.',
    `audio_description_available_flag` BOOLEAN COMMENT 'Indicates whether audio description track is available for visually impaired audiences. Required for accessibility compliance and inclusive broadcasting.',
    `closed_caption_available_flag` BOOLEAN COMMENT 'Indicates whether closed captioning is available for the content. Required for FCC compliance and accessibility standards.',
    `coppa_child_directed_flag` BOOLEAN COMMENT 'Indicates whether the content is directed to children under 13 years of age. Triggers COPPA compliance requirements for data collection, advertising restrictions, and privacy protections.',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 code representing the country where the content was originally produced. Used for rights management, regulatory compliance, and content origin reporting.. Valid values are `^[A-Z]{3}$`',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the title record was first created in the system. Used for audit trails, data lineage tracking, and operational reporting.',
    `distributor_name` STRING COMMENT 'Name of the primary distributor or licensor of the content. Used for rights management, financial reconciliation, and contract tracking.',
    `episode_number` STRING COMMENT 'Episode number within the season for episodic content. Null for non-episodic content. Used for sequential ordering in playout and Electronic Program Guide (EPG) systems.',
    `hd_available_flag` BOOLEAN COMMENT 'Indicates whether a high-definition version of the content is available. Used for channel playout decisions and quality-tier distribution strategies.',
    `isan` STRING COMMENT 'International standard identifier for audiovisual works. Primarily used for films and television programs for rights management and distribution tracking.. Valid values are `^ISAN [A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `isrc` STRING COMMENT 'International standard code for uniquely identifying sound recordings and music video recordings. Used for music tracks and audio content royalty tracking.. Valid values are `^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$`',
    `keywords` STRING COMMENT 'Comma-separated list of keywords and tags describing content themes, subjects, and topics. Used for search optimization, content discovery, and recommendation algorithms.',
    `title_name` STRING COMMENT 'Primary display name of the content title. The human-readable identifier used across all systems and customer-facing platforms.',
    `original_language` STRING COMMENT 'ISO 639-2 three-letter code representing the original language of the content production. Used for localization planning, dubbing, and subtitle workflows.. Valid values are `^[A-Z]{3}$`',
    `original_title` STRING COMMENT 'Original title name in the native language of production. Preserved for rights management, archival, and international distribution purposes.',
    `parental_advisory_flag` BOOLEAN COMMENT 'Indicates whether the content carries a parental advisory warning for explicit content, violence, or mature themes. Used for compliance with broadcast standards and platform content policies.',
    `premiere_flag` BOOLEAN COMMENT 'Indicates whether the content is a premiere or first-run broadcast. Used for promotional scheduling, advertising premium pricing, and audience measurement reporting.',
    `production_year` STRING COMMENT 'Calendar year in which the content was originally produced or completed. Used for catalog organization, rights windowing calculations, and archival classification.',
    `release_date` DATE COMMENT 'Date when the content was first released to the public or premiered. Used for rights availability calculations, windowing strategies, and anniversary programming.',
    `runtime_seconds` STRING COMMENT 'Total duration of the content in seconds. Used for program scheduling, ad pod allocation, playout automation, and Electronic Program Guide (EPG) generation.',
    `season_number` STRING COMMENT 'Season number within the parent series for episodic content. Null for non-episodic content. Used for catalog organization and Electronic Program Guide (EPG) display.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `studio_name` STRING COMMENT 'Name of the studio or production company that produced the content. Used for rights attribution, royalty calculations, and catalog organization.',
    `sub_genre` STRING COMMENT 'Secondary or more granular genre classification providing additional content categorization for advanced audience segmentation and personalization.',
    `synopsis_long` STRING COMMENT 'Detailed narrative description of the content. Used for promotional materials, streaming platform detail pages, and comprehensive program guides.',
    `synopsis_short` STRING COMMENT 'Brief summary of the content, typically 50-100 characters. Used for Electronic Program Guide (EPG) listings, mobile applications, and quick reference displays.',
    `theatrical_release_flag` BOOLEAN COMMENT 'Indicates whether the content had a theatrical release. Used for windowing strategy, rights holdback periods, and marketing classification.',
    `uhd_4k_available_flag` BOOLEAN COMMENT 'Indicates whether an Ultra HD 4K version of the content is available. Used for premium streaming tiers and next-generation broadcast services.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the title record was last modified. Used for change tracking, data synchronization, and audit compliance.',
    CONSTRAINT pk_title PRIMARY KEY(`title_id`)
) COMMENT 'Master catalog record for every content asset across the enterprise — films, series, episodes, clips, music tracks, news segments, and live events. Serves as the authoritative SSOT for content identity, carrying EIDR, ISAN, and ISRC identifiers, MPA content rating, genre classification, original language, country of origin, production year, content type discriminator (film/series/episode/clip/music/news/live), runtime in seconds, content status (active/archived/restricted), parental advisory flags, COPPA child-directed flag, and lifecycle timestamps. Acts as the universal join point referenced by scheduling, distribution, rights, digital asset, and advertising domains. Format-level technical specifications are managed by the version and digital asset domains.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`series` (
    `series_id` BIGINT COMMENT 'Unique identifier for the series. Primary key for the series master record.',
    `genre_id` BIGINT COMMENT 'Foreign key linking to content.genre. Business justification: Series have genre classification. Normalizes genre_primary/genre_secondary string columns to reference the enterprise genre taxonomy.',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Series-level license agreements govern all seasons and episodes; a series-level FK enables top-down rights reporting and renewal tracking. Rights managers need to identify the master agreement for a s',
    `partner_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_partner. Business justification: Series-level syndication and distribution deals are negotiated with specific distribution partners. The distributor plain-text field is a denormalized representation of distribution_partner. Linking',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Series-level exclusive OTT platform deals (e.g., Netflix originals, Hulu exclusives) are a named business process in streaming rights management. Platform acquisition teams negotiate series-level excl',
    `holder_id` BIGINT COMMENT 'Foreign key linking to rights.rights_holder. Business justification: Series-level rights ownership (studio/production company) drives all downstream licensing and royalty flows. Franchise management and multi-season deal negotiations require knowing the primary rights ',
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.content_rating. Business justification: A series carries an overall content rating (e.g., TV-MA, TV-14) that governs scheduling, parental controls, and platform eligibility. The series table currently has no content_rating_id FK, leaving th',
    `profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: A series has a designated showrunner/creator who is a named talent profile. This is required for guild backend participation calculations, WGA credits registration, and production accountability repor',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: Series-level territory assignment drives syndication eligibility reporting and rights clearance workflows. A rights manager expects to know which territory a series is licensed for without traversing ',
    `archive_location` STRING COMMENT 'Physical or logical location identifier where the series master content and metadata are archived. Used for Digital Asset Management (DAM) and Media Asset Management (MAM) retrieval.',
    `aspect_ratio` DECIMAL(18,2) COMMENT 'Standard aspect ratio for the series video format. Critical for playout configuration, transcoding workflows, and multi-platform distribution.',
    `audio_description_available` BOOLEAN COMMENT 'Indicates whether audio description track is available for visually impaired viewers. Required for accessibility compliance in many jurisdictions.',
    `closed_caption_available` BOOLEAN COMMENT 'Indicates whether closed captioning is available for the series. Required for regulatory compliance under FCC accessibility rules and international broadcasting standards.',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country where the series was originally produced. Used for content quotas, regulatory compliance, and international rights management.. Valid values are `^[A-Z]{3}$`',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the series record was first created in the system. Used for audit trail and data lineage tracking.',
    `episode_runtime_minutes` STRING COMMENT 'Standard runtime duration in minutes for a typical episode of the series, excluding commercials. Used for scheduling, ad pod planning, and playout automation.',
    `finale_date` DATE COMMENT 'Date when the final episode of the series aired or was released. Null for ongoing series. Used for syndication eligibility and rights holdback period calculations.',
    `franchise_name` STRING COMMENT 'Brand name of the content franchise or show brand. Used for grouping related series, spin-offs, and reboots under a common brand umbrella.',
    `keywords` STRING COMMENT 'Comma-separated list of searchable keywords and tags for content discovery, Electronic Program Guide (EPG) search, and recommendation engine optimization.',
    `language_original` STRING COMMENT 'ISO 639-3 three-letter code for the original production language of the series. Used for localization planning and international distribution.. Valid values are `^[a-z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the series record was last modified. Used for change tracking, audit compliance, and data synchronization across systems.',
    `original_network` STRING COMMENT 'Name of the original broadcast network or streaming platform that first aired or released the series. Critical for rights management and syndication deals.',
    `premiere_date` DATE COMMENT 'Date when the first episode of the series originally aired or was released. Marks the beginning of the series lifecycle and is used for rights windowing calculations.',
    `production_company` STRING COMMENT 'Name of the primary production company or studio that produced the series. Critical for rights ownership, residuals calculations, and syndication negotiations.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `syndication_eligible` BOOLEAN COMMENT 'Indicates whether the series meets the minimum episode threshold and rights clearance requirements for syndication to secondary markets and broadcast stations.',
    `synopsis_long` STRING COMMENT 'Detailed multi-paragraph description of the series premise, themes, and narrative arc. Used for marketing materials, press releases, and content catalogs.',
    `synopsis_short` STRING COMMENT 'Brief one-sentence description of the series premise. Used for Electronic Program Guide (EPG) listings, mobile applications, and social media promotion.',
    `target_demographic` STRING COMMENT 'Primary audience demographic segment the series is designed to reach. Used for advertising sales, scheduling strategy, and Target Rating Point (TRP) calculations. [ENUM-REF-CANDIDATE: adults_18_49|adults_25_54|adults_18_34|children_2_11|teens_12_17|women_18_49|men_18_49|total_viewers — promote to reference product]',
    `title` STRING COMMENT 'Official title of the series as registered and marketed. Primary human-readable identifier for the content franchise.',
    `title_original` STRING COMMENT 'Original title of the series in its native language and market before localization or translation.',
    `total_episode_count` STRING COMMENT 'Cumulative count of all episodes produced across all seasons. Includes specials and pilot episodes.',
    `total_season_count` STRING COMMENT 'Total number of seasons produced for the series to date. Updated as new seasons are commissioned and produced.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    CONSTRAINT pk_series PRIMARY KEY(`series_id`)
) COMMENT 'Master record for a serialized content franchise or show brand — the parent container above seasons and episodes. Captures series title, franchise identifier, series type (scripted/unscripted/documentary/news/sports/reality), total season count, original network/platform, premiere date, finale date, series status (ongoing/ended/cancelled/hiatus), genre taxonomy, target demographic, content rating band, and brand metadata. Enables hierarchical content navigation from series → season → episode and supports scheduling, rights windowing, and syndication deal structures.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`season` (
    `season_id` BIGINT COMMENT 'Unique identifier for the season record. Primary key.',
    `genre_id` BIGINT COMMENT 'Foreign key linking to content.genre. Business justification: Seasons have genre classification. Normalizes genre_primary/genre_secondary string columns to reference the enterprise genre taxonomy.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: Seasons are cleared against specific rights grants for run-count and holdback enforcement. Season-level grant tracking enables rights expiry alerts and run-limit compliance reporting without requiring',
    `holder_id` BIGINT COMMENT 'Foreign key linking to rights.holder. Business justification: Seasons have a rights holder for royalty and residuals tracking. The plain rights_holder text column is a denormalization of the holder entity. Rights operations require knowing which holder to pay ',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Season-specific licensing (e.g., Season 1 to Netflix, Season 2 to Hulu) is common in streaming. Clearance and windowing decisions require knowing which agreement controls each seasons distribution ri',
    `media_asset_id` BIGINT COMMENT 'Reference to the season trailer asset in the MAM system. Used for promotional campaigns and platform previews.',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Season-by-season OTT platform availability is a standard streaming rights construct (e.g., Season 1 on Netflix, Season 2 on Hulu). Platform availability reporting and rights management at the season l',
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.content_rating. Business justification: Individual seasons of a series can carry different content ratings as the show evolves (e.g., a series may escalate from TV-PG to TV-14 in later seasons). The season table has no content_rating_id FK ',
    `series_id` BIGINT COMMENT 'Reference to the parent series to which this season belongs.',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: A season is a distinct content asset registered in the master title catalog — seasons carry their own ISAN and EIDR identifiers (visible in season attributes), confirming they are independently catalo',
    `archive_date` DATE COMMENT 'Date when the season was moved to archival storage. Used for asset lifecycle management and retrieval planning.',
    `archive_location` STRING COMMENT 'Physical or digital archive location where the seasons master assets are stored. Critical for long-term preservation and retrieval.',
    `awards_nominated` STRING COMMENT 'Comma-separated list of major award nominations received by the season. Supports promotional messaging and content valuation.',
    `awards_won` STRING COMMENT 'Comma-separated list of major awards won by the season (e.g., Emmy, Golden Globe). Used for marketing and promotional value enhancement.',
    `banner_artwork_url` STRING COMMENT 'URL reference to the seasons banner or hero image for wide-format displays on streaming platforms and websites.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the season record was first created in the system. Used for audit trail and data lineage.',
    `distributor` STRING COMMENT 'Name of the primary distributor handling the seasons commercial distribution. Key for carriage agreements and revenue sharing.',
    `eidr` STRING COMMENT 'Globally unique EIDR identifier for the season, enabling cross-platform content identification and rights management.. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `episode_count_aired` STRING COMMENT 'Number of episodes that have been broadcast or released to audiences. Used for tracking release progress.',
    `episode_count_ordered` STRING COMMENT 'Number of episodes originally ordered or commissioned for this season by the network or platform.',
    `episode_count_produced` STRING COMMENT 'Actual number of episodes produced and delivered for this season. May differ from ordered count due to production changes.',
    `finale_date` DATE COMMENT 'Date when the final episode of the season was broadcast or released. Marks the end of the seasons linear run.',
    `isan` STRING COMMENT 'International standard identifier for audiovisual works, used for season-level identification in global distribution and rights management.. Valid values are `^ISAN [A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `language_original` STRING COMMENT 'ISO 639-3 three-letter code for the original production language of the season. Critical for localization and distribution planning.. Valid values are `^[a-z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the season record was last modified. Supports change tracking and audit compliance.',
    `network_original` STRING COMMENT 'Name of the network or platform that originally commissioned or first aired the season. Used for windowing and exclusivity tracking.',
    `original_air_date` DATE COMMENT 'Date when the first episode of the season was originally broadcast or released. Key for windowing and rights calculations.',
    `poster_artwork_url` STRING COMMENT 'URL reference to the seasons primary poster artwork stored in the Media Asset Management (MAM) system. Used for EPG, VOD, and promotional displays.',
    `production_company` STRING COMMENT 'Name of the primary production company responsible for creating the season. Used for rights attribution and royalty calculations.',
    `production_year` STRING COMMENT 'Calendar year in which the season was produced. Used for cataloging, rights management, and archival purposes.',
    `rights_expiry_date` DATE COMMENT 'Date when current distribution rights for the season expire. Triggers rights renewal workflows and availability restrictions.',
    `season_number` STRING COMMENT 'Sequential number of the season within the series (e.g., 1 for Season 1, 2 for Season 2). Used for ordering and identification.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `synopsis_long` STRING COMMENT 'Detailed season-level synopsis providing comprehensive narrative overview. Used for promotional materials, VOD platforms, and press releases.',
    `synopsis_short` STRING COMMENT 'Brief season-level synopsis (typically 50-150 characters) used for Electronic Program Guide (EPG) listings and mobile displays.',
    `total_runtime_minutes` STRING COMMENT 'Cumulative runtime of all episodes in the season, measured in minutes. Used for scheduling blocks and VOD packaging.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    CONSTRAINT pk_season PRIMARY KEY(`season_id`)
) COMMENT 'Master record representing a discrete production cycle of a series, grouping episodes into an ordered season. Tracks season number, season title, episode count (ordered and total), production year, original air year, season status (in-production/completed/archived), season-level content rating, season-level synopsis, and promotional artwork references. Bridges the series-to-episode hierarchy and supports season-level rights licensing, scheduling blocks, and VOD packaging.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`episode` (
    `episode_id` BIGINT COMMENT 'Unique identifier for the episode within the content management system. Primary key for the content episode entity.',
    `clearance_request_id` BIGINT COMMENT 'Foreign key linking to rights.clearance_request. Business justification: Episodes require clearance before broadcast; clearance_request tracks talent approval, music clearance, and residuals triggers at the episode level. Broadcast operations cannot schedule an episode wit',
    `season_id` BIGINT COMMENT 'Reference to the specific season within the series to which this episode belongs. Enables season-level grouping and rights management.',
    `series_id` BIGINT COMMENT 'Reference to the parent series to which this episode belongs. Links episode to its series container.',
    `genre_id` BIGINT COMMENT 'Foreign key linking to content.genre. Business justification: Episodes have genre classification. Normalizes genre_primary/genre_secondary string columns to reference the enterprise genre taxonomy.',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Episode-level syndication deals (especially for high-value episodes like finales or specials) require direct linkage to license agreements for run-count tracking and residual calculations.',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Broadcast playout and VOD distribution require direct lookup of the master media asset file for each episode. Traffic systems and playout automation depend on episode-to-asset mapping for scheduling a',
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.content_rating. Business justification: content_episode currently stores content advisory information as a free-text STRING column (content_advisory), which is unstructured and prevents deterministic filtering, analytics, and compliance r',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: Episode-level territory clearance is required for GDPR/COPPA compliance reporting and geo-blocking enforcement. Rights operations teams track which territory each episode is cleared for broadcast; no ',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Episodes ARE titles in the master catalog. Every episode should reference its title record for unified content identification and metadata management.',
    `archive_date` DATE COMMENT 'Date when the episode master was moved to long-term archive storage. Used for asset lifecycle management and storage optimization.',
    `archive_location` STRING COMMENT 'Physical or logical location identifier for the archived master copy in the Media Asset Management (MAM) system. Supports long-term preservation and retrieval.',
    `aspect_ratio` DECIMAL(18,2) COMMENT 'Display aspect ratio of the episode video. Affects playout configuration, transcoding profiles, and distribution format specifications.',
    `audio_description_available` BOOLEAN COMMENT 'Indicates whether audio description track is available for visually impaired viewers. Required for accessibility compliance.',
    `broadcast_count` STRING COMMENT 'Total number of times this episode has been broadcast on linear television. Used for residuals calculation and syndication rights management.',
    `closed_caption_available` BOOLEAN COMMENT 'Indicates whether closed captioning is available for this episode. Required for FCC compliance and accessibility standards.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the episode record was first created in the content management system. Used for audit trail and data lineage tracking.',
    `eidr_identifier` STRING COMMENT 'Globally unique identifier for the episode registered with the Entertainment Identifier Registry. Enables universal content identification across distribution platforms and rights management systems.. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `episode_number` STRING COMMENT 'Sequential number of the episode within its season. Used for ordering and identification in Electronic Program Guide (EPG) and Video On Demand (VOD) catalogs.',
    `keywords` STRING COMMENT 'Comma-separated list of keywords and tags describing episode themes, topics, and notable elements. Supports content search, discovery, and metadata enrichment.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the episode record was last modified. Supports change tracking and data quality monitoring.',
    `music_cue_sheet_submitted` BOOLEAN COMMENT 'Indicates whether the music cue sheet has been submitted for royalty collection. Required for music rights compliance and royalty distribution.',
    `original_air_date` DATE COMMENT 'The date when the episode was first broadcast on linear television. Critical for rights windowing, residuals calculation, and syndication eligibility.',
    `premiere_flag` BOOLEAN COMMENT 'Indicates whether this is a premiere episode (first broadcast). Used for promotional planning, upfront advertising sales, and Nielsen sweeps period strategy.',
    `primary_language` STRING COMMENT 'ISO 639-3 three-letter code for the primary audio language of the episode. Used for content cataloging, rights clearance, and distribution targeting.. Valid values are `^[a-z]{3}$`',
    `rerun_flag` BOOLEAN COMMENT 'Indicates whether this broadcast is a rerun. Affects advertising rates, Cost Per Rating Point (CPRP) calculations, and residuals payments to talent.',
    `runtime_seconds` STRING COMMENT 'Total duration of the episode content in seconds, excluding commercial breaks. Used for playout scheduling, ad pod allocation, and Electronic Program Guide (EPG) display.',
    `runtime_with_ads_seconds` STRING COMMENT 'Total broadcast duration including commercial ad breaks. Used for linear scheduling and daypart planning.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `subtitles_available` BOOLEAN COMMENT 'Indicates whether subtitle tracks are available for this episode. Supports international distribution and localization strategies.',
    `synopsis_long` STRING COMMENT 'Detailed description of the episode plot, themes, and key moments. Used for Video On Demand (VOD) platforms, promotional materials, and content discovery.',
    `synopsis_short` STRING COMMENT 'Brief summary of the episode content, typically 50-100 characters. Used for Electronic Program Guide (EPG) listings and mobile applications with limited display space.',
    `title` STRING COMMENT 'The official title or name of the episode. Displayed in Electronic Program Guide (EPG), Video On Demand (VOD) interfaces, and promotional materials.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `video_resolution` STRING COMMENT 'Maximum video resolution available for this episode. Determines distribution channel eligibility and Adaptive Bitrate Streaming (ABR) profile selection.. Valid values are `SD|HD|FHD|UHD|4K|8K`',
    `vod_available_from_date` DATE COMMENT 'Date when the episode becomes available on Video On Demand (VOD) platforms. Part of windowing strategy and rights holdback management.',
    `vod_available_until_date` DATE COMMENT 'Date when the episode is removed from Video On Demand (VOD) platforms. Enforces rights windows and exclusivity periods.',
    CONSTRAINT pk_episode PRIMARY KEY(`episode_id`)
) COMMENT 'Master record for an individual episode within a series season. Captures episode number, episode title, production code, original broadcast date, runtime, episode type (standard/special/pilot/finale/recap), episode synopsis, content rating, EIDR episode identifier, closed-caption availability flag, audio description flag, and episode status. Supports EPG scheduling, VOD availability windows, rights clearance at episode level, and residuals calculation for talent reuse payments.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`version` (
    `version_id` BIGINT COMMENT 'Primary key for version',
    `abr_profile_id` BIGINT COMMENT 'Foreign key linking to distribution.abr_profile. Business justification: Content versions are encoded to specific ABR profiles (HLS ladder, DASH manifest). Essential for transcode workflow, QC validation, and ensuring version matches target platforms adaptive bitrate stre',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: Content versions (editorial/rights cuts) map to specific technical asset versions (renditions). Distribution and delivery workflows require knowing which exact rendition corresponds to each content ve',
    `clearance_request_id` BIGINT COMMENT 'Foreign key linking to rights.clearance_request. Business justification: A version cannot be distributed until its clearance request is resolved (music sync, talent approval). Linking version to clearance_request enables compliance gating in distribution workflows and QC s',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Content versions are technically prepared and certified for specific delivery channels (HD version for OTT, SD for cable). The target_platform plain-text field is a denormalized representation of de',
    `drm_policy_id` BIGINT COMMENT 'Foreign key linking to distribution.drm_policy. Business justification: Each content version is protected by specific DRM policy (Widevine L1, HDCP 2.2 requirements). Required for rights enforcement, device compatibility validation, and studio compliance in premium conten',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Version-specific grants (4K rights vs HD rights, dubbed vs subtitled) are tracked separately in modern distribution. Clearance systems must validate that the specific version has an active grant.',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Different versions (theatrical cut, directors cut, TV edit, international dub) often have separate rights agreements with distinct terms. Clearance and distribution workflows require version-specific',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Each content version (territory/platform-specific cut) references its master media asset for distribution. Fulfillment workflows require version-to-asset mapping to deliver correct files to platforms ',
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.content_rating. Business justification: The version table tracks distinct cuts and edits of a title — including censored versions, broadcast-safe edits, and territory-specific versions — each of which may carry a different content rating th',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: Versions are mastered for specific territories (regional censorship cuts, PAL/NTSC, language versions). The plain target_territory text column is a denormalization of rights_territory. Territory-lev',
    `title_id` BIGINT COMMENT 'Reference to the master content asset (title, episode, series, film, clip, music, news segment, or live event) that this version belongs to.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this version was approved for distribution and playout.',
    `archived_timestamp` TIMESTAMP COMMENT 'Timestamp when this version was moved to long-term archive storage.',
    `aspect_ratio` DECIMAL(18,2) COMMENT 'Display aspect ratio of this version (e.g., 16:9, 4:3, 21:9, 2.39:1).',
    `audio_codec` STRING COMMENT 'Audio compression codec used for this version (e.g., AAC, AC-3, E-AC-3, Dolby Atmos, DTS).',
    `audio_description_available` BOOLEAN COMMENT 'Indicates whether audio description track is available for visually impaired audiences, supporting accessibility compliance.',
    `audio_track_configuration` STRING COMMENT 'Comma-separated list of audio track languages and types available in this version (e.g., en:stereo,es:5.1,fr:stereo,en:descriptive).',
    `broadcast_safe` BOOLEAN COMMENT 'Indicates whether this version has been certified as broadcast-safe, meeting technical standards for linear transmission (audio levels, video levels, closed captioning).',
    `checksum_md5` STRING COMMENT 'MD5 hash checksum of the version file, used for integrity verification during transfer and archival.. Valid values are `^[a-f0-9]{32}$`',
    `closed_caption_available` BOOLEAN COMMENT 'Indicates whether closed captioning (CC) is available for this version, supporting accessibility compliance.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this version record was first created in the system.',
    `file_size_bytes` BIGINT COMMENT 'Total file size of this version in bytes, used for storage planning and delivery bandwidth estimation.',
    `frame_rate` DECIMAL(18,2) COMMENT 'Frame rate of this version in frames per second (e.g., 23.98, 24.00, 25.00, 29.97, 30.00, 50.00, 59.94, 60.00).',
    `label` STRING COMMENT 'Human-readable label identifying this version (e.g., Theatrical Cut, Directors Cut, Broadcast Safe, Spanish Dub, UK Censored).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this version record was last modified.',
    `qc_completed_date` DATE COMMENT 'Date when quality control review was completed for this version.',
    `resolution` STRING COMMENT 'Video resolution classification for this version (SD, HD 720p, HD 1080p, UHD 4K, UHD 8K).. Valid values are `sd|hd_720p|hd_1080p|uhd_4k|uhd_8k`',
    `runtime_delta_seconds` STRING COMMENT 'Difference in runtime (in seconds) between this version and the master version. Positive values indicate longer runtime, negative indicate shorter.',
    `runtime_seconds` STRING COMMENT 'Total runtime of this version in seconds, representing the complete playback duration.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `storage_location` STRING COMMENT 'Physical or logical storage location identifier where this version is archived (e.g., tape library ID, cloud bucket path, MAM archive reference).',
    `subtitle_languages` STRING COMMENT 'Comma-separated list of ISO 639 language codes for subtitle tracks included in this version (e.g., en,es,fr,de).',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `video_codec` STRING COMMENT 'Video compression codec used for this version (e.g., H.264, H.265/HEVC, VP9, AV1, MPEG-2).',
    CONSTRAINT pk_version PRIMARY KEY(`version_id`)
) COMMENT 'Tracks every distinct version of a title — including edits, cuts, localized dubs, censored versions, broadcast-safe edits, theatrical vs. extended cuts, and format variants (SD/HD/4K). Each version record carries version type (theatrical/broadcast/director/unrated/censored/dubbed/subtitled), version label, target territory, target platform, runtime delta from master, language track configuration, subtitle language list, aspect ratio override, and version status. Enables multi-platform distribution where different versions are delivered to different windows and territories.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`genre` (
    `genre_id` BIGINT COMMENT 'Unique identifier for the genre. Primary key for the genre reference taxonomy.',
    `parent_genre_id` BIGINT COMMENT 'Reference to the parent genre in the hierarchical taxonomy, enabling multi-level classification such as Drama > Legal Drama or Sports > Football. Null for top-level genres.',
    `ad_pod_compatibility` BOOLEAN COMMENT 'Indicates whether content in this genre is compatible with Dynamic Ad Insertion (DAI) and ad pod placement. False for genres requiring uninterrupted viewing (e.g., live sports critical moments, news breaking coverage).',
    `applicable_content_types` STRING COMMENT 'Comma-separated list of content types to which this genre applies (e.g., series, film, clip, live_event, news_segment, music_video). Enables content-type-specific genre filtering.',
    `archive_retention_policy` STRING COMMENT 'Digital asset archival retention policy for content in this genre. Permanent retention for high-value evergreen genres; short-term for time-sensitive news and event content.. Valid values are `permanent|long_term|standard|short_term`',
    `avod_monetization_potential` STRING COMMENT 'Revenue generation potential for this genre on Advertising-Supported Video On Demand (AVOD) platforms, based on Cost Per Mille (CPM) rates and advertiser demand. High-potential genres command premium ad rates.. Valid values are `high|medium|low`',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this genre record was first created in the enterprise content taxonomy system.',
    `daypart_affinity` STRING COMMENT 'Comma-separated list of broadcast dayparts where this genre typically performs best (e.g., prime_time, late_night, early_morning, daytime, weekend). Informs program scheduling and playout automation strategies.',
    `genre_description` STRING COMMENT 'Detailed textual description of the genre, including defining characteristics, typical content examples, and audience expectations. Used for editorial guidance and content acquisition briefings.',
    `effective_end_date` DATE COMMENT 'Date when this genre classification was retired or superseded. Null for currently active genres. Used for historical content classification and reporting continuity.',
    `effective_start_date` DATE COMMENT 'Date when this genre classification became effective and available for use in content metadata and scheduling systems.',
    `eidr_genre_mapping` STRING COMMENT 'Mapping to Entertainment Identifier Registry (EIDR) genre taxonomy for cross-industry content identification and rights management interoperability.',
    `fast_channel_applicability` BOOLEAN COMMENT 'Indicates whether this genre is suitable for Free Ad-Supported Streaming Television (FAST) linear channel programming. FAST channels require genres with deep catalog availability and consistent audience appeal.',
    `geographic_restriction_applicability` BOOLEAN COMMENT 'Indicates whether content in this genre is subject to geographic blackout restrictions or regional licensing constraints. Common for sports genres with territorial rights and retransmission consent agreements.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this genre is currently active and available for content classification. Inactive genres are retained for historical content but not used for new acquisitions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this genre record was last updated. Used for change tracking and metadata synchronization across Electronic Program Guide (EPG), Media Asset Management (MAM), and distribution systems.',
    `linear_broadcast_suitability` BOOLEAN COMMENT 'Indicates whether this genre is suitable for traditional linear scheduled broadcasting. Some genres (e.g., interactive, choose-your-own-adventure) are non-linear only.',
    `localization_priority` STRING COMMENT 'Priority level for content localization (dubbing, subtitling, cultural adaptation) for this genre. High-priority genres justify investment in multi-language versions for international distribution.. Valid values are `high|medium|low`',
    `metadata_enrichment_priority` STRING COMMENT 'Priority level for metadata enrichment and tagging in Media Asset Management (MAM) systems. Critical genres require comprehensive metadata for content discovery and personalization.. Valid values are `critical|standard|minimal`',
    `mpa_rating_applicability` STRING COMMENT 'Comma-separated list of Motion Picture Association (MPA) ratings typically associated with this genre (e.g., G, PG, PG-13, R, NC-17). Used for content clearance and daypart scheduling compliance.',
    `genre_name` STRING COMMENT 'Full display name of the genre as presented to audiences in Electronic Program Guides (EPG), streaming platform interfaces, and content discovery systems.',
    `ott_platform_priority` STRING COMMENT 'Priority level for featuring this genre on Over-The-Top (OTT) streaming platforms and Video On Demand (VOD) services. High priority genres receive prominent placement in content discovery and recommendation engines.. Valid values are `high|medium|low`',
    `parental_guidance_flag` BOOLEAN COMMENT 'Indicates whether content in this genre typically requires parental guidance warnings or viewer discretion advisories. Used for compliance with Federal Communications Commission (FCC) broadcast standards and Childrens Online Privacy Protection Act (COPPA) requirements.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `syndication_eligibility` BOOLEAN COMMENT 'Indicates whether content in this genre is typically eligible for syndication to multiple outlets and resale. Used in rights and royalties management and windowing strategy planning.',
    `target_demographic` STRING COMMENT 'Primary audience demographic segment targeted by this genre, expressed in Nielsen demographic notation (e.g., A18-49, M25-54, W18-34). Used for Target Rating Point (TRP) and Gross Rating Point (GRP) planning.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `usage_notes` STRING COMMENT 'Internal notes and guidelines for content producers, schedulers, and metadata specialists on proper application of this genre classification. Includes edge cases and disambiguation rules.',
    CONSTRAINT pk_genre PRIMARY KEY(`genre_id`)
) COMMENT 'Enterprise reference taxonomy for content genre and sub-genre classification. Captures genre code, genre name, parent genre reference (enabling hierarchical sub-genres like Drama > Legal Drama), genre tier (primary/secondary), applicable content types, IAB content category mapping for ad targeting, and active status. Standardizes genre labeling across EPG systems, streaming platform metadata feeds, and advertising contextual targeting to ensure consistent audience segmentation and content discovery.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`localization` (
    `localization_id` BIGINT COMMENT 'Unique identifier for the localization work product record.',
    `clearance_request_id` BIGINT COMMENT 'Foreign key linking to rights.clearance_request. Business justification: Localization delivery is gated by clearance requests covering music sync and talent approval requirements. Rights operations cannot release a localized version until the associated clearance request i',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Localized versions (dubbed/subtitled) are commissioned for and delivered through specific delivery channels (e.g., Spanish dub for Latin America FAST channel). Localization project management requires',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: Localization (dubbing/subtitling) is authorized under a specific rights grant specifying language_version rights. Linking localization to grant enables rights expiry enforcement for localized assets a',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Localization work (dubbing, subtitling) is authorized under a license agreement specifying language rights. Rights compliance requires knowing which agreement authorizes each localization; without thi',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: Localization produces specific dubbed/subtitled renditions stored as asset_versions. Localization QC, delivery scheduling, and platform compliance workflows require the specific rendition reference, n',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Localized audio tracks and subtitle files are delivered as media assets. Distribution workflows require linking localization records to their delivered asset files for QC, versioning, and platform del',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Localizations are prepared for specific platform technical specs (Netflix TDF, iTunes metadata format). Platform-specific subtitle formats, audio track configurations, and metadata requirements drive ',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: Localization is produced for a specific territory; territory determines language requirements, regulatory compliance (GDPR, COPPA), and delivery obligations. Rights operations track territory-level lo',
    `version_id` BIGINT COMMENT 'Reference to the specific title version being localized.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Dubbing and voice localization require tracking which talent performed the localized version for residual payments, credit attribution, and guild reporting. Essential for international content distrib',
    `accessibility_standard_met` STRING COMMENT 'Specific accessibility standard that the localization work product complies with (e.g., WCAG 2.1 AA, FCC CVAA).. Valid values are `WCAG_2.1_AA|WCAG_2.2_AA|FCC_CVAA|EAA|ADA|none`',
    `actual_delivery_date` DATE COMMENT 'Actual date when the localization work product was delivered by the vendor or internal team.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the localization work product received final approval for distribution.',
    `approved_by_name` STRING COMMENT 'Name of the individual or role who provided final approval for the localization work product.',
    `asset_file_path` STRING COMMENT 'Storage location or URI path to the delivered localization asset file in the Media Asset Management (MAM) system or Content Delivery Network (CDN).',
    `character_count` STRING COMMENT 'Total number of characters in the subtitle or metadata translation work product, used for billing and capacity planning.',
    `compliance_certification_flag` BOOLEAN COMMENT 'Indicates whether the localization meets regulatory compliance requirements for the target territory (e.g., local content quotas, language laws, accessibility standards).',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for this localization work product, including vendor fees, studio costs, and internal labor.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this localization record was first created in the system.',
    `duration_minutes` DECIMAL(18,2) COMMENT 'Total runtime duration in minutes of the content being localized, relevant for dubbing and subtitling scope.',
    `order_date` DATE COMMENT 'Date when the localization work was ordered from the vendor or internal team.',
    `purchase_order_number` STRING COMMENT 'Purchase order number issued to the localization vendor for this work product.',
    `qc_notes` STRING COMMENT 'Detailed notes and findings from the quality control review process, including any defects or issues identified.',
    `qc_pass_flag` BOOLEAN COMMENT 'Boolean indicator of whether the localization work product passed quality control review.',
    `qc_review_date` DATE COMMENT 'Date when quality control review of the localization work product was completed.',
    `qc_reviewer_name` STRING COMMENT 'Name of the individual or team who performed the quality control review.',
    `revision_reason` STRING COMMENT 'Business reason or description for why a revision of the localization work product was required.',
    `scheduled_delivery_date` DATE COMMENT 'Contractually agreed or planned delivery date for the completed localization work product.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this localization record was last modified.',
    `version_number` STRING COMMENT 'Version identifier for this localization work product, supporting iterative revisions and updates.',
    CONSTRAINT pk_localization PRIMARY KEY(`localization_id`)
) COMMENT 'Tracks the localization work product for a specific title version in a target language and territory — covering dubbing, subtitling, metadata translation, and compliance adaptation. Captures localization type (dub/subtitle/metadata/forced-narrative), target language, target territory, localization vendor, delivery date, localization status (ordered/in-progress/delivered/approved/rejected), QC pass flag, subtitle format (SRT/TTML/WebVTT), and dubbing studio reference. Supports multi-territory distribution and regulatory compliance for local-language requirements.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` (
    `talent_credit_id` BIGINT COMMENT 'Unique identifier for the talent credit record. Primary key for the talent credit association entity.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to talent.talent_contract. Business justification: Credits must link to contracts for residual calculation, compensation verification, guild compliance reporting, and billing position validation. Fundamental to talent payment and rights management pro',
    `episode_id` BIGINT COMMENT 'Reference to the specific episode within a series for which the talent is credited. Nullable for non-episodic content such as films or specials.',
    `profile_id` BIGINT COMMENT 'Reference to the talent master record in the talent domain. Links to the individual or entity receiving credit for their contribution to the content.',
    `role_id` BIGINT COMMENT 'Foreign key linking to talent.talent_role. Business justification: Credits reference specific roles for character attribution, billing position validation, and role-specific residual eligibility. Eliminates denormalized role/character data and ensures single source o',
    `title_id` BIGINT COMMENT 'Reference to the content title (film, series, special, documentary) for which the talent is credited. Links to the content master catalog.',
    `billing_position` STRING COMMENT 'The ordinal position of the talent in the credit sequence, determining the order in which credits are displayed. Lower numbers indicate higher prominence (e.g., 1 = top billing). Used for EPG display and contractual compliance.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this talent credit record was first created in the system. Used for audit trails and data lineage tracking.',
    `credit_approval_date` DATE COMMENT 'The date on which the credit was officially approved for publication. Used for audit trails and compliance with guild credit determination timelines.',
    `credit_display_name` STRING COMMENT 'The exact name as it should appear in credits, EPG metadata, and streaming platform displays. May differ from the talents legal name if a pseudonym or stage name is used. This is the authoritative display value for all public-facing credit presentations.',
    `credit_display_order` STRING COMMENT 'The sequence number for displaying this credit within its credit type or section (e.g., within the cast section or crew section). Used for rendering credits in EPG, streaming platforms, and promotional materials.',
    `credit_end_timestamp` TIMESTAMP COMMENT 'The timestamp marking when this credit ceases to be effective or visible. Nullable for credits that remain active indefinitely. Used for managing credit corrections, disputes, or contractual credit windows.',
    `credit_notes` STRING COMMENT 'Free-text field for additional context, special credit requirements, contractual stipulations, or notes related to credit disputes, arbitration outcomes, or special billing arrangements.',
    `credit_start_timestamp` TIMESTAMP COMMENT 'The timestamp marking when this credit becomes effective or visible in EPG and streaming platform metadata. Used for managing credit changes over time and versioning.',
    `pseudonym_flag` BOOLEAN COMMENT 'Indicates whether the talent is credited under a pseudonym or stage name rather than their legal name. True if pseudonym is used; False if legal name is used. Relevant for guild compliance and contractual credit requirements.',
    `residuals_eligibility_flag` BOOLEAN COMMENT 'Indicates whether this credit qualifies the talent for residual payments based on content reuse, syndication, or secondary distribution. True if eligible; False otherwise. Triggers residuals calculation workflows in the rights and royalties domain.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `union_affiliation_flag` BOOLEAN COMMENT 'Indicates whether the talent is affiliated with a recognized industry union (SAG-AFTRA, DGA, WGA, IATSE) for this credit. True if union-affiliated; False otherwise. Used for residuals eligibility determination and compliance reporting.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this talent credit record was last modified. Used for audit trails, change tracking, and data quality monitoring.',
    CONSTRAINT pk_talent_credit PRIMARY KEY(`talent_credit_id`)
) COMMENT 'Association entity linking talent identities (owned by the talent domain) to specific titles and episodes with their credited role, billing position, character name, credit type (on-screen/off-screen), and credit display order. Captures SAG-AFTRA/WGA/DGA union affiliation flag, residuals eligibility flag, and credit approval status. Serves as the content domains authoritative credit roll for EPG metadata delivery, streaming platform cast display, and residuals calculation triggers. Does not duplicate the talent master record — references it via FK to the talent domain.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` (
    `acquisition_id` BIGINT COMMENT 'Primary key for acquisition',
    `clearance_request_id` BIGINT COMMENT 'Foreign key linking to rights.clearance_request. Business justification: Acquisitions may require clearance (music sync, talent residuals, third-party rights) before content can be exploited. Linking acquisition to clearance_request enables pre-exploitation compliance gati',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Acquisitions often specify which version was acquired (theatrical vs broadcast cut, localized version). This FK allows tracking version-specific acquisition terms and rights.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: An acquisition results in a specific rights grant; linking acquisition to grant enables run-count enforcement, holdback tracking, and royalty calculation. Rights managers need to know which grant was ',
    `holder_id` BIGINT COMMENT 'Foreign key linking to rights.holder. Business justification: Acquisitions are made from a specific rights holder; this drives payment scheduling, royalty calculation, and audit workflows. Rights operations teams must know which holder to pay minimum guarantees ',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Acquisition records must reference the underlying license agreement that enabled the acquisition. Financial reconciliation, audit trails, and rights validation require linking acquisitions to their go',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Content acquisition workflows require linking the acquisition transaction to the delivered media asset for delivery confirmation, QC audit, and rights-to-asset reconciliation reporting. Broadcast oper',
    `royalty_rule_id` BIGINT COMMENT 'Foreign key linking to rights.royalty_rule. Business justification: Acquisitions are governed by royalty rules that determine payment obligations and recoupment thresholds. Linking acquisition to royalty_rule enables automated royalty calculation at acquisition time a',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: Acquisitions are territory-scoped; the territory determines which rights were acquired and what royalty obligations apply. The plain territory_scope text column is a denormalization of rights_territ',
    `title_id` BIGINT COMMENT 'Reference to the content asset being acquired. Links to the master content catalog entry for the title, episode, series, film, clip, or other content asset.',
    `acquisition_date` DATE COMMENT 'The date on which the acquisition transaction was executed and the content rights were legally transferred or licensed to the enterprise. Represents the principal business event timestamp for this transaction.',
    `ancillary_rights_flag` BOOLEAN COMMENT 'Indicates whether ancillary rights (merchandising, soundtrack, publishing, remake, sequel, spin-off, clip licensing) are included in the acquisition (True) or retained by the supplier (False).',
    `cost_amount` DECIMAL(18,2) COMMENT 'The total monetary value paid or committed for acquiring the content rights. Represents the base acquisition cost before taxes, fees, or adjustments. For licenses, this is the total license fee; for purchases, the purchase price; for commissions, the production budget committed.',
    `cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the acquisition cost amount (e.g., USD, GBP, EUR, JPY).. Valid values are `^[A-Z]{3}$`',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this acquisition record was first created in the system. Audit field for data lineage and compliance tracking.',
    `delivery_date` DATE COMMENT 'The date on which the content master files and associated materials (metadata, artwork, closed captions, promotional assets) were delivered by the supplier and ingested into the enterprise Media Asset Management (MAM) system.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the acquired rights are exclusive (True) or non-exclusive (False) within the specified territory and window. Exclusive rights prevent the supplier from licensing the same content to competitors in the same territory/window.',
    `format_rights` STRING COMMENT 'The technical formats or delivery specifications covered by the acquisition. May include SD, HD, 4K, HDR, theatrical DCP, broadcast master, streaming-optimized, etc. Defines the quality and format tiers the enterprise is authorized to distribute.',
    `holdback_period_days` STRING COMMENT 'The number of days during which the content cannot be exploited in certain windows or territories as stipulated by the acquisition agreement. Holdback periods protect prior windows (e.g., theatrical holdback prevents SVOD release for 90 days post-theatrical).',
    `language_rights` STRING COMMENT 'The languages or language versions for which rights were acquired. May specify original language only, dubbed versions, subtitled versions, or all language adaptations. Examples: English, Spanish, French; All Languages; Original + Subtitles.',
    `license_end_date` DATE COMMENT 'The date on which the acquired content rights expire and the enterprise must cease exploitation. Null for perpetual purchases. For time-limited licenses, this defines the end of the license term.',
    `license_start_date` DATE COMMENT 'The date from which the enterprise is authorized to begin exploiting the acquired content rights. For licenses, this is the effective start of the license term; for purchases, typically the acquisition date.',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'The minimum guaranteed payment to the supplier regardless of actual revenue performance. Common in revenue-sharing deals where the enterprise commits to a floor payment even if royalties do not reach this threshold.',
    `notes` STRING COMMENT 'Free-text field for additional context, special terms, restrictions, or operational notes related to the acquisition. May include information on promotional obligations, credit requirements, or unique contractual stipulations.',
    `payment_terms` STRING COMMENT 'Contractual payment schedule and conditions for the acquisition cost. May include milestone-based payments, installment schedules, advance payments, or revenue-sharing arrangements.',
    `reference_number` STRING COMMENT 'External business identifier for this acquisition transaction. May be a purchase order number, deal reference, or contract line item identifier used in communications with the supplier.',
    `residuals_obligation_flag` BOOLEAN COMMENT 'Indicates whether the enterprise has an obligation to pay residuals (talent reuse payments) to performers, writers, directors, or other rights holders each time the content is rebroadcast or redistributed (True) or if residuals are the suppliers responsibility (False).',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'The percentage of revenue or receipts that must be paid to the supplier as ongoing royalties under a revenue-sharing acquisition model. Null if the acquisition is a flat-fee structure with no revenue share.',
    `runs_allowed` STRING COMMENT 'The maximum number of times the content may be broadcast or streamed under the acquisition agreement. Common in linear broadcast licenses (e.g., 3 runs over 2 years). Null indicates unlimited runs within the license period.',
    `runs_consumed` STRING COMMENT 'The number of runs (broadcasts or streams) that have been executed to date against the runs_allowed limit. Tracked to ensure compliance with contractual run restrictions.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `sublicensing_allowed_flag` BOOLEAN COMMENT 'Indicates whether the enterprise is permitted to sublicense the acquired content to third parties (True) or must exploit the content directly only (False). Sublicensing enables syndication and secondary distribution deals.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this acquisition record was last modified. Audit field for change tracking and data governance.',
    CONSTRAINT pk_acquisition PRIMARY KEY(`acquisition_id`)
) COMMENT 'Transactional record capturing the business event of acquiring content from an external source — studio, independent producer, syndicator, or distributor. Tracks acquisition type (purchase/license/co-production/commission), acquisition date, source party, acquisition cost, currency, content window acquired, territory scope, exclusivity flag, holdback period, acquisition status (negotiating/committed/delivered/cancelled), and originating deal reference. Serves as the financial and operational anchor for content entering the enterprise catalog from external sources.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` (
    `windowing_plan_id` BIGINT COMMENT 'Unique identifier for the windowing plan record. Primary key for the windowing plan entity.',
    `ad_order_id` BIGINT COMMENT 'Foreign key linking to sales.ad_order. Business justification: A windowing plan governs the availability window during which content can be monetized; an ad order executes against that window. Linking windowing_plan to ad_order enables revenue-per-window reportin',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Linear windowing plans are channel-specific — a titles linear broadcast window is assigned to a specific channel. Linking windowing_plan to channel enables rights window enforcement per channel, blac',
    `clearance_request_id` BIGINT COMMENT 'Foreign key linking to rights.clearance_request. Business justification: A windowing plan window cannot open without clearance approval; linking windowing_plan to clearance_request enables automated hold/release workflows and SLA tracking. Distribution operations require c',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Windowing plans are version-specific (theatrical version has different windows than broadcast version). Links distribution strategy to specific version.',
    `content_window_id` BIGINT COMMENT 'Foreign key linking to rights.rights_content_window. Business justification: windowing_plan is the content-side availability plan; rights_content_window is the rights-side enforcement record. Linking them enables reconciliation between planned and cleared windows, a core right',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: Windowing plans govern delivery of specific renditions to specific platforms/territories. Distribution scheduling systems must reference the exact asset_version (e.g., HLS 1080p for OTT, SD proxy for ',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Windowing plans cover FAST channel and linear broadcast windows in addition to OTT platforms. A windowing plan for a FAST or linear window must reference the specific delivery_channel. This fills a ga',
    `drm_policy_id` BIGINT COMMENT 'Foreign key linking to distribution.drm_policy. Business justification: Each window has specific DRM requirements based on rights agreements (theatrical requires HDCP 2.2, rental allows offline). DRM policy enforcement varies by window type and revenue model.',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Windowing strategies must comply with license agreement terms (holdbacks, exclusivity windows, platform restrictions). Windowing plan validation and conflict detection require checking against the gov',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Each window must map to a specific rights grant that authorizes that exploitation type (SVOD, AVOD, linear broadcast). Clearance systems validate that the windows dates and platform fall within grant',
    `holdback_id` BIGINT COMMENT 'Foreign key linking to rights.holdback. Business justification: Windowing plans must respect holdback periods; direct FK enables automated holdback conflict detection and enforcement. Distribution operations teams check holdback status before opening any window; w',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Windowing plans define which platform receives content in each release window (theatrical → premium VOD → SVOD → AVOD). Core to revenue maximization strategy and rights holder agreements.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to distribution.partner_partner. Business justification: Windowing plans specify distribution partners for each window (theatrical exhibitor, streaming platform, broadcast network). Partner performance tracking, holdback enforcement, exclusivity compliance ',
    `campaign_id` BIGINT COMMENT 'FK to advertising campaign for windowing ad association',
    `streaming_endpoint_id` BIGINT COMMENT 'Foreign key linking to distribution.streaming_endpoint. Business justification: Each distribution window may use specific streaming endpoints (regional CDN POPs, premium tier endpoints). Required for geo-restriction enforcement, SLA tier assignment, and CDN cost allocation per wi',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Windows are territory-specific - geo-blocking, regional release strategies, and regulatory compliance require linking each window to its target territory. Clearance validates territorial rights before',
    `title_id` BIGINT COMMENT 'Reference to the content asset (title, episode, series, film, clip) for which this windowing plan is defined. Links to the master content catalog.',
    `abr_enabled` BOOLEAN COMMENT 'Indicates whether adaptive bitrate streaming is enabled for this window, allowing dynamic quality adjustment based on viewer bandwidth. True=ABR enabled, False=fixed bitrate.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this windowing plan was formally approved by authorized stakeholders. Marks transition from draft to confirmed status.',
    `audio_configuration` STRING COMMENT 'The audio format specification for this window. Stereo=2-channel, Surround 5.1=5.1 channel surround, Surround 7.1=7.1 channel surround, Dolby Atmos=object-based audio, DTS:X=immersive audio format.. Valid values are `stereo|surround_5_1|surround_7_1|dolby_atmos|dts_x`',
    `blackout_restrictions` STRING COMMENT 'Geographic or temporal blackout rules that restrict content availability in specific regions or time periods within the territory (e.g., sports blackouts, regional exclusions).',
    `bundle_eligibility` BOOLEAN COMMENT 'Indicates whether this content is eligible for inclusion in subscription bundles or multi-title packages during this window. True=bundle eligible, False=standalone only.',
    `concurrent_streams_limit` STRING COMMENT 'Maximum number of simultaneous streams allowed per subscriber account for this content in this window. Used for subscription service tier management.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this windowing plan record was first created in the system. Audit trail for record lifecycle.',
    `daypart_restriction` STRING COMMENT 'Time-of-day broadcast restrictions for linear windows, defining when content may air (e.g., prime time only, late night only, daytime safe). Applies primarily to linear broadcast and cable windows.',
    `download_to_go_enabled` BOOLEAN COMMENT 'Indicates whether offline download capability is enabled for this window, allowing viewers to download content for offline viewing. True=downloads allowed, False=streaming only.',
    `dubbing_availability` BOOLEAN COMMENT 'Indicates whether dubbed audio tracks in alternate languages are available for this window release. True=dubbing provided, False=original language only.',
    `holdback_duration_days` STRING COMMENT 'The number of days between the close of the previous window and the open of this window, representing the exclusivity period or gap between release phases.',
    `language_version` STRING COMMENT 'ISO 639-2 or ISO 639-3 language code for the primary audio/subtitle language version to be released in this window (e.g., eng, spa, fra, deu).. Valid values are `^[a-z]{2,3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this windowing plan record was last updated. Audit trail for change tracking.',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'The minimum guaranteed revenue amount (in base currency) that the platform has committed to pay for this window, regardless of actual performance. Used in licensing negotiations.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or strategic rationale for this windowing plan. Used for internal communication and documentation.',
    `planned_close_date` DATE COMMENT 'The intended end date when the content will no longer be available on the specified platform/channel in the specified territory. Nullable for open-ended windows.',
    `planned_open_date` DATE COMMENT 'The intended start date when the content becomes available on the specified platform/channel in the specified territory. Represents the editorial/commercial release plan.',
    `price_point` DECIMAL(18,2) COMMENT 'The consumer-facing price for transactional windows (TVOD, EST, PPV) in the specified currency. Represents the retail price charged to end viewers.',
    `promotional_pricing_flag` BOOLEAN COMMENT 'Indicates whether promotional or discounted pricing is applied for this window. True=promotional pricing active, False=standard pricing.',
    `revenue_model` STRING COMMENT 'The monetization approach for this window. Subscription=SVOD model, Advertising=AVOD model, Transactional=TVOD/PPV/EST, Hybrid=combination of models, Free=no direct revenue.. Valid values are `subscription|advertising|transactional|hybrid|free`',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `streaming_protocol` STRING COMMENT 'The streaming delivery protocol used for OTT windows. HLS=HTTP Live Streaming (Apple), DASH=Dynamic Adaptive Streaming over HTTP (MPEG-DASH), Smooth Streaming=Microsoft, RTMP=Real-Time Messaging Protocol, WebRTC=real-time communication.. Valid values are `hls|dash|smooth_streaming|rtmp|webrtc`',
    `subtitle_availability` BOOLEAN COMMENT 'Indicates whether subtitles or closed captions are available for this window release. True=subtitles provided, False=no subtitles.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `viewing_window_hours` STRING COMMENT 'For TVOD/rental windows, the number of hours a viewer has to complete watching the content after initiating playback (e.g., 48-hour rental window).',
    `window_sequence_number` STRING COMMENT 'Sequential ordering of this window within the overall release strategy for the content. Lower numbers indicate earlier windows (e.g., 1=theatrical, 2=SVOD, 3=AVOD).',
    CONSTRAINT pk_windowing_plan PRIMARY KEY(`windowing_plan_id`)
) COMMENT 'Defines the content-side release sequencing strategy for a title across distribution channels — theatrical, SVOD, AVOD, TVOD, linear broadcast, home video, and syndication. Each record captures window type, platform/channel, territory, planned open date, planned close date, holdback duration, exclusivity tier, and window status. Represents the content teams intended release plan that feeds into the rights domain for contractual enforcement and the distribution domain for operational execution. Distinct from rights windows (which are contractual) — this is the editorial/commercial planning artifact.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` (
    `artwork_id` BIGINT COMMENT 'Unique identifier for the artwork asset record. Primary key for the artwork catalog.',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Artwork is often version-specific (theatrical poster vs TV key art, localized artwork with different ratings/text). Links artwork to the specific version it represents.',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Linear broadcast channels require channel-specific EPG artwork, channel bugs, and promotional graphics. Delivery channel artwork management is a named operational process in broadcast operations — art',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: Artwork clearance is tracked against specific rights grants covering talent likeness rights and studio artwork grants. Linking artwork to grant enables automated expiry enforcement and clearance audit',
    `holder_id` BIGINT COMMENT 'Foreign key linking to rights.holder. Business justification: Artwork copyright is owned by a rights holder; linking enables royalty and licensing workflows for artwork assets. The plain copyright_holder text column is a denormalization of the holder entity. R',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Artwork usage rights are governed by license agreements covering photographer rights and studio approvals. Rights audits require knowing which agreement authorizes each artwork asset. The plain usage',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Artwork files (posters, thumbnails, key art) are managed media assets in DAM systems. Asset lifecycle management, storage tier assignment, and delivery workflows require linking artwork records to the',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: OTT platforms have distinct artwork specifications and approval processes (Netflix, Disney+ each require specific dimensions/formats). Platform-specific artwork management is a named operational proce',
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.content_rating. Business justification: The artwork table has a content_rating_displayed_flag boolean indicating whether a content rating badge is displayed on the artwork, but no FK to identify WHICH rating is displayed. Adding content_r',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: Artwork usage is territory-restricted; different artwork versions are approved for different markets (e.g., censorship requirements, language overlays). Territory-level artwork clearance is a standard',
    `title_id` BIGINT COMMENT 'Reference to the content title (series, film, episode, or other content asset) that this artwork represents. Links artwork to the master content catalog.',
    `approval_date` DATE COMMENT 'Date on which the artwork received final approval for distribution and use. Marks the transition from draft/review to production-ready status. Format: yyyy-MM-dd.',
    `approved_for_use_flag` BOOLEAN COMMENT 'Boolean indicator of whether the artwork has passed legal, brand, and creative approval processes and is authorized for public distribution. True indicates approved and ready for use, False indicates pending approval or rejected.',
    `archive_location` STRING COMMENT 'Physical or logical storage location identifier for the high-resolution master artwork file in the enterprise archive system. May reference tape library, cloud object storage bucket, or network-attached storage (NAS) path. Supports long-term preservation and disaster recovery.',
    `aspect_ratio` DECIMAL(18,2) COMMENT 'Proportional relationship between width and height of the artwork. 16:9 for widescreen HD, 4:3 for standard definition, 1:1 for square social media, 2:3 for portrait poster, 3:4 for mobile portrait, 21:9 for ultra-widescreen, 9:16 for vertical mobile video. [ENUM-REF-CANDIDATE: 16:9|4:3|1:1|2:3|3:4|21:9|9:16 — 7 candidates stripped; promote to reference product]',
    `color_profile` STRING COMMENT 'Color space standard applied to the artwork for accurate color reproduction across devices and platforms. sRGB for web/digital, Adobe RGB for professional photography, CMYK for print, Rec. 709 for HD broadcast, Rec. 2020 for Ultra HD (UHD) broadcast.. Valid values are `sRGB|Adobe RGB|ProPhoto RGB|CMYK|Rec. 709|Rec. 2020`',
    `content_rating_displayed_flag` BOOLEAN COMMENT 'Boolean indicator of whether the artwork includes a visible Motion Picture Association (MPA) or equivalent content rating badge (G, PG, PG-13, R, NC-17, TV-Y, TV-PG, TV-14, TV-MA). True indicates rating is burned into the image, False indicates clean artwork without rating overlay.',
    `copyright_year` STRING COMMENT 'Year in which the artwork was created and copyright was established. Used for copyright notice display and rights duration calculation.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the artwork record was first created in the enterprise catalog system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and data lineage tracking.',
    `eidr` STRING COMMENT 'Universal unique identifier from the Entertainment Identifier Registry for the associated content title. Enables global interoperability and metadata exchange across distribution partners, rights holders, and platforms.. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `expiry_date` DATE COMMENT 'Date on which the artwork rights or usage authorization expires and the asset should no longer be used for promotional or distribution purposes. Supports rights management and holdback compliance. Nullable for perpetual-use artwork. Format: yyyy-MM-dd.',
    `file_size_bytes` BIGINT COMMENT 'Storage size of the artwork file measured in bytes. Used for Content Delivery Network (CDN) optimization, bandwidth planning, and storage capacity management.',
    `height_pixels` STRING COMMENT 'Vertical dimension of the artwork image measured in pixels. Used to determine display suitability and resolution quality for various distribution channels.',
    `language_overlay_flag` BOOLEAN COMMENT 'Boolean indicator of whether the artwork contains burned-in text, titles, or language-specific graphic elements. True indicates localized artwork requiring territory-specific versions, False indicates language-neutral artwork suitable for all markets.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the artwork record was last updated or modified in the enterprise catalog system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for change tracking and synchronization workflows.',
    `photographer_credit` STRING COMMENT 'Name or attribution of the photographer, artist, or creative agency responsible for creating the artwork. Used for copyright attribution, residuals tracking, and legal compliance with talent agreements.',
    `priority_rank` STRING COMMENT 'Numeric ranking indicating the preferred display order or priority of this artwork when multiple artwork assets exist for the same title and type. Lower numbers indicate higher priority. Used by Electronic Program Guide (EPG) and streaming platform UI to select the primary artwork.',
    `resolution_dpi` STRING COMMENT 'Image resolution measured in dots per inch. 72 DPI for web/screen display, 300 DPI for high-quality print, 150 DPI for standard print. Critical for determining print suitability and image quality.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `title` STRING COMMENT 'Human-readable descriptive title or label for the artwork asset. Used for internal cataloging and search within the Media Asset Management (MAM) system.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `width_pixels` STRING COMMENT 'Horizontal dimension of the artwork image measured in pixels. Used to determine display suitability and resolution quality for various distribution channels.',
    CONSTRAINT pk_artwork PRIMARY KEY(`artwork_id`)
) COMMENT 'Master catalog of promotional and editorial artwork assets associated with a title — key art, thumbnail images, banner graphics, poster images, and logo treatments. Captures artwork type (key-art/thumbnail/banner/poster/logo/still), image dimensions, aspect ratio, file format, color profile, territory applicability, language overlay flag, approved-for-use flag, approval date, expiry date, and source system reference (Dalet Galaxy DAM). Supports EPG display, streaming platform UI, press kits, and advertising creative without duplicating the binary asset record owned by the digital asset domain.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`package` (
    `package_id` BIGINT COMMENT 'Primary key for package',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Content packages are distributed through specific delivery channels, particularly FAST channels where a curated package of titles defines the channels content offering. Package-to-channel assignment ',
    `genre_id` BIGINT COMMENT 'Foreign key linking to content.genre. Business justification: Packages have primary genre classification. Normalizes genre_primary string column to reference the enterprise genre taxonomy.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: Packages are assembled under specific rights grants; linking enables precise run-count enforcement and holdback compliance per package. Distribution operations require knowing which grant authorizes a',
    `holder_id` BIGINT COMMENT 'Foreign key linking to rights.holder. Business justification: Packages are associated with a rights holder for royalty payment and audit purposes. The plain rights_holder text column is a denormalization of the holder entity. Rights operations require knowing ',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Content packages (e.g., Summer Action Bundle, Kids Library) are licensed as units to distributors. Package-level royalty calculations and clearance workflows require linking packages to their gove',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Content packages (bundles, collections) are licensed to specific platforms. Package-level deals are common in SVOD (entire studio catalog to Netflix) and require platform-specific availability trackin',
    `partner_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_partner. Business justification: Packages are sold to distribution partners (cable operators, MVPD aggregators, international distributors). Package-level licensing agreements and carriage fees are negotiated at partner level for bul',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Distribution packages require a promotional media asset (sizzle reel, package trailer) for distributor previews and sales presentations. Broadcast distribution teams reference a package-level promo as',
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.content_rating. Business justification: A content package (curated bundle of titles for commercial/distribution purposes) carries an overall content rating that governs platform eligibility, parental controls, and distribution partner requi',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: Content packages are assembled for specific territory markets; territory determines which titles can be included based on rights clearance. The plain territory_scope text column is a denormalization',
    `audio_description_available_flag` BOOLEAN COMMENT 'Indicates whether audio description tracks are available for the majority of content in the package (True/False). Required for accessibility compliance.',
    `closed_caption_available_flag` BOOLEAN COMMENT 'Indicates whether closed captioning is available for the majority of content in the package (True/False). Required for FCC compliance and accessibility standards.',
    `commercial_context` STRING COMMENT 'Free-text description of the business purpose or deal context for which the package was assembled, such as upfront sales event, scatter market offering, MVPD (Multichannel Video Programming Distributor) carriage negotiation, or international syndication deal.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the package record was first created in the system. Used for audit trail and data lineage.',
    `package_description` STRING COMMENT 'A detailed narrative description of the package content, target audience, and commercial positioning. Used for marketing, sales proposals, and catalog listings.',
    `drm_required_flag` BOOLEAN COMMENT 'Indicates whether Digital Rights Management (DRM) protection is required for distribution of this package (True/False). Critical for rights enforcement and anti-piracy compliance.',
    `effective_date` DATE COMMENT 'The date from which the package becomes available for distribution or licensing. Marks the start of the packages commercial availability window.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the package is offered on an exclusive basis to a single distributor or platform (True) or is available for non-exclusive multi-platform distribution (False). Critical for rights and holdback management.',
    `expiry_date` DATE COMMENT 'The date on which the package ceases to be available for distribution or licensing. Nullable for open-ended packages. Defines the end of the windowing or holdback period.',
    `hd_available_flag` BOOLEAN COMMENT 'Indicates whether the package content is available in high-definition (HD) format (True/False). Used for distribution planning and quality assurance.',
    `keywords` STRING COMMENT 'Comma-separated list of keywords or tags associated with the package for search, discovery, and recommendation purposes.',
    `language_primary` STRING COMMENT 'The primary language of the content in the package, expressed as ISO 639-2 three-letter language code (e.g., eng, spa, fra). Critical for localization and international distribution.',
    `modified_by` STRING COMMENT 'The username or identifier of the user or system that last modified the package record. Used for change accountability and audit trail.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the package record was last modified. Used for change tracking and audit compliance.',
    `package_name` STRING COMMENT 'The business name or title of the content package as recognized in commercial agreements and distribution deals.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `thumbnail_url` STRING COMMENT 'The URL or path to the thumbnail image representing the package in catalogs, EPG (Electronic Program Guide) listings, and user interfaces.',
    `total_runtime_hours` DECIMAL(18,2) COMMENT 'The aggregate runtime of all content in the package, expressed in hours. Used for programming and scheduling calculations.',
    `uhd_4k_available_flag` BOOLEAN COMMENT 'Indicates whether the package content is available in ultra-high-definition 4K format (True/False). Used for premium distribution and OTT platform requirements.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `value_usd` DECIMAL(18,2) COMMENT 'The estimated or contracted commercial value of the package in United States Dollars (USD). Used for revenue forecasting, deal valuation, and financial reporting.',
    CONSTRAINT pk_package PRIMARY KEY(`package_id`)
) COMMENT 'Defines a curated bundle of titles assembled for a specific commercial or distribution purpose — a syndication package, SVOD library deal, MVPD carriage bundle, or FAST channel lineup. Captures package name, package type (syndication/svod-library/avod-catalog/fast-channel/educational/international), package status, effective date, expiry date, territory scope, exclusivity flag, and the commercial context it was assembled for. Acts as the content-side counterpart to distribution and rights deal structures.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` (
    `title_rights_grant_id` BIGINT COMMENT 'Unique identifier for this title-grant association record. Primary key.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to the rights grant bundle being applied to this title',
    `holder_id` BIGINT COMMENT 'Foreign key linking to rights.holder. Business justification: A title rights grant is granted by a specific holder; knowing which holder granted the rights is required for payment, royalty audit, and most-favored-nations compliance. Rights operations teams must ',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: A title rights grant derives from a license agreement; linking these enables royalty statement reconciliation and rights audit at the title level. Rights managers need to trace each title grant back t',
    `partner_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_partner. Business justification: Rights grants are issued to specific distribution partners authorizing content distribution. Linking title_rights_grant to distribution_partner enables rights clearance verification for partner distri',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: A title rights grant is scoped to a territory; this is fundamental to rights management — knowing which territory a grant covers enables territory-level rights availability reporting and holdback enfo',
    `title_id` BIGINT COMMENT 'Foreign key linking to the content title receiving rights under this grant',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this title-grant association was first created in the system.',
    `grant_effective_date` DATE COMMENT 'The date on which this specific title became available under this rights grant. May differ from the grants overall start date if titles are added to an existing grant.',
    `grant_expiry_date` DATE COMMENT 'The date on which rights for this specific title expire under this grant. May differ from the grants overall end date if titles have different term lengths.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this title-grant association was last modified.',
    `run_limit` STRING COMMENT 'Maximum number of times the content may be broadcast or streamed under this grant. Nullable if unlimited runs are permitted. [Moved from rights_grant: Run limits are often title-specific within a grant (e.g., a catalog grant may allow 10 runs for blockbuster titles but unlimited runs for library content). This should move to runs_allocated in the association.]',
    `runs_allocated` STRING COMMENT 'Number of broadcast or streaming runs allocated for this specific title under this grant. Titles within the same grant may have different run limits.',
    `runs_consumed` STRING COMMENT 'Number of runs already consumed for this specific title under this grant. Tracked at the title level for availability enforcement.',
    `runs_used` STRING COMMENT 'Number of runs already consumed against the run limit. Used for availability tracking and compliance. [Moved from rights_grant: Run consumption must be tracked per title-grant combination, not at the grant level. A grant covering 100 titles needs separate run tracking for each title. This becomes runs_consumed in the association.]',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    CONSTRAINT pk_title_rights_grant PRIMARY KEY(`title_rights_grant_id`)
) COMMENT 'This association product represents the grant of specific distribution and exploitation rights for a content title. It captures the operational relationship between a content asset and the legal rights bundle that permits its distribution. Each record links one title to one rights grant with attributes that track usage, availability windows, and platform-specific restrictions that exist only in the context of this specific title-grant pairing.. Existence Justification: In media broadcasting operations, a single content title receives multiple distinct rights grants (e.g., a film has separate grants for theatrical, broadcast, SVOD, international distribution), and each rights grant covers multiple titles (catalog grants, package deals, library acquisitions). The business actively manages these title-grant pairings through clearance workflows, availability engines, and usage tracking systems. Each pairing has operational data (run counts, platform restrictions, window assignments, clearance status) that belongs to neither the title nor the grant alone.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`rating` (
    `rating_id` BIGINT COMMENT 'Surrogate key.',
    `active_flag` BOOLEAN COMMENT 'Whether the value is active.',
    `content_rating_code` STRING COMMENT 'Stable enum code.',
    `content_rating_description` STRING COMMENT 'Long description.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `label` STRING COMMENT 'Human-readable label.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    CONSTRAINT pk_rating PRIMARY KEY(`rating_id`)
) COMMENT 'Reference (enum) table promoted from a stripped ENUM-REF-CANDIDATE column for deterministic analytics joins.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`content`.`title_inclusion` (
    `title_inclusion_id` BIGINT COMMENT 'Primary key for the title_inclusion association',
    `package_id` BIGINT COMMENT 'Foreign key linking to the parent content package that contains this title inclusion record.',
    `title_id` BIGINT COMMENT 'Foreign key linking to the content title that is included in the package.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this specific titles inclusion in this package is on an exclusive basis — meaning the title cannot appear in competing packages during the rights window. This is a per-inclusion attribute distinct from the package-level exclusivity_flag on the package entity.',
    `inclusion_date` DATE COMMENT 'The date on which this title was formally added to the package. Used for audit, rights tracking, and package assembly history. Belongs to the relationship, not to either entity alone.',
    `rights_window_end` DATE COMMENT 'The end date of the licensed rights window governing this titles inclusion in this specific package. When this date passes, the title must be removed from the package or the inclusion renegotiated. Belongs to the inclusion relationship, not to the title or package independently.',
    `rights_window_start` DATE COMMENT 'The start date of the licensed rights window governing this titles inclusion in this specific package. May differ from the titles overall acquisition_date or the packages effective_date, as individual title rights windows are negotiated per package deal.',
    `sequence_number` BIGINT COMMENT 'The display or playback order of this title within the package. Used for EPG ordering, catalog presentation, and playlist sequencing. Belongs to the inclusion relationship, not to the title or package independently.',
    `total_title_count` STRING COMMENT 'The total number of distinct titles (episodes, films, clips, or other content assets) included in the package. Used for inventory reporting and deal valuation. [Moved from package: total_title_count on package is a derived aggregate of inclusion records and should be computed from the title_inclusion association table rather than stored as a denormalized attribute on package. Storing it on package creates a data integrity risk where the count can diverge from the actual number of inclusion records.]',
    CONSTRAINT pk_title_inclusion PRIMARY KEY(`title_inclusion_id`)
) COMMENT 'This association product represents the Contract between a content package and a title. It captures the operational record of a specific title being included in a specific package, including the rights window governing that inclusion, the display sequence within the package, and whether the inclusion carries exclusivity. Each record links one package to one title and carries attributes that exist only in the context of this package-title relationship — they cannot reside on either the package or the title alone.. Existence Justification: In media broadcasting, a package is explicitly a curated bundle of multiple titles (confirmed by package.total_title_count attribute), and a single title routinely participates in multiple packages simultaneously — e.g., a film may appear in an SVOD library deal, a syndication package, and a FAST channel lineup at the same time. The business actively manages this composition relationship, tracking which titles are included in which packages with sequencing, rights windows, and inclusion dates that belong to neither entity alone. This is a textbook operational M:N that content operations teams create, update, and delete as packages are assembled, renegotiated, and expired.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ADD CONSTRAINT `fk_content_title_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`genre`(`genre_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ADD CONSTRAINT `fk_content_title_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`rating`(`rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ADD CONSTRAINT `fk_content_title_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ADD CONSTRAINT `fk_content_series_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`genre`(`genre_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ADD CONSTRAINT `fk_content_series_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`rating`(`rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ADD CONSTRAINT `fk_content_season_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`genre`(`genre_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ADD CONSTRAINT `fk_content_season_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`rating`(`rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ADD CONSTRAINT `fk_content_season_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ADD CONSTRAINT `fk_content_season_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ADD CONSTRAINT `fk_content_episode_season_id` FOREIGN KEY (`season_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`season`(`season_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ADD CONSTRAINT `fk_content_episode_series_id` FOREIGN KEY (`series_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`series`(`series_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ADD CONSTRAINT `fk_content_episode_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`genre`(`genre_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ADD CONSTRAINT `fk_content_episode_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`rating`(`rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ADD CONSTRAINT `fk_content_episode_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ADD CONSTRAINT `fk_content_version_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`rating`(`rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ADD CONSTRAINT `fk_content_version_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ADD CONSTRAINT `fk_content_genre_parent_genre_id` FOREIGN KEY (`parent_genre_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`genre`(`genre_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ADD CONSTRAINT `fk_content_talent_credit_episode_id` FOREIGN KEY (`episode_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`episode`(`episode_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ADD CONSTRAINT `fk_content_talent_credit_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`version`(`version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`rating`(`rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ADD CONSTRAINT `fk_content_package_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`genre`(`genre_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ADD CONSTRAINT `fk_content_package_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`rating`(`rating_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ADD CONSTRAINT `fk_content_title_rights_grant_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_inclusion` ADD CONSTRAINT `fk_content_title_inclusion_package_id` FOREIGN KEY (`package_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`package`(`package_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_inclusion` ADD CONSTRAINT `fk_content_title_inclusion_title_id` FOREIGN KEY (`title_id`) REFERENCES `vibe_media_broadcasting_v1`.`content`.`title`(`title_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`content` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`content` SET TAGS ('dbx_domain' = 'content');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `title_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the content title. Primary key for the title master catalog. Serves as the universal join point referenced by scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `title_id` SET TAGS ('dbx_distribution' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `title_id` SET TAGS ('dbx_rights' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `title_id` SET TAGS ('dbx_digital_asset' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `title_id` SET TAGS ('dbx_and_advertising_domains' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `genre_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `genre_id` SET TAGS ('dbx_column_comment' = 'FK to content.genre');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `genre_id` SET TAGS ('dbx_metadata_standard' = 'EBUCore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `genre_id` SET TAGS ('dbx_DublinCore' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `genre_id` SET TAGS ('dbx_TVAnytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Master Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Rights Holder Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `holder_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_rights_rights_holder_Business_justification' = 'Tracks who owns/controls rights to each title - essential for royalty payments');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `holder_id` SET TAGS ('dbx_clearance_workflows' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `holder_id` SET TAGS ('dbx_and_determining_who_must_approve_licensing_deals_Rights_holder_is_the_starting_point_for_all_right' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Motion Picture Association (MPA) Content Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `rating_id` SET TAGS ('dbx_enum_promoted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `rating_id` SET TAGS ('dbx_column_comment' = 'Official content rating assigned by the Motion Picture Association or television rating authority. Determines audience suitability');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `rating_id` SET TAGS ('dbx_broadcast_restrictions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `rating_id` SET TAGS ('dbx_and_parental_control_settings_[ENUM_REF_CANDIDATE' = 'G');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `rating_id` SET TAGS ('dbx_PG' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `rating_id` SET TAGS ('dbx_PG_13' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `rating_id` SET TAGS ('dbx_R' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `rating_id` SET TAGS ('dbx_NC_17' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `rating_id` SET TAGS ('dbx_TV_Y' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `rating_id` SET TAGS ('dbx_TV_Y7' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `rating_id` SET TAGS ('dbx_TV_G' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `rating_id` SET TAGS ('dbx_TV_PG' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `rating_id` SET TAGS ('dbx_TV_14' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `rating_id` SET TAGS ('dbx_TV_MA' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `rating_id` SET TAGS ('dbx_NR_—_12_candidates_stripped;_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `rating_id` SET TAGS ('dbx_regulation' = 'Ofcom');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `series_id` SET TAGS ('dbx_column_comment' = 'Foreign key reference to the parent series for episodic content. Null for standalone films');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `series_id` SET TAGS ('dbx_clips' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `series_id` SET TAGS ('dbx_and_non_episodic_content' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `territory_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_rights_territory_Business_justification' = 'Titles have primary production/distribution territories that affect rights clearance');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `territory_id` SET TAGS ('dbx_regulatory_compliance_(content_ratings)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `territory_id` SET TAGS ('dbx_and_default_licensing_assumptions_Clearance_workflows_validate_against_t' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `territory_id` SET TAGS ('dbx_regulation' = 'Ofcom');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Content Acquisition Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_column_comment' = 'Date when the content rights were acquired by the organization. Used for rights lifecycle tracking');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_amortization_calculations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_and_contract_management' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `archive_date` SET TAGS ('dbx_business_glossary_term' = 'Archive Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `archive_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `archive_date` SET TAGS ('dbx_column_comment' = 'Date when the content was moved to archived status. Used for content lifecycle management and digital asset retention policies.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_column_comment' = 'Display aspect ratio of the content. Determines presentation format for broadcast');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_streaming' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_and_theatrical_distribution' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `audio_description_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `audio_description_available_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `audio_description_available_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether audio description track is available for visually impaired audiences. Required for accessibility compliance and inclusive broadcasting.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `audio_description_available_flag` SET TAGS ('dbx_regulation' = 'EBU R128');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `closed_caption_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `closed_caption_available_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `closed_caption_available_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether closed captioning is available for the content. Required for FCC compliance and accessibility standards.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `closed_caption_available_flag` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `coppa_child_directed_flag` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Child-Directed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `coppa_child_directed_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `coppa_child_directed_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the content is directed to children under 13 years of age. Triggers COPPA compliance requirements for data collection');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `coppa_child_directed_flag` SET TAGS ('dbx_advertising_restrictions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `coppa_child_directed_flag` SET TAGS ('dbx_and_privacy_protections' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `coppa_child_directed_flag` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_column_comment' = 'ISO 3166-1 alpha-3 code representing the country where the content was originally produced. Used for rights management');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_regulatory_compliance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_and_content_origin_reporting' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when the title record was first created in the system. Used for audit trails');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_data_lineage_tracking' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_and_operational_reporting' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `distributor_name` SET TAGS ('dbx_business_glossary_term' = 'Distributor Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `distributor_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `distributor_name` SET TAGS ('dbx_column_comment' = 'Name of the primary distributor or licensor of the content. Used for rights management');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `distributor_name` SET TAGS ('dbx_financial_reconciliation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `distributor_name` SET TAGS ('dbx_and_contract_tracking' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `distributor_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `distributor_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `episode_number` SET TAGS ('dbx_business_glossary_term' = 'Episode Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `episode_number` SET TAGS ('dbx_column_comment' = 'Episode number within the season for episodic content. Null for non-episodic content. Used for sequential ordering in playout and Electronic Program Guide (EPG) systems.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `hd_available_flag` SET TAGS ('dbx_business_glossary_term' = 'High Definition (HD) Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `hd_available_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `hd_available_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether a high-definition version of the content is available. Used for channel playout decisions and quality-tier distribution strategies.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isan` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isan` SET TAGS ('dbx_value_regex' = '^ISAN [A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isan` SET TAGS ('dbx_standard_identifier' = 'ISAN');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isan` SET TAGS ('dbx_first_class' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isan` SET TAGS ('dbx_regex' = '^[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isan` SET TAGS ('dbx_column_comment' = 'International standard identifier for audiovisual works. Primarily used for films and television programs for rights management and distribution tracking.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isan` SET TAGS ('dbx_validation_regex' = '^[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isan` SET TAGS ('dbx_standard' = 'ISAN');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isan` SET TAGS ('dbx_regex_validation' = '^[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}(-[A-Z0-9])?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isan` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isan` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isrc` SET TAGS ('dbx_business_glossary_term' = 'International Standard Recording Code (ISRC)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isrc` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isrc` SET TAGS ('dbx_standard_identifier' = 'ISRC');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isrc` SET TAGS ('dbx_first_class' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isrc` SET TAGS ('dbx_regex' = '^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isrc` SET TAGS ('dbx_column_comment' = 'International standard code for uniquely identifying sound recordings and music video recordings. Used for music tracks and audio content royalty tracking.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isrc` SET TAGS ('dbx_validation_regex' = '^[A-Z]{2}[A-Z0-9]{3}[0-9]{2}[0-9]{5}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isrc` SET TAGS ('dbx_standard' = 'ISRC');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isrc` SET TAGS ('dbx_regex_validation' = '^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isrc` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `isrc` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Content Keywords');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `keywords` SET TAGS ('dbx_column_comment' = 'Comma-separated list of keywords and tags describing content themes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `keywords` SET TAGS ('dbx_subjects' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `keywords` SET TAGS ('dbx_and_topics_Used_for_search_optimization' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `keywords` SET TAGS ('dbx_content_discovery' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `keywords` SET TAGS ('dbx_and_recommendation_algorithms' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `keywords` SET TAGS ('dbx_metadata_standard' = 'EBUCore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `keywords` SET TAGS ('dbx_DublinCore' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `keywords` SET TAGS ('dbx_TVAnytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `title_name` SET TAGS ('dbx_business_glossary_term' = 'Title Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `title_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `title_name` SET TAGS ('dbx_column_comment' = 'Primary display name of the content title. The human-readable identifier used across all systems and customer-facing platforms.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `title_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `title_name` SET TAGS ('dbx_metadata_standard' = 'EBUCore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `title_name` SET TAGS ('dbx_DublinCore' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `title_name` SET TAGS ('dbx_TVAnytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `title_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `original_language` SET TAGS ('dbx_business_glossary_term' = 'Original Language Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `original_language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `original_language` SET TAGS ('dbx_column_comment' = 'ISO 639-2 three-letter code representing the original language of the content production. Used for localization planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `original_language` SET TAGS ('dbx_dubbing' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `original_language` SET TAGS ('dbx_and_subtitle_workflows' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `original_language` SET TAGS ('dbx_metadata_standard' = 'EBUCore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `original_language` SET TAGS ('dbx_DublinCore' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `original_language` SET TAGS ('dbx_TVAnytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `original_language` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `original_title` SET TAGS ('dbx_business_glossary_term' = 'Original Title Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `original_title` SET TAGS ('dbx_column_comment' = 'Original title name in the native language of production. Preserved for rights management');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `original_title` SET TAGS ('dbx_archival' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `original_title` SET TAGS ('dbx_and_international_distribution_purposes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `parental_advisory_flag` SET TAGS ('dbx_business_glossary_term' = 'Parental Advisory Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `parental_advisory_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `parental_advisory_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the content carries a parental advisory warning for explicit content');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `parental_advisory_flag` SET TAGS ('dbx_violence' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `parental_advisory_flag` SET TAGS ('dbx_or_mature_themes_Used_for_compliance_with_broadcast_standards_and_platform_content_policies' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `parental_advisory_flag` SET TAGS ('dbx_regulation' = 'Ofcom');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `premiere_flag` SET TAGS ('dbx_business_glossary_term' = 'Premiere Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `premiere_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `premiere_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the content is a premiere or first-run broadcast. Used for promotional scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `premiere_flag` SET TAGS ('dbx_advertising_premium_pricing' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `premiere_flag` SET TAGS ('dbx_and_audience_measurement_reporting' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `production_year` SET TAGS ('dbx_business_glossary_term' = 'Production Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `production_year` SET TAGS ('dbx_column_comment' = 'Calendar year in which the content was originally produced or completed. Used for catalog organization');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `production_year` SET TAGS ('dbx_rights_windowing_calculations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `production_year` SET TAGS ('dbx_and_archival_classification' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Original Release Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `release_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `release_date` SET TAGS ('dbx_column_comment' = 'Date when the content was first released to the public or premiered. Used for rights availability calculations');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `release_date` SET TAGS ('dbx_windowing_strategies' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `release_date` SET TAGS ('dbx_and_anniversary_programming' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `release_date` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `runtime_seconds` SET TAGS ('dbx_business_glossary_term' = 'Runtime in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `runtime_seconds` SET TAGS ('dbx_column_comment' = 'Total duration of the content in seconds. Used for program scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `runtime_seconds` SET TAGS ('dbx_ad_pod_allocation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `runtime_seconds` SET TAGS ('dbx_playout_automation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `runtime_seconds` SET TAGS ('dbx_and_Electronic_Program_Guide_(EPG)_generation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `season_number` SET TAGS ('dbx_business_glossary_term' = 'Season Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `season_number` SET TAGS ('dbx_column_comment' = 'Season number within the parent series for episodic content. Null for non-episodic content. Used for catalog organization and Electronic Program Guide (EPG) display.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `season_number` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `studio_name` SET TAGS ('dbx_business_glossary_term' = 'Production Studio Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `studio_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `studio_name` SET TAGS ('dbx_column_comment' = 'Name of the studio or production company that produced the content. Used for rights attribution');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `studio_name` SET TAGS ('dbx_royalty_calculations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `studio_name` SET TAGS ('dbx_and_catalog_organization' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `studio_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `studio_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `sub_genre` SET TAGS ('dbx_business_glossary_term' = 'Sub-Genre Classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `sub_genre` SET TAGS ('dbx_column_comment' = 'Secondary or more granular genre classification providing additional content categorization for advanced audience segmentation and personalization.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_business_glossary_term' = 'Long Synopsis');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_column_comment' = 'Detailed narrative description of the content. Used for promotional materials');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_streaming_platform_detail_pages' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_and_comprehensive_program_guides' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_metadata_standard' = 'EBUCore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_DublinCore' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_TVAnytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_business_glossary_term' = 'Short Synopsis');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_column_comment' = 'Brief summary of the content');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_typically_50_100_characters_Used_for_Electronic_Program_Guide_(EPG)_listings' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_mobile_applications' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_and_quick_reference_displays' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_metadata_standard' = 'EBUCore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_DublinCore' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_TVAnytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `theatrical_release_flag` SET TAGS ('dbx_business_glossary_term' = 'Theatrical Release Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `theatrical_release_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `theatrical_release_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the content had a theatrical release. Used for windowing strategy');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `theatrical_release_flag` SET TAGS ('dbx_rights_holdback_periods' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `theatrical_release_flag` SET TAGS ('dbx_and_marketing_classification' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `theatrical_release_flag` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `uhd_4k_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Ultra High Definition (UHD) 4K Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `uhd_4k_available_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `uhd_4k_available_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether an Ultra HD 4K version of the content is available. Used for premium streaming tiers and next-generation broadcast services.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when the title record was last modified. Used for change tracking');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_data_synchronization' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_and_audit_compliance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `series_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the series. Primary key for the series master record.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `genre_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_content_genre_Business_justification' = 'Series have genre classification. Normalizes genre_primary/genre_secondary string columns to reference the enterprise genre taxonomy.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `genre_id` SET TAGS ('dbx_metadata_standard' = 'EBUCore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `genre_id` SET TAGS ('dbx_DublinCore' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `genre_id` SET TAGS ('dbx_TVAnytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Rights Holder Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `holder_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_rights_rights_holder_Business_justification' = 'Series-level rights ownership (studio/production company) drives all downstream licensing and royalty flows. Franchise management and multi-season deal negotiations require knowing the primary rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Showrunner Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `archive_location` SET TAGS ('dbx_business_glossary_term' = 'Archive Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `archive_location` SET TAGS ('dbx_column_comment' = 'Physical or logical location identifier where the series master content and metadata are archived. Used for Digital Asset Management (DAM) and Media Asset Management (MAM) retrieval.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_column_comment' = 'Standard aspect ratio for the series video format. Critical for playout configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_transcoding_workflows' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_and_multi_platform_distribution' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_column_comment' = 'Indicates whether audio description track is available for visually impaired viewers. Required for accessibility compliance in many jurisdictions.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_regulation' = 'EBU R128');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_column_comment' = 'Indicates whether closed captioning is available for the series. Required for regulatory compliance under FCC accessibility rules and international broadcasting standards.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_column_comment' = 'ISO 3166-1 alpha-3 country code for the country where the series was originally produced. Used for content quotas');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_regulatory_compliance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_and_international_rights_management' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when the series record was first created in the system. Used for audit trail and data lineage tracking.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `episode_runtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Episode Runtime Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `episode_runtime_minutes` SET TAGS ('dbx_column_comment' = 'Standard runtime duration in minutes for a typical episode of the series');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `episode_runtime_minutes` SET TAGS ('dbx_excluding_commercials_Used_for_scheduling' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `episode_runtime_minutes` SET TAGS ('dbx_ad_pod_planning' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `episode_runtime_minutes` SET TAGS ('dbx_and_playout_automation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `finale_date` SET TAGS ('dbx_business_glossary_term' = 'Finale Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `finale_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `finale_date` SET TAGS ('dbx_column_comment' = 'Date when the final episode of the series aired or was released. Null for ongoing series. Used for syndication eligibility and rights holdback period calculations.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `franchise_name` SET TAGS ('dbx_business_glossary_term' = 'Franchise Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `franchise_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `franchise_name` SET TAGS ('dbx_column_comment' = 'Brand name of the content franchise or show brand. Used for grouping related series');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `franchise_name` SET TAGS ('dbx_spin_offs' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `franchise_name` SET TAGS ('dbx_and_reboots_under_a_common_brand_umbrella' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `franchise_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `franchise_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `keywords` SET TAGS ('dbx_column_comment' = 'Comma-separated list of searchable keywords and tags for content discovery');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `keywords` SET TAGS ('dbx_Electronic_Program_Guide_(EPG)_search' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `keywords` SET TAGS ('dbx_and_recommendation_engine_optimization' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `keywords` SET TAGS ('dbx_metadata_standard' = 'EBUCore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `keywords` SET TAGS ('dbx_DublinCore' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `keywords` SET TAGS ('dbx_TVAnytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `language_original` SET TAGS ('dbx_business_glossary_term' = 'Original Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `language_original` SET TAGS ('dbx_value_regex' = '^[a-z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `language_original` SET TAGS ('dbx_column_comment' = 'ISO 639-3 three-letter code for the original production language of the series. Used for localization planning and international distribution.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `language_original` SET TAGS ('dbx_metadata_standard' = 'EBUCore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `language_original` SET TAGS ('dbx_DublinCore' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `language_original` SET TAGS ('dbx_TVAnytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `language_original` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when the series record was last modified. Used for change tracking');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_audit_compliance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_and_data_synchronization_across_systems' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `original_network` SET TAGS ('dbx_business_glossary_term' = 'Original Network');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `original_network` SET TAGS ('dbx_column_comment' = 'Name of the original broadcast network or streaming platform that first aired or released the series. Critical for rights management and syndication deals.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `premiere_date` SET TAGS ('dbx_business_glossary_term' = 'Premiere Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `premiere_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `premiere_date` SET TAGS ('dbx_column_comment' = 'Date when the first episode of the series originally aired or was released. Marks the beginning of the series lifecycle and is used for rights windowing calculations.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `production_company` SET TAGS ('dbx_business_glossary_term' = 'Production Company');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `production_company` SET TAGS ('dbx_column_comment' = 'Name of the primary production company or studio that produced the series. Critical for rights ownership');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `production_company` SET TAGS ('dbx_residuals_calculations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `production_company` SET TAGS ('dbx_and_syndication_negotiations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `production_company` SET TAGS ('dbx_regulation' = 'PCI DSS');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `syndication_eligible` SET TAGS ('dbx_business_glossary_term' = 'Syndication Eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `syndication_eligible` SET TAGS ('dbx_column_comment' = 'Indicates whether the series meets the minimum episode threshold and rights clearance requirements for syndication to secondary markets and broadcast stations.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_business_glossary_term' = 'Long Synopsis');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_column_comment' = 'Detailed multi-paragraph description of the series premise');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_themes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_and_narrative_arc_Used_for_marketing_materials' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_press_releases' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_and_content_catalogs' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_metadata_standard' = 'EBUCore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_DublinCore' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_TVAnytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_business_glossary_term' = 'Short Synopsis');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_column_comment' = 'Brief one-sentence description of the series premise. Used for Electronic Program Guide (EPG) listings');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_mobile_applications' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_and_social_media_promotion' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_metadata_standard' = 'EBUCore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_DublinCore' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_TVAnytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `target_demographic` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `target_demographic` SET TAGS ('dbx_column_comment' = 'Primary audience demographic segment the series is designed to reach. Used for advertising sales');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `target_demographic` SET TAGS ('dbx_scheduling_strategy' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `target_demographic` SET TAGS ('dbx_and_Target_Rating_Point_(TRP)_calculations_[ENUM_REF_CANDIDATE' = 'adults_18_49');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `target_demographic` SET TAGS ('dbx_adults_25_54' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `target_demographic` SET TAGS ('dbx_adults_18_34' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `target_demographic` SET TAGS ('dbx_children_2_11' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `target_demographic` SET TAGS ('dbx_teens_12_17' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `target_demographic` SET TAGS ('dbx_women_18_49' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `target_demographic` SET TAGS ('dbx_men_18_49' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `target_demographic` SET TAGS ('dbx_total_viewers_—_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Series Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `title` SET TAGS ('dbx_column_comment' = 'Official title of the series as registered and marketed. Primary human-readable identifier for the content franchise.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `title` SET TAGS ('dbx_metadata_standard' = 'EBUCore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `title` SET TAGS ('dbx_DublinCore' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `title` SET TAGS ('dbx_TVAnytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `title_original` SET TAGS ('dbx_business_glossary_term' = 'Original Series Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `title_original` SET TAGS ('dbx_column_comment' = 'Original title of the series in its native language and market before localization or translation.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `total_episode_count` SET TAGS ('dbx_business_glossary_term' = 'Total Episode Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `total_episode_count` SET TAGS ('dbx_fact_metric' = 'monetary');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `total_episode_count` SET TAGS ('dbx_column_comment' = 'Cumulative count of all episodes produced across all seasons. Includes specials and pilot episodes.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `total_season_count` SET TAGS ('dbx_business_glossary_term' = 'Total Season Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `total_season_count` SET TAGS ('dbx_fact_metric' = 'monetary');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `total_season_count` SET TAGS ('dbx_column_comment' = 'Total number of seasons produced for the series to date. Updated as new seasons are commissioned and produced.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `total_season_count` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`series` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `season_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the season record. Primary key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `season_id` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `genre_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_content_genre_Business_justification' = 'Seasons have genre classification. Normalizes genre_primary/genre_secondary string columns to reference the enterprise genre taxonomy.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `genre_id` SET TAGS ('dbx_metadata_standard' = 'EBUCore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `genre_id` SET TAGS ('dbx_DublinCore' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `genre_id` SET TAGS ('dbx_TVAnytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Holder Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_rights_license_agreement_Business_justification' = 'Season-specific licensing (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_Season_1_to_Netflix' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_Season_2_to_Hulu)_is_common_in_streaming_Clearance_and_windowing_decisions_require_knowing_which_agreement_controls_each_season's_distribution_ri' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Trailer Asset Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_column_comment' = 'Reference to the season trailer asset in the MAM system. Used for promotional campaigns and platform previews.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `series_id` SET TAGS ('dbx_column_comment' = 'Reference to the parent series to which this season belongs.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `archive_date` SET TAGS ('dbx_business_glossary_term' = 'Archive Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `archive_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `archive_date` SET TAGS ('dbx_column_comment' = 'Date when the season was moved to archival storage. Used for asset lifecycle management and retrieval planning.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `archive_location` SET TAGS ('dbx_business_glossary_term' = 'Archive Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `archive_location` SET TAGS ('dbx_column_comment' = 'Physical or digital archive location where the seasons master assets are stored. Critical for long-term preservation and retrieval.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `awards_nominated` SET TAGS ('dbx_business_glossary_term' = 'Awards Nominated');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `awards_nominated` SET TAGS ('dbx_column_comment' = 'Comma-separated list of major award nominations received by the season. Supports promotional messaging and content valuation.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `awards_won` SET TAGS ('dbx_business_glossary_term' = 'Awards Won');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `awards_won` SET TAGS ('dbx_column_comment' = 'Comma-separated list of major awards won by the season (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `awards_won` SET TAGS ('dbx_Emmy' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `awards_won` SET TAGS ('dbx_Golden_Globe)_Used_for_marketing_and_promotional_value_enhancement' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `banner_artwork_url` SET TAGS ('dbx_business_glossary_term' = 'Banner Artwork Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `banner_artwork_url` SET TAGS ('dbx_column_comment' = 'URL reference to the seasons banner or hero image for wide-format displays on streaming platforms and websites.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when the season record was first created in the system. Used for audit trail and data lineage.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `distributor` SET TAGS ('dbx_business_glossary_term' = 'Distributor');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `distributor` SET TAGS ('dbx_column_comment' = 'Name of the primary distributor handling the seasons commercial distribution. Key for carriage agreements and revenue sharing.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `eidr` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `eidr` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `eidr` SET TAGS ('dbx_standard_identifier' = 'EIDR');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `eidr` SET TAGS ('dbx_first_class' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `eidr` SET TAGS ('dbx_regex' = '^10.5240/...');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `eidr` SET TAGS ('dbx_column_comment' = 'Globally unique EIDR identifier for the season');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `eidr` SET TAGS ('dbx_enabling_cross_platform_content_identification_and_rights_management' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `eidr` SET TAGS ('dbx_validation_regex' = '^10.5240/[0-9A-F-]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `eidr` SET TAGS ('dbx_standard' = 'EIDR');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `eidr` SET TAGS ('dbx_regex_validation' = '^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `eidr` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `eidr` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `episode_count_aired` SET TAGS ('dbx_business_glossary_term' = 'Episode Count Aired');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `episode_count_aired` SET TAGS ('dbx_column_comment' = 'Number of episodes that have been broadcast or released to audiences. Used for tracking release progress.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `episode_count_ordered` SET TAGS ('dbx_business_glossary_term' = 'Episode Count Ordered');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `episode_count_ordered` SET TAGS ('dbx_column_comment' = 'Number of episodes originally ordered or commissioned for this season by the network or platform.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `episode_count_produced` SET TAGS ('dbx_business_glossary_term' = 'Episode Count Produced');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `episode_count_produced` SET TAGS ('dbx_column_comment' = 'Actual number of episodes produced and delivered for this season. May differ from ordered count due to production changes.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `finale_date` SET TAGS ('dbx_business_glossary_term' = 'Season Finale Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `finale_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `finale_date` SET TAGS ('dbx_column_comment' = 'Date when the final episode of the season was broadcast or released. Marks the end of the seasons linear run.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `isan` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `isan` SET TAGS ('dbx_value_regex' = '^ISAN [A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `isan` SET TAGS ('dbx_standard_identifier' = 'ISAN');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `isan` SET TAGS ('dbx_first_class' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `isan` SET TAGS ('dbx_regex' = '^[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `isan` SET TAGS ('dbx_column_comment' = 'International standard identifier for audiovisual works');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `isan` SET TAGS ('dbx_used_for_season_level_identification_in_global_distribution_and_rights_management' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `isan` SET TAGS ('dbx_validation_regex' = '^[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `isan` SET TAGS ('dbx_standard' = 'ISAN');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `isan` SET TAGS ('dbx_regex_validation' = '^[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}(-[A-Z0-9])?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `isan` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `isan` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `language_original` SET TAGS ('dbx_business_glossary_term' = 'Original Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `language_original` SET TAGS ('dbx_value_regex' = '^[a-z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `language_original` SET TAGS ('dbx_column_comment' = 'ISO 639-3 three-letter code for the original production language of the season. Critical for localization and distribution planning.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `language_original` SET TAGS ('dbx_metadata_standard' = 'EBUCore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `language_original` SET TAGS ('dbx_DublinCore' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `language_original` SET TAGS ('dbx_TVAnytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `language_original` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when the season record was last modified. Supports change tracking and audit compliance.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `network_original` SET TAGS ('dbx_business_glossary_term' = 'Original Network');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `network_original` SET TAGS ('dbx_column_comment' = 'Name of the network or platform that originally commissioned or first aired the season. Used for windowing and exclusivity tracking.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `original_air_date` SET TAGS ('dbx_business_glossary_term' = 'Original Air Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `original_air_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `original_air_date` SET TAGS ('dbx_column_comment' = 'Date when the first episode of the season was originally broadcast or released. Key for windowing and rights calculations.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `poster_artwork_url` SET TAGS ('dbx_business_glossary_term' = 'Poster Artwork Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `poster_artwork_url` SET TAGS ('dbx_column_comment' = 'URL reference to the seasons primary poster artwork stored in the Media Asset Management (MAM) system. Used for EPG');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `poster_artwork_url` SET TAGS ('dbx_VOD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `poster_artwork_url` SET TAGS ('dbx_and_promotional_displays' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `production_company` SET TAGS ('dbx_business_glossary_term' = 'Production Company');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `production_company` SET TAGS ('dbx_column_comment' = 'Name of the primary production company responsible for creating the season. Used for rights attribution and royalty calculations.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `production_company` SET TAGS ('dbx_regulation' = 'PCI DSS');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `production_year` SET TAGS ('dbx_business_glossary_term' = 'Production Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `production_year` SET TAGS ('dbx_column_comment' = 'Calendar year in which the season was produced. Used for cataloging');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `production_year` SET TAGS ('dbx_rights_management' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `production_year` SET TAGS ('dbx_and_archival_purposes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `rights_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Rights Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `rights_expiry_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `rights_expiry_date` SET TAGS ('dbx_column_comment' = 'Date when current distribution rights for the season expire. Triggers rights renewal workflows and availability restrictions.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `season_number` SET TAGS ('dbx_business_glossary_term' = 'Season Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `season_number` SET TAGS ('dbx_column_comment' = 'Sequential number of the season within the series (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `season_number` SET TAGS ('dbx_1_for_Season_1' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `season_number` SET TAGS ('dbx_2_for_Season_2)_Used_for_ordering_and_identification' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `season_number` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_business_glossary_term' = 'Long Synopsis');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_column_comment' = 'Detailed season-level synopsis providing comprehensive narrative overview. Used for promotional materials');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_VOD_platforms' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_and_press_releases' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_metadata_standard' = 'EBUCore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_DublinCore' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_TVAnytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_business_glossary_term' = 'Short Synopsis');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_column_comment' = 'Brief season-level synopsis (typically 50-150 characters) used for Electronic Program Guide (EPG) listings and mobile displays.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_metadata_standard' = 'EBUCore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_DublinCore' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_TVAnytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `total_runtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Runtime Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `total_runtime_minutes` SET TAGS ('dbx_fact_metric' = 'monetary');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `total_runtime_minutes` SET TAGS ('dbx_column_comment' = 'Cumulative runtime of all episodes in the season');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `total_runtime_minutes` SET TAGS ('dbx_measured_in_minutes_Used_for_scheduling_blocks_and_VOD_packaging' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`season` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `episode_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the episode within the content management system. Primary key for the content episode entity.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `clearance_request_id` SET TAGS ('dbx_business_glossary_term' = 'Clearance Request Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Content Season Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `season_id` SET TAGS ('dbx_column_comment' = 'Reference to the specific season within the series to which this episode belongs. Enables season-level grouping and rights management.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `season_id` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Content Series Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `series_id` SET TAGS ('dbx_column_comment' = 'Reference to the parent series to which this episode belongs. Links episode to its series container.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `genre_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_content_genre_Business_justification' = 'Episodes have genre classification. Normalizes genre_primary/genre_secondary string columns to reference the enterprise genre taxonomy.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `genre_id` SET TAGS ('dbx_metadata_standard' = 'EBUCore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `genre_id` SET TAGS ('dbx_DublinCore' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `genre_id` SET TAGS ('dbx_TVAnytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_rights_license_agreement_Business_justification' = 'Episode-level syndication deals (especially for high-value episodes like finales or specials) require direct linkage to license agreements for run-count tracking and residual calculations.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Master Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_mediaasset_media_asset_Business_justification' = 'Broadcast playout and VOD distribution require direct lookup of the master media asset file for each episode. Traffic systems and playout automation depend on episode-to-asset mapping for scheduling a');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `title_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_content_title_Business_justification' = 'Episodes ARE titles in the master catalog. Every episode should reference its title record for unified content identification and metadata management.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `archive_date` SET TAGS ('dbx_business_glossary_term' = 'Archive Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `archive_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `archive_date` SET TAGS ('dbx_column_comment' = 'Date when the episode master was moved to long-term archive storage. Used for asset lifecycle management and storage optimization.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `archive_location` SET TAGS ('dbx_business_glossary_term' = 'Archive Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `archive_location` SET TAGS ('dbx_column_comment' = 'Physical or logical location identifier for the archived master copy in the Media Asset Management (MAM) system. Supports long-term preservation and retrieval.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_column_comment' = 'Display aspect ratio of the episode video. Affects playout configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_transcoding_profiles' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_and_distribution_format_specifications' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_column_comment' = 'Indicates whether audio description track is available for visually impaired viewers. Required for accessibility compliance.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_regulation' = 'EBU R128');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `broadcast_count` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `broadcast_count` SET TAGS ('dbx_column_comment' = 'Total number of times this episode has been broadcast on linear television. Used for residuals calculation and syndication rights management.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `broadcast_count` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_column_comment' = 'Indicates whether closed captioning is available for this episode. Required for FCC compliance and accessibility standards.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when the episode record was first created in the content management system. Used for audit trail and data lineage tracking.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_standard_identifier' = 'EIDR');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_first_class' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_regex' = '^10.5240/...');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_column_comment' = 'Globally unique identifier for the episode registered with the Entertainment Identifier Registry. Enables universal content identification across distribution platforms and rights management systems.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_validation_regex' = '^10.5240/[0-9A-F-]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_standard' = 'EIDR');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_regex_validation' = '^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `episode_number` SET TAGS ('dbx_business_glossary_term' = 'Episode Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `episode_number` SET TAGS ('dbx_column_comment' = 'Sequential number of the episode within its season. Used for ordering and identification in Electronic Program Guide (EPG) and Video On Demand (VOD) catalogs.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Content Keywords');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `keywords` SET TAGS ('dbx_column_comment' = 'Comma-separated list of keywords and tags describing episode themes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `keywords` SET TAGS ('dbx_topics' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `keywords` SET TAGS ('dbx_and_notable_elements_Supports_content_search' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `keywords` SET TAGS ('dbx_discovery' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `keywords` SET TAGS ('dbx_and_metadata_enrichment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `keywords` SET TAGS ('dbx_metadata_standard' = 'EBUCore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `keywords` SET TAGS ('dbx_DublinCore' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `keywords` SET TAGS ('dbx_TVAnytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when the episode record was last modified. Supports change tracking and data quality monitoring.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `music_cue_sheet_submitted` SET TAGS ('dbx_business_glossary_term' = 'Music Cue Sheet Submitted Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `music_cue_sheet_submitted` SET TAGS ('dbx_column_comment' = 'Indicates whether the music cue sheet has been submitted for royalty collection. Required for music rights compliance and royalty distribution.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `original_air_date` SET TAGS ('dbx_business_glossary_term' = 'Original Air Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `original_air_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `original_air_date` SET TAGS ('dbx_column_comment' = 'The date when the episode was first broadcast on linear television. Critical for rights windowing');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `original_air_date` SET TAGS ('dbx_residuals_calculation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `original_air_date` SET TAGS ('dbx_and_syndication_eligibility' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `premiere_flag` SET TAGS ('dbx_business_glossary_term' = 'Premiere Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `premiere_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `premiere_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this is a premiere episode (first broadcast). Used for promotional planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `premiere_flag` SET TAGS ('dbx_upfront_advertising_sales' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `premiere_flag` SET TAGS ('dbx_and_Nielsen_sweeps_period_strategy' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Language Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `primary_language` SET TAGS ('dbx_value_regex' = '^[a-z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `primary_language` SET TAGS ('dbx_column_comment' = 'ISO 639-3 three-letter code for the primary audio language of the episode. Used for content cataloging');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `primary_language` SET TAGS ('dbx_rights_clearance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `primary_language` SET TAGS ('dbx_and_distribution_targeting' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `primary_language` SET TAGS ('dbx_metadata_standard' = 'EBUCore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `primary_language` SET TAGS ('dbx_DublinCore' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `primary_language` SET TAGS ('dbx_TVAnytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `primary_language` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `rerun_flag` SET TAGS ('dbx_business_glossary_term' = 'Rerun Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `rerun_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `rerun_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this broadcast is a rerun. Affects advertising rates');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `rerun_flag` SET TAGS ('dbx_Cost_Per_Rating_Point_(CPRP)_calculations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `rerun_flag` SET TAGS ('dbx_and_residuals_payments_to_talent' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `runtime_seconds` SET TAGS ('dbx_business_glossary_term' = 'Runtime in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `runtime_seconds` SET TAGS ('dbx_column_comment' = 'Total duration of the episode content in seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `runtime_seconds` SET TAGS ('dbx_excluding_commercial_breaks_Used_for_playout_scheduling' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `runtime_seconds` SET TAGS ('dbx_ad_pod_allocation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `runtime_seconds` SET TAGS ('dbx_and_Electronic_Program_Guide_(EPG)_display' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `runtime_with_ads_seconds` SET TAGS ('dbx_business_glossary_term' = 'Runtime With Advertisements in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `runtime_with_ads_seconds` SET TAGS ('dbx_column_comment' = 'Total broadcast duration including commercial ad breaks. Used for linear scheduling and daypart planning.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `subtitles_available` SET TAGS ('dbx_business_glossary_term' = 'Subtitles Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `subtitles_available` SET TAGS ('dbx_column_comment' = 'Indicates whether subtitle tracks are available for this episode. Supports international distribution and localization strategies.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_business_glossary_term' = 'Episode Synopsis Long');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_column_comment' = 'Detailed description of the episode plot');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_themes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_and_key_moments_Used_for_Video_On_Demand_(VOD)_platforms' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_promotional_materials' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_and_content_discovery' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_metadata_standard' = 'EBUCore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_DublinCore' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_TVAnytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_business_glossary_term' = 'Episode Synopsis Short');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_column_comment' = 'Brief summary of the episode content');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_typically_50_100_characters_Used_for_Electronic_Program_Guide_(EPG)_listings_and_mobile_applications_with_limited_display_space' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_metadata_standard' = 'EBUCore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_DublinCore' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_TVAnytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Episode Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `title` SET TAGS ('dbx_column_comment' = 'The official title or name of the episode. Displayed in Electronic Program Guide (EPG)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `title` SET TAGS ('dbx_Video_On_Demand_(VOD)_interfaces' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `title` SET TAGS ('dbx_and_promotional_materials' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `title` SET TAGS ('dbx_metadata_standard' = 'EBUCore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `title` SET TAGS ('dbx_DublinCore' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `title` SET TAGS ('dbx_TVAnytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `video_resolution` SET TAGS ('dbx_business_glossary_term' = 'Video Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `video_resolution` SET TAGS ('dbx_value_regex' = 'SD|HD|FHD|UHD|4K|8K');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `video_resolution` SET TAGS ('dbx_column_comment' = 'Maximum video resolution available for this episode. Determines distribution channel eligibility and Adaptive Bitrate Streaming (ABR) profile selection.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `vod_available_from_date` SET TAGS ('dbx_business_glossary_term' = 'Video On Demand (VOD) Available From Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `vod_available_from_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `vod_available_from_date` SET TAGS ('dbx_column_comment' = 'Date when the episode becomes available on Video On Demand (VOD) platforms. Part of windowing strategy and rights holdback management.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `vod_available_until_date` SET TAGS ('dbx_business_glossary_term' = 'Video On Demand (VOD) Available Until Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `vod_available_until_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`episode` ALTER COLUMN `vod_available_until_date` SET TAGS ('dbx_column_comment' = 'Date when the episode is removed from Video On Demand (VOD) platforms. Enforces rights windows and exclusivity periods.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Version Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `version_id` SET TAGS ('dbx_column_comment' = 'Primary key for version');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Abr Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_distribution_abr_profile_Business_justification' = 'Content versions are encoded to specific ABR profiles (HLS ladder');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_DASH_manifest)_Essential_for_transcode_workflow' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_QC_validation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_and_ensuring_version_matches_target_platform's_adaptive_bitrate_stre' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `clearance_request_id` SET TAGS ('dbx_business_glossary_term' = 'Clearance Request Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Drm Policy Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_distribution_drm_policy_Business_justification' = 'Each content version is protected by specific DRM policy (Widevine L1');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_HDCP_2_2_requirements)_Required_for_rights_enforcement' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_device_compatibility_validation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_and_studio_compliance_in_premium_conten' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `grant_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_rights_rights_grant_Business_justification' = 'Version-specific grants (4K rights vs HD rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `grant_id` SET TAGS ('dbx_dubbed_vs_subtitled)_are_tracked_separately_in_modern_distribution_Clearance_systems_must_validate_that_the_specific_version_has_an_active_grant' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_rights_license_agreement_Business_justification' = 'Different versions (theatrical cut');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_director's_cut' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_TV_edit' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_international_dub)_often_have_separate_rights_agreements_with_distinct_terms_Clearance_and_distribution_workflows_require_version_specific' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Master Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_mediaasset_media_asset_Business_justification' = 'Each content version (territory/platform-specific cut) references its master media asset for distribution. Fulfillment workflows require version-to-asset mapping to deliver correct files to platforms');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `title_id` SET TAGS ('dbx_column_comment' = 'Reference to the master content asset (title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `title_id` SET TAGS ('dbx_episode' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `title_id` SET TAGS ('dbx_series' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `title_id` SET TAGS ('dbx_film' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `title_id` SET TAGS ('dbx_clip' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `title_id` SET TAGS ('dbx_music' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `title_id` SET TAGS ('dbx_news_segment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `title_id` SET TAGS ('dbx_or_live_event)_that_this_version_belongs_to' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this version was approved for distribution and playout.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Archived Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this version was moved to long-term archive storage.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_column_comment' = 'Display aspect ratio of this version (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_'16' = '9');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_'4' = '3');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_'21' = '9');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_'2_39' = '1).');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_codec` SET TAGS ('dbx_business_glossary_term' = 'Audio Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_codec` SET TAGS ('dbx_column_comment' = 'Audio compression codec used for this version (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_codec` SET TAGS ('dbx_'AAC'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_codec` SET TAGS ('dbx_'AC_3'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_codec` SET TAGS ('dbx_'E_AC_3'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_codec` SET TAGS ('dbx_'Dolby_Atmos'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_codec` SET TAGS ('dbx_'DTS')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_codec` SET TAGS ('dbx_regulation' = 'EBU R128');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_column_comment' = 'Indicates whether audio description track is available for visually impaired audiences');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_supporting_accessibility_compliance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_regulation' = 'EBU R128');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_track_configuration` SET TAGS ('dbx_business_glossary_term' = 'Audio Track Configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_track_configuration` SET TAGS ('dbx_column_comment' = 'Comma-separated list of audio track languages and types available in this version (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_track_configuration` SET TAGS ('dbx_'en' = 'stereo');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_track_configuration` SET TAGS ('dbx_es' = '5.1');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_track_configuration` SET TAGS ('dbx_fr' = 'stereo');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_track_configuration` SET TAGS ('dbx_en' = 'descriptive).');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `audio_track_configuration` SET TAGS ('dbx_regulation' = 'EBU R128');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `broadcast_safe` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Safe');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `broadcast_safe` SET TAGS ('dbx_column_comment' = 'Indicates whether this version has been certified as broadcast-safe');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `broadcast_safe` SET TAGS ('dbx_meeting_technical_standards_for_linear_transmission_(audio_levels' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `broadcast_safe` SET TAGS ('dbx_video_levels' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `broadcast_safe` SET TAGS ('dbx_closed_captioning)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `broadcast_safe` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_business_glossary_term' = 'Checksum Message Digest 5 (MD5)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{32}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_column_comment' = 'MD5 hash checksum of the version file');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_used_for_integrity_verification_during_transfer_and_archival' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Available');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_column_comment' = 'Indicates whether closed captioning (CC) is available for this version');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_supporting_accessibility_compliance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this version record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_column_comment' = 'Total file size of this version in bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_used_for_storage_planning_and_delivery_bandwidth_estimation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `frame_rate` SET TAGS ('dbx_business_glossary_term' = 'Frame Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `frame_rate` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `frame_rate` SET TAGS ('dbx_column_comment' = 'Frame rate of this version in frames per second (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `frame_rate` SET TAGS ('dbx_23_98' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `frame_rate` SET TAGS ('dbx_24_00' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `frame_rate` SET TAGS ('dbx_25_00' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `frame_rate` SET TAGS ('dbx_29_97' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `frame_rate` SET TAGS ('dbx_30_00' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `frame_rate` SET TAGS ('dbx_50_00' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `frame_rate` SET TAGS ('dbx_59_94' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `frame_rate` SET TAGS ('dbx_60_00)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `label` SET TAGS ('dbx_business_glossary_term' = 'Version Label');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `label` SET TAGS ('dbx_column_comment' = 'Human-readable label identifying this version (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `label` SET TAGS ('dbx_'Theatrical_Cut'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `label` SET TAGS ('dbx_'Director's_Cut'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `label` SET TAGS ('dbx_'Broadcast_Safe'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `label` SET TAGS ('dbx_'Spanish_Dub'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `label` SET TAGS ('dbx_'UK_Censored')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this version record was last modified.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `qc_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Completed Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `qc_completed_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `qc_completed_date` SET TAGS ('dbx_column_comment' = 'Date when quality control review was completed for this version.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `resolution` SET TAGS ('dbx_business_glossary_term' = 'Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `resolution` SET TAGS ('dbx_value_regex' = 'sd|hd_720p|hd_1080p|uhd_4k|uhd_8k');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `resolution` SET TAGS ('dbx_column_comment' = 'Video resolution classification for this version (SD');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `resolution` SET TAGS ('dbx_HD_720p' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `resolution` SET TAGS ('dbx_HD_1080p' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `resolution` SET TAGS ('dbx_UHD_4K' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `resolution` SET TAGS ('dbx_UHD_8K)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `runtime_delta_seconds` SET TAGS ('dbx_business_glossary_term' = 'Runtime Delta in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `runtime_delta_seconds` SET TAGS ('dbx_column_comment' = 'Difference in runtime (in seconds) between this version and the master version. Positive values indicate longer runtime');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `runtime_delta_seconds` SET TAGS ('dbx_negative_indicate_shorter' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `runtime_seconds` SET TAGS ('dbx_business_glossary_term' = 'Runtime in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `runtime_seconds` SET TAGS ('dbx_column_comment' = 'Total runtime of this version in seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `runtime_seconds` SET TAGS ('dbx_representing_the_complete_playback_duration' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `storage_location` SET TAGS ('dbx_column_comment' = 'Physical or logical storage location identifier where this version is archived (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `storage_location` SET TAGS ('dbx_tape_library_ID' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `storage_location` SET TAGS ('dbx_cloud_bucket_path' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `storage_location` SET TAGS ('dbx_MAM_archive_reference)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `storage_location` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Languages');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_column_comment' = 'Comma-separated list of ISO 639 language codes for subtitle tracks included in this version (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_'en' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_es' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_fr' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_de')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `video_codec` SET TAGS ('dbx_business_glossary_term' = 'Video Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `video_codec` SET TAGS ('dbx_column_comment' = 'Video compression codec used for this version (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `video_codec` SET TAGS ('dbx_'H_264'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `video_codec` SET TAGS ('dbx_'H_265_HEVC'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `video_codec` SET TAGS ('dbx_'VP9'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `video_codec` SET TAGS ('dbx_'AV1'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`version` ALTER COLUMN `video_codec` SET TAGS ('dbx_'MPEG_2')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the genre. Primary key for the genre reference taxonomy.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_id` SET TAGS ('dbx_metadata_standard' = 'EBUCore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_id` SET TAGS ('dbx_DublinCore' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_id` SET TAGS ('dbx_TVAnytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `parent_genre_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Genre Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `parent_genre_id` SET TAGS ('dbx_column_comment' = 'Reference to the parent genre in the hierarchical taxonomy');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `parent_genre_id` SET TAGS ('dbx_enabling_multi_level_classification_such_as_Drama_>_Legal_Drama_or_Sports_>_Football_Null_for_top_level_genres' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `ad_pod_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Compatibility');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `ad_pod_compatibility` SET TAGS ('dbx_column_comment' = 'Indicates whether content in this genre is compatible with Dynamic Ad Insertion (DAI) and ad pod placement. False for genres requiring uninterrupted viewing (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `ad_pod_compatibility` SET TAGS ('dbx_live_sports_critical_moments' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `ad_pod_compatibility` SET TAGS ('dbx_news_breaking_coverage)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `applicable_content_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Content Types');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `applicable_content_types` SET TAGS ('dbx_column_comment' = 'Comma-separated list of content types to which this genre applies (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `applicable_content_types` SET TAGS ('dbx_series' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `applicable_content_types` SET TAGS ('dbx_film' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `applicable_content_types` SET TAGS ('dbx_clip' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `applicable_content_types` SET TAGS ('dbx_live_event' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `applicable_content_types` SET TAGS ('dbx_news_segment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `applicable_content_types` SET TAGS ('dbx_music_video)_Enables_content_type_specific_genre_filtering' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `archive_retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Archive Retention Policy');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `archive_retention_policy` SET TAGS ('dbx_value_regex' = 'permanent|long_term|standard|short_term');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `archive_retention_policy` SET TAGS ('dbx_column_comment' = 'Digital asset archival retention policy for content in this genre. Permanent retention for high-value evergreen genres; short-term for time-sensitive news and event content.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `avod_monetization_potential` SET TAGS ('dbx_business_glossary_term' = 'Advertising-Supported Video On Demand (AVOD) Monetization Potential');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `avod_monetization_potential` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `avod_monetization_potential` SET TAGS ('dbx_column_comment' = 'Revenue generation potential for this genre on Advertising-Supported Video On Demand (AVOD) platforms');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `avod_monetization_potential` SET TAGS ('dbx_based_on_Cost_Per_Mille_(CPM)_rates_and_advertiser_demand_High_potential_genres_command_premium_ad_rates' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this genre record was first created in the enterprise content taxonomy system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `daypart_affinity` SET TAGS ('dbx_business_glossary_term' = 'Daypart Affinity');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `daypart_affinity` SET TAGS ('dbx_column_comment' = 'Comma-separated list of broadcast dayparts where this genre typically performs best (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `daypart_affinity` SET TAGS ('dbx_prime_time' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `daypart_affinity` SET TAGS ('dbx_late_night' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `daypart_affinity` SET TAGS ('dbx_early_morning' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `daypart_affinity` SET TAGS ('dbx_daytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `daypart_affinity` SET TAGS ('dbx_weekend)_Informs_program_scheduling_and_playout_automation_strategies' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_description` SET TAGS ('dbx_business_glossary_term' = 'Genre Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_description` SET TAGS ('dbx_column_comment' = 'Detailed textual description of the genre');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_description` SET TAGS ('dbx_including_defining_characteristics' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_description` SET TAGS ('dbx_typical_content_examples' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_description` SET TAGS ('dbx_and_audience_expectations_Used_for_editorial_guidance_and_content_acquisition_briefings' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_column_comment' = 'Date when this genre classification was retired or superseded. Null for currently active genres. Used for historical content classification and reporting continuity.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_column_comment' = 'Date when this genre classification became effective and available for use in content metadata and scheduling systems.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `eidr_genre_mapping` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) Genre Mapping');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `eidr_genre_mapping` SET TAGS ('dbx_standard_identifier' = 'EIDR');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `eidr_genre_mapping` SET TAGS ('dbx_first_class' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `eidr_genre_mapping` SET TAGS ('dbx_regex' = '^10.5240/...');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `eidr_genre_mapping` SET TAGS ('dbx_column_comment' = 'Mapping to Entertainment Identifier Registry (EIDR) genre taxonomy for cross-industry content identification and rights management interoperability.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `eidr_genre_mapping` SET TAGS ('dbx_validation_regex' = '^10.5240/[0-9A-F-]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `eidr_genre_mapping` SET TAGS ('dbx_standard' = 'EIDR');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `fast_channel_applicability` SET TAGS ('dbx_business_glossary_term' = 'Free Ad-Supported Streaming Television (FAST) Channel Applicability');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `fast_channel_applicability` SET TAGS ('dbx_column_comment' = 'Indicates whether this genre is suitable for Free Ad-Supported Streaming Television (FAST) linear channel programming. FAST channels require genres with deep catalog availability and consistent audience appeal.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `geographic_restriction_applicability` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Applicability');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `geographic_restriction_applicability` SET TAGS ('dbx_column_comment' = 'Indicates whether content in this genre is subject to geographic blackout restrictions or regional licensing constraints. Common for sports genres with territorial rights and retransmission consent agreements.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `is_active` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `is_active` SET TAGS ('dbx_column_comment' = 'Indicates whether this genre is currently active and available for content classification. Inactive genres are retained for historical content but not used for new acquisitions.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this genre record was last updated. Used for change tracking and metadata synchronization across Electronic Program Guide (EPG)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_Media_Asset_Management_(MAM)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_and_distribution_systems' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `linear_broadcast_suitability` SET TAGS ('dbx_business_glossary_term' = 'Linear Broadcast Suitability');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `linear_broadcast_suitability` SET TAGS ('dbx_column_comment' = 'Indicates whether this genre is suitable for traditional linear scheduled broadcasting. Some genres (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `linear_broadcast_suitability` SET TAGS ('dbx_interactive' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `linear_broadcast_suitability` SET TAGS ('dbx_choose_your_own_adventure)_are_non_linear_only' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `linear_broadcast_suitability` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `localization_priority` SET TAGS ('dbx_business_glossary_term' = 'Localization Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `localization_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `localization_priority` SET TAGS ('dbx_column_comment' = 'Priority level for content localization (dubbing');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `localization_priority` SET TAGS ('dbx_subtitling' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `localization_priority` SET TAGS ('dbx_cultural_adaptation)_for_this_genre_High_priority_genres_justify_investment_in_multi_language_versions_for_international_distribution' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `metadata_enrichment_priority` SET TAGS ('dbx_business_glossary_term' = 'Metadata Enrichment Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `metadata_enrichment_priority` SET TAGS ('dbx_value_regex' = 'critical|standard|minimal');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `metadata_enrichment_priority` SET TAGS ('dbx_column_comment' = 'Priority level for metadata enrichment and tagging in Media Asset Management (MAM) systems. Critical genres require comprehensive metadata for content discovery and personalization.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `mpa_rating_applicability` SET TAGS ('dbx_business_glossary_term' = 'Motion Picture Association (MPA) Rating Applicability');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `mpa_rating_applicability` SET TAGS ('dbx_column_comment' = 'Comma-separated list of Motion Picture Association (MPA) ratings typically associated with this genre (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `mpa_rating_applicability` SET TAGS ('dbx_G' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `mpa_rating_applicability` SET TAGS ('dbx_PG' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `mpa_rating_applicability` SET TAGS ('dbx_PG_13' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `mpa_rating_applicability` SET TAGS ('dbx_R' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `mpa_rating_applicability` SET TAGS ('dbx_NC_17)_Used_for_content_clearance_and_daypart_scheduling_compliance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_name` SET TAGS ('dbx_business_glossary_term' = 'Genre Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_name` SET TAGS ('dbx_column_comment' = 'Full display name of the genre as presented to audiences in Electronic Program Guides (EPG)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_name` SET TAGS ('dbx_streaming_platform_interfaces' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_name` SET TAGS ('dbx_and_content_discovery_systems' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `genre_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `ott_platform_priority` SET TAGS ('dbx_business_glossary_term' = 'Over-The-Top (OTT) Platform Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `ott_platform_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `ott_platform_priority` SET TAGS ('dbx_column_comment' = 'Priority level for featuring this genre on Over-The-Top (OTT) streaming platforms and Video On Demand (VOD) services. High priority genres receive prominent placement in content discovery and recommendation engines.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `parental_guidance_flag` SET TAGS ('dbx_business_glossary_term' = 'Parental Guidance Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `parental_guidance_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `parental_guidance_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether content in this genre typically requires parental guidance warnings or viewer discretion advisories. Used for compliance with Federal Communications Commission (FCC) broadcast standards and Childrens Online Privacy Protection Act (COPPA) requirements.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `parental_guidance_flag` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `syndication_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Syndication Eligibility');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `syndication_eligibility` SET TAGS ('dbx_column_comment' = 'Indicates whether content in this genre is typically eligible for syndication to multiple outlets and resale. Used in rights and royalties management and windowing strategy planning.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `target_demographic` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `target_demographic` SET TAGS ('dbx_column_comment' = 'Primary audience demographic segment targeted by this genre');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `target_demographic` SET TAGS ('dbx_expressed_in_Nielsen_demographic_notation_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `target_demographic` SET TAGS ('dbx_A18_49' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `target_demographic` SET TAGS ('dbx_M25_54' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `target_demographic` SET TAGS ('dbx_W18_34)_Used_for_Target_Rating_Point_(TRP)_and_Gross_Rating_Point_(GRP)_planning' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `usage_notes` SET TAGS ('dbx_business_glossary_term' = 'Usage Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `usage_notes` SET TAGS ('dbx_column_comment' = 'Internal notes and guidelines for content producers');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `usage_notes` SET TAGS ('dbx_schedulers' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `usage_notes` SET TAGS ('dbx_and_metadata_specialists_on_proper_application_of_this_genre_classification_Includes_edge_cases_and_disambiguation_rules' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`genre` ALTER COLUMN `usage_notes` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `localization_id` SET TAGS ('dbx_business_glossary_term' = 'Localization ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `localization_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the localization work product record.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `clearance_request_id` SET TAGS ('dbx_business_glossary_term' = 'Clearance Request Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Localized Asset Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Localized Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_mediaasset_media_asset_Business_justification' = 'Localized audio tracks and subtitle files are delivered as media assets. Distribution workflows require linking localization records to their delivered asset files for QC');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_versioning' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_and_platform_del' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_distribution_ott_platform_Business_justification' = 'Localizations are prepared for specific platform technical specs (Netflix TDF');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_iTunes_metadata_format)_Platform_specific_subtitle_formats' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_audio_track_configurations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_and_metadata_requirements_drive' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Title Version ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `version_id` SET TAGS ('dbx_column_comment' = 'Reference to the specific title version being localized.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Voice Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `profile_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_talent_talent_profile_Business_justification' = 'Dubbing and voice localization require tracking which talent performed the localized version for residual payments');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `profile_id` SET TAGS ('dbx_credit_attribution' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `profile_id` SET TAGS ('dbx_and_guild_reporting_Essential_for_international_content_distrib' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `accessibility_standard_met` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Standard Met');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `accessibility_standard_met` SET TAGS ('dbx_value_regex' = 'WCAG_2.1_AA|WCAG_2.2_AA|FCC_CVAA|EAA|ADA|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `accessibility_standard_met` SET TAGS ('dbx_column_comment' = 'Specific accessibility standard that the localization work product complies with (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `accessibility_standard_met` SET TAGS ('dbx_WCAG_2_1_AA' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `accessibility_standard_met` SET TAGS ('dbx_FCC_CVAA)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_column_comment' = 'Actual date when the localization work product was delivered by the vendor or internal team.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when the localization work product received final approval for distribution.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_column_comment' = 'Name of the individual or role who provided final approval for the localization work product.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `asset_file_path` SET TAGS ('dbx_business_glossary_term' = 'Asset File Path');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `asset_file_path` SET TAGS ('dbx_column_comment' = 'Storage location or URI path to the delivered localization asset file in the Media Asset Management (MAM) system or Content Delivery Network (CDN).');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `character_count` SET TAGS ('dbx_business_glossary_term' = 'Character Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `character_count` SET TAGS ('dbx_column_comment' = 'Total number of characters in the subtitle or metadata translation work product');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `character_count` SET TAGS ('dbx_used_for_billing_and_capacity_planning' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `compliance_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `compliance_certification_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `compliance_certification_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the localization meets regulatory compliance requirements for the target territory (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `compliance_certification_flag` SET TAGS ('dbx_local_content_quotas' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `compliance_certification_flag` SET TAGS ('dbx_language_laws' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `compliance_certification_flag` SET TAGS ('dbx_accessibility_standards)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Localization Cost Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `cost_amount` SET TAGS ('dbx_column_comment' = 'Total cost incurred for this localization work product');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `cost_amount` SET TAGS ('dbx_including_vendor_fees' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `cost_amount` SET TAGS ('dbx_studio_costs' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `cost_amount` SET TAGS ('dbx_and_internal_labor' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when this localization record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_column_comment' = 'Total runtime duration in minutes of the content being localized');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_relevant_for_dubbing_and_subtitling_scope' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `order_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `order_date` SET TAGS ('dbx_column_comment' = 'Date when the localization work was ordered from the vendor or internal team.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_column_comment' = 'Purchase order number issued to the localization vendor for this work product.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `qc_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `qc_notes` SET TAGS ('dbx_column_comment' = 'Detailed notes and findings from the quality control review process');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `qc_notes` SET TAGS ('dbx_including_any_defects_or_issues_identified' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `qc_pass_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Pass Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `qc_pass_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `qc_pass_flag` SET TAGS ('dbx_column_comment' = 'Boolean indicator of whether the localization work product passed quality control review.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `qc_review_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `qc_review_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `qc_review_date` SET TAGS ('dbx_column_comment' = 'Date when quality control review of the localization work product was completed.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `qc_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Reviewer Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `qc_reviewer_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `qc_reviewer_name` SET TAGS ('dbx_column_comment' = 'Name of the individual or team who performed the quality control review.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `qc_reviewer_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `qc_reviewer_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `revision_reason` SET TAGS ('dbx_column_comment' = 'Business reason or description for why a revision of the localization work product was required.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `revision_reason` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `revision_reason` SET TAGS ('dbx_ENUM_REF_CANDIDATE' = 'promote-to-reference-product');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `scheduled_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `scheduled_delivery_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `scheduled_delivery_date` SET TAGS ('dbx_column_comment' = 'Contractually agreed or planned delivery date for the completed localization work product.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when this localization record was last modified.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `version_number` SET TAGS ('dbx_column_comment' = 'Version identifier for this localization work product');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`localization` ALTER COLUMN `version_number` SET TAGS ('dbx_supporting_iterative_revisions_and_updates' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `talent_credit_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Credit Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `talent_credit_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the talent credit record. Primary key for the talent credit association entity.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Contract Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `contract_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_talent_talent_contract_Business_justification' = 'Credits must link to contracts for residual calculation');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `contract_id` SET TAGS ('dbx_compensation_verification' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `contract_id` SET TAGS ('dbx_guild_compliance_reporting' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `contract_id` SET TAGS ('dbx_and_billing_position_validation_Fundamental_to_talent_payment_and_rights_management_pro' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `episode_id` SET TAGS ('dbx_business_glossary_term' = 'Episode Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `episode_id` SET TAGS ('dbx_column_comment' = 'Reference to the specific episode within a series for which the talent is credited. Nullable for non-episodic content such as films or specials.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `profile_id` SET TAGS ('dbx_column_comment' = 'Reference to the talent master record in the talent domain. Links to the individual or entity receiving credit for their contribution to the content.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Role Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `role_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_talent_talent_role_Business_justification' = 'Credits reference specific roles for character attribution');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `role_id` SET TAGS ('dbx_billing_position_validation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `role_id` SET TAGS ('dbx_and_role_specific_residual_eligibility_Eliminates_denormalized_role_character_data_and_ensures_single_source_o' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `title_id` SET TAGS ('dbx_column_comment' = 'Reference to the content title (film');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `title_id` SET TAGS ('dbx_series' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `title_id` SET TAGS ('dbx_special' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `title_id` SET TAGS ('dbx_documentary)_for_which_the_talent_is_credited_Links_to_the_content_master_catalog' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `billing_position` SET TAGS ('dbx_business_glossary_term' = 'Billing Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `billing_position` SET TAGS ('dbx_column_comment' = 'The ordinal position of the talent in the credit sequence');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `billing_position` SET TAGS ('dbx_determining_the_order_in_which_credits_are_displayed_Lower_numbers_indicate_higher_prominence_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `billing_position` SET TAGS ('dbx_1' = 'top billing). Used for EPG display and contractual compliance.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'The timestamp when this talent credit record was first created in the system. Used for audit trails and data lineage tracking.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_approval_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_approval_date` SET TAGS ('dbx_column_comment' = 'The date on which the credit was officially approved for publication. Used for audit trails and compliance with guild credit determination timelines.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_display_name` SET TAGS ('dbx_business_glossary_term' = 'Credit Display Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_display_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_display_name` SET TAGS ('dbx_column_comment' = 'The exact name as it should appear in credits');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_display_name` SET TAGS ('dbx_EPG_metadata' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_display_name` SET TAGS ('dbx_and_streaming_platform_displays_May_differ_from_the_talents_legal_name_if_a_pseudonym_or_stage_name_is_used_This_is_the_authoritative_display_value_for_all_public_facing_credit_presentations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_display_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_display_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_display_order` SET TAGS ('dbx_business_glossary_term' = 'Credit Display Order');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_display_order` SET TAGS ('dbx_column_comment' = 'The sequence number for displaying this credit within its credit type or section (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_display_order` SET TAGS ('dbx_within_the_cast_section_or_crew_section)_Used_for_rendering_credits_in_EPG' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_display_order` SET TAGS ('dbx_streaming_platforms' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_display_order` SET TAGS ('dbx_and_promotional_materials' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Credit End Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_end_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_end_timestamp` SET TAGS ('dbx_column_comment' = 'The timestamp marking when this credit ceases to be effective or visible. Nullable for credits that remain active indefinitely. Used for managing credit corrections');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_end_timestamp` SET TAGS ('dbx_disputes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_end_timestamp` SET TAGS ('dbx_or_contractual_credit_windows' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_notes` SET TAGS ('dbx_business_glossary_term' = 'Credit Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_notes` SET TAGS ('dbx_column_comment' = 'Free-text field for additional context');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_notes` SET TAGS ('dbx_special_credit_requirements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_notes` SET TAGS ('dbx_contractual_stipulations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_notes` SET TAGS ('dbx_or_notes_related_to_credit_disputes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_notes` SET TAGS ('dbx_arbitration_outcomes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_notes` SET TAGS ('dbx_or_special_billing_arrangements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Credit Start Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_start_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `credit_start_timestamp` SET TAGS ('dbx_column_comment' = 'The timestamp marking when this credit becomes effective or visible in EPG and streaming platform metadata. Used for managing credit changes over time and versioning.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `pseudonym_flag` SET TAGS ('dbx_business_glossary_term' = 'Pseudonym Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `pseudonym_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `pseudonym_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the talent is credited under a pseudonym or stage name rather than their legal name. True if pseudonym is used; False if legal name is used. Relevant for guild compliance and contractual credit requirements.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `residuals_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Residuals Eligibility Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `residuals_eligibility_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `residuals_eligibility_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this credit qualifies the talent for residual payments based on content reuse');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `residuals_eligibility_flag` SET TAGS ('dbx_syndication' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `residuals_eligibility_flag` SET TAGS ('dbx_or_secondary_distribution_True_if_eligible;_False_otherwise_Triggers_residuals_calculation_workflows_in_the_rights_and_royalties_domain' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `union_affiliation_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Affiliation Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `union_affiliation_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `union_affiliation_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the talent is affiliated with a recognized industry union (SAG-AFTRA');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `union_affiliation_flag` SET TAGS ('dbx_DGA' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `union_affiliation_flag` SET TAGS ('dbx_WGA' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `union_affiliation_flag` SET TAGS ('dbx_IATSE)_for_this_credit_True_if_union_affiliated;_False_otherwise_Used_for_residuals_eligibility_determination_and_compliance_reporting' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_column_comment' = 'The timestamp when this talent credit record was last modified. Used for audit trails');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_change_tracking' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_and_data_quality_monitoring' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`talent_credit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` SET TAGS ('dbx_subdomain' = 'rights_distribution');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `acquisition_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `acquisition_id` SET TAGS ('dbx_column_comment' = 'Primary key for acquisition');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `clearance_request_id` SET TAGS ('dbx_business_glossary_term' = 'Clearance Request Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `version_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_content_version_Business_justification' = 'Acquisitions often specify which version was acquired (theatrical vs broadcast cut');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `version_id` SET TAGS ('dbx_localized_version)_This_FK_allows_tracking_version_specific_acquisition_terms_and_rights' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Holder Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_rights_license_agreement_Business_justification' = 'Acquisition records must reference the underlying license agreement that enabled the acquisition. Financial reconciliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_audit_trails' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_and_rights_validation_require_linking_acquisitions_to_their_go' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `royalty_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rule Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `title_id` SET TAGS ('dbx_column_comment' = 'Reference to the content asset being acquired. Links to the master content catalog entry for the title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `title_id` SET TAGS ('dbx_episode' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `title_id` SET TAGS ('dbx_series' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `title_id` SET TAGS ('dbx_film' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `title_id` SET TAGS ('dbx_clip' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `title_id` SET TAGS ('dbx_or_other_content_asset' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_column_comment' = 'The date on which the acquisition transaction was executed and the content rights were legally transferred or licensed to the enterprise. Represents the principal business event timestamp for this transaction.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `ancillary_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Rights Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `ancillary_rights_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `ancillary_rights_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether ancillary rights (merchandising');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `ancillary_rights_flag` SET TAGS ('dbx_soundtrack' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `ancillary_rights_flag` SET TAGS ('dbx_publishing' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `ancillary_rights_flag` SET TAGS ('dbx_remake' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `ancillary_rights_flag` SET TAGS ('dbx_sequel' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `ancillary_rights_flag` SET TAGS ('dbx_spin_off' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `ancillary_rights_flag` SET TAGS ('dbx_clip_licensing)_are_included_in_the_acquisition_(True)_or_retained_by_the_supplier_(False)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `cost_amount` SET TAGS ('dbx_column_comment' = 'The total monetary value paid or committed for acquiring the content rights. Represents the base acquisition cost before taxes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `cost_amount` SET TAGS ('dbx_fees' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `cost_amount` SET TAGS ('dbx_or_adjustments_For_licenses' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `cost_amount` SET TAGS ('dbx_this_is_the_total_license_fee;_for_purchases' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `cost_amount` SET TAGS ('dbx_the_purchase_price;_for_commissions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `cost_amount` SET TAGS ('dbx_the_production_budget_committed' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `cost_currency` SET TAGS ('dbx_column_comment' = 'Three-letter ISO 4217 currency code for the acquisition cost amount (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `cost_currency` SET TAGS ('dbx_USD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `cost_currency` SET TAGS ('dbx_GBP' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `cost_currency` SET TAGS ('dbx_EUR' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `cost_currency` SET TAGS ('dbx_JPY)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'The date and time when this acquisition record was first created in the system. Audit field for data lineage and compliance tracking.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `delivery_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `delivery_date` SET TAGS ('dbx_column_comment' = 'The date on which the content master files and associated materials (metadata');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `delivery_date` SET TAGS ('dbx_artwork' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `delivery_date` SET TAGS ('dbx_closed_captions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `delivery_date` SET TAGS ('dbx_promotional_assets)_were_delivered_by_the_supplier_and_ingested_into_the_enterprise_Media_Asset_Management_(MAM)_system' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the acquired rights are exclusive (True) or non-exclusive (False) within the specified territory and window. Exclusive rights prevent the supplier from licensing the same content to competitors in the same territory/window.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `format_rights` SET TAGS ('dbx_business_glossary_term' = 'Format Rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `format_rights` SET TAGS ('dbx_column_comment' = 'The technical formats or delivery specifications covered by the acquisition. May include SD');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `format_rights` SET TAGS ('dbx_HD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `format_rights` SET TAGS ('dbx_4K' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `format_rights` SET TAGS ('dbx_HDR' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `format_rights` SET TAGS ('dbx_theatrical_DCP' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `format_rights` SET TAGS ('dbx_broadcast_master' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `format_rights` SET TAGS ('dbx_streaming_optimized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `format_rights` SET TAGS ('dbx_etc_Defines_the_quality_and_format_tiers_the_enterprise_is_authorized_to_distribute' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_business_glossary_term' = 'Holdback Period Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_column_comment' = 'The number of days during which the content cannot be exploited in certain windows or territories as stipulated by the acquisition agreement. Holdback periods protect prior windows (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_theatrical_holdback_prevents_SVOD_release_for_90_days_post_theatrical)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `language_rights` SET TAGS ('dbx_business_glossary_term' = 'Language Rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `language_rights` SET TAGS ('dbx_column_comment' = 'The languages or language versions for which rights were acquired. May specify original language only');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `language_rights` SET TAGS ('dbx_dubbed_versions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `language_rights` SET TAGS ('dbx_subtitled_versions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `language_rights` SET TAGS ('dbx_or_all_language_adaptations_Examples' = 'English');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `language_rights` SET TAGS ('dbx_Spanish' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `language_rights` SET TAGS ('dbx_French;_All_Languages;_Original_+_Subtitles' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `language_rights` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `license_end_date` SET TAGS ('dbx_business_glossary_term' = 'License End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `license_end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `license_end_date` SET TAGS ('dbx_column_comment' = 'The date on which the acquired content rights expire and the enterprise must cease exploitation. Null for perpetual purchases. For time-limited licenses');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `license_end_date` SET TAGS ('dbx_this_defines_the_end_of_the_license_term' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `license_end_date` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `license_start_date` SET TAGS ('dbx_business_glossary_term' = 'License Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `license_start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `license_start_date` SET TAGS ('dbx_column_comment' = 'The date from which the enterprise is authorized to begin exploiting the acquired content rights. For licenses');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `license_start_date` SET TAGS ('dbx_this_is_the_effective_start_of_the_license_term;_for_purchases' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `license_start_date` SET TAGS ('dbx_typically_the_acquisition_date' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `license_start_date` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_column_comment' = 'The minimum guaranteed payment to the supplier regardless of actual revenue performance. Common in revenue-sharing deals where the enterprise commits to a floor payment even if royalties do not reach this threshold.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Free-text field for additional context');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `notes` SET TAGS ('dbx_special_terms' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `notes` SET TAGS ('dbx_restrictions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `notes` SET TAGS ('dbx_or_operational_notes_related_to_the_acquisition_May_include_information_on_promotional_obligations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `notes` SET TAGS ('dbx_credit_requirements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `notes` SET TAGS ('dbx_or_unique_contractual_stipulations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `payment_terms` SET TAGS ('dbx_column_comment' = 'Contractual payment schedule and conditions for the acquisition cost. May include milestone-based payments');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `payment_terms` SET TAGS ('dbx_installment_schedules' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `payment_terms` SET TAGS ('dbx_advance_payments' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `payment_terms` SET TAGS ('dbx_or_revenue_sharing_arrangements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `payment_terms` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `reference_number` SET TAGS ('dbx_column_comment' = 'External business identifier for this acquisition transaction. May be a purchase order number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `reference_number` SET TAGS ('dbx_deal_reference' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `reference_number` SET TAGS ('dbx_or_contract_line_item_identifier_used_in_communications_with_the_supplier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `residuals_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Residuals Obligation Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `residuals_obligation_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `residuals_obligation_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the enterprise has an obligation to pay residuals (talent reuse payments) to performers');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `residuals_obligation_flag` SET TAGS ('dbx_writers' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `residuals_obligation_flag` SET TAGS ('dbx_directors' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `residuals_obligation_flag` SET TAGS ('dbx_or_other_rights_holders_each_time_the_content_is_rebroadcast_or_redistributed_(True)_or_if_residuals_are_the_supplier's_responsibility_(False)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_column_comment' = 'The percentage of revenue or receipts that must be paid to the supplier as ongoing royalties under a revenue-sharing acquisition model. Null if the acquisition is a flat-fee structure with no revenue share.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `runs_allowed` SET TAGS ('dbx_business_glossary_term' = 'Runs Allowed');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `runs_allowed` SET TAGS ('dbx_column_comment' = 'The maximum number of times the content may be broadcast or streamed under the acquisition agreement. Common in linear broadcast licenses (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `runs_allowed` SET TAGS ('dbx_3_runs_over_2_years)_Null_indicates_unlimited_runs_within_the_license_period' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `runs_consumed` SET TAGS ('dbx_business_glossary_term' = 'Runs Consumed');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `runs_consumed` SET TAGS ('dbx_column_comment' = 'The number of runs (broadcasts or streams) that have been executed to date against the runs_allowed limit. Tracked to ensure compliance with contractual run restrictions.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `sublicensing_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Sublicensing Allowed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `sublicensing_allowed_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `sublicensing_allowed_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the enterprise is permitted to sublicense the acquired content to third parties (True) or must exploit the content directly only (False). Sublicensing enables syndication and secondary distribution deals.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_column_comment' = 'The date and time when this acquisition record was last modified. Audit field for change tracking and data governance.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`acquisition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` SET TAGS ('dbx_subdomain' = 'rights_distribution');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `windowing_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Windowing Plan ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `windowing_plan_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the windowing plan record. Primary key for the windowing plan entity.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `clearance_request_id` SET TAGS ('dbx_business_glossary_term' = 'Clearance Request Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `version_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_content_version_Business_justification' = 'Windowing plans are version-specific (theatrical version has different windows than broadcast version). Links distribution strategy to specific version.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `content_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Content Window Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Asset Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Drm Policy Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_distribution_drm_policy_Business_justification' = 'Each window has specific DRM requirements based on rights agreements (theatrical requires HDCP 2.2');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_rental_allows_offline)_DRM_policy_enforcement_varies_by_window_type_and_revenue_model' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Governing License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_rights_license_agreement_Business_justification' = 'Windowing strategies must comply with license agreement terms (holdbacks');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_exclusivity_windows' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_platform_restrictions)_Windowing_plan_validation_and_conflict_detection_require_checking_against_the_gov' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `grant_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_rights_rights_grant_Business_justification' = 'Each window must map to a specific rights grant that authorizes that exploitation type (SVOD');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `grant_id` SET TAGS ('dbx_AVOD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `grant_id` SET TAGS ('dbx_linear_broadcast)_Clearance_systems_validate_that_the_window's_dates_and_platform_fall_within_grant' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `holdback_id` SET TAGS ('dbx_business_glossary_term' = 'Holdback Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_distribution_ott_platform_Business_justification' = 'Windowing plans define which platform receives content in each release window (theatrical → premium VOD → SVOD → AVOD). Core to revenue maximization strategy and rights holder agreements.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `partner_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_partner_partner_partner_Business_justification' = 'Windowing plans specify distribution partners for each window (theatrical exhibitor');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `partner_id` SET TAGS ('dbx_streaming_platform' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `partner_id` SET TAGS ('dbx_broadcast_network)_Partner_performance_tracking' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `partner_id` SET TAGS ('dbx_holdback_enforcement' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `partner_id` SET TAGS ('dbx_exclusivity_compliance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Campaign');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_distribution_streaming_endpoint_Business_justification' = 'Each distribution window may use specific streaming endpoints (regional CDN POPs');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_premium_tier_endpoints)_Required_for_geo_restriction_enforcement' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_SLA_tier_assignment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_and_CDN_cost_allocation_per_wi' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `territory_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_rights_territory_Business_justification' = 'Windows are territory-specific - geo-blocking');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `territory_id` SET TAGS ('dbx_regional_release_strategies' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `territory_id` SET TAGS ('dbx_and_regulatory_compliance_require_linking_each_window_to_its_target_territory_Clearance_validates_territorial_rights_before' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `territory_id` SET TAGS ('dbx_regulation' = 'Ofcom');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `title_id` SET TAGS ('dbx_column_comment' = 'Reference to the content asset (title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `title_id` SET TAGS ('dbx_episode' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `title_id` SET TAGS ('dbx_series' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `title_id` SET TAGS ('dbx_film' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `title_id` SET TAGS ('dbx_clip)_for_which_this_windowing_plan_is_defined_Links_to_the_master_content_catalog' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `abr_enabled` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Bitrate (ABR) Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `abr_enabled` SET TAGS ('dbx_column_comment' = 'Indicates whether adaptive bitrate streaming is enabled for this window');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `abr_enabled` SET TAGS ('dbx_allowing_dynamic_quality_adjustment_based_on_viewer_bandwidth_True' = 'ABR enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `abr_enabled` SET TAGS ('dbx_False' = 'fixed bitrate.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when this windowing plan was formally approved by authorized stakeholders. Marks transition from draft to confirmed status.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `audio_configuration` SET TAGS ('dbx_business_glossary_term' = 'Audio Configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `audio_configuration` SET TAGS ('dbx_value_regex' = 'stereo|surround_5_1|surround_7_1|dolby_atmos|dts_x');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `audio_configuration` SET TAGS ('dbx_column_comment' = 'The audio format specification for this window. Stereo=2-channel');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `audio_configuration` SET TAGS ('dbx_Surround_5_1' = '5.1 channel surround');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `audio_configuration` SET TAGS ('dbx_Surround_7_1' = '7.1 channel surround');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `audio_configuration` SET TAGS ('dbx_Dolby_Atmos' = 'object-based audio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `audio_configuration` SET TAGS ('dbx_DTS' = 'X=immersive audio format.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `audio_configuration` SET TAGS ('dbx_regulation' = 'EBU R128');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `blackout_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Blackout Restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `blackout_restrictions` SET TAGS ('dbx_column_comment' = 'Geographic or temporal blackout rules that restrict content availability in specific regions or time periods within the territory (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `blackout_restrictions` SET TAGS ('dbx_sports_blackouts' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `blackout_restrictions` SET TAGS ('dbx_regional_exclusions)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `bundle_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Bundle Eligibility');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `bundle_eligibility` SET TAGS ('dbx_column_comment' = 'Indicates whether this content is eligible for inclusion in subscription bundles or multi-title packages during this window. True=bundle eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `bundle_eligibility` SET TAGS ('dbx_False' = 'standalone only.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `concurrent_streams_limit` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Streams Limit');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `concurrent_streams_limit` SET TAGS ('dbx_column_comment' = 'Maximum number of simultaneous streams allowed per subscriber account for this content in this window. Used for subscription service tier management.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when this windowing plan record was first created in the system. Audit trail for record lifecycle.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `daypart_restriction` SET TAGS ('dbx_business_glossary_term' = 'Daypart Restriction');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `daypart_restriction` SET TAGS ('dbx_column_comment' = 'Time-of-day broadcast restrictions for linear windows');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `daypart_restriction` SET TAGS ('dbx_defining_when_content_may_air_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `daypart_restriction` SET TAGS ('dbx_prime_time_only' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `daypart_restriction` SET TAGS ('dbx_late_night_only' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `daypart_restriction` SET TAGS ('dbx_daytime_safe)_Applies_primarily_to_linear_broadcast_and_cable_windows' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `download_to_go_enabled` SET TAGS ('dbx_business_glossary_term' = 'Download-to-Go Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `download_to_go_enabled` SET TAGS ('dbx_column_comment' = 'Indicates whether offline download capability is enabled for this window');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `download_to_go_enabled` SET TAGS ('dbx_allowing_viewers_to_download_content_for_offline_viewing_True' = 'downloads allowed');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `download_to_go_enabled` SET TAGS ('dbx_False' = 'streaming only.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `dubbing_availability` SET TAGS ('dbx_business_glossary_term' = 'Dubbing Availability');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `dubbing_availability` SET TAGS ('dbx_column_comment' = 'Indicates whether dubbed audio tracks in alternate languages are available for this window release. True=dubbing provided');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `dubbing_availability` SET TAGS ('dbx_False' = 'original language only.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `holdback_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Holdback Duration Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `holdback_duration_days` SET TAGS ('dbx_column_comment' = 'The number of days between the close of the previous window and the open of this window');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `holdback_duration_days` SET TAGS ('dbx_representing_the_exclusivity_period_or_gap_between_release_phases' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `language_version` SET TAGS ('dbx_business_glossary_term' = 'Language Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `language_version` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `language_version` SET TAGS ('dbx_column_comment' = 'ISO 639-2 or ISO 639-3 language code for the primary audio/subtitle language version to be released in this window (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `language_version` SET TAGS ('dbx_eng' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `language_version` SET TAGS ('dbx_spa' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `language_version` SET TAGS ('dbx_fra' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `language_version` SET TAGS ('dbx_deu)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `language_version` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when this windowing plan record was last updated. Audit trail for change tracking.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_column_comment' = 'The minimum guaranteed revenue amount (in base currency) that the platform has committed to pay for this window');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_regardless_of_actual_performance_Used_in_licensing_negotiations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Free-text field for additional context');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `notes` SET TAGS ('dbx_special_instructions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `notes` SET TAGS ('dbx_or_strategic_rationale_for_this_windowing_plan_Used_for_internal_communication_and_documentation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `planned_close_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Close Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `planned_close_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `planned_close_date` SET TAGS ('dbx_column_comment' = 'The intended end date when the content will no longer be available on the specified platform/channel in the specified territory. Nullable for open-ended windows.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `planned_open_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Open Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `planned_open_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `planned_open_date` SET TAGS ('dbx_column_comment' = 'The intended start date when the content becomes available on the specified platform/channel in the specified territory. Represents the editorial/commercial release plan.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `price_point` SET TAGS ('dbx_business_glossary_term' = 'Price Point');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `price_point` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `price_point` SET TAGS ('dbx_column_comment' = 'The consumer-facing price for transactional windows (TVOD');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `price_point` SET TAGS ('dbx_EST' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `price_point` SET TAGS ('dbx_PPV)_in_the_specified_currency_Represents_the_retail_price_charged_to_end_viewers' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `promotional_pricing_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Pricing Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `promotional_pricing_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `promotional_pricing_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether promotional or discounted pricing is applied for this window. True=promotional pricing active');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `promotional_pricing_flag` SET TAGS ('dbx_False' = 'standard pricing.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `revenue_model` SET TAGS ('dbx_business_glossary_term' = 'Revenue Model');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `revenue_model` SET TAGS ('dbx_value_regex' = 'subscription|advertising|transactional|hybrid|free');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `revenue_model` SET TAGS ('dbx_column_comment' = 'The monetization approach for this window. Subscription=SVOD model');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `revenue_model` SET TAGS ('dbx_Advertising' = 'AVOD model');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `revenue_model` SET TAGS ('dbx_Transactional' = 'TVOD/PPV/EST');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `revenue_model` SET TAGS ('dbx_Hybrid' = 'combination of models');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `revenue_model` SET TAGS ('dbx_Free' = 'no direct revenue.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `revenue_model` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_value_regex' = 'hls|dash|smooth_streaming|rtmp|webrtc');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_column_comment' = 'The streaming delivery protocol used for OTT windows. HLS=HTTP Live Streaming (Apple)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_DASH' = 'Dynamic Adaptive Streaming over HTTP (MPEG-DASH)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_Smooth_Streaming' = 'Microsoft');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_RTMP' = 'Real-Time Messaging Protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_WebRTC' = 'real-time communication.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `subtitle_availability` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Availability');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `subtitle_availability` SET TAGS ('dbx_column_comment' = 'Indicates whether subtitles or closed captions are available for this window release. True=subtitles provided');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `subtitle_availability` SET TAGS ('dbx_False' = 'no subtitles.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `viewing_window_hours` SET TAGS ('dbx_business_glossary_term' = 'Viewing Window Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `viewing_window_hours` SET TAGS ('dbx_column_comment' = 'For TVOD/rental windows');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `viewing_window_hours` SET TAGS ('dbx_the_number_of_hours_a_viewer_has_to_complete_watching_the_content_after_initiating_playback_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `viewing_window_hours` SET TAGS ('dbx_48_hour_rental_window)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `window_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Window Sequence Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `window_sequence_number` SET TAGS ('dbx_column_comment' = 'Sequential ordering of this window within the overall release strategy for the content. Lower numbers indicate earlier windows (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `window_sequence_number` SET TAGS ('dbx_1' = 'theatrical');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `window_sequence_number` SET TAGS ('dbx_2' = 'SVOD');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`windowing_plan` ALTER COLUMN `window_sequence_number` SET TAGS ('dbx_3' = 'AVOD).');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `artwork_id` SET TAGS ('dbx_business_glossary_term' = 'Artwork Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `artwork_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the artwork asset record. Primary key for the artwork catalog.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `version_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_content_version_Business_justification' = 'Artwork is often version-specific (theatrical poster vs TV key art');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `version_id` SET TAGS ('dbx_localized_artwork_with_different_ratings_text)_Links_artwork_to_the_specific_version_it_represents' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Holder Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_mediaasset_media_asset_Business_justification' = 'Artwork files (posters');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_thumbnails' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_key_art)_are_managed_media_assets_in_DAM_systems_Asset_lifecycle_management' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_storage_tier_assignment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_and_delivery_workflows_require_linking_artwork_records_to_the' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `title_id` SET TAGS ('dbx_column_comment' = 'Reference to the content title (series');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `title_id` SET TAGS ('dbx_film' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `title_id` SET TAGS ('dbx_episode' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `title_id` SET TAGS ('dbx_or_other_content_asset)_that_this_artwork_represents_Links_artwork_to_the_master_content_catalog' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `approval_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `approval_date` SET TAGS ('dbx_column_comment_Date_on_which_the_artwork_received_final_approval_for_distribution_and_use_Marks_the_transition_from_draft_review_to_production_ready_status_Format' = 'yyyy-MM-dd.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `approved_for_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Approved for Use Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `approved_for_use_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `approved_for_use_flag` SET TAGS ('dbx_column_comment' = 'Boolean indicator of whether the artwork has passed legal');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `approved_for_use_flag` SET TAGS ('dbx_brand' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `approved_for_use_flag` SET TAGS ('dbx_and_creative_approval_processes_and_is_authorized_for_public_distribution_True_indicates_approved_and_ready_for_use' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `approved_for_use_flag` SET TAGS ('dbx_False_indicates_pending_approval_or_rejected' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `archive_location` SET TAGS ('dbx_business_glossary_term' = 'Archive Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `archive_location` SET TAGS ('dbx_column_comment' = 'Physical or logical storage location identifier for the high-resolution master artwork file in the enterprise archive system. May reference tape library');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `archive_location` SET TAGS ('dbx_cloud_object_storage_bucket' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `archive_location` SET TAGS ('dbx_or_network_attached_storage_(NAS)_path_Supports_long_term_preservation_and_disaster_recovery' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_column_comment_Proportional_relationship_between_width_and_height_of_the_artwork_16' = '9 for widescreen HD');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_4' = '3 for standard definition');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_1' = '1 for square social media');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_2' = '3 for portrait poster');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_3' = '4 for mobile portrait');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_21' = '9 for ultra-widescreen');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_9' = '16 for vertical mobile video. [ENUM-REF-CANDIDATE: 16:9');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_4' = '3');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_1' = '1');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_2' = '3');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_3' = '4');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_21' = '9');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_9' = '16 — 7 candidates stripped; promote to reference product]');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `color_profile` SET TAGS ('dbx_business_glossary_term' = 'Color Profile');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `color_profile` SET TAGS ('dbx_value_regex' = 'sRGB|Adobe RGB|ProPhoto RGB|CMYK|Rec. 709|Rec. 2020');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `color_profile` SET TAGS ('dbx_column_comment' = 'Color space standard applied to the artwork for accurate color reproduction across devices and platforms. sRGB for web/digital');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `color_profile` SET TAGS ('dbx_Adobe_RGB_for_professional_photography' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `color_profile` SET TAGS ('dbx_CMYK_for_print' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `color_profile` SET TAGS ('dbx_Rec_709_for_HD_broadcast' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `color_profile` SET TAGS ('dbx_Rec_2020_for_Ultra_HD_(UHD)_broadcast' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `content_rating_displayed_flag` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Displayed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `content_rating_displayed_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `content_rating_displayed_flag` SET TAGS ('dbx_column_comment' = 'Boolean indicator of whether the artwork includes a visible Motion Picture Association (MPA) or equivalent content rating badge (G');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `content_rating_displayed_flag` SET TAGS ('dbx_PG' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `content_rating_displayed_flag` SET TAGS ('dbx_PG_13' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `content_rating_displayed_flag` SET TAGS ('dbx_R' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `content_rating_displayed_flag` SET TAGS ('dbx_NC_17' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `content_rating_displayed_flag` SET TAGS ('dbx_TV_Y' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `content_rating_displayed_flag` SET TAGS ('dbx_TV_PG' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `content_rating_displayed_flag` SET TAGS ('dbx_TV_14' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `content_rating_displayed_flag` SET TAGS ('dbx_TV_MA)_True_indicates_rating_is_burned_into_the_image' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `content_rating_displayed_flag` SET TAGS ('dbx_False_indicates_clean_artwork_without_rating_overlay' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `content_rating_displayed_flag` SET TAGS ('dbx_regulation' = 'Ofcom');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `copyright_year` SET TAGS ('dbx_business_glossary_term' = 'Copyright Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `copyright_year` SET TAGS ('dbx_column_comment' = 'Year in which the artwork was created and copyright was established. Used for copyright notice display and rights duration calculation.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment_Date_and_time_when_the_artwork_record_was_first_created_in_the_enterprise_catalog_system_Format' = 'yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and data lineage tracking.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `eidr` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `eidr` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `eidr` SET TAGS ('dbx_standard_identifier' = 'EIDR');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `eidr` SET TAGS ('dbx_first_class' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `eidr` SET TAGS ('dbx_regex' = '^10.5240/...');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `eidr` SET TAGS ('dbx_column_comment' = 'Universal unique identifier from the Entertainment Identifier Registry for the associated content title. Enables global interoperability and metadata exchange across distribution partners');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `eidr` SET TAGS ('dbx_rights_holders' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `eidr` SET TAGS ('dbx_and_platforms' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `eidr` SET TAGS ('dbx_validation_regex' = '^10.5240/[0-9A-F-]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `eidr` SET TAGS ('dbx_standard' = 'EIDR');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `eidr` SET TAGS ('dbx_regex_validation' = '^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `expiry_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `expiry_date` SET TAGS ('dbx_column_comment_Date_on_which_the_artwork_rights_or_usage_authorization_expires_and_the_asset_should_no_longer_be_used_for_promotional_or_distribution_purposes_Supports_rights_management_and_holdback_compliance_Nullable_for_perpetual_use_artwork_Format' = 'yyyy-MM-dd.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_column_comment' = 'Storage size of the artwork file measured in bytes. Used for Content Delivery Network (CDN) optimization');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_bandwidth_planning' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_and_storage_capacity_management' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `height_pixels` SET TAGS ('dbx_business_glossary_term' = 'Height in Pixels');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `height_pixels` SET TAGS ('dbx_column_comment' = 'Vertical dimension of the artwork image measured in pixels. Used to determine display suitability and resolution quality for various distribution channels.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `language_overlay_flag` SET TAGS ('dbx_business_glossary_term' = 'Language Overlay Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `language_overlay_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `language_overlay_flag` SET TAGS ('dbx_column_comment' = 'Boolean indicator of whether the artwork contains burned-in text');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `language_overlay_flag` SET TAGS ('dbx_titles' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `language_overlay_flag` SET TAGS ('dbx_or_language_specific_graphic_elements_True_indicates_localized_artwork_requiring_territory_specific_versions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `language_overlay_flag` SET TAGS ('dbx_False_indicates_language_neutral_artwork_suitable_for_all_markets' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `language_overlay_flag` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_column_comment_Date_and_time_when_the_artwork_record_was_last_updated_or_modified_in_the_enterprise_catalog_system_Format' = 'yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for change tracking and synchronization workflows.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `photographer_credit` SET TAGS ('dbx_business_glossary_term' = 'Photographer Credit');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `photographer_credit` SET TAGS ('dbx_column_comment' = 'Name or attribution of the photographer');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `photographer_credit` SET TAGS ('dbx_artist' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `photographer_credit` SET TAGS ('dbx_or_creative_agency_responsible_for_creating_the_artwork_Used_for_copyright_attribution' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `photographer_credit` SET TAGS ('dbx_residuals_tracking' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `photographer_credit` SET TAGS ('dbx_and_legal_compliance_with_talent_agreements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `priority_rank` SET TAGS ('dbx_column_comment' = 'Numeric ranking indicating the preferred display order or priority of this artwork when multiple artwork assets exist for the same title and type. Lower numbers indicate higher priority. Used by Electronic Program Guide (EPG) and streaming platform UI to select the primary artwork.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `resolution_dpi` SET TAGS ('dbx_business_glossary_term' = 'Resolution in Dots Per Inch (DPI)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `resolution_dpi` SET TAGS ('dbx_column_comment' = 'Image resolution measured in dots per inch. 72 DPI for web/screen display');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `resolution_dpi` SET TAGS ('dbx_300_DPI_for_high_quality_print' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `resolution_dpi` SET TAGS ('dbx_150_DPI_for_standard_print_Critical_for_determining_print_suitability_and_image_quality' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Artwork Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `title` SET TAGS ('dbx_column_comment' = 'Human-readable descriptive title or label for the artwork asset. Used for internal cataloging and search within the Media Asset Management (MAM) system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `title` SET TAGS ('dbx_metadata_standard' = 'EBUCore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `title` SET TAGS ('dbx_DublinCore' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `title` SET TAGS ('dbx_TVAnytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `width_pixels` SET TAGS ('dbx_business_glossary_term' = 'Width in Pixels');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`artwork` ALTER COLUMN `width_pixels` SET TAGS ('dbx_column_comment' = 'Horizontal dimension of the artwork image measured in pixels. Used to determine display suitability and resolution quality for various distribution channels.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` SET TAGS ('dbx_subdomain' = 'rights_distribution');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_id` SET TAGS ('dbx_column_comment' = 'Primary key for package');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_id` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `genre_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_content_genre_Business_justification' = 'Packages have primary genre classification. Normalizes genre_primary string column to reference the enterprise genre taxonomy.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `genre_id` SET TAGS ('dbx_metadata_standard' = 'EBUCore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `genre_id` SET TAGS ('dbx_DublinCore' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `genre_id` SET TAGS ('dbx_TVAnytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Holder Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_rights_license_agreement_Business_justification' = 'Content packages (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_'Summer_Action_Bundle'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_'Kids_Library')_are_licensed_as_units_to_distributors_Package_level_royalty_calculations_and_clearance_workflows_require_linking_packages_to_their_gove' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_distribution_ott_platform_Business_justification' = 'Content packages (bundles');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_collections)_are_licensed_to_specific_platforms_Package_level_deals_are_common_in_SVOD_(entire_studio_catalog_to_Netflix)_and_require_platform_specific_availability_trackin' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `partner_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_distribution_distribution_partner_Business_justification' = 'Packages are sold to distribution partners (cable operators');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `partner_id` SET TAGS ('dbx_MVPD_aggregators' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `partner_id` SET TAGS ('dbx_international_distributors)_Package_level_licensing_agreements_and_carriage_fees_are_negotiated_at_partner_level_for_bul' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `audio_description_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `audio_description_available_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `audio_description_available_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether audio description tracks are available for the majority of content in the package (True/False). Required for accessibility compliance.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `audio_description_available_flag` SET TAGS ('dbx_regulation' = 'EBU R128');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `closed_caption_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `closed_caption_available_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `closed_caption_available_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether closed captioning is available for the majority of content in the package (True/False). Required for FCC compliance and accessibility standards.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `closed_caption_available_flag` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `commercial_context` SET TAGS ('dbx_business_glossary_term' = 'Commercial Context');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `commercial_context` SET TAGS ('dbx_column_comment' = 'Free-text description of the business purpose or deal context for which the package was assembled');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `commercial_context` SET TAGS ('dbx_such_as_upfront_sales_event' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `commercial_context` SET TAGS ('dbx_scatter_market_offering' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `commercial_context` SET TAGS ('dbx_MVPD_(Multichannel_Video_Programming_Distributor)_carriage_negotiation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `commercial_context` SET TAGS ('dbx_or_international_syndication_deal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'The date and time when the package record was first created in the system. Used for audit trail and data lineage.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_description` SET TAGS ('dbx_business_glossary_term' = 'Package Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_description` SET TAGS ('dbx_column_comment' = 'A detailed narrative description of the package content');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_description` SET TAGS ('dbx_target_audience' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_description` SET TAGS ('dbx_and_commercial_positioning_Used_for_marketing' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_description` SET TAGS ('dbx_sales_proposals' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_description` SET TAGS ('dbx_and_catalog_listings' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_description` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `drm_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `drm_required_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `drm_required_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether Digital Rights Management (DRM) protection is required for distribution of this package (True/False). Critical for rights enforcement and anti-piracy compliance.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `effective_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `effective_date` SET TAGS ('dbx_column_comment' = 'The date from which the package becomes available for distribution or licensing. Marks the start of the packages commercial availability window.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the package is offered on an exclusive basis to a single distributor or platform (True) or is available for non-exclusive multi-platform distribution (False). Critical for rights and holdback management.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `expiry_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `expiry_date` SET TAGS ('dbx_column_comment' = 'The date on which the package ceases to be available for distribution or licensing. Nullable for open-ended packages. Defines the end of the windowing or holdback period.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `hd_available_flag` SET TAGS ('dbx_business_glossary_term' = 'High Definition (HD) Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `hd_available_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `hd_available_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the package content is available in high-definition (HD) format (True/False). Used for distribution planning and quality assurance.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `keywords` SET TAGS ('dbx_column_comment' = 'Comma-separated list of keywords or tags associated with the package for search');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `keywords` SET TAGS ('dbx_discovery' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `keywords` SET TAGS ('dbx_and_recommendation_purposes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `keywords` SET TAGS ('dbx_metadata_standard' = 'EBUCore');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `keywords` SET TAGS ('dbx_DublinCore' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `keywords` SET TAGS ('dbx_TVAnytime' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `language_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `language_primary` SET TAGS ('dbx_column_comment' = 'The primary language of the content in the package');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `language_primary` SET TAGS ('dbx_expressed_as_ISO_639_2_three_letter_language_code_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `language_primary` SET TAGS ('dbx_eng' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `language_primary` SET TAGS ('dbx_spa' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `language_primary` SET TAGS ('dbx_fra)_Critical_for_localization_and_international_distribution' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `language_primary` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `modified_by` SET TAGS ('dbx_column_comment' = 'The username or identifier of the user or system that last modified the package record. Used for change accountability and audit trail.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_column_comment' = 'The date and time when the package record was last modified. Used for change tracking and audit compliance.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_name` SET TAGS ('dbx_business_glossary_term' = 'Package Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_name` SET TAGS ('dbx_column_comment' = 'The business name or title of the content package as recognized in commercial agreements and distribution deals.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `package_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `thumbnail_url` SET TAGS ('dbx_business_glossary_term' = 'Thumbnail Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `thumbnail_url` SET TAGS ('dbx_column_comment' = 'The URL or path to the thumbnail image representing the package in catalogs');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `thumbnail_url` SET TAGS ('dbx_EPG_(Electronic_Program_Guide)_listings' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `thumbnail_url` SET TAGS ('dbx_and_user_interfaces' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `total_runtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Runtime Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `total_runtime_hours` SET TAGS ('dbx_column_comment' = 'The aggregate runtime of all content in the package');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `total_runtime_hours` SET TAGS ('dbx_expressed_in_hours_Used_for_programming_and_scheduling_calculations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `uhd_4k_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Ultra High Definition (UHD) 4K Available Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `uhd_4k_available_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `uhd_4k_available_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the package content is available in ultra-high-definition 4K format (True/False). Used for premium distribution and OTT platform requirements.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `value_usd` SET TAGS ('dbx_business_glossary_term' = 'Package Value United States Dollars (USD)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `value_usd` SET TAGS ('dbx_column_comment' = 'The estimated or contracted commercial value of the package in United States Dollars (USD). Used for revenue forecasting');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `value_usd` SET TAGS ('dbx_deal_valuation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`package` ALTER COLUMN `value_usd` SET TAGS ('dbx_and_financial_reporting' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` SET TAGS ('dbx_subdomain' = 'rights_distribution');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `title_rights_grant_id` SET TAGS ('dbx_business_glossary_term' = 'Title Rights Grant Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `title_rights_grant_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for this title-grant association record. Primary key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Title Rights Grant - Rights Grant Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `grant_id` SET TAGS ('dbx_column_comment' = 'Foreign key linking to the rights grant bundle being applied to this title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Holder Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Rights Grant - Title Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `title_id` SET TAGS ('dbx_column_comment' = 'Foreign key linking to the content title receiving rights under this grant');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this title-grant association was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `grant_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Grant Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `grant_effective_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `grant_effective_date` SET TAGS ('dbx_column_comment' = 'The date on which this specific title became available under this rights grant. May differ from the grants overall start date if titles are added to an existing grant.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `grant_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Grant Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `grant_expiry_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `grant_expiry_date` SET TAGS ('dbx_column_comment' = 'The date on which rights for this specific title expire under this grant. May differ from the grants overall end date if titles have different term lengths.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this title-grant association was last modified.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `run_limit` SET TAGS ('dbx_business_glossary_term' = 'Run Limit');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `run_limit` SET TAGS ('dbx_column_comment_Maximum_number_of_times_the_content_may_be_broadcast_or_streamed_under_this_grant_Nullable_if_unlimited_runs_are_permitted_[Moved_from_rights_grant' = 'Run limits are often title-specific within a grant (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `run_limit` SET TAGS ('dbx_a_catalog_grant_may_allow_10_runs_for_blockbuster_titles_but_unlimited_runs_for_library_content)_This_should_move_to_runs_allocated_in_the_association_]' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `runs_allocated` SET TAGS ('dbx_business_glossary_term' = 'Runs Allocated');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `runs_allocated` SET TAGS ('dbx_column_comment' = 'Number of broadcast or streaming runs allocated for this specific title under this grant. Titles within the same grant may have different run limits.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `runs_consumed` SET TAGS ('dbx_business_glossary_term' = 'Runs Consumed');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `runs_consumed` SET TAGS ('dbx_column_comment' = 'Number of runs already consumed for this specific title under this grant. Tracked at the title level for availability enforcement.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `runs_used` SET TAGS ('dbx_business_glossary_term' = 'Runs Used');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `runs_used` SET TAGS ('dbx_column_comment_Number_of_runs_already_consumed_against_the_run_limit_Used_for_availability_tracking_and_compliance_[Moved_from_rights_grant' = 'Run consumption must be tracked per title-grant combination');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `runs_used` SET TAGS ('dbx_not_at_the_grant_level_A_grant_covering_100_titles_needs_separate_run_tracking_for_each_title_This_becomes_runs_consumed_in_the_association_]' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_rights_grant` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `rating_id` SET TAGS ('dbx_column_comment' = 'Surrogate key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `rating_id` SET TAGS ('dbx_regulation' = 'Ofcom');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `active_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `active_flag` SET TAGS ('dbx_column_comment' = 'Whether the value is active.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `content_rating_code` SET TAGS ('dbx_column_comment' = 'Stable enum code.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `content_rating_description` SET TAGS ('dbx_column_comment' = 'Long description.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `label` SET TAGS ('dbx_column_comment' = 'Human-readable label.');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`rating` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_inclusion` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_inclusion` SET TAGS ('dbx_subdomain' = 'rights_distribution');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_inclusion` SET TAGS ('dbx_association_edges' = 'content.package,content.title');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_inclusion` ALTER COLUMN `title_inclusion_id` SET TAGS ('dbx_business_glossary_term' = 'Title Inclusion - Title Inclusion Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_inclusion` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Title Inclusion - Package Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_inclusion` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Inclusion - Title Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_inclusion` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Title Inclusion Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_inclusion` ALTER COLUMN `inclusion_date` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_inclusion` ALTER COLUMN `rights_window_end` SET TAGS ('dbx_business_glossary_term' = 'Rights Window End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_inclusion` ALTER COLUMN `rights_window_start` SET TAGS ('dbx_business_glossary_term' = 'Rights Window Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_inclusion` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Title Sequence Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_inclusion` ALTER COLUMN `total_title_count` SET TAGS ('dbx_business_glossary_term' = 'Total Title Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_inclusion` ALTER COLUMN `total_title_count` SET TAGS ('dbx_fact_metric' = 'monetary');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_inclusion` ALTER COLUMN `total_title_count` SET TAGS ('dbx_column_comment' = 'The total number of distinct titles (episodes');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_inclusion` ALTER COLUMN `total_title_count` SET TAGS ('dbx_films' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_inclusion` ALTER COLUMN `total_title_count` SET TAGS ('dbx_clips' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`content`.`title_inclusion` ALTER COLUMN `total_title_count` SET TAGS ('dbx_or_other_content_assets)_included_in_the_package_Used_for_inventory_reporting_and_deal_valuation' = 'true');
