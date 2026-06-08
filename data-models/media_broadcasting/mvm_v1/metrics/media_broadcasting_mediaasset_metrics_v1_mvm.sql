-- Metric views for domain: mediaasset | Business: Media Broadcasting | Version: 1 | Generated on: 2026-05-08 19:19:28

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`mediaasset_media_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core media asset inventory and storage efficiency metrics for content lifecycle management and capacity planning"
  source: "`media_broadcasting_ecm`.`mediaasset`.`media_asset`"
  dimensions:
    - name: "asset_type"
      expr: asset_type
      comment: "Type of media asset (e.g., video, audio, image) for content portfolio analysis"
    - name: "asset_class"
      expr: asset_class
      comment: "Classification of asset (e.g., master, proxy, archive) for inventory segmentation"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage (e.g., active, archived, deprecated) for asset management"
    - name: "storage_tier"
      expr: storage_tier
      comment: "Storage tier assignment (e.g., hot, warm, cold) for cost optimization analysis"
    - name: "content_classification"
      expr: content_classification
      comment: "Content classification category for rights and distribution planning"
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Legal hold indicator for compliance and risk management"
    - name: "ingest_year"
      expr: YEAR(ingest_timestamp)
      comment: "Year of asset ingest for vintage and growth analysis"
    - name: "ingest_month"
      expr: DATE_TRUNC('MONTH', ingest_timestamp)
      comment: "Month of asset ingest for trend and seasonality analysis"
    - name: "retention_expiry_year"
      expr: YEAR(retention_expiry_date)
      comment: "Year of retention expiry for purge planning and compliance forecasting"
  measures:
    - name: "total_asset_count"
      expr: COUNT(1)
      comment: "Total number of media assets for inventory tracking"
    - name: "unique_asset_count"
      expr: COUNT(DISTINCT media_asset_id)
      comment: "Distinct count of media assets for deduplication analysis"
    - name: "total_storage_bytes"
      expr: SUM(CAST(file_size_bytes AS DOUBLE))
      comment: "Total storage consumed in bytes for capacity planning and cost allocation"
    - name: "total_storage_tb"
      expr: SUM(CAST(file_size_bytes AS DOUBLE)) / 1099511627776.0
      comment: "Total storage consumed in terabytes for executive reporting"
    - name: "avg_file_size_gb"
      expr: AVG(CAST(file_size_bytes AS DOUBLE)) / 1073741824.0
      comment: "Average file size in gigabytes for asset profiling and infrastructure sizing"
    - name: "total_content_duration_hours"
      expr: SUM(CAST(duration_seconds AS DOUBLE)) / 3600.0
      comment: "Total content duration in hours for content volume and monetization analysis"
    - name: "avg_content_duration_minutes"
      expr: AVG(CAST(duration_seconds AS DOUBLE)) / 60.0
      comment: "Average content duration in minutes for content format and programming strategy"
    - name: "storage_efficiency_mb_per_minute"
      expr: ROUND((SUM(CAST(file_size_bytes AS DOUBLE)) / 1048576.0) / NULLIF(SUM(CAST(duration_seconds AS DOUBLE)) / 60.0, 0), 2)
      comment: "Storage efficiency in megabytes per content minute for compression and quality optimization"
    - name: "legal_hold_asset_count"
      expr: SUM(CASE WHEN legal_hold_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assets under legal hold for compliance risk exposure"
    - name: "legal_hold_storage_tb"
      expr: SUM(CASE WHEN legal_hold_flag = TRUE THEN CAST(file_size_bytes AS DOUBLE) ELSE 0 END) / 1099511627776.0
      comment: "Storage consumed by legal hold assets in terabytes for cost and risk management"
    - name: "avg_bitrate_mbps"
      expr: AVG(CAST(bit_rate_mbps AS DOUBLE))
      comment: "Average bitrate in megabits per second for quality benchmarking and delivery planning"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`mediaasset_transcode_job`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transcode job performance, cost efficiency, and quality metrics for workflow optimization and vendor management"
  source: "`media_broadcasting_ecm`.`mediaasset`.`transcode_job`"
  dimensions:
    - name: "job_status"
      expr: job_status
      comment: "Job completion status (e.g., completed, failed, in-progress) for operational monitoring"
    - name: "job_type"
      expr: job_type
      comment: "Type of transcode job (e.g., ABR, proxy, archive) for workload segmentation"
    - name: "job_priority"
      expr: job_priority
      comment: "Job priority level for SLA compliance and resource allocation analysis"
    - name: "transcoding_engine"
      expr: transcoding_engine
      comment: "Transcoding engine or platform used for vendor performance comparison"
    - name: "source_codec"
      expr: source_codec
      comment: "Source codec for input format analysis and compatibility planning"
    - name: "quality_validation_result"
      expr: quality_validation_result
      comment: "Quality validation outcome for defect tracking and process improvement"
    - name: "processing_month"
      expr: DATE_TRUNC('MONTH', processing_start_timestamp)
      comment: "Month of job processing for trend and capacity planning"
    - name: "queue_entry_month"
      expr: DATE_TRUNC('MONTH', queue_entry_timestamp)
      comment: "Month of queue entry for backlog and demand analysis"
  measures:
    - name: "total_job_count"
      expr: COUNT(1)
      comment: "Total number of transcode jobs for workload volume tracking"
    - name: "unique_job_count"
      expr: COUNT(DISTINCT transcode_job_id)
      comment: "Distinct count of transcode jobs for deduplication and accuracy"
    - name: "completed_job_count"
      expr: SUM(CASE WHEN job_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of successfully completed jobs for throughput and success rate calculation"
    - name: "failed_job_count"
      expr: SUM(CASE WHEN job_status = 'failed' THEN 1 ELSE 0 END)
      comment: "Count of failed jobs for quality control and root cause analysis"
    - name: "total_processing_hours"
      expr: SUM(CAST(processing_duration_seconds AS DOUBLE)) / 3600.0
      comment: "Total processing time in hours for capacity utilization and cost allocation"
    - name: "avg_processing_minutes"
      expr: AVG(CAST(processing_duration_seconds AS DOUBLE)) / 60.0
      comment: "Average processing time in minutes for SLA benchmarking and efficiency analysis"
    - name: "total_output_tb"
      expr: SUM(CAST(output_file_size_gb AS DOUBLE)) / 1024.0
      comment: "Total output volume in terabytes for storage planning and delivery cost forecasting"
    - name: "total_cost_usd"
      expr: SUM(CAST(cost_estimate_usd AS DOUBLE))
      comment: "Total transcode cost in USD for budget tracking and vendor cost management"
    - name: "avg_cost_per_job_usd"
      expr: AVG(CAST(cost_estimate_usd AS DOUBLE))
      comment: "Average cost per job in USD for unit economics and pricing negotiation"
    - name: "cost_per_output_gb_usd"
      expr: ROUND(SUM(CAST(cost_estimate_usd AS DOUBLE)) / NULLIF(SUM(CAST(output_file_size_gb AS DOUBLE)), 0), 4)
      comment: "Cost per output gigabyte in USD for efficiency benchmarking and vendor comparison"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_validation_score AS DOUBLE))
      comment: "Average quality validation score for output quality monitoring and process control"
    - name: "retry_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN CAST(retry_count AS INT) > 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of jobs requiring retry for reliability and process stability assessment"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`mediaasset_qc_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality control inspection outcomes and defect metrics for content quality assurance and vendor performance management"
  source: "`media_broadcasting_ecm`.`mediaasset`.`qc_inspection`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Inspection completion status for workflow tracking and backlog management"
    - name: "qc_type"
      expr: qc_type
      comment: "Type of QC inspection (e.g., automated, manual, hybrid) for process optimization"
    - name: "overall_result"
      expr: overall_result
      comment: "Overall inspection result (e.g., pass, fail, conditional) for quality gate enforcement"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for release readiness and compliance tracking"
    - name: "qc_tool_name"
      expr: qc_tool_name
      comment: "QC tool or platform used for vendor and technology performance comparison"
    - name: "black_frame_detected"
      expr: black_frame_detected
      comment: "Black frame detection flag for technical defect analysis"
    - name: "freeze_frame_detected"
      expr: freeze_frame_detected
      comment: "Freeze frame detection flag for technical defect analysis"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_timestamp)
      comment: "Month of inspection for trend and seasonality analysis"
  measures:
    - name: "total_inspection_count"
      expr: COUNT(1)
      comment: "Total number of QC inspections for workload volume tracking"
    - name: "unique_inspection_count"
      expr: COUNT(DISTINCT qc_inspection_id)
      comment: "Distinct count of QC inspections for deduplication and accuracy"
    - name: "passed_inspection_count"
      expr: SUM(CASE WHEN overall_result = 'pass' THEN 1 ELSE 0 END)
      comment: "Count of passed inspections for quality pass rate calculation"
    - name: "failed_inspection_count"
      expr: SUM(CASE WHEN overall_result = 'fail' THEN 1 ELSE 0 END)
      comment: "Count of failed inspections for defect rate and root cause analysis"
    - name: "total_defect_count"
      expr: SUM(CAST(defect_count AS DOUBLE))
      comment: "Total number of defects detected for quality trend monitoring"
    - name: "total_critical_defect_count"
      expr: SUM(CAST(critical_defect_count AS DOUBLE))
      comment: "Total number of critical defects for risk assessment and escalation"
    - name: "avg_defects_per_inspection"
      expr: AVG(CAST(defect_count AS DOUBLE))
      comment: "Average defects per inspection for quality benchmarking and process control"
    - name: "black_frame_detection_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN black_frame_detected = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections detecting black frames for technical quality monitoring"
    - name: "freeze_frame_detection_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN freeze_frame_detected = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections detecting freeze frames for technical quality monitoring"
    - name: "avg_loudness_lufs"
      expr: AVG(CAST(loudness_lufs AS DOUBLE))
      comment: "Average loudness in LUFS for audio compliance and consistency monitoring"
    - name: "avg_inspection_duration_minutes"
      expr: AVG(CAST(inspection_duration_seconds AS DOUBLE)) / 60.0
      comment: "Average inspection duration in minutes for efficiency and capacity planning"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`mediaasset_storage_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage location capacity, utilization, and cost metrics for infrastructure planning and vendor cost management"
  source: "`media_broadcasting_ecm`.`mediaasset`.`storage_location`"
  dimensions:
    - name: "storage_type"
      expr: storage_type
      comment: "Type of storage (e.g., SAN, NAS, cloud object) for infrastructure segmentation"
    - name: "storage_tier"
      expr: storage_tier
      comment: "Storage tier (e.g., hot, warm, cold, archive) for cost optimization analysis"
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status (e.g., active, maintenance, decommissioned) for availability tracking"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region for latency, compliance, and disaster recovery planning"
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier for service level and cost-performance analysis"
    - name: "encryption_enabled"
      expr: encryption_enabled
      comment: "Encryption enablement flag for security compliance and risk assessment"
    - name: "replication_enabled"
      expr: replication_enabled
      comment: "Replication enablement flag for resilience and disaster recovery readiness"
    - name: "legal_hold_capable"
      expr: legal_hold_capable
      comment: "Legal hold capability flag for compliance infrastructure planning"
  measures:
    - name: "total_location_count"
      expr: COUNT(1)
      comment: "Total number of storage locations for infrastructure footprint tracking"
    - name: "unique_location_count"
      expr: COUNT(DISTINCT storage_location_id)
      comment: "Distinct count of storage locations for deduplication and accuracy"
    - name: "total_capacity_tb"
      expr: SUM(CAST(total_capacity_tb AS DOUBLE))
      comment: "Total provisioned storage capacity in terabytes for infrastructure investment tracking"
    - name: "total_used_capacity_tb"
      expr: SUM(CAST(used_capacity_tb AS DOUBLE))
      comment: "Total used storage capacity in terabytes for utilization and growth analysis"
    - name: "total_available_capacity_tb"
      expr: SUM(CAST(available_capacity_tb AS DOUBLE))
      comment: "Total available storage capacity in terabytes for capacity planning and procurement"
    - name: "avg_utilization_pct"
      expr: ROUND(100.0 * AVG(CAST(used_capacity_tb AS DOUBLE) / NULLIF(CAST(total_capacity_tb AS DOUBLE), 0)), 2)
      comment: "Average storage utilization percentage for efficiency and capacity optimization"
    - name: "weighted_avg_cost_per_tb_usd"
      expr: ROUND(SUM(CAST(cost_per_tb_per_month AS DOUBLE) * CAST(total_capacity_tb AS DOUBLE)) / NULLIF(SUM(CAST(total_capacity_tb AS DOUBLE)), 0), 2)
      comment: "Weighted average cost per terabyte per month in USD for cost benchmarking and vendor negotiation"
    - name: "total_monthly_cost_usd"
      expr: SUM(CAST(cost_per_tb_per_month AS DOUBLE) * CAST(total_capacity_tb AS DOUBLE))
      comment: "Total monthly storage cost in USD for budget tracking and cost allocation"
    - name: "avg_restore_time_objective_hours"
      expr: AVG(CAST(restore_time_objective_hours AS DOUBLE))
      comment: "Average restore time objective in hours for disaster recovery planning and SLA management"
    - name: "encryption_coverage_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN encryption_enabled = TRUE THEN CAST(total_capacity_tb AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(total_capacity_tb AS DOUBLE)), 0), 2)
      comment: "Percentage of capacity with encryption enabled for security compliance reporting"
    - name: "replication_coverage_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN replication_enabled = TRUE THEN CAST(total_capacity_tb AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(total_capacity_tb AS DOUBLE)), 0), 2)
      comment: "Percentage of capacity with replication enabled for resilience and risk management"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`mediaasset_archive_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Archive lifecycle, cost, and compliance metrics for long-term preservation and regulatory adherence"
  source: "`media_broadcasting_ecm`.`mediaasset`.`archive_record`"
  dimensions:
    - name: "archive_status"
      expr: archive_status
      comment: "Archive status (e.g., archived, restoring, purged) for lifecycle tracking"
    - name: "archive_destination_type"
      expr: archive_destination_type
      comment: "Archive destination type (e.g., tape, cloud vault, offsite) for infrastructure segmentation"
    - name: "storage_tier"
      expr: storage_tier
      comment: "Storage tier for cost and retrieval time analysis"
    - name: "archive_format"
      expr: archive_format
      comment: "Archive format for preservation strategy and migration planning"
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Legal hold indicator for compliance risk and retention management"
    - name: "oais_compliance_flag"
      expr: oais_compliance_flag
      comment: "OAIS compliance flag for archival standards adherence"
    - name: "restore_sla_tier"
      expr: restore_sla_tier
      comment: "Restore SLA tier for service level and cost-performance analysis"
    - name: "archive_year"
      expr: YEAR(archive_date)
      comment: "Year of archive for vintage and retention expiry forecasting"
    - name: "archive_month"
      expr: DATE_TRUNC('MONTH', archive_date)
      comment: "Month of archive for trend and seasonality analysis"
    - name: "retention_expiry_year"
      expr: YEAR(retention_expiry_date)
      comment: "Year of retention expiry for purge planning and compliance forecasting"
  measures:
    - name: "total_archive_count"
      expr: COUNT(1)
      comment: "Total number of archive records for inventory and compliance tracking"
    - name: "unique_archive_count"
      expr: COUNT(DISTINCT archive_record_id)
      comment: "Distinct count of archive records for deduplication and accuracy"
    - name: "total_archive_size_tb"
      expr: SUM(CAST(archive_file_size_bytes AS DOUBLE)) / 1099511627776.0
      comment: "Total archived content in terabytes for capacity and cost planning"
    - name: "avg_archive_size_gb"
      expr: AVG(CAST(archive_file_size_bytes AS DOUBLE)) / 1073741824.0
      comment: "Average archive size in gigabytes for asset profiling and infrastructure sizing"
    - name: "total_archive_cost_usd"
      expr: SUM(CAST(archive_cost_per_gb AS DOUBLE) * CAST(archive_file_size_bytes AS DOUBLE) / 1073741824.0)
      comment: "Total archive cost in USD for budget tracking and vendor cost management"
    - name: "avg_cost_per_gb_usd"
      expr: AVG(CAST(archive_cost_per_gb AS DOUBLE))
      comment: "Average cost per gigabyte in USD for cost benchmarking and vendor negotiation"
    - name: "legal_hold_archive_count"
      expr: SUM(CASE WHEN legal_hold_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of archives under legal hold for compliance risk exposure"
    - name: "legal_hold_archive_tb"
      expr: SUM(CASE WHEN legal_hold_flag = TRUE THEN CAST(archive_file_size_bytes AS DOUBLE) ELSE 0 END) / 1099511627776.0
      comment: "Storage consumed by legal hold archives in terabytes for cost and risk management"
    - name: "oais_compliant_archive_count"
      expr: SUM(CASE WHEN oais_compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of OAIS-compliant archives for standards adherence reporting"
    - name: "restore_request_count"
      expr: SUM(CASE WHEN restore_request_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of restore requests for access pattern and retrieval cost analysis"
    - name: "restore_completion_count"
      expr: SUM(CASE WHEN restore_completion_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of completed restores for SLA compliance and success rate calculation"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`mediaasset_ingest_job`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ingest job performance, throughput, and quality metrics for content acquisition workflow optimization"
  source: "`media_broadcasting_ecm`.`mediaasset`.`ingest_job`"
  dimensions:
    - name: "job_status"
      expr: job_status
      comment: "Job completion status for operational monitoring and success rate tracking"
    - name: "ingest_source_type"
      expr: ingest_source_type
      comment: "Source type (e.g., satellite, file transfer, live feed) for workflow segmentation"
    - name: "content_type"
      expr: content_type
      comment: "Content type for asset classification and routing analysis"
    - name: "priority_level"
      expr: priority_level
      comment: "Job priority level for SLA compliance and resource allocation"
    - name: "source_format"
      expr: source_format
      comment: "Source format for compatibility and conversion planning"
    - name: "target_format"
      expr: target_format
      comment: "Target format for output standardization and delivery strategy"
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Legal hold indicator for compliance and retention management"
    - name: "ingest_month"
      expr: DATE_TRUNC('MONTH', ingest_start_timestamp)
      comment: "Month of ingest start for trend and capacity planning"
  measures:
    - name: "total_ingest_job_count"
      expr: COUNT(1)
      comment: "Total number of ingest jobs for workload volume tracking"
    - name: "unique_ingest_job_count"
      expr: COUNT(DISTINCT ingest_job_id)
      comment: "Distinct count of ingest jobs for deduplication and accuracy"
    - name: "completed_ingest_count"
      expr: SUM(CASE WHEN job_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of successfully completed ingests for throughput and success rate calculation"
    - name: "failed_ingest_count"
      expr: SUM(CASE WHEN job_status = 'failed' THEN 1 ELSE 0 END)
      comment: "Count of failed ingests for quality control and root cause analysis"
    - name: "total_bytes_transferred_tb"
      expr: SUM(CAST(bytes_transferred AS DOUBLE)) / 1099511627776.0
      comment: "Total data transferred in terabytes for network capacity and cost planning"
    - name: "avg_transfer_rate_mbps"
      expr: AVG(CAST(transfer_rate_mbps AS DOUBLE))
      comment: "Average transfer rate in megabits per second for network performance benchmarking"
    - name: "total_content_duration_hours"
      expr: SUM(CAST(duration_seconds AS DOUBLE)) / 3600.0
      comment: "Total content duration ingested in hours for content volume and monetization analysis"
    - name: "avg_content_duration_minutes"
      expr: AVG(CAST(duration_seconds AS DOUBLE)) / 60.0
      comment: "Average content duration in minutes for content format and programming strategy"
    - name: "closed_caption_present_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN closed_caption_present = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ingests with closed captions for accessibility compliance monitoring"
    - name: "avg_bitrate_kbps"
      expr: AVG(CAST(bitrate_kbps AS DOUBLE))
      comment: "Average bitrate in kilobits per second for quality benchmarking and delivery planning"
$$;