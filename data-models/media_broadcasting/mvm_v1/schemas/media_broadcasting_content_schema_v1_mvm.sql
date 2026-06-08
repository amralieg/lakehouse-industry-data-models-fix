-- Schema for Domain: content | Business: Media Broadcasting | Version: v1_mvm
-- Generated on: 2026-05-08 19:23:32

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `media_broadcasting_ecm`.`content` COMMENT 'Single source of truth for all content assets across the enterprise — covering titles, episodes, series, films, clips, music, news segments, and live events. Manages content metadata (EIDR, ISAN, ISRC identifiers), format specifications, versioning, localization, MPA ratings, genre classification, and content lifecycle from acquisition through archival. Serves as the master catalog referenced by scheduling, distribution, rights, and digital asset domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`content`.`title` (
    `title_id` BIGINT COMMENT 'Unique identifier for the content title. Primary key for the title master catalog. Serves as the universal join point referenced by scheduling, distribution, rights, digital asset, and advertising domains.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Titles are assigned to cost centers for production cost allocation and departmental P&L. Standard media finance practice for tracking title-level spend against approved budgets. title.studio_name is a',
    `distribution_partner_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_partner. Business justification: Title.distributor_name is a denormalized string. Normalizing to distribution_partner_id enables distribution partner reporting, revenue allocation by partner, and rights clearance validation — fundame',
    `genre_id` BIGINT COMMENT 'FK to content.genre',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Titles are owned/produced by specific legal entities — critical for intercompany accounting, tax reporting, and rights ownership documentation. Media broadcasters with multiple subsidiaries must attri',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Every titles distribution rights are governed by license agreements. Broadcast scheduling, windowing decisions, and royalty calculations require knowing which agreement controls each titles exploita',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Standalone films, documentaries, and short-form titles require a direct link to their master media asset for QC sign-off, rights clearance readiness, and distribution packaging. Every other content le',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Content titles are frequently the subject of licensing, syndication, and sponsorship opportunities. Sales teams track which titles are being pitched in each deal. Real business process: content licens',
    `holder_id` BIGINT COMMENT 'Foreign key linking to rights.rights_holder. Business justification: Tracks who owns/controls rights to each title - essential for royalty payments, clearance workflows, and determining who must approve licensing deals. Rights holder is the starting point for all right',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Titles are attributed to profit centers for title-level P&L and content investment ROI reporting. Standard media finance practice — each title is assigned to a profit center (e.g., streaming, theatric',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Title-level revenue stream assignment is required for ASC 606/IFRS 15 performance obligation mapping. Finance teams map each title to its primary revenue stream (TVOD, SVOD, theatrical) for revenue re',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Titles have primary production/distribution territories that affect rights clearance, regulatory compliance (content ratings), and default licensing assumptions. Clearance workflows validate against t',
    `series_id` BIGINT COMMENT 'Foreign key reference to the parent series for episodic content. Null for standalone films, clips, and non-episodic content.',
    `acquisition_date` DATE COMMENT 'Date when the content rights were acquired by the organization. Used for rights lifecycle tracking, amortization calculations, and contract management.',
    `archive_date` DATE COMMENT 'Date when the content was moved to archived status. Used for content lifecycle management and digital asset retention policies.',
    `aspect_ratio` STRING COMMENT 'Display aspect ratio of the content. Determines presentation format for broadcast, streaming, and theatrical distribution.. Valid values are `4:3|16:9|21:9|1.85:1|2.39:1`',
    `audio_description_available_flag` BOOLEAN COMMENT 'Indicates whether audio description track is available for visually impaired audiences. Required for accessibility compliance and inclusive broadcasting.',
    `closed_caption_available_flag` BOOLEAN COMMENT 'Indicates whether closed captioning is available for the content. Required for FCC compliance and accessibility standards.',
    `color_format` STRING COMMENT 'Indicates whether the content is in color, black and white, or has been colorized. Used for archival classification and presentation metadata.. Valid values are `color|black_and_white|colorized`',
    `content_rating` STRING COMMENT 'Official content rating assigned by the Motion Picture Association or television rating authority. Determines audience suitability, broadcast restrictions, and parental control settings. [ENUM-REF-CANDIDATE: G|PG|PG-13|R|NC-17|TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA|NR — 12 candidates stripped; promote to reference product]',
    `content_status` STRING COMMENT 'Current lifecycle status of the content asset. Determines availability for scheduling, distribution, and monetization. Active content is available for use; archived content is retained but not actively distributed; restricted content has legal or rights limitations.. Valid values are `active|archived|restricted|pending|expired|withdrawn`',
    `content_type` STRING COMMENT 'Discriminator classifying the fundamental type of content asset. Determines applicable business rules for scheduling, rights windowing, and distribution strategies. [ENUM-REF-CANDIDATE: film|series|episode|clip|music|news|live_event|documentary — 8 candidates stripped; promote to reference product]',
    `coppa_child_directed_flag` BOOLEAN COMMENT 'Indicates whether the content is directed to children under 13 years of age. Triggers COPPA compliance requirements for data collection, advertising restrictions, and privacy protections.',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 code representing the country where the content was originally produced. Used for rights management, regulatory compliance, and content origin reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the title record was first created in the system. Used for audit trails, data lineage tracking, and operational reporting.',
    `eidr_code` STRING COMMENT 'Universal unique identifier for audiovisual content assigned by the Entertainment Identifier Registry. Used for global content identification and rights management across the media supply chain.. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `episode_number` STRING COMMENT 'Episode number within the season for episodic content. Null for non-episodic content. Used for sequential ordering in playout and Electronic Program Guide (EPG) systems.',
    `hd_available_flag` BOOLEAN COMMENT 'Indicates whether a high-definition version of the content is available. Used for channel playout decisions and quality-tier distribution strategies.',
    `isan` STRING COMMENT 'International standard identifier for audiovisual works. Primarily used for films and television programs for rights management and distribution tracking.. Valid values are `^ISAN [A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `isrc` STRING COMMENT 'International standard code for uniquely identifying sound recordings and music video recordings. Used for music tracks and audio content royalty tracking.. Valid values are `^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$`',
    `keywords` STRING COMMENT 'Comma-separated list of keywords and tags describing content themes, subjects, and topics. Used for search optimization, content discovery, and recommendation algorithms.',
    `original_language` STRING COMMENT 'ISO 639-2 three-letter code representing the original language of the content production. Used for localization planning, dubbing, and subtitle workflows.. Valid values are `^[A-Z]{3}$`',
    `original_title` STRING COMMENT 'Original title name in the native language of production. Preserved for rights management, archival, and international distribution purposes.',
    `parental_advisory_flag` BOOLEAN COMMENT 'Indicates whether the content carries a parental advisory warning for explicit content, violence, or mature themes. Used for compliance with broadcast standards and platform content policies.',
    `premiere_flag` BOOLEAN COMMENT 'Indicates whether the content is a premiere or first-run broadcast. Used for promotional scheduling, advertising premium pricing, and audience measurement reporting.',
    `production_year` STRING COMMENT 'Calendar year in which the content was originally produced or completed. Used for catalog organization, rights windowing calculations, and archival classification.',
    `release_date` DATE COMMENT 'Date when the content was first released to the public or premiered. Used for rights availability calculations, windowing strategies, and anniversary programming.',
    `rights_status` STRING COMMENT 'Current rights availability status indicating whether the content can be legally broadcast or distributed. Drives scheduling decisions and geographic blackout enforcement.. Valid values are `available|restricted|expired|pending_clearance|blackout`',
    `runtime_seconds` STRING COMMENT 'Total duration of the content in seconds. Used for program scheduling, ad pod allocation, playout automation, and Electronic Program Guide (EPG) generation.',
    `season_number` STRING COMMENT 'Season number within the parent series for episodic content. Null for non-episodic content. Used for catalog organization and Electronic Program Guide (EPG) display.',
    `sub_genre` STRING COMMENT 'Secondary or more granular genre classification providing additional content categorization for advanced audience segmentation and personalization.',
    `synopsis_long` STRING COMMENT 'Detailed narrative description of the content. Used for promotional materials, streaming platform detail pages, and comprehensive program guides.',
    `synopsis_short` STRING COMMENT 'Brief summary of the content, typically 50-100 characters. Used for Electronic Program Guide (EPG) listings, mobile applications, and quick reference displays.',
    `theatrical_release_flag` BOOLEAN COMMENT 'Indicates whether the content had a theatrical release. Used for windowing strategy, rights holdback periods, and marketing classification.',
    `title_name` STRING COMMENT 'Primary display name of the content title. The human-readable identifier used across all systems and customer-facing platforms.',
    `uhd_4k_available_flag` BOOLEAN COMMENT 'Indicates whether an Ultra HD 4K version of the content is available. Used for premium streaming tiers and next-generation broadcast services.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the title record was last modified. Used for change tracking, data synchronization, and audit compliance.',
    CONSTRAINT pk_title PRIMARY KEY(`title_id`)
) COMMENT 'Master catalog record for every content asset across the enterprise — films, series, episodes, clips, music tracks, news segments, and live events. Serves as the authoritative SSOT for content identity, carrying EIDR, ISAN, and ISRC identifiers, MPA content rating, genre classification, original language, country of origin, production year, content type discriminator (film/series/episode/clip/music/news/live), runtime in seconds, content status (active/archived/restricted), parental advisory flags, COPPA child-directed flag, and lifecycle timestamps. Acts as the universal join point referenced by scheduling, distribution, rights, digital asset, and advertising domains. Format-level technical specifications are managed by the version and digital asset domains.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`content`.`series` (
    `series_id` BIGINT COMMENT 'Unique identifier for the series. Primary key for the series master record.',
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.rating. Business justification: Series have content ratings. Normalizes content_rating string column to reference the enterprise rating taxonomy.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Series-level cost center assignment supports ongoing franchise operational cost tracking (development, marketing, distribution) independent of any single seasons production budget. Media finance team',
    `genre_id` BIGINT COMMENT 'Foreign key linking to content.genre. Business justification: Series have genre classification. Normalizes genre_primary/genre_secondary string columns to reference the enterprise genre taxonomy.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Series are produced under specific legal entities for intercompany accounting and franchise rights ownership. series.production_company is a denormalized plain attribute replaced by this FK. Required ',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Series are commissioned by or associated with a primary originating channel (original_network is plain text on series). Linking to channel.channel_id enables channel-level content library reports, acq',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Series-level distribution partner is essential for co-production tracking, distribution rights management, and partner performance analytics. The distributor plain-string attribute is a denormalizatio',
    `holder_id` BIGINT COMMENT 'Foreign key linking to rights.rights_holder. Business justification: Series-level rights ownership (studio/production company) drives all downstream licensing and royalty flows. Franchise management and multi-season deal negotiations require knowing the primary rights ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Series are assigned to profit centers for franchise-level segment revenue reporting. Distinct from cost_center — profit centers track revenue-generating segments. Required for management reporting on ',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Series-level revenue stream assignment supports franchise P&L reporting and content investment ROI analysis. Finance teams track SVOD/AVOD/syndication revenue by series for greenlight decisions. No ex',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: Series have territory-scoped rights governing syndication and distribution. Series-level territory rights management is required for franchise-wide distribution planning and rights clearance. No exist',
    `archive_location` STRING COMMENT 'Physical or logical location identifier where the series master content and metadata are archived. Used for Digital Asset Management (DAM) and Media Asset Management (MAM) retrieval.',
    `aspect_ratio` STRING COMMENT 'Standard aspect ratio for the series video format. Critical for playout configuration, transcoding workflows, and multi-platform distribution.. Valid values are `16:9|4:3|21:9|2.39:1|1.85:1`',
    `audio_description_available` BOOLEAN COMMENT 'Indicates whether audio description track is available for visually impaired viewers. Required for accessibility compliance in many jurisdictions.',
    `audio_format` STRING COMMENT 'Standard audio format and channel configuration for the series. Determines audio encoding requirements for distribution and playout.. Valid values are `stereo|surround_5_1|surround_7_1|dolby_atmos|dts_x`',
    `closed_caption_available` BOOLEAN COMMENT 'Indicates whether closed captioning is available for the series. Required for regulatory compliance under FCC accessibility rules and international broadcasting standards.',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country where the series was originally produced. Used for content quotas, regulatory compliance, and international rights management.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the series record was first created in the system. Used for audit trail and data lineage tracking.',
    `eidr_code` STRING COMMENT 'Universal unique identifier for the series registered with EIDR. Enables global content identification and rights management across the entertainment industry supply chain.. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `episode_runtime_minutes` STRING COMMENT 'Standard runtime duration in minutes for a typical episode of the series, excluding commercials. Used for scheduling, ad pod planning, and playout automation.',
    `finale_date` DATE COMMENT 'Date when the final episode of the series aired or was released. Null for ongoing series. Used for syndication eligibility and rights holdback period calculations.',
    `franchise_name` STRING COMMENT 'Brand name of the content franchise or show brand. Used for grouping related series, spin-offs, and reboots under a common brand umbrella.',
    `hdr_format` STRING COMMENT 'High Dynamic Range format specification for the series. Impacts content delivery network configuration and device compatibility.. Valid values are `SDR|HDR10|HDR10_PLUS|DOLBY_VISION|HLG`',
    `isan_code` STRING COMMENT 'International standard audiovisual number for the series. Used for audiovisual work identification in rights management and distribution.. Valid values are `^ISAN [A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `keywords` STRING COMMENT 'Comma-separated list of searchable keywords and tags for content discovery, Electronic Program Guide (EPG) search, and recommendation engine optimization.',
    `language_original` STRING COMMENT 'ISO 639-3 three-letter code for the original production language of the series. Used for localization planning and international distribution.. Valid values are `^[a-z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the series record was last modified. Used for change tracking, audit compliance, and data synchronization across systems.',
    `original_network` STRING COMMENT 'Name of the original broadcast network or streaming platform that first aired or released the series. Critical for rights management and syndication deals.',
    `premiere_date` DATE COMMENT 'Date when the first episode of the series originally aired or was released. Marks the beginning of the series lifecycle and is used for rights windowing calculations.',
    `resolution_standard` STRING COMMENT 'Standard video resolution for the series master content. Determines transcoding requirements and Adaptive Bitrate (ABR) streaming profile generation.. Valid values are `SD|HD|FHD|UHD|4K|8K`',
    `series_status` STRING COMMENT 'Current lifecycle status of the series. Indicates whether the series is actively producing new content, has concluded, or is temporarily paused.. Valid values are `ongoing|ended|cancelled|hiatus|in_development|pre_production`',
    `series_type` STRING COMMENT 'Classification of the series format and production style. Determines scheduling strategy, audience targeting, and production workflow. [ENUM-REF-CANDIDATE: scripted|unscripted|documentary|news|sports|reality|talk_show|game_show|variety|animated|miniseries|anthology — 12 candidates stripped; promote to reference product]',
    `syndication_eligible` BOOLEAN COMMENT 'Indicates whether the series meets the minimum episode threshold and rights clearance requirements for syndication to secondary markets and broadcast stations.',
    `synopsis_long` STRING COMMENT 'Detailed multi-paragraph description of the series premise, themes, and narrative arc. Used for marketing materials, press releases, and content catalogs.',
    `synopsis_short` STRING COMMENT 'Brief one-sentence description of the series premise. Used for Electronic Program Guide (EPG) listings, mobile applications, and social media promotion.',
    `target_demographic` STRING COMMENT 'Primary audience demographic segment the series is designed to reach. Used for advertising sales, scheduling strategy, and Target Rating Point (TRP) calculations. [ENUM-REF-CANDIDATE: adults_18_49|adults_25_54|adults_18_34|children_2_11|teens_12_17|women_18_49|men_18_49|total_viewers — promote to reference product]',
    `title` STRING COMMENT 'Official title of the series as registered and marketed. Primary human-readable identifier for the content franchise.',
    `title_original` STRING COMMENT 'Original title of the series in its native language and market before localization or translation.',
    `total_episode_count` STRING COMMENT 'Cumulative count of all episodes produced across all seasons. Includes specials and pilot episodes.',
    `total_season_count` STRING COMMENT 'Total number of seasons produced for the series to date. Updated as new seasons are commissioned and produced.',
    CONSTRAINT pk_series PRIMARY KEY(`series_id`)
) COMMENT 'Master record for a serialized content franchise or show brand — the parent container above seasons and episodes. Captures series title, franchise identifier, series type (scripted/unscripted/documentary/news/sports/reality), total season count, original network/platform, premiere date, finale date, series status (ongoing/ended/cancelled/hiatus), genre taxonomy, target demographic, content rating band, and brand metadata. Enables hierarchical content navigation from series → season → episode and supports scheduling, rights windowing, and syndication deal structures.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`content`.`season` (
    `season_id` BIGINT COMMENT 'Unique identifier for the season record. Primary key.',
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.rating. Business justification: Seasons have content ratings. Normalizes content_rating string column to reference the enterprise rating taxonomy.',
    `genre_id` BIGINT COMMENT 'Foreign key linking to content.genre. Business justification: Seasons have genre classification. Normalizes genre_primary/genre_secondary string columns to reference the enterprise genre taxonomy.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: Seasons are exploited under specific rights grants authorizing distribution windows. Royalty calculation and exploitation reporting at season level require the governing grant. Season has rights_holde',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Seasons are produced under specific legal entities for tax, rights, and intercompany accounting. season.production_company and season.rights_holder are denormalized plain attributes replaced by this F',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Season-specific licensing (e.g., Season 1 to Netflix, Season 2 to Hulu) is common in streaming. Clearance and windowing decisions require knowing which agreement controls each seasons distribution ri',
    `media_asset_id` BIGINT COMMENT 'Reference to the season trailer asset in the MAM system. Used for promotional campaigns and platform previews.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Season-level distribution partner tracking is required for windowing rights management and per-season deal compliance reporting. The distributor plain-string attribute is a denormalized representation',
    `production_budget_id` BIGINT COMMENT 'Foreign key linking to finance.production_budget. Business justification: Seasons often have dedicated budgets separate from series-level allocations. Network finance teams approve and monitor season budgets independently for greenlight decisions, mid-season adjustments, an',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Season-level profit center assignment supports season-by-season segment revenue reporting. Media companies report individual season profitability for renewal decisions and investor reporting. Distinct',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Seasons generate revenue independently through licensing, SVOD, and AVOD deals. Season-level revenue stream assignment supports season-by-season P&L reporting — e.g., Season 3 SVOD licensing revenue t',
    `royalty_rule_id` BIGINT COMMENT 'Foreign key linking to rights.royalty_rule. Business justification: Per-season royalty rules govern payment calculations for season-level license deals (e.g., per-episode fee structures). Royalty statement generation requires linking seasons to their applicable royalt',
    `series_id` BIGINT COMMENT 'Reference to the parent series to which this season belongs.',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: A season is a distinct content asset that should reference the master title catalog record. The season table currently stores a denormalized title STRING column; adding title_id FK to content.title.',
    `archive_date` DATE COMMENT 'Date when the season was moved to archival storage. Used for asset lifecycle management and retrieval planning.',
    `archive_location` STRING COMMENT 'Physical or digital archive location where the seasons master assets are stored. Critical for long-term preservation and retrieval.',
    `awards_nominated` STRING COMMENT 'Comma-separated list of major award nominations received by the season. Supports promotional messaging and content valuation.',
    `awards_won` STRING COMMENT 'Comma-separated list of major awards won by the season (e.g., Emmy, Golden Globe). Used for marketing and promotional value enhancement.',
    `banner_artwork_url` STRING COMMENT 'URL reference to the seasons banner or hero image for wide-format displays on streaming platforms and websites.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the season record was first created in the system. Used for audit trail and data lineage.',
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
    `production_year` STRING COMMENT 'Calendar year in which the season was produced. Used for cataloging, rights management, and archival purposes.',
    `rights_expiry_date` DATE COMMENT 'Date when current distribution rights for the season expire. Triggers rights renewal workflows and availability restrictions.',
    `rights_territory` STRING COMMENT 'Geographic territories where distribution rights are held, using ISO 3166-1 alpha-3 country codes or regional groupings. Critical for windowing and blackout enforcement.',
    `season_number` STRING COMMENT 'Sequential number of the season within the series (e.g., 1 for Season 1, 2 for Season 2). Used for ordering and identification.',
    `season_status` STRING COMMENT 'Current lifecycle status of the season. Tracks progression from development through archival or cancellation. [ENUM-REF-CANDIDATE: in-development|in-production|post-production|completed|airing|aired|archived|cancelled — 8 candidates stripped; promote to reference product]',
    `synopsis_long` STRING COMMENT 'Detailed season-level synopsis providing comprehensive narrative overview. Used for promotional materials, VOD platforms, and press releases.',
    `synopsis_short` STRING COMMENT 'Brief season-level synopsis (typically 50-150 characters) used for Electronic Program Guide (EPG) listings and mobile displays.',
    `total_runtime_minutes` STRING COMMENT 'Cumulative runtime of all episodes in the season, measured in minutes. Used for scheduling blocks and VOD packaging.',
    CONSTRAINT pk_season PRIMARY KEY(`season_id`)
) COMMENT 'Master record representing a discrete production cycle of a series, grouping episodes into an ordered season. Tracks season number, season title, episode count (ordered and total), production year, original air year, season status (in-production/completed/archived), season-level content rating, season-level synopsis, and promotional artwork references. Bridges the series-to-episode hierarchy and supports season-level rights licensing, scheduling blocks, and VOD packaging.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`content`.`content_episode` (
    `content_episode_id` BIGINT COMMENT 'Unique identifier for the episode within the content management system. Primary key for the content episode entity.',
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.rating. Business justification: Episodes have content ratings (TV-PG, TV-MA). Normalizes content_rating string column to reference the enterprise rating taxonomy.',
    `season_id` BIGINT COMMENT 'Reference to the specific season within the series to which this episode belongs. Enables season-level grouping and rights management.',
    `series_id` BIGINT COMMENT 'Reference to the parent series to which this episode belongs. Links episode to its series container.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Episode-level cost center assignment tracks per-episode production costs beyond the aggregate production_budget. Standard in TV production finance for tracking individual episode overages and cost var',
    `genre_id` BIGINT COMMENT 'Foreign key linking to content.genre. Business justification: Episodes have genre classification. Normalizes genre_primary/genre_secondary string columns to reference the enterprise genre taxonomy.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: Episodes are exploited under specific rights grants; residuals calculation and exploitation reporting require the governing grant per episode. Episode-level grant tracking is essential for guild repor',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Episode-level syndication deals (especially for high-value episodes like finales or specials) require direct linkage to license agreements for run-count tracking and residual calculations.',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Broadcast playout and VOD distribution require direct lookup of the master media asset file for each episode. Traffic systems and playout automation depend on episode-to-asset mapping for scheduling a',
    `production_budget_id` BIGINT COMMENT 'Foreign key linking to finance.production_budget. Business justification: High-cost episodes (pilots, finales, VFX-heavy episodes) often have dedicated budget line items. Production accountants track episodic costs for above-the-line talent overages, location expenses, and ',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Episode-level revenue stream assignment supports per-episode revenue tracking for TVOD per-episode purchases and syndication per-episode licensing fees. Standard in media finance for episodic content ',
    `rights_content_window_id` BIGINT COMMENT 'Foreign key linking to rights.rights_content_window. Business justification: Episodes have specific rights content windows governing VOD availability, geo-blocking, and platform access. Episode-level rights content window tracking is required for availability management and ri',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: Episodes may have territory-specific rights restrictions (geo-blocking, blackouts). Per-episode territory rights clearance and VOD availability management require this FK. Standard in broadcast operat',
    `royalty_rule_id` BIGINT COMMENT 'Foreign key linking to rights.royalty_rule. Business justification: Per-episode royalty rules govern residuals and royalty payments. Episode-level royalty rule assignment is required for accurate royalty statement generation and guild compliance reporting. No existing',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Episodes ARE titles in the master catalog. Every episode should reference its title record for unified content identification and metadata management.',
    `archive_date` DATE COMMENT 'Date when the episode master was moved to long-term archive storage. Used for asset lifecycle management and storage optimization.',
    `archive_location` STRING COMMENT 'Physical or logical location identifier for the archived master copy in the Media Asset Management (MAM) system. Supports long-term preservation and retrieval.',
    `aspect_ratio` STRING COMMENT 'Display aspect ratio of the episode video. Affects playout configuration, transcoding profiles, and distribution format specifications.. Valid values are `4:3|16:9|21:9|1.85:1|2.39:1`',
    `audio_description_available` BOOLEAN COMMENT 'Indicates whether audio description track is available for visually impaired viewers. Required for accessibility compliance.',
    `audio_format` STRING COMMENT 'Audio channel configuration and encoding format. Affects playout system configuration and premium content positioning.. Valid values are `stereo|5.1|7.1|dolby_atmos|dts_x`',
    `broadcast_count` STRING COMMENT 'Total number of times this episode has been broadcast on linear television. Used for residuals calculation and syndication rights management.',
    `closed_caption_available` BOOLEAN COMMENT 'Indicates whether closed captioning is available for this episode. Required for FCC compliance and accessibility standards.',
    `content_advisory` STRING COMMENT 'Specific content warnings or advisories for viewer guidance (e.g., violence, language, adult themes). Displayed in Electronic Program Guide (EPG) and Video On Demand (VOD) interfaces.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the episode record was first created in the content management system. Used for audit trail and data lineage tracking.',
    `eidr_identifier` STRING COMMENT 'Globally unique identifier for the episode registered with the Entertainment Identifier Registry. Enables universal content identification across distribution platforms and rights management systems.. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `episode_number` STRING COMMENT 'Sequential number of the episode within its season. Used for ordering and identification in Electronic Program Guide (EPG) and Video On Demand (VOD) catalogs.',
    `episode_status` STRING COMMENT 'Current lifecycle state of the episode. Determines availability for scheduling, playout automation, and distribution to Over-The-Top (OTT) platforms.. Valid values are `in_production|post_production|ready_for_broadcast|aired|archived|withdrawn`',
    `episode_type` STRING COMMENT 'Classification of the episode format and purpose within the series. Affects scheduling strategy, promotional treatment, and rights valuation. [ENUM-REF-CANDIDATE: standard|special|pilot|finale|recap|bonus|behind_the_scenes — 7 candidates stripped; promote to reference product]',
    `keywords` STRING COMMENT 'Comma-separated list of keywords and tags describing episode themes, topics, and notable elements. Supports content search, discovery, and metadata enrichment.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the episode record was last modified. Supports change tracking and data quality monitoring.',
    `music_cue_sheet_submitted` BOOLEAN COMMENT 'Indicates whether the music cue sheet has been submitted for royalty collection. Required for music rights compliance and royalty distribution.',
    `original_air_date` DATE COMMENT 'The date when the episode was first broadcast on linear television. Critical for rights windowing, residuals calculation, and syndication eligibility.',
    `premiere_flag` BOOLEAN COMMENT 'Indicates whether this is a premiere episode (first broadcast). Used for promotional planning, upfront advertising sales, and Nielsen sweeps period strategy.',
    `primary_language` STRING COMMENT 'ISO 639-3 three-letter code for the primary audio language of the episode. Used for content cataloging, rights clearance, and distribution targeting.. Valid values are `^[a-z]{3}$`',
    `production_code` STRING COMMENT 'Internal production identifier assigned during content creation. Used for tracking production workflow, post-production tasks, and archival reference.',
    `rerun_flag` BOOLEAN COMMENT 'Indicates whether this broadcast is a rerun. Affects advertising rates, Cost Per Rating Point (CPRP) calculations, and residuals payments to talent.',
    `rights_clearance_status` STRING COMMENT 'Current status of rights clearance for broadcast and distribution. Determines whether episode can be scheduled for playout or made available on Over-The-Top (OTT) platforms.. Valid values are `cleared|pending|restricted|expired`',
    `runtime_seconds` STRING COMMENT 'Total duration of the episode content in seconds, excluding commercial breaks. Used for playout scheduling, ad pod allocation, and Electronic Program Guide (EPG) display.',
    `runtime_with_ads_seconds` STRING COMMENT 'Total broadcast duration including commercial ad breaks. Used for linear scheduling and daypart planning.',
    `subtitles_available` BOOLEAN COMMENT 'Indicates whether subtitle tracks are available for this episode. Supports international distribution and localization strategies.',
    `synopsis_long` STRING COMMENT 'Detailed description of the episode plot, themes, and key moments. Used for Video On Demand (VOD) platforms, promotional materials, and content discovery.',
    `synopsis_short` STRING COMMENT 'Brief summary of the episode content, typically 50-100 characters. Used for Electronic Program Guide (EPG) listings and mobile applications with limited display space.',
    `title` STRING COMMENT 'The official title or name of the episode. Displayed in Electronic Program Guide (EPG), Video On Demand (VOD) interfaces, and promotional materials.',
    `video_resolution` STRING COMMENT 'Maximum video resolution available for this episode. Determines distribution channel eligibility and Adaptive Bitrate Streaming (ABR) profile selection.. Valid values are `SD|HD|FHD|UHD|4K|8K`',
    `vod_available_from_date` DATE COMMENT 'Date when the episode becomes available on Video On Demand (VOD) platforms. Part of windowing strategy and rights holdback management.',
    `vod_available_until_date` DATE COMMENT 'Date when the episode is removed from Video On Demand (VOD) platforms. Enforces rights windows and exclusivity periods.',
    CONSTRAINT pk_content_episode PRIMARY KEY(`content_episode_id`)
) COMMENT 'Master record for an individual episode within a series season. Captures episode number, episode title, production code, original broadcast date, runtime, episode type (standard/special/pilot/finale/recap), episode synopsis, content rating, EIDR episode identifier, closed-caption availability flag, audio description flag, and episode status. Supports EPG scheduling, VOD availability windows, rights clearance at episode level, and residuals calculation for talent reuse payments.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`content`.`version` (
    `version_id` BIGINT COMMENT 'Primary key for version',
    `abr_profile_id` BIGINT COMMENT 'Foreign key linking to distribution.abr_profile. Business justification: Content versions are encoded to specific ABR profiles (HLS ladder, DASH manifest). Essential for transcode workflow, QC validation, and ensuring version matches target platforms adaptive bitrate stre',
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.rating. Business justification: Versions have MPA and TV ratings. Normalizes mpa_rating/tv_rating string columns to reference the enterprise rating taxonomy.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Version creation (encoding, QC, HDR mastering, accessibility prep) incurs costs tracked against cost centers. In large media operations, version-level cost tracking against post-production cost center',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Content versions are prepared for specific delivery channels (e.g., 4K HDR version for premium OTT, SD version for FAST linear). version has target_platform as a plain string but no delivery_channel F',
    `drm_policy_id` BIGINT COMMENT 'Foreign key linking to distribution.drm_policy. Business justification: Each content version is protected by specific DRM policy (Widevine L1, HDCP 2.2 requirements). Required for rights enforcement, device compatibility validation, and studio compliance in premium conten',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Version-specific grants (4K rights vs HD rights, dubbed vs subtitled) are tracked separately in modern distribution. Clearance systems must validate that the specific version has an active grant.',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Different versions (theatrical cut, directors cut, TV edit, international dub) often have separate rights agreements with distinct terms. Clearance and distribution workflows require version-specific',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: A content version (editorial/rights construct) maps to a specific technical asset_version in the MAM. Distribution readiness reporting and platform delivery workflows require this link to confirm the ',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Each content version (territory/platform-specific cut) references its master media asset for distribution. Fulfillment workflows require version-to-asset mapping to deliver correct files to platforms ',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: A content version is derived from a production episode master. This production-to-content version lineage is fundamental for QC traceability, rights clearance, and content catalog management. Version ',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Versions (4K HDR, dubbed, accessibility) are tied to specific revenue streams — e.g., 4K version to premium SVOD tier, dubbed version to international AVOD. Version-level revenue stream assignment sup',
    `rights_content_window_id` BIGINT COMMENT 'Foreign key linking to rights.rights_content_window. Business justification: Versions are authorized for platform delivery by specific rights content windows. Version-level rights content window validation is required before platform delivery to ensure rights compliance. No ex',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: Versions are created for specific territories (dubbed French version, UK theatrical version). Territory-specific version management and rights clearance per version require this FK. Version has target',
    `royalty_rule_id` BIGINT COMMENT 'Foreign key linking to rights.royalty_rule. Business justification: Different version types (HD, SD, dubbed, theatrical) attract different royalty rates. Version-level royalty rule assignment is required for accurate royalty calculation and statement generation per ex',
    `title_id` BIGINT COMMENT 'Reference to the master content asset (title, episode, series, film, clip, music, news segment, or live event) that this version belongs to.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this version was approved for distribution and playout.',
    `archived_timestamp` TIMESTAMP COMMENT 'Timestamp when this version was moved to long-term archive storage.',
    `aspect_ratio` STRING COMMENT 'Display aspect ratio of this version (e.g., 16:9, 4:3, 21:9, 2.39:1).. Valid values are `^[0-9]+:[0-9]+$`',
    `audio_codec` STRING COMMENT 'Audio compression codec used for this version (e.g., AAC, AC-3, E-AC-3, Dolby Atmos, DTS).',
    `audio_description_available` BOOLEAN COMMENT 'Indicates whether audio description track is available for visually impaired audiences, supporting accessibility compliance.',
    `audio_track_configuration` STRING COMMENT 'Comma-separated list of audio track languages and types available in this version (e.g., en:stereo,es:5.1,fr:stereo,en:descriptive).',
    `broadcast_safe` BOOLEAN COMMENT 'Indicates whether this version has been certified as broadcast-safe, meeting technical standards for linear transmission (audio levels, video levels, closed captioning).',
    `checksum_md5` STRING COMMENT 'MD5 hash checksum of the version file, used for integrity verification during transfer and archival.. Valid values are `^[a-f0-9]{32}$`',
    `closed_caption_available` BOOLEAN COMMENT 'Indicates whether closed captioning (CC) is available for this version, supporting accessibility compliance.',
    `color_space` STRING COMMENT 'Color space standard used for this version (Rec. 709, Rec. 2020, DCI-P3, sRGB).. Valid values are `rec_709|rec_2020|dci_p3|srgb`',
    `content_advisory` STRING COMMENT 'Comma-separated list of content advisory flags for this version (e.g., violence, language, sexual_content, drug_use, nudity).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this version record was first created in the system.',
    `eidr_code` STRING COMMENT 'Unique EIDR identifier for this specific version, enabling global content identification and rights management.. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `file_format` STRING COMMENT 'Container file format for this version (e.g., MP4, MXF, MOV, TS, WebM).',
    `file_size_bytes` BIGINT COMMENT 'Total file size of this version in bytes, used for storage planning and delivery bandwidth estimation.',
    `frame_rate` DECIMAL(18,2) COMMENT 'Frame rate of this version in frames per second (e.g., 23.98, 24.00, 25.00, 29.97, 30.00, 50.00, 59.94, 60.00).',
    `hdr_format` STRING COMMENT 'High Dynamic Range format used for this version (SDR, HDR10, HDR10+, Dolby Vision, HLG).. Valid values are `sdr|hdr10|hdr10_plus|dolby_vision|hlg`',
    `isan_code` STRING COMMENT 'International Standard Audiovisual Number uniquely identifying this audiovisual work version.. Valid values are `^ISAN [A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `isrc_code` STRING COMMENT 'International Standard Recording Code for music or audio content versions, enabling tracking and royalty distribution.. Valid values are `^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$`',
    `label` STRING COMMENT 'Human-readable label identifying this version (e.g., Theatrical Cut, Directors Cut, Broadcast Safe, Spanish Dub, UK Censored).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this version record was last modified.',
    `primary_language_code` STRING COMMENT 'ISO 639 two or three-letter code for the primary audio language of this version (e.g., en, es, fr).. Valid values are `^[a-z]{2,3}$`',
    `qc_completed_date` DATE COMMENT 'Date when quality control review was completed for this version.',
    `qc_status` STRING COMMENT 'Quality control review status for this version, indicating whether it has passed technical and content quality checks.. Valid values are `not_started|in_progress|passed|failed|conditional_pass`',
    `resolution` STRING COMMENT 'Video resolution classification for this version (SD, HD 720p, HD 1080p, UHD 4K, UHD 8K).. Valid values are `sd|hd_720p|hd_1080p|uhd_4k|uhd_8k`',
    `runtime_delta_seconds` STRING COMMENT 'Difference in runtime (in seconds) between this version and the master version. Positive values indicate longer runtime, negative indicate shorter.',
    `runtime_seconds` STRING COMMENT 'Total runtime of this version in seconds, representing the complete playback duration.',
    `storage_location` STRING COMMENT 'Physical or logical storage location identifier where this version is archived (e.g., tape library ID, cloud bucket path, MAM archive reference).',
    `subtitle_languages` STRING COMMENT 'Comma-separated list of ISO 639 language codes for subtitle tracks included in this version (e.g., en,es,fr,de).',
    `target_platform` STRING COMMENT 'Distribution platform or window this version is optimized for (e.g., linear broadcast, SVOD, AVOD, theatrical). [ENUM-REF-CANDIDATE: linear_broadcast|svod|avod|tvod|theatrical|home_video|syndication|fast|mvpd|vmvpd — 10 candidates stripped; promote to reference product]',
    `target_territory` STRING COMMENT 'Three-letter ISO country code indicating the primary geographic territory this version is intended for (e.g., USA, GBR, FRA).. Valid values are `^[A-Z]{3}$`',
    `version_status` STRING COMMENT 'Current lifecycle status of the version indicating its readiness for distribution and playout. [ENUM-REF-CANDIDATE: draft|in_production|qc_pending|approved|active|archived|deprecated|rejected — 8 candidates stripped; promote to reference product]',
    `version_type` STRING COMMENT 'Classification of the version type indicating the nature of the edit or adaptation. [ENUM-REF-CANDIDATE: theatrical|broadcast|director|extended|unrated|censored|dubbed|subtitled|localized|preview|trailer — 11 candidates stripped; promote to reference product]',
    `video_codec` STRING COMMENT 'Video compression codec used for this version (e.g., H.264, H.265/HEVC, VP9, AV1, MPEG-2).',
    CONSTRAINT pk_version PRIMARY KEY(`version_id`)
) COMMENT 'Tracks every distinct version of a title — including edits, cuts, localized dubs, censored versions, broadcast-safe edits, theatrical vs. extended cuts, and format variants (SD/HD/4K). Each version record carries version type (theatrical/broadcast/director/unrated/censored/dubbed/subtitled), version label, target territory, target platform, runtime delta from master, language track configuration, subtitle language list, aspect ratio override, and version status. Enables multi-platform distribution where different versions are delivered to different windows and territories.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`content`.`genre` (
    `genre_id` BIGINT COMMENT 'Unique identifier for the genre. Primary key for the genre reference taxonomy.',
    `parent_genre_id` BIGINT COMMENT 'Reference to the parent genre in the hierarchical taxonomy, enabling multi-level classification such as Drama > Legal Drama or Sports > Football. Null for top-level genres.',
    `ad_pod_compatibility` BOOLEAN COMMENT 'Indicates whether content in this genre is compatible with Dynamic Ad Insertion (DAI) and ad pod placement. False for genres requiring uninterrupted viewing (e.g., live sports critical moments, news breaking coverage).',
    `applicable_content_types` STRING COMMENT 'Comma-separated list of content types to which this genre applies (e.g., series, film, clip, live_event, news_segment, music_video). Enables content-type-specific genre filtering.',
    `archive_retention_policy` STRING COMMENT 'Digital asset archival retention policy for content in this genre. Permanent retention for high-value evergreen genres; short-term for time-sensitive news and event content.. Valid values are `permanent|long_term|standard|short_term`',
    `avod_monetization_potential` STRING COMMENT 'Revenue generation potential for this genre on Advertising-Supported Video On Demand (AVOD) platforms, based on Cost Per Mille (CPM) rates and advertiser demand. High-potential genres command premium ad rates.. Valid values are `high|medium|low`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this genre record was first created in the enterprise content taxonomy system.',
    `daypart_affinity` STRING COMMENT 'Comma-separated list of broadcast dayparts where this genre typically performs best (e.g., prime_time, late_night, early_morning, daytime, weekend). Informs program scheduling and playout automation strategies.',
    `effective_end_date` DATE COMMENT 'Date when this genre classification was retired or superseded. Null for currently active genres. Used for historical content classification and reporting continuity.',
    `effective_start_date` DATE COMMENT 'Date when this genre classification became effective and available for use in content metadata and scheduling systems.',
    `eidr_genre_mapping` STRING COMMENT 'Mapping to Entertainment Identifier Registry (EIDR) genre taxonomy for cross-industry content identification and rights management interoperability.',
    `fast_channel_applicability` BOOLEAN COMMENT 'Indicates whether this genre is suitable for Free Ad-Supported Streaming Television (FAST) linear channel programming. FAST channels require genres with deep catalog availability and consistent audience appeal.',
    `genre_code` STRING COMMENT 'Short alphanumeric code representing the genre for system integration and Electronic Program Guide (EPG) feeds. Used as a business key across scheduling, distribution, and metadata systems.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `genre_description` STRING COMMENT 'Detailed textual description of the genre, including defining characteristics, typical content examples, and audience expectations. Used for editorial guidance and content acquisition briefings.',
    `genre_name` STRING COMMENT 'Full display name of the genre as presented to audiences in Electronic Program Guides (EPG), streaming platform interfaces, and content discovery systems.',
    `genre_tier` STRING COMMENT 'Hierarchical level of the genre within the taxonomy. Primary represents top-level genres, secondary represents sub-genres, and tertiary represents granular classifications.. Valid values are `primary|secondary|tertiary`',
    `geographic_restriction_applicability` BOOLEAN COMMENT 'Indicates whether content in this genre is subject to geographic blackout restrictions or regional licensing constraints. Common for sports genres with territorial rights and retransmission consent agreements.',
    `iab_content_category` STRING COMMENT 'Mapping to Interactive Advertising Bureau (IAB) content taxonomy for programmatic advertising and contextual ad targeting. Enables Share of Voice (SOV) optimization and Cost Per Mille (CPM) rate alignment.. Valid values are `^IAB[0-9]{1,2}(-[0-9]{1,2})?$`',
    `is_active` BOOLEAN COMMENT 'Indicates whether this genre is currently active and available for content classification. Inactive genres are retained for historical content but not used for new acquisitions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this genre record was last updated. Used for change tracking and metadata synchronization across Electronic Program Guide (EPG), Media Asset Management (MAM), and distribution systems.',
    `linear_broadcast_suitability` BOOLEAN COMMENT 'Indicates whether this genre is suitable for traditional linear scheduled broadcasting. Some genres (e.g., interactive, choose-your-own-adventure) are non-linear only.',
    `localization_priority` STRING COMMENT 'Priority level for content localization (dubbing, subtitling, cultural adaptation) for this genre. High-priority genres justify investment in multi-language versions for international distribution.. Valid values are `high|medium|low`',
    `metadata_enrichment_priority` STRING COMMENT 'Priority level for metadata enrichment and tagging in Media Asset Management (MAM) systems. Critical genres require comprehensive metadata for content discovery and personalization.. Valid values are `critical|standard|minimal`',
    `mpa_rating_applicability` STRING COMMENT 'Comma-separated list of Motion Picture Association (MPA) ratings typically associated with this genre (e.g., G, PG, PG-13, R, NC-17). Used for content clearance and daypart scheduling compliance.',
    `nielsen_genre_code` STRING COMMENT 'Nielsen Media Research genre classification code used for audience measurement, ratings analysis, and Gross Rating Point (GRP) reporting alignment.',
    `ott_platform_priority` STRING COMMENT 'Priority level for featuring this genre on Over-The-Top (OTT) streaming platforms and Video On Demand (VOD) services. High priority genres receive prominent placement in content discovery and recommendation engines.. Valid values are `high|medium|low`',
    `parental_guidance_flag` BOOLEAN COMMENT 'Indicates whether content in this genre typically requires parental guidance warnings or viewer discretion advisories. Used for compliance with Federal Communications Commission (FCC) broadcast standards and Childrens Online Privacy Protection Act (COPPA) requirements.',
    `svod_performance_tier` STRING COMMENT 'Performance classification for this genre on Subscription Video On Demand (SVOD) platforms. Premium genres drive subscriber acquisition and reduce churn rate; catalog genres provide library depth.. Valid values are `premium|standard|catalog`',
    `syndication_eligibility` BOOLEAN COMMENT 'Indicates whether content in this genre is typically eligible for syndication to multiple outlets and resale. Used in rights and royalties management and windowing strategy planning.',
    `target_demographic` STRING COMMENT 'Primary audience demographic segment targeted by this genre, expressed in Nielsen demographic notation (e.g., A18-49, M25-54, W18-34). Used for Target Rating Point (TRP) and Gross Rating Point (GRP) planning.',
    `usage_notes` STRING COMMENT 'Internal notes and guidelines for content producers, schedulers, and metadata specialists on proper application of this genre classification. Includes edge cases and disambiguation rules.',
    CONSTRAINT pk_genre PRIMARY KEY(`genre_id`)
) COMMENT 'Enterprise reference taxonomy for content genre and sub-genre classification. Captures genre code, genre name, parent genre reference (enabling hierarchical sub-genres like Drama > Legal Drama), genre tier (primary/secondary), applicable content types, IAB content category mapping for ad targeting, and active status. Standardizes genre labeling across EPG systems, streaming platform metadata feeds, and advertising contextual targeting to ensure consistent audience segmentation and content discovery.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`content`.`rating` (
    `rating_id` BIGINT COMMENT 'Primary key for rating',
    `appeal_status` STRING COMMENT 'The current status of any appeal filed by the content producer or distributor to challenge or modify the assigned rating classification.. Valid values are `not_appealed|appeal_pending|appeal_approved|appeal_denied`',
    `body` STRING COMMENT 'The official name of the regulatory or industry body that issued the rating (e.g., Motion Picture Association, TV Parental Guidelines Monitoring Board, British Board of Film Classification, Freiwillige Selbstkontrolle der Filmwirtschaft).',
    `certificate_number` STRING COMMENT 'The unique certificate or reference number issued by the rating body upon classification approval. Used for audit and compliance verification.',
    `content_descriptor_drug_use` BOOLEAN COMMENT 'Boolean flag indicating whether the rating includes a content descriptor for drug use or substance abuse.',
    `content_descriptor_fear` BOOLEAN COMMENT 'Boolean flag indicating whether the rating includes a content descriptor for frightening or intense scenes that may be unsuitable for younger audiences.',
    `content_descriptor_language` BOOLEAN COMMENT 'Boolean flag indicating whether the rating includes a content descriptor for strong or offensive language.',
    `content_descriptor_nudity` BOOLEAN COMMENT 'Boolean flag indicating whether the rating includes a content descriptor for nudity or sexual content.',
    `content_descriptor_violence` BOOLEAN COMMENT 'Boolean flag indicating whether the rating includes a content descriptor for violence or intense action.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this rating record was first created in the system.',
    `effective_date` DATE COMMENT 'The date on which this rating classification became effective and applicable to the content asset.',
    `expiration_date` DATE COMMENT 'The date on which this rating classification expires or is no longer valid. Null if the rating does not expire.',
    `minimum_age` STRING COMMENT 'The minimum recommended or legally mandated age (in years) for viewers of content with this rating. Null if no specific age restriction applies.',
    `notes` STRING COMMENT 'Additional internal notes or comments regarding the rating classification, including any special considerations, conditional approvals, or compliance requirements.',
    `parental_control_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether this rating is used to enforce parental control features on linear broadcast, OTT (Over-The-Top), or MVPD (Multichannel Video Programming Distributor) platforms.',
    `rating_code` STRING COMMENT 'The official rating classification code assigned to the content (e.g., G, PG, PG-13, R, NC-17 for MPA film ratings; TV-Y, TV-Y7, TV-G, TV-PG, TV-14, TV-MA for TV Parental Guidelines; or international equivalents such as BBFC, FSK, OFLC codes). [ENUM-REF-CANDIDATE: G|PG|PG-13|R|NC-17|TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA — 11 candidates stripped; promote to reference product]',
    `rating_description` STRING COMMENT 'Detailed textual description of the rating, including the rationale for the classification and any additional context provided by the rating body (e.g., Rated PG-13 for intense sequences of violence and action, some suggestive content, and brief strong language).',
    `regulatory_mandate_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the rating is legally mandated by a regulatory body (e.g., FCC, Ofcom) or is a voluntary industry classification.',
    `submission_date` DATE COMMENT 'The date on which the content was submitted to the rating body for classification review.',
    `system` STRING COMMENT 'The rating system or classification framework under which the rating was assigned (e.g., MPA for Motion Picture Association, TVPG for TV Parental Guidelines, BBFC for British Board of Film Classification, FSK for Freiwillige Selbstkontrolle der Filmwirtschaft, OFLC for Australian Classification Board, CBFC for Central Board of Film Certification India).. Valid values are `MPA|TVPG|BBFC|FSK|OFLC|CBFC`',
    `territory_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country or territory code indicating the geographic jurisdiction where this rating applies (e.g., USA, GBR, DEU, AUS, IND).. Valid values are `^[A-Z]{3}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this rating record was last modified or updated.',
    `version` STRING COMMENT 'Version number of the rating record, incremented when the rating is re-evaluated or updated due to content edits, appeals, or regulatory changes.',
    CONSTRAINT pk_rating PRIMARY KEY(`rating_id`)
) COMMENT 'Reference table for MPA, TV Parental Guidelines, and international content rating classifications applied to titles. Captures rating code (G/PG/PG-13/R/NC-17/TV-Y/TV-G/TV-PG/TV-14/TV-MA and international equivalents), rating system (MPA/TVPG/BBFC/FSK/etc.), rating body, applicable territory, minimum age indicator, content descriptor codes (violence/language/nudity/drug-use), and regulatory mandate flags. Supports FCC compliance, COPPA enforcement, and parental control features across linear and OTT platforms.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`content`.`localization` (
    `localization_id` BIGINT COMMENT 'Unique identifier for the localization work product record.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Localization vendors (dubbing studios, subtitle houses) are paid via accounts payable. localization has purchase_order_number as a plain attribute indicating AP linkage. Direct FK supports vendor paym',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Localized content versions require territory-specific ratings (BBFC for UK, FSK for Germany, MPAA for US). Localization workflow must track rating submission, approval, and certificate for regulatory ',
    `contract_id` BIGINT COMMENT 'Foreign key linking to talent.contract. Business justification: Voice talent dubbing contracts govern rates, residuals, and union obligations for localized versions. localization already has voice_talent_profile_id but no contract FK, making it impossible to link ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Localization spend (dubbing, subtitling, QC) is tracked against cost centers for departmental budget control. localization has cost_amount and currency_code as plain attributes indicating financial tr',
    `distribution_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.distribution_agreement. Business justification: Localization deliverables are contractually required under specific distribution agreements that define language, territory, and technical specifications. This FK enables SLA compliance tracking and c',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: Localization requires a rights grant authorizing the language/territory version. Rights grant validation before localization commissioning is a standard clearance workflow step in media operations.',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: A localization order produces a specific asset_version (dubbed or subtitled rendition). QC and platform delivery workflows require linking the localization record to the exact technical rendition for ',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Localized audio tracks and subtitle files are delivered as media assets. Distribution workflows require linking localization records to their delivered asset files for QC, versioning, and platform del',
    `music_sync_license_id` BIGINT COMMENT 'Foreign key linking to rights.music_sync_license. Business justification: Localized versions require music sync clearance for dubbed or adapted music tracks. Music sync license tracking per localized version is a regulatory and contractual requirement for broadcast complian',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Localizations are prepared for specific platform technical specs (Netflix TDF, iTunes metadata format). Platform-specific subtitle formats, audio track configurations, and metadata requirements drive ',
    `partner_id` BIGINT COMMENT 'Reference to the external vendor or internal facility performing the localization work.',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: Localization (dubbing, subtitling) is triggered by production episode delivery and tracked against the production episode record for compliance and delivery reporting. Localization links to version bu',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: ADA, EU Accessibility Act, and territory-specific language mandates require localization work (dubbing, subtitling, audio description). Linking localization records to the regulatory obligation that m',
    `rights_content_window_id` BIGINT COMMENT 'Foreign key linking to rights.rights_content_window. Business justification: Localized asset delivery is authorized by rights content windows specifying territory and platform scope. Rights content window validation before localized delivery is required for rights compliance i',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: Localization is performed for specific territories; territory rights clearance must be confirmed before localization work is commissioned. Localization has target_territory_code as a plain string but ',
    `version_id` BIGINT COMMENT 'Reference to the specific title version being localized.',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Dubbing and voice localization require tracking which talent performed the localized version for residual payments, credit attribution, and guild reporting. Essential for international content distrib',
    `accessibility_standard_met` STRING COMMENT 'Specific accessibility standard that the localization work product complies with (e.g., WCAG 2.1 AA, FCC CVAA).. Valid values are `WCAG_2.1_AA|WCAG_2.2_AA|FCC_CVAA|EAA|ADA|none`',
    `actual_delivery_date` DATE COMMENT 'Actual date when the localization work product was delivered by the vendor or internal team.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the localization work product received final approval for distribution.',
    `approved_by_name` STRING COMMENT 'Name of the individual or role who provided final approval for the localization work product.',
    `asset_file_path` STRING COMMENT 'Storage location or URI path to the delivered localization asset file in the Media Asset Management (MAM) system or Content Delivery Network (CDN).',
    `character_count` STRING COMMENT 'Total number of characters in the subtitle or metadata translation work product, used for billing and capacity planning.',
    `compliance_certification_flag` BOOLEAN COMMENT 'Indicates whether the localization meets regulatory compliance requirements for the target territory (e.g., local content quotas, language laws, accessibility standards).',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for this localization work product, including vendor fees, studio costs, and internal labor.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this localization record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the localization cost amount.. Valid values are `^[A-Z]{3}$`',
    `duration_minutes` DECIMAL(18,2) COMMENT 'Total runtime duration in minutes of the content being localized, relevant for dubbing and subtitling scope.',
    `eidr_code` STRING COMMENT 'EIDR unique identifier linking this localization to the global content registry for the underlying title.. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `localization_status` STRING COMMENT 'Current workflow status of the localization work product. [ENUM-REF-CANDIDATE: ordered|in_progress|delivered|qc_review|approved|rejected|revision_required — 7 candidates stripped; promote to reference product]',
    `localization_type` STRING COMMENT 'The type of localization work being performed on the content asset.. Valid values are `dubbing|subtitling|metadata_translation|forced_narrative|audio_description|closed_caption`',
    `order_date` DATE COMMENT 'Date when the localization work was ordered from the vendor or internal team.',
    `purchase_order_number` STRING COMMENT 'Purchase order number issued to the localization vendor for this work product.',
    `qc_notes` STRING COMMENT 'Detailed notes and findings from the quality control review process, including any defects or issues identified.',
    `qc_pass_flag` BOOLEAN COMMENT 'Boolean indicator of whether the localization work product passed quality control review.',
    `qc_review_date` DATE COMMENT 'Date when quality control review of the localization work product was completed.',
    `qc_reviewer_name` STRING COMMENT 'Name of the individual or team who performed the quality control review.',
    `revision_reason` STRING COMMENT 'Business reason or description for why a revision of the localization work product was required.',
    `scheduled_delivery_date` DATE COMMENT 'Contractually agreed or planned delivery date for the completed localization work product.',
    `subtitle_format` STRING COMMENT 'Technical format specification for subtitle files (SRT, TTML, WebVTT, etc.). [ENUM-REF-CANDIDATE: SRT|TTML|WebVTT|EBU-STL|SMPTE-TT|SCC|DFXP — 7 candidates stripped; promote to reference product]',
    `target_language_code` STRING COMMENT 'ISO 639 language code for the target localization language (e.g., es-MX for Mexican Spanish, fr-CA for Canadian French).. Valid values are `^[a-z]{2,3}(-[A-Z]{2})?$`',
    `target_territory_code` STRING COMMENT 'ISO 3166 three-letter country code representing the target distribution territory for this localization.. Valid values are `^[A-Z]{3}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this localization record was last modified.',
    `version_number` STRING COMMENT 'Version identifier for this localization work product, supporting iterative revisions and updates.',
    CONSTRAINT pk_localization PRIMARY KEY(`localization_id`)
) COMMENT 'Tracks the localization work product for a specific title version in a target language and territory — covering dubbing, subtitling, metadata translation, and compliance adaptation. Captures localization type (dub/subtitle/metadata/forced-narrative), target language, target territory, localization vendor, delivery date, localization status (ordered/in-progress/delivered/approved/rejected), QC pass flag, subtitle format (SRT/TTML/WebVTT), and dubbing studio reference. Supports multi-territory distribution and regulatory compliance for local-language requirements.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`content`.`talent_credit` (
    `talent_credit_id` BIGINT COMMENT 'Unique identifier for the talent credit record. Primary key for the talent credit association entity.',
    `content_episode_id` BIGINT COMMENT 'Reference to the specific episode within a series for which the talent is credited. Nullable for non-episodic content such as films or specials.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to talent.talent_contract. Business justification: Credits must link to contracts for residual calculation, compensation verification, guild compliance reporting, and billing position validation. Fundamental to talent payment and rights management pro',
    `role_id` BIGINT COMMENT 'Foreign key linking to talent.talent_role. Business justification: Credits reference specific roles for character attribution, billing position validation, and role-specific residual eligibility. Eliminates denormalized role/character data and ensures single source o',
    `talent_profile_id` BIGINT COMMENT 'Reference to the talent master record in the talent domain. Links to the individual or entity receiving credit for their contribution to the content.',
    `title_id` BIGINT COMMENT 'Reference to the content title (film, series, special, documentary) for which the talent is credited. Links to the content master catalog.',
    `billing_position` STRING COMMENT 'The ordinal position of the talent in the credit sequence, determining the order in which credits are displayed. Lower numbers indicate higher prominence (e.g., 1 = top billing). Used for EPG display and contractual compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this talent credit record was first created in the system. Used for audit trails and data lineage tracking.',
    `credit_approval_date` DATE COMMENT 'The date on which the credit was officially approved for publication. Used for audit trails and compliance with guild credit determination timelines.',
    `credit_approval_status` STRING COMMENT 'Current approval state of the credit. Pending indicates awaiting review; Approved indicates credit is finalized and ready for publication; Disputed indicates a challenge has been raised; Rejected indicates credit was not approved; Arbitration indicates the credit is under formal guild arbitration process.. Valid values are `pending|approved|disputed|rejected|arbitration`',
    `credit_category` STRING COMMENT 'High-level categorization of the credit by functional area or department. Used for grouping credits in EPG displays, streaming platform interfaces, and analytics. [ENUM-REF-CANDIDATE: cast|director|producer|writer|cinematography|editing|music|sound|production_design|costume|makeup|visual_effects|executive|other — 14 candidates stripped; promote to reference product]',
    `credit_display_name` STRING COMMENT 'The exact name as it should appear in credits, EPG metadata, and streaming platform displays. May differ from the talents legal name if a pseudonym or stage name is used. This is the authoritative display value for all public-facing credit presentations.',
    `credit_display_order` STRING COMMENT 'The sequence number for displaying this credit within its credit type or section (e.g., within the cast section or crew section). Used for rendering credits in EPG, streaming platforms, and promotional materials.',
    `credit_end_timestamp` TIMESTAMP COMMENT 'The timestamp marking when this credit ceases to be effective or visible. Nullable for credits that remain active indefinitely. Used for managing credit corrections, disputes, or contractual credit windows.',
    `credit_notes` STRING COMMENT 'Free-text field for additional context, special credit requirements, contractual stipulations, or notes related to credit disputes, arbitration outcomes, or special billing arrangements.',
    `credit_start_timestamp` TIMESTAMP COMMENT 'The timestamp marking when this credit becomes effective or visible in EPG and streaming platform metadata. Used for managing credit changes over time and versioning.',
    `credit_type` STRING COMMENT 'Classification of the credit based on how the talent contribution is presented. On-screen credits appear in the visual content; off-screen credits appear in end titles or metadata only; voice credits are for voice-over or dubbing; stunt credits are for stunt performers; archive credits are for archival footage appearances.. Valid values are `on-screen|off-screen|voice|stunt|archive`',
    `pseudonym_flag` BOOLEAN COMMENT 'Indicates whether the talent is credited under a pseudonym or stage name rather than their legal name. True if pseudonym is used; False if legal name is used. Relevant for guild compliance and contractual credit requirements.',
    `residuals_eligibility_flag` BOOLEAN COMMENT 'Indicates whether this credit qualifies the talent for residual payments based on content reuse, syndication, or secondary distribution. True if eligible; False otherwise. Triggers residuals calculation workflows in the rights and royalties domain.',
    `union_affiliation_flag` BOOLEAN COMMENT 'Indicates whether the talent is affiliated with a recognized industry union (SAG-AFTRA, DGA, WGA, IATSE) for this credit. True if union-affiliated; False otherwise. Used for residuals eligibility determination and compliance reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this talent credit record was last modified. Used for audit trails, change tracking, and data quality monitoring.',
    CONSTRAINT pk_talent_credit PRIMARY KEY(`talent_credit_id`)
) COMMENT 'Association entity linking talent identities (owned by the talent domain) to specific titles and episodes with their credited role, billing position, character name, credit type (on-screen/off-screen), and credit display order. Captures SAG-AFTRA/WGA/DGA union affiliation flag, residuals eligibility flag, and credit approval status. Serves as the content domains authoritative credit roll for EPG metadata delivery, streaming platform cast display, and residuals calculation triggers. Does not duplicate the talent master record — references it via FK to the talent domain.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`content`.`acquisition` (
    `acquisition_id` BIGINT COMMENT 'Primary key for acquisition',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Content acquisition deals create payment obligations to licensors/distributors. AP tracks amounts owed under acquisition agreements for cash flow forecasting, payment scheduling, and vendor relationsh',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Content acquisition workflows require reconciling the acquired deliverable (physical or digital) with its MAM record. Acquisition-to-asset traceability is mandatory for rights clearance audits, paymen',
    `acquisition_deal_id` BIGINT COMMENT 'Reference to the originating rights deal or contract under which this content was acquired. Links to the master rights agreement.',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Content acquisitions must verify existing ratings or budget for rating submissions (MPAA, TV Parental Guidelines) as part of deal clearance and distribution planning. Links acquisition to rating certi',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Acquisitions often specify which version was acquired (theatrical vs broadcast cut, localized version). This FK allows tracking version-specific acquisition terms and rights.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Content acquisition costs are allocated to cost centers for departmental budget control and acquisition P&L. The existing accounts_payable_id covers payment processing but not cost center allocation. ',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Acquisition deals specify permitted delivery channels (e.g., streaming-only rights, linear-only rights). acquisition.delivery_channel_id captures the delivery channel scope of an acquisition, enabling',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: Acquisitions result in or are governed by specific rights grants. Linking acquisition to the grant it produces or operates under is essential for rights tracking, exploitation authorization, and royal',
    `ingest_job_id` BIGINT COMMENT 'Foreign key linking to mediaasset.ingest_job. Business justification: Content acquisition triggers a MAM ingest job to onboard the delivered asset. Acquisition-to-ingest traceability is required for content operations audits, delivery SLA reporting, and payment mileston',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Acquisitions are executed by specific legal entities — the acquiring entity is critical for intercompany accounting, regulatory reporting of content acquisition spend, and ensuring correct entity-leve',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Acquisition records must reference the underlying license agreement that enabled the acquisition. Financial reconciliation, audit trails, and rights validation require linking acquisitions to their go',
    `partner_id` BIGINT COMMENT 'Reference to the external party from whom the content was acquired (studio, independent producer, syndicator, distributor, or content aggregator).',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Content acquisition deals generate payable invoices to rights holders. Accounts payable teams track which invoices correspond to acquisition agreements for payment scheduling, rights verification, cos',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Acquisition deals are attributed to profit centers for segment-level content investment reporting. Media companies track acquisition ROI by profit center (e.g., streaming segment vs. broadcast segment',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Local content quota regulations (Australian local content rules, Canadian CanCon, EU content quotas) require tracking which acquisitions satisfy specific regulatory obligations. Compliance teams must ',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Content acquisition deals define licensing terms that determine revenue recognition treatment. Acquired content flows through specific revenue streams based on deal structure (output deals, first-run ',
    `rights_content_window_id` BIGINT COMMENT 'Foreign key linking to rights.rights_content_window. Business justification: Acquisitions define the rights content windows under which content is available. Linking acquisition to the rights content window it creates or operates within is essential for availability management',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: Acquisitions are scoped to specific territories; territory-scoped acquisition deal management and rights clearance require a proper FK. Acquisition has territory_scope as plain text description but no',
    `royalty_rule_id` BIGINT COMMENT 'Foreign key linking to rights.royalty_rule. Business justification: Acquisitions are subject to specific royalty rules governing payment calculations. Acquisition has royalty_rate_percent as a plain attribute but no FK to the royalty_rule master. Royalty rule assignme',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: Content acquisitions are frequently negotiated at the season level (e.g., acquiring rights to Season 3 of a series). The acquisition table already has title_id and content_version_id, but lacks a dire',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Acquisitions are commonly negotiated at the series level (e.g., acquiring all rights to an entire franchise). The acquisition table lacks a series_id FK. Adding content.series.series_id as a FK enable',
    `title_id` BIGINT COMMENT 'Reference to the content asset being acquired. Links to the master content catalog entry for the title, episode, series, film, clip, or other content asset.',
    `acquisition_date` DATE COMMENT 'The date on which the acquisition transaction was executed and the content rights were legally transferred or licensed to the enterprise. Represents the principal business event timestamp for this transaction.',
    `acquisition_status` STRING COMMENT 'Current lifecycle state of the acquisition. Negotiating = deal in discussion; Committed = contract signed but content not yet delivered; Delivered = content received and ingested; Active = content in use; Cancelled = deal terminated before delivery; Expired = license period ended.. Valid values are `negotiating|committed|delivered|active|cancelled|expired`',
    `acquisition_type` STRING COMMENT 'Classification of the acquisition method. Purchase = outright ownership transfer; License = time-limited rights; Co-production = joint production investment; Commission = original content commissioned from producer; Barter = content exchanged for advertising inventory; Syndication = content licensed from syndicator for regional broadcast.. Valid values are `purchase|license|co-production|commission|barter|syndication`',
    `ancillary_rights_flag` BOOLEAN COMMENT 'Indicates whether ancillary rights (merchandising, soundtrack, publishing, remake, sequel, spin-off, clip licensing) are included in the acquisition (True) or retained by the supplier (False).',
    `clearance_status` STRING COMMENT 'Rights verification status confirming that all necessary clearances (music rights, talent rights, third-party content, trademarks) have been obtained for broadcast or distribution. Pending = verification in progress; Cleared = all rights confirmed; Restricted = partial clearance with limitations; Failed = clearance issues prevent exploitation.. Valid values are `pending|cleared|restricted|failed`',
    `content_window_type` STRING COMMENT 'The distribution window or rights category acquired. Windowing refers to the sequential release strategy where content is made available through different channels over time. Theatrical = cinema release; Home Video = physical/digital sell-through; SVOD = Subscription Video On Demand; AVOD = Advertising-Supported Video On Demand; TVOD = Transactional Video On Demand; Linear Broadcast = traditional scheduled TV; Syndication = resale to multiple outlets; All Rights = comprehensive rights across all windows. [ENUM-REF-CANDIDATE: theatrical|home_video|svod|avod|tvod|linear_broadcast|syndication|all_rights — 8 candidates stripped; promote to reference product]',
    `cost_amount` DECIMAL(18,2) COMMENT 'The total monetary value paid or committed for acquiring the content rights. Represents the base acquisition cost before taxes, fees, or adjustments. For licenses, this is the total license fee; for purchases, the purchase price; for commissions, the production budget committed.',
    `cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the acquisition cost amount (e.g., USD, GBP, EUR, JPY).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this acquisition record was first created in the system. Audit field for data lineage and compliance tracking.',
    `delivery_date` DATE COMMENT 'The date on which the content master files and associated materials (metadata, artwork, closed captions, promotional assets) were delivered by the supplier and ingested into the enterprise Media Asset Management (MAM) system.',
    `delivery_format` STRING COMMENT 'The technical format and delivery method used by the supplier to provide the content. Examples: ProRes 422 HQ via FTP, IMF package via Aspera, DCP hard drive, MPEG-4 via CDN, tape (legacy).',
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
    `sublicensing_allowed_flag` BOOLEAN COMMENT 'Indicates whether the enterprise is permitted to sublicense the acquired content to third parties (True) or must exploit the content directly only (False). Sublicensing enables syndication and secondary distribution deals.',
    `territory_scope` STRING COMMENT 'Geographic territories or markets for which the content rights were acquired. May be specified as country codes (ISO 3166), regional groupings, or worldwide. Examples: USA, GBR, North America, EMEA, Worldwide.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this acquisition record was last modified. Audit field for change tracking and data governance.',
    CONSTRAINT pk_acquisition PRIMARY KEY(`acquisition_id`)
) COMMENT 'Transactional record capturing the business event of acquiring content from an external source — studio, independent producer, syndicator, or distributor. Tracks acquisition type (purchase/license/co-production/commission), acquisition date, source party, acquisition cost, currency, content window acquired, territory scope, exclusivity flag, holdback period, acquisition status (negotiating/committed/delivered/cancelled), and originating deal reference. Serves as the financial and operational anchor for content entering the enterprise catalog from external sources.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` (
    `windowing_plan_id` BIGINT COMMENT 'Unique identifier for the windowing plan record. Primary key for the windowing plan entity.',
    `abr_profile_id` BIGINT COMMENT 'Foreign key linking to distribution.abr_profile. Business justification: Windows specify technical delivery profiles (4K/HDR for premium SVOD, HD for AVOD). ABR profile determines quality tier, bandwidth costs, and subscriber experience per distribution window.',
    `acquisition_id` BIGINT COMMENT 'Foreign key linking to content.acquisition. Business justification: A windowing plan is typically derived from or governed by an acquisition agreement — the acquisition defines the rights windows (theatrical, SVOD, AVOD, linear) that the windowing plan operationalizes',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Broadcast windowing plans must be tied to the specific FCC broadcast license authorizing distribution on that frequency/channel. License renewal documentation, retransmission consent management, and m',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Linear channel windowing plans define when and on which channel content can air — a core rights management process. Linking windowing_plan to channel enables rights compliance verification that schedu',
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.rating. Business justification: Windowing plans specify rating requirements for distribution windows. Normalizes rating_code string column to reference the enterprise rating taxonomy.',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Windowing plans are version-specific (theatrical version has different windows than broadcast version). Links distribution strategy to specific version.',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: A windowing plan targets a specific delivery channel (FAST, SVOD, linear, TVOD). windowing_plan already links to ott_platform and streaming_endpoint but not delivery_channel; delivery_channel_id direc',
    `distribution_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.distribution_agreement. Business justification: Windowing plans are executed under distribution agreements that define permitted windows, holdback periods, and exclusivity terms. This FK is required for rights compliance auditing and window sequenc',
    `drm_policy_id` BIGINT COMMENT 'Foreign key linking to distribution.drm_policy. Business justification: Each window has specific DRM requirements based on rights agreements (theatrical requires HDCP 2.2, rental allows offline). DRM policy enforcement varies by window type and revenue model.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Windowing plans specify distribution partners for each window (theatrical exhibitor, streaming platform, broadcast network). Partner performance tracking, holdback enforcement, exclusivity compliance ',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Windowing strategies must comply with license agreement terms (holdbacks, exclusivity windows, platform restrictions). Windowing plan validation and conflict detection require checking against the gov',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Each window must map to a specific rights grant that authorizes that exploitation type (SVOD, AVOD, linear broadcast). Clearance systems validate that the windows dates and platform fall within grant',
    `holdback_id` BIGINT COMMENT 'Foreign key linking to rights.holdback. Business justification: Windowing plans must respect holdback restrictions that block certain distribution windows. Linking windowing plans to applicable holdbacks is required for holdback enforcement during scheduling and d',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Windowing plans are executed by specific legal entities, especially for international distribution by regional subsidiaries. Required for intercompany revenue reporting and ensuring correct legal enti',
    `campaign_id` BIGINT COMMENT 'Reference identifier for the marketing campaign associated with this window release. Links to promotional activities, advertising spend, and audience acquisition efforts.',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Windowing plans define which platform receives content in each release window (theatrical → premium VOD → SVOD → AVOD). Core to revenue maximization strategy and rights holder agreements.',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: Episode-level windowing plans (SVOD window opens after broadcast premiere) are tied to production episode delivery dates. Distribution teams set windowing plans based on production episode delivery st',
    `program_schedule_id` BIGINT COMMENT 'Foreign key linking to scheduling.program_schedule. Business justification: Windowing plans define approved broadcast windows; program schedules execute them. Linking enables compliance verification that scheduled airings fall within approved windows, supporting rights cleara',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: EU AVMS Directive, Australian local content rules, and Canadian CanCon regulations impose mandatory windowing constraints (holdback periods, local content quotas). Linking windowing plans to the gover',
    `revenue_recognition_event_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_recognition_event. Business justification: Windowing plan openings trigger ASC 606/IFRS 15 revenue recognition events. Direct FK links the distribution window to its recognition event for compliance auditing. Finance teams need this to verify ',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Windowing plans define how content monetizes across distribution windows (theatrical, SVOD, AVOD, linear). Each window maps to specific revenue streams for ASC 606 performance obligation identificatio',
    `rights_availability_window_id` BIGINT COMMENT 'Foreign key linking to rights.rights_availability_window. Business justification: Windowing plans are derived from rights availability windows that define when content can be distributed. Rights-driven windowing strategy requires linking distribution plans to the availability windo',
    `rights_content_window_id` BIGINT COMMENT 'Foreign key linking to rights.rights_content_window. Business justification: Windowing plans must map to the rights content windows that authorize distribution. Rights-driven windowing requires linking distribution plans to their authorizing rights content windows for complian',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Windows are territory-specific - geo-blocking, regional release strategies, and regulatory compliance require linking each window to its target territory. Clearance validates territorial rights before',
    `royalty_rule_id` BIGINT COMMENT 'Foreign key linking to rights.royalty_rule. Business justification: Windowing plans determine revenue model and royalty obligations per distribution window (SVOD, AVOD, linear). Royalty rule assignment to windowing plans is required for financial planning and royalty ',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: Windowing plans are also commonly defined at the season level — a new season may have different windowing rules than prior seasons (e.g., Season 5 has a shorter theatrical window). Adding season_id FK',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Windowing plans in broadcasting are frequently defined at the series level — a network or streaming platform may define a single windowing strategy for an entire series (e.g., SVOD window opens 30 day',
    `streaming_endpoint_id` BIGINT COMMENT 'Foreign key linking to distribution.streaming_endpoint. Business justification: Each distribution window may use specific streaming endpoints (regional CDN POPs, premium tier endpoints). Required for geo-restriction enforcement, SLA tier assignment, and CDN cost allocation per wi',
    `subscription_plan_id` BIGINT COMMENT 'Foreign key linking to subscriber.subscription_plan. Business justification: Windowing plans define which subscription tier unlocks a content window (e.g., SVOD Premium window, AVOD free window). A FK to subscriber.subscription_plan.subscription_plan_id links content availabil',
    `title_id` BIGINT COMMENT 'Reference to the content asset (title, episode, series, film, clip) for which this windowing plan is defined. Links to the master content catalog.',
    `upfront_deal_id` BIGINT COMMENT 'Foreign key linking to sales.upfront_deal. Business justification: Windowing plans are directly constrained by upfront deal commitments — content must be available on specific platforms during contracted flight periods. Rights and distribution teams need to validate ',
    `abr_enabled` BOOLEAN COMMENT 'Indicates whether adaptive bitrate streaming is enabled for this window, allowing dynamic quality adjustment based on viewer bandwidth. True=ABR enabled, False=fixed bitrate.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this windowing plan was formally approved by authorized stakeholders. Marks transition from draft to confirmed status.',
    `audio_configuration` STRING COMMENT 'The audio format specification for this window. Stereo=2-channel, Surround 5.1=5.1 channel surround, Surround 7.1=7.1 channel surround, Dolby Atmos=object-based audio, DTS:X=immersive audio format.. Valid values are `stereo|surround_5_1|surround_7_1|dolby_atmos|dts_x`',
    `blackout_restrictions` STRING COMMENT 'Geographic or temporal blackout rules that restrict content availability in specific regions or time periods within the territory (e.g., sports blackouts, regional exclusions).',
    `bundle_eligibility` BOOLEAN COMMENT 'Indicates whether this content is eligible for inclusion in subscription bundles or multi-title packages during this window. True=bundle eligible, False=standalone only.',
    `concurrent_streams_limit` STRING COMMENT 'Maximum number of simultaneous streams allowed per subscriber account for this content in this window. Used for subscription service tier management.',
    `content_format` STRING COMMENT 'The technical format specification for content delivery in this window. SD=standard definition, HD=high definition 1080p, 4K=ultra high definition, 8K=8K resolution, HDR=high dynamic range, Dolby Vision=premium HDR format.. Valid values are `sd|hd|4k|8k|hdr|dolby_vision`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this windowing plan record was first created in the system. Audit trail for record lifecycle.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this windowing plan (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `daypart_restriction` STRING COMMENT 'Time-of-day broadcast restrictions for linear windows, defining when content may air (e.g., prime time only, late night only, daytime safe). Applies primarily to linear broadcast and cable windows.',
    `download_to_go_enabled` BOOLEAN COMMENT 'Indicates whether offline download capability is enabled for this window, allowing viewers to download content for offline viewing. True=downloads allowed, False=streaming only.',
    `dubbing_availability` BOOLEAN COMMENT 'Indicates whether dubbed audio tracks in alternate languages are available for this window release. True=dubbing provided, False=original language only.',
    `exclusivity_tier` STRING COMMENT 'The level of exclusivity granted to the platform during this window. Exclusive=sole distribution rights, Non-Exclusive=concurrent availability on multiple platforms, Shared Exclusive=limited to a defined group of platforms, First Run=premiere window, Second Run=subsequent availability.. Valid values are `exclusive|non_exclusive|shared_exclusive|first_run|second_run`',
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
    `streaming_protocol` STRING COMMENT 'The streaming delivery protocol used for OTT windows. HLS=HTTP Live Streaming (Apple), DASH=Dynamic Adaptive Streaming over HTTP (MPEG-DASH), Smooth Streaming=Microsoft, RTMP=Real-Time Messaging Protocol, WebRTC=real-time communication.. Valid values are `hls|dash|smooth_streaming|rtmp|webrtc`',
    `subtitle_availability` BOOLEAN COMMENT 'Indicates whether subtitles or closed captions are available for this window release. True=subtitles provided, False=no subtitles.',
    `territory_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country or territory code where this windowing plan applies (e.g., USA, GBR, CAN, AUS). Defines geographic scope of the release window.. Valid values are `^[A-Z]{3}$`',
    `viewing_window_hours` STRING COMMENT 'For TVOD/rental windows, the number of hours a viewer has to complete watching the content after initiating playback (e.g., 48-hour rental window).',
    `window_sequence_number` STRING COMMENT 'Sequential ordering of this window within the overall release strategy for the content. Lower numbers indicate earlier windows (e.g., 1=theatrical, 2=SVOD, 3=AVOD).',
    `window_status` STRING COMMENT 'Current lifecycle status of the windowing plan. Planned=initial strategy, Confirmed=approved by stakeholders, Active=currently in release window, Completed=window has closed, Cancelled=window will not execute, Postponed=delayed to future date.. Valid values are `planned|confirmed|active|completed|cancelled|postponed`',
    `window_type` STRING COMMENT 'The distribution window category defining the release channel type. Theatrical=cinema release, SVOD=subscription video on demand, AVOD=advertising-supported video on demand, TVOD=transactional video on demand, Linear Broadcast=traditional scheduled TV, Home Video=physical media, Syndication=content resale to multiple outlets, FAST=free ad-supported streaming television, PPV=pay-per-view, EST=electronic sell-through. [ENUM-REF-CANDIDATE: theatrical|svod|avod|tvod|linear_broadcast|home_video|syndication|fast|vod|ppv|est — 11 candidates stripped; promote to reference product]',
    CONSTRAINT pk_windowing_plan PRIMARY KEY(`windowing_plan_id`)
) COMMENT 'Defines the content-side release sequencing strategy for a title across distribution channels — theatrical, SVOD, AVOD, TVOD, linear broadcast, home video, and syndication. Each record captures window type, platform/channel, territory, planned open date, planned close date, holdback duration, exclusivity tier, and window status. Represents the content teams intended release plan that feeds into the rights domain for contractual enforcement and the distribution domain for operational execution. Distinct from rights windows (which are contractual) — this is the editorial/commercial planning artifact.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` (
    `metadata_profile_id` BIGINT COMMENT 'Unique identifier for the metadata profile record. Primary key.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Metadata profiles are platform/channel-specific (different synopsis lengths, artwork specs, rating displays per channel). Linking to channel enables channel-specific metadata delivery workflows and EP',
    `compliance_content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Metadata profiles delivered to distribution platforms (Netflix, Hulu, linear broadcast) must include certified content rating for parental control systems and regulatory display requirements. Links pr',
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.rating. Business justification: The metadata_profile table stores parental_guidance_notes as a free-text STRING but lacks a structured FK to the rating reference table. Adding content_rating_id -> content.rating.rating_id enables st',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Metadata profiles are version-specific (different metadata for theatrical vs broadcast version, localized versions). Links metadata delivery to specific version.',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: Platform-specific metadata profiles are validated against the specific asset_version being delivered to that platform. Platform delivery validation workflows require this link to confirm metadata comp',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: FAST channels, linear broadcast, and SVOD platforms have distinct metadata requirements (EPG metadata vs. on-demand metadata). metadata_profile already links to ott_platform; delivery_channel_id enabl',
    `genre_id` BIGINT COMMENT 'Foreign key linking to content.genre. Business justification: The metadata_profile table stores genre_classification as a free-text STRING column, which is a denormalization of the enterprise genre taxonomy. Adding genre_id FK to content.genre.genre_id normalize',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Metadata profiles are formatted for specific platform ingestion specs (Netflix TDF, iTunes XML, Roku feed). Each platform has unique metadata schema, image specs, and validation rules for content cata',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Metadata packages for platform delivery often include preview clips or thumbnail assets. Distribution systems require linking metadata profiles to their associated preview/promo assets for bundled del',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: Metadata profiles are created during the production-to-catalog handoff workflow, sourced from production episode records. Linking metadata_profile to production_episode enables production metadata han',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: Season-level metadata profiles are a standard deliverable for streaming platforms — each season has its own synopsis, artwork, and episode count metadata. The metadata_profile table stores season_numb',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Metadata profiles are delivered to platforms at multiple content hierarchy levels. Series-level metadata profiles (series synopsis, series artwork URLs, series genre) are routinely delivered to OTT pl',
    `title_id` BIGINT COMMENT 'Reference to the core content title for which this metadata profile is created. Links to the master title catalog.',
    `aspect_ratio` STRING COMMENT 'Visual aspect ratio of the content. Common values include 4:3 (standard definition), 16:9 (HD/widescreen), 21:9 (ultra-widescreen), 1.85:1, 2.39:1 (cinema formats).. Valid values are `4:3|16:9|21:9|1.85:1|2.39:1`',
    `audio_description_available` BOOLEAN COMMENT 'Indicates whether audio description (narration for visually impaired viewers) is available for this content. Used for accessibility compliance and platform requirements.',
    `audio_format` STRING COMMENT 'Audio format and channel configuration of the content. Examples: Stereo, 5.1 surround, 7.1 surround, Dolby Atmos, DTS:X, Mono.. Valid values are `Stereo|5.1|7.1|Dolby Atmos|DTS:X|Mono`',
    `cast_summary` STRING COMMENT 'Summarized list of principal cast members and their roles. Used for promotional materials and EPG (Electronic Program Guide) displays where full cast lists are impractical.',
    `closed_caption_available` BOOLEAN COMMENT 'Indicates whether closed captions (subtitles for the deaf and hard of hearing) are available for this content. Used for accessibility compliance and platform requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this metadata profile record was first created in the system. Used for audit trails and metadata lifecycle tracking.',
    `delivery_date` DATE COMMENT 'The date on which this metadata profile was delivered or published to the target platform. Used for tracking metadata distribution and compliance with delivery schedules.',
    `director_credit` STRING COMMENT 'Name(s) of the director(s) of the content. Used for attribution, promotional materials, and search/discovery.',
    `distributor` STRING COMMENT 'Name of the distributor responsible for delivering the content to platforms and audiences. Used for rights management and business intelligence.',
    `expiration_date` DATE COMMENT 'Date on which this metadata profile expires or is no longer valid for the target platform. Used for metadata lifecycle management and rights windowing.',
    `keyword_tags` STRING COMMENT 'Comma-separated list of keyword tags for content discovery, search indexing, and recommendation engines. Includes themes, topics, moods, and contextual descriptors.',
    `long_synopsis` STRING COMMENT 'Extended narrative description of the content title. Typically 200-500 words, used for detailed program guides, press releases, and promotional materials.',
    `metadata_language` STRING COMMENT 'ISO 639 language code (2 or 3 letters) with optional ISO 3166 country code for the language in which this metadata profile is written. Examples: en, en-US, fr, es-MX.. Valid values are `^[a-z]{2,3}(-[A-Z]{2})?$`',
    `metadata_standard` STRING COMMENT 'The metadata standard or schema used for this profile. Defines the structure and vocabulary of the metadata package.. Valid values are `EIDR|Dublin Core|EBUCore|TVAnytime|schema.org|MPEG-7`',
    `modified_by` STRING COMMENT 'User or system identifier of the person or process that last modified this metadata profile. Used for audit trails and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this metadata profile record was last modified. Used for audit trails, change tracking, and metadata version control.',
    `parental_guidance_notes` STRING COMMENT 'Detailed notes explaining the content rating, including specific content descriptors (violence, language, sexual content, etc.). Used for parental controls and compliance.',
    `platform_specific_code` STRING COMMENT 'Unique identifier assigned by the target platform for this metadata profile. Used for cross-referencing and reconciliation with external systems.',
    `poster_url` STRING COMMENT 'URL (Uniform Resource Locator) to the poster or cover art image associated with this metadata profile. Used for streaming platform UI, marketing, and promotional materials.',
    `production_company` STRING COMMENT 'Name of the production company or studio that produced the content. Used for rights attribution and promotional materials.',
    `profile_status` STRING COMMENT 'Current lifecycle status of the metadata profile. Indicates whether the profile is in draft, has been validated, is published to the target platform, rejected due to validation errors, archived, or expired.. Valid values are `draft|validated|published|rejected|archived|expired`',
    `promotional_tagline` STRING COMMENT 'Short, catchy promotional phrase or slogan used in marketing campaigns, social media, and advertising. Typically 10-30 words.',
    `runtime_minutes` STRING COMMENT 'Total runtime of the content in minutes. Used for scheduling, EPG (Electronic Program Guide) display, and audience planning.',
    `short_synopsis` STRING COMMENT 'Brief narrative description of the content title. Typically 50-150 words, used for EPG (Electronic Program Guide) listings, mobile apps, and quick reference.',
    `thumbnail_url` STRING COMMENT 'URL (Uniform Resource Locator) to the thumbnail image associated with this metadata profile. Used for EPG (Electronic Program Guide) display, streaming platform UI, and promotional materials.',
    `trailer_url` STRING COMMENT 'URL (Uniform Resource Locator) to the trailer or preview video associated with this content. Used for promotional campaigns and streaming platform previews.',
    `validation_errors` STRING COMMENT 'Detailed list of validation errors or warnings encountered during metadata quality checks. Used for troubleshooting and metadata remediation.',
    `validation_status` STRING COMMENT 'Result of automated or manual validation checks against the target metadata standard. Indicates whether the profile meets all required schema and business rules.. Valid values are `pending|passed|failed|warning`',
    `version_number` STRING COMMENT 'Version number of this metadata profile. Incremented with each update to track metadata evolution and support rollback if needed.',
    CONSTRAINT pk_metadata_profile PRIMARY KEY(`metadata_profile_id`)
) COMMENT 'Stores the full descriptive metadata set for a title as delivered to a specific platform or metadata standard — EPG, streaming platform, MVPD, search index, or press/publicity. Captures metadata standard (EIDR/Dublin Core/EBUCore/TVAnytime/schema.org), target platform, long synopsis, short synopsis, keyword tags, cast summary, director credit, production company, distributor, promotional tagline, metadata language, delivery date, and validation status. Enables platform-specific metadata packaging without polluting the core title master record.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`content`.`artwork` (
    `artwork_id` BIGINT COMMENT 'Unique identifier for the artwork asset record. Primary key for the artwork catalog.',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: Platform-specific artwork renditions (resized, reformatted for each platforms spec) are tracked as asset_versions. Artwork delivery and QC workflows require linking the artwork record to the specific',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: MPAA, BBFC, and other rating authorities mandate that promotional artwork display the official rating symbol from the certified compliance record. Rating display compliance audits require linking artw',
    `content_episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Episode-level artwork (episode thumbnail, episode still frame) is critical for streaming platform UX — each episode requires a thumbnail image for the content grid. The artwork table has title_id but ',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Artwork is often version-specific (theatrical poster vs TV key art, localized artwork with different ratings/text). Links artwork to the specific version it represents.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: Artwork usage is governed by rights grants covering photographer rights, studio artwork rights, and territory usage permissions. Artwork rights grant tracking is required for usage rights compliance a',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Artwork files (posters, thumbnails, key art) are managed media assets in DAM systems. Asset lifecycle management, storage tier assignment, and delivery workflows require linking artwork records to the',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: OTT platforms have distinct artwork specifications (dimensions, aspect ratios, format requirements). Platform-specific artwork management is a standard media operations workflow. artwork.ott_platform_',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Artwork rights clearance and licensing are managed per partner (copyright holder). This FK enables artwork rights compliance tracking and partner-level clearance reporting. copyright_holder is a denor',
    `project_id` BIGINT COMMENT 'Foreign key linking to production.project. Business justification: Key art and promotional artwork are commissioned as part of a production project. Production projects manage artwork briefs, approvals, and delivery. Artwork links to title and version but not the pro',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: Artwork is territory-specific (different poster art per territory); territory rights clearance and usage rights management require a proper FK. Artwork has territory_code as a denormalized plain attri',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: Season-level artwork (season poster, season banner) is a standard deliverable for streaming platforms — each season typically has its own promotional artwork. The artwork table has title_id but lacks ',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Artwork assets in broadcasting are created at multiple content hierarchy levels. Series-level artwork (series key art, series logo, series banner) is a distinct asset type used across all seasons and ',
    `title_id` BIGINT COMMENT 'Reference to the content title (series, film, episode, or other content asset) that this artwork represents. Links artwork to the master content catalog.',
    `approval_date` DATE COMMENT 'Date on which the artwork received final approval for distribution and use. Marks the transition from draft/review to production-ready status. Format: yyyy-MM-dd.',
    `approved_for_use_flag` BOOLEAN COMMENT 'Boolean indicator of whether the artwork has passed legal, brand, and creative approval processes and is authorized for public distribution. True indicates approved and ready for use, False indicates pending approval or rejected.',
    `archive_location` STRING COMMENT 'Physical or logical storage location identifier for the high-resolution master artwork file in the enterprise archive system. May reference tape library, cloud object storage bucket, or network-attached storage (NAS) path. Supports long-term preservation and disaster recovery.',
    `artwork_type` STRING COMMENT 'Classification of the artwork asset by its intended use and format. Key-art is primary promotional image, thumbnail for Electronic Program Guide (EPG) and streaming UI, banner for web headers, poster for theatrical/retail, logo for branding, still for scene captures.. Valid values are `key-art|thumbnail|banner|poster|logo|still`',
    `aspect_ratio` STRING COMMENT 'Proportional relationship between width and height of the artwork. 16:9 for widescreen HD, 4:3 for standard definition, 1:1 for square social media, 2:3 for portrait poster, 3:4 for mobile portrait, 21:9 for ultra-widescreen, 9:16 for vertical mobile video. [ENUM-REF-CANDIDATE: 16:9|4:3|1:1|2:3|3:4|21:9|9:16 — 7 candidates stripped; promote to reference product]',
    `color_profile` STRING COMMENT 'Color space standard applied to the artwork for accurate color reproduction across devices and platforms. sRGB for web/digital, Adobe RGB for professional photography, CMYK for print, Rec. 709 for HD broadcast, Rec. 2020 for Ultra HD (UHD) broadcast.. Valid values are `sRGB|Adobe RGB|ProPhoto RGB|CMYK|Rec. 709|Rec. 2020`',
    `content_rating_displayed_flag` BOOLEAN COMMENT 'Boolean indicator of whether the artwork includes a visible Motion Picture Association (MPA) or equivalent content rating badge (G, PG, PG-13, R, NC-17, TV-Y, TV-PG, TV-14, TV-MA). True indicates rating is burned into the image, False indicates clean artwork without rating overlay.',
    `copyright_year` STRING COMMENT 'Year in which the artwork was created and copyright was established. Used for copyright notice display and rights duration calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the artwork record was first created in the enterprise catalog system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and data lineage tracking.',
    `eidr` STRING COMMENT 'Universal unique identifier from the Entertainment Identifier Registry for the associated content title. Enables global interoperability and metadata exchange across distribution partners, rights holders, and platforms.. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `expiry_date` DATE COMMENT 'Date on which the artwork rights or usage authorization expires and the asset should no longer be used for promotional or distribution purposes. Supports rights management and holdback compliance. Nullable for perpetual-use artwork. Format: yyyy-MM-dd.',
    `file_format` STRING COMMENT 'Image file format of the artwork asset. JPEG for compressed photos, PNG for transparency support, TIFF for high-resolution archival, PSD for Adobe Photoshop source files, SVG for vector graphics, WebP for modern web delivery.. Valid values are `JPEG|PNG|TIFF|PSD|SVG|WebP`',
    `file_size_bytes` BIGINT COMMENT 'Storage size of the artwork file measured in bytes. Used for Content Delivery Network (CDN) optimization, bandwidth planning, and storage capacity management.',
    `height_pixels` STRING COMMENT 'Vertical dimension of the artwork image measured in pixels. Used to determine display suitability and resolution quality for various distribution channels.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the language of any text overlay or localization present in the artwork. Used for multi-territory distribution and localization workflows.. Valid values are `^[a-z]{2}$`',
    `language_overlay_flag` BOOLEAN COMMENT 'Boolean indicator of whether the artwork contains burned-in text, titles, or language-specific graphic elements. True indicates localized artwork requiring territory-specific versions, False indicates language-neutral artwork suitable for all markets.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the artwork record was last updated or modified in the enterprise catalog system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for change tracking and synchronization workflows.',
    `photographer_credit` STRING COMMENT 'Name or attribution of the photographer, artist, or creative agency responsible for creating the artwork. Used for copyright attribution, residuals tracking, and legal compliance with talent agreements.',
    `priority_rank` STRING COMMENT 'Numeric ranking indicating the preferred display order or priority of this artwork when multiple artwork assets exist for the same title and type. Lower numbers indicate higher priority. Used by Electronic Program Guide (EPG) and streaming platform UI to select the primary artwork.',
    `resolution_dpi` STRING COMMENT 'Image resolution measured in dots per inch. 72 DPI for web/screen display, 300 DPI for high-quality print, 150 DPI for standard print. Critical for determining print suitability and image quality.',
    `source_system` STRING COMMENT 'Originating system or platform from which the artwork asset was ingested into the enterprise Media Asset Management (MAM) catalog. Dalet Galaxy for internal DAM, Adobe Experience Platform for digital marketing assets, Internal Studio for in-house creative, External Agency for third-party creative services, Vendor Portal for distributor-provided assets.. Valid values are `Dalet Galaxy|Adobe Experience Platform|Internal Studio|External Agency|Vendor Portal`',
    `source_system_code` STRING COMMENT 'Unique identifier or reference key for the artwork asset in the originating source system. Enables traceability and synchronization with upstream Digital Asset Management (DAM) or creative management platforms.',
    `title` STRING COMMENT 'Human-readable descriptive title or label for the artwork asset. Used for internal cataloging and search within the Media Asset Management (MAM) system.',
    `usage_rights` STRING COMMENT 'Scope of authorized usage channels and media types for the artwork. All-media for unrestricted use, digital-only for Over-The-Top (OTT) and web, print-only for press kits and retail, broadcast-only for linear television, theatrical-only for cinema, promotional-only for advertising and marketing campaigns.. Valid values are `all-media|digital-only|print-only|broadcast-only|theatrical-only|promotional-only`',
    `width_pixels` STRING COMMENT 'Horizontal dimension of the artwork image measured in pixels. Used to determine display suitability and resolution quality for various distribution channels.',
    CONSTRAINT pk_artwork PRIMARY KEY(`artwork_id`)
) COMMENT 'Master catalog of promotional and editorial artwork assets associated with a title — key art, thumbnail images, banner graphics, poster images, and logo treatments. Captures artwork type (key-art/thumbnail/banner/poster/logo/still), image dimensions, aspect ratio, file format, color profile, territory applicability, language overlay flag, approved-for-use flag, approval date, expiry date, and source system reference (Dalet Galaxy DAM). Supports EPG display, streaming platform UI, press kits, and advertising creative without duplicating the binary asset record owned by the digital asset domain.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`content`.`tag` (
    `tag_id` BIGINT COMMENT 'Primary key for tag',
    `content_episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Episode-level tagging is essential for content discovery and recommendation in streaming platforms — individual episodes may have unique tags (e.g., season finale, guest star: [name], clip-worthy',
    `parent_tag_id` BIGINT COMMENT 'Reference to a parent tag in a hierarchical taxonomy structure. Enables multi-level tag classification (e.g., Action as parent, Car Chase as child). Null for top-level tags.',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Editorial and operational tags are applied at multiple content hierarchy levels. Series-level tags (e.g., binge-worthy, award-winning, franchise) are used for content discovery, recommendation e',
    `title_id` BIGINT COMMENT 'Reference to the content title (film, series, episode, clip, music track, news segment, or live event) to which this tag is applied.',
    `advertiser_safe` BOOLEAN COMMENT 'Indicates whether content with this tag is suitable for advertising placement according to brand safety guidelines. False may indicate sensitive or controversial content that requires restricted ad inventory.',
    `applied_date` DATE COMMENT 'Date when the tag was first applied to the content asset. Tracks the temporal evolution of content metadata and editorial curation.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Confidence level for algorithmically-generated tags, expressed as a decimal between 0.0000 and 1.0000. A score of 1.0000 indicates highest confidence. Null for manually-applied editorial tags.',
    `coppa_compliant` BOOLEAN COMMENT 'Indicates whether this tag and its associated content comply with COPPA regulations for childrens content. True indicates the tag is appropriate for content directed at children under 13.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tag record was first created in the system. Supports audit trails and data lineage tracking.',
    `expiry_date` DATE COMMENT 'Date when the tag assignment expires or is no longer valid. Used for time-bound campaign tags, seasonal collections, or promotional initiatives. Null for permanent tags.',
    `hierarchy_level` STRING COMMENT 'Depth level of this tag within a hierarchical taxonomy structure. Level 1 represents top-level categories, with increasing numbers indicating deeper nesting. Supports faceted navigation and drill-down discovery.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the tag is currently active and should be used in content discovery, recommendation engines, and advertising contextual targeting. False indicates the tag has been deprecated or removed.',
    `is_displayable` BOOLEAN COMMENT 'Indicates whether this tag should be displayed to end users in content detail pages, Electronic Program Guides (EPG), or Over-The-Top (OTT) platform interfaces. Some tags are for backend analytics only.',
    `is_searchable` BOOLEAN COMMENT 'Indicates whether this tag should be indexed and surfaced in user-facing search interfaces. Some tags may be used for internal classification or algorithmic purposes only.',
    `language` STRING COMMENT 'ISO 639-2/T three-letter language code indicating the language in which the tag value is expressed. Supports multilingual tagging for international content catalogs.. Valid values are `^[A-Z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this tag record was last modified. Tracks the evolution of tag metadata and supports change data capture processes.',
    `review_date` DATE COMMENT 'Date when the tag assignment was reviewed by editorial staff. Null if no review has occurred.',
    `review_notes` STRING COMMENT 'Free-text notes or comments from the editorial reviewer regarding the tag assignment. May include rationale for approval or rejection, suggested alternatives, or quality feedback.',
    `review_status` STRING COMMENT 'Editorial review and approval status for the tag assignment. Supports quality control workflows where algorithmically-generated or partner-supplied tags require human validation before publication.. Valid values are `pending|approved|rejected|under_review`',
    `tag_source` STRING COMMENT 'Origin of the tag assignment. Indicates whether the tag was applied by internal editorial staff, generated by machine learning algorithms, provided by a content partner or rights holder, contributed by users, or supplied by the production team.. Valid values are `editorial|algorithmic|partner|user_generated|rights_holder|production`',
    `tag_type` STRING COMMENT 'Category of the tag applied to the content. Defines the semantic purpose of the tag (e.g., mood for emotional tone, theme for subject matter, setting for location context, era for time period, franchise for brand universe, content_warning for viewer advisories, editorial_collection for curated groupings, campaign for promotional initiatives). [ENUM-REF-CANDIDATE: mood|theme|setting|era|franchise|universe|content_warning|editorial_collection|campaign|keyword — 10 candidates stripped; promote to reference product]',
    `tag_value` DECIMAL(18,2) COMMENT 'The specific controlled vocabulary term or label applied to the content. Examples: suspenseful, family-friendly, urban, 1980s, Marvel Cinematic Universe, violence, holiday-special, summer-blockbuster.',
    `taxonomy_version` STRING COMMENT 'Version number of the external taxonomy or controlled vocabulary system referenced by taxonomy_id. Tracks schema evolution and ensures backward compatibility.',
    `usage_context` STRING COMMENT 'Primary business context or application domain for which this tag is intended. Defines how the tag should be leveraged across the content lifecycle (e.g., recommendation engines, contextual advertising targeting, editorial curation, regulatory compliance reporting).. Valid values are `recommendation|search|advertising|editorial|analytics|compliance`',
    `weight` DECIMAL(18,2) COMMENT 'Relative importance or prominence of this tag for the content asset, expressed as a decimal between 0.0000 and 1.0000. Higher weights indicate more central or defining characteristics. Used to prioritize tags in recommendation and discovery algorithms.',
    CONSTRAINT pk_tag PRIMARY KEY(`tag_id`)
) COMMENT 'Flexible editorial and operational tagging of titles with controlled vocabulary terms beyond genre — mood, theme, setting, era, franchise, universe, content warning, editorial collection, and campaign tag. Each record captures tag type, tag value, tag source (editorial/algorithmic/partner), confidence score for algorithmic tags, applied date, and active status. Powers content discovery, recommendation engines, advertising contextual targeting, and editorial curation across OTT and linear platforms.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`content`.`package` (
    `package_id` BIGINT COMMENT 'Primary key for package',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Content packages are licensed and distributed to specific channels. Linking package to channel enables channel-level content package management, carriage fee reporting, and channel programming invento',
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.rating. Business justification: Packages have content rating (highest rating of included titles). Normalizes content_rating string column to reference the enterprise rating taxonomy.',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Content packages are distributed through specific delivery channels (e.g., a FAST channel bundle, a linear carriage package). package already links to ott_platform; delivery_channel_id enables channel',
    `distribution_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.distribution_agreement. Business justification: A content package is assembled to fulfill a specific distribution agreement, governing rights scope, territory, and fee structure. This link is required for contract compliance reporting and revenue r',
    `distribution_partner_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_partner. Business justification: Packages are sold to distribution partners (cable operators, MVPD aggregators, international distributors). Package-level licensing agreements and carriage fees are negotiated at partner level for bul',
    `genre_id` BIGINT COMMENT 'Foreign key linking to content.genre. Business justification: Packages have primary genre classification. Normalizes genre_primary string column to reference the enterprise genre taxonomy.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: Content packages are authorized for distribution by rights grants. Rights grant validation for package distribution is required for rights compliance and exploitation authorization in content licensin',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Content packages are offered by specific legal entities, especially for international distribution by subsidiaries. Required for intercompany revenue reporting and ensuring the correct legal entity is',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Content packages (e.g., Summer Action Bundle, Kids Library) are licensed as units to distributors. Package-level royalty calculations and clearance workflows require linking packages to their gove',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Content packages delivered to distributors have a package-level manifest or preview reel as a media asset. Content operations teams track this asset for delivery confirmation, QC, and distributor acce',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Content packages are sold as bundled offerings in syndication, international distribution, and SVOD licensing. Real business process: package-level deal tracking where multiple titles are sold togethe',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Content packages (bundles, collections) are licensed to specific platforms. Package-level deals are common in SVOD (entire studio catalog to Netflix) and require platform-specific availability trackin',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Content packages (bundles sold to distributors/platforms) represent distinct revenue streams with specific recognition patterns. Package deals require revenue allocation across titles and performance ',
    `holder_id` BIGINT COMMENT 'Foreign key linking to rights.holder. Business justification: Packages have a rights holder governing royalty and clearance obligations. Package has rights_holder as a denormalized plain text attribute. Proper FK to holder master is required for royalty manageme',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: Content packages are scoped to specific territories for distribution. Territory-scoped package rights management and distribution clearance require a proper FK to rights_territory. Package has territo',
    `audio_description_available_flag` BOOLEAN COMMENT 'Indicates whether audio description tracks are available for the majority of content in the package (True/False). Required for accessibility compliance.',
    `closed_caption_available_flag` BOOLEAN COMMENT 'Indicates whether closed captioning is available for the majority of content in the package (True/False). Required for FCC compliance and accessibility standards.',
    `commercial_context` STRING COMMENT 'Free-text description of the business purpose or deal context for which the package was assembled, such as upfront sales event, scatter market offering, MVPD (Multichannel Video Programming Distributor) carriage negotiation, or international syndication deal.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the package record was first created in the system. Used for audit trail and data lineage.',
    `drm_required_flag` BOOLEAN COMMENT 'Indicates whether Digital Rights Management (DRM) protection is required for distribution of this package (True/False). Critical for rights enforcement and anti-piracy compliance.',
    `effective_date` DATE COMMENT 'The date from which the package becomes available for distribution or licensing. Marks the start of the packages commercial availability window.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the package is offered on an exclusive basis to a single distributor or platform (True) or is available for non-exclusive multi-platform distribution (False). Critical for rights and holdback management.',
    `expiry_date` DATE COMMENT 'The date on which the package ceases to be available for distribution or licensing. Nullable for open-ended packages. Defines the end of the windowing or holdback period.',
    `hd_available_flag` BOOLEAN COMMENT 'Indicates whether the package content is available in high-definition (HD) format (True/False). Used for distribution planning and quality assurance.',
    `keywords` STRING COMMENT 'Comma-separated list of keywords or tags associated with the package for search, discovery, and recommendation purposes.',
    `language_primary` STRING COMMENT 'The primary language of the content in the package, expressed as ISO 639-2 three-letter language code (e.g., eng, spa, fra). Critical for localization and international distribution.',
    `modified_by` STRING COMMENT 'The username or identifier of the user or system that last modified the package record. Used for change accountability and audit trail.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the package record was last modified. Used for change tracking and audit compliance.',
    `package_code` STRING COMMENT 'The externally-known unique business identifier or code for the package used in contracts, invoicing, and distribution systems.',
    `package_description` STRING COMMENT 'A detailed narrative description of the package content, target audience, and commercial positioning. Used for marketing, sales proposals, and catalog listings.',
    `package_name` STRING COMMENT 'The business name or title of the content package as recognized in commercial agreements and distribution deals.',
    `package_status` STRING COMMENT 'Current lifecycle status of the package: draft (under construction), active (available for distribution), suspended (temporarily unavailable), expired (past effective period), terminated (cancelled before expiry), or archived (historical record).. Valid values are `draft|active|suspended|expired|terminated|archived`',
    `package_type` STRING COMMENT 'The classification of the package based on its commercial or distribution purpose: syndication (content resale to multiple outlets), SVOD (Subscription Video On Demand) library (subscription-based catalog), AVOD (Advertising-Supported Video On Demand) catalog (ad-supported offering), FAST (Free Ad-Supported Streaming Television) channel (linear streaming channel), educational (academic or training content bundle), or international (cross-border distribution bundle).. Valid values are `syndication|svod-library|avod-catalog|fast-channel|educational|international`',
    `territory_scope` STRING COMMENT 'Geographic territories or markets where the package is licensed for distribution, expressed as comma-separated ISO 3166-1 alpha-3 country codes or regional groupings (e.g., USA, GBR, CAN or EMEA, APAC). Defines the carriage or clearance geography.',
    `thumbnail_url` STRING COMMENT 'The URL or path to the thumbnail image representing the package in catalogs, EPG (Electronic Program Guide) listings, and user interfaces.',
    `total_runtime_hours` DECIMAL(18,2) COMMENT 'The aggregate runtime of all content in the package, expressed in hours. Used for programming and scheduling calculations.',
    `total_title_count` STRING COMMENT 'The total number of distinct titles (episodes, films, clips, or other content assets) included in the package. Used for inventory reporting and deal valuation.',
    `uhd_4k_available_flag` BOOLEAN COMMENT 'Indicates whether the package content is available in ultra-high-definition 4K format (True/False). Used for premium distribution and OTT platform requirements.',
    `value_usd` DECIMAL(18,2) COMMENT 'The estimated or contracted commercial value of the package in United States Dollars (USD). Used for revenue forecasting, deal valuation, and financial reporting.',
    CONSTRAINT pk_package PRIMARY KEY(`package_id`)
) COMMENT 'Defines a curated bundle of titles assembled for a specific commercial or distribution purpose — a syndication package, SVOD library deal, MVPD carriage bundle, or FAST channel lineup. Captures package name, package type (syndication/svod-library/avod-catalog/fast-channel/educational/international), package status, effective date, expiry date, territory scope, exclusivity flag, and the commercial context it was assembled for. Acts as the content-side counterpart to distribution and rights deal structures.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`content`.`title_relationship` (
    `title_relationship_id` BIGINT COMMENT 'Unique identifier for the title relationship record. Primary key.',
    `parent_title_relationship_id` BIGINT COMMENT 'Self-referencing FK on title_relationship (parent_title_relationship_id)',
    `title_id` BIGINT COMMENT 'The originating content title in the relationship. References the title that serves as the starting point of the relationship (e.g., the original film in a sequel relationship, the parent series in a spin-off).',
    `target_title_id` BIGINT COMMENT 'The destination content title in the relationship. References the title that is the result or endpoint of the relationship (e.g., the sequel film, the spin-off series, the remake).',
    `bidirectional_flag` BOOLEAN COMMENT 'Indicates whether the relationship should be surfaced in both directions (e.g., show sequel on original AND show original on sequel). True for symmetric relationships like franchise siblings or crossovers, false for asymmetric relationships like clip-of or compilation.',
    `canonical_order` STRING COMMENT 'The sequence position of the target title within a series or franchise when viewed in canonical order (e.g., Episode IV is canonical_order 4 in Star Wars franchise). Null for non-sequential relationships like remakes or crossovers.',
    `chronological_order` STRING COMMENT 'The sequence position of the target title when viewed in story chronological order (e.g., Episode I is chronological_order 1 in Star Wars despite being released later). Null for non-sequential relationships.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this relationship record was first created in the system. Supports audit trail and data lineage tracking.',
    `display_priority` STRING COMMENT 'Numeric ranking (lower numbers = higher priority) controlling the order in which related titles are displayed in user interfaces, Electronic Program Guides (EPG), and recommendation carousels. Enables editorial control over content discovery presentation.',
    `editorial_notes` STRING COMMENT 'Free-text notes from content editors or curators explaining the nature, context, or nuances of the relationship. May include information about shared characters, plot connections, or reasons for the relationship classification.',
    `effective_date` DATE COMMENT 'The date when this relationship became valid and should be recognized by content discovery, recommendation engines, and editorial systems. Typically aligns with the target titles release or announcement date.',
    `expiration_date` DATE COMMENT 'The date when this relationship is no longer valid or should no longer be surfaced in content discovery. Null for permanent relationships. Used when relationships are time-bound due to rights, promotional windows, or editorial decisions.',
    `external_reference_code` STRING COMMENT 'Identifier for this relationship in an external system or metadata provider (e.g., EIDR relationship ID, ISAN linkage ID, third-party content graph ID). Enables cross-system reconciliation and metadata enrichment.',
    `franchise_name` STRING COMMENT 'The overarching franchise or intellectual property umbrella that both source and target titles belong to (e.g., Marvel Cinematic Universe, Star Trek, Law & Order). Enables franchise-level content discovery and curation.',
    `modified_by` STRING COMMENT 'Identifier or name of the user, system, or process that last modified this relationship record. Supports audit trail and change management.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this relationship record was last updated or modified. Supports change tracking and audit trail.',
    `platform_visibility` STRING COMMENT 'Comma-separated list of platforms or distribution channels where this relationship should be surfaced (e.g., OTT, Linear, SVOD, AVOD, FAST). Enables platform-specific content discovery strategies. Empty or null indicates visibility across all platforms.',
    `recommendation_weight` DECIMAL(18,2) COMMENT 'Numeric weight (0.00 to 100.00) indicating the priority or relevance of this relationship for recommendation engine algorithms. Higher weights indicate stronger recommendation signals. Used to tune content discovery and auto-play sequences.',
    `relationship_direction` STRING COMMENT 'Indicates the directionality of the relationship. Forward means source points to target, reverse means target points back to source, bidirectional means the relationship is mutual and non-hierarchical (e.g., franchise siblings).. Valid values are `forward|reverse|bidirectional`',
    `relationship_status` STRING COMMENT 'Current lifecycle status of the relationship. Active relationships are live and used by recommendation engines. Pending relationships are scheduled but not yet effective. Inactive relationships are temporarily disabled. Deprecated relationships are historical and no longer relevant.. Valid values are `active|inactive|pending|deprecated`',
    `relationship_strength` STRING COMMENT 'Indicates the strength or importance of the relationship for content discovery and recommendation purposes. Primary relationships are direct and essential (e.g., direct sequel), secondary are significant but less direct (e.g., shared universe), tertiary are weak connections (e.g., cameo appearance), tangential are loosely related (e.g., similar theme).. Valid values are `primary|secondary|tertiary|tangential`',
    `relationship_type` STRING COMMENT 'The nature of the relationship between the source and target titles. Defines how the two content assets are connected (e.g., sequel indicates target follows source chronologically, spin-off indicates target derives characters/universe from source, remake indicates target is a new version of source). [ENUM-REF-CANDIDATE: sequel|prequel|remake|reboot|spin-off|compilation|clip-of|franchise-sibling|crossover|adaptation|parody|documentary-of|behind-the-scenes — promote to reference product]. Valid values are `sequel|prequel|remake|reboot|spin-off|compilation`',
    `release_order` STRING COMMENT 'The sequence position of the target title in the order of original release or premiere dates within the franchise or relationship set. Supports viewing content in historical release sequence.',
    `source_system` STRING COMMENT 'The originating system or platform that created or asserted this relationship (e.g., Dalet Galaxy, manual editorial curation, third-party metadata provider). Supports data lineage and troubleshooting.',
    `territory_scope` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes indicating the geographic territories where this relationship is valid and should be surfaced. Supports rights-aware content discovery. Empty or null indicates global applicability.',
    `verification_date` DATE COMMENT 'The date when this relationship was verified or last reviewed for accuracy. Null for unverified relationships. Enables periodic re-verification workflows.',
    `verification_status` STRING COMMENT 'Indicates whether the relationship has been verified by editorial staff or subject matter experts. Verified relationships have been confirmed accurate, unverified are system-generated or user-submitted, disputed have conflicting information, pending_review are queued for editorial review.. Valid values are `verified|unverified|disputed|pending_review`',
    `verified_by` STRING COMMENT 'Name or identifier of the user, editor, or system that verified the accuracy of this relationship. Null for unverified relationships. Supports audit trail and quality assurance.',
    `created_by` STRING COMMENT 'Identifier or name of the user, system, or process that created this relationship record. Supports audit trail and accountability.',
    CONSTRAINT pk_title_relationship PRIMARY KEY(`title_relationship_id`)
) COMMENT 'Defines typed relationships between content assets — remakes, sequels, prequels, spin-offs, compilations, clip-parent associations, franchise linkages, and cross-promotional pairings. Captures source title, target title, relationship type (sequel/prequel/remake/spin-off/compilation/clip-of/franchise-sibling/crossover), relationship direction, canonical order, effective date, and active status. Supports content discovery, recommendation engines, franchise management, and editorial curation across linear and OTT platforms.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`content`.`package_title` (
    `package_title_id` BIGINT COMMENT 'Primary key uniquely identifying each package-title inclusion record',
    `package_id` BIGINT COMMENT 'Foreign key linking to the content package that contains the title',
    `title_id` BIGINT COMMENT 'Foreign key linking to the title included in the package',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this package-title inclusion record was first created in the system, used for audit trail',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this specific title is offered exclusively within this package (may differ from package-level exclusivity), used for rights management and competitive positioning',
    `inclusion_date` DATE COMMENT 'The date when this specific title was added to the package, used for tracking package evolution and content refresh cycles',
    `inclusion_status` STRING COMMENT 'Current lifecycle status of this title within the package: active (currently included), pending (scheduled for inclusion), removed (manually excluded), expired (rights expired). Used for package content management.',
    `modified_by` STRING COMMENT 'Username or identifier of the user or system that last modified this inclusion record',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this package-title inclusion record was last modified, used for change tracking',
    `price_contribution_amount` DECIMAL(18,2) COMMENT 'The allocated or attributed pricing value of this title within the package bundle, used for revenue allocation and package valuation',
    `removal_date` DATE COMMENT 'The date when this title was removed from the package, null if still active. Used for tracking package content changes and rights expiration.',
    `sequence_number` STRING COMMENT 'The ordinal position or sequence of this title within the package, used for playlist ordering in FAST channels or presentation order in catalogs',
    CONSTRAINT pk_package_title PRIMARY KEY(`package_title_id`)
) COMMENT 'This association product represents the inclusion of a specific title within a content package. It captures the commercial and operational terms under which each title is bundled into a package for distribution or licensing. Each record links one package to one title with attributes that exist only in the context of this specific inclusion relationship, such as sequencing, pricing contribution, and inclusion status.. Existence Justification: In media broadcasting operations, content packages are explicitly curated bundles containing multiple titles (films, series, episodes), and individual titles routinely appear across multiple packages simultaneously (e.g., a blockbuster film may be included in a premium SVOD library package, a syndication package for international markets, and a FAST channel lineup). The business actively manages these inclusions as operational records, tracking which titles are in which packages with specific commercial terms, sequencing, and pricing contributions.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ADD CONSTRAINT `fk_content_title_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `media_broadcasting_ecm`.`content`.`genre`(`genre_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ADD CONSTRAINT `fk_content_title_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ADD CONSTRAINT `fk_content_series_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `media_broadcasting_ecm`.`content`.`rating`(`rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ADD CONSTRAINT `fk_content_series_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `media_broadcasting_ecm`.`content`.`genre`(`genre_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ADD CONSTRAINT `fk_content_season_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `media_broadcasting_ecm`.`content`.`rating`(`rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ADD CONSTRAINT `fk_content_season_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `media_broadcasting_ecm`.`content`.`genre`(`genre_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ADD CONSTRAINT `fk_content_season_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ADD CONSTRAINT `fk_content_season_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ADD CONSTRAINT `fk_content_content_episode_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `media_broadcasting_ecm`.`content`.`rating`(`rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ADD CONSTRAINT `fk_content_content_episode_season_id` FOREIGN KEY (`season_id`) REFERENCES `media_broadcasting_ecm`.`content`.`season`(`season_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ADD CONSTRAINT `fk_content_content_episode_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ADD CONSTRAINT `fk_content_content_episode_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `media_broadcasting_ecm`.`content`.`genre`(`genre_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ADD CONSTRAINT `fk_content_content_episode_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ADD CONSTRAINT `fk_content_version_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `media_broadcasting_ecm`.`content`.`rating`(`rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ADD CONSTRAINT `fk_content_version_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ADD CONSTRAINT `fk_content_genre_parent_genre_id` FOREIGN KEY (`parent_genre_id`) REFERENCES `media_broadcasting_ecm`.`content`.`genre`(`genre_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ADD CONSTRAINT `fk_content_localization_version_id` FOREIGN KEY (`version_id`) REFERENCES `media_broadcasting_ecm`.`content`.`version`(`version_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`talent_credit` ADD CONSTRAINT `fk_content_talent_credit_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `media_broadcasting_ecm`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`talent_credit` ADD CONSTRAINT `fk_content_talent_credit_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_version_id` FOREIGN KEY (`version_id`) REFERENCES `media_broadcasting_ecm`.`content`.`version`(`version_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_season_id` FOREIGN KEY (`season_id`) REFERENCES `media_broadcasting_ecm`.`content`.`season`(`season_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ADD CONSTRAINT `fk_content_acquisition_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_acquisition_id` FOREIGN KEY (`acquisition_id`) REFERENCES `media_broadcasting_ecm`.`content`.`acquisition`(`acquisition_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `media_broadcasting_ecm`.`content`.`rating`(`rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_version_id` FOREIGN KEY (`version_id`) REFERENCES `media_broadcasting_ecm`.`content`.`version`(`version_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_season_id` FOREIGN KEY (`season_id`) REFERENCES `media_broadcasting_ecm`.`content`.`season`(`season_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ADD CONSTRAINT `fk_content_windowing_plan_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `media_broadcasting_ecm`.`content`.`rating`(`rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_version_id` FOREIGN KEY (`version_id`) REFERENCES `media_broadcasting_ecm`.`content`.`version`(`version_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `media_broadcasting_ecm`.`content`.`genre`(`genre_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_season_id` FOREIGN KEY (`season_id`) REFERENCES `media_broadcasting_ecm`.`content`.`season`(`season_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ADD CONSTRAINT `fk_content_metadata_profile_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `media_broadcasting_ecm`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_version_id` FOREIGN KEY (`version_id`) REFERENCES `media_broadcasting_ecm`.`content`.`version`(`version_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_season_id` FOREIGN KEY (`season_id`) REFERENCES `media_broadcasting_ecm`.`content`.`season`(`season_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ADD CONSTRAINT `fk_content_artwork_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ADD CONSTRAINT `fk_content_tag_content_episode_id` FOREIGN KEY (`content_episode_id`) REFERENCES `media_broadcasting_ecm`.`content`.`content_episode`(`content_episode_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ADD CONSTRAINT `fk_content_tag_parent_tag_id` FOREIGN KEY (`parent_tag_id`) REFERENCES `media_broadcasting_ecm`.`content`.`tag`(`tag_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ADD CONSTRAINT `fk_content_tag_series_id` FOREIGN KEY (`series_id`) REFERENCES `media_broadcasting_ecm`.`content`.`series`(`series_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ADD CONSTRAINT `fk_content_tag_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ADD CONSTRAINT `fk_content_package_rating_id` FOREIGN KEY (`rating_id`) REFERENCES `media_broadcasting_ecm`.`content`.`rating`(`rating_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ADD CONSTRAINT `fk_content_package_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `media_broadcasting_ecm`.`content`.`genre`(`genre_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ADD CONSTRAINT `fk_content_title_relationship_parent_title_relationship_id` FOREIGN KEY (`parent_title_relationship_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title_relationship`(`title_relationship_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ADD CONSTRAINT `fk_content_title_relationship_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ADD CONSTRAINT `fk_content_title_relationship_target_title_id` FOREIGN KEY (`target_title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`package_title` ADD CONSTRAINT `fk_content_package_title_package_id` FOREIGN KEY (`package_id`) REFERENCES `media_broadcasting_ecm`.`content`.`package`(`package_id`);
ALTER TABLE `media_broadcasting_ecm`.`content`.`package_title` ADD CONSTRAINT `fk_content_package_title_title_id` FOREIGN KEY (`title_id`) REFERENCES `media_broadcasting_ecm`.`content`.`title`(`title_id`);

-- ========= TAGS =========
ALTER SCHEMA `media_broadcasting_ecm`.`content` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `media_broadcasting_ecm`.`content` SET TAGS ('dbx_domain' = 'content');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` SET TAGS ('dbx_subdomain' = 'asset_catalog');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Identifier');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `distribution_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `genre_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Master Media Asset Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Rights Holder Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Territory Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Identifier');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Content Acquisition Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `archive_date` SET TAGS ('dbx_business_glossary_term' = 'Archive Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_value_regex' = '4:3|16:9|21:9|1.85:1|2.39:1');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `audio_description_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Available Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `closed_caption_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Available Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `color_format` SET TAGS ('dbx_business_glossary_term' = 'Color Format');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `color_format` SET TAGS ('dbx_value_regex' = 'color|black_and_white|colorized');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Motion Picture Association (MPA) Content Rating');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `content_status` SET TAGS ('dbx_business_glossary_term' = 'Content Lifecycle Status');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `content_status` SET TAGS ('dbx_value_regex' = 'active|archived|restricted|pending|expired|withdrawn');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `coppa_child_directed_flag` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Child-Directed Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Code');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `eidr_code` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) Identifier');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `eidr_code` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `episode_number` SET TAGS ('dbx_business_glossary_term' = 'Episode Number');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `hd_available_flag` SET TAGS ('dbx_business_glossary_term' = 'High Definition (HD) Available Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `isan` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `isan` SET TAGS ('dbx_value_regex' = '^ISAN [A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `isrc` SET TAGS ('dbx_business_glossary_term' = 'International Standard Recording Code (ISRC)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `isrc` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Content Keywords');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `original_language` SET TAGS ('dbx_business_glossary_term' = 'Original Language Code');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `original_language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `original_title` SET TAGS ('dbx_business_glossary_term' = 'Original Title Name');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `parental_advisory_flag` SET TAGS ('dbx_business_glossary_term' = 'Parental Advisory Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `premiere_flag` SET TAGS ('dbx_business_glossary_term' = 'Premiere Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `production_year` SET TAGS ('dbx_business_glossary_term' = 'Production Year');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Original Release Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `rights_status` SET TAGS ('dbx_business_glossary_term' = 'Rights Availability Status');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `rights_status` SET TAGS ('dbx_value_regex' = 'available|restricted|expired|pending_clearance|blackout');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `runtime_seconds` SET TAGS ('dbx_business_glossary_term' = 'Runtime in Seconds');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `season_number` SET TAGS ('dbx_business_glossary_term' = 'Season Number');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `sub_genre` SET TAGS ('dbx_business_glossary_term' = 'Sub-Genre Classification');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_business_glossary_term' = 'Long Synopsis');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_business_glossary_term' = 'Short Synopsis');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `theatrical_release_flag` SET TAGS ('dbx_business_glossary_term' = 'Theatrical Release Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `title_name` SET TAGS ('dbx_business_glossary_term' = 'Title Name');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `uhd_4k_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Ultra High Definition (UHD) 4K Available Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` SET TAGS ('dbx_subdomain' = 'asset_catalog');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Rights Holder Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `archive_location` SET TAGS ('dbx_business_glossary_term' = 'Archive Location');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_value_regex' = '16:9|4:3|21:9|2.39:1|1.85:1');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Available');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `audio_format` SET TAGS ('dbx_business_glossary_term' = 'Audio Format');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `audio_format` SET TAGS ('dbx_value_regex' = 'stereo|surround_5_1|surround_7_1|dolby_atmos|dts_x');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Available');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `eidr_code` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) Identifier');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `eidr_code` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `episode_runtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Episode Runtime Minutes');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `finale_date` SET TAGS ('dbx_business_glossary_term' = 'Finale Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `franchise_name` SET TAGS ('dbx_business_glossary_term' = 'Franchise Name');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `hdr_format` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Format');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `hdr_format` SET TAGS ('dbx_value_regex' = 'SDR|HDR10|HDR10_PLUS|DOLBY_VISION|HLG');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `isan_code` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `isan_code` SET TAGS ('dbx_value_regex' = '^ISAN [A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `language_original` SET TAGS ('dbx_business_glossary_term' = 'Original Language');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `language_original` SET TAGS ('dbx_value_regex' = '^[a-z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `original_network` SET TAGS ('dbx_business_glossary_term' = 'Original Network');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `premiere_date` SET TAGS ('dbx_business_glossary_term' = 'Premiere Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `resolution_standard` SET TAGS ('dbx_business_glossary_term' = 'Resolution Standard');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `resolution_standard` SET TAGS ('dbx_value_regex' = 'SD|HD|FHD|UHD|4K|8K');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `series_status` SET TAGS ('dbx_business_glossary_term' = 'Series Status');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `series_status` SET TAGS ('dbx_value_regex' = 'ongoing|ended|cancelled|hiatus|in_development|pre_production');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `series_type` SET TAGS ('dbx_business_glossary_term' = 'Series Type');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `syndication_eligible` SET TAGS ('dbx_business_glossary_term' = 'Syndication Eligible');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_business_glossary_term' = 'Long Synopsis');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_business_glossary_term' = 'Short Synopsis');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `target_demographic` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Series Title');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `title_original` SET TAGS ('dbx_business_glossary_term' = 'Original Series Title');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `total_episode_count` SET TAGS ('dbx_business_glossary_term' = 'Total Episode Count');
ALTER TABLE `media_broadcasting_ecm`.`content`.`series` ALTER COLUMN `total_season_count` SET TAGS ('dbx_business_glossary_term' = 'Total Season Count');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` SET TAGS ('dbx_subdomain' = 'asset_catalog');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Trailer Asset Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `production_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Production Budget Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `royalty_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rule Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `archive_date` SET TAGS ('dbx_business_glossary_term' = 'Archive Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `archive_location` SET TAGS ('dbx_business_glossary_term' = 'Archive Location');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `awards_nominated` SET TAGS ('dbx_business_glossary_term' = 'Awards Nominated');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `awards_won` SET TAGS ('dbx_business_glossary_term' = 'Awards Won');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `banner_artwork_url` SET TAGS ('dbx_business_glossary_term' = 'Banner Artwork Uniform Resource Locator (URL)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `eidr` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `eidr` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `episode_count_aired` SET TAGS ('dbx_business_glossary_term' = 'Episode Count Aired');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `episode_count_ordered` SET TAGS ('dbx_business_glossary_term' = 'Episode Count Ordered');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `episode_count_produced` SET TAGS ('dbx_business_glossary_term' = 'Episode Count Produced');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `finale_date` SET TAGS ('dbx_business_glossary_term' = 'Season Finale Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `isan` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `isan` SET TAGS ('dbx_value_regex' = '^ISAN [A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `language_original` SET TAGS ('dbx_business_glossary_term' = 'Original Language');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `language_original` SET TAGS ('dbx_value_regex' = '^[a-z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `network_original` SET TAGS ('dbx_business_glossary_term' = 'Original Network');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `original_air_date` SET TAGS ('dbx_business_glossary_term' = 'Original Air Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `poster_artwork_url` SET TAGS ('dbx_business_glossary_term' = 'Poster Artwork Uniform Resource Locator (URL)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `production_year` SET TAGS ('dbx_business_glossary_term' = 'Production Year');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `rights_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Rights Expiry Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `rights_territory` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `season_number` SET TAGS ('dbx_business_glossary_term' = 'Season Number');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `season_status` SET TAGS ('dbx_business_glossary_term' = 'Season Status');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_business_glossary_term' = 'Long Synopsis');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_business_glossary_term' = 'Short Synopsis');
ALTER TABLE `media_broadcasting_ecm`.`content`.`season` ALTER COLUMN `total_runtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Runtime Minutes');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` SET TAGS ('dbx_subdomain' = 'asset_catalog');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Content Season Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Content Series Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Master Media Asset Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `production_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Production Budget Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `rights_content_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Content Window Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `royalty_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rule Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `archive_date` SET TAGS ('dbx_business_glossary_term' = 'Archive Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `archive_location` SET TAGS ('dbx_business_glossary_term' = 'Archive Location');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_value_regex' = '4:3|16:9|21:9|1.85:1|2.39:1');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Available Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `audio_format` SET TAGS ('dbx_business_glossary_term' = 'Audio Format');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `audio_format` SET TAGS ('dbx_value_regex' = 'stereo|5.1|7.1|dolby_atmos|dts_x');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `broadcast_count` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Count');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Available Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `content_advisory` SET TAGS ('dbx_business_glossary_term' = 'Content Advisory');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) Identifier');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `episode_number` SET TAGS ('dbx_business_glossary_term' = 'Episode Number');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `episode_status` SET TAGS ('dbx_business_glossary_term' = 'Episode Status');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `episode_status` SET TAGS ('dbx_value_regex' = 'in_production|post_production|ready_for_broadcast|aired|archived|withdrawn');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `episode_type` SET TAGS ('dbx_business_glossary_term' = 'Episode Type');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Content Keywords');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `music_cue_sheet_submitted` SET TAGS ('dbx_business_glossary_term' = 'Music Cue Sheet Submitted Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `original_air_date` SET TAGS ('dbx_business_glossary_term' = 'Original Air Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `premiere_flag` SET TAGS ('dbx_business_glossary_term' = 'Premiere Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Language Code');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `primary_language` SET TAGS ('dbx_value_regex' = '^[a-z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `production_code` SET TAGS ('dbx_business_glossary_term' = 'Production Code');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `rerun_flag` SET TAGS ('dbx_business_glossary_term' = 'Rerun Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Rights Clearance Status');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|restricted|expired');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `runtime_seconds` SET TAGS ('dbx_business_glossary_term' = 'Runtime in Seconds');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `runtime_with_ads_seconds` SET TAGS ('dbx_business_glossary_term' = 'Runtime With Advertisements in Seconds');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `subtitles_available` SET TAGS ('dbx_business_glossary_term' = 'Subtitles Available Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `synopsis_long` SET TAGS ('dbx_business_glossary_term' = 'Episode Synopsis Long');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `synopsis_short` SET TAGS ('dbx_business_glossary_term' = 'Episode Synopsis Short');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Episode Title');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `video_resolution` SET TAGS ('dbx_business_glossary_term' = 'Video Resolution');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `video_resolution` SET TAGS ('dbx_value_regex' = 'SD|HD|FHD|UHD|4K|8K');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `vod_available_from_date` SET TAGS ('dbx_business_glossary_term' = 'Video On Demand (VOD) Available From Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`content_episode` ALTER COLUMN `vod_available_until_date` SET TAGS ('dbx_business_glossary_term' = 'Video On Demand (VOD) Available Until Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` SET TAGS ('dbx_subdomain' = 'asset_catalog');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Version Identifier');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Abr Profile Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Drm Policy Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Master Asset Version Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Master Media Asset Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `rights_content_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Content Window Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `royalty_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rule Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Archived Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_value_regex' = '^[0-9]+:[0-9]+$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `audio_codec` SET TAGS ('dbx_business_glossary_term' = 'Audio Codec');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Available');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `audio_track_configuration` SET TAGS ('dbx_business_glossary_term' = 'Audio Track Configuration');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `broadcast_safe` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Safe');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_business_glossary_term' = 'Checksum Message Digest 5 (MD5)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{32}$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Available');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `color_space` SET TAGS ('dbx_business_glossary_term' = 'Color Space');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `color_space` SET TAGS ('dbx_value_regex' = 'rec_709|rec_2020|dci_p3|srgb');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `content_advisory` SET TAGS ('dbx_business_glossary_term' = 'Content Advisory');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `eidr_code` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `eidr_code` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `frame_rate` SET TAGS ('dbx_business_glossary_term' = 'Frame Rate');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `hdr_format` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Format');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `hdr_format` SET TAGS ('dbx_value_regex' = 'sdr|hdr10|hdr10_plus|dolby_vision|hlg');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `isan_code` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN) Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `isan_code` SET TAGS ('dbx_value_regex' = '^ISAN [A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `isrc_code` SET TAGS ('dbx_business_glossary_term' = 'International Standard Recording Code (ISRC) Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `isrc_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `label` SET TAGS ('dbx_business_glossary_term' = 'Version Label');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Language Code');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `qc_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Completed Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `qc_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Status');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `qc_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|passed|failed|conditional_pass');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `resolution` SET TAGS ('dbx_business_glossary_term' = 'Resolution');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `resolution` SET TAGS ('dbx_value_regex' = 'sd|hd_720p|hd_1080p|uhd_4k|uhd_8k');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `runtime_delta_seconds` SET TAGS ('dbx_business_glossary_term' = 'Runtime Delta in Seconds');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `runtime_seconds` SET TAGS ('dbx_business_glossary_term' = 'Runtime in Seconds');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Languages');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `target_platform` SET TAGS ('dbx_business_glossary_term' = 'Target Platform');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `target_territory` SET TAGS ('dbx_business_glossary_term' = 'Target Territory');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `target_territory` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `version_status` SET TAGS ('dbx_business_glossary_term' = 'Version Status');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `version_type` SET TAGS ('dbx_business_glossary_term' = 'Version Type');
ALTER TABLE `media_broadcasting_ecm`.`content`.`version` ALTER COLUMN `video_codec` SET TAGS ('dbx_business_glossary_term' = 'Video Codec');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` SET TAGS ('dbx_subdomain' = 'asset_catalog');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `parent_genre_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Genre Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `ad_pod_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Compatibility');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `applicable_content_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Content Types');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `archive_retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Archive Retention Policy');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `archive_retention_policy` SET TAGS ('dbx_value_regex' = 'permanent|long_term|standard|short_term');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `avod_monetization_potential` SET TAGS ('dbx_business_glossary_term' = 'Advertising-Supported Video On Demand (AVOD) Monetization Potential');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `avod_monetization_potential` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `daypart_affinity` SET TAGS ('dbx_business_glossary_term' = 'Daypart Affinity');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `eidr_genre_mapping` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) Genre Mapping');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `fast_channel_applicability` SET TAGS ('dbx_business_glossary_term' = 'Free Ad-Supported Streaming Television (FAST) Channel Applicability');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `genre_code` SET TAGS ('dbx_business_glossary_term' = 'Genre Code');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `genre_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `genre_description` SET TAGS ('dbx_business_glossary_term' = 'Genre Description');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `genre_name` SET TAGS ('dbx_business_glossary_term' = 'Genre Name');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `genre_tier` SET TAGS ('dbx_business_glossary_term' = 'Genre Tier');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `genre_tier` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `geographic_restriction_applicability` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Applicability');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `iab_content_category` SET TAGS ('dbx_business_glossary_term' = 'Interactive Advertising Bureau (IAB) Content Category');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `iab_content_category` SET TAGS ('dbx_value_regex' = '^IAB[0-9]{1,2}(-[0-9]{1,2})?$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Indicator');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `linear_broadcast_suitability` SET TAGS ('dbx_business_glossary_term' = 'Linear Broadcast Suitability');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `localization_priority` SET TAGS ('dbx_business_glossary_term' = 'Localization Priority');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `localization_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `metadata_enrichment_priority` SET TAGS ('dbx_business_glossary_term' = 'Metadata Enrichment Priority');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `metadata_enrichment_priority` SET TAGS ('dbx_value_regex' = 'critical|standard|minimal');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `mpa_rating_applicability` SET TAGS ('dbx_business_glossary_term' = 'Motion Picture Association (MPA) Rating Applicability');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `nielsen_genre_code` SET TAGS ('dbx_business_glossary_term' = 'Nielsen Genre Code');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `ott_platform_priority` SET TAGS ('dbx_business_glossary_term' = 'Over-The-Top (OTT) Platform Priority');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `ott_platform_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `parental_guidance_flag` SET TAGS ('dbx_business_glossary_term' = 'Parental Guidance Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `svod_performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Subscription Video On Demand (SVOD) Performance Tier');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `svod_performance_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|catalog');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `syndication_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Syndication Eligibility');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `target_demographic` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic');
ALTER TABLE `media_broadcasting_ecm`.`content`.`genre` ALTER COLUMN `usage_notes` SET TAGS ('dbx_business_glossary_term' = 'Usage Notes');
ALTER TABLE `media_broadcasting_ecm`.`content`.`rating` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `media_broadcasting_ecm`.`content`.`rating` SET TAGS ('dbx_subdomain' = 'asset_catalog');
ALTER TABLE `media_broadcasting_ecm`.`content`.`rating` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Rating Identifier');
ALTER TABLE `media_broadcasting_ecm`.`content`.`rating` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `media_broadcasting_ecm`.`content`.`rating` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'not_appealed|appeal_pending|appeal_approved|appeal_denied');
ALTER TABLE `media_broadcasting_ecm`.`content`.`rating` ALTER COLUMN `body` SET TAGS ('dbx_business_glossary_term' = 'Rating Body');
ALTER TABLE `media_broadcasting_ecm`.`content`.`rating` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Rating Certificate Number');
ALTER TABLE `media_broadcasting_ecm`.`content`.`rating` ALTER COLUMN `content_descriptor_drug_use` SET TAGS ('dbx_business_glossary_term' = 'Content Descriptor Drug Use');
ALTER TABLE `media_broadcasting_ecm`.`content`.`rating` ALTER COLUMN `content_descriptor_fear` SET TAGS ('dbx_business_glossary_term' = 'Content Descriptor Fear');
ALTER TABLE `media_broadcasting_ecm`.`content`.`rating` ALTER COLUMN `content_descriptor_language` SET TAGS ('dbx_business_glossary_term' = 'Content Descriptor Language');
ALTER TABLE `media_broadcasting_ecm`.`content`.`rating` ALTER COLUMN `content_descriptor_nudity` SET TAGS ('dbx_business_glossary_term' = 'Content Descriptor Nudity');
ALTER TABLE `media_broadcasting_ecm`.`content`.`rating` ALTER COLUMN `content_descriptor_violence` SET TAGS ('dbx_business_glossary_term' = 'Content Descriptor Violence');
ALTER TABLE `media_broadcasting_ecm`.`content`.`rating` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`rating` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Effective Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`rating` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Expiration Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`rating` ALTER COLUMN `minimum_age` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age');
ALTER TABLE `media_broadcasting_ecm`.`content`.`rating` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rating Notes');
ALTER TABLE `media_broadcasting_ecm`.`content`.`rating` ALTER COLUMN `parental_control_enabled` SET TAGS ('dbx_business_glossary_term' = 'Parental Control Enabled');
ALTER TABLE `media_broadcasting_ecm`.`content`.`rating` ALTER COLUMN `rating_code` SET TAGS ('dbx_business_glossary_term' = 'Rating Code');
ALTER TABLE `media_broadcasting_ecm`.`content`.`rating` ALTER COLUMN `rating_description` SET TAGS ('dbx_business_glossary_term' = 'Rating Description');
ALTER TABLE `media_broadcasting_ecm`.`content`.`rating` ALTER COLUMN `regulatory_mandate_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`rating` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Submission Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`rating` ALTER COLUMN `system` SET TAGS ('dbx_business_glossary_term' = 'Rating System');
ALTER TABLE `media_broadcasting_ecm`.`content`.`rating` ALTER COLUMN `system` SET TAGS ('dbx_value_regex' = 'MPA|TVPG|BBFC|FSK|OFLC|CBFC');
ALTER TABLE `media_broadcasting_ecm`.`content`.`rating` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `media_broadcasting_ecm`.`content`.`rating` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`rating` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`rating` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Rating Version');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` SET TAGS ('dbx_subdomain' = 'production_enrichment');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `localization_id` SET TAGS ('dbx_business_glossary_term' = 'Localization ID');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Localized Asset Version Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Localized Media Asset Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `music_sync_license_id` SET TAGS ('dbx_business_glossary_term' = 'Music Sync License Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Localization Vendor ID');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `rights_content_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Content Window Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Title Version ID');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Voice Talent Profile Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `accessibility_standard_met` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Standard Met');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `accessibility_standard_met` SET TAGS ('dbx_value_regex' = 'WCAG_2.1_AA|WCAG_2.2_AA|FCC_CVAA|EAA|ADA|none');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `asset_file_path` SET TAGS ('dbx_business_glossary_term' = 'Asset File Path');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `character_count` SET TAGS ('dbx_business_glossary_term' = 'Character Count');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `compliance_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Localization Cost Amount');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration Minutes');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `eidr_code` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) ID');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `eidr_code` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `localization_status` SET TAGS ('dbx_business_glossary_term' = 'Localization Status');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `localization_type` SET TAGS ('dbx_business_glossary_term' = 'Localization Type');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `localization_type` SET TAGS ('dbx_value_regex' = 'dubbing|subtitling|metadata_translation|forced_narrative|audio_description|closed_caption');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `qc_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Notes');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `qc_pass_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Pass Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `qc_review_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `qc_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Reviewer Name');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `scheduled_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `subtitle_format` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Format');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `target_language_code` SET TAGS ('dbx_business_glossary_term' = 'Target Language Code');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `target_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}(-[A-Z]{2})?$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `target_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Target Territory Code');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `target_territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`localization` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `media_broadcasting_ecm`.`content`.`talent_credit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`content`.`talent_credit` SET TAGS ('dbx_subdomain' = 'production_enrichment');
ALTER TABLE `media_broadcasting_ecm`.`content`.`talent_credit` ALTER COLUMN `talent_credit_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Credit Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`talent_credit` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Episode Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`talent_credit` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Contract Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`talent_credit` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Role Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`talent_credit` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`talent_credit` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`talent_credit` ALTER COLUMN `billing_position` SET TAGS ('dbx_business_glossary_term' = 'Billing Position');
ALTER TABLE `media_broadcasting_ecm`.`content`.`talent_credit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`talent_credit` ALTER COLUMN `credit_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Approval Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`talent_credit` ALTER COLUMN `credit_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Approval Status');
ALTER TABLE `media_broadcasting_ecm`.`content`.`talent_credit` ALTER COLUMN `credit_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|disputed|rejected|arbitration');
ALTER TABLE `media_broadcasting_ecm`.`content`.`talent_credit` ALTER COLUMN `credit_category` SET TAGS ('dbx_business_glossary_term' = 'Credit Category');
ALTER TABLE `media_broadcasting_ecm`.`content`.`talent_credit` ALTER COLUMN `credit_display_name` SET TAGS ('dbx_business_glossary_term' = 'Credit Display Name');
ALTER TABLE `media_broadcasting_ecm`.`content`.`talent_credit` ALTER COLUMN `credit_display_order` SET TAGS ('dbx_business_glossary_term' = 'Credit Display Order');
ALTER TABLE `media_broadcasting_ecm`.`content`.`talent_credit` ALTER COLUMN `credit_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Credit End Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`talent_credit` ALTER COLUMN `credit_notes` SET TAGS ('dbx_business_glossary_term' = 'Credit Notes');
ALTER TABLE `media_broadcasting_ecm`.`content`.`talent_credit` ALTER COLUMN `credit_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Credit Start Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`talent_credit` ALTER COLUMN `credit_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Type');
ALTER TABLE `media_broadcasting_ecm`.`content`.`talent_credit` ALTER COLUMN `credit_type` SET TAGS ('dbx_value_regex' = 'on-screen|off-screen|voice|stunt|archive');
ALTER TABLE `media_broadcasting_ecm`.`content`.`talent_credit` ALTER COLUMN `pseudonym_flag` SET TAGS ('dbx_business_glossary_term' = 'Pseudonym Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`talent_credit` ALTER COLUMN `residuals_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Residuals Eligibility Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`talent_credit` ALTER COLUMN `union_affiliation_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Affiliation Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`talent_credit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` SET TAGS ('dbx_subdomain' = 'rights_distribution');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `acquisition_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Identifier');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Acquired Media Asset Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `acquisition_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal ID');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `ingest_job_id` SET TAGS ('dbx_business_glossary_term' = 'Ingest Job Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition License Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Payable Invoice Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `rights_content_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Content Window Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `royalty_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rule Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content ID');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `acquisition_status` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Status');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `acquisition_status` SET TAGS ('dbx_value_regex' = 'negotiating|committed|delivered|active|cancelled|expired');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `acquisition_type` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Type');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `acquisition_type` SET TAGS ('dbx_value_regex' = 'purchase|license|co-production|commission|barter|syndication');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `ancillary_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Rights Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Clearance Status');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `clearance_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|restricted|failed');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `content_window_type` SET TAGS ('dbx_business_glossary_term' = 'Content Window Type');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost Amount');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost Currency');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `delivery_format` SET TAGS ('dbx_business_glossary_term' = 'Delivery Format');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `format_rights` SET TAGS ('dbx_business_glossary_term' = 'Format Rights');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_business_glossary_term' = 'Holdback Period Days');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `language_rights` SET TAGS ('dbx_business_glossary_term' = 'Language Rights');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `license_end_date` SET TAGS ('dbx_business_glossary_term' = 'License End Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `license_start_date` SET TAGS ('dbx_business_glossary_term' = 'License Start Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Amount');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Notes');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Reference Number');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `residuals_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Residuals Obligation Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percent');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `runs_allowed` SET TAGS ('dbx_business_glossary_term' = 'Runs Allowed');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `runs_consumed` SET TAGS ('dbx_business_glossary_term' = 'Runs Consumed');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `sublicensing_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Sublicensing Allowed Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `media_broadcasting_ecm`.`content`.`acquisition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` SET TAGS ('dbx_subdomain' = 'rights_distribution');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `windowing_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Windowing Plan ID');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Abr Profile Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `acquisition_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `drm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Drm Policy Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Governing License Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `holdback_id` SET TAGS ('dbx_business_glossary_term' = 'Holdback Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign ID');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Program Schedule Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `revenue_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `rights_availability_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Availability Window Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `rights_content_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Content Window Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `royalty_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rule Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `subscription_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Plan Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content ID');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `upfront_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Upfront Deal Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `abr_enabled` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Bitrate (ABR) Enabled');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `audio_configuration` SET TAGS ('dbx_business_glossary_term' = 'Audio Configuration');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `audio_configuration` SET TAGS ('dbx_value_regex' = 'stereo|surround_5_1|surround_7_1|dolby_atmos|dts_x');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `blackout_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Blackout Restrictions');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `bundle_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Bundle Eligibility');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `concurrent_streams_limit` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Streams Limit');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `content_format` SET TAGS ('dbx_business_glossary_term' = 'Content Format');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `content_format` SET TAGS ('dbx_value_regex' = 'sd|hd|4k|8k|hdr|dolby_vision');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `daypart_restriction` SET TAGS ('dbx_business_glossary_term' = 'Daypart Restriction');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `download_to_go_enabled` SET TAGS ('dbx_business_glossary_term' = 'Download-to-Go Enabled');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `dubbing_availability` SET TAGS ('dbx_business_glossary_term' = 'Dubbing Availability');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `exclusivity_tier` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Tier');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `exclusivity_tier` SET TAGS ('dbx_value_regex' = 'exclusive|non_exclusive|shared_exclusive|first_run|second_run');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `holdback_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Holdback Duration Days');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `language_version` SET TAGS ('dbx_business_glossary_term' = 'Language Version');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `language_version` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Amount');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `planned_close_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Close Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `planned_open_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Open Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `price_point` SET TAGS ('dbx_business_glossary_term' = 'Price Point');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `price_point` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `promotional_pricing_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Pricing Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `revenue_model` SET TAGS ('dbx_business_glossary_term' = 'Revenue Model');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `revenue_model` SET TAGS ('dbx_value_regex' = 'subscription|advertising|transactional|hybrid|free');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_value_regex' = 'hls|dash|smooth_streaming|rtmp|webrtc');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `subtitle_availability` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Availability');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `viewing_window_hours` SET TAGS ('dbx_business_glossary_term' = 'Viewing Window Hours');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `window_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Window Sequence Number');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `window_status` SET TAGS ('dbx_business_glossary_term' = 'Window Status');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `window_status` SET TAGS ('dbx_value_regex' = 'planned|confirmed|active|completed|cancelled|postponed');
ALTER TABLE `media_broadcasting_ecm`.`content`.`windowing_plan` ALTER COLUMN `window_type` SET TAGS ('dbx_business_glossary_term' = 'Window Type');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` SET TAGS ('dbx_subdomain' = 'production_enrichment');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `metadata_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Metadata Profile ID');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `compliance_content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Asset Version Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Preview Media Asset Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title ID');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_value_regex' = '4:3|16:9|21:9|1.85:1|2.39:1');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `audio_description_available` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Available');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `audio_format` SET TAGS ('dbx_business_glossary_term' = 'Audio Format');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `audio_format` SET TAGS ('dbx_value_regex' = 'Stereo|5.1|7.1|Dolby Atmos|DTS:X|Mono');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `cast_summary` SET TAGS ('dbx_business_glossary_term' = 'Cast Summary');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Available');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `director_credit` SET TAGS ('dbx_business_glossary_term' = 'Director Credit');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `distributor` SET TAGS ('dbx_business_glossary_term' = 'Distributor');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `keyword_tags` SET TAGS ('dbx_business_glossary_term' = 'Keyword Tags');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `long_synopsis` SET TAGS ('dbx_business_glossary_term' = 'Long Synopsis');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `metadata_language` SET TAGS ('dbx_business_glossary_term' = 'Metadata Language');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `metadata_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}(-[A-Z]{2})?$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `metadata_standard` SET TAGS ('dbx_business_glossary_term' = 'Metadata Standard');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `metadata_standard` SET TAGS ('dbx_value_regex' = 'EIDR|Dublin Core|EBUCore|TVAnytime|schema.org|MPEG-7');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `parental_guidance_notes` SET TAGS ('dbx_business_glossary_term' = 'Parental Guidance Notes');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `platform_specific_code` SET TAGS ('dbx_business_glossary_term' = 'Platform-Specific ID');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `poster_url` SET TAGS ('dbx_business_glossary_term' = 'Poster URL (Uniform Resource Locator)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `production_company` SET TAGS ('dbx_business_glossary_term' = 'Production Company');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Profile Status');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'draft|validated|published|rejected|archived|expired');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `promotional_tagline` SET TAGS ('dbx_business_glossary_term' = 'Promotional Tagline');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `runtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Runtime Minutes');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `short_synopsis` SET TAGS ('dbx_business_glossary_term' = 'Short Synopsis');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `thumbnail_url` SET TAGS ('dbx_business_glossary_term' = 'Thumbnail URL (Uniform Resource Locator)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `trailer_url` SET TAGS ('dbx_business_glossary_term' = 'Trailer URL (Uniform Resource Locator)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `validation_errors` SET TAGS ('dbx_business_glossary_term' = 'Validation Errors');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|warning');
ALTER TABLE `media_broadcasting_ecm`.`content`.`metadata_profile` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` SET TAGS ('dbx_subdomain' = 'production_enrichment');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `artwork_id` SET TAGS ('dbx_business_glossary_term' = 'Artwork Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Artwork Asset Version Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `approved_for_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Approved for Use Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `archive_location` SET TAGS ('dbx_business_glossary_term' = 'Archive Location');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `artwork_type` SET TAGS ('dbx_business_glossary_term' = 'Artwork Type');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `artwork_type` SET TAGS ('dbx_value_regex' = 'key-art|thumbnail|banner|poster|logo|still');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `color_profile` SET TAGS ('dbx_business_glossary_term' = 'Color Profile');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `color_profile` SET TAGS ('dbx_value_regex' = 'sRGB|Adobe RGB|ProPhoto RGB|CMYK|Rec. 709|Rec. 2020');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `content_rating_displayed_flag` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Displayed Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `copyright_year` SET TAGS ('dbx_business_glossary_term' = 'Copyright Year');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `eidr` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `eidr` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'JPEG|PNG|TIFF|PSD|SVG|WebP');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `height_pixels` SET TAGS ('dbx_business_glossary_term' = 'Height in Pixels');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `language_overlay_flag` SET TAGS ('dbx_business_glossary_term' = 'Language Overlay Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `photographer_credit` SET TAGS ('dbx_business_glossary_term' = 'Photographer Credit');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `resolution_dpi` SET TAGS ('dbx_business_glossary_term' = 'Resolution in Dots Per Inch (DPI)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Dalet Galaxy|Adobe Experience Platform|Internal Studio|External Agency|Vendor Portal');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Artwork Title');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `usage_rights` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `usage_rights` SET TAGS ('dbx_value_regex' = 'all-media|digital-only|print-only|broadcast-only|theatrical-only|promotional-only');
ALTER TABLE `media_broadcasting_ecm`.`content`.`artwork` ALTER COLUMN `width_pixels` SET TAGS ('dbx_business_glossary_term' = 'Width in Pixels');
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` SET TAGS ('dbx_subdomain' = 'production_enrichment');
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ALTER COLUMN `tag_id` SET TAGS ('dbx_business_glossary_term' = 'Tag Identifier');
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ALTER COLUMN `parent_tag_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Tag ID');
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title ID');
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ALTER COLUMN `advertiser_safe` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Safe');
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ALTER COLUMN `applied_date` SET TAGS ('dbx_business_glossary_term' = 'Applied Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score');
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ALTER COLUMN `coppa_compliant` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Compliant');
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Tag Hierarchy Level');
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ALTER COLUMN `is_displayable` SET TAGS ('dbx_business_glossary_term' = 'Is Displayable');
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ALTER COLUMN `is_searchable` SET TAGS ('dbx_business_glossary_term' = 'Is Searchable');
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Tag Language');
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review');
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ALTER COLUMN `tag_source` SET TAGS ('dbx_business_glossary_term' = 'Tag Source');
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ALTER COLUMN `tag_source` SET TAGS ('dbx_value_regex' = 'editorial|algorithmic|partner|user_generated|rights_holder|production');
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ALTER COLUMN `tag_type` SET TAGS ('dbx_business_glossary_term' = 'Tag Type');
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ALTER COLUMN `tag_value` SET TAGS ('dbx_business_glossary_term' = 'Tag Value');
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ALTER COLUMN `taxonomy_version` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Version');
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ALTER COLUMN `usage_context` SET TAGS ('dbx_business_glossary_term' = 'Usage Context');
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ALTER COLUMN `usage_context` SET TAGS ('dbx_value_regex' = 'recommendation|search|advertising|editorial|analytics|compliance');
ALTER TABLE `media_broadcasting_ecm`.`content`.`tag` ALTER COLUMN `weight` SET TAGS ('dbx_business_glossary_term' = 'Tag Weight');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` SET TAGS ('dbx_subdomain' = 'rights_distribution');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Identifier');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `distribution_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Package Media Asset Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `audio_description_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Available Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `closed_caption_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Available Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `commercial_context` SET TAGS ('dbx_business_glossary_term' = 'Commercial Context');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `drm_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Required Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `hd_available_flag` SET TAGS ('dbx_business_glossary_term' = 'High Definition (HD) Available Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `language_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Language');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `package_code` SET TAGS ('dbx_business_glossary_term' = 'Package Code');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `package_description` SET TAGS ('dbx_business_glossary_term' = 'Package Description');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `package_name` SET TAGS ('dbx_business_glossary_term' = 'Package Name');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `package_status` SET TAGS ('dbx_business_glossary_term' = 'Package Status');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `package_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated|archived');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `package_type` SET TAGS ('dbx_value_regex' = 'syndication|svod-library|avod-catalog|fast-channel|educational|international');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `thumbnail_url` SET TAGS ('dbx_business_glossary_term' = 'Thumbnail Uniform Resource Locator (URL)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `total_runtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Runtime Hours');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `total_title_count` SET TAGS ('dbx_business_glossary_term' = 'Total Title Count');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `uhd_4k_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Ultra High Definition (UHD) 4K Available Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `value_usd` SET TAGS ('dbx_business_glossary_term' = 'Package Value United States Dollars (USD)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package` ALTER COLUMN `value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` SET TAGS ('dbx_subdomain' = 'rights_distribution');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `title_relationship_id` SET TAGS ('dbx_business_glossary_term' = 'Title Relationship Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `parent_title_relationship_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Source Title Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `target_title_id` SET TAGS ('dbx_business_glossary_term' = 'Target Title Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `bidirectional_flag` SET TAGS ('dbx_business_glossary_term' = 'Bidirectional Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `canonical_order` SET TAGS ('dbx_business_glossary_term' = 'Canonical Order');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `chronological_order` SET TAGS ('dbx_business_glossary_term' = 'Chronological Order');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `display_priority` SET TAGS ('dbx_business_glossary_term' = 'Display Priority');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `editorial_notes` SET TAGS ('dbx_business_glossary_term' = 'Editorial Notes');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `franchise_name` SET TAGS ('dbx_business_glossary_term' = 'Franchise Name');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `platform_visibility` SET TAGS ('dbx_business_glossary_term' = 'Platform Visibility');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `recommendation_weight` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Weight');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `relationship_direction` SET TAGS ('dbx_business_glossary_term' = 'Relationship Direction');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `relationship_direction` SET TAGS ('dbx_value_regex' = 'forward|reverse|bidirectional');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|deprecated');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `relationship_strength` SET TAGS ('dbx_business_glossary_term' = 'Relationship Strength');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `relationship_strength` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary|tangential');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'sequel|prequel|remake|reboot|spin-off|compilation');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `release_order` SET TAGS ('dbx_business_glossary_term' = 'Release Order');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|disputed|pending_review');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `media_broadcasting_ecm`.`content`.`title_relationship` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package_title` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package_title` SET TAGS ('dbx_subdomain' = 'rights_distribution');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package_title` SET TAGS ('dbx_association_edges' = 'content.package,content.title');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package_title` ALTER COLUMN `package_title_id` SET TAGS ('dbx_business_glossary_term' = 'Package Title Inclusion ID');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package_title` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Title - Package Id');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package_title` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Package Title - Title Id');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package_title` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package_title` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Title-Level Exclusivity Flag');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package_title` ALTER COLUMN `inclusion_date` SET TAGS ('dbx_business_glossary_term' = 'Title Inclusion Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package_title` ALTER COLUMN `inclusion_status` SET TAGS ('dbx_business_glossary_term' = 'Title Inclusion Status');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package_title` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package_title` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modification Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package_title` ALTER COLUMN `price_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Title Price Contribution');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package_title` ALTER COLUMN `removal_date` SET TAGS ('dbx_business_glossary_term' = 'Title Removal Date');
ALTER TABLE `media_broadcasting_ecm`.`content`.`package_title` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Title Sequence Number');
