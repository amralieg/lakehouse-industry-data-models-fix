-- Metric views for domain: mediaasset | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-22 23:42:33

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_media_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core media asset inventory and quality metrics. Tracks asset volume, storage footprint, duration, bitrate efficiency, and legal hold exposure — key inputs for MAM capacity planning, rights compliance, and archive cost management."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`media_asset`"
  dimensions:
    - name: "asset_type"
      expr: asset_type_id
      comment: "FK to asset_type reference — segments assets by type (video, audio, image, document) for inventory analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status_id
      comment: "FK to mediaasset_lifecycle_status — segments assets by current lifecycle stage (active, archived, purged) for operational triage."
    - name: "storage_tier"
      expr: storage_tier_id
      comment: "FK to mediaasset_storage_tier — segments assets by hot/warm/cold/archive tier for cost and SLA analysis."
    - name: "content_classification"
      expr: content_classification_id
      comment: "FK to content_classification — segments assets by content class (original, acquired, UGC) for rights and cost attribution."
    - name: "hdr_format"
      expr: hdr_format_id
      comment: "FK to mediaasset_hdr_format — segments assets by HDR standard (SDR, HDR10, Dolby Vision) for technical inventory reporting."
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Boolean flag indicating whether the asset is under legal hold — critical for compliance and purge eligibility analysis."
    - name: "ingest_month"
      expr: DATE_TRUNC('MONTH', ingest_timestamp)
      comment: "Month of asset ingest — enables trend analysis of ingest volume and storage growth over time."
    - name: "retention_expiry_month"
      expr: DATE_TRUNC('MONTH', retention_expiry_date)
      comment: "Month when retention expires — supports proactive purge scheduling and storage reclamation planning."
  measures:
    - name: "total_asset_count"
      expr: COUNT(1)
      comment: "Total number of media assets in inventory. Baseline KPI for MAM capacity and growth tracking."
    - name: "total_storage_bytes"
      expr: SUM(CAST(file_size_bytes AS DOUBLE))
      comment: "Total storage footprint in bytes across all assets. Drives storage cost forecasting and capacity planning decisions."
    - name: "avg_asset_duration_seconds"
      expr: AVG(CAST(duration_seconds AS DOUBLE))
      comment: "Average duration of media assets in seconds. Indicates content depth and informs transcode cost estimation."
    - name: "total_duration_seconds"
      expr: SUM(CAST(duration_seconds AS DOUBLE))
      comment: "Total content duration in seconds across all assets. Key metric for content library depth and licensing valuation."
    - name: "avg_bitrate_mbps"
      expr: AVG(CAST(bit_rate_mbps AS DOUBLE))
      comment: "Average bitrate in Mbps across assets. Signals encoding quality standards and storage efficiency trade-offs."
    - name: "legal_hold_asset_count"
      expr: COUNT(CASE WHEN legal_hold_flag = TRUE THEN 1 END)
      comment: "Number of assets currently under legal hold. Directly informs legal risk exposure and purge eligibility."
    - name: "distinct_asset_types"
      expr: COUNT(DISTINCT asset_type_id)
      comment: "Number of distinct asset types in inventory. Measures breadth of the asset library for strategic planning."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_ingest_job`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ingest pipeline performance and throughput metrics. Tracks job success rates, transfer speeds, data volumes ingested, and error rates — essential for MAM operations, SLA compliance, and pipeline capacity management."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`ingest_job`"
  dimensions:
    - name: "job_status"
      expr: job_status_id
      comment: "FK to job_status — segments ingest jobs by outcome (completed, failed, in-progress) for SLA and error analysis."
    - name: "ingest_source_type"
      expr: ingest_source_type_id
      comment: "FK to mediaasset_ingest_source_type — segments by ingest origin (satellite, FTP, cloud, tape) for pipeline performance benchmarking."
    - name: "priority_level"
      expr: priority_level_id
      comment: "FK to mediaasset_priority_level — segments jobs by priority tier for SLA adherence analysis."
    - name: "hdr_format"
      expr: hdr_format_id
      comment: "FK to mediaasset_hdr_format — segments ingest jobs by HDR format for technical quality tracking."
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Boolean indicating whether ingested asset is under legal hold — flags compliance-sensitive ingest events."
    - name: "ingest_start_month"
      expr: DATE_TRUNC('MONTH', ingest_start_timestamp)
      comment: "Month of ingest job start — enables monthly throughput trend analysis."
    - name: "closed_caption_present"
      expr: closed_caption_present
      comment: "Boolean indicating presence of closed captions at ingest — supports accessibility compliance tracking."
  measures:
    - name: "total_ingest_jobs"
      expr: COUNT(1)
      comment: "Total number of ingest jobs executed. Baseline throughput KPI for pipeline capacity planning."
    - name: "total_bytes_transferred"
      expr: SUM(CAST(bytes_transferred AS DOUBLE))
      comment: "Total data volume transferred in bytes across all ingest jobs. Drives network bandwidth and storage provisioning decisions."
    - name: "avg_transfer_rate_mbps"
      expr: AVG(CAST(transfer_rate_mbps AS DOUBLE))
      comment: "Average ingest transfer rate in Mbps. Key SLA metric for ingest pipeline performance benchmarking."
    - name: "avg_ingest_duration_seconds"
      expr: AVG(CAST(duration_seconds AS DOUBLE))
      comment: "Average content duration ingested per job in seconds. Informs transcode queue sizing and downstream processing load."
    - name: "failed_ingest_job_count"
      expr: COUNT(CASE WHEN error_code_id IS NOT NULL THEN 1 END)
      comment: "Number of ingest jobs with an error code. Directly measures pipeline reliability and triggers operational intervention."
    - name: "total_ingest_content_duration_seconds"
      expr: SUM(CAST(duration_seconds AS DOUBLE))
      comment: "Total content duration ingested in seconds. Measures ingest pipeline throughput in content terms for scheduling and rights tracking."
    - name: "avg_frame_rate"
      expr: AVG(CAST(frame_rate AS DOUBLE))
      comment: "Average frame rate of ingested content. Signals technical quality consistency and format compliance across ingest sources."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_transcode_job`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transcoding pipeline efficiency and cost metrics. Tracks job throughput, cost per job, quality validation outcomes, and failure rates — critical for optimising transcode infrastructure spend and delivery SLA compliance."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`transcode_job`"
  dimensions:
    - name: "job_status"
      expr: job_status_id
      comment: "FK to job_status — segments transcode jobs by outcome (completed, failed, queued) for SLA and error analysis."
    - name: "job_type"
      expr: job_type_id
      comment: "FK to job_type — segments by transcode type (proxy, mezzanine, delivery, ABR) for cost and throughput benchmarking."
    - name: "source_format"
      expr: source_format_id
      comment: "FK to mediaasset_source_format — segments by input format for format migration cost analysis."
    - name: "target_format_specification"
      expr: target_format_specification_id
      comment: "FK to format_specification — segments by output specification for delivery compliance tracking."
    - name: "processing_start_month"
      expr: DATE_TRUNC('MONTH', processing_start_timestamp)
      comment: "Month of transcode job start — enables monthly cost and throughput trend analysis."
  measures:
    - name: "total_transcode_jobs"
      expr: COUNT(1)
      comment: "Total number of transcode jobs executed. Baseline throughput KPI for transcode farm capacity planning."
    - name: "total_transcode_cost_usd"
      expr: SUM(CAST(cost_estimate_usd AS DOUBLE))
      comment: "Total estimated transcode cost in USD. Primary financial KPI for cloud/on-prem transcode infrastructure spend management."
    - name: "avg_transcode_cost_usd"
      expr: AVG(CAST(cost_estimate_usd AS DOUBLE))
      comment: "Average cost per transcode job in USD. Benchmarks unit economics of transcoding across job types and formats."
    - name: "total_output_file_size_gb"
      expr: SUM(CAST(output_file_size_gb AS DOUBLE))
      comment: "Total output storage generated by transcode jobs in GB. Drives downstream storage provisioning and CDN cost forecasting."
    - name: "avg_output_file_size_gb"
      expr: AVG(CAST(output_file_size_gb AS DOUBLE))
      comment: "Average output file size per transcode job in GB. Informs storage tier allocation and delivery bandwidth planning."
    - name: "failed_transcode_job_count"
      expr: COUNT(CASE WHEN error_code_id IS NOT NULL THEN 1 END)
      comment: "Number of transcode jobs with an error code. Measures pipeline reliability and triggers infrastructure or workflow intervention."
    - name: "avg_source_bitrate_mbps"
      expr: AVG(CAST(source_bitrate_mbps AS DOUBLE))
      comment: "Average source bitrate in Mbps across transcode jobs. Informs input quality standards and transcode complexity estimation."
    - name: "avg_quality_validation_score"
      expr: AVG(CAST(quality_validation_score AS DOUBLE))
      comment: "Average quality validation score across completed transcode jobs. Key quality KPI for delivery readiness and SLA compliance."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_qc_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality control inspection outcomes and defect metrics. Tracks pass/fail rates, defect volumes, AI confidence, and loudness compliance — essential for delivery quality assurance, SLA adherence, and broadcast standards compliance."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`qc_inspection`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status_id
      comment: "FK to inspection_status — segments QC results by pass/fail/conditional for quality trend analysis."
    - name: "approval_status"
      expr: approval_status_id
      comment: "FK to mediaasset_approval_status — segments by approval outcome for delivery readiness tracking."
    - name: "qc_type"
      expr: qc_type_id
      comment: "FK to mediaasset_qc_type — segments by QC type (automated, manual, AI-assisted) for process efficiency analysis."
    - name: "hdr_format"
      expr: hdr_format_id
      comment: "FK to mediaasset_hdr_format — segments QC results by HDR format for technical compliance tracking."
    - name: "black_frame_detected"
      expr: black_frame_detected
      comment: "Boolean flag for black frame detection — segments inspections by a critical broadcast defect type."
    - name: "freeze_frame_detected"
      expr: freeze_frame_detected
      comment: "Boolean flag for freeze frame detection — segments inspections by another critical broadcast defect type."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_timestamp)
      comment: "Month of QC inspection — enables monthly quality trend and defect rate analysis."
  measures:
    - name: "total_qc_inspections"
      expr: COUNT(1)
      comment: "Total number of QC inspections performed. Baseline throughput KPI for QC pipeline capacity and workload management."
    - name: "avg_loudness_lufs"
      expr: AVG(CAST(loudness_lufs AS DOUBLE))
      comment: "Average loudness level in LUFS across inspected assets. Directly measures broadcast loudness standard compliance (EBU R128 / ATSC A/85)."
    - name: "avg_ai_confidence_score"
      expr: AVG(CAST(ai_confidence_score AS DOUBLE))
      comment: "Average AI QC engine confidence score. Measures reliability of automated QC and informs when human review escalation is needed."
    - name: "black_frame_detection_count"
      expr: COUNT(CASE WHEN black_frame_detected = TRUE THEN 1 END)
      comment: "Number of inspections where black frames were detected. Critical broadcast defect KPI driving re-transcode or re-ingest decisions."
    - name: "freeze_frame_detection_count"
      expr: COUNT(CASE WHEN freeze_frame_detected = TRUE THEN 1 END)
      comment: "Number of inspections where freeze frames were detected. Critical broadcast defect KPI for delivery quality assurance."
    - name: "approved_inspection_count"
      expr: COUNT(CASE WHEN approval_status_id IS NOT NULL THEN 1 END)
      comment: "Number of QC inspections that reached an approval decision. Measures QC pipeline throughput and delivery readiness velocity."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_archive_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Archive operations cost, compliance, and restore readiness metrics. Tracks archive storage costs, OAIS compliance, legal hold exposure, and restore SLA adherence — critical for long-term asset preservation governance and cost management."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`archive_record`"
  dimensions:
    - name: "archive_status"
      expr: archive_status_id
      comment: "FK to archive_status — segments archive records by current status (archived, restoring, purged) for operational triage."
    - name: "archive_destination_type"
      expr: archive_destination_type_id
      comment: "FK to archive_destination_type — segments by destination (LTO tape, cloud vault, offsite) for cost and risk analysis."
    - name: "archive_format"
      expr: archive_format_id
      comment: "FK to archive_format — segments by archive format for format migration planning."
    - name: "storage_tier"
      expr: storage_tier_id
      comment: "FK to mediaasset_storage_tier — segments archive records by storage tier for cost attribution."
    - name: "restore_sla_tier"
      expr: restore_sla_tier_id
      comment: "FK to restore_sla_tier — segments by restore SLA commitment for SLA compliance monitoring."
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Boolean indicating whether archived asset is under legal hold — critical for purge eligibility and compliance reporting."
    - name: "oais_compliance_flag"
      expr: oais_compliance_flag
      comment: "Boolean indicating OAIS (Open Archival Information System) compliance — key governance metric for long-term preservation standards."
    - name: "archive_month"
      expr: DATE_TRUNC('MONTH', archive_date)
      comment: "Month of archival — enables trend analysis of archive volume and cost growth."
    - name: "purge_scheduled_month"
      expr: DATE_TRUNC('MONTH', purge_scheduled_date)
      comment: "Month when purge is scheduled — supports proactive storage reclamation planning."
  measures:
    - name: "total_archive_records"
      expr: COUNT(1)
      comment: "Total number of archive records. Baseline KPI for archive inventory size and growth tracking."
    - name: "total_archive_file_size_bytes"
      expr: SUM(CAST(archive_file_size_bytes AS DOUBLE))
      comment: "Total archived storage footprint in bytes. Primary cost driver for long-term preservation budget planning."
    - name: "avg_archive_cost_per_gb"
      expr: AVG(CAST(archive_cost_per_gb AS DOUBLE))
      comment: "Average archive cost per GB. Benchmarks storage vendor pricing and informs tier migration decisions."
    - name: "total_archive_cost"
      expr: SUM(CAST(archive_cost_per_gb AS DOUBLE))
      comment: "Sum of archive cost-per-GB values as a proxy for total archive cost exposure. Drives archive budget forecasting."
    - name: "legal_hold_archive_count"
      expr: COUNT(CASE WHEN legal_hold_flag = TRUE THEN 1 END)
      comment: "Number of archived assets under legal hold. Measures legal risk exposure and blocks premature purge of legally sensitive content."
    - name: "oais_compliant_archive_count"
      expr: COUNT(CASE WHEN oais_compliance_flag = TRUE THEN 1 END)
      comment: "Number of archive records meeting OAIS compliance standards. Measures preservation governance quality for regulatory and audit purposes."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_asset_storage_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage assignment efficiency and cost metrics. Tracks storage utilisation, cost per GB, legal hold exposure, and assignment lifecycle — essential for storage capacity planning, cost optimisation, and compliance governance."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`asset_storage_assignment`"
  dimensions:
    - name: "storage_tier"
      expr: storage_tier_id
      comment: "FK to mediaasset_storage_tier — segments assignments by hot/warm/cold/archive tier for cost and SLA analysis."
    - name: "assignment_status"
      expr: assignment_status_id
      comment: "FK to mediaasset_assignment_status — segments by assignment state (active, migrating, expired) for operational triage."
    - name: "verification_status"
      expr: verification_status_id
      comment: "FK to mediaasset_verification_status — segments by checksum verification outcome for data integrity monitoring."
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Boolean indicating whether the stored asset is under legal hold — critical for purge eligibility and compliance reporting."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of storage location — enables regional cost and compliance analysis (data sovereignty)."
    - name: "assignment_start_month"
      expr: DATE_TRUNC('MONTH', assignment_start_date)
      comment: "Month of storage assignment start — enables trend analysis of storage growth and tier migration activity."
  measures:
    - name: "total_storage_assignments"
      expr: COUNT(1)
      comment: "Total number of active storage assignments. Baseline KPI for storage inventory and assignment lifecycle management."
    - name: "total_stored_file_size_bytes"
      expr: SUM(CAST(file_size_bytes AS DOUBLE))
      comment: "Total storage footprint in bytes across all assignments. Primary input for storage capacity planning and cost forecasting."
    - name: "avg_storage_cost_per_gb"
      expr: AVG(CAST(storage_cost_per_gb AS DOUBLE))
      comment: "Average storage cost per GB across assignments. Benchmarks storage vendor pricing and informs tier migration ROI decisions."
    - name: "total_storage_cost"
      expr: SUM(CAST(storage_cost_per_gb AS DOUBLE))
      comment: "Sum of storage cost-per-GB values as a proxy for total storage cost exposure. Drives storage budget forecasting."
    - name: "legal_hold_assignment_count"
      expr: COUNT(CASE WHEN legal_hold_flag = TRUE THEN 1 END)
      comment: "Number of storage assignments under legal hold. Measures compliance exposure and blocks premature deletion of legally sensitive assets."
    - name: "distinct_storage_locations"
      expr: COUNT(DISTINCT storage_location_id)
      comment: "Number of distinct storage locations in use. Measures storage infrastructure diversity and informs consolidation decisions."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_storage_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage infrastructure capacity and utilisation metrics. Tracks total vs used vs available capacity, cost per TB, and replication coverage — essential for infrastructure capacity planning, cost management, and SLA governance."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`storage_location`"
  dimensions:
    - name: "storage_tier"
      expr: storage_tier_id
      comment: "FK to mediaasset_storage_tier — segments locations by hot/warm/cold/archive tier for cost and performance analysis."
    - name: "storage_type"
      expr: storage_type_id
      comment: "FK to storage_type — segments by storage technology (NAS, SAN, object, tape) for infrastructure planning."
    - name: "sla_tier"
      expr: sla_tier_id
      comment: "FK to mediaasset_sla_tier — segments locations by SLA commitment for restore time objective compliance monitoring."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the storage location — enables regional capacity and cost analysis including data sovereignty compliance."
    - name: "replication_enabled"
      expr: replication_enabled
      comment: "Boolean indicating whether replication is enabled — segments locations by resilience posture for DR planning."
    - name: "encryption_enabled"
      expr: encryption_enabled
      comment: "Boolean indicating whether encryption is enabled — segments locations by security posture for compliance auditing."
  measures:
    - name: "total_provisioned_capacity_tb"
      expr: SUM(CAST(total_capacity_tb AS DOUBLE))
      comment: "Total provisioned storage capacity in TB across all locations. Primary KPI for infrastructure capacity planning and procurement."
    - name: "total_used_capacity_tb"
      expr: SUM(CAST(used_capacity_tb AS DOUBLE))
      comment: "Total used storage capacity in TB. Measures actual storage consumption for capacity headroom and growth forecasting."
    - name: "total_available_capacity_tb"
      expr: SUM(CAST(available_capacity_tb AS DOUBLE))
      comment: "Total available storage capacity in TB. Directly informs when new storage must be provisioned to avoid SLA breaches."
    - name: "avg_cost_per_tb_per_month"
      expr: AVG(CAST(cost_per_tb_per_month AS DOUBLE))
      comment: "Average storage cost per TB per month across locations. Benchmarks vendor pricing and informs tier migration and consolidation decisions."
    - name: "avg_restore_time_objective_hours"
      expr: AVG(CAST(restore_time_objective_hours AS DOUBLE))
      comment: "Average restore time objective in hours across storage locations. Measures SLA commitment level for disaster recovery planning."
    - name: "replication_enabled_location_count"
      expr: COUNT(CASE WHEN replication_enabled = TRUE THEN 1 END)
      comment: "Number of storage locations with replication enabled. Measures DR resilience coverage across the storage estate."
    - name: "total_storage_locations"
      expr: COUNT(1)
      comment: "Total number of storage locations in the infrastructure estate. Baseline KPI for infrastructure footprint and consolidation analysis."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_format_migration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Format migration throughput, quality, and cost metrics. Tracks migration success rates, quality validation scores, file size changes, and duration — essential for technology refresh programmes, codec obsolescence management, and archive preservation."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`format_migration`"
  dimensions:
    - name: "migration_status"
      expr: migration_status
      comment: "Migration status string (completed, failed, in-progress) — segments migrations by outcome for operational triage."
    - name: "migration_type"
      expr: migration_type
      comment: "Type of migration (codec, container, resolution, archive) — segments by migration category for cost and quality analysis."
    - name: "target_format"
      expr: target_format_id
      comment: "FK to target_format — segments migrations by output format for format adoption and compliance tracking."
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Boolean indicating whether the migrated asset is under legal hold — flags compliance-sensitive migration events."
    - name: "migration_start_month"
      expr: DATE_TRUNC('MONTH', migration_start_timestamp)
      comment: "Month of migration start — enables monthly throughput and cost trend analysis for technology refresh programmes."
  measures:
    - name: "total_format_migrations"
      expr: COUNT(1)
      comment: "Total number of format migrations executed. Baseline throughput KPI for technology refresh programme tracking."
    - name: "avg_migration_duration_seconds"
      expr: AVG(CAST(migration_duration_seconds AS DOUBLE))
      comment: "Average migration duration in seconds. Measures pipeline efficiency and informs capacity planning for large-scale format refresh programmes."
    - name: "total_source_file_size_bytes"
      expr: SUM(CAST(source_file_size_bytes AS DOUBLE))
      comment: "Total source file size in bytes across all migrations. Measures the scale of content being migrated for resource planning."
    - name: "total_target_file_size_bytes"
      expr: SUM(CAST(target_file_size_bytes AS DOUBLE))
      comment: "Total target file size in bytes after migration. Measures net storage impact of format migrations for capacity planning."
    - name: "avg_quality_validation_score"
      expr: AVG(CAST(quality_validation_score AS DOUBLE))
      comment: "Average quality validation score post-migration. Key quality KPI ensuring migrated assets meet broadcast delivery standards."
    - name: "avg_target_bitrate_kbps"
      expr: AVG(CAST(target_bitrate_kbps AS DOUBLE))
      comment: "Average target bitrate in Kbps across migrations. Measures encoding quality outcomes and storage efficiency of the migration programme."
    - name: "failed_migration_count"
      expr: COUNT(CASE WHEN error_code_id IS NOT NULL THEN 1 END)
      comment: "Number of format migrations with an error code. Measures pipeline reliability and triggers investigation of systemic migration failures."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_asset_lifecycle_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset lifecycle event throughput and quality metrics. Tracks event volumes by type, QC scores, compliance flags, and processing durations — essential for MAM audit trails, compliance governance, and operational pipeline monitoring."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`asset_lifecycle_event`"
  dimensions:
    - name: "event_type"
      expr: event_type_id
      comment: "FK to mediaasset_event_type — segments lifecycle events by type (ingest, transcode, archive, purge, restore) for operational analysis."
    - name: "operator_type"
      expr: operator_type_id
      comment: "FK to operator_type — segments events by operator category (human, automated, AI) for process efficiency analysis."
    - name: "rights_clearance_status"
      expr: rights_clearance_status_id
      comment: "FK to mediaasset_rights_clearance_status — segments events by rights clearance state for compliance monitoring."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Boolean indicating whether the lifecycle event is compliance-relevant — segments events for regulatory audit trail analysis."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month of lifecycle event — enables monthly activity trend analysis across the asset management pipeline."
  measures:
    - name: "total_lifecycle_events"
      expr: COUNT(1)
      comment: "Total number of asset lifecycle events recorded. Baseline KPI for MAM pipeline activity and audit trail completeness."
    - name: "avg_qc_score"
      expr: AVG(CAST(qc_score AS DOUBLE))
      comment: "Average QC score across lifecycle events. Measures overall asset quality health across the content pipeline."
    - name: "avg_event_duration_milliseconds"
      expr: AVG(CAST(event_duration_milliseconds AS DOUBLE))
      comment: "Average lifecycle event processing duration in milliseconds. Measures pipeline latency and informs SLA compliance for automated workflows."
    - name: "total_file_size_bytes_processed"
      expr: SUM(CAST(file_size_bytes AS DOUBLE))
      comment: "Total file size in bytes processed across lifecycle events. Measures data throughput of the asset management pipeline."
    - name: "compliance_event_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Number of compliance-flagged lifecycle events. Directly measures regulatory audit trail coverage and compliance risk exposure."
    - name: "avg_duration_seconds"
      expr: AVG(CAST(duration_seconds AS DOUBLE))
      comment: "Average content duration in seconds associated with lifecycle events. Informs processing load estimation for pipeline capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_deal_asset_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset licensing deal value and delivery metrics. Tracks license fee revenue, exclusivity coverage, delivery status, and license term duration — essential for rights monetisation reporting, deal performance analysis, and revenue forecasting."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`deal_asset_license`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status_id
      comment: "FK to mediaasset_delivery_status — segments license deals by delivery state (pending, delivered, failed) for fulfilment tracking."
    - name: "territory_code"
      expr: territory_code_id
      comment: "FK to mediaasset_territory_code — segments license deals by territory for geographic revenue analysis."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Boolean indicating exclusive licensing — segments deals by exclusivity for rights strategy and premium pricing analysis."
    - name: "license_start_month"
      expr: DATE_TRUNC('MONTH', license_term_start_date)
      comment: "Month of license term start — enables cohort analysis of license deal vintages and revenue recognition timing."
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month of asset delivery — enables delivery fulfilment trend analysis against license commitments."
  measures:
    - name: "total_deal_asset_licenses"
      expr: COUNT(1)
      comment: "Total number of asset license deals. Baseline KPI for rights monetisation portfolio size and deal velocity."
    - name: "total_license_fee_amount"
      expr: SUM(CAST(license_fee_amount AS DOUBLE))
      comment: "Total license fee revenue in deal currency. Primary financial KPI for asset rights monetisation and revenue forecasting."
    - name: "avg_license_fee_amount"
      expr: AVG(CAST(license_fee_amount AS DOUBLE))
      comment: "Average license fee per deal. Benchmarks deal pricing and informs negotiation strategy for future asset licensing."
    - name: "exclusive_deal_count"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END)
      comment: "Number of exclusive asset license deals. Measures premium rights exposure and informs windowing strategy decisions."
    - name: "distinct_territories_licensed"
      expr: COUNT(DISTINCT territory_code_id)
      comment: "Number of distinct territories covered by asset license deals. Measures geographic reach of rights monetisation portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_asset_rights_grant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset rights grant coverage and revenue share metrics. Tracks active grants, exclusivity exposure, revenue share rates, and grant lifecycle — essential for rights governance, partner relationship management, and revenue optimisation."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`asset_rights_grant`"
  dimensions:
    - name: "grant_status"
      expr: grant_status_id
      comment: "FK to grant_status — segments rights grants by status (active, expired, revoked) for rights portfolio health monitoring."
    - name: "rights_type"
      expr: rights_type_id
      comment: "FK to rights_type — segments grants by rights category (broadcast, streaming, theatrical, clip) for rights strategy analysis."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Boolean indicating exclusive rights grant — segments by exclusivity for premium rights exposure and conflict risk analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month of rights grant effective start — enables cohort analysis of grant vintages and rights portfolio evolution."
    - name: "effective_end_month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
      comment: "Month of rights grant expiry — supports proactive rights renewal and re-licensing pipeline management."
  measures:
    - name: "total_rights_grants"
      expr: COUNT(1)
      comment: "Total number of asset rights grants. Baseline KPI for rights portfolio size and partner coverage."
    - name: "avg_revenue_share_percentage"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue share percentage across rights grants. Benchmarks partner deal terms and informs negotiation strategy for new grants."
    - name: "total_revenue_share_percentage"
      expr: SUM(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Sum of revenue share percentages as a proxy for total revenue share obligation exposure across the rights portfolio."
    - name: "exclusive_grant_count"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END)
      comment: "Number of exclusive rights grants. Measures premium rights exposure and potential windowing conflicts requiring active management."
    - name: "distinct_partners_granted"
      expr: COUNT(DISTINCT partner_id)
      comment: "Number of distinct partners holding asset rights grants. Measures breadth of rights distribution network and partner dependency concentration."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_legal_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Legal hold portfolio risk and compliance metrics. Tracks active holds, asset exposure, acknowledgment compliance, and hold duration — essential for legal risk management, e-discovery readiness, and regulatory compliance governance."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`legal_hold`"
  dimensions:
    - name: "hold_status"
      expr: hold_status_id
      comment: "FK to hold_status — segments legal holds by status (active, released, pending) for legal risk portfolio monitoring."
    - name: "hold_type"
      expr: hold_type_id
      comment: "FK to hold_type — segments holds by type (litigation, regulatory, investigation) for legal risk categorisation."
    - name: "acknowledgment_required"
      expr: acknowledgment_required
      comment: "Boolean indicating whether custodian acknowledgment is required — segments holds by compliance obligation level."
    - name: "retention_override_flag"
      expr: retention_override_flag
      comment: "Boolean indicating whether the hold overrides standard retention policy — flags high-risk holds requiring special governance."
    - name: "hold_start_month"
      expr: DATE_TRUNC('MONTH', hold_start_date)
      comment: "Month of legal hold initiation — enables trend analysis of legal hold volume and duration over time."
  measures:
    - name: "total_legal_holds"
      expr: COUNT(1)
      comment: "Total number of legal holds in the portfolio. Baseline KPI for legal risk exposure and e-discovery readiness."
    - name: "active_legal_hold_count"
      expr: COUNT(CASE WHEN hold_status_id IS NOT NULL THEN 1 END)
      comment: "Number of legal holds with a status assigned. Measures active legal hold portfolio size for resource and compliance planning."
    - name: "retention_override_hold_count"
      expr: COUNT(CASE WHEN retention_override_flag = TRUE THEN 1 END)
      comment: "Number of legal holds that override standard retention policy. Measures high-risk holds requiring elevated governance and custodian oversight."
    - name: "acknowledgment_required_hold_count"
      expr: COUNT(CASE WHEN acknowledgment_required = TRUE THEN 1 END)
      comment: "Number of legal holds requiring custodian acknowledgment. Measures compliance obligation volume for legal operations workload planning."
    - name: "distinct_issuing_authorities"
      expr: COUNT(DISTINCT issuing_authority)
      comment: "Number of distinct issuing authorities behind legal holds. Measures regulatory and legal exposure breadth across jurisdictions."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_retention_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retention policy governance and coverage metrics. Tracks active policies, legal hold applicability, syndication scope, and format migration permissions — essential for data governance, regulatory compliance, and archive cost management."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`retention_policy`"
  dimensions:
    - name: "policy_status"
      expr: policy_status_id
      comment: "FK to mediaasset_policy_status — segments retention policies by status (active, superseded, draft) for governance health monitoring."
    - name: "policy_code"
      expr: policy_code_id
      comment: "FK to mediaasset_policy_code — segments policies by code category for regulatory basis analysis."
    - name: "priority_level"
      expr: priority_level_id
      comment: "FK to mediaasset_priority_level — segments policies by priority for enforcement triage."
    - name: "applies_to_legal_hold"
      expr: applies_to_legal_hold
      comment: "Boolean indicating whether the policy applies to assets under legal hold — critical for compliance governance segmentation."
    - name: "applies_to_syndication_content"
      expr: applies_to_syndication_content
      comment: "Boolean indicating whether the policy applies to syndicated content — segments policies by content distribution scope."
    - name: "format_migration_allowed"
      expr: format_migration_allowed
      comment: "Boolean indicating whether format migration is permitted under the policy — segments policies by technology refresh eligibility."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of policy effective date — enables trend analysis of policy portfolio evolution over time."
  measures:
    - name: "total_retention_policies"
      expr: COUNT(1)
      comment: "Total number of retention policies defined. Baseline KPI for data governance policy portfolio completeness."
    - name: "legal_hold_applicable_policy_count"
      expr: COUNT(CASE WHEN applies_to_legal_hold = TRUE THEN 1 END)
      comment: "Number of retention policies applicable to legal hold assets. Measures governance coverage for legally sensitive content."
    - name: "syndication_applicable_policy_count"
      expr: COUNT(CASE WHEN applies_to_syndication_content = TRUE THEN 1 END)
      comment: "Number of retention policies covering syndicated content. Measures governance coverage for distributed content rights obligations."
    - name: "format_migration_eligible_policy_count"
      expr: COUNT(CASE WHEN format_migration_allowed = TRUE THEN 1 END)
      comment: "Number of retention policies permitting format migration. Measures the scope of assets eligible for technology refresh programmes."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`mediaasset_asset_collection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset collection quality, size, and rights clearance metrics. Tracks collection completeness scores, total duration, storage footprint, syndication eligibility, and rights clearance status — essential for content packaging, distribution readiness, and rights governance."
  source: "`vibe_media_broadcasting_v1`.`mediaasset`.`asset_collection`"
  dimensions:
    - name: "collection_type"
      expr: collection_type_id
      comment: "FK to collection_type — segments collections by type (series, campaign, archive, syndication package) for portfolio analysis."
    - name: "asset_collection_status"
      expr: asset_collection_status_id
      comment: "FK to asset_collection_status — segments collections by status (active, archived, draft) for operational triage."
    - name: "rights_clearance_status"
      expr: rights_clearance_status_id
      comment: "FK to mediaasset_rights_clearance_status — segments collections by rights clearance state for distribution readiness analysis."
    - name: "qc_status"
      expr: qc_status_id
      comment: "FK to mediaasset_qc_status — segments collections by QC outcome for quality governance monitoring."
    - name: "syndication_eligible_flag"
      expr: syndication_eligible_flag
      comment: "Boolean indicating syndication eligibility — segments collections by distribution readiness for revenue opportunity analysis."
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Boolean indicating whether the collection is under legal hold — flags compliance-sensitive collections."
    - name: "creation_month"
      expr: DATE_TRUNC('MONTH', creation_date)
      comment: "Month of collection creation — enables trend analysis of collection portfolio growth over time."
  measures:
    - name: "total_asset_collections"
      expr: COUNT(1)
      comment: "Total number of asset collections. Baseline KPI for content packaging portfolio size and growth tracking."
    - name: "total_collection_duration_seconds"
      expr: SUM(CAST(total_duration_seconds AS DOUBLE))
      comment: "Total content duration in seconds across all collections. Measures content library depth available for distribution and licensing."
    - name: "total_collection_storage_bytes"
      expr: SUM(CAST(total_storage_size_bytes AS DOUBLE))
      comment: "Total storage footprint in bytes across all collections. Drives storage cost forecasting for packaged content libraries."
    - name: "avg_metadata_completeness_score"
      expr: AVG(CAST(metadata_completeness_score AS DOUBLE))
      comment: "Average metadata completeness score across collections. Measures content discoverability and distribution readiness quality."
    - name: "syndication_eligible_collection_count"
      expr: COUNT(CASE WHEN syndication_eligible_flag = TRUE THEN 1 END)
      comment: "Number of collections eligible for syndication. Directly measures the revenue-generating potential of the packaged content portfolio."
    - name: "legal_hold_collection_count"
      expr: COUNT(CASE WHEN legal_hold_flag = TRUE THEN 1 END)
      comment: "Number of collections under legal hold. Measures compliance exposure and blocks premature distribution of legally sensitive content packages."
$$;