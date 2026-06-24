-- Schema for Domain: rights | Business: Media_Broadcasting | Version: v2_mvm
-- Generated on: 2026-06-23 04:24:41

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`rights` COMMENT 'Single source of truth for all intellectual property rights, licensing agreements, and royalty obligations. Manages content windows (theatrical, SVOD, AVOD, TVOD, linear), holdback periods, territory restrictions, talent residuals, music synchronization licenses, clearance workflows, and royalty calculations. Powered by Rightsline, this domain enforces windowing strategies and feeds availability data to scheduling and distribution.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` (
    `license_agreement_id` BIGINT COMMENT 'Unique system identifier for the license agreement record. Primary key. Role: MASTER_AGREEMENT.',
    `holder_id` BIGINT COMMENT 'Reference to the party granting rights under this agreement (studio, distributor, music publisher, talent guild, production company).',
    `advance_payment_amount` DECIMAL(18,2) COMMENT 'Upfront payment made upon execution of the agreement, typically recoupable against future royalties or license fees.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the license agreement, used in contracts and communications with rights holders and licensees.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement automatically renews at expiry unless terminated by either party. True = auto-renews, False = expires at term end.',
    `blackout_restrictions` STRING COMMENT 'Geographic or temporal restrictions on content availability (e.g., no broadcast in certain markets during specific events, sports blackout rules). Free-text description.',
    `clearance_required_flag` BOOLEAN COMMENT 'Indicates whether additional rights clearance verification is required before content can be broadcast or distributed under this agreement. True = clearance workflow required, False = no additional clearance needed.',
    `content_rating_restriction` STRING COMMENT 'Content rating limitations imposed by this agreement (e.g., PG-13 and below only, no R-rated content). Comma-separated list of allowed ratings per MPA or TV Parental Guidelines.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this license agreement record was first created in Rightsline.',
    `effective_date` DATE COMMENT 'Date when the license agreement becomes legally binding and rights become available for exploitation. Start of the agreement term.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the license grants exclusive rights within the territory and media windows. True = exclusive, False = non-exclusive.',
    `expiry_date` DATE COMMENT 'Date when the license agreement terminates and rights revert to the licensor. End of the agreement term. Nullable for perpetual agreements.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction whose laws govern the interpretation and enforcement of this agreement (e.g., State of California, England and Wales, New York).',
    `holdback_period_days` STRING COMMENT 'Number of days during which content must be withheld from certain distribution windows to protect exclusivity in other windows (e.g., theatrical holdback before SVOD release).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this license agreement record was last updated in Rightsline.',
    `mechanical_license_flag` BOOLEAN COMMENT 'Whether this agreement covers mechanical reproduction rights.',
    `media_rights_granted` STRING COMMENT 'Comma-separated list of media exploitation rights included in this agreement (e.g., linear broadcast, SVOD, AVOD, TVOD, theatrical, home video, digital download, mobile streaming).',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum guaranteed payment to the licensor regardless of actual usage or revenue performance. Common in output deals and syndication agreements.',
    `music_sync_license_flag` BOOLEAN COMMENT 'Indicates whether this agreement includes music synchronization rights for use of musical compositions in audiovisual content. True = music sync rights included, False = no music sync rights.',
    `neighbouring_rights_flag` BOOLEAN COMMENT 'Whether this agreement covers neighbouring/related rights.',
    `notes` STRING COMMENT 'Free-text field for additional contractual terms, special conditions, or internal comments about the agreement.',
    `payment_schedule_type` STRING COMMENT 'Structure of the payment obligation. Determines how total_license_fee is disbursed over time.. Valid values are `lump sum|installments|per-episode|annual|milestone-based|revenue share`',
    `per_episode_fee` DECIMAL(18,2) COMMENT 'License fee charged per episode for episodic content. Applicable to syndication and first-run syndication agreements.',
    `renewal_term_months` STRING COMMENT 'Duration in months of each automatic renewal period if auto_renewal_flag is true. Null if agreement does not auto-renew.',
    `residuals_obligation_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes obligations to pay talent residuals for reuse of content. True = residuals required, False = no residuals.',
    `royalty_calculation_method` STRING COMMENT 'Method used to calculate ongoing royalty payments to the licensor. Determines how revenue is shared or how usage is monetized.. Valid values are `flat fee|percentage of revenue|tiered percentage|per-unit|hybrid`',
    `royalty_percentage` DECIMAL(18,2) COMMENT 'Percentage of revenue or receipts paid to the licensor as ongoing royalties. Applicable when royalty_calculation_method is percentage-based.',
    `run_count_limit` STRING COMMENT 'Maximum number of times each episode or program may be broadcast or streamed under this agreement. Common in syndication deals. Null indicates unlimited runs.',
    `signed_date` DATE COMMENT 'Date when the agreement was executed by all parties. May differ from effective_date.',
    `source_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `sublicensing_allowed_flag` BOOLEAN COMMENT 'Indicates whether the licensee is permitted to sublicense the rights to third parties. True = sublicensing allowed, False = sublicensing prohibited.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the agreement before expiry or renewal.',
    `territory_scope` STRING COMMENT 'Geographic territories covered by this license agreement. Comma-separated list of ISO 3166-1 alpha-3 country codes or region identifiers (e.g., USA,CAN,MEX or WORLDWIDE or EMEA).',
    `total_license_fee` DECIMAL(18,2) COMMENT 'Total contractual payment obligation for the license rights over the full term of the agreement. Sum of all payment milestones.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `windowing_strategy` STRING COMMENT 'Sequential release strategy defining the order and timing of content availability across distribution channels (theatrical, SVOD, AVOD, TVOD, linear, syndication). Free-text description of the windowing plan.',
    CONSTRAINT pk_license_agreement PRIMARY KEY(`license_agreement_id`)
) COMMENT 'Master record for all content licensing, acquisition, and syndication agreements managed in Rightsline. Captures the full contractual relationship between Media Broadcasting and rights grantors or licensees (studios, distributors, music publishers, talent guilds, syndication partners). Stores agreement type (acquisition, co-production, syndication, first-run syndication, off-network syndication, international syndication, music sync, output deal), licensor and licensee identities, effective and expiry dates, territory scope, exclusivity flags, total license fee, payment schedule with milestone detail (advances, minimum guarantees, per-episode fees, annual installments), run count limitations for syndication, governing law jurisdiction, and agreement status (draft, executed, expired, terminated). This is the SSOT for all rights-bearing contracts and the anchor entity for all downstream window, royalty, and clearance records. [VENDOR-ANCHOR] Identifier anchors: EIDR 10.5240/ ISRC ISWC rights identifiers. System of record: Rightsline. [DEMO-FITNESS] MVM demo-fitness: Churn prediction & win-back (D2C SVOD) [rating=5/5, status=done]; Rights availability & windowing [rating=5/5, status=best-in-class]; Linear playout + as-run reconciliation [rating=5/5, status=complete]; Production cost & budget vs. actuals [rating=4/5, status=strong]; Compliance / regulatory reporting [rating=5/5, status=complete]; Overall bottom-line [rating=n/a/5, status=substantially above average]';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` (
    `grant_id` BIGINT COMMENT 'Unique identifier for the rights grant record. Primary key.',
    `license_agreement_id` BIGINT COMMENT 'Reference to the parent license agreement from which this grant is derived.',
    `media_asset_id` BIGINT COMMENT 'Reference to the content asset (film, series, episode, music track) to which this grant applies.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Grant has talent_residuals_applicable flag but no FK identifying WHICH talent is owed residuals. The Talent Residuals Tracking per Grant process (SAG-AFTRA exploitation reporting) requires knowing',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Rights grants apply to specific territories. Each rights grant covers one territory. Normalizing to territory reference eliminates redundant territory string storage and enables consistent territory m',
    `blackout_applicable` BOOLEAN COMMENT 'Indicates whether geographic or temporal blackout restrictions apply to this grant (e.g., sports blackouts, regional restrictions).',
    `carriage_fee_applicable` BOOLEAN COMMENT 'Indicates whether a carriage fee (distribution payment) is associated with this grant.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rights grant record was first created in the system.',
    `drm_required` BOOLEAN COMMENT 'Indicates whether DRM protection is mandated for content distributed under this grant.',
    `end_date` DATE COMMENT 'The date on which the rights grant expires and exploitation must cease. Nullable for perpetual grants.',
    `exclusivity_indicator` BOOLEAN COMMENT 'Indicates whether the grant is exclusive (true) or non-exclusive (false). Exclusive grants prevent other parties from exploiting the same rights in the same territory and window.',
    `grant_number` STRING COMMENT 'Business identifier for the rights grant, typically a human-readable code used in Rightsline and operational workflows.',
    `holdback_applicable` BOOLEAN COMMENT 'Indicates whether a holdback period applies to this grant. Holdbacks restrict exploitation during specific windows to protect other distribution channels.',
    `holdback_end_date` DATE COMMENT 'The end date of the holdback period, after which exploitation may resume. Nullable if no holdback applies.',
    `holdback_start_date` DATE COMMENT 'The start date of any holdback period during which exploitation is restricted. Nullable if no holdback applies.',
    `language_version` STRING COMMENT 'Language version of the content covered by this grant (e.g., English, Spanish, French). May reference dubbed, subtitled, or original language versions.',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum guaranteed payment amount for this grant, regardless of actual revenue. Nullable if no MG applies.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this rights grant record was last modified.',
    `music_sync_license_required` BOOLEAN COMMENT 'Indicates whether a separate music synchronization license is required for the music tracks embedded in the content.',
    `notes` STRING COMMENT 'Free-text notes capturing additional terms, conditions, or operational instructions related to this grant.',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'Percentage royalty rate applied to revenue generated under this grant. Used for royalty calculations.',
    `source_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `start_date` DATE COMMENT 'The date on which the rights grant becomes effective and exploitation may begin.',
    `sublicense_permitted` BOOLEAN COMMENT 'Indicates whether the licensee is permitted to sublicense the rights to third parties.',
    `talent_residuals_applicable` BOOLEAN COMMENT 'Indicates whether talent residual payments (reuse payments to actors, directors, writers) are triggered by this grant.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `window_name` STRING COMMENT 'Named distribution window (e.g., Theatrical, Premium VOD, Pay-TV, Free-TV) that this grant falls within. Used for windowing strategy enforcement.',
    CONSTRAINT pk_grant PRIMARY KEY(`grant_id`)
) COMMENT 'Granular rights entitlement record derived from a license agreement. Each row represents a specific bundle of rights granted for a content asset — capturing right type (broadcast, SVOD, AVOD, TVOD, theatrical, home video, music sync, podcast), media type, territory or territory group, language version, exclusivity indicator, holdback applicability, and the grant period (start and end dates). Multiple grants can exist per agreement and per content asset. Feeds the availability engine in scheduling and distribution domains. Powered by Rightsline availabilities module. [VENDOR-ANCHOR] Identifier anchors: EIDR 10.5240/ ISRC ISWC rights identifiers. System of record: Rightsline. [DEMO-FITNESS] MVM demo-fitness: Churn prediction & win-back (D2C SVOD) [rating=5/5, status=done]; Rights availability & windowing [rating=5/5, status=best-in-class]; Linear playout + as-run reconciliation [rating=5/5, status=complete]; Production cost & budget vs. actuals [rating=4/5, status=strong]; Compliance / regulatory reporting [rating=5/5, status=complete]; Overall bottom-line [rating=n/a/5, status=substantially above average]';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` (
    `content_window_id` BIGINT COMMENT 'Unique identifier for the content window record. Primary key for the rights content window entity.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: A rights_content_window represents the operational realization of a specific rights grant — it defines the exploitation window (SVOD, AVOD, linear, etc.) authorized by a grant. Linking rights_content_',
    `license_agreement_id` BIGINT COMMENT 'Reference to the parent rights agreement or license contract that governs this window. Links to the master rights agreement.',
    `media_asset_id` BIGINT COMMENT 'Reference to the specific content asset (film, series, episode, program) to which this window applies. Links to the content master record.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Content windows apply to specific territories. Each window covers one territory. Normalizing to territory reference eliminates redundant territory string storage and enables consistent territory metad',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this window record is currently active and should be considered in availability calculations. False if the window has been superseded, cancelled, or archived.',
    `blackout_flag` BOOLEAN COMMENT 'Indicates whether a geographic or temporal blackout restriction is currently active for this window. True if content is blacked out and cannot be distributed; false otherwise.',
    `blackout_reason` STRING COMMENT 'The business or regulatory reason for the blackout restriction (e.g., sports event local blackout, contractual exclusivity, regulatory compliance). Populated only when blackout_flag is true.',
    `clearance_notes` STRING COMMENT 'Free-text notes documenting clearance issues, pending approvals, conditional restrictions, or special instructions related to rights clearance for this window.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_by_user` STRING COMMENT 'The username or identifier of the user who created this window record. Audit field for accountability and compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this window record was first created in the system. Audit field for data lineage and compliance.',
    `drm_requirement` STRING COMMENT 'The DRM technology or protection scheme required for content distribution during this window. Enforces content protection and anti-piracy requirements specified in the rights agreement.. Valid values are `widevine|fairplay|playready|none|multi_drm`',
    `geo_blocking_required_flag` BOOLEAN COMMENT 'Indicates whether geographic blocking technology must be enforced to restrict access to the specified territory. True if geo-blocking is mandatory; false if not required.',
    `holdback_end_date` DATE COMMENT 'The date when a holdback period ends and distribution is re-authorized. Marks the conclusion of the exclusivity restriction.',
    `holdback_start_date` DATE COMMENT 'The date when a holdback period begins, temporarily restricting distribution even within an open window. Used to enforce exclusivity periods and prevent simultaneous exploitation across competing platforms.',
    `last_availability_refresh_timestamp` TIMESTAMP COMMENT 'The timestamp when the availability_status was last recalculated. Updated whenever upstream rights, holdback, or blackout records change. Used to track data freshness for scheduling and distribution systems.',
    `license_fee_amount` DECIMAL(18,2) COMMENT 'The monetary fee paid by the platform or distributor for the rights to exploit the content during this window. May be a flat fee, minimum guarantee, or advance against royalties.',
    `license_fee_currency` STRING COMMENT 'The three-letter ISO 4217 currency code for the license fee amount (e.g., USD, GBP, EUR).',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'The minimum guaranteed payment amount that the distributor or platform must pay regardless of actual revenue or usage. Common in SVOD and licensing deals.',
    `modified_by_user` STRING COMMENT 'The username or identifier of the user who last modified this window record. Audit field for accountability and compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this window record was last modified. Audit field for change tracking and data lineage.',
    `platform_scope` STRING COMMENT 'The specific platform, channel, service, or outlet authorized for distribution during this window (e.g., Netflix, HBO Max, ABC Network, theatrical chain). May be a single platform or a platform group.',
    `revenue_share_percent` DECIMAL(18,2) COMMENT 'The percentage of gross or net revenue that the rights holder receives from exploitation during this window. Common in TVOD, AVOD, and theatrical windows.',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'The percentage rate applied to revenue or usage to calculate royalty payments for this window. Used when the window operates under a revenue-sharing or usage-based royalty model.',
    `source_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `sublicense_permitted_flag` BOOLEAN COMMENT 'Indicates whether the platform or distributor is authorized to sublicense the content to third parties during this window. True if sublicensing is permitted; false if prohibited.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `usage_cap_units` STRING COMMENT 'The maximum number of usage units (streams, downloads, broadcasts, screenings) permitted during this window. Used to enforce contractual usage limits.',
    `window_close_date` DATE COMMENT 'The date when this exploitation window ends and the content is no longer authorized for distribution on the specified platform. End of the availability period. Nullable for perpetual windows.',
    `window_extension_count` STRING COMMENT 'The number of times this window has been extended beyond its original close date. Tracks amendments and extensions to the original window terms.',
    `window_open_date` DATE COMMENT 'The date when this exploitation window becomes active and the content is authorized for distribution on the specified platform. Start of the availability period.',
    `window_priority` STRING COMMENT 'The numeric priority or sequence order of this window in the overall windowing strategy. Lower numbers indicate earlier windows in the release hierarchy (e.g., 1 for theatrical, 2 for PVOD, 3 for SVOD). Used to enforce windowing hierarchy rules.',
    CONSTRAINT pk_content_window PRIMARY KEY(`content_window_id`)
) COMMENT 'Defines the sequential release window strategy (windowing) for a specific content asset across exploitation platforms, and computes the net availability status. Each record captures the window type (theatrical, PVOD, TVOD, SVOD, AVOD, linear, FAST, home video, syndication), platform or channel scope, window open and close dates, holdback start and end dates, territory, exclusivity tier, and computed availability status (available, held-back, blacked-out, expired). Enforces the windowing hierarchy that prevents simultaneous exploitation across competing platforms. The net availability (considering holdbacks and blackouts) is refreshed whenever upstream rights or holdback records change. Directly consumed by scheduling and distribution domains to validate playout eligibility. Powered by Rightsline Windows module. [VENDOR-ANCHOR] Identifier anchors: EIDR 10.5240/ ISRC ISWC rights identifiers. System of record: Rightsline. [DEMO-FITNESS] MVM demo-fitness: Churn prediction & win-back (D2C SVOD) [rating=5/5, status=done]; Rights availability & windowing [rating=5/5, status=best-in-class]; Linear playout + as-run reconciliation [rating=5/5, status=complete]; Production cost & budget vs. actuals [rating=4/5, status=strong]; Compliance / regulatory reporting [rating=5/5, status=complete]; Overall bottom-line [rating=n/a/5, status=substantially above average]';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` (
    `holdback_id` BIGINT COMMENT 'Unique identifier for the holdback restriction record. Primary key.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Holdbacks restrict specific rights grants. Each holdback applies to one rights grant, establishing which exploitation rights are being restricted. This FK enables tracing holdback restrictions back to',
    `license_agreement_id` BIGINT COMMENT 'Reference to the source license agreement that establishes this holdback restriction.',
    `media_asset_id` BIGINT COMMENT 'Reference to the content asset subject to this holdback restriction.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Talent exclusivity clauses in contracts create talent-driven holdbacks on specific platforms/channels. The Talent Exclusivity Holdback Enforcement process requires linking the holdback restriction t',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Holdbacks apply to specific territories. Each holdback restricts one territory. Normalizing to territory reference eliminates redundant territory string storage and enables consistent territory metada',
    `automated_enforcement_flag` BOOLEAN COMMENT 'Indicates whether this holdback restriction is automatically enforced by scheduling and distribution systems or requires manual review.',
    `carriage_negotiation_reference` STRING COMMENT 'Reference identifier to the MVPD or vMVPD carriage negotiation that established this holdback restriction.',
    `conflict_resolution_notes` STRING COMMENT 'Documentation of any conflicts with other rights, windows, or holdbacks and how they were resolved.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this holdback restriction record was first created in the system.',
    `duration_days` STRING COMMENT 'Total number of days the holdback restriction is in effect, calculated from start to end date.',
    `end_date` DATE COMMENT 'Date when the holdback restriction expires and the content becomes available for exploitation on the previously restricted platform, territory, channel, or format.',
    `exclusivity_scope` STRING COMMENT 'Scope of exclusivity granted by this holdback, defining whether the restriction is absolute or allows limited exploitation.. Valid values are `full_exclusive|partial_exclusive|non_exclusive`',
    `last_modified_by` STRING COMMENT 'User or system identifier that last modified this holdback restriction record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this holdback restriction record was last updated or modified.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether notification of this holdback restriction has been sent to relevant scheduling, distribution, and operations teams.',
    `restricted_channel` STRING COMMENT 'Specific broadcast or distribution channel that is restricted from airing or distributing the content during the holdback period.',
    `restricted_platform` STRING COMMENT 'Name or identifier of the platform, distributor, or service that is restricted from exploiting the content during the holdback period. Applies to platform_holdback restriction types.',
    `source_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `start_date` DATE COMMENT 'Date when the holdback restriction becomes effective and the content is blocked from the specified platform, territory, channel, or format.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `waiver_approved_by` STRING COMMENT 'Name or identifier of the person or role who authorized the waiver or override of the holdback restriction.',
    `waiver_approved_date` DATE COMMENT 'Date when the waiver or override of the holdback restriction was officially approved.',
    `waiver_reason` STRING COMMENT 'Business justification or explanation for waiving or overriding the holdback restriction, if applicable.',
    `windowing_strategy_notes` STRING COMMENT 'Additional notes or context explaining how this holdback fits into the overall content windowing and sequential release strategy.',
    `created_by` STRING COMMENT 'User or system identifier that created this holdback restriction record.',
    CONSTRAINT pk_holdback PRIMARY KEY(`holdback_id`)
) COMMENT 'Records exclusivity holdback restrictions that prevent a content asset from being exploited on a specific platform, territory, or channel during a defined period. Each holdback captures the restriction type (platform holdback, territory holdback, channel holdback, format holdback), the restricted platform or distributor, holdback start and end dates, the triggering window type and source window reference, the source license agreement, and enforcement status (active, expired, waived, overridden). Holdbacks are enforced by the clearance workflow before any scheduling or distribution action is approved. Critical for MVPD carriage negotiations, OTT windowing compliance, and theatrical-to-home-video sequencing. Links to rights_content_window and license_agreement. [VENDOR-ANCHOR] Identifier anchors: EIDR 10.5240/ ISRC ISWC rights identifiers. System of record: Rightsline. [DEMO-FITNESS] MVM demo-fitness: Churn prediction & win-back (D2C SVOD) [rating=5/5, status=done]; Rights availability & windowing [rating=5/5, status=best-in-class]; Linear playout + as-run reconciliation [rating=5/5, status=complete]; Production cost & budget vs. actuals [rating=4/5, status=strong]; Compliance / regulatory reporting [rating=5/5, status=complete]; Overall bottom-line [rating=n/a/5, status=substantially above average]';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` (
    `territory_id` BIGINT COMMENT 'Unique identifier for the geographic territory. Primary key.',
    `blackout_restricted_flag` BOOLEAN COMMENT 'Indicates whether the territory is subject to geographic blackout restrictions for certain content (e.g., sports events, theatrical windows). True if blackouts apply, False otherwise.',
    `content_rating_system` STRING COMMENT 'Official content classification and rating system used in the territory (e.g., TV-MA/TV-PG for USA, BBFC for UK, FSK for Germany). Governs age-appropriate content labeling and parental controls.',
    `coppa_applicable_flag` BOOLEAN COMMENT 'Indicates whether the territory is subject to COPPA regulations governing childrens data privacy (USA). True if COPPA applies, False otherwise. Enforces parental consent for childrens content and data collection.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the territory record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `effective_date` DATE COMMENT 'Date when the territory record became active and available for rights grants and distribution agreements. Format: yyyy-MM-dd.',
    `expiration_date` DATE COMMENT 'Date when the territory record expires or is no longer valid for new rights grants (nullable for indefinite territories). Format: yyyy-MM-dd.',
    `gdpr_applicable_flag` BOOLEAN COMMENT 'Indicates whether the territory is subject to GDPR data privacy regulations (EU member states and EEA). True if GDPR applies, False otherwise. Governs audience data collection and consent management.',
    `holdback_eligible_flag` BOOLEAN COMMENT 'Indicates whether the territory is eligible for holdback periods in windowing strategies (e.g., delaying SVOD release to protect theatrical revenue). True if holdbacks apply, False otherwise.',
    `internet_penetration_percent` DECIMAL(18,2) COMMENT 'Percentage of the population with internet access in the territory (e.g., 95.00 for USA, 60.00 for India). Used for OTT and streaming market opportunity assessment.',
    `language_primary` STRING COMMENT 'ISO 639-1 or ISO 639-2 code for the primary language spoken in the territory (e.g., en for English, es for Spanish, fr for French). Used for metadata localization and subtitle requirements.. Valid values are `^[a-z]{2,3}$`',
    `language_secondary` STRING COMMENT 'ISO 639-1 or ISO 639-2 code for a secondary or co-official language in the territory (e.g., fr for Canada, ca for Spain). Supports multi-language content delivery and compliance.. Valid values are `^[a-z]{2,3}$`',
    `mechanical_licensing_body` STRING COMMENT 'Mechanical licensing authority in this territory (MLC, MCPS, etc.).',
    `territory_name` STRING COMMENT 'Full official name of the territory (e.g., United States, United Kingdom, Canada). Human-readable identifier used in contracts and reporting.',
    `neighbouring_rights_society` STRING COMMENT 'Neighbouring rights collection society in this territory.',
    `notes` STRING COMMENT 'Free-text field for additional territory-specific information, special handling instructions, or regulatory nuances (e.g., Requires local dubbing for theatrical release, Subject to military censorship).',
    `ott_market_maturity` STRING COMMENT 'Classification of the territorys OTT streaming market maturity: mature (high penetration, competitive), developing (growing adoption), emerging (early stage), nascent (minimal infrastructure). Informs distribution strategy and rights pricing.. Valid values are `mature|developing|emerging|nascent`',
    `population` BIGINT COMMENT 'Total population of the territory. Used for audience reach estimation, market sizing, and rights valuation.',
    `quota_percentage` DECIMAL(18,2) COMMENT 'Minimum percentage of local or regional content required by regulation in the territory (e.g., 30.00 for EU, 0.00 for territories without quotas). Used for compliance reporting and content acquisition planning.',
    `quota_requirement_flag` BOOLEAN COMMENT 'Indicates whether the territory mandates local content quotas for broadcasters and streaming platforms (e.g., EU Audiovisual Media Services Directive requiring 30% European content). True if quotas apply, False otherwise.',
    `regulatory_body` STRING COMMENT 'Primary broadcast and media regulatory authority governing the territory (e.g., FCC for USA, Ofcom for UK, CRTC for Canada). Enforces content standards, licensing, and compliance requirements.',
    `source_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `territory_group` STRING COMMENT 'Regional grouping of the territory used for rights aggregation and windowing strategies (e.g., EMEA, LATAM, North America, Worldwide, APAC). Enables multi-territory licensing and holdback management. [ENUM-REF-CANDIDATE: worldwide|north_america|latin_america|emea|apac|europe|asia|africa|middle_east|oceania — 10 candidates stripped; promote to reference product]',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the territory (e.g., America/New_York, Europe/London, Asia/Tokyo). Used for scheduling, playout, and live event coordination.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the territory record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `vat_applicable_flag` BOOLEAN COMMENT 'Indicates whether Value-Added Tax (VAT) or Goods and Services Tax (GST) applies to transactions in the territory. True if VAT/GST applies, False otherwise. Used for royalty and subscription billing calculations.',
    `vat_rate_percent` DECIMAL(18,2) COMMENT 'Standard VAT or GST rate percentage applicable in the territory (e.g., 20.00 for UK, 19.00 for Germany, 0.00 for territories without VAT). Used for financial reconciliation and revenue recognition.',
    `withholding_tax_rate_percent` DECIMAL(18,2) COMMENT 'Standard withholding tax rate percentage applied to royalty payments to rights holders in the territory (e.g., 30.00 for USA non-resident aliens, 0.00 for domestic). Used for talent residuals and royalty calculations.',
    CONSTRAINT pk_territory PRIMARY KEY(`territory_id`)
) COMMENT 'Reference master for geographic territories and territory groups used in rights grants, holdbacks, and royalty calculations. Each record defines a territory by ISO country code, territory name, territory group (e.g., EMEA, LATAM, North America, Worldwide), broadcast regulatory body (FCC, Ofcom, etc.), currency, and whether the territory is subject to blackout restrictions. Provides the standardized territory taxonomy consumed by all rights, scheduling, and distribution products. [VENDOR-ANCHOR] Identifier anchors: EIDR 10.5240/ ISRC ISWC rights identifiers. System of record: Rightsline. [DEMO-FITNESS] MVM demo-fitness: Churn prediction & win-back (D2C SVOD) [rating=5/5, status=done]; Rights availability & windowing [rating=5/5, status=best-in-class]; Linear playout + as-run reconciliation [rating=5/5, status=complete]; Production cost & budget vs. actuals [rating=4/5, status=strong]; Compliance / regulatory reporting [rating=5/5, status=complete]; Overall bottom-line [rating=n/a/5, status=substantially above average]';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` (
    `royalty_rule_id` BIGINT COMMENT 'Unique identifier for the royalty calculation rule. Primary key.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Royalty rules may apply to specific rights grants. Each rule may apply to one rights grant, defining how royalties are calculated for that grant. This FK enables tracing royalty rules back to the spec',
    `guild_affiliation_id` BIGINT COMMENT 'Foreign key linking to talent.guild_affiliation. Business justification: Royalty rules in broadcasting are directly derived from guild CBAs (SAG-AFTRA, WGA, DGA residual formulas). The CBA-Governed Royalty Rule Definition process requires linking each royalty rule to the',
    `license_agreement_id` BIGINT COMMENT 'Reference to the parent license agreement or rights grant to which this royalty rule applies. Links this rule to the contract context in Rightsline.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Star talent negotiates bespoke royalty rules (most-favored-nations clauses, backend participation rates) that override standard CBA rates. Talent-Specific Royalty Rule Override is a standard broadca',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who approved this royalty rule. Nullable if not yet approved.',
    `approved_date` DATE COMMENT 'Date on which this royalty rule was approved. Nullable if not yet approved.',
    `audit_rights_flag` BOOLEAN COMMENT 'Indicates whether the rights holder has audit rights to verify royalty calculations under this rule. True if audit rights are granted, False otherwise.',
    `calculation_basis` STRING COMMENT 'The financial or usage metric upon which the royalty calculation is based (e.g., gross revenue, net revenue, subscriber count, stream count, GRP). [ENUM-REF-CANDIDATE: gross_revenue|net_revenue|subscriber_count|stream_count|grp|unit_sales|advertising_revenue — 7 candidates stripped; promote to reference product]',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this royalty rule record was first created in the system.',
    `deduction_allowed_flag` BOOLEAN COMMENT 'Indicates whether deductions (e.g., distribution costs, marketing expenses) are allowed before calculating the royalty. True if deductions are permitted, False otherwise.',
    `deduction_percentage` DECIMAL(18,2) COMMENT 'The percentage of revenue or basis that may be deducted before applying the royalty rate. Nullable if no deduction applies.',
    `effective_end_date` DATE COMMENT 'The date on which this royalty rule ceases to be active. Nullable for open-ended rules.',
    `effective_start_date` DATE COMMENT 'The date from which this royalty rule becomes active and applicable to royalty calculations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this royalty rule record was last updated or modified.',
    `maximum_cap_amount` DECIMAL(18,2) COMMENT 'The maximum royalty payment cap for this rule. Royalty calculations will not exceed this amount. Nullable if no cap applies.',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'The minimum guaranteed royalty payment amount for this rule, regardless of calculated royalty. Nullable if no minimum guarantee applies.',
    `notes` STRING COMMENT 'Free-text notes or comments about this royalty rule, including special conditions, exceptions, or clarifications.',
    `payment_frequency` STRING COMMENT 'The frequency at which royalty payments calculated by this rule are made (e.g., monthly, quarterly, semi-annually, annually, per event, on demand).. Valid values are `monthly|quarterly|semi_annually|annually|per_event|on_demand`',
    `payment_timing` STRING COMMENT 'The timing of royalty payments relative to the calculation period (e.g., advance, arrears, upon delivery, upon release, milestone-based).. Valid values are `advance|arrears|upon_delivery|upon_release|milestone_based`',
    `rate_unit` STRING COMMENT 'The unit of measure for the rate value (e.g., percentage, per stream, per subscriber, per unit, per GRP, flat amount).. Valid values are `percentage|per_stream|per_subscriber|per_unit|per_grp|flat_amount`',
    `rate_value` DECIMAL(18,2) COMMENT 'The numeric rate or percentage applied in the royalty calculation. For percentage-based royalties, this is the percentage (e.g., 15.5 for 15.5%). For per-unit rates, this is the amount per unit.',
    `recoupment_flag` BOOLEAN COMMENT 'Indicates whether this royalty rule includes recoupment provisions (e.g., advance payments must be recouped before additional royalties are paid). True if recoupment applies, False otherwise.',
    `recoupment_threshold` DECIMAL(18,2) COMMENT 'The monetary threshold that must be recouped before additional royalty payments are made. Nullable if no recoupment applies.',
    `residual_formula` STRING COMMENT 'The formula or calculation logic for residual payments to talent (actors, directors, writers) based on reuse, reruns, or secondary exploitation. Nullable if not applicable.',
    `royalty_rule_status` STRING COMMENT 'Current lifecycle status of the royalty rule (e.g., draft, active, suspended, expired, terminated).. Valid values are `draft|active|suspended|expired|terminated`',
    `royalty_type` STRING COMMENT 'The type of royalty calculation method applied by this rule. Determines how the royalty amount is computed.. Valid values are `flat_fee|revenue_share_percentage|per_stream_rate|per_unit_rate|residual_formula|minimum_guarantee`',
    `rule_name` STRING COMMENT 'Human-readable name or title of the royalty rule, describing its purpose or scope (e.g., SVOD Revenue Share - Tier 1, Per-Stream Rate - Music Sync).',
    `rule_priority` STRING COMMENT 'The priority or precedence of this royalty rule when multiple rules may apply to the same content or transaction. Lower numbers indicate higher priority.',
    `source_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `territory_scope` STRING COMMENT 'Geographic territory or territories to which this royalty rule applies. May be a single country code, region, or comma-separated list of territories.',
    `threshold_unit` STRING COMMENT 'The unit of measure for the threshold value (e.g., revenue, subscriber count, stream count, unit count, GRP).. Valid values are `revenue|subscriber_count|stream_count|unit_count|grp`',
    `threshold_value` DECIMAL(18,2) COMMENT 'The threshold value that triggers a rate tier change or special calculation logic (e.g., revenue threshold for tiered royalty rates).',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    CONSTRAINT pk_royalty_rule PRIMARY KEY(`royalty_rule_id`)
) COMMENT 'Defines the royalty calculation rules and rate structures associated with a license agreement or rights grant. Captures royalty type (flat fee, revenue share percentage, per-stream rate, per-unit rate, residual formula), calculation basis (gross revenue, net revenue, subscriber count, stream count, GRP), applicable platform or exploitation type, rate tiers and thresholds, minimum guarantee amounts, and effective date range. Serves as the configuration engine for the royalty calculation process in Rightsline. Distinct from actual royalty payment transactions. [VENDOR-ANCHOR] Identifier anchors: EIDR 10.5240/ ISRC ISWC rights identifiers. System of record: Rightsline. [DEMO-FITNESS] MVM demo-fitness: Churn prediction & win-back (D2C SVOD) [rating=5/5, status=done]; Rights availability & windowing [rating=5/5, status=best-in-class]; Linear playout + as-run reconciliation [rating=5/5, status=complete]; Production cost & budget vs. actuals [rating=4/5, status=strong]; Compliance / regulatory reporting [rating=5/5, status=complete]; Overall bottom-line [rating=n/a/5, status=substantially above average]';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` (
    `royalty_statement_id` BIGINT COMMENT 'Unique identifier for the royalty statement. Primary key.',
    `guild_affiliation_id` BIGINT COMMENT 'Foreign key linking to talent.guild_affiliation. Business justification: Royalty statements governed by guild CBAs (SAG-AFTRA, WGA, DGA) require direct reference to the specific guild affiliation and CBA version that governs the calculation. Guild-Governed Royalty Stateme',
    `holder_id` BIGINT COMMENT 'Identifier of the rights holder (licensor, talent guild, music publisher, or syndication partner) to whom this statement is issued. Links to the party receiving royalty payments.',
    `license_agreement_id` BIGINT COMMENT 'Identifier of the underlying rights agreement or contract that governs the royalty terms for this statement.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Talent performance royalty statements (SAG-AFTRA residuals, neighbouring rights) are issued directly to performing talent, distinct from rights holder royalty statements. The existing holder_id covers',
    `royalty_rule_id` BIGINT COMMENT 'Foreign key linking to rights.royalty_rule. Business justification: A royalty_statement is computed by applying a specific royalty_rule (rate structure, calculation basis, deduction rules). Linking royalty_statement.royalty_rule_id → royalty_rule.royalty_rule_id estab',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Net adjustment amount applied to this statement for corrections, credits, or debits from prior periods.',
    `advance_recoupment_amount` DECIMAL(18,2) COMMENT 'Amount deducted from gross royalties to recoup advances previously paid to the rights holder under the agreement.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or system that approved this royalty statement for payment.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this royalty statement was approved for payment.',
    `content_title_breakdown` STRING COMMENT 'Structured breakdown of royalties by content title or asset. Stored as JSON or delimited string for detailed reporting.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this royalty statement record was first created in the system.',
    `currency_code` STRING COMMENT '',
    `dispute_date` DATE COMMENT 'The date on which the rights holder formally disputed this royalty statement.',
    `dispute_reason` STRING COMMENT 'Explanation or reason provided by the rights holder if the statement status is disputed. Captures objections to calculations, missing revenues, or contractual interpretation issues.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert foreign currency revenues to the statement currency, if applicable. Rate is typically the average rate for the statement period.',
    `exploitation_type_breakdown` STRING COMMENT 'Structured breakdown of royalties by exploitation type (theatrical, SVOD, AVOD, TVOD, linear, syndication, home video, etc.). Stored as JSON or delimited string for detailed reporting.',
    `gross_royalty_amount` DECIMAL(18,2) COMMENT 'Total royalty amount earned by the rights holder before any deductions, recoupments, or adjustments.',
    `mechanical_royalty_flag` BOOLEAN COMMENT 'Whether this statement includes mechanical royalties.',
    `minimum_guarantee_shortfall` DECIMAL(18,2) COMMENT 'The difference between the contractual minimum guarantee and actual royalties earned for the period. A positive value indicates the rights holder is entitled to a minimum guarantee payment.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this royalty statement record was last modified or updated.',
    `neighbouring_rights_flag` BOOLEAN COMMENT 'Whether this statement includes neighbouring rights royalties.',
    `net_royalty_amount` DECIMAL(18,2) COMMENT 'Final royalty amount payable to the rights holder after all deductions, recoupments, taxes, and adjustments. This is the amount that will be paid.',
    `paid_timestamp` TIMESTAMP COMMENT 'Date and time when payment for this royalty statement was successfully processed and remitted to the rights holder.',
    `payment_method` STRING COMMENT 'The payment instrument or method that will be used to remit the net royalty amount to the rights holder.. Valid values are `wire_transfer|check|ach|paypal|direct_deposit`',
    `payment_reference_number` STRING COMMENT 'Reference number or transaction identifier for the payment associated with this statement, once payment has been processed.',
    `resolution_date` DATE COMMENT 'The date on which a disputed statement was resolved and moved to approved or paid status.',
    `source_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `statement_due_date` DATE COMMENT 'The date by which payment of the royalties on this statement is contractually due to the rights holder.',
    `statement_frequency` STRING COMMENT 'The reporting frequency for this royalty statement as defined in the underlying rights agreement.. Valid values are `monthly|quarterly|semi-annual|annual|ad-hoc`',
    `statement_issue_date` DATE COMMENT 'The date on which this royalty statement was officially issued to the rights holder.',
    `statement_notes` STRING COMMENT 'Free-text notes or comments related to this royalty statement, including explanations of unusual adjustments, special circumstances, or clarifications for the rights holder.',
    `statement_number` STRING COMMENT 'Externally-known unique business identifier for this royalty statement, used for reference in correspondence and payment processing.. Valid values are `^[A-Z0-9]{6,20}$`',
    `statement_period_end_date` DATE COMMENT 'The last date of the reporting period covered by this royalty statement.',
    `statement_period_start_date` DATE COMMENT 'The first date of the reporting period covered by this royalty statement.',
    `statement_status` STRING COMMENT '',
    `territory_breakdown` STRING COMMENT 'Structured breakdown of royalties by geographic territory or market. Stored as JSON or delimited string for detailed reporting.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Tax amount withheld from royalty payment as required by applicable tax treaties and regulations.',
    CONSTRAINT pk_royalty_statement PRIMARY KEY(`royalty_statement_id`)
) COMMENT 'Periodic royalty statement generated for a rights holder (licensor, talent guild, music publisher, or syndication partner) covering a specific reporting period. Captures statement period (monthly, quarterly, semi-annual), total royalties due, breakdown by exploitation type and territory, advance recoupment amounts, minimum guarantee shortfall, currency, exchange rate applied, and statement status (draft, approved, disputed, paid). The SSOT for royalty obligations owed to external rights holders. Feeds the billing domain for payment processing. [VENDOR-ANCHOR] Identifier anchors: EIDR 10.5240/ ISRC ISWC rights identifiers. System of record: Rightsline. [DEMO-FITNESS] MVM demo-fitness: Churn prediction & win-back (D2C SVOD) [rating=5/5, status=done]; Rights availability & windowing [rating=5/5, status=best-in-class]; Linear playout + as-run reconciliation [rating=5/5, status=complete]; Production cost & budget vs. actuals [rating=4/5, status=strong]; Compliance / regulatory reporting [rating=5/5, status=complete]; Overall bottom-line [rating=n/a/5, status=substantially above average]';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` (
    `clearance_request_id` BIGINT COMMENT 'Unique identifier for the rights clearance request. Primary key for the clearance request workflow record.',
    `content_window_id` BIGINT COMMENT 'Foreign key linking to rights.rights_content_window. Business justification: A clearance_request is initiated to clear a specific content exploitation window before scheduling. Linking clearance_request.rights_content_window_id → rights_content_window.rights_content_window_id ',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.rights_grant. Business justification: Clearance requests validate against specific rights grants to determine if exploitation is permitted. Each clearance request checks one rights grant for authorization. This FK enables validation of ex',
    `holdback_id` BIGINT COMMENT 'Foreign key linking to rights.holdback. Business justification: Clearance requests may be blocked by specific holdbacks. Each clearance request may reference one blocking holdback that prevents exploitation. This FK enables tracing clearance denials back to the sp',
    `license_agreement_id` BIGINT COMMENT 'Reference to the primary licensing agreement that governs the requested exploitation. Links to the contract record in Rightsline that defines available windows, territories, and restrictions.',
    `media_asset_id` BIGINT COMMENT 'Reference to the content asset requiring clearance verification before broadcast, streaming, or distribution. Links to the digital asset managed in Dalet Galaxy MAM.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Clearance requests with talent_approval_required flag need to identify WHICH talent must approve. The Talent Clearance Approval process (SAG-AFTRA, likeness rights) requires direct linkage to the ',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.territory. Business justification: Clearance requests are for specific territories. Each request relates to one territory. Normalizing to territory reference eliminates redundant territory code storage and enables consistent territory ',
    `analyst_notes` STRING COMMENT 'Free-text notes and observations recorded by the clearance analyst during review. May include references to specific contract clauses, communications with rights holders, or special handling instructions.',
    `blocking_reason` STRING COMMENT 'Detailed explanation of why a clearance request was blocked or denied. May reference specific contract clauses, holdback periods, territorial restrictions, or missing rights. Null if request is cleared.',
    `clearance_decision` STRING COMMENT 'Final determination made by the clearance analyst regarding whether the content may be exploited as requested. Approved with conditions may require specific usage restrictions or additional payments.. Valid values are `approved|approved_with_conditions|denied|pending_review`',
    `conditional_requirements` STRING COMMENT 'Specific conditions or restrictions that must be met for conditional clearance approval. May include required credits, usage limitations, geographic blackouts, or additional royalty payments.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the clearance request record was first created in the database. Part of standard audit trail for data lineage and compliance.',
    `escalation_reason` STRING COMMENT 'Explanation of why the clearance request required escalation beyond standard analyst review. May reference contract ambiguity, conflicting rights claims, or high-value strategic decisions.',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time when the clearance request was escalated to senior rights management or legal counsel due to complexity, ambiguity, or high business impact. Null if no escalation occurred.',
    `estimated_audience_reach` BIGINT COMMENT 'Projected number of unique viewers or households expected to access the content in the requested exploitation. Used for royalty calculations and rights holder reporting.',
    `estimated_grp` DECIMAL(18,2) COMMENT 'Projected Gross Rating Point value for the scheduled broadcast or streaming event. GRP represents the sum of ratings achieved by the content and may trigger tiered royalty obligations.',
    `estimated_residuals_amount` DECIMAL(18,2) COMMENT 'Projected total residual payments owed to talent if the clearance is approved and content is distributed. Used for financial planning and budget approval workflows.',
    `integration_status` STRING COMMENT 'Status of data synchronization between Rightsline clearance system and downstream scheduling and playout systems (Ericsson MediaFirst). Ensures cleared content is automatically released to scheduling workflows.. Valid values are `pending_sync|synced_to_scheduling|synced_to_playout|sync_failed`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to any field in the clearance request record. Enables change tracking and audit trail for compliance and operational monitoring.',
    `music_clearance_required` BOOLEAN COMMENT 'Indicates whether separate music synchronization licenses must be verified before content can be cleared for distribution. True if content contains licensed music requiring additional clearance.',
    `platform_channel` STRING COMMENT 'Specific platform, channel, or outlet where the content is intended to be distributed (e.g., HBO Max, NBC Network, YouTube, Hulu). Used to verify platform-specific licensing restrictions.',
    `request_number` STRING COMMENT 'Human-readable business identifier for the clearance request, typically formatted as CLR-YYYYMMDD sequence for tracking and reference in scheduling and distribution workflows.. Valid values are `^CLR-[0-9]{8}$`',
    `request_submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the clearance request was initially submitted into the workflow system. Marks the start of the clearance review lifecycle and SLA clock.',
    `requested_air_date` DATE COMMENT 'The target date when the content is scheduled to be broadcast, streamed, or published. Critical for verifying that rights are available within the requested window and that no holdback periods are violated.',
    `requested_air_time` TIMESTAMP COMMENT 'Precise timestamp for the intended broadcast or streaming start time, including time zone. Used for daypart-specific rights verification and scheduling coordination.',
    `requesting_department` STRING COMMENT 'Business unit or department initiating the clearance request. Identifies which operational area needs rights verification before proceeding with content exploitation.. Valid values are `scheduling|distribution|production|programming|digital|syndication`',
    `residuals_triggered` BOOLEAN COMMENT 'Indicates whether the requested exploitation will trigger residual payments to talent per guild agreements. True if reuse payments are required for this distribution window.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the clearance request was finalized with a cleared, blocked, or conditionally cleared decision. Marks the end of the clearance workflow and enables SLA compliance measurement.',
    `review_started_timestamp` TIMESTAMP COMMENT 'Date and time when a clearance analyst began active review of the request. Used to measure queue time and analyst response performance.',
    `sla_met` BOOLEAN COMMENT 'Indicates whether the clearance request was resolved within the defined SLA target hours. Used for operational performance reporting and process improvement.',
    `sla_target_hours` STRING COMMENT 'Number of business hours within which the clearance request must be resolved per service level agreement. Varies by priority level (urgent requests have shorter SLA targets).',
    `source_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `talent_approval_required` BOOLEAN COMMENT 'Indicates whether talent (actors, directors, producers) approval or notification is contractually required before the requested exploitation. True if talent has approval rights per guild agreements or individual contracts.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    CONSTRAINT pk_clearance_request PRIMARY KEY(`clearance_request_id`)
) COMMENT 'Workflow record capturing a rights clearance request initiated before a content asset is scheduled for broadcast, streaming, or distribution. Tracks the requesting department (scheduling, distribution, production), content asset, intended exploitation type and platform, requested air or publish date, territory, clearance status (pending, cleared, conditionally cleared, blocked, escalated), blocking reason if applicable, assigned clearance analyst, and resolution date. Enforces the clearance gate that prevents unlicensed content from reaching playout or distribution systems. Integrates with Ericsson MediaFirst scheduling and Rightsline availabilities. [VENDOR-ANCHOR] Identifier anchors: EIDR 10.5240/ ISRC ISWC rights identifiers. System of record: Rightsline. [DEMO-FITNESS] MVM demo-fitness: Churn prediction & win-back (D2C SVOD) [rating=5/5, status=done]; Rights availability & windowing [rating=5/5, status=best-in-class]; Linear playout + as-run reconciliation [rating=5/5, status=complete]; Production cost & budget vs. actuals [rating=4/5, status=strong]; Compliance / regulatory reporting [rating=5/5, status=complete]; Overall bottom-line [rating=n/a/5, status=substantially above average]';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` (
    `holder_id` BIGINT COMMENT 'Unique identifier for the rights holder entity. Primary key for the rights holder master record.',
    `audit_rights_flag` BOOLEAN COMMENT 'Indicates whether this rights holder has contractual audit rights to review revenue reporting and royalty calculations. True requires enhanced documentation retention.',
    `bank_account_name` STRING COMMENT 'Name on the bank account designated for royalty payments. Must match legal entity name for payment processing compliance.',
    `bank_account_number` STRING COMMENT 'Bank account number for royalty payment remittance. Encrypted at rest and in transit per PCI DSS requirements.',
    `bank_routing_number` STRING COMMENT 'Bank routing number or SWIFT/BIC code for international wire transfers. Used for automated royalty payment processing.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rights holder record was first created in the system. Used for audit trail and data lineage tracking.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit exposure allowed for advance payments or minimum guarantees to this rights holder. Used for financial risk management.',
    `default_royalty_rate` DECIMAL(18,2) COMMENT 'Default royalty rate percentage applied to new agreements with this rights holder. Can be overridden at the contract level.',
    `exclusivity_preference` STRING COMMENT 'Rights holders stated preference for exclusivity terms in licensing agreements. Influences windowing strategy and holdback negotiations.. Valid values are `exclusive_only|non_exclusive_preferred|flexible|no_preference`',
    `guild_affiliation` STRING COMMENT 'Name of talent guild or performing rights organization (PRO) that this rights holder is affiliated with. Determines residual payment rules and reporting requirements. [ENUM-REF-CANDIDATE: sag_aftra|wga|dga|afm|ascap|bmi|sesac|gema|prs|socan — promote to reference product]',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified this rights holder record. Used for audit trail and change accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this rights holder record was last updated. Used for change tracking and data synchronization.',
    `minimum_guarantee_threshold` DECIMAL(18,2) COMMENT 'Minimum guarantee amount threshold below which this rights holder will not enter licensing agreements. Used for deal structuring and negotiation.',
    `most_favored_nations_flag` BOOLEAN COMMENT 'Indicates whether this rights holder has most favored nations clause requiring rate parity with other similar rights holders. True triggers rate comparison workflows.',
    `music_publisher_flag` BOOLEAN COMMENT 'Whether this holder is a music publisher.',
    `notes` STRING COMMENT 'Free-text notes capturing special handling instructions, negotiation history, relationship nuances, or other contextual information for this rights holder.',
    `payment_method` STRING COMMENT 'Preferred payment method for royalty disbursements. Determines processing fees and settlement timelines.. Valid values are `wire_transfer|ach|check|paypal|international_wire`',
    `payment_terms_days` STRING COMMENT 'Standard payment terms in days from invoice date for royalty payments to this rights holder. Typical values include 30, 60, or 90 days net.',
    `preferred_currency` STRING COMMENT 'Three-letter ISO currency code representing the rights holders preferred currency for royalty payments and contract valuations.. Valid values are `^[A-Z]{3}$`',
    `primary_contact_email` STRING COMMENT 'Primary email address for the rights holder contact. Used for contract notifications, clearance communications, and royalty statements.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the rights holder organization for licensing negotiations, clearance requests, and royalty inquiries.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the rights holder contact. Used for urgent clearance issues and contract negotiations.',
    `pro_affiliation` STRING COMMENT 'Performing Rights Organization affiliation (ASCAP/BMI/SESAC/PRS).',
    `record_label_flag` BOOLEAN COMMENT 'Whether this holder is a record label.',
    `registrant_identifier` STRING COMMENT 'The ISAN or ISRC registrant identifier assigned to the rights holder by the respective international registration authority. Used for global rights tracking and content identification.',
    `relationship_end_date` DATE COMMENT 'Date when the business relationship with this rights holder was terminated or suspended. Null for active relationships.',
    `relationship_start_date` DATE COMMENT 'Date when the business relationship with this rights holder was established. Used for historical reporting and relationship tenure analysis.',
    `rights_holder_name` STRING COMMENT 'The full legal name of the rights holder entity as registered in their territory of incorporation. Used for contract execution and royalty payment identification.',
    `royalty_calculation_method` STRING COMMENT 'Standard royalty calculation methodology applied to this rights holders agreements. Determines how residuals and royalties are computed.. Valid values are `percentage_of_revenue|flat_fee|tiered_percentage|per_unit|hybrid`',
    `source_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `tax_identification_number` STRING COMMENT 'Tax identification number for the rights holder in their jurisdiction of incorporation. Required for tax reporting and withholding compliance.',
    `tax_withholding_rate` DECIMAL(18,2) COMMENT 'Applicable tax withholding rate percentage for royalty payments to this rights holder. Derived from tax treaties and domestic law based on withholding classification.',
    `territory_of_incorporation` STRING COMMENT 'Three-letter ISO country code representing the legal jurisdiction where the rights holder entity is incorporated or registered. Determines applicable tax treaties and withholding requirements.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `created_by` STRING COMMENT 'User identifier of the person who created this rights holder record. Used for audit trail and accountability.',
    CONSTRAINT pk_holder PRIMARY KEY(`holder_id`)
) COMMENT 'Master record for all external entities that hold intellectual property rights licensed to or from Media Broadcasting — including film studios, independent production companies, music publishers, performing rights organizations (PROs), talent guilds, record labels, news agencies, and individual creators. Captures rights holder name, entity type, ISAN or ISRC registrant identifier, primary contact, territory of incorporation, preferred currency, payment terms, and tax withholding classification. This is the SSOT for rights grantor and grantee identity within the rights domain, distinct from the partner domain which manages broader commercial relationships. [VENDOR-ANCHOR] Identifier anchors: EIDR 10.5240/ ISRC ISWC rights identifiers. System of record: Rightsline. [DEMO-FITNESS] MVM demo-fitness: Churn prediction & win-back (D2C SVOD) [rating=5/5, status=done]; Rights availability & windowing [rating=5/5, status=best-in-class]; Linear playout + as-run reconciliation [rating=5/5, status=complete]; Production cost & budget vs. actuals [rating=4/5, status=strong]; Compliance / regulatory reporting [rating=5/5, status=complete]; Overall bottom-line [rating=n/a/5, status=substantially above average]';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ADD CONSTRAINT `fk_rights_license_agreement_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ADD CONSTRAINT `fk_rights_grant_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ADD CONSTRAINT `fk_rights_grant_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ADD CONSTRAINT `fk_rights_content_window_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ADD CONSTRAINT `fk_rights_content_window_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ADD CONSTRAINT `fk_rights_content_window_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ADD CONSTRAINT `fk_rights_holdback_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ADD CONSTRAINT `fk_rights_holdback_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ADD CONSTRAINT `fk_rights_holdback_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ADD CONSTRAINT `fk_rights_royalty_rule_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ADD CONSTRAINT `fk_rights_royalty_rule_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_holder_id` FOREIGN KEY (`holder_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holder`(`holder_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ADD CONSTRAINT `fk_rights_royalty_statement_royalty_rule_id` FOREIGN KEY (`royalty_rule_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`royalty_rule`(`royalty_rule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_content_window_id` FOREIGN KEY (`content_window_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`content_window`(`content_window_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`grant`(`grant_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_holdback_id` FOREIGN KEY (`holdback_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`holdback`(`holdback_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ADD CONSTRAINT `fk_rights_clearance_request_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`rights`.`territory`(`territory_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`rights` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`rights` SET TAGS ('dbx_domain' = 'rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` SET TAGS ('dbx_subdomain' = 'license_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_column_comment_Unique_system_identifier_for_the_license_agreement_record_Primary_key_Role' = 'MASTER_AGREEMENT.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Licensor Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `holder_id` SET TAGS ('dbx_column_comment' = 'Reference to the party granting rights under this agreement (studio');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `holder_id` SET TAGS ('dbx_distributor' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `holder_id` SET TAGS ('dbx_music_publisher' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `holder_id` SET TAGS ('dbx_talent_guild' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `holder_id` SET TAGS ('dbx_production_company)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `holder_id` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `advance_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `advance_payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `advance_payment_amount` SET TAGS ('dbx_column_comment' = 'Upfront payment made upon execution of the agreement');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `advance_payment_amount` SET TAGS ('dbx_typically_recoupable_against_future_royalties_or_license_fees' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `advance_payment_amount` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_column_comment' = 'Externally-known unique business identifier for the license agreement');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_used_in_contracts_and_communications_with_rights_holders_and_licensees' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the agreement automatically renews at expiry unless terminated by either party. True = auto-renews');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_False' = 'expires at term end.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `blackout_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Blackout Restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `blackout_restrictions` SET TAGS ('dbx_column_comment' = 'Geographic or temporal restrictions on content availability (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `blackout_restrictions` SET TAGS ('dbx_no_broadcast_in_certain_markets_during_specific_events' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `blackout_restrictions` SET TAGS ('dbx_sports_blackout_rules)_Free_text_description' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `clearance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Clearance Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `clearance_required_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `clearance_required_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether additional rights clearance verification is required before content can be broadcast or distributed under this agreement. True = clearance workflow required');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `clearance_required_flag` SET TAGS ('dbx_False' = 'no additional clearance needed.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `content_rating_restriction` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Restriction');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `content_rating_restriction` SET TAGS ('dbx_column_comment' = 'Content rating limitations imposed by this agreement (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `content_rating_restriction` SET TAGS ('dbx_PG_13_and_below_only' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `content_rating_restriction` SET TAGS ('dbx_no_R_rated_content)_Comma_separated_list_of_allowed_ratings_per_MPA_or_TV_Parental_Guidelines' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `content_rating_restriction` SET TAGS ('dbx_regulation' = 'Ofcom');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'System timestamp when this license agreement record was first created in Rightsline.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_column_comment' = 'Date when the license agreement becomes legally binding and rights become available for exploitation. Start of the agreement term.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the license grants exclusive rights within the territory and media windows. True = exclusive');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_False' = 'non-exclusive.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_column_comment' = 'Date when the license agreement terminates and rights revert to the licensor. End of the agreement term. Nullable for perpetual agreements.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_column_comment' = 'Legal jurisdiction whose laws govern the interpretation and enforcement of this agreement (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_State_of_California' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_England_and_Wales' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_New_York)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_business_glossary_term' = 'Holdback Period (Days)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_column_comment' = 'Number of days during which content must be withheld from certain distribution windows to protect exclusivity in other windows (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_theatrical_holdback_before_SVOD_release)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_column_comment' = 'System timestamp when this license agreement record was last updated in Rightsline.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `mechanical_license_flag` SET TAGS ('dbx_business_glossary_term' = 'Mechanical License Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `media_rights_granted` SET TAGS ('dbx_business_glossary_term' = 'Media Rights Granted');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `media_rights_granted` SET TAGS ('dbx_column_comment' = 'Comma-separated list of media exploitation rights included in this agreement (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `media_rights_granted` SET TAGS ('dbx_linear_broadcast' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `media_rights_granted` SET TAGS ('dbx_SVOD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `media_rights_granted` SET TAGS ('dbx_AVOD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `media_rights_granted` SET TAGS ('dbx_TVOD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `media_rights_granted` SET TAGS ('dbx_theatrical' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `media_rights_granted` SET TAGS ('dbx_home_video' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `media_rights_granted` SET TAGS ('dbx_digital_download' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `media_rights_granted` SET TAGS ('dbx_mobile_streaming)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_column_comment' = 'Minimum guaranteed payment to the licensor regardless of actual usage or revenue performance. Common in output deals and syndication agreements.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `music_sync_license_flag` SET TAGS ('dbx_business_glossary_term' = 'Music Synchronization (Sync) License Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `music_sync_license_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `music_sync_license_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this agreement includes music synchronization rights for use of musical compositions in audiovisual content. True = music sync rights included');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `music_sync_license_flag` SET TAGS ('dbx_False' = 'no music sync rights.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `music_sync_license_flag` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `neighbouring_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Neighbouring Rights Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Free-text field for additional contractual terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_special_conditions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_or_internal_comments_about_the_agreement' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `payment_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `payment_schedule_type` SET TAGS ('dbx_value_regex' = 'lump sum|installments|per-episode|annual|milestone-based|revenue share');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `payment_schedule_type` SET TAGS ('dbx_column_comment' = 'Structure of the payment obligation. Determines how total_license_fee is disbursed over time.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `payment_schedule_type` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `per_episode_fee` SET TAGS ('dbx_business_glossary_term' = 'Per-Episode Fee');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `per_episode_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `per_episode_fee` SET TAGS ('dbx_column_comment' = 'License fee charged per episode for episodic content. Applicable to syndication and first-run syndication agreements.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term (Months)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_column_comment' = 'Duration in months of each automatic renewal period if auto_renewal_flag is true. Null if agreement does not auto-renew.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `residuals_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Residuals Obligation Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `residuals_obligation_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `residuals_obligation_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the agreement includes obligations to pay talent residuals for reuse of content. True = residuals required');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `residuals_obligation_flag` SET TAGS ('dbx_False' = 'no residuals.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `royalty_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Royalty Calculation Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `royalty_calculation_method` SET TAGS ('dbx_value_regex' = 'flat fee|percentage of revenue|tiered percentage|per-unit|hybrid');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `royalty_calculation_method` SET TAGS ('dbx_column_comment' = 'Method used to calculate ongoing royalty payments to the licensor. Determines how revenue is shared or how usage is monetized.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `royalty_percentage` SET TAGS ('dbx_business_glossary_term' = 'Royalty Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `royalty_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `royalty_percentage` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `royalty_percentage` SET TAGS ('dbx_column_comment' = 'Percentage of revenue or receipts paid to the licensor as ongoing royalties. Applicable when royalty_calculation_method is percentage-based.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `royalty_percentage` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `run_count_limit` SET TAGS ('dbx_business_glossary_term' = 'Run Count Limit');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `run_count_limit` SET TAGS ('dbx_column_comment' = 'Maximum number of times each episode or program may be broadcast or streamed under this agreement. Common in syndication deals. Null indicates unlimited runs.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_column_comment' = 'Date when the agreement was executed by all parties. May differ from effective_date.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `source_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `source_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `sublicensing_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Sublicensing Allowed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `sublicensing_allowed_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `sublicensing_allowed_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the licensee is permitted to sublicense the rights to third parties. True = sublicensing allowed');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `sublicensing_allowed_flag` SET TAGS ('dbx_False' = 'sublicensing prohibited.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_column_comment' = 'Number of days advance notice required by either party to terminate the agreement before expiry or renewal.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `territory_scope` SET TAGS ('dbx_column_comment' = 'Geographic territories covered by this license agreement. Comma-separated list of ISO 3166-1 alpha-3 country codes or region identifiers (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `territory_scope` SET TAGS ('dbx_USA' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `territory_scope` SET TAGS ('dbx_CAN' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `territory_scope` SET TAGS ('dbx_MEX_or_WORLDWIDE_or_EMEA)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `territory_scope` SET TAGS ('dbx_regulation' = 'Ofcom');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `total_license_fee` SET TAGS ('dbx_business_glossary_term' = 'Total License Fee');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `total_license_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `total_license_fee` SET TAGS ('dbx_column_comment' = 'Total contractual payment obligation for the license rights over the full term of the agreement. Sum of all payment milestones.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `total_license_fee` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `windowing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Windowing Strategy');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `windowing_strategy` SET TAGS ('dbx_column_comment' = 'Sequential release strategy defining the order and timing of content availability across distribution channels (theatrical');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `windowing_strategy` SET TAGS ('dbx_SVOD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `windowing_strategy` SET TAGS ('dbx_AVOD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `windowing_strategy` SET TAGS ('dbx_TVOD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `windowing_strategy` SET TAGS ('dbx_linear' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`license_agreement` ALTER COLUMN `windowing_strategy` SET TAGS ('dbx_syndication)_Free_text_description_of_the_windowing_plan' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` SET TAGS ('dbx_subdomain' = 'license_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `grant_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the rights grant record. Primary key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_column_comment' = 'Reference to the parent license agreement from which this grant is derived.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_column_comment' = 'Reference to the content asset (film');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_series' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_episode' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_music_track)_to_which_this_grant_applies' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `territory_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_rights_territory_Business_justification' = 'Rights grants apply to specific territories. Each rights grant covers one territory. Normalizing to territory reference eliminates redundant territory string storage and enables consistent territory m');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `territory_id` SET TAGS ('dbx_regulation' = 'Ofcom');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `blackout_applicable` SET TAGS ('dbx_business_glossary_term' = 'Blackout Applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `blackout_applicable` SET TAGS ('dbx_column_comment' = 'Indicates whether geographic or temporal blackout restrictions apply to this grant (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `blackout_applicable` SET TAGS ('dbx_sports_blackouts' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `blackout_applicable` SET TAGS ('dbx_regional_restrictions)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `carriage_fee_applicable` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `carriage_fee_applicable` SET TAGS ('dbx_column_comment' = 'Indicates whether a carriage fee (distribution payment) is associated with this grant.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `carriage_fee_applicable` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this rights grant record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `drm_required` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `drm_required` SET TAGS ('dbx_column_comment' = 'Indicates whether DRM protection is mandated for content distributed under this grant.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Grant End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `end_date` SET TAGS ('dbx_column_comment' = 'The date on which the rights grant expires and exploitation must cease. Nullable for perpetual grants.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `exclusivity_indicator` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `exclusivity_indicator` SET TAGS ('dbx_column_comment' = 'Indicates whether the grant is exclusive (true) or non-exclusive (false). Exclusive grants prevent other parties from exploiting the same rights in the same territory and window.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `grant_number` SET TAGS ('dbx_business_glossary_term' = 'Grant Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `grant_number` SET TAGS ('dbx_column_comment' = 'Business identifier for the rights grant');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `grant_number` SET TAGS ('dbx_typically_a_human_readable_code_used_in_Rightsline_and_operational_workflows' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `holdback_applicable` SET TAGS ('dbx_business_glossary_term' = 'Holdback Applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `holdback_applicable` SET TAGS ('dbx_column_comment' = 'Indicates whether a holdback period applies to this grant. Holdbacks restrict exploitation during specific windows to protect other distribution channels.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `holdback_end_date` SET TAGS ('dbx_business_glossary_term' = 'Holdback End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `holdback_end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `holdback_end_date` SET TAGS ('dbx_column_comment' = 'The end date of the holdback period');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `holdback_end_date` SET TAGS ('dbx_after_which_exploitation_may_resume_Nullable_if_no_holdback_applies' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `holdback_start_date` SET TAGS ('dbx_business_glossary_term' = 'Holdback Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `holdback_start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `holdback_start_date` SET TAGS ('dbx_column_comment' = 'The start date of any holdback period during which exploitation is restricted. Nullable if no holdback applies.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `language_version` SET TAGS ('dbx_business_glossary_term' = 'Language Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `language_version` SET TAGS ('dbx_column_comment' = 'Language version of the content covered by this grant (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `language_version` SET TAGS ('dbx_English' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `language_version` SET TAGS ('dbx_Spanish' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `language_version` SET TAGS ('dbx_French)_May_reference_dubbed' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `language_version` SET TAGS ('dbx_subtitled' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `language_version` SET TAGS ('dbx_or_original_language_versions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `language_version` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_column_comment' = 'Minimum guaranteed payment amount for this grant');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_regardless_of_actual_revenue_Nullable_if_no_MG_applies' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this rights grant record was last modified.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `music_sync_license_required` SET TAGS ('dbx_business_glossary_term' = 'Music Synchronization (Sync) License Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `music_sync_license_required` SET TAGS ('dbx_column_comment' = 'Indicates whether a separate music synchronization license is required for the music tracks embedded in the content.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `music_sync_license_required` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Grant Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Free-text notes capturing additional terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `notes` SET TAGS ('dbx_conditions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `notes` SET TAGS ('dbx_or_operational_instructions_related_to_this_grant' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_column_comment' = 'Percentage royalty rate applied to revenue generated under this grant. Used for royalty calculations.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `source_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `source_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Grant Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `start_date` SET TAGS ('dbx_column_comment' = 'The date on which the rights grant becomes effective and exploitation may begin.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `sublicense_permitted` SET TAGS ('dbx_business_glossary_term' = 'Sublicense Permitted');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `sublicense_permitted` SET TAGS ('dbx_column_comment' = 'Indicates whether the licensee is permitted to sublicense the rights to third parties.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `sublicense_permitted` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `talent_residuals_applicable` SET TAGS ('dbx_business_glossary_term' = 'Talent Residuals Applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `talent_residuals_applicable` SET TAGS ('dbx_column_comment' = 'Indicates whether talent residual payments (reuse payments to actors');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `talent_residuals_applicable` SET TAGS ('dbx_directors' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `talent_residuals_applicable` SET TAGS ('dbx_writers)_are_triggered_by_this_grant' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `window_name` SET TAGS ('dbx_business_glossary_term' = 'Window Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `window_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `window_name` SET TAGS ('dbx_column_comment' = 'Named distribution window (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `window_name` SET TAGS ('dbx_Theatrical' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `window_name` SET TAGS ('dbx_Premium_VOD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `window_name` SET TAGS ('dbx_Pay_TV' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `window_name` SET TAGS ('dbx_Free_TV)_that_this_grant_falls_within_Used_for_windowing_strategy_enforcement' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `window_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`grant` ALTER COLUMN `window_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` SET TAGS ('dbx_subdomain' = 'license_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `content_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Content Window Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `content_window_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the content window record. Primary key for the rights content window entity.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Agreement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_column_comment' = 'Reference to the parent rights agreement or license contract that governs this window. Links to the master rights agreement.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_column_comment' = 'Reference to the specific content asset (film');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_series' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_episode' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_program)_to_which_this_window_applies_Links_to_the_content_master_record' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `territory_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_rights_territory_Business_justification' = 'Content windows apply to specific territories. Each window covers one territory. Normalizing to territory reference eliminates redundant territory string storage and enables consistent territory metad');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `territory_id` SET TAGS ('dbx_regulation' = 'Ofcom');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `active_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `active_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this window record is currently active and should be considered in availability calculations. False if the window has been superseded');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `active_flag` SET TAGS ('dbx_cancelled' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `active_flag` SET TAGS ('dbx_or_archived' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_business_glossary_term' = 'Blackout Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether a geographic or temporal blackout restriction is currently active for this window. True if content is blacked out and cannot be distributed; false otherwise.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `blackout_reason` SET TAGS ('dbx_business_glossary_term' = 'Blackout Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `blackout_reason` SET TAGS ('dbx_column_comment' = 'The business or regulatory reason for the blackout restriction (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `blackout_reason` SET TAGS ('dbx_sports_event_local_blackout' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `blackout_reason` SET TAGS ('dbx_contractual_exclusivity' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `blackout_reason` SET TAGS ('dbx_regulatory_compliance)_Populated_only_when_blackout_flag_is_true' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `blackout_reason` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `blackout_reason` SET TAGS ('dbx_ENUM_REF_CANDIDATE' = 'promote-to-reference-product');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `clearance_notes` SET TAGS ('dbx_business_glossary_term' = 'Clearance Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `clearance_notes` SET TAGS ('dbx_column_comment' = 'Free-text notes documenting clearance issues');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `clearance_notes` SET TAGS ('dbx_pending_approvals' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `clearance_notes` SET TAGS ('dbx_conditional_restrictions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `clearance_notes` SET TAGS ('dbx_or_special_instructions_related_to_rights_clearance_for_this_window' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `created_by_user` SET TAGS ('dbx_column_comment' = 'The username or identifier of the user who created this window record. Audit field for accountability and compliance.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'The timestamp when this window record was first created in the system. Audit field for data lineage and compliance.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `drm_requirement` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Requirement');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `drm_requirement` SET TAGS ('dbx_value_regex' = 'widevine|fairplay|playready|none|multi_drm');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `drm_requirement` SET TAGS ('dbx_column_comment' = 'The DRM technology or protection scheme required for content distribution during this window. Enforces content protection and anti-piracy requirements specified in the rights agreement.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `geo_blocking_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Geo-Blocking Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `geo_blocking_required_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `geo_blocking_required_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether geographic blocking technology must be enforced to restrict access to the specified territory. True if geo-blocking is mandatory; false if not required.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `holdback_end_date` SET TAGS ('dbx_business_glossary_term' = 'Holdback End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `holdback_end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `holdback_end_date` SET TAGS ('dbx_column_comment' = 'The date when a holdback period ends and distribution is re-authorized. Marks the conclusion of the exclusivity restriction.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `holdback_start_date` SET TAGS ('dbx_business_glossary_term' = 'Holdback Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `holdback_start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `holdback_start_date` SET TAGS ('dbx_column_comment' = 'The date when a holdback period begins');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `holdback_start_date` SET TAGS ('dbx_temporarily_restricting_distribution_even_within_an_open_window_Used_to_enforce_exclusivity_periods_and_prevent_simultaneous_exploitation_across_competing_platforms' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `last_availability_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Availability Refresh Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `last_availability_refresh_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `last_availability_refresh_timestamp` SET TAGS ('dbx_column_comment' = 'The timestamp when the availability_status was last recalculated. Updated whenever upstream rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `last_availability_refresh_timestamp` SET TAGS ('dbx_holdback' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `last_availability_refresh_timestamp` SET TAGS ('dbx_or_blackout_records_change_Used_to_track_data_freshness_for_scheduling_and_distribution_systems' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `license_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'License Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `license_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `license_fee_amount` SET TAGS ('dbx_column_comment' = 'The monetary fee paid by the platform or distributor for the rights to exploit the content during this window. May be a flat fee');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `license_fee_amount` SET TAGS ('dbx_minimum_guarantee' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `license_fee_amount` SET TAGS ('dbx_or_advance_against_royalties' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `license_fee_amount` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `license_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'License Fee Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `license_fee_currency` SET TAGS ('dbx_column_comment' = 'The three-letter ISO 4217 currency code for the license fee amount (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `license_fee_currency` SET TAGS ('dbx_USD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `license_fee_currency` SET TAGS ('dbx_GBP' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `license_fee_currency` SET TAGS ('dbx_EUR)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `license_fee_currency` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_column_comment' = 'The minimum guaranteed payment amount that the distributor or platform must pay regardless of actual revenue or usage. Common in SVOD and licensing deals.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_column_comment' = 'The username or identifier of the user who last modified this window record. Audit field for accountability and compliance.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_column_comment' = 'The timestamp when this window record was last modified. Audit field for change tracking and data lineage.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `platform_scope` SET TAGS ('dbx_business_glossary_term' = 'Platform Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `platform_scope` SET TAGS ('dbx_column_comment' = 'The specific platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `platform_scope` SET TAGS ('dbx_channel' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `platform_scope` SET TAGS ('dbx_service' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `platform_scope` SET TAGS ('dbx_or_outlet_authorized_for_distribution_during_this_window_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `platform_scope` SET TAGS ('dbx_Netflix' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `platform_scope` SET TAGS ('dbx_HBO_Max' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `platform_scope` SET TAGS ('dbx_ABC_Network' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `platform_scope` SET TAGS ('dbx_theatrical_chain)_May_be_a_single_platform_or_a_platform_group' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `revenue_share_percent` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `revenue_share_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `revenue_share_percent` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `revenue_share_percent` SET TAGS ('dbx_column_comment' = 'The percentage of gross or net revenue that the rights holder receives from exploitation during this window. Common in TVOD');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `revenue_share_percent` SET TAGS ('dbx_AVOD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `revenue_share_percent` SET TAGS ('dbx_and_theatrical_windows' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `revenue_share_percent` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_column_comment' = 'The percentage rate applied to revenue or usage to calculate royalty payments for this window. Used when the window operates under a revenue-sharing or usage-based royalty model.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `source_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `source_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `sublicense_permitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Sublicense Permitted Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `sublicense_permitted_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `sublicense_permitted_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the platform or distributor is authorized to sublicense the content to third parties during this window. True if sublicensing is permitted; false if prohibited.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `sublicense_permitted_flag` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `usage_cap_units` SET TAGS ('dbx_business_glossary_term' = 'Usage Cap Units');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `usage_cap_units` SET TAGS ('dbx_column_comment' = 'The maximum number of usage units (streams');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `usage_cap_units` SET TAGS ('dbx_downloads' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `usage_cap_units` SET TAGS ('dbx_broadcasts' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `usage_cap_units` SET TAGS ('dbx_screenings)_permitted_during_this_window_Used_to_enforce_contractual_usage_limits' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `usage_cap_units` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `window_close_date` SET TAGS ('dbx_business_glossary_term' = 'Window Close Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `window_close_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `window_close_date` SET TAGS ('dbx_column_comment' = 'The date when this exploitation window ends and the content is no longer authorized for distribution on the specified platform. End of the availability period. Nullable for perpetual windows.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `window_extension_count` SET TAGS ('dbx_business_glossary_term' = 'Window Extension Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `window_extension_count` SET TAGS ('dbx_column_comment' = 'The number of times this window has been extended beyond its original close date. Tracks amendments and extensions to the original window terms.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `window_open_date` SET TAGS ('dbx_business_glossary_term' = 'Window Open Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `window_open_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `window_open_date` SET TAGS ('dbx_column_comment' = 'The date when this exploitation window becomes active and the content is authorized for distribution on the specified platform. Start of the availability period.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `window_priority` SET TAGS ('dbx_business_glossary_term' = 'Window Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `window_priority` SET TAGS ('dbx_column_comment' = 'The numeric priority or sequence order of this window in the overall windowing strategy. Lower numbers indicate earlier windows in the release hierarchy (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `window_priority` SET TAGS ('dbx_1_for_theatrical' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `window_priority` SET TAGS ('dbx_2_for_PVOD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`content_window` ALTER COLUMN `window_priority` SET TAGS ('dbx_3_for_SVOD)_Used_to_enforce_windowing_hierarchy_rules' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` SET TAGS ('dbx_subdomain' = 'license_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `holdback_id` SET TAGS ('dbx_business_glossary_term' = 'Holdback Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `holdback_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the holdback restriction record. Primary key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `grant_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_rights_rights_grant_Business_justification' = 'Holdbacks restrict specific rights grants. Each holdback applies to one rights grant');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `grant_id` SET TAGS ('dbx_establishing_which_exploitation_rights_are_being_restricted_This_FK_enables_tracing_holdback_restrictions_back_to' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_column_comment' = 'Reference to the source license agreement that establishes this holdback restriction.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_column_comment' = 'Reference to the content asset subject to this holdback restriction.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `territory_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_rights_territory_Business_justification' = 'Holdbacks apply to specific territories. Each holdback restricts one territory. Normalizing to territory reference eliminates redundant territory string storage and enables consistent territory metada');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `territory_id` SET TAGS ('dbx_regulation' = 'Ofcom');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `automated_enforcement_flag` SET TAGS ('dbx_business_glossary_term' = 'Automated Enforcement Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `automated_enforcement_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `automated_enforcement_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this holdback restriction is automatically enforced by scheduling and distribution systems or requires manual review.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `carriage_negotiation_reference` SET TAGS ('dbx_business_glossary_term' = 'Carriage Negotiation Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `carriage_negotiation_reference` SET TAGS ('dbx_column_comment' = 'Reference identifier to the MVPD or vMVPD carriage negotiation that established this holdback restriction.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `carriage_negotiation_reference` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `conflict_resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Conflict Resolution Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `conflict_resolution_notes` SET TAGS ('dbx_column_comment' = 'Documentation of any conflicts with other rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `conflict_resolution_notes` SET TAGS ('dbx_windows' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `conflict_resolution_notes` SET TAGS ('dbx_or_holdbacks_and_how_they_were_resolved' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this holdback restriction record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Holdback Duration in Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `duration_days` SET TAGS ('dbx_column_comment' = 'Total number of days the holdback restriction is in effect');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `duration_days` SET TAGS ('dbx_calculated_from_start_to_end_date' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Holdback End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `end_date` SET TAGS ('dbx_column_comment' = 'Date when the holdback restriction expires and the content becomes available for exploitation on the previously restricted platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `end_date` SET TAGS ('dbx_territory' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `end_date` SET TAGS ('dbx_channel' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `end_date` SET TAGS ('dbx_or_format' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_value_regex' = 'full_exclusive|partial_exclusive|non_exclusive');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_column_comment' = 'Scope of exclusivity granted by this holdback');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_defining_whether_the_restriction_is_absolute_or_allows_limited_exploitation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_column_comment' = 'User or system identifier that last modified this holdback restriction record.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this holdback restriction record was last updated or modified.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether notification of this holdback restriction has been sent to relevant scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_distribution' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_and_operations_teams' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `restricted_channel` SET TAGS ('dbx_business_glossary_term' = 'Restricted Channel');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `restricted_channel` SET TAGS ('dbx_column_comment' = 'Specific broadcast or distribution channel that is restricted from airing or distributing the content during the holdback period.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `restricted_platform` SET TAGS ('dbx_business_glossary_term' = 'Restricted Platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `restricted_platform` SET TAGS ('dbx_column_comment' = 'Name or identifier of the platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `restricted_platform` SET TAGS ('dbx_distributor' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `restricted_platform` SET TAGS ('dbx_or_service_that_is_restricted_from_exploiting_the_content_during_the_holdback_period_Applies_to_platform_holdback_restriction_types' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `source_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `source_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Holdback Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `start_date` SET TAGS ('dbx_column_comment' = 'Date when the holdback restriction becomes effective and the content is blocked from the specified platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `start_date` SET TAGS ('dbx_territory' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `start_date` SET TAGS ('dbx_channel' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `start_date` SET TAGS ('dbx_or_format' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_column_comment' = 'Name or identifier of the person or role who authorized the waiver or override of the holdback restriction.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `waiver_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `waiver_approved_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `waiver_approved_date` SET TAGS ('dbx_column_comment' = 'Date when the waiver or override of the holdback restriction was officially approved.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_column_comment' = 'Business justification or explanation for waiving or overriding the holdback restriction');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_if_applicable' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_ENUM_REF_CANDIDATE' = 'promote-to-reference-product');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `windowing_strategy_notes` SET TAGS ('dbx_business_glossary_term' = 'Windowing Strategy Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `windowing_strategy_notes` SET TAGS ('dbx_column_comment' = 'Additional notes or context explaining how this holdback fits into the overall content windowing and sequential release strategy.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holdback` ALTER COLUMN `created_by` SET TAGS ('dbx_column_comment' = 'User or system identifier that created this holdback restriction record.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` SET TAGS ('dbx_subdomain' = 'license_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the geographic territory. Primary key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_id` SET TAGS ('dbx_regulation' = 'Ofcom');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `blackout_restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'Blackout Restricted Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `blackout_restricted_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `blackout_restricted_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the territory is subject to geographic blackout restrictions for certain content (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `blackout_restricted_flag` SET TAGS ('dbx_sports_events' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `blackout_restricted_flag` SET TAGS ('dbx_theatrical_windows)_True_if_blackouts_apply' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `blackout_restricted_flag` SET TAGS ('dbx_False_otherwise' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `content_rating_system` SET TAGS ('dbx_business_glossary_term' = 'Content Rating System');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `content_rating_system` SET TAGS ('dbx_column_comment' = 'Official content classification and rating system used in the territory (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `content_rating_system` SET TAGS ('dbx_TV_MA_TV_PG_for_USA' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `content_rating_system` SET TAGS ('dbx_BBFC_for_UK' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `content_rating_system` SET TAGS ('dbx_FSK_for_Germany)_Governs_age_appropriate_content_labeling_and_parental_controls' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `content_rating_system` SET TAGS ('dbx_regulation' = 'Ofcom');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `coppa_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Applicable Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `coppa_applicable_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `coppa_applicable_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the territory is subject to COPPA regulations governing childrens data privacy (USA). True if COPPA applies');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `coppa_applicable_flag` SET TAGS ('dbx_False_otherwise_Enforces_parental_consent_for_children's_content_and_data_collection' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `coppa_applicable_flag` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment_Timestamp_when_the_territory_record_was_first_created_in_the_system_Format' = 'yyyy-MM-ddTHH:mm:ss.SSSXXX.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `effective_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `effective_date` SET TAGS ('dbx_column_comment_Date_when_the_territory_record_became_active_and_available_for_rights_grants_and_distribution_agreements_Format' = 'yyyy-MM-dd.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `expiration_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `expiration_date` SET TAGS ('dbx_column_comment_Date_when_the_territory_record_expires_or_is_no_longer_valid_for_new_rights_grants_(nullable_for_indefinite_territories)_Format' = 'yyyy-MM-dd.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `gdpr_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Applicable Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `gdpr_applicable_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `gdpr_applicable_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the territory is subject to GDPR data privacy regulations (EU member states and EEA). True if GDPR applies');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `gdpr_applicable_flag` SET TAGS ('dbx_False_otherwise_Governs_audience_data_collection_and_consent_management' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `gdpr_applicable_flag` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `holdback_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Holdback Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `holdback_eligible_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `holdback_eligible_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the territory is eligible for holdback periods in windowing strategies (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `holdback_eligible_flag` SET TAGS ('dbx_delaying_SVOD_release_to_protect_theatrical_revenue)_True_if_holdbacks_apply' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `holdback_eligible_flag` SET TAGS ('dbx_False_otherwise' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `internet_penetration_percent` SET TAGS ('dbx_business_glossary_term' = 'Internet Penetration Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `internet_penetration_percent` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `internet_penetration_percent` SET TAGS ('dbx_column_comment' = 'Percentage of the population with internet access in the territory (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `internet_penetration_percent` SET TAGS ('dbx_95_00_for_USA' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `internet_penetration_percent` SET TAGS ('dbx_60_00_for_India)_Used_for_OTT_and_streaming_market_opportunity_assessment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `language_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `language_primary` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `language_primary` SET TAGS ('dbx_column_comment' = 'ISO 639-1 or ISO 639-2 code for the primary language spoken in the territory (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `language_primary` SET TAGS ('dbx_en_for_English' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `language_primary` SET TAGS ('dbx_es_for_Spanish' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `language_primary` SET TAGS ('dbx_fr_for_French)_Used_for_metadata_localization_and_subtitle_requirements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `language_primary` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `language_secondary` SET TAGS ('dbx_business_glossary_term' = 'Secondary Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `language_secondary` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `language_secondary` SET TAGS ('dbx_column_comment' = 'ISO 639-1 or ISO 639-2 code for a secondary or co-official language in the territory (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `language_secondary` SET TAGS ('dbx_fr_for_Canada' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `language_secondary` SET TAGS ('dbx_ca_for_Spain)_Supports_multi_language_content_delivery_and_compliance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `language_secondary` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `mechanical_licensing_body` SET TAGS ('dbx_business_glossary_term' = 'Mechanical Licensing Body');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_business_glossary_term' = 'Territory Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_column_comment' = 'Full official name of the territory (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_United_States' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_United_Kingdom' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_Canada)_Human_readable_identifier_used_in_contracts_and_reporting' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_regulation' = 'Ofcom');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `neighbouring_rights_society` SET TAGS ('dbx_business_glossary_term' = 'Neighbouring Rights Society');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Territory Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Free-text field for additional territory-specific information');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `notes` SET TAGS ('dbx_special_handling_instructions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `notes` SET TAGS ('dbx_or_regulatory_nuances_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `notes` SET TAGS ('dbx_'Requires_local_dubbing_for_theatrical_release'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `notes` SET TAGS ('dbx_'Subject_to_military_censorship')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `ott_market_maturity` SET TAGS ('dbx_business_glossary_term' = 'Over-The-Top (OTT) Market Maturity');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `ott_market_maturity` SET TAGS ('dbx_value_regex' = 'mature|developing|emerging|nascent');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `ott_market_maturity` SET TAGS ('dbx_column_comment_Classification_of_the_territory's_OTT_streaming_market_maturity' = 'mature (high penetration');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `ott_market_maturity` SET TAGS ('dbx_competitive)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `ott_market_maturity` SET TAGS ('dbx_developing_(growing_adoption)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `ott_market_maturity` SET TAGS ('dbx_emerging_(early_stage)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `ott_market_maturity` SET TAGS ('dbx_nascent_(minimal_infrastructure)_Informs_distribution_strategy_and_rights_pricing' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `population` SET TAGS ('dbx_business_glossary_term' = 'Population');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `population` SET TAGS ('dbx_column_comment' = 'Total population of the territory. Used for audience reach estimation');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `population` SET TAGS ('dbx_market_sizing' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `population` SET TAGS ('dbx_and_rights_valuation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `quota_percentage` SET TAGS ('dbx_business_glossary_term' = 'Content Quota Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `quota_percentage` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `quota_percentage` SET TAGS ('dbx_column_comment' = 'Minimum percentage of local or regional content required by regulation in the territory (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `quota_percentage` SET TAGS ('dbx_30_00_for_EU' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `quota_percentage` SET TAGS ('dbx_0_00_for_territories_without_quotas)_Used_for_compliance_reporting_and_content_acquisition_planning' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `quota_percentage` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `quota_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Content Quota Requirement Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `quota_requirement_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `quota_requirement_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the territory mandates local content quotas for broadcasters and streaming platforms (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `quota_requirement_flag` SET TAGS ('dbx_EU_Audiovisual_Media_Services_Directive_requiring_30%_European_content)_True_if_quotas_apply' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `quota_requirement_flag` SET TAGS ('dbx_False_otherwise' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_column_comment' = 'Primary broadcast and media regulatory authority governing the territory (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_FCC_for_USA' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_Ofcom_for_UK' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_CRTC_for_Canada)_Enforces_content_standards' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_licensing' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_and_compliance_requirements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `source_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `source_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_group` SET TAGS ('dbx_business_glossary_term' = 'Territory Group');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_group` SET TAGS ('dbx_column_comment' = 'Regional grouping of the territory used for rights aggregation and windowing strategies (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_group` SET TAGS ('dbx_EMEA' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_group` SET TAGS ('dbx_LATAM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_group` SET TAGS ('dbx_North_America' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_group` SET TAGS ('dbx_Worldwide' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_group` SET TAGS ('dbx_APAC)_Enables_multi_territory_licensing_and_holdback_management_[ENUM_REF_CANDIDATE' = 'worldwide');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_group` SET TAGS ('dbx_north_america' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_group` SET TAGS ('dbx_latin_america' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_group` SET TAGS ('dbx_emea' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_group` SET TAGS ('dbx_apac' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_group` SET TAGS ('dbx_europe' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_group` SET TAGS ('dbx_asia' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_group` SET TAGS ('dbx_africa' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_group` SET TAGS ('dbx_middle_east' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_group` SET TAGS ('dbx_oceania_—_10_candidates_stripped;_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `territory_group` SET TAGS ('dbx_regulation' = 'Ofcom');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `time_zone` SET TAGS ('dbx_column_comment' = 'IANA time zone identifier for the territory (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `time_zone` SET TAGS ('dbx_America_New_York' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `time_zone` SET TAGS ('dbx_Europe_London' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `time_zone` SET TAGS ('dbx_Asia_Tokyo)_Used_for_scheduling' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `time_zone` SET TAGS ('dbx_playout' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `time_zone` SET TAGS ('dbx_and_live_event_coordination' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_column_comment_Timestamp_when_the_territory_record_was_last_modified_Format' = 'yyyy-MM-ddTHH:mm:ss.SSSXXX.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `vat_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Value-Added Tax (VAT) Applicable Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `vat_applicable_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `vat_applicable_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether Value-Added Tax (VAT) or Goods and Services Tax (GST) applies to transactions in the territory. True if VAT/GST applies');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `vat_applicable_flag` SET TAGS ('dbx_False_otherwise_Used_for_royalty_and_subscription_billing_calculations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `vat_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Value-Added Tax (VAT) Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `vat_rate_percent` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `vat_rate_percent` SET TAGS ('dbx_column_comment' = 'Standard VAT or GST rate percentage applicable in the territory (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `vat_rate_percent` SET TAGS ('dbx_20_00_for_UK' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `vat_rate_percent` SET TAGS ('dbx_19_00_for_Germany' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `vat_rate_percent` SET TAGS ('dbx_0_00_for_territories_without_VAT)_Used_for_financial_reconciliation_and_revenue_recognition' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `withholding_tax_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `withholding_tax_rate_percent` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `withholding_tax_rate_percent` SET TAGS ('dbx_column_comment' = 'Standard withholding tax rate percentage applied to royalty payments to rights holders in the territory (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `withholding_tax_rate_percent` SET TAGS ('dbx_30_00_for_USA_non_resident_aliens' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `withholding_tax_rate_percent` SET TAGS ('dbx_0_00_for_domestic)_Used_for_talent_residuals_and_royalty_calculations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`territory` ALTER COLUMN `withholding_tax_rate_percent` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` SET TAGS ('dbx_subdomain' = 'royalty_clearance');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rule Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_rule_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the royalty calculation rule. Primary key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `grant_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_rights_rights_grant_Business_justification' = 'Royalty rules may apply to specific rights grants. Each rule may apply to one rights grant');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `grant_id` SET TAGS ('dbx_defining_how_royalties_are_calculated_for_that_grant_This_FK_enables_tracing_royalty_rules_back_to_the_spec' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `guild_affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_column_comment' = 'Reference to the parent license agreement or rights grant to which this royalty rule applies. Links this rule to the contract context in Rightsline.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `approved_by` SET TAGS ('dbx_column_comment' = 'Name or identifier of the person or role who approved this royalty rule. Nullable if not yet approved.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `approved_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `approved_date` SET TAGS ('dbx_column_comment' = 'Date on which this royalty rule was approved. Nullable if not yet approved.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `audit_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `audit_rights_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `audit_rights_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the rights holder has audit rights to verify royalty calculations under this rule. True if audit rights are granted');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `audit_rights_flag` SET TAGS ('dbx_False_otherwise' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `audit_rights_flag` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Calculation Basis');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_column_comment' = 'The financial or usage metric upon which the royalty calculation is based (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_gross_revenue' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_net_revenue' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_subscriber_count' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_stream_count' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_GRP)_[ENUM_REF_CANDIDATE' = 'gross_revenue');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_net_revenue' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_subscriber_count' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_stream_count' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_grp' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_unit_sales' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_advertising_revenue_—_7_candidates_stripped;_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this royalty rule record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `deduction_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Deduction Allowed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `deduction_allowed_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `deduction_allowed_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether deductions (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `deduction_allowed_flag` SET TAGS ('dbx_distribution_costs' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `deduction_allowed_flag` SET TAGS ('dbx_marketing_expenses)_are_allowed_before_calculating_the_royalty_True_if_deductions_are_permitted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `deduction_allowed_flag` SET TAGS ('dbx_False_otherwise' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `deduction_percentage` SET TAGS ('dbx_business_glossary_term' = 'Deduction Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `deduction_percentage` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `deduction_percentage` SET TAGS ('dbx_column_comment' = 'The percentage of revenue or basis that may be deducted before applying the royalty rate. Nullable if no deduction applies.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `deduction_percentage` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_column_comment' = 'The date on which this royalty rule ceases to be active. Nullable for open-ended rules.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_column_comment' = 'The date from which this royalty rule becomes active and applicable to royalty calculations.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this royalty rule record was last updated or modified.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `maximum_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Cap Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `maximum_cap_amount` SET TAGS ('dbx_column_comment' = 'The maximum royalty payment cap for this rule. Royalty calculations will not exceed this amount. Nullable if no cap applies.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_column_comment' = 'The minimum guaranteed royalty payment amount for this rule');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_regardless_of_calculated_royalty_Nullable_if_no_minimum_guarantee_applies' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rule Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Free-text notes or comments about this royalty rule');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `notes` SET TAGS ('dbx_including_special_conditions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `notes` SET TAGS ('dbx_exceptions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `notes` SET TAGS ('dbx_or_clarifications' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|per_event|on_demand');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_column_comment' = 'The frequency at which royalty payments calculated by this rule are made (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_monthly' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_quarterly' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_semi_annually' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_annually' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_per_event' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_on_demand)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `payment_timing` SET TAGS ('dbx_business_glossary_term' = 'Payment Timing');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `payment_timing` SET TAGS ('dbx_value_regex' = 'advance|arrears|upon_delivery|upon_release|milestone_based');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `payment_timing` SET TAGS ('dbx_column_comment' = 'The timing of royalty payments relative to the calculation period (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `payment_timing` SET TAGS ('dbx_advance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `payment_timing` SET TAGS ('dbx_arrears' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `payment_timing` SET TAGS ('dbx_upon_delivery' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `payment_timing` SET TAGS ('dbx_upon_release' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `payment_timing` SET TAGS ('dbx_milestone_based)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `payment_timing` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Rate Unit');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rate_unit` SET TAGS ('dbx_value_regex' = 'percentage|per_stream|per_subscriber|per_unit|per_grp|flat_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rate_unit` SET TAGS ('dbx_column_comment' = 'The unit of measure for the rate value (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rate_unit` SET TAGS ('dbx_percentage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rate_unit` SET TAGS ('dbx_per_stream' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rate_unit` SET TAGS ('dbx_per_subscriber' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rate_unit` SET TAGS ('dbx_per_unit' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rate_unit` SET TAGS ('dbx_per_GRP' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rate_unit` SET TAGS ('dbx_flat_amount)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rate_value` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rate_value` SET TAGS ('dbx_column_comment' = 'The numeric rate or percentage applied in the royalty calculation. For percentage-based royalties');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rate_value` SET TAGS ('dbx_this_is_the_percentage_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rate_value` SET TAGS ('dbx_15_5_for_15_5%)_For_per_unit_rates' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rate_value` SET TAGS ('dbx_this_is_the_amount_per_unit' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `recoupment_flag` SET TAGS ('dbx_business_glossary_term' = 'Recoupment Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `recoupment_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `recoupment_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this royalty rule includes recoupment provisions (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `recoupment_flag` SET TAGS ('dbx_advance_payments_must_be_recouped_before_additional_royalties_are_paid)_True_if_recoupment_applies' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `recoupment_flag` SET TAGS ('dbx_False_otherwise' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `recoupment_threshold` SET TAGS ('dbx_business_glossary_term' = 'Recoupment Threshold');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `recoupment_threshold` SET TAGS ('dbx_column_comment' = 'The monetary threshold that must be recouped before additional royalty payments are made. Nullable if no recoupment applies.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `residual_formula` SET TAGS ('dbx_business_glossary_term' = 'Residual Formula');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `residual_formula` SET TAGS ('dbx_column_comment' = 'The formula or calculation logic for residual payments to talent (actors');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `residual_formula` SET TAGS ('dbx_directors' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `residual_formula` SET TAGS ('dbx_writers)_based_on_reuse' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `residual_formula` SET TAGS ('dbx_reruns' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `residual_formula` SET TAGS ('dbx_or_secondary_exploitation_Nullable_if_not_applicable' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rule Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_rule_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_rule_status` SET TAGS ('dbx_column_comment' = 'Current lifecycle status of the royalty rule (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_rule_status` SET TAGS ('dbx_draft' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_rule_status` SET TAGS ('dbx_active' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_rule_status` SET TAGS ('dbx_suspended' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_rule_status` SET TAGS ('dbx_expired' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_rule_status` SET TAGS ('dbx_terminated)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_type` SET TAGS ('dbx_business_glossary_term' = 'Royalty Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_type` SET TAGS ('dbx_value_regex' = 'flat_fee|revenue_share_percentage|per_stream_rate|per_unit_rate|residual_formula|minimum_guarantee');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `royalty_type` SET TAGS ('dbx_column_comment' = 'The type of royalty calculation method applied by this rule. Determines how the royalty amount is computed.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rule Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_column_comment' = 'Human-readable name or title of the royalty rule');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_describing_its_purpose_or_scope_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_'SVOD_Revenue_Share_Tier_1'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_'Per_Stream_Rate_Music_Sync')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rule_priority` SET TAGS ('dbx_business_glossary_term' = 'Rule Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `rule_priority` SET TAGS ('dbx_column_comment' = 'The priority or precedence of this royalty rule when multiple rules may apply to the same content or transaction. Lower numbers indicate higher priority.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `source_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `source_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `territory_scope` SET TAGS ('dbx_column_comment' = 'Geographic territory or territories to which this royalty rule applies. May be a single country code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `territory_scope` SET TAGS ('dbx_region' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `territory_scope` SET TAGS ('dbx_or_comma_separated_list_of_territories' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `territory_scope` SET TAGS ('dbx_regulation' = 'Ofcom');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_value_regex' = 'revenue|subscriber_count|stream_count|unit_count|grp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_column_comment' = 'The unit of measure for the threshold value (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_revenue' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_subscriber_count' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_stream_count' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_unit_count' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_GRP)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `threshold_value` SET TAGS ('dbx_column_comment' = 'The threshold value that triggers a rate tier change or special calculation logic (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `threshold_value` SET TAGS ('dbx_revenue_threshold_for_tiered_royalty_rates)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_rule` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` SET TAGS ('dbx_subdomain' = 'royalty_clearance');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `royalty_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Statement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `royalty_statement_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the royalty statement. Primary key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `guild_affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Guild Affiliation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `holder_id` SET TAGS ('dbx_column_comment' = 'Identifier of the rights holder (licensor');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `holder_id` SET TAGS ('dbx_talent_guild' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `holder_id` SET TAGS ('dbx_music_publisher' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `holder_id` SET TAGS ('dbx_or_syndication_partner)_to_whom_this_statement_is_issued_Links_to_the_party_receiving_royalty_payments' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_column_comment' = 'Identifier of the underlying rights agreement or contract that governs the royalty terms for this statement.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `royalty_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rule Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_column_comment' = 'Net adjustment amount applied to this statement for corrections');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_credits' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_or_debits_from_prior_periods' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `advance_recoupment_amount` SET TAGS ('dbx_business_glossary_term' = 'Advance Recoupment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `advance_recoupment_amount` SET TAGS ('dbx_column_comment' = 'Amount deducted from gross royalties to recoup advances previously paid to the rights holder under the agreement.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `approved_by` SET TAGS ('dbx_column_comment' = 'Name or identifier of the person or system that approved this royalty statement for payment.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when this royalty statement was approved for payment.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `content_title_breakdown` SET TAGS ('dbx_business_glossary_term' = 'Content Title Breakdown');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `content_title_breakdown` SET TAGS ('dbx_column_comment' = 'Structured breakdown of royalties by content title or asset. Stored as JSON or delimited string for detailed reporting.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when this royalty statement record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `dispute_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `dispute_date` SET TAGS ('dbx_column_comment' = 'The date on which the rights holder formally disputed this royalty statement.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_column_comment' = 'Explanation or reason provided by the rights holder if the statement status is disputed. Captures objections to calculations');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_missing_revenues' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_or_contractual_interpretation_issues' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_ENUM_REF_CANDIDATE' = 'promote-to-reference-product');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_column_comment' = 'Exchange rate applied to convert foreign currency revenues to the statement currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_if_applicable_Rate_is_typically_the_average_rate_for_the_statement_period' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `exploitation_type_breakdown` SET TAGS ('dbx_business_glossary_term' = 'Exploitation Type Breakdown');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `exploitation_type_breakdown` SET TAGS ('dbx_column_comment' = 'Structured breakdown of royalties by exploitation type (theatrical');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `exploitation_type_breakdown` SET TAGS ('dbx_SVOD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `exploitation_type_breakdown` SET TAGS ('dbx_AVOD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `exploitation_type_breakdown` SET TAGS ('dbx_TVOD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `exploitation_type_breakdown` SET TAGS ('dbx_linear' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `exploitation_type_breakdown` SET TAGS ('dbx_syndication' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `exploitation_type_breakdown` SET TAGS ('dbx_home_video' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `exploitation_type_breakdown` SET TAGS ('dbx_etc_)_Stored_as_JSON_or_delimited_string_for_detailed_reporting' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `gross_royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Royalty Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `gross_royalty_amount` SET TAGS ('dbx_column_comment' = 'Total royalty amount earned by the rights holder before any deductions');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `gross_royalty_amount` SET TAGS ('dbx_recoupments' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `gross_royalty_amount` SET TAGS ('dbx_or_adjustments' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `mechanical_royalty_flag` SET TAGS ('dbx_business_glossary_term' = 'Mechanical Royalty Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `minimum_guarantee_shortfall` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Shortfall');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `minimum_guarantee_shortfall` SET TAGS ('dbx_column_comment' = 'The difference between the contractual minimum guarantee and actual royalties earned for the period. A positive value indicates the rights holder is entitled to a minimum guarantee payment.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when this royalty statement record was last modified or updated.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `neighbouring_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Neighbouring Rights Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `net_royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Royalty Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `net_royalty_amount` SET TAGS ('dbx_column_comment' = 'Final royalty amount payable to the rights holder after all deductions');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `net_royalty_amount` SET TAGS ('dbx_recoupments' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `net_royalty_amount` SET TAGS ('dbx_taxes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `net_royalty_amount` SET TAGS ('dbx_and_adjustments_This_is_the_amount_that_will_be_paid' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `paid_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Paid Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `paid_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `paid_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when payment for this royalty statement was successfully processed and remitted to the rights holder.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|check|ach|paypal|direct_deposit');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `payment_method` SET TAGS ('dbx_column_comment' = 'The payment instrument or method that will be used to remit the net royalty amount to the rights holder.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `payment_method` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_column_comment' = 'Reference number or transaction identifier for the payment associated with this statement');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_once_payment_has_been_processed' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `resolution_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `resolution_date` SET TAGS ('dbx_column_comment' = 'The date on which a disputed statement was resolved and moved to approved or paid status.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `source_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `source_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_due_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Payment Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_due_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_due_date` SET TAGS ('dbx_column_comment' = 'The date by which payment of the royalties on this statement is contractually due to the rights holder.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Statement Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi-annual|annual|ad-hoc');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_frequency` SET TAGS ('dbx_column_comment' = 'The reporting frequency for this royalty statement as defined in the underlying rights agreement.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Issue Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_issue_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_issue_date` SET TAGS ('dbx_column_comment' = 'The date on which this royalty statement was officially issued to the rights holder.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_notes` SET TAGS ('dbx_business_glossary_term' = 'Statement Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_notes` SET TAGS ('dbx_column_comment' = 'Free-text notes or comments related to this royalty statement');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_notes` SET TAGS ('dbx_including_explanations_of_unusual_adjustments' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_notes` SET TAGS ('dbx_special_circumstances' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_notes` SET TAGS ('dbx_or_clarifications_for_the_rights_holder' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_number` SET TAGS ('dbx_business_glossary_term' = 'Royalty Statement Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_number` SET TAGS ('dbx_column_comment' = 'Externally-known unique business identifier for this royalty statement');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_number` SET TAGS ('dbx_used_for_reference_in_correspondence_and_payment_processing' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Period End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_period_end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_period_end_date` SET TAGS ('dbx_column_comment' = 'The last date of the reporting period covered by this royalty statement.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Period Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_period_start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `statement_period_start_date` SET TAGS ('dbx_column_comment' = 'The first date of the reporting period covered by this royalty statement.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `territory_breakdown` SET TAGS ('dbx_business_glossary_term' = 'Territory Breakdown');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `territory_breakdown` SET TAGS ('dbx_column_comment' = 'Structured breakdown of royalties by geographic territory or market. Stored as JSON or delimited string for detailed reporting.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `territory_breakdown` SET TAGS ('dbx_regulation' = 'Ofcom');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_column_comment' = 'Tax amount withheld from royalty payment as required by applicable tax treaties and regulations.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`royalty_statement` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` SET TAGS ('dbx_subdomain' = 'royalty_clearance');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `clearance_request_id` SET TAGS ('dbx_business_glossary_term' = 'Clearance Request ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `clearance_request_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the rights clearance request. Primary key for the clearance request workflow record.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `content_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Content Window Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `grant_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_rights_rights_grant_Business_justification' = 'Clearance requests validate against specific rights grants to determine if exploitation is permitted. Each clearance request checks one rights grant for authorization. This FK enables validation of ex');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `holdback_id` SET TAGS ('dbx_business_glossary_term' = 'Holdback Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `holdback_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_rights_holdback_Business_justification' = 'Clearance requests may be blocked by specific holdbacks. Each clearance request may reference one blocking holdback that prevents exploitation. This FK enables tracing clearance denials back to the sp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_column_comment' = 'Reference to the primary licensing agreement that governs the requested exploitation. Links to the contract record in Rightsline that defines available windows');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_territories' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_and_restrictions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_column_comment' = 'Reference to the content asset requiring clearance verification before broadcast');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_streaming' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_or_distribution_Links_to_the_digital_asset_managed_in_Dalet_Galaxy_MAM' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `territory_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_rights_territory_Business_justification' = 'Clearance requests are for specific territories. Each request relates to one territory. Normalizing to territory reference eliminates redundant territory code storage and enables consistent territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `territory_id` SET TAGS ('dbx_regulation' = 'Ofcom');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `analyst_notes` SET TAGS ('dbx_business_glossary_term' = 'Analyst Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `analyst_notes` SET TAGS ('dbx_column_comment' = 'Free-text notes and observations recorded by the clearance analyst during review. May include references to specific contract clauses');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `analyst_notes` SET TAGS ('dbx_communications_with_rights_holders' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `analyst_notes` SET TAGS ('dbx_or_special_handling_instructions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocking Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_column_comment' = 'Detailed explanation of why a clearance request was blocked or denied. May reference specific contract clauses');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_holdback_periods' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_territorial_restrictions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_or_missing_rights_Null_if_request_is_cleared' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_ENUM_REF_CANDIDATE' = 'promote-to-reference-product');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `clearance_decision` SET TAGS ('dbx_business_glossary_term' = 'Clearance Decision');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `clearance_decision` SET TAGS ('dbx_value_regex' = 'approved|approved_with_conditions|denied|pending_review');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `clearance_decision` SET TAGS ('dbx_column_comment' = 'Final determination made by the clearance analyst regarding whether the content may be exploited as requested. Approved with conditions may require specific usage restrictions or additional payments.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `conditional_requirements` SET TAGS ('dbx_business_glossary_term' = 'Conditional Requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `conditional_requirements` SET TAGS ('dbx_column_comment' = 'Specific conditions or restrictions that must be met for conditional clearance approval. May include required credits');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `conditional_requirements` SET TAGS ('dbx_usage_limitations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `conditional_requirements` SET TAGS ('dbx_geographic_blackouts' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `conditional_requirements` SET TAGS ('dbx_or_additional_royalty_payments' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'System timestamp when the clearance request record was first created in the database. Part of standard audit trail for data lineage and compliance.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_column_comment' = 'Explanation of why the clearance request required escalation beyond standard analyst review. May reference contract ambiguity');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_conflicting_rights_claims' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_or_high_value_strategic_decisions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_ENUM_REF_CANDIDATE' = 'promote-to-reference-product');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when the clearance request was escalated to senior rights management or legal counsel due to complexity');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_ambiguity' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_or_high_business_impact_Null_if_no_escalation_occurred' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_regulation' = 'ATSC A/85');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `estimated_audience_reach` SET TAGS ('dbx_business_glossary_term' = 'Estimated Audience Reach');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `estimated_audience_reach` SET TAGS ('dbx_column_comment' = 'Projected number of unique viewers or households expected to access the content in the requested exploitation. Used for royalty calculations and rights holder reporting.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `estimated_grp` SET TAGS ('dbx_business_glossary_term' = 'Estimated Gross Rating Point (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `estimated_grp` SET TAGS ('dbx_column_comment' = 'Projected Gross Rating Point value for the scheduled broadcast or streaming event. GRP represents the sum of ratings achieved by the content and may trigger tiered royalty obligations.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `estimated_residuals_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Residuals Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `estimated_residuals_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `estimated_residuals_amount` SET TAGS ('dbx_column_comment' = 'Projected total residual payments owed to talent if the clearance is approved and content is distributed. Used for financial planning and budget approval workflows.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `integration_status` SET TAGS ('dbx_business_glossary_term' = 'Integration Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `integration_status` SET TAGS ('dbx_value_regex' = 'pending_sync|synced_to_scheduling|synced_to_playout|sync_failed');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `integration_status` SET TAGS ('dbx_column_comment' = 'Status of data synchronization between Rightsline clearance system and downstream scheduling and playout systems (Ericsson MediaFirst). Ensures cleared content is automatically released to scheduling workflows.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_column_comment' = 'System timestamp of the most recent update to any field in the clearance request record. Enables change tracking and audit trail for compliance and operational monitoring.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `music_clearance_required` SET TAGS ('dbx_business_glossary_term' = 'Music Synchronization Clearance Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `music_clearance_required` SET TAGS ('dbx_column_comment' = 'Indicates whether separate music synchronization licenses must be verified before content can be cleared for distribution. True if content contains licensed music requiring additional clearance.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `platform_channel` SET TAGS ('dbx_business_glossary_term' = 'Platform or Channel');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `platform_channel` SET TAGS ('dbx_column_comment' = 'Specific platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `platform_channel` SET TAGS ('dbx_channel' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `platform_channel` SET TAGS ('dbx_or_outlet_where_the_content_is_intended_to_be_distributed_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `platform_channel` SET TAGS ('dbx_HBO_Max' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `platform_channel` SET TAGS ('dbx_NBC_Network' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `platform_channel` SET TAGS ('dbx_YouTube' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `platform_channel` SET TAGS ('dbx_Hulu)_Used_to_verify_platform_specific_licensing_restrictions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Clearance Request Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^CLR-[0-9]{8}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `request_number` SET TAGS ('dbx_column_comment' = 'Human-readable business identifier for the clearance request');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `request_number` SET TAGS ('dbx_typically_formatted_as_CLR_YYYYMMDD_sequence_for_tracking_and_reference_in_scheduling_and_distribution_workflows' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `request_submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Submitted Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `request_submitted_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `request_submitted_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when the clearance request was initially submitted into the workflow system. Marks the start of the clearance review lifecycle and SLA clock.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `requested_air_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Air or Publish Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `requested_air_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `requested_air_date` SET TAGS ('dbx_column_comment' = 'The target date when the content is scheduled to be broadcast');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `requested_air_date` SET TAGS ('dbx_streamed' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `requested_air_date` SET TAGS ('dbx_or_published_Critical_for_verifying_that_rights_are_available_within_the_requested_window_and_that_no_holdback_periods_are_violated' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `requested_air_time` SET TAGS ('dbx_business_glossary_term' = 'Requested Air or Publish Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `requested_air_time` SET TAGS ('dbx_column_comment' = 'Precise timestamp for the intended broadcast or streaming start time');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `requested_air_time` SET TAGS ('dbx_including_time_zone_Used_for_daypart_specific_rights_verification_and_scheduling_coordination' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `requesting_department` SET TAGS ('dbx_business_glossary_term' = 'Requesting Department');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `requesting_department` SET TAGS ('dbx_value_regex' = 'scheduling|distribution|production|programming|digital|syndication');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `requesting_department` SET TAGS ('dbx_column_comment' = 'Business unit or department initiating the clearance request. Identifies which operational area needs rights verification before proceeding with content exploitation.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `residuals_triggered` SET TAGS ('dbx_business_glossary_term' = 'Residuals Triggered');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `residuals_triggered` SET TAGS ('dbx_column_comment' = 'Indicates whether the requested exploitation will trigger residual payments to talent per guild agreements. True if reuse payments are required for this distribution window.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when the clearance request was finalized with a cleared');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_blocked' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_or_conditionally_cleared_decision_Marks_the_end_of_the_clearance_workflow_and_enables_SLA_compliance_measurement' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `review_started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Started Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `review_started_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `review_started_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when a clearance analyst began active review of the request. Used to measure queue time and analyst response performance.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `sla_met` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Met');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `sla_met` SET TAGS ('dbx_column_comment' = 'Indicates whether the clearance request was resolved within the defined SLA target hours. Used for operational performance reporting and process improvement.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_column_comment' = 'Number of business hours within which the clearance request must be resolved per service level agreement. Varies by priority level (urgent requests have shorter SLA targets).');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `source_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `source_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `talent_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Talent Approval Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `talent_approval_required` SET TAGS ('dbx_column_comment' = 'Indicates whether talent (actors');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `talent_approval_required` SET TAGS ('dbx_directors' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `talent_approval_required` SET TAGS ('dbx_producers)_approval_or_notification_is_contractually_required_before_the_requested_exploitation_True_if_talent_has_approval_rights_per_guild_agreements_or_individual_contracts' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`clearance_request` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` SET TAGS ('dbx_subdomain' = 'royalty_clearance');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `holder_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `holder_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the rights holder entity. Primary key for the rights holder master record.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `audit_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `audit_rights_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `audit_rights_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this rights holder has contractual audit rights to review revenue reporting and royalty calculations. True requires enhanced documentation retention.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `audit_rights_flag` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_column_comment' = 'Name on the bank account designated for royalty payments. Must match legal entity name for payment processing compliance.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_column_comment' = 'Bank account number for royalty payment remittance. Encrypted at rest and in transit per PCI DSS requirements.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_column_comment' = 'Bank routing number or SWIFT/BIC code for international wire transfers. Used for automated royalty payment processing.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this rights holder record was first created in the system. Used for audit trail and data lineage tracking.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_column_comment' = 'Maximum credit exposure allowed for advance payments or minimum guarantees to this rights holder. Used for financial risk management.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `default_royalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Default Royalty Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `default_royalty_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `default_royalty_rate` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `default_royalty_rate` SET TAGS ('dbx_column_comment' = 'Default royalty rate percentage applied to new agreements with this rights holder. Can be overridden at the contract level.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `exclusivity_preference` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Preference');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `exclusivity_preference` SET TAGS ('dbx_value_regex' = 'exclusive_only|non_exclusive_preferred|flexible|no_preference');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `exclusivity_preference` SET TAGS ('dbx_column_comment' = 'Rights holders stated preference for exclusivity terms in licensing agreements. Influences windowing strategy and holdback negotiations.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Talent Guild Affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_column_comment_Name_of_talent_guild_or_performing_rights_organization_(PRO)_that_this_rights_holder_is_affiliated_with_Determines_residual_payment_rules_and_reporting_requirements_[ENUM_REF_CANDIDATE' = 'sag_aftra');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_wga' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_dga' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_afm' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_ascap' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_bmi' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_sesac' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_gema' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_prs' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `guild_affiliation` SET TAGS ('dbx_socan_—_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_column_comment' = 'User identifier of the person who last modified this rights holder record. Used for audit trail and change accountability.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this rights holder record was last updated. Used for change tracking and data synchronization.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `minimum_guarantee_threshold` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Threshold Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `minimum_guarantee_threshold` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `minimum_guarantee_threshold` SET TAGS ('dbx_column_comment' = 'Minimum guarantee amount threshold below which this rights holder will not enter licensing agreements. Used for deal structuring and negotiation.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `most_favored_nations_flag` SET TAGS ('dbx_business_glossary_term' = 'Most Favored Nations (MFN) Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `most_favored_nations_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `most_favored_nations_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this rights holder has most favored nations clause requiring rate parity with other similar rights holders. True triggers rate comparison workflows.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `music_publisher_flag` SET TAGS ('dbx_business_glossary_term' = 'Music Publisher Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Free-text notes capturing special handling instructions');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `notes` SET TAGS ('dbx_negotiation_history' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `notes` SET TAGS ('dbx_relationship_nuances' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `notes` SET TAGS ('dbx_or_other_contextual_information_for_this_rights_holder' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|paypal|international_wire');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `payment_method` SET TAGS ('dbx_column_comment' = 'Preferred payment method for royalty disbursements. Determines processing fees and settlement timelines.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `payment_method` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms in Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_column_comment' = 'Standard payment terms in days from invoice date for royalty payments to this rights holder. Typical values include 30');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_60' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_or_90_days_net' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_column_comment' = 'Three-letter ISO currency code representing the rights holders preferred currency for royalty payments and contract valuations.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_column_comment' = 'Primary email address for the rights holder contact. Used for contract notifications');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_clearance_communications' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_and_royalty_statements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Full Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_column_comment' = 'Full name of the primary business contact at the rights holder organization for licensing negotiations');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_clearance_requests' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_and_royalty_inquiries' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_column_comment' = 'Primary telephone number for the rights holder contact. Used for urgent clearance issues and contract negotiations.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `pro_affiliation` SET TAGS ('dbx_business_glossary_term' = 'PRO Affiliation');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `record_label_flag` SET TAGS ('dbx_business_glossary_term' = 'Record Label Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `registrant_identifier` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN) or International Standard Recording Code (ISRC) Registrant Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `registrant_identifier` SET TAGS ('dbx_column_comment' = 'The ISAN or ISRC registrant identifier assigned to the rights holder by the respective international registration authority. Used for global rights tracking and content identification.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `relationship_end_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `relationship_end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `relationship_end_date` SET TAGS ('dbx_column_comment' = 'Date when the business relationship with this rights holder was terminated or suspended. Null for active relationships.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `relationship_start_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `relationship_start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `relationship_start_date` SET TAGS ('dbx_column_comment' = 'Date when the business relationship with this rights holder was established. Used for historical reporting and relationship tenure analysis.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `rights_holder_name` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder Legal Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `rights_holder_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `rights_holder_name` SET TAGS ('dbx_column_comment' = 'The full legal name of the rights holder entity as registered in their territory of incorporation. Used for contract execution and royalty payment identification.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `rights_holder_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `rights_holder_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `royalty_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Royalty Calculation Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `royalty_calculation_method` SET TAGS ('dbx_value_regex' = 'percentage_of_revenue|flat_fee|tiered_percentage|per_unit|hybrid');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `royalty_calculation_method` SET TAGS ('dbx_column_comment' = 'Standard royalty calculation methodology applied to this rights holders agreements. Determines how residuals and royalties are computed.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `source_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `source_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_column_comment' = 'Tax identification number for the rights holder in their jurisdiction of incorporation. Required for tax reporting and withholding compliance.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_withholding_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Withholding Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_withholding_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_withholding_rate` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_withholding_rate` SET TAGS ('dbx_column_comment' = 'Applicable tax withholding rate percentage for royalty payments to this rights holder. Derived from tax treaties and domestic law based on withholding classification.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `tax_withholding_rate` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `territory_of_incorporation` SET TAGS ('dbx_business_glossary_term' = 'Territory of Incorporation');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `territory_of_incorporation` SET TAGS ('dbx_column_comment' = 'Three-letter ISO country code representing the legal jurisdiction where the rights holder entity is incorporated or registered. Determines applicable tax treaties and withholding requirements.');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `territory_of_incorporation` SET TAGS ('dbx_regulation' = 'Ofcom');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`rights`.`holder` ALTER COLUMN `created_by` SET TAGS ('dbx_column_comment' = 'User identifier of the person who created this rights holder record. Used for audit trail and accountability.');
