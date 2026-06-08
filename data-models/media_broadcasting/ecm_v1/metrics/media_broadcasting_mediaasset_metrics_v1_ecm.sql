-- Metric views for domain: mediaasset | Business: Media Broadcasting | Version: 1 | Generated on: 2026-05-08 17:09:06

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`mediaasset_media_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core media asset inventory and storage metrics."
  source: "`media_broadcasting_ecm`.`mediaasset`.`media_asset`"
  dimensions:
    - name: "asset_class"
      expr: asset_class
      comment: "Classification of asset (e.g., Film, Series, Clip)."
    - name: "asset_type"
      expr: asset_type
      comment: "Technical type of asset (e.g., Video, Audio, Image)."
    - name: "storage_tier"
      expr: storage_tier
      comment: "Storage tier where asset resides (e.g., Hot, Cold)."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the asset."
    - name: "retention_policy_code"
      expr: retention_policy_code
      comment: "Retention policy identifier applied to asset."
    - name: "rights_restriction"
      expr: rights_restriction
      comment: "Rights restriction label."
    - name: "asset_title"
      expr: asset_title
      comment: "Human readable title of the asset."
  measures:
    - name: "total_assets"
      expr: COUNT(1)
      comment: "Total number of media assets."
    - name: "total_file_size_gb"
      expr: SUM(CAST(file_size_bytes AS DOUBLE)) / (1024*1024*1024)
      comment: "Aggregate file size of all assets in gigabytes."
    - name: "average_duration_seconds"
      expr: AVG(CAST(duration_seconds AS DOUBLE))
      comment: "Average duration of assets in seconds."
    - name: "legal_hold_asset_count"
      expr: SUM(CASE WHEN legal_hold_flag THEN 1 ELSE 0 END)
      comment: "Count of assets under legal hold."
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`mediaasset_asset_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Version-level metrics for media assets."
  source: "`media_broadcasting_ecm`.`mediaasset`.`asset_version`"
  dimensions:
    - name: "storage_tier"
      expr: storage_tier
      comment: "Storage tier for the version."
    - name: "version_status"
      expr: version_status
      comment: "Status of the version (e.g., Active, Deprecated)."
    - name: "video_codec"
      expr: video_codec
      comment: "Video codec used in the version."
    - name: "audio_codec"
      expr: audio_codec
      comment: "Audio codec used."
    - name: "resolution_width"
      expr: resolution_width
      comment: "Width resolution of the version."
    - name: "resolution_height"
      expr: resolution_height
      comment: "Height resolution of the version."
    - name: "drm_protection"
      expr: drm_protection
      comment: "Flag indicating DRM protection."
    - name: "created_timestamp"
      expr: created_timestamp
      comment: "Timestamp when version was created."
  measures:
    - name: "total_versions"
      expr: COUNT(1)
      comment: "Total number of asset versions."
    - name: "total_version_file_size_gb"
      expr: SUM(CAST(file_size_bytes AS DOUBLE)) / (1024*1024*1024)
      comment: "Total file size of versions in GB."
    - name: "average_version_duration_seconds"
      expr: AVG(CAST(duration_seconds AS DOUBLE))
      comment: "Average duration of versions."
    - name: "average_frame_rate"
      expr: AVG(CAST(frame_rate AS DOUBLE))
      comment: "Average frame rate across versions."
    - name: "distinct_version_numbers"
      expr: COUNT(DISTINCT version_number)
      comment: "Count of distinct version identifiers."
    - name: "drm_protected_version_count"
      expr: SUM(CASE WHEN drm_protection THEN 1 ELSE 0 END)
      comment: "Number of versions with DRM protection."
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`mediaasset_archive_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Archival activity and cost metrics."
  source: "`media_broadcasting_ecm`.`mediaasset`.`archive_record`"
  dimensions:
    - name: "archive_destination_type"
      expr: archive_destination_type
      comment: "Type of archive destination (e.g., Cloud, Tape)."
    - name: "archive_status"
      expr: archive_status
      comment: "Current status of archive record."
    - name: "storage_tier"
      expr: storage_tier
      comment: "Storage tier of archived data."
    - name: "archive_system_name"
      expr: archive_system_name
      comment: "System handling the archive."
    - name: "archive_date"
      expr: archive_date
      comment: "Date of archive operation."
  measures:
    - name: "archive_record_count"
      expr: COUNT(1)
      comment: "Number of archive records."
    - name: "total_archived_gb"
      expr: SUM(CAST(archive_file_size_bytes AS DOUBLE)) / (1024*1024*1024)
      comment: "Total archived data size in GB."
    - name: "total_archive_cost_usd"
      expr: SUM(archive_cost_per_gb * (CAST(archive_file_size_bytes AS DOUBLE) / (1024*1024*1024)))
      comment: "Total cost incurred for archiving in USD."
    - name: "average_archive_cost_per_gb"
      expr: AVG(CAST(archive_cost_per_gb AS DOUBLE))
      comment: "Average cost per GB for archiving."
    - name: "legal_hold_archive_count"
      expr: SUM(CASE WHEN legal_hold_flag THEN 1 ELSE 0 END)
      comment: "Count of archived items under legal hold."
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`mediaasset_asset_storage_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage assignment and cost per asset version."
  source: "`media_broadcasting_ecm`.`mediaasset`.`asset_storage_assignment`"
  dimensions:
    - name: "storage_tier"
      expr: storage_tier
      comment: "Storage tier assigned."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the storage assignment."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of storage location."
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Flag indicating legal hold on assignment."
    - name: "assignment_start_timestamp"
      expr: assignment_start_timestamp
      comment: "When assignment started."
  measures:
    - name: "storage_assignment_count"
      expr: COUNT(1)
      comment: "Number of storage assignments."
    - name: "total_assigned_storage_gb"
      expr: SUM(CAST(file_size_bytes AS DOUBLE)) / (1024*1024*1024)
      comment: "Total assigned storage size in GB."
    - name: "total_storage_cost_usd"
      expr: SUM(storage_cost_per_gb * (CAST(file_size_bytes AS DOUBLE) / (1024*1024*1024)))
      comment: "Total storage cost for assignments in USD."
    - name: "legal_hold_assignment_count"
      expr: SUM(CASE WHEN legal_hold_flag THEN 1 ELSE 0 END)
      comment: "Assignments under legal hold."
    - name: "distinct_replication_counts"
      expr: COUNT(DISTINCT replication_count)
      comment: "Number of distinct replication count values."
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`mediaasset_asset_access_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Access request activity for media assets."
  source: "`media_broadcasting_ecm`.`mediaasset`.`asset_access_request`"
  dimensions:
    - name: "access_type"
      expr: access_type
      comment: "Type of access granted (e.g., Download, Stream)."
    - name: "request_status"
      expr: request_status
      comment: "Current status of the request."
    - name: "request_source"
      expr: request_source
      comment: "Origin of the request (e.g., Internal, External)."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to request."
    - name: "request_timestamp"
      expr: request_timestamp
      comment: "Timestamp when request was made."
  measures:
    - name: "request_count"
      expr: COUNT(1)
      comment: "Total number of access requests."
    - name: "approval_required_count"
      expr: SUM(CASE WHEN approval_required THEN 1 ELSE 0 END)
      comment: "Number of requests requiring approval."
    - name: "drm_applied_count"
      expr: SUM(CASE WHEN drm_applied THEN 1 ELSE 0 END)
      comment: "Requests where DRM was applied."
    - name: "legal_hold_request_count"
      expr: SUM(CASE WHEN legal_hold_flag THEN 1 ELSE 0 END)
      comment: "Requests for assets under legal hold."
    - name: "watermark_applied_count"
      expr: SUM(CASE WHEN watermark_applied THEN 1 ELSE 0 END)
      comment: "Requests where watermark was applied."
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`mediaasset_qc_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality control inspection outcomes."
  source: "`media_broadcasting_ecm`.`mediaasset`.`qc_inspection`"
  dimensions:
    - name: "qc_type"
      expr: qc_type
      comment: "Type of QC performed."
    - name: "overall_result"
      expr: overall_result
      comment: "Overall pass/fail result."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Status of the inspection (e.g., Completed)."
    - name: "inspection_timestamp"
      expr: inspection_timestamp
      comment: "When inspection occurred."
  measures:
    - name: "inspection_count"
      expr: COUNT(1)
      comment: "Total QC inspections performed."
    - name: "passed_inspection_count"
      expr: SUM(CASE WHEN overall_result = 'PASS' THEN 1 ELSE 0 END)
      comment: "Number of inspections that passed."
    - name: "average_loudness_lufs"
      expr: AVG(CAST(loudness_lufs AS DOUBLE))
      comment: "Average loudness level in LUFS across inspections."
    - name: "black_frame_detected_count"
      expr: SUM(CASE WHEN black_frame_detected THEN 1 ELSE 0 END)
      comment: "Inspections where black frames were detected."
    - name: "freeze_frame_detected_count"
      expr: SUM(CASE WHEN freeze_frame_detected THEN 1 ELSE 0 END)
      comment: "Inspections where freeze frames were detected."
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`mediaasset_transcode_job`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transcoding job performance and cost."
  source: "`media_broadcasting_ecm`.`mediaasset`.`transcode_job`"
  dimensions:
    - name: "job_status"
      expr: job_status
      comment: "Current status of the transcode job."
    - name: "job_type"
      expr: job_type
      comment: "Type of transcode job (e.g., Full, Incremental)."
    - name: "source_format"
      expr: source_format
      comment: "Original format of source asset."
    - name: "processing_start_timestamp"
      expr: processing_start_timestamp
      comment: "When transcoding started."
  measures:
    - name: "transcode_job_count"
      expr: COUNT(1)
      comment: "Total number of transcode jobs executed."
    - name: "total_output_gb"
      expr: SUM(CAST(output_file_size_gb AS DOUBLE))
      comment: "Aggregate size of transcoded output in GB."
    - name: "total_cost_estimate_usd"
      expr: SUM(CAST(cost_estimate_usd AS DOUBLE))
      comment: "Sum of cost estimates for transcode jobs in USD."
    - name: "average_quality_score"
      expr: AVG(CAST(quality_validation_score AS DOUBLE))
      comment: "Average quality validation score across jobs."
    - name: "failed_job_count"
      expr: SUM(CASE WHEN job_status = 'FAILED' THEN 1 ELSE 0 END)
      comment: "Number of transcode jobs that failed."
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`mediaasset_deal_asset_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "License fee and exclusivity metrics for asset deals."
  source: "`media_broadcasting_ecm`.`mediaasset`.`deal_asset_license`"
  dimensions:
    - name: "rights_restrictions"
      expr: rights_restrictions
      comment: "Restrictions attached to the license."
    - name: "territory_code"
      expr: territory_code
      comment: "Geographic territory of the license."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current delivery status of licensed asset."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the license is exclusive."
  measures:
    - name: "license_count"
      expr: COUNT(1)
      comment: "Number of asset licenses."
    - name: "total_license_fee_usd"
      expr: SUM(CAST(license_fee_amount AS DOUBLE))
      comment: "Total license fee revenue in USD."
    - name: "exclusive_license_count"
      expr: SUM(CASE WHEN exclusivity_flag THEN 1 ELSE 0 END)
      comment: "Count of exclusive licenses."
    - name: "average_license_fee_usd"
      expr: AVG(CAST(license_fee_amount AS DOUBLE))
      comment: "Average license fee per license in USD."
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`mediaasset_format_migration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Format migration performance and quality."
  source: "`media_broadcasting_ecm`.`mediaasset`.`format_migration`"
  dimensions:
    - name: "migration_status"
      expr: migration_status
      comment: "Current status of migration (e.g., Completed, InProgress)."
    - name: "migration_type"
      expr: migration_type
      comment: "Type of migration (e.g., Re-encode, ContainerChange)."
    - name: "target_format"
      expr: target_format
      comment: "Target format after migration."
    - name: "migration_engine"
      expr: migration_engine
      comment: "Engine used for migration."
  measures:
    - name: "migration_count"
      expr: COUNT(1)
      comment: "Total number of format migrations."
    - name: "total_migration_seconds"
      expr: SUM(CAST(migration_duration_seconds AS DOUBLE))
      comment: "Cumulative migration duration in seconds."
    - name: "average_migration_seconds"
      expr: AVG(CAST(migration_duration_seconds AS DOUBLE))
      comment: "Average migration duration in seconds."
    - name: "total_source_size_gb"
      expr: SUM(CAST(source_file_size_bytes AS DOUBLE)) / (1024*1024*1024)
      comment: "Total source data size migrated in GB."
    - name: "total_target_size_gb"
      expr: SUM(CAST(target_file_size_bytes AS DOUBLE)) / (1024*1024*1024)
      comment: "Total target data size after migration in GB."
    - name: "average_quality_score"
      expr: AVG(CAST(quality_validation_score AS DOUBLE))
      comment: "Average quality validation score for migrations."
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`mediaasset_asset_collection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Collection-level aggregation and metadata completeness."
  source: "`media_broadcasting_ecm`.`mediaasset`.`asset_collection`"
  dimensions:
    - name: "collection_type"
      expr: collection_type
      comment: "Type of collection (e.g., Series, Playlist)."
    - name: "primary_genre"
      expr: primary_genre
      comment: "Primary genre of the collection."
    - name: "territory_code"
      expr: territory_code
      comment: "Geographic territory of collection."
    - name: "creation_date"
      expr: creation_date
      comment: "Date the collection was created."
  measures:
    - name: "collection_count"
      expr: COUNT(1)
      comment: "Total number of asset collections."
    - name: "total_collection_storage_gb"
      expr: SUM(CAST(total_storage_size_bytes AS DOUBLE)) / (1024*1024*1024)
      comment: "Aggregate storage size of collections in GB."
    - name: "total_collection_duration_seconds"
      expr: SUM(CAST(total_duration_seconds AS DOUBLE))
      comment: "Total duration of all assets in collections in seconds."
    - name: "legal_hold_collection_count"
      expr: SUM(CASE WHEN legal_hold_flag THEN 1 ELSE 0 END)
      comment: "Number of collections under legal hold."
    - name: "average_metadata_completeness_score"
      expr: AVG(CAST(metadata_completeness_score AS DOUBLE))
      comment: "Average metadata completeness score across collections."
$$;