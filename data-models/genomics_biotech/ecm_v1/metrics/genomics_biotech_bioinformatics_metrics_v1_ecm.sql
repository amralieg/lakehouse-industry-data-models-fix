-- Metric views for domain: bioinformatics | Business: Genomics Biotech | Version: 1 | Generated on: 2026-05-06 12:58:41

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`bioinformatics_alignment_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key alignment performance and quality metrics for bioinformatics pipelines"
  source: "`genomics_biotech_ecm`.`bioinformatics`.`alignment_result`"
  dimensions:
    - name: "alignment_date"
      expr: DATE_TRUNC('day', alignment_timestamp)
      comment: "Date of the alignment operation"
    - name: "compute_platform"
      expr: compute_platform
      comment: "Compute platform used for alignment (e.g., AWS, GCP)"
    - name: "aligner_tool"
      expr: aligner_tool
      comment: "Software tool used for alignment"
    - name: "intended_use"
      expr: intended_use
      comment: "Intended downstream use of the alignment (research, clinical, etc.)"
    - name: "is_reanalysis"
      expr: is_reanalysis
      comment: "Flag indicating if this alignment is a re‑analysis"
  measures:
    - name: "total_alignments"
      expr: COUNT(1)
      comment: "Total number of alignment result records processed"
    - name: "total_mapped_reads"
      expr: SUM(CAST(mapped_reads AS DOUBLE))
      comment: "Sum of all reads that were successfully mapped"
    - name: "avg_mapping_rate_pct"
      expr: AVG(CAST(mapping_rate_pct AS DOUBLE))
      comment: "Average mapping rate percentage across alignments"
    - name: "avg_coverage_uniformity_pct"
      expr: AVG(CAST(coverage_uniformity_pct AS DOUBLE))
      comment: "Average coverage uniformity percentage"
    - name: "avg_duplicate_rate_pct"
      expr: AVG(CAST(duplicate_rate_pct AS DOUBLE))
      comment: "Average duplicate read rate percentage"
    - name: "avg_gc_content_pct"
      expr: AVG(CAST(gc_content_pct AS DOUBLE))
      comment: "Average GC content percentage"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`bioinformatics_pipeline_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational efficiency and cost metrics for bioinformatics pipeline executions"
  source: "`genomics_biotech_ecm`.`bioinformatics`.`bioinformatics_pipeline_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Current status of the pipeline run"
    - name: "pipeline_type"
      expr: pipeline_type
      comment: "Type/category of the pipeline (e.g., variant calling, RNA‑seq)"
    - name: "compute_environment"
      expr: compute_environment
      comment: "Compute environment used (e.g., Spark, HPC)"
    - name: "run_start_date"
      expr: DATE_TRUNC('day', start_timestamp)
      comment: "Date the pipeline run started"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Boolean flag indicating SLA breach"
  measures:
    - name: "total_pipeline_runs"
      expr: COUNT(1)
      comment: "Total number of pipeline runs executed"
    - name: "total_estimated_compute_cost_usd"
      expr: SUM(CAST(estimated_compute_cost_usd AS DOUBLE))
      comment: "Sum of estimated compute cost in USD for all runs"
    - name: "avg_cpu_core_hours"
      expr: AVG(CAST(cpu_core_hours AS DOUBLE))
      comment: "Average CPU core‑hours consumed per run"
    - name: "avg_total_reads"
      expr: AVG(CAST(total_reads_count AS DOUBLE))
      comment: "Average total reads processed per run"
    - name: "avg_percent_reads_mapped"
      expr: AVG(CAST(percent_reads_mapped AS DOUBLE))
      comment: "Average percentage of reads mapped per run"
    - name: "sla_breach_rate"
      expr: AVG(CASE WHEN sla_breach_flag THEN 1 ELSE 0 END)
      comment: "Proportion of runs that breached SLA"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`bioinformatics_variant_call_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and clinical relevance metrics for variant calling results"
  source: "`genomics_biotech_ecm`.`bioinformatics`.`variant_call_result`"
  dimensions:
    - name: "caller_tool_name"
      expr: caller_tool_name
      comment: "Variant caller software tool name"
    - name: "is_clinical_reportable"
      expr: is_clinical_reportable
      comment: "Flag indicating clinical reportability"
    - name: "sample_specimen_id"
      expr: sample_specimen_id
      comment: "Identifier of the specimen the variant originates from"
  measures:
    - name: "total_variant_calls"
      expr: COUNT(1)
      comment: "Total number of variant call records generated"
    - name: "reportable_variant_calls"
      expr: SUM(CASE WHEN is_clinical_reportable THEN 1 ELSE 0 END)
      comment: "Count of variants flagged as clinically reportable"
    - name: "avg_maf_threshold_applied"
      expr: AVG(CAST(maf_threshold_applied AS DOUBLE))
      comment: "Average minor‑allele‑frequency threshold applied during calling"
    - name: "avg_ti_tv_ratio"
      expr: AVG(CAST(ti_tv_ratio AS DOUBLE))
      comment: "Average transition/transversion ratio across calls"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`bioinformatics_cnv_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key CNV detection quality and quantity metrics"
  source: "`genomics_biotech_ecm`.`bioinformatics`.`cnv_result`"
  dimensions:
    - name: "cnv_type"
      expr: cnv_type
      comment: "Type of CNV (deletion, duplication, etc.)"
    - name: "cnv_caller_tool"
      expr: cnv_caller_tool
      comment: "Software tool used for CNV calling"
    - name: "is_filtered"
      expr: is_filtered
      comment: "Flag indicating if the CNV was filtered"
    - name: "sample_specimen_id"
      expr: sample_specimen_id
      comment: "Specimen identifier for the CNV event"
  measures:
    - name: "total_cnv_events"
      expr: COUNT(1)
      comment: "Total number of CNV events detected"
    - name: "filtered_cnv_events"
      expr: SUM(CASE WHEN is_filtered THEN 1 ELSE 0 END)
      comment: "Count of CNV events that were filtered out"
    - name: "avg_copy_number_estimate"
      expr: AVG(CAST(copy_number_estimate AS DOUBLE))
      comment: "Average estimated copy number across CNV segments"
    - name: "avg_log2_ratio"
      expr: AVG(CAST(log2_ratio AS DOUBLE))
      comment: "Average log2 ratio across CNV segments"
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average confidence score for CNV calls"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`bioinformatics_compute_job`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost and resource utilization metrics for bioinformatics compute jobs"
  source: "`genomics_biotech_ecm`.`bioinformatics`.`compute_job`"
  dimensions:
    - name: "compute_environment"
      expr: compute_environment
      comment: "Compute environment (e.g., Spark, Kubernetes)"
    - name: "algorithm_name"
      expr: algorithm_name
      comment: "Algorithm executed in the compute job"
    - name: "job_status"
      expr: job_status
      comment: "Current status of the compute job"
    - name: "is_spot_preempted"
      expr: is_spot_preempted
      comment: "Flag indicating if the job was preempted due to spot pricing"
    - name: "job_start_date"
      expr: DATE_TRUNC('day', start_timestamp)
      comment: "Date the compute job started"
  measures:
    - name: "total_compute_jobs"
      expr: COUNT(1)
      comment: "Total number of compute jobs submitted"
    - name: "total_estimated_cost_usd"
      expr: SUM(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Sum of estimated cost in USD for all compute jobs"
    - name: "avg_memory_requested_gb"
      expr: AVG(CAST(memory_requested_gb AS DOUBLE))
      comment: "Average memory requested per job (GB)"
    - name: "avg_memory_actual_gb"
      expr: AVG(CAST(memory_actual_gb AS DOUBLE))
      comment: "Average actual memory used per job (GB)"
    - name: "avg_wall_clock_seconds"
      expr: AVG(CAST(wall_clock_seconds AS DOUBLE))
      comment: "Average wall‑clock duration per job (seconds)"
    - name: "preempted_job_rate"
      expr: AVG(CASE WHEN is_spot_preempted THEN 1 ELSE 0 END)
      comment: "Proportion of jobs that were preempted"
$$;