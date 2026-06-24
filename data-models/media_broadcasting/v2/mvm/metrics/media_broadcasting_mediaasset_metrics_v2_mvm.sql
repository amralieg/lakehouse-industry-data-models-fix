-- Metric views for domain: mediaasset | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-23 04:34:26

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_media_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core media asset inventory and quality metrics. Tracks asset volume, storage footprint, duration, and quality completion rates to inform archive strategy, storage cost planning, and content readiness decisions."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`"
  dimensions:
    - name: "asset_class"
      expr: asset_class
      comment: "Classification of the media asset (e.g. master, proxy, archive) used to segment inventory by tier."
    - name: "codec"
      expr: codec
      comment: "Video codec of the media asset, used to track format distribution and plan transcoding migrations."
    - name: "resolution"
      expr: resolution
      comment: "Resolution of the media asset (e.g. 4K, HD, SD), used to segment storage and processing costs."
    - name: "originating_system"
      expr: originating_system
      comment: "Source system that originated the asset, used to trace provenance and ingest pipeline performance."
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Indicates whether the asset is under legal hold, critical for compliance and retention governance."
    - name: "rights_restriction"
      expr: rights_restriction
      comment: "Rights restriction category applied to the asset, used to segment distributable vs. restricted content."
    - name: "retention_expiry_year_month"
      expr: DATE_TRUNC('MONTH', retention_expiry_date)
      comment: "Month-level bucketing of retention expiry date, used to forecast upcoming asset expirations."
    - name: "ingest_year_month"
      expr: DATE_TRUNC('MONTH', ingest_timestamp)
      comment: "Month-level bucketing of ingest timestamp, used to track asset acquisition trends over time."
  measures:
    - name: "total_assets"
      expr: COUNT(DISTINCT media_asset_id)
      comment: "Total number of distinct media assets in the catalog. Baseline KPI for inventory size and growth tracking."
    - name: "total_storage_bytes"
      expr: SUM(CAST(file_size_bytes AS DOUBLE))
      comment: "Total storage consumed by all media assets in bytes. Directly drives storage cost forecasting and capacity planning."
    - name: "avg_asset_duration_seconds"
      expr: AVG(CAST(duration_seconds AS DOUBLE))
      comment: "Average duration of media assets in seconds. Informs encoding time estimates and storage tier sizing."
    - name: "total_content_duration_seconds"
      expr: SUM(CAST(duration_seconds AS DOUBLE))
      comment: "Total content duration across all assets in seconds. Measures the breadth of the content library for licensing and scheduling decisions."
    - name: "avg_bitrate_mbps"
      expr: AVG(CAST(bit_rate_mbps AS DOUBLE))
      comment: "Average bitrate of media assets in Mbps. Used to assess encoding quality standards and bandwidth requirements for distribution."
    - name: "legal_hold_asset_count"
      expr: COUNT(DISTINCT CASE WHEN legal_hold_flag = TRUE THEN media_asset_id END)
      comment: "Number of assets currently under legal hold. Critical compliance KPI monitored by legal and governance teams."
    - name: "qc_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN qc_completed_timestamp IS NOT NULL THEN media_asset_id END) / NULLIF(COUNT(DISTINCT media_asset_id), 0), 2)
      comment: "Percentage of assets that have completed QC inspection. Measures content readiness pipeline health and broadcast compliance posture."
    - name: "avg_file_size_gb"
      expr: ROUND(AVG(CAST(file_size_bytes AS DOUBLE)) / 1073741824.0, 4)
      comment: "Average file size per media asset in GB. Used to benchmark storage efficiency and detect anomalously large or small assets."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_ingest_job`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ingest pipeline performance and throughput metrics. Tracks data transfer volumes, transfer rates, job success rates, and ingest velocity to optimize ingestion infrastructure and SLA compliance."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job`"
  dimensions:
    - name: "codec"
      expr: codec
      comment: "Codec of the ingested content, used to segment ingest performance by format type."
    - name: "source_location"
      expr: source_location
      comment: "Origin location of the ingest source, used to identify slow or unreliable ingest paths."
    - name: "resolution"
      expr: resolution
      comment: "Resolution of the ingested asset, used to correlate file size and transfer rate with content quality tier."
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Indicates whether the ingested asset is under legal hold, used for compliance-aware ingest tracking."
    - name: "closed_caption_present"
      expr: closed_caption_present
      comment: "Whether closed captions were present in the ingested file, used to track accessibility compliance at ingest."
    - name: "ingest_start_year_month"
      expr: DATE_TRUNC('MONTH', ingest_start_timestamp)
      comment: "Month-level bucketing of ingest start time, used to analyze ingest volume trends over time."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Code identifying the upstream system that triggered the ingest, used to attribute pipeline load by source."
  measures:
    - name: "total_ingest_jobs"
      expr: COUNT(DISTINCT ingest_job_id)
      comment: "Total number of ingest jobs executed. Baseline throughput KPI for the ingest pipeline."
    - name: "total_bytes_transferred"
      expr: SUM(CAST(bytes_transferred AS DOUBLE))
      comment: "Total data volume transferred across all ingest jobs in bytes. Measures pipeline throughput and informs bandwidth capacity planning."
    - name: "avg_transfer_rate_mbps"
      expr: AVG(CAST(transfer_rate_mbps AS DOUBLE))
      comment: "Average transfer rate in Mbps across ingest jobs. Key SLA metric for ingest pipeline performance benchmarking."
    - name: "failed_ingest_job_count"
      expr: COUNT(DISTINCT CASE WHEN error_message IS NOT NULL THEN ingest_job_id END)
      comment: "Number of ingest jobs that encountered errors. Operational health KPI — elevated counts trigger infrastructure investigation."
    - name: "ingest_failure_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN error_message IS NOT NULL THEN ingest_job_id END) / NULLIF(COUNT(DISTINCT ingest_job_id), 0), 2)
      comment: "Percentage of ingest jobs that failed. Critical reliability KPI used to enforce ingest pipeline SLAs and prioritize engineering fixes."
    - name: "avg_ingest_duration_seconds"
      expr: AVG(CAST(duration_seconds AS DOUBLE))
      comment: "Average duration of ingested content in seconds. Used to correlate content length with ingest processing time and resource consumption."
    - name: "total_ingest_content_hours"
      expr: ROUND(SUM(CAST(duration_seconds AS DOUBLE)) / 3600.0, 2)
      comment: "Total hours of content ingested. Strategic KPI for content acquisition volume reporting to executives and rights teams."
    - name: "closed_caption_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN closed_caption_present = TRUE THEN ingest_job_id END) / NULLIF(COUNT(DISTINCT ingest_job_id), 0), 2)
      comment: "Percentage of ingest jobs where closed captions were present. Regulatory accessibility compliance KPI tracked against broadcast standards."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_transcode_job`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transcoding pipeline efficiency, cost, and quality metrics. Tracks job throughput, processing cost, quality validation outcomes, and file size transformation ratios to optimize encoding infrastructure spend and output quality."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job`"
  dimensions:
    - name: "source_codec"
      expr: source_codec
      comment: "Codec of the source file being transcoded, used to segment performance and cost by input format."
    - name: "source_resolution"
      expr: source_resolution
      comment: "Resolution of the source file, used to analyze transcoding complexity and cost by input quality tier."
    - name: "transcoding_engine"
      expr: transcoding_engine
      comment: "Transcoding engine used for the job, used to compare performance and cost across encoding platforms."
    - name: "job_priority"
      expr: job_priority
      comment: "Priority level assigned to the transcode job, used to analyze SLA adherence by priority tier."
    - name: "quality_validation_result"
      expr: quality_validation_result
      comment: "Outcome of quality validation for the transcode output, used to segment jobs by pass/fail status."
    - name: "migration_reason"
      expr: migration_reason
      comment: "Reason for the transcode/migration job, used to categorize jobs by business driver (e.g. format refresh, distribution prep)."
    - name: "processing_start_year_month"
      expr: DATE_TRUNC('MONTH', processing_start_timestamp)
      comment: "Month-level bucketing of processing start time, used to track transcode volume and cost trends over time."
  measures:
    - name: "total_transcode_jobs"
      expr: COUNT(DISTINCT transcode_job_id)
      comment: "Total number of transcode jobs executed. Baseline throughput KPI for the encoding pipeline."
    - name: "total_transcode_cost_usd"
      expr: SUM(CAST(cost_estimate_usd AS DOUBLE))
      comment: "Total estimated cost of all transcode jobs in USD. Primary financial KPI for encoding infrastructure spend management."
    - name: "avg_transcode_cost_usd"
      expr: AVG(CAST(cost_estimate_usd AS DOUBLE))
      comment: "Average cost per transcode job in USD. Used to benchmark encoding efficiency and detect cost anomalies by engine or format."
    - name: "avg_quality_validation_score"
      expr: AVG(CAST(quality_validation_score AS DOUBLE))
      comment: "Average quality validation score across transcode jobs. Measures output quality consistency and informs encoder configuration decisions."
    - name: "quality_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN quality_validation_result = 'PASS' THEN transcode_job_id END) / NULLIF(COUNT(DISTINCT transcode_job_id), 0), 2)
      comment: "Percentage of transcode jobs that passed quality validation. Critical broadcast readiness KPI — low rates trigger encoder tuning or source asset review."
    - name: "total_output_file_size_gb"
      expr: SUM(CAST(output_file_size_gb AS DOUBLE))
      comment: "Total output storage generated by transcode jobs in GB. Drives storage capacity planning for encoded asset repositories."
    - name: "avg_compression_ratio"
      expr: ROUND(AVG(CAST(source_file_size_gb AS DOUBLE) / NULLIF(CAST(output_file_size_gb AS DOUBLE), 0)), 4)
      comment: "Average compression ratio (source size / output size) across transcode jobs. Measures encoding efficiency — higher ratios indicate better storage savings."
    - name: "failed_transcode_job_count"
      expr: COUNT(DISTINCT CASE WHEN error_message IS NOT NULL THEN transcode_job_id END)
      comment: "Number of transcode jobs that encountered errors. Operational reliability KPI used to monitor encoding pipeline health and SLA compliance."
    - name: "avg_source_bitrate_mbps"
      expr: AVG(CAST(source_bitrate_mbps AS DOUBLE))
      comment: "Average bitrate of source files submitted for transcoding in Mbps. Used to characterize the quality profile of content entering the encoding pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_qc_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality control inspection outcomes and AI confidence metrics. Tracks pass/fail rates, defect detection, loudness compliance, and AI engine confidence to govern broadcast readiness and regulatory compliance."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection`"
  dimensions:
    - name: "overall_result"
      expr: overall_result
      comment: "Overall QC inspection result (e.g. PASS, FAIL, REVIEW), used to segment assets by broadcast readiness status."
    - name: "qc_tool_name"
      expr: qc_tool_name
      comment: "Name of the QC tool used for inspection, used to compare performance and accuracy across QC platforms."
    - name: "ai_qc_engine_version"
      expr: ai_qc_engine_version
      comment: "Version of the AI QC engine, used to track quality improvements across engine releases."
    - name: "loudness_compliance_result"
      expr: loudness_compliance_result
      comment: "Result of loudness compliance check (e.g. PASS, FAIL), used to monitor regulatory audio standards adherence."
    - name: "black_frame_detected"
      expr: black_frame_detected
      comment: "Whether black frames were detected during inspection, used to flag content quality issues."
    - name: "freeze_frame_detected"
      expr: freeze_frame_detected
      comment: "Whether freeze frames were detected during inspection, used to identify encoding or capture defects."
    - name: "video_codec_compliance_result"
      expr: video_codec_compliance_result
      comment: "Result of video codec compliance check, used to ensure assets meet broadcast delivery specifications."
    - name: "inspection_year_month"
      expr: DATE_TRUNC('MONTH', inspection_timestamp)
      comment: "Month-level bucketing of inspection timestamp, used to track QC throughput and pass rate trends over time."
  measures:
    - name: "total_inspections"
      expr: COUNT(DISTINCT qc_inspection_id)
      comment: "Total number of QC inspections performed. Baseline throughput KPI for the quality control pipeline."
    - name: "qc_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN overall_result = 'PASS' THEN qc_inspection_id END) / NULLIF(COUNT(DISTINCT qc_inspection_id), 0), 2)
      comment: "Percentage of QC inspections that passed. Primary broadcast readiness KPI — declines trigger content quality investigations and encoder reviews."
    - name: "avg_ai_confidence_score"
      expr: AVG(CAST(ai_confidence_score AS DOUBLE))
      comment: "Average AI confidence score across QC inspections. Measures reliability of automated QC decisions — low scores indicate need for human review escalation."
    - name: "avg_loudness_lufs"
      expr: AVG(CAST(loudness_lufs AS DOUBLE))
      comment: "Average loudness level in LUFS across inspected assets. Regulatory compliance KPI for broadcast audio standards (e.g. EBU R128, ATSC A/85)."
    - name: "loudness_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN loudness_compliance_result = 'PASS' THEN qc_inspection_id END) / NULLIF(COUNT(DISTINCT qc_inspection_id), 0), 2)
      comment: "Percentage of inspections passing loudness compliance. Regulatory KPI directly tied to broadcast license obligations and viewer experience standards."
    - name: "black_frame_detection_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN black_frame_detected = TRUE THEN qc_inspection_id END) / NULLIF(COUNT(DISTINCT qc_inspection_id), 0), 2)
      comment: "Percentage of inspections where black frames were detected. Content quality KPI used to identify systematic capture or encoding defects."
    - name: "freeze_frame_detection_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN freeze_frame_detected = TRUE THEN qc_inspection_id END) / NULLIF(COUNT(DISTINCT qc_inspection_id), 0), 2)
      comment: "Percentage of inspections where freeze frames were detected. Encoding defect KPI used to prioritize re-transcode or re-capture workflows."
    - name: "avg_detected_aspect_ratio"
      expr: AVG(CAST(detected_aspect_ratio AS DOUBLE))
      comment: "Average detected aspect ratio across inspected assets. Used to verify format compliance against delivery specifications."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_asset_storage_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage assignment cost, utilization, and compliance metrics. Tracks storage spend, replication coverage, legal hold exposure, and assignment lifecycle to optimize storage tier strategy and governance."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment`"
  dimensions:
    - name: "access_frequency"
      expr: access_frequency
      comment: "Access frequency tier of the stored asset (e.g. hot, warm, cold), used to optimize storage tier assignments and cost."
    - name: "checksum_algorithm"
      expr: checksum_algorithm
      comment: "Checksum algorithm used for integrity verification, used to audit storage integrity practices across locations."
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Indicates whether the storage assignment is under legal hold, critical for compliance and eDiscovery cost tracking."
    - name: "migration_trigger"
      expr: migration_trigger
      comment: "Reason that triggered a storage migration, used to analyze migration drivers and plan future storage transitions."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source system that created the storage assignment, used to attribute storage costs by originating system."
    - name: "assignment_start_year_month"
      expr: DATE_TRUNC('MONTH', assignment_start_date)
      comment: "Month-level bucketing of assignment start date, used to track storage assignment growth trends over time."
  measures:
    - name: "total_storage_assignments"
      expr: COUNT(DISTINCT asset_storage_assignment_id)
      comment: "Total number of active storage assignments. Baseline KPI for storage inventory breadth and replication coverage."
    - name: "total_stored_file_size_bytes"
      expr: SUM(CAST(file_size_bytes AS DOUBLE))
      comment: "Total file size of all stored assets in bytes. Primary storage capacity KPI used for infrastructure planning and cost forecasting."
    - name: "total_storage_cost_per_gb"
      expr: SUM(CAST(storage_cost_per_gb AS DOUBLE))
      comment: "Sum of storage cost rates across all assignments (per GB). Used to benchmark total storage spend exposure and identify high-cost storage locations."
    - name: "avg_storage_cost_per_gb"
      expr: AVG(CAST(storage_cost_per_gb AS DOUBLE))
      comment: "Average storage cost per GB across all assignments. Used to compare cost efficiency across storage tiers and vendors."
    - name: "legal_hold_assignment_count"
      expr: COUNT(DISTINCT CASE WHEN legal_hold_flag = TRUE THEN asset_storage_assignment_id END)
      comment: "Number of storage assignments currently under legal hold. Compliance KPI monitored by legal and records management teams to assess eDiscovery exposure."
    - name: "legal_hold_storage_bytes"
      expr: SUM(CAST(CASE WHEN legal_hold_flag = TRUE THEN file_size_bytes ELSE 0 END AS DOUBLE))
      comment: "Total storage bytes consumed by assets under legal hold. Financial compliance KPI quantifying the cost of legal hold obligations."
    - name: "avg_checksum_value"
      expr: AVG(CAST(checksum_value AS DOUBLE))
      comment: "Average checksum value across storage assignments. Used as a data integrity health indicator — significant deviations may signal corruption or tampering."
    - name: "distinct_assets_stored"
      expr: COUNT(DISTINCT media_asset_id)
      comment: "Number of distinct media assets with at least one storage assignment. Measures storage coverage of the asset catalog."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_asset_lifecycle_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset lifecycle event tracking and compliance metrics. Monitors event volumes, QC scores, compliance flags, file size changes, and audit trail coverage to govern asset state transitions and regulatory obligations."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event`"
  dimensions:
    - name: "event_reason"
      expr: event_reason
      comment: "Business reason for the lifecycle event (e.g. ingest, archive, delete, restore), used to segment event volumes by operational driver."
    - name: "approval_authority"
      expr: approval_authority
      comment: "Authority that approved the lifecycle event, used to audit governance and approval workflow compliance."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether the lifecycle event was flagged for compliance review, used to monitor regulatory risk exposure."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source system that generated the lifecycle event, used to attribute event volumes and compliance flags by system."
    - name: "operator_identity"
      expr: operator_identity
      comment: "Identity of the operator who performed the lifecycle action, used for audit and accountability tracking."
    - name: "event_year_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month-level bucketing of event timestamp, used to analyze lifecycle event trends and compliance flag rates over time."
  measures:
    - name: "total_lifecycle_events"
      expr: COUNT(DISTINCT asset_lifecycle_event_id)
      comment: "Total number of asset lifecycle events recorded. Baseline operational KPI for asset state transition activity."
    - name: "compliance_flagged_event_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_flag = TRUE THEN asset_lifecycle_event_id END)
      comment: "Number of lifecycle events flagged for compliance review. Regulatory risk KPI — elevated counts trigger compliance team investigation and remediation."
    - name: "compliance_flag_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN compliance_flag = TRUE THEN asset_lifecycle_event_id END) / NULLIF(COUNT(DISTINCT asset_lifecycle_event_id), 0), 2)
      comment: "Percentage of lifecycle events flagged for compliance. Governance health KPI used to assess regulatory risk posture across asset operations."
    - name: "avg_qc_score"
      expr: AVG(CAST(qc_score AS DOUBLE))
      comment: "Average QC score recorded at lifecycle event time. Tracks quality trajectory of assets through their lifecycle stages."
    - name: "total_event_file_size_bytes"
      expr: SUM(CAST(file_size_bytes AS DOUBLE))
      comment: "Total file size associated with lifecycle events in bytes. Used to quantify storage impact of lifecycle operations (e.g. archive, migration)."
    - name: "avg_event_duration_milliseconds"
      expr: AVG(CAST(event_duration_milliseconds AS DOUBLE))
      comment: "Average duration of lifecycle event processing in milliseconds. Operational efficiency KPI for lifecycle pipeline performance monitoring."
    - name: "distinct_assets_with_events"
      expr: COUNT(DISTINCT media_asset_id)
      comment: "Number of distinct media assets that have recorded lifecycle events. Measures lifecycle pipeline coverage across the asset catalog."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_storage_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage infrastructure capacity, utilization, and cost metrics. Tracks capacity headroom, utilization rates, cost per TB, and operational status to inform storage procurement, decommissioning, and vendor management decisions."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`storage_location`"
  dimensions:
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the storage location, used to analyze capacity and cost distribution across regions."
    - name: "storage_vendor"
      expr: storage_vendor
      comment: "Storage vendor name, used to compare cost, capacity, and reliability across vendor contracts."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the storage location (e.g. active, degraded, decommissioned), used to filter capacity planning views."
    - name: "data_center_name"
      expr: data_center_name
      comment: "Name of the data center hosting the storage location, used to aggregate capacity and cost by facility."
    - name: "encryption_enabled"
      expr: encryption_enabled
      comment: "Whether encryption is enabled on the storage location, used to audit security compliance across storage infrastructure."
    - name: "replication_enabled"
      expr: replication_enabled
      comment: "Whether replication is enabled on the storage location, used to assess disaster recovery coverage."
    - name: "legal_hold_capable"
      expr: legal_hold_capable
      comment: "Whether the storage location supports legal hold, used to ensure compliance-capable storage capacity is sufficient."
  measures:
    - name: "total_provisioned_capacity_tb"
      expr: SUM(CAST(total_capacity_tb AS DOUBLE))
      comment: "Total provisioned storage capacity in TB across all locations. Primary infrastructure KPI for capacity planning and procurement decisions."
    - name: "total_used_capacity_tb"
      expr: SUM(CAST(used_capacity_tb AS DOUBLE))
      comment: "Total used storage capacity in TB across all locations. Tracks actual storage consumption against provisioned capacity."
    - name: "total_available_capacity_tb"
      expr: SUM(CAST(available_capacity_tb AS DOUBLE))
      comment: "Total available (free) storage capacity in TB. Critical capacity headroom KPI — low values trigger procurement or migration actions."
    - name: "avg_utilization_rate_pct"
      expr: ROUND(100.0 * AVG(CAST(used_capacity_tb AS DOUBLE) / NULLIF(CAST(total_capacity_tb AS DOUBLE), 0)), 2)
      comment: "Average storage utilization rate as a percentage of total capacity. Infrastructure efficiency KPI used to identify over- or under-provisioned locations."
    - name: "avg_cost_per_tb_per_month"
      expr: AVG(CAST(cost_per_tb_per_month AS DOUBLE))
      comment: "Average storage cost per TB per month across all locations. Financial benchmarking KPI used in vendor negotiations and storage tier optimization."
    - name: "total_monthly_storage_cost_usd"
      expr: SUM(CAST(used_capacity_tb AS DOUBLE) * CAST(cost_per_tb_per_month AS DOUBLE))
      comment: "Estimated total monthly storage cost in USD (used TB × cost per TB per month). Primary financial KPI for storage budget management and cost allocation."
    - name: "avg_restore_time_objective_hours"
      expr: AVG(CAST(restore_time_objective_hours AS DOUBLE))
      comment: "Average restore time objective in hours across storage locations. Disaster recovery SLA KPI used to assess business continuity posture."
    - name: "encryption_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN encryption_enabled = TRUE THEN storage_location_id END) / NULLIF(COUNT(DISTINCT storage_location_id), 0), 2)
      comment: "Percentage of storage locations with encryption enabled. Security compliance KPI monitored against data protection policies and regulatory requirements."
$$;