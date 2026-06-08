-- Schema for Domain: mediaasset | Business: Media Broadcasting | Version: v1_mvm
-- Generated on: 2026-05-08 19:23:32

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `media_broadcasting_ecm`.`mediaasset` COMMENT 'Authoritative repository for all managed media files and digital objects — raw camera footage, mezzanine masters, proxy files, graphics, music beds, and archived assets. Implements MAM (Media Asset Management) via Dalet Galaxy, enforcing storage tiering, format standards (MPEG-4 ISO 14496), checksum integrity, retention policies, format migrations, and chain-of-custody audit trails for regulatory and legal hold compliance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` (
    `media_asset_id` BIGINT COMMENT 'Unique identifier for the media asset record in the MAM (Media Asset Management) system. Primary key for all digital objects managed by Dalet Galaxy.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Production assets are charged to cost centers for budget tracking and cost allocation. Essential for production accounting, variance analysis, and departmental P&L reporting in media operations.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Media assets are owned by specific legal entities in multi-entity media groups, driving tax treatment, depreciation schedules, intercompany licensing, and regulatory reporting. A media finance expert ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Assets generate revenue through distribution channels (theatrical, streaming, syndication) tracked by profit center. Required for content P&L reporting, ROI analysis, and segment performance measureme',
    `retention_policy_id` BIGINT COMMENT 'Foreign key linking to mediaasset.retention_policy. Business justification: media_asset.retention_policy_code is a denormalized STRING code referencing the retention_policy table. Each media asset is governed by a retention policy that determines its lifecycle, storage tier, ',
    `archived_timestamp` TIMESTAMP COMMENT 'Date and time when the asset was moved to archive storage tier. Null if asset has never been archived.',
    `aspect_ratio` STRING COMMENT 'Display aspect ratio of the video content. Determines letterboxing and pillarboxing requirements for different distribution channels.. Valid values are `16:9|4:3|21:9|1:1|2.39:1`',
    `asset_class` STRING COMMENT 'Classification of the asset based on its production workflow stage and quality level. Raw=unprocessed camera footage, Mezzanine=high-quality intermediate, Proxy=low-res preview, Archive=long-term preservation, Master=final approved version.. Valid values are `raw|mezzanine|proxy|archive|master`',
    `asset_title` STRING COMMENT 'Primary human-readable title or name of the media asset. Used for search, cataloging, and display in MAM interfaces.',
    `asset_type` STRING COMMENT 'Primary media type classification of the digital object. Determines handling, playback, and workflow routing in the MAM system. [ENUM-REF-CANDIDATE: video|audio|image|graphics|document|subtitle|caption — 7 candidates stripped; promote to reference product]',
    `audio_bit_depth` STRING COMMENT 'Audio bit depth in bits per sample (e.g., 16, 24). Higher bit depth provides greater dynamic range and lower quantization noise.',
    `audio_channels` STRING COMMENT 'Number of discrete audio channels in the asset (e.g., 2 for stereo, 6 for 5.1 surround, 8 for 7.1, 16 for multi-language tracks). Determines audio routing and mixing requirements.',
    `audio_sample_rate_khz` DECIMAL(18,2) COMMENT 'Audio sampling frequency in kilohertz (e.g., 48.000 for broadcast, 44.100 for CD quality). Indicates audio quality and broadcast compliance.',
    `bit_rate_mbps` DECIMAL(18,2) COMMENT 'Average bit rate of the encoded media in megabits per second. Indicates quality level and bandwidth requirements for streaming and playout.',
    `checksum_md5` STRING COMMENT 'MD5 hash of the file content for integrity verification. Used to detect corruption during transfer, storage, and archival operations.. Valid values are `^[a-f0-9]{32}$`',
    `checksum_sha256` STRING COMMENT 'SHA-256 cryptographic hash for enhanced integrity verification and chain-of-custody audit trails. Required for regulatory compliance and legal hold.. Valid values are `^[a-f0-9]{64}$`',
    `codec` STRING COMMENT 'Video or audio compression codec used for encoding (e.g., H.264, H.265/HEVC, ProRes, DNxHD, AAC, PCM). Critical for quality assessment and transcoding decisions.',
    `color_space` STRING COMMENT 'Color space standard used for encoding (e.g., BT.709 for HD, BT.2020 for UHD/HDR). Critical for color accuracy across distribution platforms.. Valid values are `BT.709|BT.2020|DCI-P3|sRGB|Adobe RGB`',
    `content_classification` STRING COMMENT 'Business classification tags for content categorization (e.g., news, sports, drama, documentary, commercial, promo). Supports search, rights management, and workflow routing. Pipe-separated list for multiple classifications.',
    `duration_seconds` DECIMAL(18,2) COMMENT 'Total playback duration of the media asset in seconds with millisecond precision. Used for scheduling, ad insertion planning, and rights windowing calculations.',
    `eidr` STRING COMMENT 'Universal unique identifier for film and television assets. Enables global content identification for distribution and rights management.. Valid values are `^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z]$`',
    `file_format` STRING COMMENT 'Container format of the media file (e.g., MXF, MP4, MOV, AVI, WAV). Determines compatibility with playout and editing systems.',
    `file_size_bytes` BIGINT COMMENT 'Total file size in bytes. Used for storage capacity planning, transfer time estimation, and billing calculations.',
    `frame_rate` DECIMAL(18,2) COMMENT 'Video frame rate in frames per second (e.g., 23.976, 24.000, 25.000, 29.970, 30.000, 50.000, 59.940, 60.000). Critical for broadcast standards compliance and motion quality.',
    `hdr_format` STRING COMMENT 'HDR encoding format if applicable. SDR=Standard Dynamic Range, HDR10/HDR10+/Dolby Vision=High Dynamic Range variants, HLG=Hybrid Log-Gamma for broadcast.. Valid values are `SDR|HDR10|HDR10+|Dolby Vision|HLG`',
    `ingest_timestamp` TIMESTAMP COMMENT 'Date and time when the asset was first ingested into the MAM system. Marks the beginning of the assets lifecycle in the enterprise repository.',
    `isan` STRING COMMENT 'ISO 15706 international identifier for audiovisual works. Used for content registration and rights management across territories.. Valid values are `^ISAN [0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]$`',
    `isrc` STRING COMMENT 'ISO 3901 unique identifier for sound recordings and music video recordings. Used for music beds, audio tracks, and music-related assets.. Valid values are `^[A-Z]{2}-[A-Z0-9]{3}-[0-9]{2}-[0-9]{5}$`',
    `last_accessed_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent access or playback of the asset. Used for storage tier optimization and usage analytics.',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicates whether the asset is under legal hold and must not be modified or deleted. Overrides retention policies until hold is released.',
    `lifecycle_status` STRING COMMENT 'Current state of the asset in its operational lifecycle. Tracks progression from ingest through quality control, active use, archival, and eventual purge. Drives workflow automation and access control. [ENUM-REF-CANDIDATE: ingest|qc_pending|qc_approved|qc_rejected|available|in_use|archived|purged|quarantined — 9 candidates stripped; promote to reference product]',
    `originating_system` STRING COMMENT 'Source system or device that created or ingested the asset (e.g., camera model, editing suite, ingest station, external vendor). Provides provenance for chain-of-custody tracking.',
    `qc_completed_timestamp` TIMESTAMP COMMENT 'Date and time when quality control review was completed. Null if QC is pending or not required.',
    `qc_operator` STRING COMMENT 'User ID or name of the operator who performed quality control review. Used for accountability and audit trails.',
    `resolution` STRING COMMENT 'Video frame resolution in pixels (e.g., 1920x1080, 3840x2160, 1280x720). Indicates quality tier and delivery format compatibility.',
    `retention_expiry_date` DATE COMMENT 'Date when the asset becomes eligible for purge based on retention policy. Null indicates indefinite retention or active legal hold.',
    `rights_restriction` STRING COMMENT 'Rights and usage restrictions governing distribution and use of the asset. Enforces compliance with licensing agreements, territorial restrictions, and legal holds.. Valid values are `unrestricted|internal_only|licensed|embargoed|restricted_territory|legal_hold`',
    `storage_location_uri` STRING COMMENT 'Full URI path to the physical storage location of the media file (e.g., s3://bucket/path, file://server/share/path). Used by MAM for retrieval and playout automation.',
    `storage_tier` STRING COMMENT 'Current storage tier assignment based on access frequency and retention policy. Hot=online high-performance, Warm=nearline, Cold=offline tape, Deep-archive=long-term preservation, Glacier=regulatory hold.. Valid values are `hot|warm|cold|deep_archive|glacier`',
    `timecode_start` STRING COMMENT 'SMPTE timecode of the first frame in HH:MM:SS:FF format. Essential for frame-accurate editing and playout synchronization.. Valid values are `^([0-1][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9][:;][0-9]{2}$`',
    `umid` STRING COMMENT 'SMPTE 330M globally unique identifier for the media essence. 64-character hexadecimal string providing universal identification across systems and organizations.. Valid values are `^[0-9A-F]{64}$`',
    CONSTRAINT pk_media_asset PRIMARY KEY(`media_asset_id`)
) COMMENT 'Core master record for every managed digital object in the MAM (Dalet Galaxy) — raw camera footage, mezzanine masters, graphics, music beds, and archived assets. Stores canonical asset identity, technical format metadata (codec, resolution, duration, bit-rate, aspect ratio, color space, audio channels, frame rate), asset class (raw/mezzanine/proxy/archive), storage tier (hot/warm/cold/deep-archive), lifecycle status (ingest/QC/approved/archived/purged), industry identifiers (ISAN/EIDR/ISRC/UMID), originating system reference, and content classification tags. Single source of truth for all digital object identities and their technical characteristics across the enterprise.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` (
    `asset_version_id` BIGINT COMMENT 'Unique identifier for the asset version record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Asset versioning (transcoding, packaging, QC per rendition) incurs costs allocated to cost centers for chargeback and budgeting. Media operations finance teams require version-level cost attribution t',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Specific versions may be delivered by different partners (e.g., international dub from foreign partner, localized version from regional distributor). Tracks provenance for quality issues, delivery acc',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Specific asset versions (Spanish-dubbed, audio-described, childrens edit) are explicitly mapped to target demographic segments for audience-targeted delivery and DAI workflows. Distribution systems s',
    `format_specification_id` BIGINT COMMENT 'Foreign key linking to mediaasset.format_specification. Business justification: Normalization: each version conforms to a format specification from the catalog. The format_specification STRING attribute becomes a FK. Format details (codec, resolution, bitrate, etc.) retrieved via',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: Grants frequently specify which renditions are licensed (e.g., only English-dubbed SD version for a territory). Linking asset_version to grant enables rights validation at the rendition level during d',
    `media_asset_id` BIGINT COMMENT 'Reference to the parent media asset of which this is a version or rendition.',
    `rights_content_window_id` BIGINT COMMENT 'Foreign key linking to rights.rights_content_window. Business justification: Rights teams must validate that a specific asset rendition (e.g., 4K HDR, dubbed) is authorized under the applicable content window before delivery. A platform may hold rights only to SD versions; lin',
    `transcode_job_id` BIGINT COMMENT 'Reference to the transcode or encoding job that created this version. Links to workflow orchestration system (Dalet Galaxy) for lineage tracking and troubleshooting.',
    `abr_ladder_rung` STRING COMMENT 'Position in the ABR ladder for HLS or DASH streaming (e.g., 1 for lowest quality, 5 for highest). Enables adaptive streaming based on viewer bandwidth. Null if not part of an ABR ladder.',
    `archived_timestamp` TIMESTAMP COMMENT 'Timestamp when this version was moved to archive storage tier. Null if not yet archived. Supports retention policy enforcement and cost optimization.',
    `aspect_ratio` STRING COMMENT 'Display aspect ratio of the video (e.g., 16:9, 4:3, 21:9, 1:1). Determines how content is displayed on different screens and platforms.',
    `audio_channels` STRING COMMENT 'Number of audio channels in this version (e.g., 2 for stereo, 6 for 5.1 surround, 8 for 7.1 surround). Determines audio format and playback capability requirements.',
    `audio_codec` STRING COMMENT 'Audio compression codec used in this version (e.g., AAC, AC-3, Dolby Digital, Opus, MP3). Determines audio quality, compatibility, and decoding requirements.',
    `bitrate_kbps` STRING COMMENT 'Average bitrate of the encoded media in kilobits per second. Critical for ABR (Adaptive Bitrate Streaming) ladder configuration, CDN bandwidth planning, and QoS (Quality of Service) management.',
    `checksum_algorithm` STRING COMMENT 'Algorithm used to generate the checksum value (MD5, SHA-256, SHA-512). Identifies the hashing method for integrity verification.. Valid values are `MD5|SHA-256|SHA-512`',
    `checksum_value` DECIMAL(18,2) COMMENT 'Cryptographic hash (MD5 or SHA-256) of the file content. Ensures integrity verification, detects corruption during transfer or storage, and supports chain-of-custody audit trails for legal hold and regulatory compliance.',
    `color_space` STRING COMMENT 'Color space and gamut specification for this version (e.g., Rec. 709, Rec. 2020, DCI-P3, sRGB). Critical for HDR (High Dynamic Range) content and color accuracy across distribution channels.',
    `container_format` STRING COMMENT 'File container format wrapping the audio and video streams (e.g., MP4, MOV, MXF, TS, WebM). Determines file compatibility and metadata support.',
    `created_by_user` STRING COMMENT 'Username or identifier of the user or system that created this version. Supports chain-of-custody audit trails for legal hold and regulatory compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this version record was first created in the MAM (Media Asset Management) system. Supports audit trails and chain-of-custody for regulatory compliance.',
    `drm_protection` BOOLEAN COMMENT 'Indicates whether this version is protected by DRM encryption (True/False). DRM systems include Widevine, PlayReady, FairPlay. Supports content security and anti-piracy.',
    `drm_system` STRING COMMENT 'DRM system used to protect this version if drm_protection is True (e.g., Widevine, PlayReady, FairPlay, AES-128). Identifies the encryption and key management system.',
    `duration_seconds` DECIMAL(18,2) COMMENT 'Total playback duration of this version in seconds. Used for scheduling, ad pod placement, and content inventory management.',
    `file_size_bytes` BIGINT COMMENT 'Size of the media file in bytes. Used for storage capacity planning, CDN (Content Delivery Network) bandwidth estimation, and archive cost calculation.',
    `frame_rate` DECIMAL(18,2) COMMENT 'Video frame rate in frames per second (e.g., 23.98, 25.00, 29.97, 59.94). Determines playback smoothness and broadcast standard compliance (NTSC, PAL, ATSC).',
    `hdr_format` STRING COMMENT 'HDR format specification if applicable (e.g., HDR10, HDR10+, Dolby Vision, HLG). Indicates enhanced brightness and color range capabilities.',
    `language_code` STRING COMMENT 'ISO 639-2 three-letter language code for the primary audio or subtitle track in this version (e.g., eng, spa, fra, deu). Supports localized dub and multi-language distribution.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this version record was last modified. Tracks updates to metadata, status changes, or re-transcoding events.',
    `notes` STRING COMMENT 'Free-text notes or comments about this version. Used for QC feedback, production notes, or special handling instructions.',
    `proxy_expiry_date` DATE COMMENT 'Date when this proxy or preview version expires and should be purged from storage. Applicable only when rendition_purpose is proxy or preview. Supports storage cost optimization and compliance with retention policies.',
    `rendition_purpose` STRING COMMENT 'Business purpose or use case for this version: playout (broadcast transmission), distribution (delivery to platforms), archive (long-term preservation), preview (review/approval), proxy (low-res editing), watermark (forensic tracking), mezzanine (high-quality master), localized_dub (language variant), thumbnail (visual reference). [ENUM-REF-CANDIDATE: playout|distribution|archive|preview|proxy|watermark|mezzanine|localized_dub|thumbnail — 9 candidates stripped; promote to reference product]',
    `resolution_height` STRING COMMENT 'Vertical resolution of the video frame in pixels (e.g., 1080 for 1080p, 2160 for 4K). Used for format classification and quality assessment.',
    `resolution_width` STRING COMMENT 'Horizontal resolution of the video frame in pixels (e.g., 1920 for 1080p, 3840 for 4K). Used for format classification and quality assessment.',
    `storage_tier` STRING COMMENT 'Storage tier classification indicating access frequency and cost: hot (frequent access, high cost), warm (occasional access), cold (infrequent access), archive (long-term preservation), glacier (deep archive). Aligns with retention policies and cost optimization.. Valid values are `hot|warm|cold|archive|glacier`',
    `storage_uri` STRING COMMENT 'Full storage path or URI where this version is physically stored (e.g., s3://bucket/path, file://nas/volume/path, https://cdn.example.com/asset). Supports multi-tier storage (hot/warm/cold/archive) and CDN distribution via Akamai.',
    `subtitle_tracks` STRING COMMENT 'Comma-separated list of ISO 639-2 language codes for embedded subtitle or closed caption tracks (e.g., eng,spa,fra). Supports accessibility compliance (COPPA, FCC) and multi-language distribution.',
    `validated_timestamp` TIMESTAMP COMMENT 'Timestamp when this version passed quality control (QC) validation and was approved for use. Null if validation is pending or failed.',
    `version_number` STRING COMMENT 'Sequential or semantic version identifier for this rendition (e.g., v1.0, v2.3, proxy_01). Tracks lineage from camera original through derivatives.',
    `version_status` STRING COMMENT 'Current lifecycle status of this version: active (available for use), archived (moved to long-term storage), deprecated (superseded by newer version), corrupted (integrity check failed), pending_validation (awaiting QC approval), deleted (marked for removal).. Valid values are `active|archived|deprecated|corrupted|pending_validation|deleted`',
    `video_codec` STRING COMMENT 'Video compression codec used in this version (e.g., H.264/AVC, H.265/HEVC, VP9, AV1, ProRes). Determines video quality, file size, and decoding requirements.',
    `watermark_payload` STRING COMMENT 'Forensic watermark identifier or payload embedded in this version for anti-piracy tracking and content protection. Applicable only when rendition_purpose is watermark. Supports DRM (Digital Rights Management) and content security.',
    CONSTRAINT pk_asset_version PRIMARY KEY(`asset_version_id`)
) COMMENT 'Tracks every distinct version, rendition, or derivative of a media asset — including mezzanine, proxy (low-res preview/edit proxy/thumbnail), HLS/DASH adaptive bitrate ladder rungs, watermarked forensic copies, and localized dubs. Each version captures version number, rendition purpose (playout/distribution/archive/preview/proxy/watermark), format specification reference, file size, checksum (MD5/SHA-256), storage URI, transcode job reference, watermark payload (if applicable), proxy expiry date (if applicable), and version status. Enables full version lineage from camera original through every derivative to final delivery rendition.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` (
    `ingest_job_id` BIGINT COMMENT 'Unique identifier for the media ingest job. Primary key for the ingest_job data product.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Ingest operations incur labor, storage, and infrastructure costs allocated to technical operations cost centers. Enables operational cost tracking, budget variance analysis, and capacity planning.',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: Ingest job creates a specific version (typically the mezzanine or raw master). This FK links the ingest job to the version it produced. Populated upon successful ingest completion.',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Content ingest is frequently triggered by a license agreement obligation (e.g., a licensee delivers masters per contract delivery schedule). Linking ingest_job to license_agreement enables tracking of',
    `media_asset_id` BIGINT COMMENT 'Reference to the resulting media asset record created upon successful completion of the ingest job. Establishes chain-of-custody linkage.',
    `retention_policy_id` BIGINT COMMENT 'Foreign key linking to mediaasset.retention_policy. Business justification: ingest_job.retention_policy_code is a denormalized STRING code referencing the retention_policy table. Ingest jobs apply a retention policy to the ingested asset at the point of ingest. Normalizing to',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Content ingested from partner feeds (satellite, FTP, aspera) requires tracking source partner for SLA compliance monitoring, billing reconciliation, delivery acceptance workflows, and automated partne',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to mediaasset.storage_location. Business justification: ingest_job.target_storage_location is a free-text STRING URI referencing the destination storage location. Normalizing this to a FK (target_storage_location_id → storage_location.storage_location_id) ',
    `aspect_ratio` STRING COMMENT 'Display aspect ratio of the ingested video content. Determines presentation format and compatibility with distribution channels.. Valid values are `16:9|4:3|21:9|1:1|2.39:1`',
    `audio_channels` STRING COMMENT 'Number of audio channels in the ingested media (e.g., 2 for stereo, 6 for 5.1 surround). Used for audio processing and compliance validation.',
    `bitrate_kbps` STRING COMMENT 'Average bitrate of the ingested media in kilobits per second. Indicator of media quality and storage requirements.',
    `bytes_transferred` BIGINT COMMENT 'Total number of bytes successfully transferred during the ingest operation. Used for capacity planning and performance monitoring.',
    `checksum_algorithm` STRING COMMENT 'Cryptographic hash algorithm used to verify file integrity during and after ingest. Critical for chain-of-custody and regulatory compliance.. Valid values are `MD5|SHA-256|SHA-512|CRC32`',
    `checksum_value` DECIMAL(18,2) COMMENT 'Computed checksum hash of the ingested media file. Used to verify data integrity and detect corruption or tampering.',
    `closed_caption_present` BOOLEAN COMMENT 'Indicates whether closed captions or subtitles are embedded in the ingested media. Required for FCC accessibility compliance validation.',
    `codec` STRING COMMENT 'Video or audio codec used in the ingested media (e.g., H.264, H.265/HEVC, ProRes, AAC, AC-3). Critical for playback compatibility and transcoding decisions.',
    `color_space` STRING COMMENT 'Color space standard of the ingested video content. Determines color accuracy and compatibility with HDR/SDR workflows.. Valid values are `BT.709|BT.2020|DCI-P3|sRGB`',
    `content_type` STRING COMMENT 'Classification of the media content being ingested. Determines storage tier, retention policy, and downstream workflow routing. [ENUM-REF-CANDIDATE: raw_footage|mezzanine|proxy|graphics|music_bed|archived_asset|master — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ingest job record was first created in the MAM system. Audit trail entry point for chain-of-custody.',
    `duration_seconds` DECIMAL(18,2) COMMENT 'Total duration of the ingested media content in seconds. Null for non-time-based media such as still images or graphics.',
    `error_code` STRING COMMENT 'System-generated error code if the ingest job failed or encountered issues. Null for successful jobs. Maps to error catalog for troubleshooting.',
    `error_message` STRING COMMENT 'Human-readable description of any error encountered during ingest. Provides operational context for failure analysis and remediation.',
    `frame_rate` DECIMAL(18,2) COMMENT 'Frame rate of the ingested video content in frames per second (e.g., 23.976, 25, 29.97, 50, 59.94). Critical for format compatibility and playout.',
    `hdr_format` STRING COMMENT 'HDR format of the ingested video content. Null or SDR for standard dynamic range content. Critical for premium content workflows.. Valid values are `SDR|HDR10|HDR10+|Dolby_Vision|HLG`',
    `ingest_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the ingest job completed or terminated. Null for jobs still in progress.',
    `ingest_source_type` STRING COMMENT 'Classification of the media source from which content is being ingested. Determines handling protocols and validation rules.. Valid values are `tape|file_transfer|satellite_feed|cloud_upload|live_capture|ftp`',
    `ingest_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the ingest job began processing. Represents the actual start of media transfer, not the queued time.',
    `job_number` STRING COMMENT 'Human-readable business identifier for the ingest job, typically formatted as prefix-date-sequence (e.g., ING-20240115-0042). Used for operational tracking and reference.. Valid values are `^[A-Z]{3}-[0-9]{8}-[0-9]{4}$`',
    `job_status` STRING COMMENT 'Current lifecycle status of the ingest job. Tracks progression from queued through execution to final disposition.. Valid values are `queued|running|completed|failed|cancelled|paused`',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicates whether the ingested media is subject to legal hold and must be preserved for litigation or regulatory investigation. Prevents deletion.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the ingest job record was last modified. Tracks updates to job status, metadata corrections, or error resolution.',
    `notes` STRING COMMENT 'Free-text field for operator notes, special handling instructions, or contextual information about the ingest job. Used for operational communication.',
    `priority_level` STRING COMMENT 'Business priority assigned to the ingest job. Determines queue position and resource allocation for time-sensitive content.. Valid values are `urgent|high|normal|low`',
    `resolution` STRING COMMENT 'Spatial resolution of the ingested video content (e.g., 1920x1080, 3840x2160, 1280x720). Used for quality assessment and distribution planning.',
    `source_format` STRING COMMENT 'Technical format of the source media file or stream (e.g., MPEG-4, ProRes, MXF, H.264). Used for transcode planning and compatibility validation.',
    `source_location` STRING COMMENT 'Physical or logical location of the source media. May be a tape ID, file path, URL, satellite transponder identifier, or cloud storage bucket path.',
    `source_system` STRING COMMENT 'Identifier of the system or module that initiated the ingest job (e.g., Dalet Galaxy Ingest Module, automated workflow, manual operator console).',
    `target_format` STRING COMMENT 'Desired output format for the ingested media. May differ from source format if transcoding is required during ingest.',
    `timecode_start` STRING COMMENT 'Starting timecode of the ingested media in SMPTE format (HH:MM:SS:FF). Used for frame-accurate editing and synchronization.',
    `transfer_rate_mbps` DECIMAL(18,2) COMMENT 'Average data transfer rate achieved during ingest, measured in megabits per second. Key performance indicator for ingest infrastructure.',
    CONSTRAINT pk_ingest_job PRIMARY KEY(`ingest_job_id`)
) COMMENT 'Transactional record of every media ingest operation executed in Dalet Galaxy — capturing ingest source (tape, file transfer, satellite feed, cloud upload), ingest start/end timestamps, operator identity, source format, target storage location, ingest status (queued/running/completed/failed), bytes transferred, transfer rate, and any error codes encountered. Provides the chain-of-custody entry point for all assets entering the MAM. Links to the resulting media_asset record upon successful completion.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` (
    `transcode_job_id` BIGINT COMMENT 'Primary key for transcode_job',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Transcoding consumes compute resources and labor charged to post-production or technical operations cost centers. Required for project costing, vendor invoice reconciliation, and operational budgeting',
    `media_asset_id` BIGINT COMMENT 'Reference to the source media asset being transcoded.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to mediaasset.storage_location. Business justification: transcode_job.output_storage_uri is a free-text STRING URI referencing the destination storage location for transcoded output. Normalizing to a FK (output_storage_location_id → storage_location.storag',
    `production_budget_id` BIGINT COMMENT 'Foreign key linking to finance.production_budget. Business justification: Transcoding is a post-production cost line item tracked against production budgets. transcode_job has cost_estimate_usd; linking to production_budget enables actual-vs-budget variance reporting for po',
    `format_specification_id` BIGINT COMMENT 'Foreign key linking to mediaasset.format_specification. Business justification: Normalization: transcode job targets an approved format specification from the catalog. The target_format_specification STRING attribute becomes a FK. Format details retrieved via JOIN.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Transcoding is frequently outsourced to specialist vendors (e.g., Telestream, Encoding.com). Studios track which vendor performed each transcode job for SLA compliance, cost allocation against vendor ',
    `abr_ladder_configuration` STRING COMMENT 'Configuration specification for ABR ladder generation, defining the set of bitrate/resolution variants to be created for adaptive streaming (e.g., 240p@400kbps, 360p@800kbps, 480p@1.2Mbps, 720p@2.5Mbps, 1080p@5Mbps). Applicable when job_type is abr_ladder_generation.',
    `checksum_algorithm` STRING COMMENT 'Algorithm used to generate the output checksum.. Valid values are `MD5|SHA-256|SHA-512`',
    `codec_parameters` STRING COMMENT 'Detailed codec encoding parameters including profile, level, GOP structure, B-frames, reference frames, and other encoder-specific settings (e.g., x264 preset=medium, crf=23, profile=high, level=4.1).',
    `cost_estimate_usd` DECIMAL(18,2) COMMENT 'Estimated processing cost in US dollars for this transcode job, based on compute time, storage, and resource utilization. Used for chargeback and budget tracking.',
    `error_code` STRING COMMENT 'System error code if the job failed, used for troubleshooting and automated retry logic.',
    `error_message` STRING COMMENT 'Human-readable error message describing the failure reason if job_status is failed.',
    `job_number` STRING COMMENT 'Human-readable business identifier for the transcode job, used for tracking and reference across systems.. Valid values are `^TJ-[0-9]{8}-[A-Z0-9]{6}$`',
    `job_priority` STRING COMMENT 'Processing priority level for the transcode job, determining queue position and resource allocation. Critical jobs are processed immediately, batch jobs during off-peak hours.. Valid values are `critical|high|normal|low|batch`',
    `job_status` STRING COMMENT 'Current lifecycle state of the transcode job. Tracks progression from queue entry through processing to completion or failure. [ENUM-REF-CANDIDATE: queued|processing|completed|failed|retrying|cancelled|paused — 7 candidates stripped; promote to reference product]',
    `job_type` STRING COMMENT 'Classification of the transcode operation: standard transcode for routine format conversion, ABR (Adaptive Bitrate) ladder generation for streaming, proxy creation for editing workflows, delivery package preparation for distribution, or format migration for obsolescence-driven conversions. [ENUM-REF-CANDIDATE: standard_transcode|abr_ladder_generation|proxy_creation|delivery_package|format_migration|tape_digitization|analogue_to_digital — 7 candidates stripped; promote to reference product]',
    `migration_reason` STRING COMMENT 'Business justification for format migration jobs. Applicable only when job_type is format_migration, tape_digitization, or analogue_to_digital. Captures whether the conversion is driven by format obsolescence (e.g., MPEG-2 to H.265), storage optimization, distribution requirements, or regulatory compliance. [ENUM-REF-CANDIDATE: format_obsolescence|storage_optimization|distribution_requirement|quality_enhancement|compliance_mandate|archive_preservation|not_applicable — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text field for operational notes, special instructions, or contextual information about the transcode job.',
    `output_checksum` STRING COMMENT 'Cryptographic checksum (MD5, SHA-256, or SHA-512) of the output file for integrity verification and chain-of-custody audit trails.',
    `output_file_size_gb` DECIMAL(18,2) COMMENT 'Total file size of the transcoded output in gigabytes. Populated upon job completion.',
    `processing_duration_seconds` STRING COMMENT 'Total elapsed time in seconds from processing start to completion, used for performance monitoring and capacity planning.',
    `processing_end_timestamp` TIMESTAMP COMMENT 'Date and time when the transcoding engine completed or terminated processing of this job.',
    `processing_start_timestamp` TIMESTAMP COMMENT 'Date and time when the transcoding engine began processing this job.',
    `quality_validation_result` STRING COMMENT 'Outcome of automated quality validation checks performed on the transcoded output, including video integrity, audio sync, and compliance with target specifications.. Valid values are `passed|failed|warning|not_validated`',
    `quality_validation_score` DECIMAL(18,2) COMMENT 'Numeric quality score (0-100) assigned by automated validation tools, measuring output fidelity against source and target specifications.',
    `queue_entry_timestamp` TIMESTAMP COMMENT 'Date and time when the transcode job was submitted to the processing queue.',
    `retry_count` STRING COMMENT 'Number of times this job has been automatically retried after failure, used to prevent infinite retry loops.',
    `source_bitrate_mbps` DECIMAL(18,2) COMMENT 'Average bitrate of the source asset in megabits per second.',
    `source_codec` STRING COMMENT 'Video codec of the source asset (e.g., H.264, H.265/HEVC, MPEG-2, ProRes, DNxHD).',
    `source_duration_seconds` STRING COMMENT 'Duration of the source media asset in seconds.',
    `source_file_size_gb` DECIMAL(18,2) COMMENT 'File size of the source asset in gigabytes.',
    `source_format` STRING COMMENT 'Original format specification of the source asset, including container format and codec (e.g., MXF/MPEG-2, MOV/ProRes, MP4/H.264).',
    `source_resolution` STRING COMMENT 'Video resolution of the source asset in pixels (e.g., 1920x1080, 3840x2160, 1280x720).',
    `transcoding_engine` STRING COMMENT 'Name and version of the transcoding engine or software used to perform the conversion (e.g., FFmpeg 5.1.2, AWS Elemental MediaConvert, Dalet Brio).',
    CONSTRAINT pk_transcode_job PRIMARY KEY(`transcode_job_id`)
) COMMENT 'Transactional record of every format conversion operation performed on a media asset — including standard transcodes (ABR ladder generation, proxy creation, delivery package preparation) and format migrations (obsolescence-driven conversions such as MPEG-2 to H.265, tape digitisation, analogue-to-digital). Captures source asset version, target format specification, codec parameters, bitrate ladder configuration, output storage URI, job type (transcode/migration), migration reason (if applicable: format obsolescence/storage optimisation/distribution requirement), job priority, queue entry time, processing start/end timestamps, transcoding engine used, output file size, checksum, quality validation result, and job status (queued/processing/completed/failed/retrying). Single source of truth for all format conversion operations in the MAM.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` (
    `qc_inspection_id` BIGINT COMMENT 'Unique identifier for the quality control inspection record. Primary key.',
    `accessibility_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.accessibility_obligation. Business justification: QC inspections explicitly validate caption accuracy, audio description, and loudness compliance — all governed by accessibility obligations (CVAA, FCC caption rules). Accessibility compliance reportin',
    `clearance_request_id` BIGINT COMMENT 'Foreign key linking to rights.clearance_request. Business justification: Clearance analysts require QC inspection results before approving broadcast clearance. A failed QC blocks clearance; a passed QC is a prerequisite for clearance approval. Linking qc_inspection to clea',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: QC activities incur labor and tooling costs allocated to quality assurance cost centers. Supports QC budget management, headcount planning, and cost-per-inspection metrics for operational efficiency.',
    `format_specification_id` BIGINT COMMENT 'Foreign key linking to mediaasset.format_specification. Business justification: QC inspections validate technical compliance (loudness LUFS, aspect ratio, codec) against format specifications. Broadcasters define acceptance criteria in format specs; QC tools reference these for p',
    `asset_version_id` BIGINT COMMENT 'Reference to the specific version of the media asset that underwent this quality control inspection.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: QC inspections in media broadcasting are routinely performed by third-party QC vendors (e.g., Deluxe, Technicolor). Operations teams track which vendor passed/failed an asset for SLA management, vendo',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: QC inspections validate assets against FCC technical standards (CALM Act loudness, caption format mandates). Compliance teams must report which QC inspections satisfy which regulatory obligations. A m',
    `approval_status` STRING COMMENT 'Final approval decision for the media asset version based on QC inspection results. Approved assets are cleared for playout or distribution; rejected assets require remediation.. Valid values are `approved|rejected|pending_review|conditional_approval`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the asset was approved for playout or distribution following QC inspection. Null if not yet approved.',
    `aspect_ratio_compliance_result` STRING COMMENT 'Result of aspect ratio compliance check. Verifies that video aspect ratio (e.g., 16:9, 4:3, 21:9) matches expected format and Active Format Description (AFD) metadata is correct.. Valid values are `pass|fail|not_tested`',
    `audio_codec_compliance_result` STRING COMMENT 'Result of audio codec format compliance check. Verifies that audio encoding conforms to expected codec standard (e.g., AAC, Dolby Digital, Dolby Atmos, MPEG-1 Layer II).. Valid values are `pass|fail|not_tested`',
    `audio_sync_offset_ms` STRING COMMENT 'Measured audio-to-video synchronization offset in milliseconds. Positive values indicate audio leads video; negative values indicate audio lags video. Null if sync check not performed.',
    `audio_sync_result` STRING COMMENT 'Result of audio-to-video synchronization check. Detects lip-sync errors or audio drift.. Valid values are `pass|fail|not_tested`',
    `black_frame_count` STRING COMMENT 'Total number of black frames detected in the media asset. Zero if none detected.',
    `black_frame_detected` BOOLEAN COMMENT 'Indicates whether unintended black frames (video signal dropout or encoding error) were detected during inspection.',
    `caption_validation_result` STRING COMMENT 'Result of closed caption (CEA-608, CEA-708) or subtitle validation check. Verifies presence, format compliance, and synchronization of captions.. Valid values are `pass|fail|not_tested`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this QC inspection record was first created in the system. Audit trail field.',
    `critical_defect_count` STRING COMMENT 'Number of critical-severity defects that block asset approval for playout or distribution. Critical defects require remediation.',
    `defect_count` STRING COMMENT 'Total number of quality defects detected during inspection. Zero indicates no defects found.',
    `defect_summary` STRING COMMENT 'Structured JSON or delimited text summary of all detected defects with timecode references, severity levels, and defect type codes. Detailed defect records may be stored in a separate qc_defect child table.',
    `detected_aspect_ratio` STRING COMMENT 'Actual aspect ratio detected in the video stream (e.g., 16:9, 4:3, 1.85:1, 2.39:1). Null if aspect ratio check not performed.',
    `freeze_frame_count` STRING COMMENT 'Total number of freeze frame incidents detected in the media asset. Zero if none detected.',
    `freeze_frame_detected` BOOLEAN COMMENT 'Indicates whether freeze frames (static video for extended duration) were detected during inspection.',
    `hdr_format` STRING COMMENT 'Detected High Dynamic Range format or Standard Dynamic Range designation. HLG = Hybrid Log-Gamma, SDR = Standard Dynamic Range.. Valid values are `HDR10|HDR10+|Dolby Vision|HLG|SDR|unknown`',
    `hdr_metadata_validation_result` STRING COMMENT 'Result of High Dynamic Range (HDR) metadata validation check. Verifies presence and correctness of HDR10, HDR10+, Dolby Vision, or HLG metadata. Not applicable for Standard Dynamic Range (SDR) content.. Valid values are `pass|fail|not_applicable|not_tested`',
    `inspection_duration_seconds` STRING COMMENT 'Total elapsed time in seconds required to complete the quality control inspection process.',
    `inspection_number` STRING COMMENT 'Human-readable business identifier for the inspection record, formatted as QC-YYYYMMDD-NNNNNN.. Valid values are `^QC-[0-9]{8}-[0-9]{6}$`',
    `inspection_status` STRING COMMENT 'Current lifecycle state of the quality control inspection process.. Valid values are `pending|in_progress|completed|failed|cancelled`',
    `inspection_timestamp` TIMESTAMP COMMENT 'Date and time when the quality control inspection was performed or completed. Primary business event timestamp.',
    `loudness_compliance_result` STRING COMMENT 'Result of audio loudness compliance check against regulatory standards (EBU R128 for Europe, ATSC A/85 for North America, ITU-R BS.1770 globally).. Valid values are `pass|fail|not_tested`',
    `loudness_lufs` DECIMAL(18,2) COMMENT 'Measured integrated loudness level in LUFS (Loudness Units relative to Full Scale) or LKFS. Typical broadcast target is -23 LUFS (EBU R128) or -24 LKFS (ATSC A/85).',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this QC inspection record was last updated. Audit trail field.',
    `notes` STRING COMMENT 'Free-text notes or comments from the QC operator or automated tool regarding the inspection, including observations, context, or recommendations.',
    `overall_result` STRING COMMENT 'Final pass/fail determination for the quality control inspection. Conditional pass indicates minor issues that do not block playout. Review required indicates human escalation needed.. Valid values are `pass|fail|conditional_pass|review_required`',
    `qc_tool_name` STRING COMMENT 'Name and version of the automated quality control software or tool used for inspection (e.g., Baton, Interra, Venera, Dalet QC Module).',
    `qc_type` STRING COMMENT 'Classification of the quality control inspection method: automated (software-based), manual (human operator), or hybrid (combination of both).. Valid values are `automated|manual|hybrid`',
    `rejection_reason` STRING COMMENT 'Detailed explanation of why the asset was rejected, including references to specific defects or compliance failures. Null if asset was approved.',
    `video_codec_compliance_result` STRING COMMENT 'Result of video codec format compliance check. Verifies that video encoding conforms to expected codec standard (e.g., H.264/AVC, H.265/HEVC, MPEG-2, AV1).. Valid values are `pass|fail|not_tested`',
    CONSTRAINT pk_qc_inspection PRIMARY KEY(`qc_inspection_id`)
) COMMENT 'Records the quality control inspection result for each media asset version — capturing QC type (automated/manual/hybrid), inspection timestamp, operator or automated QC tool identity, pass/fail status, loudness compliance result (EBU R128 / ATSC A/85), black frame detection, freeze frame detection, audio sync check, caption/subtitle validation, aspect ratio compliance, HDR metadata validation, and a structured list of detected defects with timecode references. Mandatory gate before asset is approved for playout or distribution.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` (
    `storage_location_id` BIGINT COMMENT 'Unique identifier for the storage location within the Media Asset Management (MAM) infrastructure. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Storage locations carry cost_per_tb_per_month representing ongoing infrastructure financial commitments. Finance requires cost center attribution for storage infrastructure budgeting, vendor invoice r',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Storage locations are operated by third-party vendors (AWS, Iron Mountain, Spectra Logic). Linking to partner_partner enables vendor contract management, SLA tracking, and cost reconciliation. storage',
    `access_protocol` STRING COMMENT 'Network protocol or interface used to access the storage location (NFS = Network File System, SMB = Server Message Block, S3 = Amazon S3 API, SFTP = Secure File Transfer Protocol, iSCSI = Internet Small Computer Systems Interface, Fibre_Channel = FC SAN protocol). [ENUM-REF-CANDIDATE: NFS|SMB|S3|SFTP|iSCSI|Fibre_Channel|HTTP|HTTPS — 8 candidates stripped; promote to reference product]',
    `available_capacity_tb` DECIMAL(18,2) COMMENT 'Remaining available storage capacity (total minus used), measured in terabytes (TB). Drives automated alerts and provisioning workflows.',
    `checksum_algorithm` STRING COMMENT 'Hashing algorithm used for checksum validation (MD5 = Message Digest 5, SHA = Secure Hash Algorithm, CRC32 = Cyclic Redundancy Check). Null if checksum validation is not enabled.. Valid values are `MD5|SHA-1|SHA-256|SHA-512|CRC32`',
    `checksum_validation_enabled` BOOLEAN COMMENT 'Indicates whether automated checksum integrity validation is performed on assets stored at this location (True = enabled, False = disabled). Critical for ensuring asset integrity and detecting corruption.',
    `contact_email` STRING COMMENT 'Primary email address for the technical or operational contact responsible for this storage location. Used for alerts, maintenance coordination, and incident response.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `cost_per_tb_per_month` DECIMAL(18,2) COMMENT 'Monthly cost per terabyte of storage at this location, used for cost allocation and financial reporting. Includes infrastructure, licensing, and operational costs.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage location record was first created in the MAM system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for cost and financial reporting (e.g., USD = US Dollar, EUR = Euro, GBP = British Pound).. Valid values are `USD|EUR|GBP|JPY|AUD|CAD`',
    `data_center_name` STRING COMMENT 'Name or identifier of the physical data center or facility housing the storage infrastructure (e.g., NYC-DC1, AWS-US-East-1, Azure-WestEurope).',
    `decommission_date` DATE COMMENT 'Date when the storage location was or is planned to be decommissioned and removed from service. Null if still active. Format: yyyy-MM-dd.',
    `encryption_enabled` BOOLEAN COMMENT 'Indicates whether data-at-rest encryption is enabled for this storage location (True = encrypted, False = not encrypted). Critical for compliance with data protection regulations.',
    `encryption_method` STRING COMMENT 'Encryption algorithm or method applied to data at rest (e.g., AES-256, AES-128, RSA-2048). Null if encryption is not enabled.',
    `geographic_region` STRING COMMENT 'Geographic region or data center location where the storage is physically or logically hosted (e.g., US-East, EU-West, APAC-Singapore, On-Premise-NYC).',
    `last_capacity_check_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent capacity measurement or audit for this storage location. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage location record was last updated or modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `legal_hold_capable` BOOLEAN COMMENT 'Indicates whether this storage location supports legal hold functionality to prevent deletion or modification of assets under litigation or regulatory investigation (True = capable, False = not capable).',
    `location_code` STRING COMMENT 'Short alphanumeric code or identifier used for operational reference and system integration (e.g., SAN-PROD-01, LTO-ARCH-02, S3-USEAST).',
    `location_name` STRING COMMENT 'Human-readable name or label for the storage location (e.g., Production SAN Array 01, Archive LTO Tape Library, AWS S3 US-East Bucket).',
    `mount_point` STRING COMMENT 'File system mount point, UNC path, or object storage URI used by MAM systems to access the location (e.g., /mnt/production_san, nas01media, s3://bucket-name/prefix).',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, configuration details, or special instructions related to this storage location.',
    `operational_status` STRING COMMENT 'Current operational state of the storage location (Active = in production use, Inactive = temporarily offline, Maintenance = undergoing service, Decommissioned = retired, Provisioning = being set up).. Valid values are `Active|Inactive|Maintenance|Decommissioned|Provisioning`',
    `provisioned_date` DATE COMMENT 'Date when the storage location was initially provisioned and made available for use. Format: yyyy-MM-dd.',
    `replication_enabled` BOOLEAN COMMENT 'Indicates whether this storage location is replicated to another location for redundancy and disaster recovery (True = replicated, False = not replicated).',
    `restore_time_objective_hours` DECIMAL(18,2) COMMENT 'Maximum acceptable time to restore or retrieve assets from this storage location, measured in hours. Critical for disaster recovery and operational planning.',
    `retention_policy_days` STRING COMMENT 'Default retention period in days for assets stored at this location, after which assets may be migrated or purged per policy. Null if no default retention applies.',
    `sla_tier` STRING COMMENT 'Service level tier defining performance, availability, and support commitments (Platinum = highest availability and fastest restore, Bronze = basic service with extended restore times).. Valid values are `Platinum|Gold|Silver|Bronze`',
    `storage_tier` STRING COMMENT 'Tiering classification based on access frequency and retrieval speed requirements (Hot = immediate access for active production, Warm = nearline for recent content, Cold = infrequent access for older assets, Deep_Archive = long-term archival with extended retrieval time).. Valid values are `Hot|Warm|Cold|Deep_Archive`',
    `storage_type` STRING COMMENT 'Classification of the physical or logical storage technology (SAN = Storage Area Network, NAS = Network Attached Storage, LTO_Tape = Linear Tape-Open, Cloud_Object_Storage = S3/Azure Blob/GCS, CDN_Origin = Content Delivery Network origin store, Deep_Archive = long-term cold storage vault).. Valid values are `SAN|NAS|LTO_Tape|Cloud_Object_Storage|CDN_Origin|Deep_Archive`',
    `total_capacity_tb` DECIMAL(18,2) COMMENT 'Total storage capacity of the location measured in terabytes (TB). Used for capacity planning and allocation reporting.',
    `used_capacity_tb` DECIMAL(18,2) COMMENT 'Current amount of storage capacity consumed or allocated, measured in terabytes (TB). Updated periodically to reflect actual usage.',
    CONSTRAINT pk_storage_location PRIMARY KEY(`storage_location_id`)
) COMMENT 'Master reference for all physical and logical storage locations in the MAM infrastructure — on-premise SAN/NAS arrays, nearline LTO tape libraries, cloud object storage (S3, Azure Blob, GCS), CDN origin stores, and deep-archive vaults. Captures location name, storage type, tier classification (hot/warm/cold/deep-archive), geographic region/data centre, total capacity, used capacity, storage vendor, access protocol (NFS/SMB/S3/SFTP), SLA tier (restore time objective), and operational status. Drives automated storage tiering policy enforcement, capacity planning, and cost allocation reporting.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` (
    `asset_storage_assignment_id` BIGINT COMMENT 'Unique identifier for the asset storage assignment record. Primary key for tracking storage placement history.',
    `asset_version_id` BIGINT COMMENT 'Reference to the specific version of the media asset being stored. Tracks mezzanine, proxy, master, or archived versions.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Storage cost chargeback is a core media operations finance process. asset_storage_assignment tracks storage_cost_per_gb; linking to cost_center enables departmental storage cost allocation, budgeting,',
    `media_asset_id` BIGINT COMMENT 'Reference to the media asset that is being stored. Links to the master media asset record in the MAM (Media Asset Management) system.',
    `retention_policy_id` BIGINT COMMENT 'Reference to the retention policy governing this storage assignment. Determines how long the file must be retained and when it can be purged.',
    `storage_location_id` BIGINT COMMENT 'Reference to the physical or logical storage location where the asset file resides. Links to storage infrastructure registry.',
    `access_frequency` STRING COMMENT 'Number of times this file has been accessed since assignment to this storage location. Used to inform tiering and migration decisions.',
    `assignment_end_date` DATE COMMENT 'Date when the asset file was migrated, purged, or removed from this storage location. Null if still active at this location.',
    `assignment_end_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the asset file was migrated, purged, or removed from this storage location. Null if still active.',
    `assignment_start_date` DATE COMMENT 'Date when the asset file was placed at this storage location. Marks the beginning of the storage assignment period.',
    `assignment_start_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the asset file was placed at this storage location. Provides exact time for chain-of-custody audit trails.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of this storage assignment. Indicates whether the file is actively stored, has been moved, or has been deleted.. Valid values are `active|migrated|purged|archived|failed|pending`',
    `checksum_algorithm` STRING COMMENT 'Algorithm used to generate the checksum value. Common algorithms include MD5, SHA-1, SHA-256, SHA-512, and CRC32.. Valid values are `MD5|SHA-1|SHA-256|SHA-512|CRC32`',
    `checksum_value` DECIMAL(18,2) COMMENT 'Cryptographic hash or checksum of the file at placement time. Ensures file integrity verification and detects corruption or tampering.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage assignment record was first created in the system. Used for audit trails and data lineage.',
    `file_path` STRING COMMENT 'Complete file system path or URI where the asset file is physically stored. Enables restore path resolution and file retrieval.',
    `file_size_bytes` BIGINT COMMENT 'Size of the asset file in bytes at the time of storage assignment. Used for capacity planning and storage cost allocation.',
    `geographic_region` STRING COMMENT 'Geographic region or data center location where the storage resides. Used for data sovereignty compliance and disaster recovery planning.',
    `last_access_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent access to this file at this storage location. Used for tiering policy enforcement and usage analytics.',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicates whether this storage assignment is subject to a legal hold. When true, the file cannot be deleted or modified regardless of retention policy.',
    `migration_trigger` STRING COMMENT 'Reason why the asset was moved to or from this storage location. Captures business or technical driver for storage placement decisions.. Valid values are `tiering_policy|legal_hold|cost_optimization|format_migration|capacity_rebalance|manual_request`',
    `notes` STRING COMMENT 'Free-text notes or comments about this storage assignment. Captures context, special handling instructions, or migration rationale.',
    `replication_count` STRING COMMENT 'Number of redundant copies of this file maintained at this storage location. Used for disaster recovery and high availability planning.',
    `storage_cost_per_gb` DECIMAL(18,2) COMMENT 'Cost per gigabyte for this storage tier at the time of assignment. Used for storage cost allocation and financial reporting.',
    `storage_tier` STRING COMMENT 'Storage tier classification at the time of assignment. Indicates performance and cost characteristics: hot (high-performance online), warm (standard online), cold (infrequent access), archive (long-term preservation), nearline (tape/optical near-online), offline (physical media vault).. Valid values are `hot|warm|cold|archive|nearline|offline`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage assignment record was last modified. Used for change tracking and audit trails.',
    `verification_status` STRING COMMENT 'Status of file integrity verification at this storage location. Indicates whether checksum validation has been performed and passed.. Valid values are `pending|verified|failed|not_verified`',
    `verification_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent integrity verification check. Used to track compliance with periodic verification policies.',
    CONSTRAINT pk_asset_storage_assignment PRIMARY KEY(`asset_storage_assignment_id`)
) COMMENT 'Tracks the complete storage placement history for every media asset version — recording which file resides at which storage location, when it was placed there, and why it moved. Captures storage location reference, file path/URI, storage tier at time of assignment, assignment start date, end date (if migrated or purged), file size, checksum at placement, migration trigger (tiering policy/legal hold/cost optimisation/format migration/capacity rebalance), and verification status. Provides the authoritative chain-of-custody for physical file placement, drives storage capacity reporting, enables restore path resolution, and supports legal discovery by proving where a file was at any point in time.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` (
    `retention_policy_id` BIGINT COMMENT 'Unique identifier for the retention policy record. Primary key.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Retention policies in media broadcasting are directly mandated by regulatory obligations (FCC political ad 2-year retention, EAS log retention rules). Compliance teams must trace each retention policy',
    `supersedes_policy_retention_policy_id` BIGINT COMMENT 'Reference to the previous retention policy that this policy replaces. Null if this is the first version. Supports policy lineage and historical analysis.',
    `applies_to_legal_hold` BOOLEAN COMMENT 'Indicates whether this retention policy applies to assets under legal hold. If false, legal hold assets are exempt from automated lifecycle actions governed by this policy.',
    `applies_to_syndication_content` BOOLEAN COMMENT 'Indicates whether this retention policy applies to syndicated content (content resold to multiple outlets). Syndication agreements may impose distinct retention obligations.',
    `asset_class_scope` STRING COMMENT 'The category of media assets to which this retention policy applies. Aligns with MAM (Media Asset Management) asset classification in Dalet Galaxy. [ENUM-REF-CANDIDATE: raw|mezzanine|proxy|archive|master|graphics|audio|metadata — 8 candidates stripped; promote to reference product]',
    `audit_trail_required` BOOLEAN COMMENT 'Indicates whether a full chain-of-custody audit trail must be maintained for assets governed by this policy. Critical for regulatory compliance and legal hold scenarios.',
    `checksum_verification_required` BOOLEAN COMMENT 'Indicates whether checksum integrity verification is mandatory before executing post-retention actions. Ensures asset integrity throughout the retention lifecycle.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this retention policy record was first created in the system.',
    `effective_date` DATE COMMENT 'The date on which this retention policy becomes enforceable. Assets ingested or classified on or after this date are subject to the policy.',
    `expiry_date` DATE COMMENT 'The date on which this retention policy ceases to be enforceable. Null indicates the policy remains in effect indefinitely until explicitly retired.',
    `format_migration_allowed` BOOLEAN COMMENT 'Indicates whether format migration (transcoding to newer codecs or containers) is permitted during the retention period. Supports long-term preservation and format obsolescence mitigation.',
    `geographic_scope` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes indicating the geographic jurisdictions to which this policy applies (e.g., USA,GBR,CAN). Supports multi-jurisdictional compliance.',
    `last_modified_by` STRING COMMENT 'The user ID or system identifier that last modified this retention policy record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this retention policy record was last updated.',
    `maximum_retention_period_days` STRING COMMENT 'The maximum number of days an asset may be retained before mandatory action (purge or archive migration). Null indicates indefinite retention.',
    `minimum_retention_period_days` STRING COMMENT 'The minimum number of days an asset must be retained before any deletion or migration action can occur. Enforces regulatory and contractual obligations.',
    `notification_recipients` STRING COMMENT 'Comma-separated list of email addresses or role identifiers to be notified when retention actions are triggered (e.g., legal@mediabroadcasting.com, content-ops-team).',
    `policy_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the policy for system integration and reporting (e.g., RET-MAST-7Y, RET-RAW-90D).. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `policy_description` STRING COMMENT 'Detailed business description of the retention policy, including rationale, scope, and any special handling instructions.',
    `policy_name` STRING COMMENT 'Business-friendly name of the retention policy (e.g., Broadcast Master Archive Policy, Raw Footage 90-Day Purge).',
    `policy_owner` STRING COMMENT 'The business role, department, or individual responsible for defining and maintaining this retention policy (e.g., Legal & Compliance, Media Operations Director, Chief Content Officer).',
    `policy_status` STRING COMMENT 'Current lifecycle state of the retention policy. Only active policies are enforced by automated lifecycle management workflows.. Valid values are `draft|active|suspended|retired|under_review`',
    `post_retention_action` STRING COMMENT 'The action to be taken when the retention period expires. Drives automated lifecycle workflows in MAM (Media Asset Management) systems.. Valid values are `purge|migrate_to_deep_archive|notify_rights_owner|manual_review|transfer_to_external_archive`',
    `priority_level` STRING COMMENT 'The business priority of this retention policy. Critical policies (e.g., legal hold, regulatory mandate) take precedence over lower-priority policies when conflicts arise.. Valid values are `critical|high|medium|low`',
    `regulatory_basis` STRING COMMENT 'The regulatory framework, statute, or compliance requirement that mandates or informs this retention policy (e.g., FCC 47 CFR 73.1840, Ofcom Section 11, GDPR Article 5, SOX Section 802, Legal Hold Case #12345).',
    `retention_trigger` STRING COMMENT 'The business event that starts the retention clock for this policy (e.g., when the asset was ingested, when it was first broadcast, when the licensing contract expires, or when a legal hold is placed).. Valid values are `ingest_date|broadcast_date|contract_expiry|legal_hold|last_access_date|rights_expiry`',
    `storage_tier_target` STRING COMMENT 'The target storage tier for assets governed by this policy after the retention period. Aligns with tiered storage strategies in MAM (Media Asset Management) and CDN (Content Delivery Network) architectures.. Valid values are `hot|warm|cold|deep_archive|glacier`',
    `version_number` STRING COMMENT 'Sequential version number of this retention policy. Incremented each time the policy is revised. Supports policy change tracking and audit compliance.',
    `created_by` STRING COMMENT 'The user ID or system identifier that created this retention policy record.',
    CONSTRAINT pk_retention_policy PRIMARY KEY(`retention_policy_id`)
) COMMENT 'Defines the business retention rules applied to media assets — capturing policy name, asset class scope (raw/mezzanine/proxy/archive), minimum retention period, maximum retention period, retention trigger (ingest date / broadcast date / contract expiry / legal hold), post-retention action (purge/migrate-to-deep-archive/notify-rights-owner), regulatory basis (FCC, Ofcom, GDPR, SOX, legal hold), policy owner, effective date, and expiry date. Drives automated lifecycle management and ensures regulatory compliance for asset archival and deletion.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` (
    `format_specification_id` BIGINT COMMENT 'Unique identifier for the format specification record. Primary key.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Format specifications in broadcasting are engineered to satisfy specific regulatory obligations (e.g., CALM Act -24 LKFS loudness standard, FCC caption format rules). Compliance engineers need to audi',
    `approval_date` DATE COMMENT 'Date when this format specification was officially approved for production use.',
    `approved_by` STRING COMMENT 'Name or identifier of the technical authority or committee that approved this format specification for production use.',
    `aspect_ratio` STRING COMMENT 'Display aspect ratio of the video frame (e.g., 16:9 for widescreen, 4:3 for standard, 21:9 for cinematic).',
    `audio_bit_depth` STRING COMMENT 'Audio bit depth in bits per sample (e.g., 16-bit for standard, 24-bit for professional, 32-bit float for mastering).',
    `audio_channel_configuration` STRING COMMENT 'Audio channel layout and count (e.g., stereo 2.0, surround 5.1, immersive 7.1.4 Dolby Atmos, mono 1.0).',
    `audio_codec` STRING COMMENT 'Audio compression codec used for encoding (e.g., AAC, PCM, Dolby AC-3, Dolby E, Dolby Atmos, MPEG-1 Layer II).',
    `audio_sample_rate_khz` DECIMAL(18,2) COMMENT 'Audio sampling frequency in kilohertz (e.g., 48.000 kHz for broadcast, 44.100 kHz for CD quality, 96.000 kHz for high-resolution).',
    `bit_rate_mbps` DECIMAL(18,2) COMMENT 'Target video bit rate in megabits per second (Mbps) for encoding, determining quality and file size.',
    `bit_rate_mode` STRING COMMENT 'Encoding bit rate control mode: CBR (Constant Bit Rate), VBR (Variable Bit Rate), or ABR (Average Bit Rate / Adaptive Bitrate Streaming).. Valid values are `CBR|VBR|ABR`',
    `checksum_algorithm` STRING COMMENT 'Cryptographic hash algorithm used for file integrity verification and chain-of-custody audit (MD5, SHA-1, SHA-256, SHA-512, xxHash).. Valid values are `MD5|SHA1|SHA256|SHA512|xxHash`',
    `color_space` STRING COMMENT 'Color space standard used for video encoding (e.g., BT.709 for HD, BT.2020 for UHD, DCI-P3 for cinema).',
    `container_format` STRING COMMENT 'File container format that wraps the encoded video and audio streams (MXF for broadcast, MP4 for web, MOV for production, TS for streaming, AVI legacy, MKV open-source).. Valid values are `MXF|MP4|MOV|TS|AVI|MKV`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this format specification record was first created in the system.',
    `drm_compatibility` STRING COMMENT 'Digital Rights Management systems compatible with this format (e.g., Widevine, FairPlay, PlayReady, none for unencrypted).',
    `effective_from_date` DATE COMMENT 'Date from which this format specification becomes active and available for use in production workflows.',
    `effective_until_date` DATE COMMENT 'Date when this format specification is scheduled to be deprecated or retired. Null for formats with no planned end date.',
    `file_extension` STRING COMMENT 'Standard file extension for files encoded in this format (e.g., .mxf, .mp4, .mov, .ts, .m3u8).',
    `format_category` STRING COMMENT 'Classification of the format by its intended use case in the media workflow: ingest (acquisition), mezzanine (high-quality intermediate), proxy (low-res editing), playout (broadcast transmission), OTT delivery (streaming), or archive (long-term preservation).. Valid values are `ingest|mezzanine|proxy|playout|ott_delivery|archive`',
    `format_code` STRING COMMENT 'Unique business identifier code for the format specification used across systems and workflows.',
    `format_name` STRING COMMENT 'Human-readable name of the media format specification (e.g., HD 1080p H.264 AAC, 4K UHD HEVC Dolby Atmos).',
    `frame_rate` DECIMAL(18,2) COMMENT 'Video frame rate in frames per second (fps), e.g., 23.976, 24.000, 25.000, 29.970, 30.000, 50.000, 59.940, 60.000.',
    `governing_standard` STRING COMMENT 'Primary industry or regulatory standard governing this format specification (e.g., ATSC 3.0, DVB-T2, SMPTE ST 2110, ISO/IEC 14496, ITU-R BT.2020).',
    `hdr_standard` STRING COMMENT 'High Dynamic Range standard applied to the format (e.g., HDR10, HDR10+, HLG (Hybrid Log-Gamma), Dolby Vision, none for SDR).',
    `horizontal_resolution` STRING COMMENT 'Horizontal pixel count of the video frame (e.g., 1920 for Full HD, 3840 for UHD).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this format specification record was last updated or modified.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the format specification: active (in production use), deprecated (phasing out), retired (no longer used), draft (under development), under_review (pending approval), or approved (ready for deployment).. Valid values are `active|deprecated|retired|draft|under_review|approved`',
    `loudness_standard` STRING COMMENT 'Audio loudness normalization standard applied (e.g., ITU-R BS.1770-4 LKFS, EBU R128 LUFS, ATSC A/85 for broadcast).',
    `mime_type` STRING COMMENT 'MIME (Multipurpose Internet Mail Extensions) type for HTTP delivery and content negotiation (e.g., video/mp4, application/mxf, video/MP2T).',
    `qc_profile` STRING COMMENT 'Quality control validation profile applied to assets in this format, defining automated checks for technical compliance (e.g., video levels, audio loudness, format conformance).',
    `resolution_class` STRING COMMENT 'Video resolution classification: SD (Standard Definition 480/576), HD (720p), FHD (Full HD 1080p), UHD (Ultra HD 2160p), 4K (4096x2160), 8K (7680x4320).. Valid values are `SD|HD|FHD|UHD|4K|8K`',
    `retention_period_years` STRING COMMENT 'Minimum retention period in years for assets encoded in this format, driven by regulatory, legal hold, or business requirements.',
    `scan_type` STRING COMMENT 'Video scanning method: progressive (all lines scanned sequentially, denoted p) or interlaced (alternating fields, denoted i).. Valid values are `progressive|interlaced`',
    `storage_tier` STRING COMMENT 'Recommended storage tier for assets in this format based on access frequency and retention policy: hot (frequent access), warm (occasional access), cold (infrequent access), archive (long-term preservation), glacier (deep archive).. Valid values are `hot|warm|cold|archive|glacier`',
    `streaming_protocol` STRING COMMENT 'Streaming delivery protocol supported by this format (e.g., HLS (HTTP Live Streaming), MPEG-DASH (Dynamic Adaptive Streaming over HTTP), RTMP, SRT, none for file-based).',
    `subtitle_format` STRING COMMENT 'Subtitle or closed caption format supported (e.g., SRT, WebVTT, TTML, CEA-608, CEA-708, EBU-TT-D, none if not applicable).',
    `target_loudness_lufs` DECIMAL(18,2) COMMENT 'Target integrated loudness level in LUFS (Loudness Units relative to Full Scale) or LKFS, typically -23 LUFS for broadcast, -14 LUFS for streaming.',
    `transcode_priority` STRING COMMENT 'Default processing priority for transcode jobs targeting this format: critical (immediate), high (expedited), normal (standard queue), low (off-peak), batch (scheduled bulk processing).. Valid values are `critical|high|normal|low|batch`',
    `vertical_resolution` STRING COMMENT 'Vertical pixel count of the video frame (e.g., 1080 for Full HD, 2160 for UHD).',
    `video_codec` STRING COMMENT 'Video compression codec used for encoding (e.g., H.264/AVC, H.265/HEVC, AV1, Apple ProRes, Avid DNxHD, MPEG-2).',
    CONSTRAINT pk_format_specification PRIMARY KEY(`format_specification_id`)
) COMMENT 'Reference catalogue of all approved media format specifications used across the enterprise — capturing format name, container format (MXF, MP4, MOV, TS), video codec (H.264, H.265/HEVC, AV1, ProRes, DNxHD), audio codec (AAC, PCM, Dolby AC-3, Dolby Atmos), resolution class (SD/HD/UHD/4K/8K), frame rate, scan type (progressive/interlaced), HDR standard (HDR10, HLG, Dolby Vision), audio loudness spec, subtitle/caption format, intended use case (ingest/mezzanine/proxy/playout/OTT-delivery/archive), and governing standard reference (ATSC, DVB, HLS, MPEG-DASH). Drives transcode job configuration and QC compliance checks.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` (
    `asset_collection_id` BIGINT COMMENT 'Unique identifier for the asset collection. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Collections (series, franchises) are managed under specific cost centers for production and library management budgets. Enables portfolio-level cost tracking and multi-title project accounting.',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Asset collections are curated content packages assembled for specific demographic targets (childrens blocks, sports packages, primetime drama). Content packaging and licensing workflows require linki',
    `market_coverage_id` BIGINT COMMENT 'Foreign key linking to audience.market_coverage. Business justification: Asset collections are assembled for specific geographic markets with defined coverage areas (DMA, country). Linking to market_coverage enables geographic rights management, blackout rule enforcement, ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Collections drive revenue streams (box sets, franchise licensing, library sales) tracked by profit center. Critical for franchise P&L reporting, content portfolio valuation, and strategic investment d',
    `retention_policy_id` BIGINT COMMENT 'Foreign key linking to mediaasset.retention_policy. Business justification: Normalization: asset_collection has retention_policy_code STRING which should be FK to retention_policy catalog. This connects asset_collection to the relational graph and allows retrieving full polic',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Asset collections are licensed and distributed as revenue-generating packages (e.g., series licensed to SVOD platforms). Linking to revenue_stream enables revenue attribution, ASC 606 performance obli',
    `archive_tier` STRING COMMENT 'Storage tier classification for the collection: hot (frequent access), warm (occasional access), cold (rare access), glacier (long-term preservation), or deep-archive (regulatory retention).. Valid values are `hot|warm|cold|glacier|deep-archive`',
    `asset_collection_description` STRING COMMENT 'Detailed narrative description of the collections content, purpose, and editorial context. Used for cataloging and discovery.',
    `asset_collection_status` STRING COMMENT 'Current lifecycle status of the collection: draft (being assembled), active (available for use), archived (preserved but not active), deprecated (superseded), under-review (pending approval), or locked (no modifications allowed).. Valid values are `draft|active|archived|deprecated|under-review|locked`',
    `audio_description_available_flag` BOOLEAN COMMENT 'Indicates whether audio description tracks are available for visually impaired audiences (true) or not (false). Required for accessibility compliance.',
    `bulk_operation_enabled` BOOLEAN COMMENT 'Indicates whether bulk operations (bulk QC, bulk rights check, bulk archive, bulk transcode) are enabled for this collection (true) or must be performed individually (false).',
    `checksum_algorithm` STRING COMMENT 'Algorithm used to generate checksums for integrity verification of the collection package (MD5, SHA-1, SHA-256, SHA-512, or xxHash).. Valid values are `MD5|SHA-1|SHA-256|SHA-512|xxHash`',
    `checksum_value` DECIMAL(18,2) COMMENT 'Computed checksum value for the collection package, used to verify data integrity during transfer, storage, and archival.',
    `closed_caption_available_flag` BOOLEAN COMMENT 'Indicates whether closed captions are available for all time-based assets in the collection (true) or not (false). Required for FCC compliance.',
    `collection_code` STRING COMMENT 'Business identifier or code for the collection, used for external reference and cataloging (e.g., GOT-S08-PKG, NEWS-ELEC24-001).',
    `collection_name` STRING COMMENT 'Human-readable name of the asset collection (e.g., Breaking News Package - Election 2024, Game of Thrones Season 8 Bundle, Super Bowl LVIII Highlights).',
    `collection_type` STRING COMMENT 'Classification of the collection by content grouping purpose: series (episodic television), film-franchise (related films), news-package (story bundle), sports-event (game/match clips), music-album (music tracks), campaign-creative (advertising assets), documentary-series, special-event, archive-bundle, or promo-package. [ENUM-REF-CANDIDATE: series|film-franchise|news-package|sports-event|music-album|campaign-creative|documentary-series|special-event|archive-bundle|promo-package — 10 candidates stripped; promote to reference product]',
    `content_rating` STRING COMMENT 'Age-appropriateness or content rating for the collection (e.g., TV-PG, TV-14, TV-MA, G, PG, PG-13, R). Used for compliance and scheduling.',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created the collection record in the MAM system. Used for audit trail and accountability.',
    `curator_name` STRING COMMENT 'Name of the individual or team responsible for curating and maintaining the collection.',
    `distribution_window_end` DATE COMMENT 'End date of the distribution window after which the collection may no longer be distributed or broadcast. Part of windowing strategy.',
    `distribution_window_start` DATE COMMENT 'Start date of the distribution window during which the collection may be distributed or broadcast. Part of windowing strategy.',
    `eidr_identifier` STRING COMMENT 'Globally unique EIDR identifier for the collection, used for rights management and content identification across the industry.. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$`',
    `language_code` STRING COMMENT 'Primary language of the collection content, using ISO 639-3 three-letter language codes (e.g., eng for English, spa for Spanish, fra for French).. Valid values are `^[a-z]{3}$`',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified the collection record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the collection or its membership (asset added, removed, or metadata updated).',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicates whether the collection is under legal hold (true) or not (false). Assets under legal hold cannot be deleted or modified.',
    `metadata_completeness_score` DECIMAL(18,2) COMMENT 'Percentage score (0.00 to 100.00) indicating the completeness of metadata across all assets in the collection. Used for quality assurance and discoverability.',
    `notes` STRING COMMENT 'Free-form notes or comments about the collection, used for internal communication, special handling instructions, or editorial context.',
    `owner_department` STRING COMMENT 'Business unit or department responsible for the collection (e.g., News Editorial, Sports Production, Entertainment Programming, Marketing Creative Services).',
    `packaging_format` STRING COMMENT 'Technical packaging format used for distribution (e.g., IMF, DPP, AS-11, ProRes Package, MPEG-DASH Manifest). Relevant for distribution deals.',
    `primary_genre` STRING COMMENT 'Primary content genre or category for the collection (e.g., Drama, News, Sports, Documentary, Comedy, Music, Reality).',
    `qc_status` STRING COMMENT 'Quality control status for the collection as a whole: not-started, in-progress, passed (all assets QC approved), failed (one or more assets failed QC), or waived (QC not required).. Valid values are `not-started|in-progress|passed|failed|waived`',
    `rights_clearance_status` STRING COMMENT 'Status of rights clearance for the entire collection: cleared (all rights verified), pending (clearance in progress), restricted (usage limitations), expired (rights lapsed), or not-required (no clearance needed).. Valid values are `cleared|pending|restricted|expired|not-required`',
    `syndication_eligible_flag` BOOLEAN COMMENT 'Indicates whether the collection is eligible for syndication (resale to multiple outlets) based on rights and content suitability (true) or not (false).',
    `total_asset_count` STRING COMMENT 'Total number of media assets currently included in the collection.',
    `total_duration_seconds` BIGINT COMMENT 'Cumulative playback duration of all time-based assets in the collection, measured in seconds.',
    `total_storage_size_bytes` BIGINT COMMENT 'Total storage footprint of all assets in the collection, measured in bytes. Used for capacity planning and archival costing.',
    `creation_date` DATE COMMENT 'Date when the collection was first created in the MAM (Media Asset Management) system.',
    CONSTRAINT pk_asset_collection PRIMARY KEY(`asset_collection_id`)
) COMMENT 'Defines logical groupings of media assets for editorial, distribution, or archival purposes — such as a series package, film franchise bundle, news story package, sports event clip collection, or music album. Captures collection name, type (series/film/news-package/sports-event/music-album/campaign-creative), description, creation date, owner department, status, and an ordered member list with membership role (primary/supplemental/bonus/trailer/promo), sequence position, and inclusion dates. Enables bulk operations (bulk QC, bulk rights check, bulk archive) and supports content packaging for distribution deals.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` (
    `archive_record_id` BIGINT COMMENT 'Primary key for archive_record',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to mediaasset.storage_location. Business justification: archive_record describes where an asset is archived (archive_destination_identifier, archive_destination_type, storage_tier) but has no FK to the storage_location master. For archive destinations that',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: Archive operations target specific versions (mezzanine, proxy, master) not just the abstract asset. This FK allows tracking which exact rendition was archived. Nullable initially, populated during arc',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Archive operations (tape handling, vault storage, retrieval) incur costs allocated to archive management cost centers. Supports archive budget tracking, cost-per-asset metrics, and storage tier optimi',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Archives may be held at partner facilities (Iron Mountain, AWS Glacier, offsite vaults). Tracks custodian partner for retrieval requests, audit compliance, disaster recovery planning, and vendor perfo',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Archive retention obligations are directly governed by license agreement terms (e.g., content must be retained for the license duration; purge eligibility is triggered by license expiry). Linking arch',
    `media_asset_id` BIGINT COMMENT 'Reference to the media asset being archived. Links to the source digital asset in the Media Asset Management (MAM) system.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Archive records document long-term asset storage mandated by FCC and other regulatory obligations (political ad records, EAS logs, public file documents). Compliance auditors must link each archive re',
    `retention_policy_id` BIGINT COMMENT 'Foreign key linking to mediaasset.retention_policy. Business justification: archive_record.retention_policy_code is a denormalized STRING code referencing the retention_policy table (which has a policy_code attribute). Normalizing to a FK (retention_policy_id → retention_poli',
    `archive_cost_per_gb` DECIMAL(18,2) COMMENT 'The cost per gigabyte for storing the asset in the archive destination, used for financial planning and cost allocation.',
    `archive_date` DATE COMMENT 'The date when the media asset was formally archived to long-term storage.',
    `archive_destination_identifier` STRING COMMENT 'Specific identifier for the archive destination such as LTO (Linear Tape-Open) tape barcode, cloud vault identifier, or off-site facility location code.',
    `archive_destination_type` STRING COMMENT 'The type of long-term storage destination where the asset was archived.. Valid values are `lto_tape|cloud_deep_archive|offsite_facility|nearline_storage|optical_media|hybrid_archive`',
    `archive_file_size_bytes` BIGINT COMMENT 'The size of the archived media file in bytes, used for storage capacity planning and billing.',
    `archive_format` STRING COMMENT 'The file format or container format of the archived asset (e.g., MXF, MOV, MP4, ProRes, DNxHD) as stored in the archive.',
    `archive_job_reference` STRING COMMENT 'Unique reference number assigned to the archival job or batch process that created this archive record.',
    `archive_notes` STRING COMMENT 'Free-text notes or comments about the archival process, special handling instructions, or any issues encountered during archival.',
    `archive_status` STRING COMMENT 'Current lifecycle status of the archived asset indicating its availability and operational state. [ENUM-REF-CANDIDATE: archived|restore_requested|restore_in_progress|restored|purge_pending|purged|failed — 7 candidates stripped; promote to reference product]',
    `archive_system_name` STRING COMMENT 'Name of the archival system or MAM module that performed the archival operation (e.g., Dalet Galaxy Archive, Spectra Logic).',
    `archive_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the archival process completed and the asset was committed to long-term storage.',
    `checksum_algorithm` STRING COMMENT 'The cryptographic hash algorithm used to generate the checksum for verifying asset integrity during archival and restore operations.. Valid values are `md5|sha256|sha512|xxhash`',
    `checksum_value` DECIMAL(18,2) COMMENT 'The computed checksum hash value of the archived media asset, used to verify data integrity and detect corruption.',
    `cloud_vault_identifier` STRING COMMENT 'Unique identifier for the cloud deep-archive vault or bucket where the asset is stored (e.g., AWS Glacier vault ARN, Azure Archive Storage container).',
    `compression_codec` STRING COMMENT 'The compression codec applied to the media asset for archival storage (e.g., H.264, H.265, JPEG2000, uncompressed).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this archive record was first created in the system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this archive record was last updated or modified.',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicates whether the archived asset is under legal hold, preventing deletion or modification regardless of retention policy.',
    `lto_tape_generation` STRING COMMENT 'The LTO tape generation standard used for archival (e.g., LTO-8, LTO-9) if the destination is tape-based storage.',
    `oais_compliance_flag` BOOLEAN COMMENT 'Indicates whether this archive record complies with ISO 14721 OAIS reference model standards for long-term digital preservation.',
    `offsite_facility_code` STRING COMMENT 'Code identifying the physical off-site archival facility or vault location where the media is stored.',
    `purge_approval_status` STRING COMMENT 'Approval status for purging the archived asset, ensuring compliance with retention and legal hold requirements before deletion.. Valid values are `pending|approved|rejected|not_required`',
    `purge_scheduled_date` DATE COMMENT 'The scheduled date for purging or permanently deleting the archived asset, based on retention policy expiration.',
    `restore_completion_date` DATE COMMENT 'The date when the restore operation was completed and the asset was made available for use.',
    `restore_request_date` DATE COMMENT 'The date when a restore request was submitted for this archived asset, if applicable.',
    `restore_sla_tier` STRING COMMENT 'The service level tier defining the expected restore time for retrieving this archived asset (e.g., expedited within hours, standard within days, bulk within weeks).. Valid values are `expedited|standard|bulk|emergency`',
    `restore_test_date` DATE COMMENT 'The date when the last restore test was performed to verify the integrity and retrievability of the archived asset.',
    `restore_test_result` STRING COMMENT 'Outcome of the most recent restore test indicating whether the asset was successfully retrieved and validated.. Valid values are `passed|failed|partial|not_tested`',
    `retention_expiry_date` DATE COMMENT 'The date when the retention period expires and the asset becomes eligible for purging or disposition review.',
    `storage_tier` STRING COMMENT 'The storage tier classification indicating access frequency and cost structure (hot for frequent access, deep archive for infrequent access).. Valid values are `hot|warm|cold|deep_archive`',
    `tape_barcode` STRING COMMENT 'Physical barcode identifier on the LTO tape cartridge used for archival, enabling physical inventory tracking.',
    CONSTRAINT pk_archive_record PRIMARY KEY(`archive_record_id`)
) COMMENT 'Tracks the formal archival of media assets to long-term storage — capturing archive date, archive destination (LTO tape generation, cloud deep-archive vault, off-site facility), archive job reference, tape barcode or vault identifier, restore SLA tier, restore test date, restore test result, retention policy applied, archival operator, and archive status (archived/restore-requested/restored/purge-pending). Supports ISO 14721 OAIS compliance and provides the authoritative record for asset archival and retrieval operations.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`mediaasset`.`collection_membership` (
    `collection_membership_id` BIGINT COMMENT 'Unique identifier for this collection membership record. Primary key.',
    `asset_collection_id` BIGINT COMMENT 'Foreign key linking to the asset collection that contains this member asset',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to the media asset that is a member of this collection',
    `added_by_user` STRING COMMENT 'Username or identifier of the user who added this asset to the collection. Used for audit trail and editorial accountability. Explicitly identified in detection reasoning.',
    `added_timestamp` TIMESTAMP COMMENT 'Date and time when this asset was added to the collection. Used for audit trail and membership history tracking. Explicitly identified in detection reasoning.',
    `inclusion_end_date` DATE COMMENT 'Effective end date for this assets inclusion in the collection, used for time-windowed distribution packages and rights management. Null if inclusion is indefinite.',
    `inclusion_start_date` DATE COMMENT 'Effective start date for this assets inclusion in the collection, used for time-windowed distribution packages and rights management.',
    `inclusion_status` STRING COMMENT 'Current lifecycle status of this membership: active (currently included), pending (queued for inclusion), removed (excluded from collection), archived (historical record). Explicitly identified in detection reasoning.',
    `membership_role` STRING COMMENT 'Classification of the assets role within the collection: primary (main content), supplemental (related content), bonus (extras), trailer (preview), promo (promotional material). Determines how the asset is used in distribution and presentation.',
    `notes` STRING COMMENT 'Free-form notes about this specific membership, such as editorial rationale, special handling instructions, or usage restrictions specific to this asset-collection pairing.',
    `removed_by_user` STRING COMMENT 'Username or identifier of the user who removed this asset from the collection, if applicable. Null if membership is still active.',
    `removed_timestamp` TIMESTAMP COMMENT 'Date and time when this asset was removed from the collection, if applicable. Null if membership is still active. Used for membership lifecycle tracking.',
    `sequence_number` STRING COMMENT 'Ordinal position of this asset within the collection. Used for playback order in series, episode numbering, or display sequence in packages. Explicitly identified in detection reasoning.',
    CONSTRAINT pk_collection_membership PRIMARY KEY(`collection_membership_id`)
) COMMENT 'This association product represents the membership relationship between asset_collection and media_asset. It captures the inclusion of individual media assets within editorial collections, series packages, news story bundles, and distribution packages. Each record links one asset_collection to one media_asset with attributes that define the role, sequence, and lifecycle of that specific membership relationship. Editorial teams actively create, reorder, and manage these memberships as part of content packaging and distribution workflows.. Existence Justification: In media broadcasting operations, asset collections (series packages, news story bundles, film franchise collections, music albums) routinely contain multiple media assets, and individual assets frequently appear in multiple collections simultaneously—a raw interview clip may be part of a breaking news package, a documentary series collection, and an archival topic bundle. Editorial teams actively manage collection membership as a distinct operational activity, creating, reordering, and removing memberships with specific roles (primary/supplemental/bonus/trailer/promo), sequence positions, and inclusion dates. This is not an analytical correlation but a core content packaging workflow.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ADD CONSTRAINT `fk_mediaasset_media_asset_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ADD CONSTRAINT `fk_mediaasset_asset_version_format_specification_id` FOREIGN KEY (`format_specification_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`format_specification`(`format_specification_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ADD CONSTRAINT `fk_mediaasset_asset_version_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ADD CONSTRAINT `fk_mediaasset_asset_version_transcode_job_id` FOREIGN KEY (`transcode_job_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`transcode_job`(`transcode_job_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ADD CONSTRAINT `fk_mediaasset_ingest_job_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ADD CONSTRAINT `fk_mediaasset_ingest_job_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ADD CONSTRAINT `fk_mediaasset_ingest_job_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ADD CONSTRAINT `fk_mediaasset_ingest_job_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`storage_location`(`storage_location_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ADD CONSTRAINT `fk_mediaasset_transcode_job_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ADD CONSTRAINT `fk_mediaasset_transcode_job_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`storage_location`(`storage_location_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ADD CONSTRAINT `fk_mediaasset_transcode_job_format_specification_id` FOREIGN KEY (`format_specification_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`format_specification`(`format_specification_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ADD CONSTRAINT `fk_mediaasset_qc_inspection_format_specification_id` FOREIGN KEY (`format_specification_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`format_specification`(`format_specification_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ADD CONSTRAINT `fk_mediaasset_qc_inspection_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ADD CONSTRAINT `fk_mediaasset_asset_storage_assignment_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ADD CONSTRAINT `fk_mediaasset_asset_storage_assignment_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ADD CONSTRAINT `fk_mediaasset_asset_storage_assignment_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ADD CONSTRAINT `fk_mediaasset_asset_storage_assignment_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`storage_location`(`storage_location_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ADD CONSTRAINT `fk_mediaasset_retention_policy_supersedes_policy_retention_policy_id` FOREIGN KEY (`supersedes_policy_retention_policy_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ADD CONSTRAINT `fk_mediaasset_asset_collection_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ADD CONSTRAINT `fk_mediaasset_archive_record_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`storage_location`(`storage_location_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ADD CONSTRAINT `fk_mediaasset_archive_record_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ADD CONSTRAINT `fk_mediaasset_archive_record_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ADD CONSTRAINT `fk_mediaasset_archive_record_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`collection_membership` ADD CONSTRAINT `fk_mediaasset_collection_membership_asset_collection_id` FOREIGN KEY (`asset_collection_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`asset_collection`(`asset_collection_id`);
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`collection_membership` ADD CONSTRAINT `fk_mediaasset_collection_membership_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `media_broadcasting_ecm`.`mediaasset`.`media_asset`(`media_asset_id`);

-- ========= TAGS =========
ALTER SCHEMA `media_broadcasting_ecm`.`mediaasset` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `media_broadcasting_ecm`.`mediaasset` SET TAGS ('dbx_domain' = 'mediaasset');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` SET TAGS ('dbx_subdomain' = 'content_registry');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset ID');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Archived Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_value_regex' = '16:9|4:3|21:9|1:1|2.39:1');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = 'raw|mezzanine|proxy|archive|master');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `asset_title` SET TAGS ('dbx_business_glossary_term' = 'Asset Title');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `audio_bit_depth` SET TAGS ('dbx_business_glossary_term' = 'Audio Bit Depth');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `audio_channels` SET TAGS ('dbx_business_glossary_term' = 'Audio Channels');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `audio_sample_rate_khz` SET TAGS ('dbx_business_glossary_term' = 'Audio Sample Rate Kilohertz (kHz)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `bit_rate_mbps` SET TAGS ('dbx_business_glossary_term' = 'Bit Rate Megabits Per Second (Mbps)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_business_glossary_term' = 'Checksum Message Digest 5 (MD5)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{32}$');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `checksum_sha256` SET TAGS ('dbx_business_glossary_term' = 'Checksum Secure Hash Algorithm 256 (SHA-256)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `checksum_sha256` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{64}$');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `codec` SET TAGS ('dbx_business_glossary_term' = 'Codec');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `color_space` SET TAGS ('dbx_business_glossary_term' = 'Color Space');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `color_space` SET TAGS ('dbx_value_regex' = 'BT.709|BT.2020|DCI-P3|sRGB|Adobe RGB');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `content_classification` SET TAGS ('dbx_business_glossary_term' = 'Content Classification');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration Seconds');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `eidr` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `eidr` SET TAGS ('dbx_value_regex' = '^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z]$');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size Bytes');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `frame_rate` SET TAGS ('dbx_business_glossary_term' = 'Frame Rate');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `hdr_format` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Format');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `hdr_format` SET TAGS ('dbx_value_regex' = 'SDR|HDR10|HDR10+|Dolby Vision|HLG');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `ingest_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ingest Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `isan` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `isan` SET TAGS ('dbx_value_regex' = '^ISAN [0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]$');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `isrc` SET TAGS ('dbx_business_glossary_term' = 'International Standard Recording Code (ISRC)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `isrc` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}-[A-Z0-9]{3}-[0-9]{2}-[0-9]{5}$');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `last_accessed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Accessed Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `originating_system` SET TAGS ('dbx_business_glossary_term' = 'Originating System');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `qc_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Completed Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `qc_operator` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Operator');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `resolution` SET TAGS ('dbx_business_glossary_term' = 'Resolution');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiry Date');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `rights_restriction` SET TAGS ('dbx_business_glossary_term' = 'Rights Restriction');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `rights_restriction` SET TAGS ('dbx_value_regex' = 'unrestricted|internal_only|licensed|embargoed|restricted_territory|legal_hold');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `rights_restriction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `storage_location_uri` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Uniform Resource Identifier (URI)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `storage_location_uri` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `storage_tier` SET TAGS ('dbx_business_glossary_term' = 'Storage Tier');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `storage_tier` SET TAGS ('dbx_value_regex' = 'hot|warm|cold|deep_archive|glacier');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `timecode_start` SET TAGS ('dbx_business_glossary_term' = 'Timecode Start');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `timecode_start` SET TAGS ('dbx_value_regex' = '^([0-1][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9][:;][0-9]{2}$');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `umid` SET TAGS ('dbx_business_glossary_term' = 'Unique Material Identifier (UMID)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`media_asset` ALTER COLUMN `umid` SET TAGS ('dbx_value_regex' = '^[0-9A-F]{64}$');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` SET TAGS ('dbx_subdomain' = 'content_registry');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version ID');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `format_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Format Specification Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `rights_content_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Content Window Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `transcode_job_id` SET TAGS ('dbx_business_glossary_term' = 'Transcode Job ID');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `abr_ladder_rung` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Bitrate (ABR) Ladder Rung');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Archived Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `audio_channels` SET TAGS ('dbx_business_glossary_term' = 'Audio Channels');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `audio_codec` SET TAGS ('dbx_business_glossary_term' = 'Audio Codec');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Bitrate (Kilobits Per Second)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Checksum Algorithm');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_value_regex' = 'MD5|SHA-256|SHA-512');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `checksum_value` SET TAGS ('dbx_business_glossary_term' = 'Checksum Value');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `color_space` SET TAGS ('dbx_business_glossary_term' = 'Color Space');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `container_format` SET TAGS ('dbx_business_glossary_term' = 'Container Format');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `drm_protection` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Protection');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `drm_system` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) System');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration (Seconds)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `frame_rate` SET TAGS ('dbx_business_glossary_term' = 'Frame Rate (Frames Per Second)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `hdr_format` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Format');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `proxy_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Proxy Expiry Date');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `rendition_purpose` SET TAGS ('dbx_business_glossary_term' = 'Rendition Purpose');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `resolution_height` SET TAGS ('dbx_business_glossary_term' = 'Resolution Height (Pixels)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `resolution_width` SET TAGS ('dbx_business_glossary_term' = 'Resolution Width (Pixels)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `storage_tier` SET TAGS ('dbx_business_glossary_term' = 'Storage Tier');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `storage_tier` SET TAGS ('dbx_value_regex' = 'hot|warm|cold|archive|glacier');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `storage_uri` SET TAGS ('dbx_business_glossary_term' = 'Storage Uniform Resource Identifier (URI)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `storage_uri` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `subtitle_tracks` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Tracks');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `validated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `version_status` SET TAGS ('dbx_business_glossary_term' = 'Version Status');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `version_status` SET TAGS ('dbx_value_regex' = 'active|archived|deprecated|corrupted|pending_validation|deleted');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `video_codec` SET TAGS ('dbx_business_glossary_term' = 'Video Codec');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `watermark_payload` SET TAGS ('dbx_business_glossary_term' = 'Watermark Payload');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_version` ALTER COLUMN `watermark_payload` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` SET TAGS ('dbx_subdomain' = 'processing_operations');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_job_id` SET TAGS ('dbx_business_glossary_term' = 'Ingest Job Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Created Asset Version Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Source Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Target Storage Location Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_value_regex' = '16:9|4:3|21:9|1:1|2.39:1');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `audio_channels` SET TAGS ('dbx_business_glossary_term' = 'Audio Channel Count');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Bitrate (Kilobits Per Second)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `bytes_transferred` SET TAGS ('dbx_business_glossary_term' = 'Bytes Transferred');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Checksum Algorithm');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_value_regex' = 'MD5|SHA-256|SHA-512|CRC32');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `checksum_value` SET TAGS ('dbx_business_glossary_term' = 'Checksum Value');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `closed_caption_present` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Present Flag');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `codec` SET TAGS ('dbx_business_glossary_term' = 'Codec');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `color_space` SET TAGS ('dbx_business_glossary_term' = 'Color Space');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `color_space` SET TAGS ('dbx_value_regex' = 'BT.709|BT.2020|DCI-P3|sRGB');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Media Duration (Seconds)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `frame_rate` SET TAGS ('dbx_business_glossary_term' = 'Frame Rate (Frames Per Second)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `hdr_format` SET TAGS ('dbx_business_glossary_term' = 'High Dynamic Range (HDR) Format');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `hdr_format` SET TAGS ('dbx_value_regex' = 'SDR|HDR10|HDR10+|Dolby_Vision|HLG');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ingest End Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_source_type` SET TAGS ('dbx_business_glossary_term' = 'Ingest Source Type');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_source_type` SET TAGS ('dbx_value_regex' = 'tape|file_transfer|satellite_feed|cloud_upload|live_capture|ftp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ingest Start Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `job_number` SET TAGS ('dbx_business_glossary_term' = 'Ingest Job Number');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `job_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `job_status` SET TAGS ('dbx_business_glossary_term' = 'Ingest Job Status');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `job_status` SET TAGS ('dbx_value_regex' = 'queued|running|completed|failed|cancelled|paused');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Ingest Job Notes');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `resolution` SET TAGS ('dbx_business_glossary_term' = 'Video Resolution');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `source_format` SET TAGS ('dbx_business_glossary_term' = 'Source Media Format');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `source_location` SET TAGS ('dbx_business_glossary_term' = 'Source Location');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `target_format` SET TAGS ('dbx_business_glossary_term' = 'Target Media Format');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `timecode_start` SET TAGS ('dbx_business_glossary_term' = 'Timecode Start');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`ingest_job` ALTER COLUMN `transfer_rate_mbps` SET TAGS ('dbx_business_glossary_term' = 'Transfer Rate (Megabits Per Second)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` SET TAGS ('dbx_subdomain' = 'processing_operations');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `transcode_job_id` SET TAGS ('dbx_business_glossary_term' = 'Transcode Job Identifier');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Source Asset ID');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Output Storage Location Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `production_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Production Budget Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `format_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Target Format Specification Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Transcoding Vendor Partner Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `abr_ladder_configuration` SET TAGS ('dbx_business_glossary_term' = 'ABR (Adaptive Bitrate) Ladder Configuration');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Checksum Algorithm');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_value_regex' = 'MD5|SHA-256|SHA-512');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `codec_parameters` SET TAGS ('dbx_business_glossary_term' = 'Codec Parameters');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate (USD)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `job_number` SET TAGS ('dbx_business_glossary_term' = 'Transcode Job Number');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `job_number` SET TAGS ('dbx_value_regex' = '^TJ-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `job_priority` SET TAGS ('dbx_business_glossary_term' = 'Job Priority');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `job_priority` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low|batch');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `job_status` SET TAGS ('dbx_business_glossary_term' = 'Job Status');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `job_type` SET TAGS ('dbx_business_glossary_term' = 'Job Type');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `migration_reason` SET TAGS ('dbx_business_glossary_term' = 'Migration Reason');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `output_checksum` SET TAGS ('dbx_business_glossary_term' = 'Output Checksum');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `output_file_size_gb` SET TAGS ('dbx_business_glossary_term' = 'Output File Size (GB)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `processing_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Processing Duration (Seconds)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `processing_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processing End Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `processing_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processing Start Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `quality_validation_result` SET TAGS ('dbx_business_glossary_term' = 'Quality Validation Result');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `quality_validation_result` SET TAGS ('dbx_value_regex' = 'passed|failed|warning|not_validated');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `quality_validation_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Validation Score');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `queue_entry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Queue Entry Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `source_bitrate_mbps` SET TAGS ('dbx_business_glossary_term' = 'Source Bitrate (Mbps)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `source_codec` SET TAGS ('dbx_business_glossary_term' = 'Source Codec');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `source_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Source Duration (Seconds)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `source_file_size_gb` SET TAGS ('dbx_business_glossary_term' = 'Source File Size (GB)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `source_format` SET TAGS ('dbx_business_glossary_term' = 'Source Format');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `source_resolution` SET TAGS ('dbx_business_glossary_term' = 'Source Resolution');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`transcode_job` ALTER COLUMN `transcoding_engine` SET TAGS ('dbx_business_glossary_term' = 'Transcoding Engine');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` SET TAGS ('dbx_subdomain' = 'processing_operations');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Inspection ID');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `clearance_request_id` SET TAGS ('dbx_business_glossary_term' = 'Clearance Request Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `format_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Format Specification Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Version ID');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Qc Vendor Partner Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending_review|conditional_approval');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `aspect_ratio_compliance_result` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio Compliance Result');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `aspect_ratio_compliance_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_tested');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_codec_compliance_result` SET TAGS ('dbx_business_glossary_term' = 'Audio Codec Compliance Result');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_codec_compliance_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_tested');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_sync_offset_ms` SET TAGS ('dbx_business_glossary_term' = 'Audio Sync Offset (Milliseconds)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_sync_result` SET TAGS ('dbx_business_glossary_term' = 'Audio Sync Check Result');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_sync_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_tested');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `black_frame_count` SET TAGS ('dbx_business_glossary_term' = 'Black Frame Count');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `black_frame_detected` SET TAGS ('dbx_business_glossary_term' = 'Black Frame Detected');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `caption_validation_result` SET TAGS ('dbx_business_glossary_term' = 'Caption/Subtitle Validation Result');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `caption_validation_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_tested');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `critical_defect_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Defect Count');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `defect_summary` SET TAGS ('dbx_business_glossary_term' = 'Defect Summary');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `detected_aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Detected Aspect Ratio');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `freeze_frame_count` SET TAGS ('dbx_business_glossary_term' = 'Freeze Frame Count');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `freeze_frame_detected` SET TAGS ('dbx_business_glossary_term' = 'Freeze Frame Detected');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `hdr_format` SET TAGS ('dbx_business_glossary_term' = 'HDR Format');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `hdr_format` SET TAGS ('dbx_value_regex' = 'HDR10|HDR10+|Dolby Vision|HLG|SDR|unknown');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `hdr_metadata_validation_result` SET TAGS ('dbx_business_glossary_term' = 'HDR Metadata Validation Result');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `hdr_metadata_validation_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable|not_tested');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Inspection Duration (Seconds)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'QC Inspection Number');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_value_regex' = '^QC-[0-9]{8}-[0-9]{6}$');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed|cancelled');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `loudness_compliance_result` SET TAGS ('dbx_business_glossary_term' = 'Loudness Compliance Result');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `loudness_compliance_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_tested');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `loudness_lufs` SET TAGS ('dbx_business_glossary_term' = 'Loudness Level (LUFS)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'QC Inspection Notes');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `overall_result` SET TAGS ('dbx_business_glossary_term' = 'Overall QC Result');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `overall_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|review_required');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_tool_name` SET TAGS ('dbx_business_glossary_term' = 'QC Tool Name');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_type` SET TAGS ('dbx_business_glossary_term' = 'QC Type');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_type` SET TAGS ('dbx_value_regex' = 'automated|manual|hybrid');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `video_codec_compliance_result` SET TAGS ('dbx_business_glossary_term' = 'Video Codec Compliance Result');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`qc_inspection` ALTER COLUMN `video_codec_compliance_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_tested');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` SET TAGS ('dbx_subdomain' = 'content_registry');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Vendor Partner Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `access_protocol` SET TAGS ('dbx_business_glossary_term' = 'Storage Access Protocol');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `available_capacity_tb` SET TAGS ('dbx_business_glossary_term' = 'Available Storage Capacity in Terabytes (TB)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Checksum Algorithm');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_value_regex' = 'MD5|SHA-1|SHA-256|SHA-512|CRC32');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `checksum_validation_enabled` SET TAGS ('dbx_business_glossary_term' = 'Checksum Validation Enabled Flag');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Contact Email');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `cost_per_tb_per_month` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Terabyte (TB) Per Month');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `cost_per_tb_per_month` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|AUD|CAD');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `data_center_name` SET TAGS ('dbx_business_glossary_term' = 'Data Center Name');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `encryption_enabled` SET TAGS ('dbx_business_glossary_term' = 'Encryption Enabled Flag');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `encryption_method` SET TAGS ('dbx_business_glossary_term' = 'Encryption Method');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `last_capacity_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Capacity Check Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `legal_hold_capable` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Capable Flag');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Name');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `mount_point` SET TAGS ('dbx_business_glossary_term' = 'Storage Mount Point or Path');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Notes');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Maintenance|Decommissioned|Provisioning');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `provisioned_date` SET TAGS ('dbx_business_glossary_term' = 'Provisioned Date');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `replication_enabled` SET TAGS ('dbx_business_glossary_term' = 'Replication Enabled Flag');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `restore_time_objective_hours` SET TAGS ('dbx_business_glossary_term' = 'Restore Time Objective (RTO) in Hours');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `retention_policy_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy in Days');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'Platinum|Gold|Silver|Bronze');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `storage_tier` SET TAGS ('dbx_business_glossary_term' = 'Storage Tier Classification');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `storage_tier` SET TAGS ('dbx_value_regex' = 'Hot|Warm|Cold|Deep_Archive');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `storage_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Type');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `storage_type` SET TAGS ('dbx_value_regex' = 'SAN|NAS|LTO_Tape|Cloud_Object_Storage|CDN_Origin|Deep_Archive');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `total_capacity_tb` SET TAGS ('dbx_business_glossary_term' = 'Total Storage Capacity in Terabytes (TB)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`storage_location` ALTER COLUMN `used_capacity_tb` SET TAGS ('dbx_business_glossary_term' = 'Used Storage Capacity in Terabytes (TB)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` SET TAGS ('dbx_subdomain' = 'processing_operations');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `asset_storage_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Storage Assignment ID');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version ID');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset ID');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy ID');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `access_frequency` SET TAGS ('dbx_business_glossary_term' = 'Access Frequency Count');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|migrated|purged|archived|failed|pending');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Checksum Algorithm');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_value_regex' = 'MD5|SHA-1|SHA-256|SHA-512|CRC32');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `checksum_value` SET TAGS ('dbx_business_glossary_term' = 'Checksum Value');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `file_path` SET TAGS ('dbx_business_glossary_term' = 'File Path or Uniform Resource Identifier (URI)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `last_access_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Access Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `migration_trigger` SET TAGS ('dbx_business_glossary_term' = 'Migration Trigger');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `migration_trigger` SET TAGS ('dbx_value_regex' = 'tiering_policy|legal_hold|cost_optimization|format_migration|capacity_rebalance|manual_request');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `replication_count` SET TAGS ('dbx_business_glossary_term' = 'Replication Count');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `storage_cost_per_gb` SET TAGS ('dbx_business_glossary_term' = 'Storage Cost Per Gigabyte (GB)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `storage_cost_per_gb` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `storage_tier` SET TAGS ('dbx_business_glossary_term' = 'Storage Tier');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `storage_tier` SET TAGS ('dbx_value_regex' = 'hot|warm|cold|archive|nearline|offline');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|failed|not_verified');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` SET TAGS ('dbx_subdomain' = 'governance_standards');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy ID');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `supersedes_policy_retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Supersedes Retention Policy ID');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `applies_to_legal_hold` SET TAGS ('dbx_business_glossary_term' = 'Applies to Legal Hold Assets');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `applies_to_syndication_content` SET TAGS ('dbx_business_glossary_term' = 'Applies to Syndication Content');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `asset_class_scope` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Scope');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `audit_trail_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Required');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `checksum_verification_required` SET TAGS ('dbx_business_glossary_term' = 'Checksum Verification Required');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Effective Date');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Expiry Date');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `format_migration_allowed` SET TAGS ('dbx_business_glossary_term' = 'Format Migration Allowed');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `maximum_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Retention Period (Days)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `minimum_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Retention Period (Days)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `notification_recipients` SET TAGS ('dbx_business_glossary_term' = 'Notification Recipients');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `notification_recipients` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Code');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_description` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Description');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Name');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_owner` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Status');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|retired|under_review');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `post_retention_action` SET TAGS ('dbx_business_glossary_term' = 'Post-Retention Action');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `post_retention_action` SET TAGS ('dbx_value_regex' = 'purge|migrate_to_deep_archive|notify_rights_owner|manual_review|transfer_to_external_archive');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Policy Priority Level');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `retention_trigger` SET TAGS ('dbx_business_glossary_term' = 'Retention Trigger Event');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `retention_trigger` SET TAGS ('dbx_value_regex' = 'ingest_date|broadcast_date|contract_expiry|legal_hold|last_access_date|rights_expiry');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `storage_tier_target` SET TAGS ('dbx_business_glossary_term' = 'Storage Tier Target');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `storage_tier_target` SET TAGS ('dbx_value_regex' = 'hot|warm|cold|deep_archive|glacier');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Number');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`retention_policy` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` SET TAGS ('dbx_subdomain' = 'governance_standards');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `format_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Format Specification ID');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `audio_bit_depth` SET TAGS ('dbx_business_glossary_term' = 'Audio Bit Depth');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `audio_channel_configuration` SET TAGS ('dbx_business_glossary_term' = 'Audio Channel Configuration');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `audio_codec` SET TAGS ('dbx_business_glossary_term' = 'Audio Codec');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `audio_sample_rate_khz` SET TAGS ('dbx_business_glossary_term' = 'Audio Sample Rate (kHz)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `bit_rate_mbps` SET TAGS ('dbx_business_glossary_term' = 'Bit Rate (Mbps)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `bit_rate_mode` SET TAGS ('dbx_business_glossary_term' = 'Bit Rate Mode');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `bit_rate_mode` SET TAGS ('dbx_value_regex' = 'CBR|VBR|ABR');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Checksum Algorithm');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_value_regex' = 'MD5|SHA1|SHA256|SHA512|xxHash');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `color_space` SET TAGS ('dbx_business_glossary_term' = 'Color Space');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `container_format` SET TAGS ('dbx_business_glossary_term' = 'Container Format');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `container_format` SET TAGS ('dbx_value_regex' = 'MXF|MP4|MOV|TS|AVI|MKV');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `drm_compatibility` SET TAGS ('dbx_business_glossary_term' = 'DRM (Digital Rights Management) Compatibility');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `file_extension` SET TAGS ('dbx_business_glossary_term' = 'File Extension');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `format_category` SET TAGS ('dbx_business_glossary_term' = 'Format Category');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `format_category` SET TAGS ('dbx_value_regex' = 'ingest|mezzanine|proxy|playout|ott_delivery|archive');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `format_code` SET TAGS ('dbx_business_glossary_term' = 'Format Code');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `format_name` SET TAGS ('dbx_business_glossary_term' = 'Format Name');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `frame_rate` SET TAGS ('dbx_business_glossary_term' = 'Frame Rate');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `governing_standard` SET TAGS ('dbx_business_glossary_term' = 'Governing Standard');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `hdr_standard` SET TAGS ('dbx_business_glossary_term' = 'HDR (High Dynamic Range) Standard');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `horizontal_resolution` SET TAGS ('dbx_business_glossary_term' = 'Horizontal Resolution');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|retired|draft|under_review|approved');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `loudness_standard` SET TAGS ('dbx_business_glossary_term' = 'Loudness Standard');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `mime_type` SET TAGS ('dbx_business_glossary_term' = 'MIME Type');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `qc_profile` SET TAGS ('dbx_business_glossary_term' = 'QC (Quality Control) Profile');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `resolution_class` SET TAGS ('dbx_business_glossary_term' = 'Resolution Class');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `resolution_class` SET TAGS ('dbx_value_regex' = 'SD|HD|FHD|UHD|4K|8K');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Years)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `scan_type` SET TAGS ('dbx_business_glossary_term' = 'Scan Type');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `scan_type` SET TAGS ('dbx_value_regex' = 'progressive|interlaced');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `storage_tier` SET TAGS ('dbx_business_glossary_term' = 'Storage Tier');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `storage_tier` SET TAGS ('dbx_value_regex' = 'hot|warm|cold|archive|glacier');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `streaming_protocol` SET TAGS ('dbx_business_glossary_term' = 'Streaming Protocol');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `subtitle_format` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Format');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `target_loudness_lufs` SET TAGS ('dbx_business_glossary_term' = 'Target Loudness (LUFS)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `transcode_priority` SET TAGS ('dbx_business_glossary_term' = 'Transcode Priority');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `transcode_priority` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low|batch');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `vertical_resolution` SET TAGS ('dbx_business_glossary_term' = 'Vertical Resolution');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`format_specification` ALTER COLUMN `video_codec` SET TAGS ('dbx_business_glossary_term' = 'Video Codec');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` SET TAGS ('dbx_subdomain' = 'content_registry');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `asset_collection_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Collection Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `market_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Market Coverage Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `archive_tier` SET TAGS ('dbx_business_glossary_term' = 'Archive Storage Tier');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `archive_tier` SET TAGS ('dbx_value_regex' = 'hot|warm|cold|glacier|deep-archive');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `asset_collection_description` SET TAGS ('dbx_business_glossary_term' = 'Collection Description');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `asset_collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `asset_collection_status` SET TAGS ('dbx_value_regex' = 'draft|active|archived|deprecated|under-review|locked');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `audio_description_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Available Flag');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `bulk_operation_enabled` SET TAGS ('dbx_business_glossary_term' = 'Bulk Operation Enabled Flag');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Checksum Algorithm');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_value_regex' = 'MD5|SHA-1|SHA-256|SHA-512|xxHash');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `checksum_value` SET TAGS ('dbx_business_glossary_term' = 'Checksum Value');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `closed_caption_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Available Flag');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `collection_code` SET TAGS ('dbx_business_glossary_term' = 'Collection Code');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `collection_name` SET TAGS ('dbx_business_glossary_term' = 'Collection Name');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `collection_type` SET TAGS ('dbx_business_glossary_term' = 'Collection Type');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `created_by_user` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `curator_name` SET TAGS ('dbx_business_glossary_term' = 'Curator Name');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `curator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `distribution_window_end` SET TAGS ('dbx_business_glossary_term' = 'Distribution Window End Date');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `distribution_window_start` SET TAGS ('dbx_business_glossary_term' = 'Distribution Window Start Date');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) Identifier');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z0-9]$');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `metadata_completeness_score` SET TAGS ('dbx_business_glossary_term' = 'Metadata Completeness Score');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Collection Notes');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `packaging_format` SET TAGS ('dbx_business_glossary_term' = 'Packaging Format');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `primary_genre` SET TAGS ('dbx_business_glossary_term' = 'Primary Genre');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `qc_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Status');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `qc_status` SET TAGS ('dbx_value_regex' = 'not-started|in-progress|passed|failed|waived');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Rights Clearance Status');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `rights_clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|restricted|expired|not-required');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `syndication_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Syndication Eligible Flag');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `total_asset_count` SET TAGS ('dbx_business_glossary_term' = 'Total Asset Count');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `total_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Total Duration in Seconds');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `total_storage_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Total Storage Size in Bytes');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`asset_collection` ALTER COLUMN `creation_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Creation Date');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` SET TAGS ('dbx_subdomain' = 'processing_operations');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `archive_record_id` SET TAGS ('dbx_business_glossary_term' = 'Archive Record Identifier');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Archive Storage Location Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset ID');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `archive_cost_per_gb` SET TAGS ('dbx_business_glossary_term' = 'Archive Cost Per Gigabyte (GB)');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `archive_cost_per_gb` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `archive_date` SET TAGS ('dbx_business_glossary_term' = 'Archive Date');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `archive_destination_identifier` SET TAGS ('dbx_business_glossary_term' = 'Archive Destination Identifier');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `archive_destination_type` SET TAGS ('dbx_business_glossary_term' = 'Archive Destination Type');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `archive_destination_type` SET TAGS ('dbx_value_regex' = 'lto_tape|cloud_deep_archive|offsite_facility|nearline_storage|optical_media|hybrid_archive');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `archive_file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Archive File Size in Bytes');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `archive_format` SET TAGS ('dbx_business_glossary_term' = 'Archive Format');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `archive_job_reference` SET TAGS ('dbx_business_glossary_term' = 'Archive Job Reference Number');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `archive_notes` SET TAGS ('dbx_business_glossary_term' = 'Archive Notes');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `archive_status` SET TAGS ('dbx_business_glossary_term' = 'Archive Status');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `archive_system_name` SET TAGS ('dbx_business_glossary_term' = 'Archive System Name');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `archive_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Archive Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Checksum Algorithm');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_value_regex' = 'md5|sha256|sha512|xxhash');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `checksum_value` SET TAGS ('dbx_business_glossary_term' = 'Checksum Value');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `cloud_vault_identifier` SET TAGS ('dbx_business_glossary_term' = 'Cloud Vault Identifier');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `compression_codec` SET TAGS ('dbx_business_glossary_term' = 'Compression Codec');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `lto_tape_generation` SET TAGS ('dbx_business_glossary_term' = 'Linear Tape-Open (LTO) Tape Generation');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `oais_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Open Archival Information System (OAIS) Compliance Flag');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `offsite_facility_code` SET TAGS ('dbx_business_glossary_term' = 'Off-Site Facility Code');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `purge_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Purge Approval Status');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `purge_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not_required');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `purge_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Purge Scheduled Date');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `restore_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Restore Completion Date');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `restore_request_date` SET TAGS ('dbx_business_glossary_term' = 'Restore Request Date');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `restore_sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Restore Service Level Agreement (SLA) Tier');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `restore_sla_tier` SET TAGS ('dbx_value_regex' = 'expedited|standard|bulk|emergency');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `restore_test_date` SET TAGS ('dbx_business_glossary_term' = 'Restore Test Date');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `restore_test_result` SET TAGS ('dbx_business_glossary_term' = 'Restore Test Result');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `restore_test_result` SET TAGS ('dbx_value_regex' = 'passed|failed|partial|not_tested');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiry Date');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `storage_tier` SET TAGS ('dbx_business_glossary_term' = 'Storage Tier');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `storage_tier` SET TAGS ('dbx_value_regex' = 'hot|warm|cold|deep_archive');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`archive_record` ALTER COLUMN `tape_barcode` SET TAGS ('dbx_business_glossary_term' = 'Tape Barcode');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`collection_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`collection_membership` SET TAGS ('dbx_subdomain' = 'content_registry');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`collection_membership` SET TAGS ('dbx_association_edges' = 'mediaasset.asset_collection,mediaasset.media_asset');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`collection_membership` ALTER COLUMN `collection_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Membership Identifier');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`collection_membership` ALTER COLUMN `asset_collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Membership - Asset Collection Id');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`collection_membership` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Membership - Media Asset Id');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`collection_membership` ALTER COLUMN `added_by_user` SET TAGS ('dbx_business_glossary_term' = 'Added By User');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`collection_membership` ALTER COLUMN `added_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Added Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`collection_membership` ALTER COLUMN `inclusion_end_date` SET TAGS ('dbx_business_glossary_term' = 'Inclusion End Date');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`collection_membership` ALTER COLUMN `inclusion_start_date` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Start Date');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`collection_membership` ALTER COLUMN `inclusion_status` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Status');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`collection_membership` ALTER COLUMN `membership_role` SET TAGS ('dbx_business_glossary_term' = 'Membership Role');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`collection_membership` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Membership Notes');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`collection_membership` ALTER COLUMN `removed_by_user` SET TAGS ('dbx_business_glossary_term' = 'Removed By User');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`collection_membership` ALTER COLUMN `removed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Removed Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`mediaasset`.`collection_membership` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Sequence Number');
