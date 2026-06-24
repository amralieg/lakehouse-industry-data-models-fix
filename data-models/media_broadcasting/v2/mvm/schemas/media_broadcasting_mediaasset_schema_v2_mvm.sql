-- Schema for Domain: mediaasset | Business: Media_Broadcasting | Version: v2_mvm
-- Generated on: 2026-06-23 04:24:40

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`mediaasset` COMMENT 'Authoritative repository for all managed media files and digital objects — raw camera footage, mezzanine masters, proxy files, graphics, music beds, and archived assets. Implements MAM (Media Asset Management) via Dalet Galaxy, enforcing storage tiering, format standards (MPEG-4 ISO 14496), checksum integrity, retention policies, format migrations, and chain-of-custody audit trails for regulatory and legal hold compliance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` (
    `media_asset_id` BIGINT COMMENT 'Unique identifier for the media asset record in the MAM (Media Asset Management) system. Primary key for all digital objects managed by Dalet Galaxy.',
    `retention_policy_id` BIGINT COMMENT 'Foreign key linking to mediaasset.retention_policy. Business justification: media_asset is the core master record for every managed digital object and has a retention_expiry_date column, indicating retention policy is applied at the asset level. A direct FK from media_asset t',
    `archived_timestamp` TIMESTAMP COMMENT 'Date and time when the asset was moved to archive storage tier. Null if asset has never been archived.',
    `aspect_ratio` DECIMAL(18,2) COMMENT 'Display aspect ratio of the video content. Determines letterboxing and pillarboxing requirements for different distribution channels.',
    `asset_class` STRING COMMENT 'Classification of the asset based on its production workflow stage and quality level. Raw=unprocessed camera footage, Mezzanine=high-quality intermediate, Proxy=low-res preview, Archive=long-term preservation, Master=final approved version.. Valid values are `raw|mezzanine|proxy|archive|master`',
    `asset_title` STRING COMMENT 'Primary human-readable title or name of the media asset. Used for search, cataloging, and display in MAM interfaces.',
    `audio_bit_depth` STRING COMMENT 'Audio bit depth in bits per sample (e.g., 16, 24). Higher bit depth provides greater dynamic range and lower quantization noise.',
    `audio_channels` STRING COMMENT 'Number of discrete audio channels in the asset (e.g., 2 for stereo, 6 for 5.1 surround, 8 for 7.1, 16 for multi-language tracks). Determines audio routing and mixing requirements.',
    `audio_sample_rate_khz` DECIMAL(18,2) COMMENT 'Audio sampling frequency in kilohertz (e.g., 48.000 for broadcast, 44.100 for CD quality). Indicates audio quality and broadcast compliance.',
    `bit_rate_mbps` DECIMAL(18,2) COMMENT 'Average bit rate of the encoded media in megabits per second. Indicates quality level and bandwidth requirements for streaming and playout.',
    `checksum_md5` STRING COMMENT 'MD5 hash of the file content for integrity verification. Used to detect corruption during transfer, storage, and archival operations.. Valid values are `^[a-f0-9]{32}$`',
    `checksum_sha256` STRING COMMENT 'SHA-256 cryptographic hash for enhanced integrity verification and chain-of-custody audit trails. Required for regulatory compliance and legal hold.. Valid values are `^[a-f0-9]{64}$`',
    `codec` STRING COMMENT 'Video or audio compression codec used for encoding (e.g., H.264, H.265/HEVC, ProRes, DNxHD, AAC, PCM). Critical for quality assessment and transcoding decisions.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `duration_seconds` DECIMAL(18,2) COMMENT 'Total playback duration of the media asset in seconds with millisecond precision. Used for scheduling, ad insertion planning, and rights windowing calculations.',
    `eidr` STRING COMMENT 'Universal unique identifier for film and television assets. Enables global content identification for distribution and rights management.. Valid values are `^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z]$`',
    `file_size_bytes` BIGINT COMMENT 'Total file size in bytes. Used for storage capacity planning, transfer time estimation, and billing calculations.',
    `frame_rate` DECIMAL(18,2) COMMENT 'Video frame rate in frames per second (e.g., 23.976, 24.000, 25.000, 29.970, 30.000, 50.000, 59.940, 60.000). Critical for broadcast standards compliance and motion quality.',
    `ingest_timestamp` TIMESTAMP COMMENT 'Date and time when the asset was first ingested into the MAM system. Marks the beginning of the assets lifecycle in the enterprise repository.',
    `isan` STRING COMMENT 'ISO 15706 international identifier for audiovisual works. Used for content registration and rights management across territories.. Valid values are `^ISAN [0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]$`',
    `isrc` STRING COMMENT 'ISO 3901 unique identifier for sound recordings and music video recordings. Used for music beds, audio tracks, and music-related assets.. Valid values are `^[A-Z]{2}-[A-Z0-9]{3}-[0-9]{2}-[0-9]{5}$`',
    `last_accessed_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent access or playback of the asset. Used for storage tier optimization and usage analytics.',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicates whether the asset is under legal hold and must not be modified or deleted. Overrides retention policies until hold is released.',
    `originating_system` STRING COMMENT 'Source system or device that created or ingested the asset (e.g., camera model, editing suite, ingest station, external vendor). Provides provenance for chain-of-custody tracking.',
    `qc_completed_timestamp` TIMESTAMP COMMENT 'Date and time when quality control review was completed. Null if QC is pending or not required.',
    `qc_operator` STRING COMMENT 'User ID or name of the operator who performed quality control review. Used for accountability and audit trails.',
    `resolution` STRING COMMENT 'Video frame resolution in pixels (e.g., 1920x1080, 3840x2160, 1280x720). Indicates quality tier and delivery format compatibility.',
    `retention_expiry_date` DATE COMMENT 'Date when the asset becomes eligible for purge based on retention policy. Null indicates indefinite retention or active legal hold.',
    `rights_restriction` STRING COMMENT 'Rights and usage restrictions governing distribution and use of the asset. Enforces compliance with licensing agreements, territorial restrictions, and legal holds.. Valid values are `unrestricted|internal_only|licensed|embargoed|restricted_territory|legal_hold`',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `storage_location_uri` STRING COMMENT 'Full URI path to the physical storage location of the media file (e.g., s3://bucket/path, file://server/share/path). Used by MAM for retrieval and playout automation.',
    `timecode_start` STRING COMMENT 'SMPTE timecode of the first frame in HH:MM:SS:FF format. Essential for frame-accurate editing and playout synchronization.. Valid values are `^([0-1][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9][:;][0-9]{2}$`',
    `umid` STRING COMMENT 'SMPTE 330M globally unique identifier for the media essence. 64-character hexadecimal string providing universal identification across systems and organizations.. Valid values are `^[0-9A-F]{64}$`',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    CONSTRAINT pk_media_asset PRIMARY KEY(`media_asset_id`)
) COMMENT 'Core master record for every managed digital object in the MAM (Dalet Galaxy) — raw camera footage, mezzanine masters, graphics, music beds, and archived assets. Stores canonical asset identity, technical format metadata (codec, resolution, duration, bit-rate, aspect ratio, color space, audio channels, frame rate), asset class (raw/mezzanine/proxy/archive), storage tier (hot/warm/cold/deep-archive), lifecycle status (ingest/QC/approved/archived/purged), industry identifiers (ISAN/EIDR/ISRC/UMID), originating system reference, and content classification tags. Single source of truth for all digital object identities and their technical characteristics across the enterprise.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` (
    `asset_version_id` BIGINT COMMENT 'Unique identifier for the asset version record. Primary key.',
    `media_asset_id` BIGINT COMMENT 'Reference to the parent media asset of which this is a version or rendition.',
    `transcode_job_id` BIGINT COMMENT 'Reference to the transcode or encoding job that created this version. Links to workflow orchestration system (Dalet Galaxy) for lineage tracking and troubleshooting.',
    `abr_ladder_rung` STRING COMMENT 'Position in the ABR ladder for HLS or DASH streaming (e.g., 1 for lowest quality, 5 for highest). Enables adaptive streaming based on viewer bandwidth. Null if not part of an ABR ladder.',
    `archived_timestamp` TIMESTAMP COMMENT 'Timestamp when this version was moved to archive storage tier. Null if not yet archived. Supports retention policy enforcement and cost optimization.',
    `aspect_ratio` DECIMAL(18,2) COMMENT 'Display aspect ratio of the video (e.g., 16:9, 4:3, 21:9, 1:1). Determines how content is displayed on different screens and platforms.',
    `audio_channels` STRING COMMENT 'Number of audio channels in this version (e.g., 2 for stereo, 6 for 5.1 surround, 8 for 7.1 surround). Determines audio format and playback capability requirements.',
    `audio_codec` STRING COMMENT 'Audio compression codec used in this version (e.g., AAC, AC-3, Dolby Digital, Opus, MP3). Determines audio quality, compatibility, and decoding requirements.',
    `bitrate_kbps` STRING COMMENT 'Average bitrate of the encoded media in kilobits per second. Critical for ABR (Adaptive Bitrate Streaming) ladder configuration, CDN bandwidth planning, and QoS (Quality of Service) management.',
    `checksum_algorithm` STRING COMMENT 'Algorithm used to generate the checksum value (MD5, SHA-256, SHA-512). Identifies the hashing method for integrity verification.. Valid values are `MD5|SHA-256|SHA-512`',
    `checksum_value` DECIMAL(18,2) COMMENT 'Cryptographic hash (MD5 or SHA-256) of the file content. Ensures integrity verification, detects corruption during transfer or storage, and supports chain-of-custody audit trails for legal hold and regulatory compliance.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_by_user` STRING COMMENT 'Username or identifier of the user or system that created this version. Supports chain-of-custody audit trails for legal hold and regulatory compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this version record was first created in the MAM (Media Asset Management) system. Supports audit trails and chain-of-custody for regulatory compliance.',
    `drm_protection` BOOLEAN COMMENT 'Indicates whether this version is protected by DRM encryption (True/False). DRM systems include Widevine, PlayReady, FairPlay. Supports content security and anti-piracy.',
    `drm_system` STRING COMMENT 'DRM system used to protect this version if drm_protection is True (e.g., Widevine, PlayReady, FairPlay, AES-128). Identifies the encryption and key management system.',
    `duration_seconds` DECIMAL(18,2) COMMENT 'Total playback duration of this version in seconds. Used for scheduling, ad pod placement, and content inventory management.',
    `file_size_bytes` BIGINT COMMENT 'Size of the media file in bytes. Used for storage capacity planning, CDN (Content Delivery Network) bandwidth estimation, and archive cost calculation.',
    `frame_rate` DECIMAL(18,2) COMMENT 'Video frame rate in frames per second (e.g., 23.98, 25.00, 29.97, 59.94). Determines playback smoothness and broadcast standard compliance (NTSC, PAL, ATSC).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this version record was last modified. Tracks updates to metadata, status changes, or re-transcoding events.',
    `notes` STRING COMMENT 'Free-text notes or comments about this version. Used for QC feedback, production notes, or special handling instructions.',
    `proxy_expiry_date` DATE COMMENT 'Date when this proxy or preview version expires and should be purged from storage. Applicable only when rendition_purpose is proxy or preview. Supports storage cost optimization and compliance with retention policies.',
    `rendition_purpose` STRING COMMENT 'Business purpose or use case for this version: playout (broadcast transmission), distribution (delivery to platforms), archive (long-term preservation), preview (review/approval), proxy (low-res editing), watermark (forensic tracking), mezzanine (high-quality master), localized_dub (language variant), thumbnail (visual reference). [ENUM-REF-CANDIDATE: playout|distribution|archive|preview|proxy|watermark|mezzanine|localized_dub|thumbnail — 9 candidates stripped; promote to reference product]',
    `resolution_height` STRING COMMENT 'Vertical resolution of the video frame in pixels (e.g., 1080 for 1080p, 2160 for 4K). Used for format classification and quality assessment.',
    `resolution_width` STRING COMMENT 'Horizontal resolution of the video frame in pixels (e.g., 1920 for 1080p, 3840 for 4K). Used for format classification and quality assessment.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `storage_uri` STRING COMMENT 'Full storage path or URI where this version is physically stored (e.g., s3://bucket/path, file://nas/volume/path, https://cdn.example.com/asset). Supports multi-tier storage (hot/warm/cold/archive) and CDN distribution via Akamai.',
    `subtitle_tracks` STRING COMMENT 'Comma-separated list of ISO 639-2 language codes for embedded subtitle or closed caption tracks (e.g., eng,spa,fra). Supports accessibility compliance (COPPA, FCC) and multi-language distribution.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `validated_timestamp` TIMESTAMP COMMENT 'Timestamp when this version passed quality control (QC) validation and was approved for use. Null if validation is pending or failed.',
    `version_number` STRING COMMENT 'Sequential or semantic version identifier for this rendition (e.g., v1.0, v2.3, proxy_01). Tracks lineage from camera original through derivatives.',
    `video_codec` STRING COMMENT 'Video compression codec used in this version (e.g., H.264/AVC, H.265/HEVC, VP9, AV1, ProRes). Determines video quality, file size, and decoding requirements.',
    `watermark_payload` STRING COMMENT 'Forensic watermark identifier or payload embedded in this version for anti-piracy tracking and content protection. Applicable only when rendition_purpose is watermark. Supports DRM (Digital Rights Management) and content security.',
    CONSTRAINT pk_asset_version PRIMARY KEY(`asset_version_id`)
) COMMENT 'Tracks every distinct version, rendition, or derivative of a media asset — including mezzanine, proxy (low-res preview/edit proxy/thumbnail), HLS/DASH adaptive bitrate ladder rungs, watermarked forensic copies, and localized dubs. Each version captures version number, rendition purpose (playout/distribution/archive/preview/proxy/watermark), format specification reference, file size, checksum (MD5/SHA-256), storage URI, transcode job reference, watermark payload (if applicable), proxy expiry date (if applicable), and version status. Enables full version lineage from camera original through every derivative to final delivery rendition.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` (
    `ingest_job_id` BIGINT COMMENT 'Unique identifier for the media ingest job. Primary key for the ingest_job data product.',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: Ingest job creates a specific version (typically the mezzanine or raw master). This FK links the ingest job to the version it produced. Populated upon successful ingest completion.',
    `media_asset_id` BIGINT COMMENT 'Reference to the resulting media asset record created upon successful completion of the ingest job. Establishes chain-of-custody linkage.',
    `aspect_ratio` DECIMAL(18,2) COMMENT 'Display aspect ratio of the ingested video content. Determines presentation format and compatibility with distribution channels.',
    `audio_channels` STRING COMMENT 'Number of audio channels in the ingested media (e.g., 2 for stereo, 6 for 5.1 surround). Used for audio processing and compliance validation.',
    `bitrate_kbps` STRING COMMENT 'Average bitrate of the ingested media in kilobits per second. Indicator of media quality and storage requirements.',
    `bytes_transferred` BIGINT COMMENT 'Total number of bytes successfully transferred during the ingest operation. Used for capacity planning and performance monitoring.',
    `checksum_algorithm` STRING COMMENT 'Cryptographic hash algorithm used to verify file integrity during and after ingest. Critical for chain-of-custody and regulatory compliance.. Valid values are `MD5|SHA-256|SHA-512|CRC32`',
    `checksum_value` DECIMAL(18,2) COMMENT 'Computed checksum hash of the ingested media file. Used to verify data integrity and detect corruption or tampering.',
    `closed_caption_present` BOOLEAN COMMENT 'Indicates whether closed captions or subtitles are embedded in the ingested media. Required for FCC accessibility compliance validation.',
    `codec` STRING COMMENT 'Video or audio codec used in the ingested media (e.g., H.264, H.265/HEVC, ProRes, AAC, AC-3). Critical for playback compatibility and transcoding decisions.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ingest job record was first created in the MAM system. Audit trail entry point for chain-of-custody.',
    `duration_seconds` DECIMAL(18,2) COMMENT 'Total duration of the ingested media content in seconds. Null for non-time-based media such as still images or graphics.',
    `error_message` STRING COMMENT 'Human-readable description of any error encountered during ingest. Provides operational context for failure analysis and remediation.',
    `frame_rate` DECIMAL(18,2) COMMENT 'Frame rate of the ingested video content in frames per second (e.g., 23.976, 25, 29.97, 50, 59.94). Critical for format compatibility and playout.',
    `ingest_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the ingest job completed or terminated. Null for jobs still in progress.',
    `ingest_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the ingest job began processing. Represents the actual start of media transfer, not the queued time.',
    `job_number` STRING COMMENT 'Human-readable business identifier for the ingest job, typically formatted as prefix-date-sequence (e.g., ING-20240115-0042). Used for operational tracking and reference.. Valid values are `^[A-Z]{3}-[0-9]{8}-[0-9]{4}$`',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicates whether the ingested media is subject to legal hold and must be preserved for litigation or regulatory investigation. Prevents deletion.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the ingest job record was last modified. Tracks updates to job status, metadata corrections, or error resolution.',
    `notes` STRING COMMENT 'Free-text field for operator notes, special handling instructions, or contextual information about the ingest job. Used for operational communication.',
    `resolution` STRING COMMENT 'Spatial resolution of the ingested video content (e.g., 1920x1080, 3840x2160, 1280x720). Used for quality assessment and distribution planning.',
    `source_location` STRING COMMENT 'Physical or logical location of the source media. May be a tape ID, file path, URL, satellite transponder identifier, or cloud storage bucket path.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `target_storage_location` STRING COMMENT 'Destination storage path or tier where the ingested media asset will be stored. May reference nearline, online, or archive storage systems.',
    `timecode_start` STRING COMMENT 'Starting timecode of the ingested media in SMPTE format (HH:MM:SS:FF). Used for frame-accurate editing and synchronization.',
    `transfer_rate_mbps` DECIMAL(18,2) COMMENT 'Average data transfer rate achieved during ingest, measured in megabits per second. Key performance indicator for ingest infrastructure.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    CONSTRAINT pk_ingest_job PRIMARY KEY(`ingest_job_id`)
) COMMENT 'Transactional record of every media ingest operation executed in Dalet Galaxy — capturing ingest source (tape, file transfer, satellite feed, cloud upload), ingest start/end timestamps, operator identity, source format, target storage location, ingest status (queued/running/completed/failed), bytes transferred, transfer rate, and any error codes encountered. Provides the chain-of-custody entry point for all assets entering the MAM. Links to the resulting media_asset record upon successful completion.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` (
    `transcode_job_id` BIGINT COMMENT 'Primary key for transcode_job',
    `media_asset_id` BIGINT COMMENT 'Reference to the source media asset being transcoded.',
    `abr_ladder_configuration` STRING COMMENT 'Configuration specification for ABR ladder generation, defining the set of bitrate/resolution variants to be created for adaptive streaming (e.g., 240p@400kbps, 360p@800kbps, 480p@1.2Mbps, 720p@2.5Mbps, 1080p@5Mbps). Applicable when job_type is abr_ladder_generation.',
    `checksum_algorithm` STRING COMMENT 'Algorithm used to generate the output checksum.. Valid values are `MD5|SHA-256|SHA-512`',
    `codec_parameters` STRING COMMENT 'Detailed codec encoding parameters including profile, level, GOP structure, B-frames, reference frames, and other encoder-specific settings (e.g., x264 preset=medium, crf=23, profile=high, level=4.1).',
    `cost_estimate_usd` DECIMAL(18,2) COMMENT 'Estimated processing cost in US dollars for this transcode job, based on compute time, storage, and resource utilization. Used for chargeback and budget tracking.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `error_message` STRING COMMENT 'Human-readable error message describing the failure reason if job_status is failed.',
    `job_number` STRING COMMENT 'Human-readable business identifier for the transcode job, used for tracking and reference across systems.. Valid values are `^TJ-[0-9]{8}-[A-Z0-9]{6}$`',
    `job_priority` STRING COMMENT 'Processing priority level for the transcode job, determining queue position and resource allocation. Critical jobs are processed immediately, batch jobs during off-peak hours.. Valid values are `critical|high|normal|low|batch`',
    `migration_reason` STRING COMMENT 'Business justification for format migration jobs. Applicable only when job_type is format_migration, tape_digitization, or analogue_to_digital. Captures whether the conversion is driven by format obsolescence (e.g., MPEG-2 to H.265), storage optimization, distribution requirements, or regulatory compliance. [ENUM-REF-CANDIDATE: format_obsolescence|storage_optimization|distribution_requirement|quality_enhancement|compliance_mandate|archive_preservation|not_applicable — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text field for operational notes, special instructions, or contextual information about the transcode job.',
    `output_checksum` STRING COMMENT 'Cryptographic checksum (MD5, SHA-256, or SHA-512) of the output file for integrity verification and chain-of-custody audit trails.',
    `output_file_size_gb` DECIMAL(18,2) COMMENT 'Total file size of the transcoded output in gigabytes. Populated upon job completion.',
    `output_storage_uri` STRING COMMENT 'Storage location URI for the transcoded output file(s), including protocol, bucket/path, and filename pattern (e.g., s3://media-archive/transcoded/2024/01/asset_12345_1080p.mp4).',
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
    `source_resolution` STRING COMMENT 'Video resolution of the source asset in pixels (e.g., 1920x1080, 3840x2160, 1280x720).',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `transcoding_engine` STRING COMMENT 'Name and version of the transcoding engine or software used to perform the conversion (e.g., FFmpeg 5.1.2, AWS Elemental MediaConvert, Dalet Brio).',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    CONSTRAINT pk_transcode_job PRIMARY KEY(`transcode_job_id`)
) COMMENT 'Transactional record of every format conversion operation performed on a media asset — including standard transcodes (ABR ladder generation, proxy creation, delivery package preparation) and format migrations (obsolescence-driven conversions such as MPEG-2 to H.265, tape digitisation, analogue-to-digital). Captures source asset version, target format specification, codec parameters, bitrate ladder configuration, output storage URI, job type (transcode/migration), migration reason (if applicable: format obsolescence/storage optimisation/distribution requirement), job priority, queue entry time, processing start/end timestamps, transcoding engine used, output file size, checksum, quality validation result, and job status (queued/processing/completed/failed/retrying). Single source of truth for all format conversion operations in the MAM.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` (
    `qc_inspection_id` BIGINT COMMENT 'Unique identifier for the quality control inspection record. Primary key.',
    `asset_version_id` BIGINT COMMENT 'Reference to the specific version of the media asset that underwent this quality control inspection.',
    `ai_confidence_score` DOUBLE COMMENT 'Confidence score from AI-driven QC analysis (0.0-1.0)',
    `ai_qc_engine_version` STRING COMMENT 'Version identifier of the AI/ML engine used for automated QC inspection',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the asset was approved for playout or distribution following QC inspection. Null if not yet approved.',
    `aspect_ratio_compliance_result` STRING COMMENT 'Result of aspect ratio compliance check. Verifies that video aspect ratio (e.g., 16:9, 4:3, 21:9) matches expected format and Active Format Description (AFD) metadata is correct.. Valid values are `pass|fail|not_tested`',
    `audio_codec_compliance_result` STRING COMMENT 'Result of audio codec format compliance check. Verifies that audio encoding conforms to expected codec standard (e.g., AAC, Dolby Digital, Dolby Atmos, MPEG-1 Layer II).. Valid values are `pass|fail|not_tested`',
    `audio_sync_offset_ms` STRING COMMENT 'Measured audio-to-video synchronization offset in milliseconds. Positive values indicate audio leads video; negative values indicate audio lags video. Null if sync check not performed.',
    `audio_sync_result` STRING COMMENT 'Result of audio-to-video synchronization check. Detects lip-sync errors or audio drift.. Valid values are `pass|fail|not_tested`',
    `black_frame_count` STRING COMMENT 'Total number of black frames detected in the media asset. Zero if none detected.',
    `black_frame_detected` BOOLEAN COMMENT 'Indicates whether unintended black frames (video signal dropout or encoding error) were detected during inspection.',
    `caption_validation_result` STRING COMMENT 'Result of closed caption (CEA-608, CEA-708) or subtitle validation check. Verifies presence, format compliance, and synchronization of captions.. Valid values are `pass|fail|not_tested`',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this QC inspection record was first created in the system. Audit trail field.',
    `critical_defect_count` STRING COMMENT 'Number of critical-severity defects that block asset approval for playout or distribution. Critical defects require remediation.',
    `defect_count` STRING COMMENT 'Total number of quality defects detected during inspection. Zero indicates no defects found.',
    `defect_summary` STRING COMMENT 'Structured JSON or delimited text summary of all detected defects with timecode references, severity levels, and defect type codes. Detailed defect records may be stored in a separate qc_defect child table.',
    `detected_aspect_ratio` DECIMAL(18,2) COMMENT 'Actual aspect ratio detected in the video stream (e.g., 16:9, 4:3, 1.85:1, 2.39:1). Null if aspect ratio check not performed.',
    `freeze_frame_count` STRING COMMENT 'Total number of freeze frame incidents detected in the media asset. Zero if none detected.',
    `freeze_frame_detected` BOOLEAN COMMENT 'Indicates whether freeze frames (static video for extended duration) were detected during inspection.',
    `hdr_metadata_validation_result` STRING COMMENT 'Result of High Dynamic Range (HDR) metadata validation check. Verifies presence and correctness of HDR10, HDR10+, Dolby Vision, or HLG metadata. Not applicable for Standard Dynamic Range (SDR) content.. Valid values are `pass|fail|not_applicable|not_tested`',
    `inspection_duration_seconds` STRING COMMENT 'Total elapsed time in seconds required to complete the quality control inspection process.',
    `inspection_number` STRING COMMENT 'Human-readable business identifier for the inspection record, formatted as QC-YYYYMMDD-NNNNNN.. Valid values are `^QC-[0-9]{8}-[0-9]{6}$`',
    `inspection_timestamp` TIMESTAMP COMMENT 'Date and time when the quality control inspection was performed or completed. Primary business event timestamp.',
    `loudness_compliance_result` STRING COMMENT 'Result of audio loudness compliance check against regulatory standards (EBU R128 for Europe, ATSC A/85 for North America, ITU-R BS.1770 globally).. Valid values are `pass|fail|not_tested`',
    `loudness_lufs` DECIMAL(18,2) COMMENT 'Measured integrated loudness level in LUFS (Loudness Units relative to Full Scale) or LKFS. Typical broadcast target is -23 LUFS (EBU R128) or -24 LKFS (ATSC A/85).',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this QC inspection record was last updated. Audit trail field.',
    `notes` STRING COMMENT 'Free-text notes or comments from the QC operator or automated tool regarding the inspection, including observations, context, or recommendations.',
    `overall_result` STRING COMMENT 'Final pass/fail determination for the quality control inspection. Conditional pass indicates minor issues that do not block playout. Review required indicates human escalation needed.. Valid values are `pass|fail|conditional_pass|review_required`',
    `qc_tool_name` STRING COMMENT 'Name and version of the automated quality control software or tool used for inspection (e.g., Baton, Interra, Venera, Dalet QC Module).',
    `rejection_reason` STRING COMMENT 'Detailed explanation of why the asset was rejected, including references to specific defects or compliance failures. Null if asset was approved.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `video_codec_compliance_result` STRING COMMENT 'Result of video codec format compliance check. Verifies that video encoding conforms to expected codec standard (e.g., H.264/AVC, H.265/HEVC, MPEG-2, AV1).. Valid values are `pass|fail|not_tested`',
    CONSTRAINT pk_qc_inspection PRIMARY KEY(`qc_inspection_id`)
) COMMENT 'Records the quality control inspection result for each media asset version — capturing QC type (automated/manual/hybrid), inspection timestamp, operator or automated QC tool identity, pass/fail status, loudness compliance result (EBU R128 / ATSC A/85), black frame detection, freeze frame detection, audio sync check, caption/subtitle validation, aspect ratio compliance, HDR metadata validation, and a structured list of detected defects with timecode references. Mandatory gate before asset is approved for playout or distribution.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` (
    `storage_location_id` BIGINT COMMENT 'Unique identifier for the storage location within the Media Asset Management (MAM) infrastructure. Primary key.',
    `access_protocol` STRING COMMENT 'Network protocol or interface used to access the storage location (NFS = Network File System, SMB = Server Message Block, S3 = Amazon S3 API, SFTP = Secure File Transfer Protocol, iSCSI = Internet Small Computer Systems Interface, Fibre_Channel = FC SAN protocol). [ENUM-REF-CANDIDATE: NFS|SMB|S3|SFTP|iSCSI|Fibre_Channel|HTTP|HTTPS — 8 candidates stripped; promote to reference product]',
    `available_capacity_tb` DECIMAL(18,2) COMMENT 'Remaining available storage capacity (total minus used), measured in terabytes (TB). Drives automated alerts and provisioning workflows.',
    `checksum_algorithm` STRING COMMENT 'Hashing algorithm used for checksum validation (MD5 = Message Digest 5, SHA = Secure Hash Algorithm, CRC32 = Cyclic Redundancy Check). Null if checksum validation is not enabled.. Valid values are `MD5|SHA-1|SHA-256|SHA-512|CRC32`',
    `checksum_validation_enabled` BOOLEAN COMMENT 'Indicates whether automated checksum integrity validation is performed on assets stored at this location (True = enabled, False = disabled). Critical for ensuring asset integrity and detecting corruption.',
    `contact_email` STRING COMMENT 'Primary email address for the technical or operational contact responsible for this storage location. Used for alerts, maintenance coordination, and incident response.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `cost_per_tb_per_month` DECIMAL(18,2) COMMENT 'Monthly cost per terabyte of storage at this location, used for cost allocation and financial reporting. Includes infrastructure, licensing, and operational costs.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage location record was first created in the MAM system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `data_center_name` STRING COMMENT 'Name or identifier of the physical data center or facility housing the storage infrastructure (e.g., NYC-DC1, AWS-US-East-1, Azure-WestEurope).',
    `decommission_date` DATE COMMENT 'Date when the storage location was or is planned to be decommissioned and removed from service. Null if still active. Format: yyyy-MM-dd.',
    `encryption_enabled` BOOLEAN COMMENT 'Indicates whether data-at-rest encryption is enabled for this storage location (True = encrypted, False = not encrypted). Critical for compliance with data protection regulations.',
    `geographic_region` STRING COMMENT 'Geographic region or data center location where the storage is physically or logically hosted (e.g., US-East, EU-West, APAC-Singapore, On-Premise-NYC).',
    `last_capacity_check_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent capacity measurement or audit for this storage location. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage location record was last updated or modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `legal_hold_capable` BOOLEAN COMMENT 'Indicates whether this storage location supports legal hold functionality to prevent deletion or modification of assets under litigation or regulatory investigation (True = capable, False = not capable).',
    `location_name` STRING COMMENT 'Human-readable name or label for the storage location (e.g., Production SAN Array 01, Archive LTO Tape Library, AWS S3 US-East Bucket).',
    `mount_point` STRING COMMENT 'File system mount point, UNC path, or object storage URI used by MAM systems to access the location (e.g., /mnt/production_san, nas01media, s3://bucket-name/prefix).',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, configuration details, or special instructions related to this storage location.',
    `operational_status` STRING COMMENT 'Current operational state of the storage location (Active = in production use, Inactive = temporarily offline, Maintenance = undergoing service, Decommissioned = retired, Provisioning = being set up).. Valid values are `Active|Inactive|Maintenance|Decommissioned|Provisioning`',
    `provisioned_date` DATE COMMENT 'Date when the storage location was initially provisioned and made available for use. Format: yyyy-MM-dd.',
    `replication_enabled` BOOLEAN COMMENT 'Indicates whether this storage location is replicated to another location for redundancy and disaster recovery (True = replicated, False = not replicated).',
    `restore_time_objective_hours` DECIMAL(18,2) COMMENT 'Maximum acceptable time to restore or retrieve assets from this storage location, measured in hours. Critical for disaster recovery and operational planning.',
    `retention_policy_days` STRING COMMENT 'Default retention period in days for assets stored at this location, after which assets may be migrated or purged per policy. Null if no default retention applies.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `storage_vendor` STRING COMMENT 'Name of the storage hardware or cloud service provider (e.g., Dell EMC, NetApp, AWS, Azure, Google Cloud, IBM Spectrum Archive).',
    `total_capacity_tb` DECIMAL(18,2) COMMENT 'Total storage capacity of the location measured in terabytes (TB). Used for capacity planning and allocation reporting.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `used_capacity_tb` DECIMAL(18,2) COMMENT 'Current amount of storage capacity consumed or allocated, measured in terabytes (TB). Updated periodically to reflect actual usage.',
    CONSTRAINT pk_storage_location PRIMARY KEY(`storage_location_id`)
) COMMENT 'Master reference for all physical and logical storage locations in the MAM infrastructure — on-premise SAN/NAS arrays, nearline LTO tape libraries, cloud object storage (S3, Azure Blob, GCS), CDN origin stores, and deep-archive vaults. Captures location name, storage type, tier classification (hot/warm/cold/deep-archive), geographic region/data centre, total capacity, used capacity, storage vendor, access protocol (NFS/SMB/S3/SFTP), SLA tier (restore time objective), and operational status. Drives automated storage tiering policy enforcement, capacity planning, and cost allocation reporting.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` (
    `asset_storage_assignment_id` BIGINT COMMENT 'Unique identifier for the asset storage assignment record. Primary key for tracking storage placement history.',
    `asset_version_id` BIGINT COMMENT 'Reference to the specific version of the media asset being stored. Tracks mezzanine, proxy, master, or archived versions.',
    `media_asset_id` BIGINT COMMENT 'Reference to the media asset that is being stored. Links to the master media asset record in the MAM (Media Asset Management) system.',
    `retention_policy_id` BIGINT COMMENT 'Reference to the retention policy governing this storage assignment. Determines how long the file must be retained and when it can be purged.',
    `storage_location_id` BIGINT COMMENT 'Reference to the physical or logical storage location where the asset file resides. Links to storage infrastructure registry.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: Data sovereignty compliance (GDPR, licensing geo-restrictions) requires linking storage assignments to the structured rights territory record. Broadcasting operations must verify that content stored i',
    `access_frequency` STRING COMMENT 'Number of times this file has been accessed since assignment to this storage location. Used to inform tiering and migration decisions.',
    `assignment_end_date` DATE COMMENT 'Date when the asset file was migrated, purged, or removed from this storage location. Null if still active at this location.',
    `assignment_end_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the asset file was migrated, purged, or removed from this storage location. Null if still active.',
    `assignment_start_date` DATE COMMENT 'Date when the asset file was placed at this storage location. Marks the beginning of the storage assignment period.',
    `assignment_start_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the asset file was placed at this storage location. Provides exact time for chain-of-custody audit trails.',
    `checksum_algorithm` STRING COMMENT 'Algorithm used to generate the checksum value. Common algorithms include MD5, SHA-1, SHA-256, SHA-512, and CRC32.. Valid values are `MD5|SHA-1|SHA-256|SHA-512|CRC32`',
    `checksum_value` DECIMAL(18,2) COMMENT 'Cryptographic hash or checksum of the file at placement time. Ensures file integrity verification and detects corruption or tampering.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage assignment record was first created in the system. Used for audit trails and data lineage.',
    `file_path` STRING COMMENT 'Complete file system path or URI where the asset file is physically stored. Enables restore path resolution and file retrieval.',
    `file_size_bytes` BIGINT COMMENT 'Size of the asset file in bytes at the time of storage assignment. Used for capacity planning and storage cost allocation.',
    `last_access_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent access to this file at this storage location. Used for tiering policy enforcement and usage analytics.',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicates whether this storage assignment is subject to a legal hold. When true, the file cannot be deleted or modified regardless of retention policy.',
    `migration_trigger` STRING COMMENT 'Reason why the asset was moved to or from this storage location. Captures business or technical driver for storage placement decisions.. Valid values are `tiering_policy|legal_hold|cost_optimization|format_migration|capacity_rebalance|manual_request`',
    `notes` STRING COMMENT 'Free-text notes or comments about this storage assignment. Captures context, special handling instructions, or migration rationale.',
    `replication_count` STRING COMMENT 'Number of redundant copies of this file maintained at this storage location. Used for disaster recovery and high availability planning.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `storage_cost_per_gb` DECIMAL(18,2) COMMENT 'Cost per gigabyte for this storage tier at the time of assignment. Used for storage cost allocation and financial reporting.',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage assignment record was last modified. Used for change tracking and audit trails.',
    `verification_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent integrity verification check. Used to track compliance with periodic verification policies.',
    CONSTRAINT pk_asset_storage_assignment PRIMARY KEY(`asset_storage_assignment_id`)
) COMMENT 'Tracks the complete storage placement history for every media asset version — recording which file resides at which storage location, when it was placed there, and why it moved. Captures storage location reference, file path/URI, storage tier at time of assignment, assignment start date, end date (if migrated or purged), file size, checksum at placement, migration trigger (tiering policy/legal hold/cost optimisation/format migration/capacity rebalance), and verification status. Provides the authoritative chain-of-custody for physical file placement, drives storage capacity reporting, enables restore path resolution, and supports legal discovery by proving where a file was at any point in time.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` (
    `retention_policy_id` BIGINT COMMENT 'Unique identifier for the retention policy record. Primary key.',
    `supersedes_policy_retention_policy_id` BIGINT COMMENT 'Reference to the previous retention policy that this policy replaces. Null if this is the first version. Supports policy lineage and historical analysis.',
    `applies_to_legal_hold` BOOLEAN COMMENT 'Indicates whether this retention policy applies to assets under legal hold. If false, legal hold assets are exempt from automated lifecycle actions governed by this policy.',
    `applies_to_syndication_content` BOOLEAN COMMENT 'Indicates whether this retention policy applies to syndicated content (content resold to multiple outlets). Syndication agreements may impose distinct retention obligations.',
    `asset_class_scope` STRING COMMENT 'The category of media assets to which this retention policy applies. Aligns with MAM (Media Asset Management) asset classification in Dalet Galaxy. [ENUM-REF-CANDIDATE: raw|mezzanine|proxy|archive|master|graphics|audio|metadata — 8 candidates stripped; promote to reference product]',
    `audit_trail_required` BOOLEAN COMMENT 'Indicates whether a full chain-of-custody audit trail must be maintained for assets governed by this policy. Critical for regulatory compliance and legal hold scenarios.',
    `checksum_verification_required` BOOLEAN COMMENT 'Indicates whether checksum integrity verification is mandatory before executing post-retention actions. Ensures asset integrity throughout the retention lifecycle.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
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
    `policy_description` STRING COMMENT 'Detailed business description of the retention policy, including rationale, scope, and any special handling instructions.',
    `policy_name` STRING COMMENT 'Business-friendly name of the retention policy (e.g., Broadcast Master Archive Policy, Raw Footage 90-Day Purge).',
    `policy_owner` STRING COMMENT 'The business role, department, or individual responsible for defining and maintaining this retention policy (e.g., Legal & Compliance, Media Operations Director, Chief Content Officer).',
    `post_retention_action` STRING COMMENT 'The action to be taken when the retention period expires. Drives automated lifecycle workflows in MAM (Media Asset Management) systems.. Valid values are `purge|migrate_to_deep_archive|notify_rights_owner|manual_review|transfer_to_external_archive`',
    `regulatory_basis` STRING COMMENT 'The regulatory framework, statute, or compliance requirement that mandates or informs this retention policy (e.g., FCC 47 CFR 73.1840, Ofcom Section 11, GDPR Article 5, SOX Section 802, Legal Hold Case #12345).',
    `retention_trigger` STRING COMMENT 'The business event that starts the retention clock for this policy (e.g., when the asset was ingested, when it was first broadcast, when the licensing contract expires, or when a legal hold is placed).. Valid values are `ingest_date|broadcast_date|contract_expiry|legal_hold|last_access_date|rights_expiry`',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `storage_tier_target` STRING COMMENT 'The target storage tier for assets governed by this policy after the retention period. Aligns with tiered storage strategies in MAM (Media Asset Management) and CDN (Content Delivery Network) architectures.. Valid values are `hot|warm|cold|deep_archive|glacier`',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    `version_number` STRING COMMENT 'Sequential version number of this retention policy. Incremented each time the policy is revised. Supports policy change tracking and audit compliance.',
    `created_by` STRING COMMENT 'The user ID or system identifier that created this retention policy record.',
    CONSTRAINT pk_retention_policy PRIMARY KEY(`retention_policy_id`)
) COMMENT 'Defines the business retention rules applied to media assets — capturing policy name, asset class scope (raw/mezzanine/proxy/archive), minimum retention period, maximum retention period, retention trigger (ingest date / broadcast date / contract expiry / legal hold), post-retention action (purge/migrate-to-deep-archive/notify-rights-owner), regulatory basis (FCC, Ofcom, GDPR, SOX, legal hold), policy owner, effective date, and expiry date. Drives automated lifecycle management and ensures regulatory compliance for asset archival and deletion.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` (
    `asset_lifecycle_event_id` BIGINT COMMENT 'Unique identifier for the asset lifecycle event record. Primary key. Inferred role: EVENT_LOG. This entity represents an immutable audit log of state transitions for media assets, capturing the complete chain-of-custody trail required for regulatory, legal, and rights compliance in media asset management systems.',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: Lifecycle events (QC passed, transcoded, archived, migrated) apply to specific versions, not just the asset concept. This FK allows tracking version-specific state transitions. Nullable for asset-leve',
    `ingest_job_id` BIGINT COMMENT 'Foreign key linking to mediaasset.ingest_job. Business justification: asset_lifecycle_event records every significant lifecycle state transition including ingest events. A direct FK to ingest_job provides chain-of-custody audit traceability — when an ingest lifecycle ev',
    `media_asset_id` BIGINT COMMENT 'Reference to the media asset that experienced this lifecycle event. Links to the master media asset record in the MAM (Media Asset Management) system. This is the EVENT_SOURCE_REFERENCE required for EVENT_LOG role.',
    `qc_inspection_id` BIGINT COMMENT 'Foreign key linking to mediaasset.qc_inspection. Business justification: asset_lifecycle_event records QC pass/fail lifecycle events and contains qc_defect_count and qc_score as point-in-time snapshot values. A direct FK to qc_inspection allows joining to the full inspecti',
    `retention_policy_id` BIGINT COMMENT 'Reference to the data retention policy that governs this assets lifecycle. Links to the retention policy master table that defines minimum and maximum retention periods, purge rules, and regulatory compliance requirements.',
    `transcode_job_id` BIGINT COMMENT 'Foreign key linking to mediaasset.transcode_job. Business justification: asset_lifecycle_event records format migration and transcode lifecycle events. A direct FK to transcode_job provides full audit traceability for format conversion events — when a transcode/migration l',
    `approval_authority` STRING COMMENT 'The name or identifier of the person or role that provided approval for this lifecycle event, applicable for approval, publish, and legal_hold_released events. Used for accountability and compliance documentation.',
    `audit_trail_reference` STRING COMMENT 'External reference identifier linking this lifecycle event to broader audit trail systems, compliance documentation, or regulatory filing records. Used to connect MAM (Media Asset Management) events to enterprise audit and compliance frameworks.',
    `checksum_after` STRING COMMENT 'The cryptographic checksum (MD5, SHA-256, or other hash) of the media file after this event. Used to verify file integrity and detect unauthorized modifications. Critical for chain-of-custody audit trail.',
    `checksum_before` STRING COMMENT 'The cryptographic checksum (MD5, SHA-256, or other hash) of the media file before this event. Used to verify file integrity and detect unauthorized modifications. Critical for chain-of-custody audit trail.',
    `compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether this lifecycle event was executed in compliance with applicable regulatory, legal, and internal policy requirements. True indicates compliant execution; False indicates a compliance violation or exception that requires review.',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage column: row creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this lifecycle event record was created in the data warehouse. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Distinct from event_timestamp which captures the business event time. Used for data lineage and ETL (Extract Transform Load) audit purposes.',
    `duration_seconds` DECIMAL(18,2) COMMENT 'The playback duration of the media asset in seconds at the time of this lifecycle event. Used to verify content integrity after format migrations and to track asset characteristics over time.',
    `error_message` STRING COMMENT 'Human-readable error message or exception description if this lifecycle event encountered an error or failure. Provides detailed context for troubleshooting and incident resolution.',
    `event_duration_milliseconds` BIGINT COMMENT 'The elapsed time in milliseconds that this lifecycle event took to complete. Used for performance monitoring, SLA (Service Level Agreement) tracking, and workflow optimization. Applicable for transcode, migration, and ingest events.',
    `event_reason` STRING COMMENT 'Free-text explanation or justification for why this lifecycle event occurred. May include business context, regulatory requirement, editorial decision rationale, or technical reason. Critical for audit trail and compliance documentation.',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when the lifecycle event occurred in the media asset management workflow. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. This is the EVENT_TIMESTAMP required for EVENT_LOG role.',
    `file_size_bytes` BIGINT COMMENT 'The size of the media file in bytes at the time of this lifecycle event. Used to track storage consumption, validate successful transfers, and monitor format migration efficiency.',
    `metadata_version` STRING COMMENT 'Version number of the assets descriptive metadata at the time of this lifecycle event. Incremented with each metadata_update event. Used to track metadata evolution and support rollback scenarios.',
    `operator_identity` STRING COMMENT 'The identity of the human operator or automated system that triggered or executed this lifecycle event. May be a user ID, system account name, or automated workflow identifier. Used for accountability and audit trail purposes.',
    `qc_defect_count` STRING COMMENT 'Number of quality defects identified during quality control inspection, applicable for qc_fail events. Defects may include video artifacts, audio issues, metadata errors, or format compliance violations.',
    `qc_score` DECIMAL(18,2) COMMENT 'Numeric quality control score assigned during qc_pass or qc_fail events. Scale typically 0-100, representing technical quality assessment of video, audio, and metadata completeness. Used to track asset quality metrics over time.',
    `source_system_code` STRING COMMENT 'Medallion lineage column: natural id in source system',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage column: row last update timestamp',
    CONSTRAINT pk_asset_lifecycle_event PRIMARY KEY(`asset_lifecycle_event_id`)
) COMMENT 'Immutable audit log of every significant lifecycle state transition for a media asset — ingest, QC pass, QC fail, approval, publish, archive, storage tier migration, legal hold applied, legal hold released, format migration, and purge. Each record captures the event type, previous state, new state, event timestamp, operator or automated system identity, and a free-text reason. Provides the complete chain-of-custody audit trail required for regulatory, legal, and rights compliance.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ADD CONSTRAINT `fk_mediaasset_media_asset_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ADD CONSTRAINT `fk_mediaasset_asset_version_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ADD CONSTRAINT `fk_mediaasset_asset_version_transcode_job_id` FOREIGN KEY (`transcode_job_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job`(`transcode_job_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ADD CONSTRAINT `fk_mediaasset_ingest_job_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ADD CONSTRAINT `fk_mediaasset_ingest_job_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ADD CONSTRAINT `fk_mediaasset_transcode_job_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ADD CONSTRAINT `fk_mediaasset_qc_inspection_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ADD CONSTRAINT `fk_mediaasset_asset_storage_assignment_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ADD CONSTRAINT `fk_mediaasset_asset_storage_assignment_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ADD CONSTRAINT `fk_mediaasset_asset_storage_assignment_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ADD CONSTRAINT `fk_mediaasset_asset_storage_assignment_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ADD CONSTRAINT `fk_mediaasset_retention_policy_supersedes_policy_retention_policy_id` FOREIGN KEY (`supersedes_policy_retention_policy_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ADD CONSTRAINT `fk_mediaasset_asset_lifecycle_event_asset_version_id` FOREIGN KEY (`asset_version_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version`(`asset_version_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ADD CONSTRAINT `fk_mediaasset_asset_lifecycle_event_ingest_job_id` FOREIGN KEY (`ingest_job_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job`(`ingest_job_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ADD CONSTRAINT `fk_mediaasset_asset_lifecycle_event_media_asset_id` FOREIGN KEY (`media_asset_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`(`media_asset_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ADD CONSTRAINT `fk_mediaasset_asset_lifecycle_event_qc_inspection_id` FOREIGN KEY (`qc_inspection_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection`(`qc_inspection_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ADD CONSTRAINT `fk_mediaasset_asset_lifecycle_event_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ADD CONSTRAINT `fk_mediaasset_asset_lifecycle_event_transcode_job_id` FOREIGN KEY (`transcode_job_id`) REFERENCES `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job`(`transcode_job_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`mediaasset` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`mediaasset` SET TAGS ('dbx_domain' = 'mediaasset');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the media asset record in the MAM (Media Asset Management) system. Primary key for all digital objects managed by Dalet Galaxy.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Archived Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when the asset was moved to archive storage tier. Null if asset has never been archived.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_column_comment' = 'Display aspect ratio of the video content. Determines letterboxing and pillarboxing requirements for different distribution channels.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = 'raw|mezzanine|proxy|archive|master');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_column_comment' = 'Classification of the asset based on its production workflow stage and quality level. Raw=unprocessed camera footage');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_Mezzanine' = 'high-quality intermediate');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_Proxy' = 'low-res preview');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_Archive' = 'long-term preservation');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_Master' = 'final approved version.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_ENUM_REF_CANDIDATE' = 'promote-to-reference-product');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `asset_title` SET TAGS ('dbx_business_glossary_term' = 'Asset Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `asset_title` SET TAGS ('dbx_column_comment' = 'Primary human-readable title or name of the media asset. Used for search');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `asset_title` SET TAGS ('dbx_cataloging' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `asset_title` SET TAGS ('dbx_and_display_in_MAM_interfaces' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `audio_bit_depth` SET TAGS ('dbx_business_glossary_term' = 'Audio Bit Depth');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `audio_bit_depth` SET TAGS ('dbx_column_comment' = 'Audio bit depth in bits per sample (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `audio_bit_depth` SET TAGS ('dbx_16' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `audio_bit_depth` SET TAGS ('dbx_24)_Higher_bit_depth_provides_greater_dynamic_range_and_lower_quantization_noise' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `audio_bit_depth` SET TAGS ('dbx_regulation' = 'EBU R128');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `audio_channels` SET TAGS ('dbx_business_glossary_term' = 'Audio Channels');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `audio_channels` SET TAGS ('dbx_column_comment' = 'Number of discrete audio channels in the asset (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `audio_channels` SET TAGS ('dbx_2_for_stereo' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `audio_channels` SET TAGS ('dbx_6_for_5_1_surround' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `audio_channels` SET TAGS ('dbx_8_for_7_1' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `audio_channels` SET TAGS ('dbx_16_for_multi_language_tracks)_Determines_audio_routing_and_mixing_requirements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `audio_channels` SET TAGS ('dbx_regulation' = 'EBU R128');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `audio_sample_rate_khz` SET TAGS ('dbx_business_glossary_term' = 'Audio Sample Rate Kilohertz (kHz)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `audio_sample_rate_khz` SET TAGS ('dbx_column_comment' = 'Audio sampling frequency in kilohertz (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `audio_sample_rate_khz` SET TAGS ('dbx_48_000_for_broadcast' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `audio_sample_rate_khz` SET TAGS ('dbx_44_100_for_CD_quality)_Indicates_audio_quality_and_broadcast_compliance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `audio_sample_rate_khz` SET TAGS ('dbx_regulation' = 'EBU R128');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `bit_rate_mbps` SET TAGS ('dbx_business_glossary_term' = 'Bit Rate Megabits Per Second (Mbps)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `bit_rate_mbps` SET TAGS ('dbx_column_comment' = 'Average bit rate of the encoded media in megabits per second. Indicates quality level and bandwidth requirements for streaming and playout.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_business_glossary_term' = 'Checksum Message Digest 5 (MD5)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{32}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_column_comment' = 'MD5 hash of the file content for integrity verification. Used to detect corruption during transfer');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_storage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_and_archival_operations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `checksum_sha256` SET TAGS ('dbx_business_glossary_term' = 'Checksum Secure Hash Algorithm 256 (SHA-256)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `checksum_sha256` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{64}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `checksum_sha256` SET TAGS ('dbx_column_comment' = 'SHA-256 cryptographic hash for enhanced integrity verification and chain-of-custody audit trails. Required for regulatory compliance and legal hold.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `codec` SET TAGS ('dbx_business_glossary_term' = 'Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `codec` SET TAGS ('dbx_column_comment' = 'Video or audio compression codec used for encoding (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `codec` SET TAGS ('dbx_H_264' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `codec` SET TAGS ('dbx_H_265_HEVC' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `codec` SET TAGS ('dbx_ProRes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `codec` SET TAGS ('dbx_DNxHD' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `codec` SET TAGS ('dbx_AAC' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `codec` SET TAGS ('dbx_PCM)_Critical_for_quality_assessment_and_transcoding_decisions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_column_comment' = 'Total playback duration of the media asset in seconds with millisecond precision. Used for scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_ad_insertion_planning' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_and_rights_windowing_calculations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `eidr` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `eidr` SET TAGS ('dbx_value_regex' = '^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `eidr` SET TAGS ('dbx_standard_identifier' = 'EIDR');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `eidr` SET TAGS ('dbx_first_class' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `eidr` SET TAGS ('dbx_regex' = '^10.5240/...');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `eidr` SET TAGS ('dbx_column_comment' = 'Universal unique identifier for film and television assets. Enables global content identification for distribution and rights management.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `eidr` SET TAGS ('dbx_validation_regex' = '^10.5240/[0-9A-F-]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `eidr` SET TAGS ('dbx_standard' = 'EIDR');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `eidr` SET TAGS ('dbx_regex_validation' = '^10.5240/[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[A-Z0-9]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size Bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_column_comment' = 'Total file size in bytes. Used for storage capacity planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_transfer_time_estimation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_and_billing_calculations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `frame_rate` SET TAGS ('dbx_business_glossary_term' = 'Frame Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `frame_rate` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `frame_rate` SET TAGS ('dbx_column_comment' = 'Video frame rate in frames per second (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `frame_rate` SET TAGS ('dbx_23_976' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `frame_rate` SET TAGS ('dbx_24_000' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `frame_rate` SET TAGS ('dbx_25_000' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `frame_rate` SET TAGS ('dbx_29_970' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `frame_rate` SET TAGS ('dbx_30_000' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `frame_rate` SET TAGS ('dbx_50_000' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `frame_rate` SET TAGS ('dbx_59_940' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `frame_rate` SET TAGS ('dbx_60_000)_Critical_for_broadcast_standards_compliance_and_motion_quality' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `ingest_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ingest Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `ingest_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `ingest_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when the asset was first ingested into the MAM system. Marks the beginning of the assets lifecycle in the enterprise repository.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `isan` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `isan` SET TAGS ('dbx_value_regex' = '^ISAN [0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `isan` SET TAGS ('dbx_standard_identifier' = 'ISAN');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `isan` SET TAGS ('dbx_first_class' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `isan` SET TAGS ('dbx_regex' = '^[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `isan` SET TAGS ('dbx_column_comment' = 'ISO 15706 international identifier for audiovisual works. Used for content registration and rights management across territories.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `isan` SET TAGS ('dbx_validation_regex' = '^[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `isan` SET TAGS ('dbx_standard' = 'ISAN');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `isan` SET TAGS ('dbx_regex_validation' = '^[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}(-[A-Z0-9])?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `isrc` SET TAGS ('dbx_business_glossary_term' = 'International Standard Recording Code (ISRC)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `isrc` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}-[A-Z0-9]{3}-[0-9]{2}-[0-9]{5}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `isrc` SET TAGS ('dbx_standard_identifier' = 'ISRC');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `isrc` SET TAGS ('dbx_first_class' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `isrc` SET TAGS ('dbx_regex' = '^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `isrc` SET TAGS ('dbx_column_comment' = 'ISO 3901 unique identifier for sound recordings and music video recordings. Used for music beds');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `isrc` SET TAGS ('dbx_audio_tracks' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `isrc` SET TAGS ('dbx_and_music_related_assets' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `isrc` SET TAGS ('dbx_validation_regex' = '^[A-Z]{2}[A-Z0-9]{3}[0-9]{2}[0-9]{5}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `isrc` SET TAGS ('dbx_standard' = 'ISRC');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `isrc` SET TAGS ('dbx_regex_validation' = '^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `last_accessed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Accessed Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `last_accessed_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `last_accessed_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time of the most recent access or playback of the asset. Used for storage tier optimization and usage analytics.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the asset is under legal hold and must not be modified or deleted. Overrides retention policies until hold is released.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `originating_system` SET TAGS ('dbx_business_glossary_term' = 'Originating System');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `originating_system` SET TAGS ('dbx_column_comment' = 'Source system or device that created or ingested the asset (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `originating_system` SET TAGS ('dbx_camera_model' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `originating_system` SET TAGS ('dbx_editing_suite' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `originating_system` SET TAGS ('dbx_ingest_station' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `originating_system` SET TAGS ('dbx_external_vendor)_Provides_provenance_for_chain_of_custody_tracking' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `qc_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Completed Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `qc_completed_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `qc_completed_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when quality control review was completed. Null if QC is pending or not required.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `qc_operator` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Operator');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `qc_operator` SET TAGS ('dbx_column_comment' = 'User ID or name of the operator who performed quality control review. Used for accountability and audit trails.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `resolution` SET TAGS ('dbx_business_glossary_term' = 'Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `resolution` SET TAGS ('dbx_column_comment' = 'Video frame resolution in pixels (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `resolution` SET TAGS ('dbx_1920x1080' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `resolution` SET TAGS ('dbx_3840x2160' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `resolution` SET TAGS ('dbx_1280x720)_Indicates_quality_tier_and_delivery_format_compatibility' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_column_comment' = 'Date when the asset becomes eligible for purge based on retention policy. Null indicates indefinite retention or active legal hold.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `rights_restriction` SET TAGS ('dbx_business_glossary_term' = 'Rights Restriction');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `rights_restriction` SET TAGS ('dbx_value_regex' = 'unrestricted|internal_only|licensed|embargoed|restricted_territory|legal_hold');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `rights_restriction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `rights_restriction` SET TAGS ('dbx_column_comment' = 'Rights and usage restrictions governing distribution and use of the asset. Enforces compliance with licensing agreements');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `rights_restriction` SET TAGS ('dbx_territorial_restrictions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `rights_restriction` SET TAGS ('dbx_and_legal_holds' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `storage_location_uri` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Uniform Resource Identifier (URI)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `storage_location_uri` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `storage_location_uri` SET TAGS ('dbx_column_comment' = 'Full URI path to the physical storage location of the media file (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `storage_location_uri` SET TAGS ('dbx_s3' = '//bucket/path');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `storage_location_uri` SET TAGS ('dbx_file' = '//server/share/path). Used by MAM for retrieval and playout automation.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `storage_location_uri` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `timecode_start` SET TAGS ('dbx_business_glossary_term' = 'Timecode Start');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `timecode_start` SET TAGS ('dbx_value_regex' = '^([0-1][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9][:;][0-9]{2}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `timecode_start` SET TAGS ('dbx_column_comment_SMPTE_timecode_of_the_first_frame_in_HH' = 'MM:SS:FF format. Essential for frame-accurate editing and playout synchronization.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `umid` SET TAGS ('dbx_business_glossary_term' = 'Unique Material Identifier (UMID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `umid` SET TAGS ('dbx_value_regex' = '^[0-9A-F]{64}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `umid` SET TAGS ('dbx_column_comment' = 'SMPTE 330M globally unique identifier for the media essence. 64-character hexadecimal string providing universal identification across systems and organizations.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`media_asset` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the asset version record. Primary key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_column_comment' = 'Reference to the parent media asset of which this is a version or rendition.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `transcode_job_id` SET TAGS ('dbx_business_glossary_term' = 'Transcode Job ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `transcode_job_id` SET TAGS ('dbx_column_comment' = 'Reference to the transcode or encoding job that created this version. Links to workflow orchestration system (Dalet Galaxy) for lineage tracking and troubleshooting.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `abr_ladder_rung` SET TAGS ('dbx_business_glossary_term' = 'Adaptive Bitrate (ABR) Ladder Rung');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `abr_ladder_rung` SET TAGS ('dbx_column_comment' = 'Position in the ABR ladder for HLS or DASH streaming (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `abr_ladder_rung` SET TAGS ('dbx_1_for_lowest_quality' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `abr_ladder_rung` SET TAGS ('dbx_5_for_highest)_Enables_adaptive_streaming_based_on_viewer_bandwidth_Null_if_not_part_of_an_ABR_ladder' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Archived Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this version was moved to archive storage tier. Null if not yet archived. Supports retention policy enforcement and cost optimization.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_column_comment' = 'Display aspect ratio of the video (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_16' = '9');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_4' = '3');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_21' = '9');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_1' = '1). Determines how content is displayed on different screens and platforms.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `audio_channels` SET TAGS ('dbx_business_glossary_term' = 'Audio Channels');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `audio_channels` SET TAGS ('dbx_column_comment' = 'Number of audio channels in this version (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `audio_channels` SET TAGS ('dbx_2_for_stereo' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `audio_channels` SET TAGS ('dbx_6_for_5_1_surround' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `audio_channels` SET TAGS ('dbx_8_for_7_1_surround)_Determines_audio_format_and_playback_capability_requirements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `audio_channels` SET TAGS ('dbx_regulation' = 'EBU R128');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `audio_codec` SET TAGS ('dbx_business_glossary_term' = 'Audio Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `audio_codec` SET TAGS ('dbx_column_comment' = 'Audio compression codec used in this version (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `audio_codec` SET TAGS ('dbx_AAC' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `audio_codec` SET TAGS ('dbx_AC_3' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `audio_codec` SET TAGS ('dbx_Dolby_Digital' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `audio_codec` SET TAGS ('dbx_Opus' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `audio_codec` SET TAGS ('dbx_MP3)_Determines_audio_quality' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `audio_codec` SET TAGS ('dbx_compatibility' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `audio_codec` SET TAGS ('dbx_and_decoding_requirements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `audio_codec` SET TAGS ('dbx_regulation' = 'EBU R128');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Bitrate (Kilobits Per Second)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `bitrate_kbps` SET TAGS ('dbx_column_comment' = 'Average bitrate of the encoded media in kilobits per second. Critical for ABR (Adaptive Bitrate Streaming) ladder configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `bitrate_kbps` SET TAGS ('dbx_CDN_bandwidth_planning' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `bitrate_kbps` SET TAGS ('dbx_and_QoS_(Quality_of_Service)_management' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Checksum Algorithm');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_value_regex' = 'MD5|SHA-256|SHA-512');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_column_comment' = 'Algorithm used to generate the checksum value (MD5');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_SHA_256' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_SHA_512)_Identifies_the_hashing_method_for_integrity_verification' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `checksum_value` SET TAGS ('dbx_business_glossary_term' = 'Checksum Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `checksum_value` SET TAGS ('dbx_column_comment' = 'Cryptographic hash (MD5 or SHA-256) of the file content. Ensures integrity verification');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `checksum_value` SET TAGS ('dbx_detects_corruption_during_transfer_or_storage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `checksum_value` SET TAGS ('dbx_and_supports_chain_of_custody_audit_trails_for_legal_hold_and_regulatory_compliance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `created_by_user` SET TAGS ('dbx_column_comment' = 'Username or identifier of the user or system that created this version. Supports chain-of-custody audit trails for legal hold and regulatory compliance.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this version record was first created in the MAM (Media Asset Management) system. Supports audit trails and chain-of-custody for regulatory compliance.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `drm_protection` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Protection');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `drm_protection` SET TAGS ('dbx_column_comment' = 'Indicates whether this version is protected by DRM encryption (True/False). DRM systems include Widevine');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `drm_protection` SET TAGS ('dbx_PlayReady' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `drm_protection` SET TAGS ('dbx_FairPlay_Supports_content_security_and_anti_piracy' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `drm_system` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) System');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `drm_system` SET TAGS ('dbx_column_comment' = 'DRM system used to protect this version if drm_protection is True (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `drm_system` SET TAGS ('dbx_Widevine' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `drm_system` SET TAGS ('dbx_PlayReady' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `drm_system` SET TAGS ('dbx_FairPlay' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `drm_system` SET TAGS ('dbx_AES_128)_Identifies_the_encryption_and_key_management_system' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_column_comment' = 'Total playback duration of this version in seconds. Used for scheduling');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_ad_pod_placement' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_and_content_inventory_management' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_column_comment' = 'Size of the media file in bytes. Used for storage capacity planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_CDN_(Content_Delivery_Network)_bandwidth_estimation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_and_archive_cost_calculation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `frame_rate` SET TAGS ('dbx_business_glossary_term' = 'Frame Rate (Frames Per Second)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `frame_rate` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `frame_rate` SET TAGS ('dbx_column_comment' = 'Video frame rate in frames per second (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `frame_rate` SET TAGS ('dbx_23_98' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `frame_rate` SET TAGS ('dbx_25_00' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `frame_rate` SET TAGS ('dbx_29_97' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `frame_rate` SET TAGS ('dbx_59_94)_Determines_playback_smoothness_and_broadcast_standard_compliance_(NTSC' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `frame_rate` SET TAGS ('dbx_PAL' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `frame_rate` SET TAGS ('dbx_ATSC)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this version record was last modified. Tracks updates to metadata');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_status_changes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_or_re_transcoding_events' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Free-text notes or comments about this version. Used for QC feedback');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `notes` SET TAGS ('dbx_production_notes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `notes` SET TAGS ('dbx_or_special_handling_instructions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `proxy_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Proxy Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `proxy_expiry_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `proxy_expiry_date` SET TAGS ('dbx_column_comment' = 'Date when this proxy or preview version expires and should be purged from storage. Applicable only when rendition_purpose is proxy or preview. Supports storage cost optimization and compliance with retention policies.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `rendition_purpose` SET TAGS ('dbx_business_glossary_term' = 'Rendition Purpose');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `rendition_purpose` SET TAGS ('dbx_column_comment_Business_purpose_or_use_case_for_this_version' = 'playout (broadcast transmission)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `rendition_purpose` SET TAGS ('dbx_distribution_(delivery_to_platforms)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `rendition_purpose` SET TAGS ('dbx_archive_(long_term_preservation)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `rendition_purpose` SET TAGS ('dbx_preview_(review_approval)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `rendition_purpose` SET TAGS ('dbx_proxy_(low_res_editing)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `rendition_purpose` SET TAGS ('dbx_watermark_(forensic_tracking)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `rendition_purpose` SET TAGS ('dbx_mezzanine_(high_quality_master)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `rendition_purpose` SET TAGS ('dbx_localized_dub_(language_variant)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `rendition_purpose` SET TAGS ('dbx_thumbnail_(visual_reference)_[ENUM_REF_CANDIDATE' = 'playout');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `rendition_purpose` SET TAGS ('dbx_distribution' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `rendition_purpose` SET TAGS ('dbx_archive' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `rendition_purpose` SET TAGS ('dbx_preview' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `rendition_purpose` SET TAGS ('dbx_proxy' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `rendition_purpose` SET TAGS ('dbx_watermark' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `rendition_purpose` SET TAGS ('dbx_mezzanine' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `rendition_purpose` SET TAGS ('dbx_localized_dub' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `rendition_purpose` SET TAGS ('dbx_thumbnail_—_9_candidates_stripped;_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `resolution_height` SET TAGS ('dbx_business_glossary_term' = 'Resolution Height (Pixels)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `resolution_height` SET TAGS ('dbx_column_comment' = 'Vertical resolution of the video frame in pixels (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `resolution_height` SET TAGS ('dbx_1080_for_1080p' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `resolution_height` SET TAGS ('dbx_2160_for_4K)_Used_for_format_classification_and_quality_assessment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `resolution_width` SET TAGS ('dbx_business_glossary_term' = 'Resolution Width (Pixels)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `resolution_width` SET TAGS ('dbx_column_comment' = 'Horizontal resolution of the video frame in pixels (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `resolution_width` SET TAGS ('dbx_1920_for_1080p' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `resolution_width` SET TAGS ('dbx_3840_for_4K)_Used_for_format_classification_and_quality_assessment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `storage_uri` SET TAGS ('dbx_business_glossary_term' = 'Storage Uniform Resource Identifier (URI)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `storage_uri` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `storage_uri` SET TAGS ('dbx_column_comment' = 'Full storage path or URI where this version is physically stored (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `storage_uri` SET TAGS ('dbx_s3' = '//bucket/path');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `storage_uri` SET TAGS ('dbx_file' = '//nas/volume/path');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `storage_uri` SET TAGS ('dbx_https' = '//cdn.example.com/asset). Supports multi-tier storage (hot/warm/cold/archive) and CDN distribution via Akamai.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `storage_uri` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `subtitle_tracks` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Tracks');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `subtitle_tracks` SET TAGS ('dbx_column_comment' = 'Comma-separated list of ISO 639-2 language codes for embedded subtitle or closed caption tracks (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `subtitle_tracks` SET TAGS ('dbx_eng' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `subtitle_tracks` SET TAGS ('dbx_spa' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `subtitle_tracks` SET TAGS ('dbx_fra)_Supports_accessibility_compliance_(COPPA' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `subtitle_tracks` SET TAGS ('dbx_FCC)_and_multi_language_distribution' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `validated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `validated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `validated_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this version passed quality control (QC) validation and was approved for use. Null if validation is pending or failed.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `version_number` SET TAGS ('dbx_column_comment' = 'Sequential or semantic version identifier for this rendition (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `version_number` SET TAGS ('dbx_v1_0' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `version_number` SET TAGS ('dbx_v2_3' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `version_number` SET TAGS ('dbx_proxy_01)_Tracks_lineage_from_camera_original_through_derivatives' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `video_codec` SET TAGS ('dbx_business_glossary_term' = 'Video Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `video_codec` SET TAGS ('dbx_column_comment' = 'Video compression codec used in this version (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `video_codec` SET TAGS ('dbx_H_264_AVC' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `video_codec` SET TAGS ('dbx_H_265_HEVC' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `video_codec` SET TAGS ('dbx_VP9' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `video_codec` SET TAGS ('dbx_AV1' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `video_codec` SET TAGS ('dbx_ProRes)_Determines_video_quality' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `video_codec` SET TAGS ('dbx_file_size' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `video_codec` SET TAGS ('dbx_and_decoding_requirements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `watermark_payload` SET TAGS ('dbx_business_glossary_term' = 'Watermark Payload');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `watermark_payload` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_version` ALTER COLUMN `watermark_payload` SET TAGS ('dbx_column_comment' = 'Forensic watermark identifier or payload embedded in this version for anti-piracy tracking and content protection. Applicable only when rendition_purpose is watermark. Supports DRM (Digital Rights Management) and content security.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` SET TAGS ('dbx_subdomain' = 'media_processing');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_job_id` SET TAGS ('dbx_business_glossary_term' = 'Ingest Job Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_job_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the media ingest job. Primary key for the ingest_job data product.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Created Asset Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_mediaasset_asset_version_Business_justification' = 'Ingest job creates a specific version (typically the mezzanine or raw master). This FK links the ingest job to the version it produced. Populated upon successful ingest completion.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_column_comment' = 'Reference to the resulting media asset record created upon successful completion of the ingest job. Establishes chain-of-custody linkage.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_column_comment' = 'Display aspect ratio of the ingested video content. Determines presentation format and compatibility with distribution channels.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `audio_channels` SET TAGS ('dbx_business_glossary_term' = 'Audio Channel Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `audio_channels` SET TAGS ('dbx_column_comment' = 'Number of audio channels in the ingested media (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `audio_channels` SET TAGS ('dbx_2_for_stereo' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `audio_channels` SET TAGS ('dbx_6_for_5_1_surround)_Used_for_audio_processing_and_compliance_validation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `audio_channels` SET TAGS ('dbx_regulation' = 'EBU R128');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `bitrate_kbps` SET TAGS ('dbx_business_glossary_term' = 'Bitrate (Kilobits Per Second)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `bitrate_kbps` SET TAGS ('dbx_column_comment' = 'Average bitrate of the ingested media in kilobits per second. Indicator of media quality and storage requirements.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `bytes_transferred` SET TAGS ('dbx_business_glossary_term' = 'Bytes Transferred');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `bytes_transferred` SET TAGS ('dbx_column_comment' = 'Total number of bytes successfully transferred during the ingest operation. Used for capacity planning and performance monitoring.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Checksum Algorithm');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_value_regex' = 'MD5|SHA-256|SHA-512|CRC32');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_column_comment' = 'Cryptographic hash algorithm used to verify file integrity during and after ingest. Critical for chain-of-custody and regulatory compliance.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `checksum_value` SET TAGS ('dbx_business_glossary_term' = 'Checksum Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `checksum_value` SET TAGS ('dbx_column_comment' = 'Computed checksum hash of the ingested media file. Used to verify data integrity and detect corruption or tampering.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `closed_caption_present` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Present Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `closed_caption_present` SET TAGS ('dbx_column_comment' = 'Indicates whether closed captions or subtitles are embedded in the ingested media. Required for FCC accessibility compliance validation.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `closed_caption_present` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `codec` SET TAGS ('dbx_business_glossary_term' = 'Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `codec` SET TAGS ('dbx_column_comment' = 'Video or audio codec used in the ingested media (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `codec` SET TAGS ('dbx_H_264' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `codec` SET TAGS ('dbx_H_265_HEVC' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `codec` SET TAGS ('dbx_ProRes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `codec` SET TAGS ('dbx_AAC' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `codec` SET TAGS ('dbx_AC_3)_Critical_for_playback_compatibility_and_transcoding_decisions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when the ingest job record was first created in the MAM system. Audit trail entry point for chain-of-custody.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Media Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_column_comment' = 'Total duration of the ingested media content in seconds. Null for non-time-based media such as still images or graphics.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `error_message` SET TAGS ('dbx_column_comment' = 'Human-readable description of any error encountered during ingest. Provides operational context for failure analysis and remediation.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `error_message` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `frame_rate` SET TAGS ('dbx_business_glossary_term' = 'Frame Rate (Frames Per Second)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `frame_rate` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `frame_rate` SET TAGS ('dbx_column_comment' = 'Frame rate of the ingested video content in frames per second (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `frame_rate` SET TAGS ('dbx_23_976' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `frame_rate` SET TAGS ('dbx_25' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `frame_rate` SET TAGS ('dbx_29_97' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `frame_rate` SET TAGS ('dbx_50' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `frame_rate` SET TAGS ('dbx_59_94)_Critical_for_format_compatibility_and_playout' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ingest End Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_end_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_end_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when the ingest job completed or terminated. Null for jobs still in progress.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ingest Start Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_start_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_start_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when the ingest job began processing. Represents the actual start of media transfer');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `ingest_start_timestamp` SET TAGS ('dbx_not_the_queued_time' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `job_number` SET TAGS ('dbx_business_glossary_term' = 'Ingest Job Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `job_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `job_number` SET TAGS ('dbx_column_comment' = 'Human-readable business identifier for the ingest job');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `job_number` SET TAGS ('dbx_typically_formatted_as_prefix_date_sequence_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `job_number` SET TAGS ('dbx_ING_20240115_0042)_Used_for_operational_tracking_and_reference' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether the ingested media is subject to legal hold and must be preserved for litigation or regulatory investigation. Prevents deletion.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when the ingest job record was last modified. Tracks updates to job status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_metadata_corrections' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_or_error_resolution' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Ingest Job Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Free-text field for operator notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `notes` SET TAGS ('dbx_special_handling_instructions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `notes` SET TAGS ('dbx_or_contextual_information_about_the_ingest_job_Used_for_operational_communication' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `resolution` SET TAGS ('dbx_business_glossary_term' = 'Video Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `resolution` SET TAGS ('dbx_column_comment' = 'Spatial resolution of the ingested video content (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `resolution` SET TAGS ('dbx_1920x1080' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `resolution` SET TAGS ('dbx_3840x2160' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `resolution` SET TAGS ('dbx_1280x720)_Used_for_quality_assessment_and_distribution_planning' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `source_location` SET TAGS ('dbx_business_glossary_term' = 'Source Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `source_location` SET TAGS ('dbx_column_comment' = 'Physical or logical location of the source media. May be a tape ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `source_location` SET TAGS ('dbx_file_path' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `source_location` SET TAGS ('dbx_URL' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `source_location` SET TAGS ('dbx_satellite_transponder_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `source_location` SET TAGS ('dbx_or_cloud_storage_bucket_path' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `target_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Target Storage Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `target_storage_location` SET TAGS ('dbx_column_comment' = 'Destination storage path or tier where the ingested media asset will be stored. May reference nearline');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `target_storage_location` SET TAGS ('dbx_online' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `target_storage_location` SET TAGS ('dbx_or_archive_storage_systems' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `target_storage_location` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `timecode_start` SET TAGS ('dbx_business_glossary_term' = 'Timecode Start');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `timecode_start` SET TAGS ('dbx_column_comment_Starting_timecode_of_the_ingested_media_in_SMPTE_format_(HH' = 'MM:SS:FF). Used for frame-accurate editing and synchronization.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `transfer_rate_mbps` SET TAGS ('dbx_business_glossary_term' = 'Transfer Rate (Megabits Per Second)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `transfer_rate_mbps` SET TAGS ('dbx_column_comment' = 'Average data transfer rate achieved during ingest');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `transfer_rate_mbps` SET TAGS ('dbx_measured_in_megabits_per_second_Key_performance_indicator_for_ingest_infrastructure' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` SET TAGS ('dbx_subdomain' = 'media_processing');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `transcode_job_id` SET TAGS ('dbx_business_glossary_term' = 'Transcode Job Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `transcode_job_id` SET TAGS ('dbx_column_comment' = 'Primary key for transcode_job');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Source Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_column_comment' = 'Reference to the source media asset being transcoded.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `abr_ladder_configuration` SET TAGS ('dbx_business_glossary_term' = 'ABR (Adaptive Bitrate) Ladder Configuration');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `abr_ladder_configuration` SET TAGS ('dbx_column_comment' = 'Configuration specification for ABR ladder generation');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `abr_ladder_configuration` SET TAGS ('dbx_defining_the_set_of_bitrate_resolution_variants_to_be_created_for_adaptive_streaming_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `abr_ladder_configuration` SET TAGS ('dbx_240p@400kbps' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `abr_ladder_configuration` SET TAGS ('dbx_360p@800kbps' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `abr_ladder_configuration` SET TAGS ('dbx_480p@1_2Mbps' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `abr_ladder_configuration` SET TAGS ('dbx_720p@2_5Mbps' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `abr_ladder_configuration` SET TAGS ('dbx_1080p@5Mbps)_Applicable_when_job_type_is_abr_ladder_generation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Checksum Algorithm');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_value_regex' = 'MD5|SHA-256|SHA-512');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_column_comment' = 'Algorithm used to generate the output checksum.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `codec_parameters` SET TAGS ('dbx_business_glossary_term' = 'Codec Parameters');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `codec_parameters` SET TAGS ('dbx_column_comment' = 'Detailed codec encoding parameters including profile');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `codec_parameters` SET TAGS ('dbx_level' = '4.1).');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `codec_parameters` SET TAGS ('dbx_GOP_structure' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `codec_parameters` SET TAGS ('dbx_B_frames' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `codec_parameters` SET TAGS ('dbx_reference_frames' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `codec_parameters` SET TAGS ('dbx_and_other_encoder_specific_settings_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `codec_parameters` SET TAGS ('dbx_x264_preset' = 'medium');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `codec_parameters` SET TAGS ('dbx_crf' = '23');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `codec_parameters` SET TAGS ('dbx_profile' = 'high');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate (USD)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_column_comment' = 'Estimated processing cost in US dollars for this transcode job');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_based_on_compute_time' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_storage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_and_resource_utilization_Used_for_chargeback_and_budget_tracking' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `error_message` SET TAGS ('dbx_column_comment' = 'Human-readable error message describing the failure reason if job_status is failed.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `error_message` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `job_number` SET TAGS ('dbx_business_glossary_term' = 'Transcode Job Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `job_number` SET TAGS ('dbx_value_regex' = '^TJ-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `job_number` SET TAGS ('dbx_column_comment' = 'Human-readable business identifier for the transcode job');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `job_number` SET TAGS ('dbx_used_for_tracking_and_reference_across_systems' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `job_priority` SET TAGS ('dbx_business_glossary_term' = 'Job Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `job_priority` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low|batch');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `job_priority` SET TAGS ('dbx_column_comment' = 'Processing priority level for the transcode job');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `job_priority` SET TAGS ('dbx_determining_queue_position_and_resource_allocation_Critical_jobs_are_processed_immediately' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `job_priority` SET TAGS ('dbx_batch_jobs_during_off_peak_hours' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `migration_reason` SET TAGS ('dbx_business_glossary_term' = 'Migration Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `migration_reason` SET TAGS ('dbx_column_comment' = 'Business justification for format migration jobs. Applicable only when job_type is format_migration');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `migration_reason` SET TAGS ('dbx_tape_digitization' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `migration_reason` SET TAGS ('dbx_or_analogue_to_digital_Captures_whether_the_conversion_is_driven_by_format_obsolescence_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `migration_reason` SET TAGS ('dbx_MPEG_2_to_H_265)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `migration_reason` SET TAGS ('dbx_storage_optimization' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `migration_reason` SET TAGS ('dbx_distribution_requirements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `migration_reason` SET TAGS ('dbx_or_regulatory_compliance_[ENUM_REF_CANDIDATE' = 'format_obsolescence');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `migration_reason` SET TAGS ('dbx_storage_optimization' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `migration_reason` SET TAGS ('dbx_distribution_requirement' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `migration_reason` SET TAGS ('dbx_quality_enhancement' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `migration_reason` SET TAGS ('dbx_compliance_mandate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `migration_reason` SET TAGS ('dbx_archive_preservation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `migration_reason` SET TAGS ('dbx_not_applicable_—_7_candidates_stripped;_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `migration_reason` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Free-text field for operational notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `notes` SET TAGS ('dbx_special_instructions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `notes` SET TAGS ('dbx_or_contextual_information_about_the_transcode_job' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `output_checksum` SET TAGS ('dbx_business_glossary_term' = 'Output Checksum');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `output_checksum` SET TAGS ('dbx_column_comment' = 'Cryptographic checksum (MD5');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `output_checksum` SET TAGS ('dbx_SHA_256' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `output_checksum` SET TAGS ('dbx_or_SHA_512)_of_the_output_file_for_integrity_verification_and_chain_of_custody_audit_trails' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `output_file_size_gb` SET TAGS ('dbx_business_glossary_term' = 'Output File Size (GB)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `output_file_size_gb` SET TAGS ('dbx_column_comment' = 'Total file size of the transcoded output in gigabytes. Populated upon job completion.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `output_storage_uri` SET TAGS ('dbx_business_glossary_term' = 'Output Storage URI (Uniform Resource Identifier)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `output_storage_uri` SET TAGS ('dbx_column_comment' = 'Storage location URI for the transcoded output file(s)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `output_storage_uri` SET TAGS ('dbx_including_protocol' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `output_storage_uri` SET TAGS ('dbx_bucket_path' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `output_storage_uri` SET TAGS ('dbx_and_filename_pattern_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `output_storage_uri` SET TAGS ('dbx_s3' = '//media-archive/transcoded/2024/01/asset_12345_1080p.mp4).');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `output_storage_uri` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `processing_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Processing Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `processing_duration_seconds` SET TAGS ('dbx_column_comment' = 'Total elapsed time in seconds from processing start to completion');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `processing_duration_seconds` SET TAGS ('dbx_used_for_performance_monitoring_and_capacity_planning' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `processing_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processing End Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `processing_end_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `processing_end_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when the transcoding engine completed or terminated processing of this job.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `processing_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processing Start Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `processing_start_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `processing_start_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when the transcoding engine began processing this job.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `quality_validation_result` SET TAGS ('dbx_business_glossary_term' = 'Quality Validation Result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `quality_validation_result` SET TAGS ('dbx_value_regex' = 'passed|failed|warning|not_validated');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `quality_validation_result` SET TAGS ('dbx_column_comment' = 'Outcome of automated quality validation checks performed on the transcoded output');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `quality_validation_result` SET TAGS ('dbx_including_video_integrity' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `quality_validation_result` SET TAGS ('dbx_audio_sync' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `quality_validation_result` SET TAGS ('dbx_and_compliance_with_target_specifications' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `quality_validation_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Validation Score');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `quality_validation_score` SET TAGS ('dbx_column_comment' = 'Numeric quality score (0-100) assigned by automated validation tools');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `quality_validation_score` SET TAGS ('dbx_measuring_output_fidelity_against_source_and_target_specifications' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `queue_entry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Queue Entry Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `queue_entry_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `queue_entry_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when the transcode job was submitted to the processing queue.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `retry_count` SET TAGS ('dbx_column_comment' = 'Number of times this job has been automatically retried after failure');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `retry_count` SET TAGS ('dbx_used_to_prevent_infinite_retry_loops' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_bitrate_mbps` SET TAGS ('dbx_business_glossary_term' = 'Source Bitrate (Mbps)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_bitrate_mbps` SET TAGS ('dbx_column_comment' = 'Average bitrate of the source asset in megabits per second.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_codec` SET TAGS ('dbx_business_glossary_term' = 'Source Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_codec` SET TAGS ('dbx_column_comment' = 'Video codec of the source asset (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_codec` SET TAGS ('dbx_H_264' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_codec` SET TAGS ('dbx_H_265_HEVC' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_codec` SET TAGS ('dbx_MPEG_2' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_codec` SET TAGS ('dbx_ProRes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_codec` SET TAGS ('dbx_DNxHD)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Source Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_duration_seconds` SET TAGS ('dbx_column_comment' = 'Duration of the source media asset in seconds.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_file_size_gb` SET TAGS ('dbx_business_glossary_term' = 'Source File Size (GB)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_file_size_gb` SET TAGS ('dbx_column_comment' = 'File size of the source asset in gigabytes.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_resolution` SET TAGS ('dbx_business_glossary_term' = 'Source Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_resolution` SET TAGS ('dbx_column_comment' = 'Video resolution of the source asset in pixels (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_resolution` SET TAGS ('dbx_1920x1080' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_resolution` SET TAGS ('dbx_3840x2160' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_resolution` SET TAGS ('dbx_1280x720)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `transcoding_engine` SET TAGS ('dbx_business_glossary_term' = 'Transcoding Engine');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `transcoding_engine` SET TAGS ('dbx_column_comment' = 'Name and version of the transcoding engine or software used to perform the conversion (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `transcoding_engine` SET TAGS ('dbx_FFmpeg_5_1_2' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `transcoding_engine` SET TAGS ('dbx_AWS_Elemental_MediaConvert' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `transcoding_engine` SET TAGS ('dbx_Dalet_Brio)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` SET TAGS ('dbx_subdomain' = 'media_processing');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Inspection ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_inspection_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the quality control inspection record. Primary key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Version ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_column_comment' = 'Reference to the specific version of the media asset that underwent this quality control inspection.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `ai_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'AI Confidence Score');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `ai_qc_engine_version` SET TAGS ('dbx_business_glossary_term' = 'AI QC Engine Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when the asset was approved for playout or distribution following QC inspection. Null if not yet approved.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `aspect_ratio_compliance_result` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio Compliance Result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `aspect_ratio_compliance_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_tested');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `aspect_ratio_compliance_result` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `aspect_ratio_compliance_result` SET TAGS ('dbx_column_comment' = 'Result of aspect ratio compliance check. Verifies that video aspect ratio (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `aspect_ratio_compliance_result` SET TAGS ('dbx_16' = '9');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `aspect_ratio_compliance_result` SET TAGS ('dbx_4' = '3');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `aspect_ratio_compliance_result` SET TAGS ('dbx_21' = '9) matches expected format and Active Format Description (AFD) metadata is correct.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_codec_compliance_result` SET TAGS ('dbx_business_glossary_term' = 'Audio Codec Compliance Result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_codec_compliance_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_tested');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_codec_compliance_result` SET TAGS ('dbx_column_comment' = 'Result of audio codec format compliance check. Verifies that audio encoding conforms to expected codec standard (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_codec_compliance_result` SET TAGS ('dbx_AAC' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_codec_compliance_result` SET TAGS ('dbx_Dolby_Digital' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_codec_compliance_result` SET TAGS ('dbx_Dolby_Atmos' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_codec_compliance_result` SET TAGS ('dbx_MPEG_1_Layer_II)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_codec_compliance_result` SET TAGS ('dbx_regulation' = 'EBU R128');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_sync_offset_ms` SET TAGS ('dbx_business_glossary_term' = 'Audio Sync Offset (Milliseconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_sync_offset_ms` SET TAGS ('dbx_column_comment' = 'Measured audio-to-video synchronization offset in milliseconds. Positive values indicate audio leads video; negative values indicate audio lags video. Null if sync check not performed.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_sync_offset_ms` SET TAGS ('dbx_regulation' = 'EBU R128');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_sync_result` SET TAGS ('dbx_business_glossary_term' = 'Audio Sync Check Result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_sync_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_tested');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_sync_result` SET TAGS ('dbx_column_comment' = 'Result of audio-to-video synchronization check. Detects lip-sync errors or audio drift.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `audio_sync_result` SET TAGS ('dbx_regulation' = 'EBU R128');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `black_frame_count` SET TAGS ('dbx_business_glossary_term' = 'Black Frame Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `black_frame_count` SET TAGS ('dbx_column_comment' = 'Total number of black frames detected in the media asset. Zero if none detected.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `black_frame_detected` SET TAGS ('dbx_business_glossary_term' = 'Black Frame Detected');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `black_frame_detected` SET TAGS ('dbx_column_comment' = 'Indicates whether unintended black frames (video signal dropout or encoding error) were detected during inspection.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `caption_validation_result` SET TAGS ('dbx_business_glossary_term' = 'Caption/Subtitle Validation Result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `caption_validation_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_tested');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `caption_validation_result` SET TAGS ('dbx_column_comment' = 'Result of closed caption (CEA-608');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `caption_validation_result` SET TAGS ('dbx_CEA_708)_or_subtitle_validation_check_Verifies_presence' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `caption_validation_result` SET TAGS ('dbx_format_compliance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `caption_validation_result` SET TAGS ('dbx_and_synchronization_of_captions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `caption_validation_result` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when this QC inspection record was first created in the system. Audit trail field.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `critical_defect_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Defect Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `critical_defect_count` SET TAGS ('dbx_column_comment' = 'Number of critical-severity defects that block asset approval for playout or distribution. Critical defects require remediation.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `defect_count` SET TAGS ('dbx_column_comment' = 'Total number of quality defects detected during inspection. Zero indicates no defects found.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `defect_summary` SET TAGS ('dbx_business_glossary_term' = 'Defect Summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `defect_summary` SET TAGS ('dbx_column_comment' = 'Structured JSON or delimited text summary of all detected defects with timecode references');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `defect_summary` SET TAGS ('dbx_severity_levels' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `defect_summary` SET TAGS ('dbx_and_defect_type_codes_Detailed_defect_records_may_be_stored_in_a_separate_qc_defect_child_table' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `detected_aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Detected Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `detected_aspect_ratio` SET TAGS ('dbx_metric_kind' = 'ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `detected_aspect_ratio` SET TAGS ('dbx_column_comment' = 'Actual aspect ratio detected in the video stream (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `detected_aspect_ratio` SET TAGS ('dbx_16' = '9');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `detected_aspect_ratio` SET TAGS ('dbx_4' = '3');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `detected_aspect_ratio` SET TAGS ('dbx_1_85' = '1');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `detected_aspect_ratio` SET TAGS ('dbx_2_39' = '1). Null if aspect ratio check not performed.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `freeze_frame_count` SET TAGS ('dbx_business_glossary_term' = 'Freeze Frame Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `freeze_frame_count` SET TAGS ('dbx_column_comment' = 'Total number of freeze frame incidents detected in the media asset. Zero if none detected.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `freeze_frame_detected` SET TAGS ('dbx_business_glossary_term' = 'Freeze Frame Detected');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `freeze_frame_detected` SET TAGS ('dbx_column_comment' = 'Indicates whether freeze frames (static video for extended duration) were detected during inspection.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `hdr_metadata_validation_result` SET TAGS ('dbx_business_glossary_term' = 'HDR Metadata Validation Result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `hdr_metadata_validation_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable|not_tested');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `hdr_metadata_validation_result` SET TAGS ('dbx_column_comment' = 'Result of High Dynamic Range (HDR) metadata validation check. Verifies presence and correctness of HDR10');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `hdr_metadata_validation_result` SET TAGS ('dbx_HDR10+' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `hdr_metadata_validation_result` SET TAGS ('dbx_Dolby_Vision' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `hdr_metadata_validation_result` SET TAGS ('dbx_or_HLG_metadata_Not_applicable_for_Standard_Dynamic_Range_(SDR)_content' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Inspection Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_duration_seconds` SET TAGS ('dbx_column_comment' = 'Total elapsed time in seconds required to complete the quality control inspection process.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'QC Inspection Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_value_regex' = '^QC-[0-9]{8}-[0-9]{6}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_column_comment' = 'Human-readable business identifier for the inspection record');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_formatted_as_QC_YYYYMMDD_NNNNNN' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when the quality control inspection was performed or completed. Primary business event timestamp.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `loudness_compliance_result` SET TAGS ('dbx_business_glossary_term' = 'Loudness Compliance Result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `loudness_compliance_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_tested');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `loudness_compliance_result` SET TAGS ('dbx_column_comment' = 'Result of audio loudness compliance check against regulatory standards (EBU R128 for Europe');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `loudness_compliance_result` SET TAGS ('dbx_ATSC_A_85_for_North_America' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `loudness_compliance_result` SET TAGS ('dbx_ITU_R_BS_1770_globally)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `loudness_compliance_result` SET TAGS ('dbx_regulation' = 'EBU R128');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `loudness_lufs` SET TAGS ('dbx_business_glossary_term' = 'Loudness Level (LUFS)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `loudness_lufs` SET TAGS ('dbx_column_comment' = 'Measured integrated loudness level in LUFS (Loudness Units relative to Full Scale) or LKFS. Typical broadcast target is -23 LUFS (EBU R128) or -24 LKFS (ATSC A/85).');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `loudness_lufs` SET TAGS ('dbx_regulation' = 'EBU R128');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_column_comment' = 'Date and time when this QC inspection record was last updated. Audit trail field.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'QC Inspection Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Free-text notes or comments from the QC operator or automated tool regarding the inspection');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `notes` SET TAGS ('dbx_including_observations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `notes` SET TAGS ('dbx_context' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `notes` SET TAGS ('dbx_or_recommendations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `overall_result` SET TAGS ('dbx_business_glossary_term' = 'Overall QC Result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `overall_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|review_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `overall_result` SET TAGS ('dbx_column_comment' = 'Final pass/fail determination for the quality control inspection. Conditional pass indicates minor issues that do not block playout. Review required indicates human escalation needed.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_tool_name` SET TAGS ('dbx_business_glossary_term' = 'QC Tool Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_tool_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_tool_name` SET TAGS ('dbx_column_comment' = 'Name and version of the automated quality control software or tool used for inspection (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_tool_name` SET TAGS ('dbx_Baton' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_tool_name` SET TAGS ('dbx_Interra' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_tool_name` SET TAGS ('dbx_Venera' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_tool_name` SET TAGS ('dbx_Dalet_QC_Module)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_tool_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `qc_tool_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_column_comment' = 'Detailed explanation of why the asset was rejected');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_including_references_to_specific_defects_or_compliance_failures_Null_if_asset_was_approved' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_ENUM_REF_CANDIDATE' = 'promote-to-reference-product');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `video_codec_compliance_result` SET TAGS ('dbx_business_glossary_term' = 'Video Codec Compliance Result');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `video_codec_compliance_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_tested');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `video_codec_compliance_result` SET TAGS ('dbx_column_comment' = 'Result of video codec format compliance check. Verifies that video encoding conforms to expected codec standard (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `video_codec_compliance_result` SET TAGS ('dbx_H_264_AVC' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `video_codec_compliance_result` SET TAGS ('dbx_H_265_HEVC' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `video_codec_compliance_result` SET TAGS ('dbx_MPEG_2' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection` ALTER COLUMN `video_codec_compliance_result` SET TAGS ('dbx_AV1)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the storage location within the Media Asset Management (MAM) infrastructure. Primary key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `access_protocol` SET TAGS ('dbx_business_glossary_term' = 'Storage Access Protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `access_protocol` SET TAGS ('dbx_column_comment' = 'Network protocol or interface used to access the storage location (NFS = Network File System');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `access_protocol` SET TAGS ('dbx_SMB' = 'Server Message Block');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `access_protocol` SET TAGS ('dbx_S3' = 'Amazon S3 API');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `access_protocol` SET TAGS ('dbx_SFTP' = 'Secure File Transfer Protocol');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `access_protocol` SET TAGS ('dbx_iSCSI' = 'Internet Small Computer Systems Interface');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `access_protocol` SET TAGS ('dbx_Fibre_Channel_FC_SAN_protocol)_[ENUM_REF_CANDIDATE' = 'NFS');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `access_protocol` SET TAGS ('dbx_SMB' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `access_protocol` SET TAGS ('dbx_S3' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `access_protocol` SET TAGS ('dbx_SFTP' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `access_protocol` SET TAGS ('dbx_iSCSI' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `access_protocol` SET TAGS ('dbx_Fibre_Channel' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `access_protocol` SET TAGS ('dbx_HTTP' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `access_protocol` SET TAGS ('dbx_HTTPS_—_8_candidates_stripped;_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `available_capacity_tb` SET TAGS ('dbx_business_glossary_term' = 'Available Storage Capacity in Terabytes (TB)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `available_capacity_tb` SET TAGS ('dbx_column_comment' = 'Remaining available storage capacity (total minus used)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `available_capacity_tb` SET TAGS ('dbx_measured_in_terabytes_(TB)_Drives_automated_alerts_and_provisioning_workflows' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Checksum Algorithm');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_value_regex' = 'MD5|SHA-1|SHA-256|SHA-512|CRC32');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_column_comment' = 'Hashing algorithm used for checksum validation (MD5 = Message Digest 5');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_SHA' = 'Secure Hash Algorithm');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_CRC32' = 'Cyclic Redundancy Check). Null if checksum validation is not enabled.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `checksum_validation_enabled` SET TAGS ('dbx_business_glossary_term' = 'Checksum Validation Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `checksum_validation_enabled` SET TAGS ('dbx_column_comment' = 'Indicates whether automated checksum integrity validation is performed on assets stored at this location (True = enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `checksum_validation_enabled` SET TAGS ('dbx_False' = 'disabled). Critical for ensuring asset integrity and detecting corruption.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Contact Email');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `contact_email` SET TAGS ('dbx_column_comment' = 'Primary email address for the technical or operational contact responsible for this storage location. Used for alerts');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `contact_email` SET TAGS ('dbx_maintenance_coordination' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `contact_email` SET TAGS ('dbx_and_incident_response' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `contact_email` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `contact_email` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `cost_per_tb_per_month` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Terabyte (TB) Per Month');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `cost_per_tb_per_month` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `cost_per_tb_per_month` SET TAGS ('dbx_column_comment' = 'Monthly cost per terabyte of storage at this location');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `cost_per_tb_per_month` SET TAGS ('dbx_used_for_cost_allocation_and_financial_reporting_Includes_infrastructure' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `cost_per_tb_per_month` SET TAGS ('dbx_licensing' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `cost_per_tb_per_month` SET TAGS ('dbx_and_operational_costs' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment_Timestamp_when_this_storage_location_record_was_first_created_in_the_MAM_system_Format' = 'yyyy-MM-ddTHH:mm:ss.SSSXXX.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `data_center_name` SET TAGS ('dbx_business_glossary_term' = 'Data Center Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `data_center_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `data_center_name` SET TAGS ('dbx_column_comment' = 'Name or identifier of the physical data center or facility housing the storage infrastructure (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `data_center_name` SET TAGS ('dbx_'NYC_DC1'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `data_center_name` SET TAGS ('dbx_'AWS_US_East_1'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `data_center_name` SET TAGS ('dbx_'Azure_WestEurope')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `data_center_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `data_center_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `decommission_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `decommission_date` SET TAGS ('dbx_column_comment_Date_when_the_storage_location_was_or_is_planned_to_be_decommissioned_and_removed_from_service_Null_if_still_active_Format' = 'yyyy-MM-dd.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `encryption_enabled` SET TAGS ('dbx_business_glossary_term' = 'Encryption Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `encryption_enabled` SET TAGS ('dbx_column_comment' = 'Indicates whether data-at-rest encryption is enabled for this storage location (True = encrypted');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `encryption_enabled` SET TAGS ('dbx_False' = 'not encrypted). Critical for compliance with data protection regulations.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `geographic_region` SET TAGS ('dbx_column_comment' = 'Geographic region or data center location where the storage is physically or logically hosted (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `geographic_region` SET TAGS ('dbx_'US_East'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `geographic_region` SET TAGS ('dbx_'EU_West'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `geographic_region` SET TAGS ('dbx_'APAC_Singapore'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `geographic_region` SET TAGS ('dbx_'On_Premise_NYC')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `last_capacity_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Capacity Check Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `last_capacity_check_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `last_capacity_check_timestamp` SET TAGS ('dbx_column_comment_Timestamp_of_the_most_recent_capacity_measurement_or_audit_for_this_storage_location_Format' = 'yyyy-MM-ddTHH:mm:ss.SSSXXX.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_column_comment_Timestamp_when_this_storage_location_record_was_last_updated_or_modified_Format' = 'yyyy-MM-ddTHH:mm:ss.SSSXXX.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `legal_hold_capable` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Capable Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `legal_hold_capable` SET TAGS ('dbx_column_comment' = 'Indicates whether this storage location supports legal hold functionality to prevent deletion or modification of assets under litigation or regulatory investigation (True = capable');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `legal_hold_capable` SET TAGS ('dbx_False' = 'not capable).');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `location_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `location_name` SET TAGS ('dbx_column_comment' = 'Human-readable name or label for the storage location (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `location_name` SET TAGS ('dbx_'Production_SAN_Array_01'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `location_name` SET TAGS ('dbx_'Archive_LTO_Tape_Library'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `location_name` SET TAGS ('dbx_'AWS_S3_US_East_Bucket')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `location_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `location_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `mount_point` SET TAGS ('dbx_business_glossary_term' = 'Storage Mount Point or Path');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `mount_point` SET TAGS ('dbx_column_comment' = 'File system mount point');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `mount_point` SET TAGS ('dbx_UNC_path' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `mount_point` SET TAGS ('dbx_or_object_storage_URI_used_by_MAM_systems_to_access_the_location_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `mount_point` SET TAGS ('dbx_'_mnt_production_san'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `mount_point` SET TAGS ('dbx_'\\nas01\media'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `mount_point` SET TAGS ('dbx_'s3' = '//bucket-name/prefix).');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Free-text field for additional operational notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `notes` SET TAGS ('dbx_configuration_details' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `notes` SET TAGS ('dbx_or_special_instructions_related_to_this_storage_location' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Maintenance|Decommissioned|Provisioning');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `operational_status` SET TAGS ('dbx_column_comment' = 'Current operational state of the storage location (Active = in production use');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `operational_status` SET TAGS ('dbx_Inactive' = 'temporarily offline');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `operational_status` SET TAGS ('dbx_Maintenance' = 'undergoing service');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `operational_status` SET TAGS ('dbx_Decommissioned' = 'retired');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `operational_status` SET TAGS ('dbx_Provisioning' = 'being set up).');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `provisioned_date` SET TAGS ('dbx_business_glossary_term' = 'Provisioned Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `provisioned_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `provisioned_date` SET TAGS ('dbx_column_comment_Date_when_the_storage_location_was_initially_provisioned_and_made_available_for_use_Format' = 'yyyy-MM-dd.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `replication_enabled` SET TAGS ('dbx_business_glossary_term' = 'Replication Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `replication_enabled` SET TAGS ('dbx_column_comment' = 'Indicates whether this storage location is replicated to another location for redundancy and disaster recovery (True = replicated');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `replication_enabled` SET TAGS ('dbx_False' = 'not replicated).');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `restore_time_objective_hours` SET TAGS ('dbx_business_glossary_term' = 'Restore Time Objective (RTO) in Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `restore_time_objective_hours` SET TAGS ('dbx_column_comment' = 'Maximum acceptable time to restore or retrieve assets from this storage location');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `restore_time_objective_hours` SET TAGS ('dbx_measured_in_hours_Critical_for_disaster_recovery_and_operational_planning' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `retention_policy_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy in Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `retention_policy_days` SET TAGS ('dbx_column_comment' = 'Default retention period in days for assets stored at this location');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `retention_policy_days` SET TAGS ('dbx_after_which_assets_may_be_migrated_or_purged_per_policy_Null_if_no_default_retention_applies' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `storage_vendor` SET TAGS ('dbx_business_glossary_term' = 'Storage Vendor');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `storage_vendor` SET TAGS ('dbx_column_comment' = 'Name of the storage hardware or cloud service provider (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `storage_vendor` SET TAGS ('dbx_'Dell_EMC'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `storage_vendor` SET TAGS ('dbx_'NetApp'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `storage_vendor` SET TAGS ('dbx_'AWS'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `storage_vendor` SET TAGS ('dbx_'Azure'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `storage_vendor` SET TAGS ('dbx_'Google_Cloud'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `storage_vendor` SET TAGS ('dbx_'IBM_Spectrum_Archive')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `storage_vendor` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `total_capacity_tb` SET TAGS ('dbx_business_glossary_term' = 'Total Storage Capacity in Terabytes (TB)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `total_capacity_tb` SET TAGS ('dbx_column_comment' = 'Total storage capacity of the location measured in terabytes (TB). Used for capacity planning and allocation reporting.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `used_capacity_tb` SET TAGS ('dbx_business_glossary_term' = 'Used Storage Capacity in Terabytes (TB)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `used_capacity_tb` SET TAGS ('dbx_column_comment' = 'Current amount of storage capacity consumed or allocated');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`storage_location` ALTER COLUMN `used_capacity_tb` SET TAGS ('dbx_measured_in_terabytes_(TB)_Updated_periodically_to_reflect_actual_usage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` SET TAGS ('dbx_subdomain' = 'media_processing');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `asset_storage_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Storage Assignment ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `asset_storage_assignment_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the asset storage assignment record. Primary key for tracking storage placement history.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `asset_storage_assignment_id` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_column_comment' = 'Reference to the specific version of the media asset being stored. Tracks mezzanine');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_proxy' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_master' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_or_archived_versions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_column_comment' = 'Reference to the media asset that is being stored. Links to the master media asset record in the MAM (Media Asset Management) system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_column_comment' = 'Reference to the retention policy governing this storage assignment. Determines how long the file must be retained and when it can be purged.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_column_comment' = 'Reference to the physical or logical storage location where the asset file resides. Links to storage infrastructure registry.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `access_frequency` SET TAGS ('dbx_business_glossary_term' = 'Access Frequency Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `access_frequency` SET TAGS ('dbx_column_comment' = 'Number of times this file has been accessed since assignment to this storage location. Used to inform tiering and migration decisions.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_column_comment' = 'Date when the asset file was migrated');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_purged' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_or_removed_from_this_storage_location_Null_if_still_active_at_this_location' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_end_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_end_timestamp` SET TAGS ('dbx_column_comment' = 'Precise timestamp when the asset file was migrated');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_end_timestamp` SET TAGS ('dbx_purged' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_end_timestamp` SET TAGS ('dbx_or_removed_from_this_storage_location_Null_if_still_active' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_column_comment' = 'Date when the asset file was placed at this storage location. Marks the beginning of the storage assignment period.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_start_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `assignment_start_timestamp` SET TAGS ('dbx_column_comment' = 'Precise timestamp when the asset file was placed at this storage location. Provides exact time for chain-of-custody audit trails.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Checksum Algorithm');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_value_regex' = 'MD5|SHA-1|SHA-256|SHA-512|CRC32');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_column_comment' = 'Algorithm used to generate the checksum value. Common algorithms include MD5');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_SHA_1' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_SHA_256' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_SHA_512' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_and_CRC32' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `checksum_value` SET TAGS ('dbx_business_glossary_term' = 'Checksum Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `checksum_value` SET TAGS ('dbx_column_comment' = 'Cryptographic hash or checksum of the file at placement time. Ensures file integrity verification and detects corruption or tampering.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this storage assignment record was first created in the system. Used for audit trails and data lineage.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `file_path` SET TAGS ('dbx_business_glossary_term' = 'File Path or Uniform Resource Identifier (URI)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `file_path` SET TAGS ('dbx_column_comment' = 'Complete file system path or URI where the asset file is physically stored. Enables restore path resolution and file retrieval.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_column_comment' = 'Size of the asset file in bytes at the time of storage assignment. Used for capacity planning and storage cost allocation.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `last_access_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Access Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `last_access_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `last_access_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp of the most recent access to this file at this storage location. Used for tiering policy enforcement and usage analytics.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_column_comment' = 'Indicates whether this storage assignment is subject to a legal hold. When true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_the_file_cannot_be_deleted_or_modified_regardless_of_retention_policy' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `migration_trigger` SET TAGS ('dbx_business_glossary_term' = 'Migration Trigger');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `migration_trigger` SET TAGS ('dbx_value_regex' = 'tiering_policy|legal_hold|cost_optimization|format_migration|capacity_rebalance|manual_request');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `migration_trigger` SET TAGS ('dbx_column_comment' = 'Reason why the asset was moved to or from this storage location. Captures business or technical driver for storage placement decisions.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_column_comment' = 'Free-text notes or comments about this storage assignment. Captures context');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_special_handling_instructions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_or_migration_rationale' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `replication_count` SET TAGS ('dbx_business_glossary_term' = 'Replication Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `replication_count` SET TAGS ('dbx_column_comment' = 'Number of redundant copies of this file maintained at this storage location. Used for disaster recovery and high availability planning.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `storage_cost_per_gb` SET TAGS ('dbx_business_glossary_term' = 'Storage Cost Per Gigabyte (GB)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `storage_cost_per_gb` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `storage_cost_per_gb` SET TAGS ('dbx_column_comment' = 'Cost per gigabyte for this storage tier at the time of assignment. Used for storage cost allocation and financial reporting.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `storage_cost_per_gb` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp when this storage assignment record was last modified. Used for change tracking and audit trails.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_column_comment' = 'Timestamp of the most recent integrity verification check. Used to track compliance with periodic verification policies.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` SET TAGS ('dbx_data_type' = 'dimension');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_column_comment' = 'Unique identifier for the retention policy record. Primary key.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `supersedes_policy_retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Supersedes Retention Policy ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `supersedes_policy_retention_policy_id` SET TAGS ('dbx_column_comment' = 'Reference to the previous retention policy that this policy replaces. Null if this is the first version. Supports policy lineage and historical analysis.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `applies_to_legal_hold` SET TAGS ('dbx_business_glossary_term' = 'Applies to Legal Hold Assets');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `applies_to_legal_hold` SET TAGS ('dbx_column_comment' = 'Indicates whether this retention policy applies to assets under legal hold. If false');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `applies_to_legal_hold` SET TAGS ('dbx_legal_hold_assets_are_exempt_from_automated_lifecycle_actions_governed_by_this_policy' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `applies_to_syndication_content` SET TAGS ('dbx_business_glossary_term' = 'Applies to Syndication Content');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `applies_to_syndication_content` SET TAGS ('dbx_column_comment' = 'Indicates whether this retention policy applies to syndicated content (content resold to multiple outlets). Syndication agreements may impose distinct retention obligations.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `asset_class_scope` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `asset_class_scope` SET TAGS ('dbx_column_comment_The_category_of_media_assets_to_which_this_retention_policy_applies_Aligns_with_MAM_(Media_Asset_Management)_asset_classification_in_Dalet_Galaxy_[ENUM_REF_CANDIDATE' = 'raw');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `asset_class_scope` SET TAGS ('dbx_mezzanine' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `asset_class_scope` SET TAGS ('dbx_proxy' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `asset_class_scope` SET TAGS ('dbx_archive' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `asset_class_scope` SET TAGS ('dbx_master' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `asset_class_scope` SET TAGS ('dbx_graphics' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `asset_class_scope` SET TAGS ('dbx_audio' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `asset_class_scope` SET TAGS ('dbx_metadata_—_8_candidates_stripped;_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `audit_trail_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `audit_trail_required` SET TAGS ('dbx_column_comment' = 'Indicates whether a full chain-of-custody audit trail must be maintained for assets governed by this policy. Critical for regulatory compliance and legal hold scenarios.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `audit_trail_required` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `checksum_verification_required` SET TAGS ('dbx_business_glossary_term' = 'Checksum Verification Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `checksum_verification_required` SET TAGS ('dbx_column_comment' = 'Indicates whether checksum integrity verification is mandatory before executing post-retention actions. Ensures asset integrity throughout the retention lifecycle.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment' = 'The timestamp when this retention policy record was first created in the system.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_column_comment' = 'The date on which this retention policy becomes enforceable. Assets ingested or classified on or after this date are subject to the policy.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `expiry_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `expiry_date` SET TAGS ('dbx_column_comment' = 'The date on which this retention policy ceases to be enforceable. Null indicates the policy remains in effect indefinitely until explicitly retired.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `format_migration_allowed` SET TAGS ('dbx_business_glossary_term' = 'Format Migration Allowed');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `format_migration_allowed` SET TAGS ('dbx_column_comment' = 'Indicates whether format migration (transcoding to newer codecs or containers) is permitted during the retention period. Supports long-term preservation and format obsolescence mitigation.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_column_comment' = 'Comma-separated list of ISO 3166-1 alpha-3 country codes indicating the geographic jurisdictions to which this policy applies (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_'USA' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_GBR' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_CAN')_Supports_multi_jurisdictional_compliance' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_column_comment' = 'The user ID or system identifier that last modified this retention policy record.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_column_comment' = 'The timestamp when this retention policy record was last updated.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `maximum_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Retention Period (Days)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `maximum_retention_period_days` SET TAGS ('dbx_column_comment' = 'The maximum number of days an asset may be retained before mandatory action (purge or archive migration). Null indicates indefinite retention.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `minimum_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Retention Period (Days)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `minimum_retention_period_days` SET TAGS ('dbx_column_comment' = 'The minimum number of days an asset must be retained before any deletion or migration action can occur. Enforces regulatory and contractual obligations.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `notification_recipients` SET TAGS ('dbx_business_glossary_term' = 'Notification Recipients');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `notification_recipients` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `notification_recipients` SET TAGS ('dbx_column_comment' = 'Comma-separated list of email addresses or role identifiers to be notified when retention actions are triggered (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `notification_recipients` SET TAGS ('dbx_'legal@mediabroadcasting_com' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `notification_recipients` SET TAGS ('dbx_content_ops_team')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_description` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_description` SET TAGS ('dbx_column_comment' = 'Detailed business description of the retention policy');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_description` SET TAGS ('dbx_including_rationale' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_description` SET TAGS ('dbx_scope' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_description` SET TAGS ('dbx_and_any_special_handling_instructions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_column_comment' = 'Business-friendly name of the retention policy (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_'Broadcast_Master_Archive_Policy'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_'Raw_Footage_90_Day_Purge')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_regulation' = 'GDPR');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_owner` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_owner` SET TAGS ('dbx_column_comment' = 'The business role');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_owner` SET TAGS ('dbx_department' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_owner` SET TAGS ('dbx_or_individual_responsible_for_defining_and_maintaining_this_retention_policy_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_owner` SET TAGS ('dbx_'Legal_&_Compliance'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_owner` SET TAGS ('dbx_'Media_Operations_Director'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `policy_owner` SET TAGS ('dbx_'Chief_Content_Officer')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `post_retention_action` SET TAGS ('dbx_business_glossary_term' = 'Post-Retention Action');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `post_retention_action` SET TAGS ('dbx_value_regex' = 'purge|migrate_to_deep_archive|notify_rights_owner|manual_review|transfer_to_external_archive');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `post_retention_action` SET TAGS ('dbx_column_comment' = 'The action to be taken when the retention period expires. Drives automated lifecycle workflows in MAM (Media Asset Management) systems.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_column_comment' = 'The regulatory framework');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_statute' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_or_compliance_requirement_that_mandates_or_informs_this_retention_policy_(e_g' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_'FCC_47_CFR_73_1840'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_'Ofcom_Section_11'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_'GDPR_Article_5'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_'SOX_Section_802'' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_'Legal_Hold_Case_#12345')' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `retention_trigger` SET TAGS ('dbx_business_glossary_term' = 'Retention Trigger Event');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `retention_trigger` SET TAGS ('dbx_value_regex' = 'ingest_date|broadcast_date|contract_expiry|legal_hold|last_access_date|rights_expiry');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `retention_trigger` SET TAGS ('dbx_column_comment' = 'The business event that starts the retention clock for this policy (e.g.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `retention_trigger` SET TAGS ('dbx_when_the_asset_was_ingested' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `retention_trigger` SET TAGS ('dbx_when_it_was_first_broadcast' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `retention_trigger` SET TAGS ('dbx_when_the_licensing_contract_expires' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `retention_trigger` SET TAGS ('dbx_or_when_a_legal_hold_is_placed)' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `storage_tier_target` SET TAGS ('dbx_business_glossary_term' = 'Storage Tier Target');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `storage_tier_target` SET TAGS ('dbx_value_regex' = 'hot|warm|cold|deep_archive|glacier');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `storage_tier_target` SET TAGS ('dbx_column_comment' = 'The target storage tier for assets governed by this policy after the retention period. Aligns with tiered storage strategies in MAM (Media Asset Management) and CDN (Content Delivery Network) architectures.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `storage_tier_target` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `version_number` SET TAGS ('dbx_column_comment' = 'Sequential version number of this retention policy. Incremented each time the policy is revised. Supports policy change tracking and audit compliance.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy` ALTER COLUMN `created_by` SET TAGS ('dbx_column_comment' = 'The user ID or system identifier that created this retention policy record.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` SET TAGS ('dbx_data_type' = 'fact');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` SET TAGS ('dbx_subdomain' = 'media_processing');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `asset_lifecycle_event_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Lifecycle Event ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `asset_lifecycle_event_id` SET TAGS ('dbx_column_comment_Unique_identifier_for_the_asset_lifecycle_event_record_Primary_key_Inferred_role' = 'EVENT_LOG. This entity represents an immutable audit log of state transitions for media assets');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `asset_lifecycle_event_id` SET TAGS ('dbx_capturing_the_complete_chain_of_custody_trail_required_for_regulatory' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `asset_lifecycle_event_id` SET TAGS ('dbx_legal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `asset_lifecycle_event_id` SET TAGS ('dbx_and_rights_compliance_in_media_asset_management_systems' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_column_comment_Foreign_key_linking_to_mediaasset_asset_version_Business_justification' = 'Lifecycle events (QC passed');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_transcoded' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_archived' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_migrated)_apply_to_specific_versions' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_not_just_the_asset_concept_This_FK_allows_tracking_version_specific_state_transitions_Nullable_for_asset_leve' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `ingest_job_id` SET TAGS ('dbx_business_glossary_term' = 'Ingest Job Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_column_comment' = 'Reference to the media asset that experienced this lifecycle event. Links to the master media asset record in the MAM (Media Asset Management) system. This is the EVENT_SOURCE_REFERENCE required for EVENT_LOG role.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `qc_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Qc Inspection Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_column_comment' = 'Reference to the data retention policy that governs this assets lifecycle. Links to the retention policy master table that defines minimum and maximum retention periods');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_purge_rules' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_and_regulatory_compliance_requirements' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `transcode_job_id` SET TAGS ('dbx_business_glossary_term' = 'Transcode Job Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `approval_authority` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `approval_authority` SET TAGS ('dbx_column_comment' = 'The name or identifier of the person or role that provided approval for this lifecycle event');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `approval_authority` SET TAGS ('dbx_applicable_for_approval' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `approval_authority` SET TAGS ('dbx_publish' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `approval_authority` SET TAGS ('dbx_and_legal_hold_released_events_Used_for_accountability_and_compliance_documentation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_column_comment' = 'External reference identifier linking this lifecycle event to broader audit trail systems');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_compliance_documentation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_or_regulatory_filing_records_Used_to_connect_MAM_(Media_Asset_Management)_events_to_enterprise_audit_and_compliance_frameworks' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_regulation' = 'SOX');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `checksum_after` SET TAGS ('dbx_business_glossary_term' = 'Checksum After Event');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `checksum_after` SET TAGS ('dbx_column_comment' = 'The cryptographic checksum (MD5');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `checksum_after` SET TAGS ('dbx_SHA_256' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `checksum_after` SET TAGS ('dbx_or_other_hash)_of_the_media_file_after_this_event_Used_to_verify_file_integrity_and_detect_unauthorized_modifications_Critical_for_chain_of_custody_audit_trail' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `checksum_before` SET TAGS ('dbx_business_glossary_term' = 'Checksum Before Event');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `checksum_before` SET TAGS ('dbx_column_comment' = 'The cryptographic checksum (MD5');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `checksum_before` SET TAGS ('dbx_SHA_256' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `checksum_before` SET TAGS ('dbx_or_other_hash)_of_the_media_file_before_this_event_Used_to_verify_file_integrity_and_detect_unauthorized_modifications_Critical_for_chain_of_custody_audit_trail' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_type_hint' = 'boolean');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_column_comment' = 'Boolean indicator of whether this lifecycle event was executed in compliance with applicable regulatory');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_legal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_and_internal_policy_requirements_True_indicates_compliant_execution;_False_indicates_a_compliance_violation_or_exception_that_requires_review' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_column_comment_System_timestamp_when_this_lifecycle_event_record_was_created_in_the_data_warehouse_Format' = 'yyyy-MM-ddTHH:mm:ss.SSSXXX. Distinct from event_timestamp which captures the business event time. Used for data lineage and ETL (Extract Transform Load) audit purposes.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Media Duration in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_column_comment' = 'The playback duration of the media asset in seconds at the time of this lifecycle event. Used to verify content integrity after format migrations and to track asset characteristics over time.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `error_message` SET TAGS ('dbx_column_comment' = 'Human-readable error message or exception description if this lifecycle event encountered an error or failure. Provides detailed context for troubleshooting and incident resolution.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `error_message` SET TAGS ('dbx_regulation' = 'COPPA');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `event_duration_milliseconds` SET TAGS ('dbx_business_glossary_term' = 'Event Processing Duration in Milliseconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `event_duration_milliseconds` SET TAGS ('dbx_column_comment' = 'The elapsed time in milliseconds that this lifecycle event took to complete. Used for performance monitoring');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `event_duration_milliseconds` SET TAGS ('dbx_SLA_(Service_Level_Agreement)_tracking' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `event_duration_milliseconds` SET TAGS ('dbx_and_workflow_optimization_Applicable_for_transcode' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `event_duration_milliseconds` SET TAGS ('dbx_migration' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `event_duration_milliseconds` SET TAGS ('dbx_and_ingest_events' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `event_reason` SET TAGS ('dbx_business_glossary_term' = 'Event Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `event_reason` SET TAGS ('dbx_column_comment' = 'Free-text explanation or justification for why this lifecycle event occurred. May include business context');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `event_reason` SET TAGS ('dbx_regulatory_requirement' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `event_reason` SET TAGS ('dbx_editorial_decision_rationale' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `event_reason` SET TAGS ('dbx_or_technical_reason_Critical_for_audit_trail_and_compliance_documentation' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `event_reason` SET TAGS ('dbx_regulation' = 'FCC');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `event_reason` SET TAGS ('dbx_ENUM_REF_CANDIDATE' = 'promote-to-reference-product');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_column_comment_Precise_date_and_time_when_the_lifecycle_event_occurred_in_the_media_asset_management_workflow_Format' = 'yyyy-MM-ddTHH:mm:ss.SSSXXX. This is the EVENT_TIMESTAMP required for EVENT_LOG role.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_column_comment' = 'The size of the media file in bytes at the time of this lifecycle event. Used to track storage consumption');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_validate_successful_transfers' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_and_monitor_format_migration_efficiency' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `metadata_version` SET TAGS ('dbx_business_glossary_term' = 'Metadata Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `metadata_version` SET TAGS ('dbx_column_comment' = 'Version number of the assets descriptive metadata at the time of this lifecycle event. Incremented with each metadata_update event. Used to track metadata evolution and support rollback scenarios.');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `operator_identity` SET TAGS ('dbx_business_glossary_term' = 'Operator Identity');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `operator_identity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `operator_identity` SET TAGS ('dbx_column_comment' = 'The identity of the human operator or automated system that triggered or executed this lifecycle event. May be a user ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `operator_identity` SET TAGS ('dbx_system_account_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `operator_identity` SET TAGS ('dbx_or_automated_workflow_identifier_Used_for_accountability_and_audit_trail_purposes' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `qc_defect_count` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Defect Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `qc_defect_count` SET TAGS ('dbx_column_comment' = 'Number of quality defects identified during quality control inspection');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `qc_defect_count` SET TAGS ('dbx_applicable_for_qc_fail_events_Defects_may_include_video_artifacts' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `qc_defect_count` SET TAGS ('dbx_audio_issues' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `qc_defect_count` SET TAGS ('dbx_metadata_errors' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `qc_defect_count` SET TAGS ('dbx_or_format_compliance_violations' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `qc_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Score');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `qc_score` SET TAGS ('dbx_column_comment' = 'Numeric quality control score assigned during qc_pass or qc_fail events. Scale typically 0-100');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `qc_score` SET TAGS ('dbx_representing_technical_quality_assessment_of_video' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `qc_score` SET TAGS ('dbx_audio' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `qc_score` SET TAGS ('dbx_and_metadata_completeness_Used_to_track_asset_quality_metrics_over_time' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `source_system_code` SET TAGS ('dbx_normalized' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_remediated' = 'VREQ-063');
ALTER TABLE `vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
