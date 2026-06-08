-- Metric views for domain: bioinformatics | Business: Genomics Biotech | Version: 1 | Generated on: 2026-05-06 15:25:46

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`bioinformatics_pipeline_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core bioinformatics pipeline execution metrics tracking computational efficiency, quality outcomes, and operational performance for genomic data processing workflows"
  source: "`genomics_biotech_ecm`.`bioinformatics`.`pipeline_run`"
  dimensions:
    - name: "pipeline_type"
      expr: pipeline_type
      comment: "Type of bioinformatics pipeline executed (e.g., variant calling, alignment, annotation)"
    - name: "run_status"
      expr: run_status
      comment: "Execution status of the pipeline run (e.g., completed, failed, running)"
    - name: "sequencing_assay_type"
      expr: sequencing_assay_type
      comment: "Type of sequencing assay processed (e.g., WGS, WES, targeted panel)"
    - name: "compute_environment"
      expr: compute_environment
      comment: "Computational environment where pipeline executed (e.g., AWS, HPC, on-prem)"
    - name: "qc_pass_flag"
      expr: qc_pass_flag
      comment: "Boolean indicator whether pipeline run passed quality control thresholds"
    - name: "regulatory_use_classification"
      expr: regulatory_use_classification
      comment: "Classification of regulatory use (e.g., clinical, research, validation)"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Boolean indicator whether pipeline run breached service level agreement turnaround time"
    - name: "reprocessing_flag"
      expr: reprocessing_flag
      comment: "Boolean indicator whether this is a reprocessing of previously analyzed data"
    - name: "error_category"
      expr: error_category
      comment: "Category of error if pipeline run failed (e.g., compute, data quality, configuration)"
    - name: "workflow_engine"
      expr: workflow_engine
      comment: "Workflow orchestration engine used (e.g., Nextflow, Cromwell, Snakemake)"
    - name: "submission_date"
      expr: DATE_TRUNC('day', submission_timestamp)
      comment: "Date when pipeline run was submitted for execution"
    - name: "completion_date"
      expr: DATE_TRUNC('day', completion_timestamp)
      comment: "Date when pipeline run completed execution"
    - name: "submission_month"
      expr: DATE_TRUNC('month', submission_timestamp)
      comment: "Month when pipeline run was submitted"
  measures:
    - name: "total_pipeline_runs"
      expr: COUNT(1)
      comment: "Total number of pipeline runs executed"
    - name: "total_samples_processed"
      expr: COUNT(DISTINCT sample_specimen_id)
      comment: "Distinct count of biological samples processed through pipelines"
    - name: "qc_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN qc_pass_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pipeline runs that passed quality control thresholds"
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_breach_flag = FALSE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pipeline runs that met service level agreement turnaround time targets"
    - name: "total_compute_cost_usd"
      expr: SUM(CAST(estimated_compute_cost_usd AS DOUBLE))
      comment: "Total estimated computational cost in USD for pipeline executions"
    - name: "avg_compute_cost_per_run_usd"
      expr: AVG(CAST(estimated_compute_cost_usd AS DOUBLE))
      comment: "Average computational cost per pipeline run in USD"
    - name: "total_cpu_core_hours"
      expr: SUM(CAST(cpu_core_hours AS DOUBLE))
      comment: "Total CPU core hours consumed across all pipeline runs"
    - name: "avg_cpu_core_hours_per_run"
      expr: AVG(CAST(cpu_core_hours AS DOUBLE))
      comment: "Average CPU core hours consumed per pipeline run"
    - name: "total_storage_consumed_gb"
      expr: SUM(CAST(storage_consumed_gb AS DOUBLE))
      comment: "Total storage consumed in gigabytes across all pipeline outputs"
    - name: "avg_peak_memory_gb"
      expr: AVG(CAST(peak_memory_gb AS DOUBLE))
      comment: "Average peak memory utilization in gigabytes per pipeline run"
    - name: "total_reads_processed"
      expr: SUM(CAST(total_reads_count AS BIGINT))
      comment: "Total number of sequencing reads processed across all pipeline runs"
    - name: "avg_reads_per_sample"
      expr: AVG(CAST(total_reads_count AS BIGINT))
      comment: "Average number of sequencing reads processed per pipeline run"
    - name: "avg_mapping_rate_pct"
      expr: AVG(CAST(percent_reads_mapped AS DOUBLE))
      comment: "Average percentage of reads successfully mapped to reference genome"
    - name: "avg_coverage_depth"
      expr: AVG(CAST(mean_coverage_depth AS DOUBLE))
      comment: "Average mean sequencing coverage depth across pipeline runs"
    - name: "avg_q30_bases_pct"
      expr: AVG(CAST(percent_bases_above_q30 AS DOUBLE))
      comment: "Average percentage of bases with quality score above Q30 (99.9% accuracy)"
    - name: "avg_turnaround_time_hours"
      expr: AVG(CAST(sla_target_tat_hours AS DOUBLE))
      comment: "Average target turnaround time in hours for pipeline completion"
    - name: "failed_run_count"
      expr: SUM(CASE WHEN run_status IN ('failed', 'error') THEN 1 ELSE 0 END)
      comment: "Count of pipeline runs that failed or encountered errors"
    - name: "failure_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN run_status IN ('failed', 'error') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pipeline runs that failed execution"
    - name: "reprocessing_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reprocessing_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pipeline runs that are reprocessing previously analyzed data"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`bioinformatics_alignment_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sequencing alignment quality metrics tracking read mapping performance, coverage uniformity, and data quality indicators critical for downstream variant calling accuracy"
  source: "`genomics_biotech_ecm`.`bioinformatics`.`alignment_result`"
  dimensions:
    - name: "aligner_tool"
      expr: aligner_tool
      comment: "Bioinformatics tool used for sequence alignment (e.g., BWA, Bowtie2, STAR)"
    - name: "aligner_version"
      expr: aligner_version
      comment: "Version of the alignment tool used"
    - name: "sequencing_platform"
      expr: sequencing_platform
      comment: "Sequencing platform used (e.g., Illumina, PacBio, Oxford Nanopore)"
    - name: "sequencing_type"
      expr: sequencing_type
      comment: "Type of sequencing performed (e.g., paired-end, single-end, long-read)"
    - name: "reference_genome_build"
      expr: reference_genome_build
      comment: "Reference genome assembly version used for alignment (e.g., GRCh38, hg19)"
    - name: "qc_status"
      expr: qc_status
      comment: "Quality control status of alignment result (e.g., pass, fail, warning)"
    - name: "intended_use"
      expr: intended_use
      comment: "Intended use classification of alignment data (e.g., clinical, research, validation)"
    - name: "compute_platform"
      expr: compute_platform
      comment: "Computational platform where alignment was performed"
    - name: "is_reanalysis"
      expr: is_reanalysis
      comment: "Boolean indicator whether this is a reanalysis of previously aligned data"
    - name: "alignment_month"
      expr: DATE_TRUNC('month', alignment_timestamp)
      comment: "Month when alignment was performed"
  measures:
    - name: "total_alignments"
      expr: COUNT(1)
      comment: "Total number of alignment results generated"
    - name: "total_reads_aligned"
      expr: SUM(CAST(total_reads AS BIGINT))
      comment: "Total number of sequencing reads processed for alignment"
    - name: "total_mapped_reads"
      expr: SUM(CAST(mapped_reads AS BIGINT))
      comment: "Total number of reads successfully mapped to reference genome"
    - name: "avg_mapping_rate_pct"
      expr: AVG(CAST(mapping_rate_pct AS DOUBLE))
      comment: "Average percentage of reads successfully mapped to reference genome"
    - name: "avg_duplicate_rate_pct"
      expr: AVG(CAST(duplicate_rate_pct AS DOUBLE))
      comment: "Average percentage of duplicate reads identified (PCR or optical duplicates)"
    - name: "avg_properly_paired_rate_pct"
      expr: AVG(CAST(properly_paired_rate_pct AS DOUBLE))
      comment: "Average percentage of read pairs properly aligned in expected orientation and distance"
    - name: "avg_coverage_depth"
      expr: AVG(CAST(mean_coverage_depth AS DOUBLE))
      comment: "Average mean sequencing coverage depth across target regions"
    - name: "avg_coverage_uniformity_pct"
      expr: AVG(CAST(coverage_uniformity_pct AS DOUBLE))
      comment: "Average uniformity of coverage across target regions (evenness of sequencing depth)"
    - name: "avg_bases_above_10x_pct"
      expr: AVG(CAST(pct_bases_above_10x AS DOUBLE))
      comment: "Average percentage of target bases covered at 10x depth or greater"
    - name: "avg_bases_above_30x_pct"
      expr: AVG(CAST(pct_bases_above_30x AS DOUBLE))
      comment: "Average percentage of target bases covered at 30x depth or greater (clinical threshold)"
    - name: "avg_q30_bases_pct"
      expr: AVG(CAST(pct_q30_bases AS DOUBLE))
      comment: "Average percentage of bases with quality score Q30 or higher (99.9% base call accuracy)"
    - name: "avg_base_quality_score"
      expr: AVG(CAST(mean_base_quality_score AS DOUBLE))
      comment: "Average mean base quality score across all aligned reads"
    - name: "avg_gc_content_pct"
      expr: AVG(CAST(gc_content_pct AS DOUBLE))
      comment: "Average GC content percentage in aligned sequences"
    - name: "avg_chimeric_read_rate_pct"
      expr: AVG(CAST(chimeric_read_rate_pct AS DOUBLE))
      comment: "Average percentage of chimeric reads detected (reads mapping to multiple loci)"
    - name: "avg_insert_size_std_dev_bp"
      expr: AVG(CAST(insert_size_std_dev_bp AS DOUBLE))
      comment: "Average standard deviation of insert size in base pairs for paired-end reads"
    - name: "avg_strand_balance_ratio"
      expr: AVG(CAST(strand_balance_ratio AS DOUBLE))
      comment: "Average ratio of forward to reverse strand coverage (indicator of strand bias)"
    - name: "avg_compute_runtime_seconds"
      expr: AVG(CAST(compute_runtime_seconds AS DOUBLE))
      comment: "Average computational runtime in seconds for alignment processing"
    - name: "avg_memory_used_gb"
      expr: AVG(CAST(memory_used_gb AS DOUBLE))
      comment: "Average memory utilization in gigabytes during alignment processing"
    - name: "qc_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN qc_status = 'pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alignment results that passed quality control thresholds"
    - name: "high_quality_alignment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN mapping_rate_pct >= 95 AND duplicate_rate_pct <= 20 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alignments meeting high quality thresholds (>=95% mapping, <=20% duplicates)"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`bioinformatics_variant_call_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Variant calling quality and yield metrics tracking genomic variant detection performance, concordance rates, and clinical reportability for precision medicine applications"
  source: "`genomics_biotech_ecm`.`bioinformatics`.`variant_call_result`"
  dimensions:
    - name: "caller_tool_name"
      expr: caller_tool_name
      comment: "Variant calling tool used (e.g., GATK, FreeBayes, Strelka)"
    - name: "caller_tool_version"
      expr: caller_tool_version
      comment: "Version of variant calling tool used"
    - name: "assay_type"
      expr: assay_type
      comment: "Type of genomic assay performed (e.g., WGS, WES, targeted panel)"
    - name: "call_method"
      expr: call_method
      comment: "Method used for variant calling (e.g., germline, somatic, joint)"
    - name: "qc_status"
      expr: qc_status
      comment: "Quality control status of variant calling result"
    - name: "result_status"
      expr: result_status
      comment: "Overall status of variant calling result (e.g., complete, pending, failed)"
    - name: "is_clinical_reportable"
      expr: is_clinical_reportable
      comment: "Boolean indicator whether variants are suitable for clinical reporting"
    - name: "reanalysis_flag"
      expr: reanalysis_flag
      comment: "Boolean indicator whether this is a reanalysis of previously called variants"
    - name: "regulatory_use_designation"
      expr: regulatory_use_designation
      comment: "Regulatory classification of variant calling use (e.g., clinical, research)"
    - name: "use_case_classification"
      expr: use_case_classification
      comment: "Classification of variant calling use case (e.g., diagnostics, pharmacogenomics)"
    - name: "zygosity"
      expr: zygosity
      comment: "Zygosity classification of called variants (e.g., heterozygous, homozygous)"
    - name: "call_month"
      expr: DATE_TRUNC('month', call_timestamp)
      comment: "Month when variant calling was performed"
  measures:
    - name: "total_variant_calls"
      expr: COUNT(1)
      comment: "Total number of variant calling results generated"
    - name: "total_samples_called"
      expr: COUNT(DISTINCT sample_specimen_id)
      comment: "Distinct count of biological samples with variant calling performed"
    - name: "total_variants_detected"
      expr: SUM(CAST(total_variants_called AS BIGINT))
      comment: "Total number of genomic variants detected across all samples"
    - name: "avg_variants_per_sample"
      expr: AVG(CAST(total_variants_called AS BIGINT))
      comment: "Average number of variants detected per sample"
    - name: "total_snps_detected"
      expr: SUM(CAST(snp_count AS BIGINT))
      comment: "Total number of single nucleotide polymorphisms (SNPs) detected"
    - name: "total_indels_detected"
      expr: SUM(CAST(indel_count AS BIGINT))
      comment: "Total number of insertion-deletion variants (indels) detected"
    - name: "total_cnvs_detected"
      expr: SUM(CAST(cnv_count AS BIGINT))
      comment: "Total number of copy number variants (CNVs) detected"
    - name: "avg_call_rate_pct"
      expr: AVG(CAST(call_rate AS DOUBLE))
      comment: "Average percentage of genomic positions successfully genotyped"
    - name: "avg_genotype_quality_score"
      expr: AVG(CAST(genotype_quality_score AS DOUBLE))
      comment: "Average genotype quality score across variant calls"
    - name: "avg_coverage_depth"
      expr: AVG(CAST(mean_coverage_depth AS DOUBLE))
      comment: "Average mean sequencing coverage depth at variant positions"
    - name: "avg_base_quality_score"
      expr: AVG(CAST(mean_base_quality_score AS DOUBLE))
      comment: "Average base quality score at variant positions"
    - name: "avg_bases_above_20x_pct"
      expr: AVG(CAST(pct_bases_above_20x AS DOUBLE))
      comment: "Average percentage of bases covered at 20x depth or greater"
    - name: "avg_dbsnp_concordance_pct"
      expr: AVG(CAST(dbsnp_concordance_rate AS DOUBLE))
      comment: "Average concordance rate with dbSNP reference database (validation metric)"
    - name: "avg_ti_tv_ratio"
      expr: AVG(CAST(ti_tv_ratio AS DOUBLE))
      comment: "Average transition/transversion ratio (quality indicator, expected ~2.0 for WGS)"
    - name: "avg_maf_threshold"
      expr: AVG(CAST(maf_threshold_applied AS DOUBLE))
      comment: "Average minor allele frequency threshold applied for variant filtering"
    - name: "clinical_reportable_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_clinical_reportable = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of variant calling results suitable for clinical reporting"
    - name: "qc_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN qc_status = 'pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of variant calling results that passed quality control thresholds"
    - name: "reanalysis_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reanalysis_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of variant calls that are reanalysis of previously processed samples"
    - name: "high_quality_call_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN genotype_quality_score >= 30 AND mean_coverage_depth >= 30 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of variant calls meeting high quality thresholds (GQ>=30, depth>=30x)"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`bioinformatics_compute_job`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Computational resource utilization and cost efficiency metrics for bioinformatics workloads tracking cloud spend, job performance, and infrastructure optimization opportunities"
  source: "`genomics_biotech_ecm`.`bioinformatics`.`compute_job`"
  dimensions:
    - name: "job_type"
      expr: job_type
      comment: "Type of computational job executed (e.g., alignment, variant calling, annotation)"
    - name: "job_status"
      expr: job_status
      comment: "Execution status of compute job (e.g., completed, failed, running, cancelled)"
    - name: "compute_environment"
      expr: compute_environment
      comment: "Computational environment where job executed (e.g., AWS Batch, HPC cluster, Kubernetes)"
    - name: "instance_type"
      expr: instance_type
      comment: "Cloud instance type or HPC node specification used"
    - name: "pricing_model"
      expr: pricing_model
      comment: "Cloud pricing model used (e.g., on-demand, spot, reserved)"
    - name: "is_spot_preempted"
      expr: is_spot_preempted
      comment: "Boolean indicator whether spot instance was preempted during execution"
    - name: "aws_region"
      expr: aws_region
      comment: "AWS region where compute job executed"
    - name: "workflow_engine"
      expr: workflow_engine
      comment: "Workflow orchestration engine used (e.g., Nextflow, Cromwell, Snakemake)"
    - name: "algorithm_name"
      expr: algorithm_name
      comment: "Name of bioinformatics algorithm executed"
    - name: "priority_tier"
      expr: priority_tier
      comment: "Priority tier assigned to compute job (e.g., high, normal, low)"
    - name: "submission_date"
      expr: DATE_TRUNC('day', submission_timestamp)
      comment: "Date when compute job was submitted"
    - name: "submission_month"
      expr: DATE_TRUNC('month', submission_timestamp)
      comment: "Month when compute job was submitted"
  measures:
    - name: "total_compute_jobs"
      expr: COUNT(1)
      comment: "Total number of compute jobs executed"
    - name: "total_compute_cost_usd"
      expr: SUM(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Total estimated computational cost in USD across all jobs"
    - name: "avg_cost_per_job_usd"
      expr: AVG(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Average computational cost per job in USD"
    - name: "total_cpu_core_hours"
      expr: SUM(CAST(quota_cpu_core_hours_consumed AS DOUBLE))
      comment: "Total CPU core hours consumed across all compute jobs"
    - name: "avg_cpu_core_hours_per_job"
      expr: AVG(CAST(quota_cpu_core_hours_consumed AS DOUBLE))
      comment: "Average CPU core hours consumed per compute job"
    - name: "total_wall_clock_hours"
      expr: SUM(CAST(wall_clock_seconds AS BIGINT)) / 3600.0
      comment: "Total wall clock time in hours across all compute jobs"
    - name: "avg_wall_clock_hours_per_job"
      expr: AVG(CAST(wall_clock_seconds AS BIGINT)) / 3600.0
      comment: "Average wall clock time in hours per compute job"
    - name: "avg_memory_requested_gb"
      expr: AVG(CAST(memory_requested_gb AS DOUBLE))
      comment: "Average memory requested in gigabytes per compute job"
    - name: "avg_memory_actual_gb"
      expr: AVG(CAST(memory_actual_gb AS DOUBLE))
      comment: "Average actual memory utilized in gigabytes per compute job"
    - name: "total_storage_read_gb"
      expr: SUM(CAST(storage_read_gb AS DOUBLE))
      comment: "Total storage read in gigabytes across all compute jobs"
    - name: "total_storage_write_gb"
      expr: SUM(CAST(storage_write_gb AS DOUBLE))
      comment: "Total storage written in gigabytes across all compute jobs"
    - name: "avg_storage_io_gb_per_job"
      expr: AVG(CAST(storage_read_gb AS DOUBLE) + CAST(storage_write_gb AS DOUBLE))
      comment: "Average total storage I/O (read + write) in gigabytes per compute job"
    - name: "job_success_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN job_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of compute jobs that completed successfully"
    - name: "job_failure_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN job_status IN ('failed', 'error') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of compute jobs that failed or encountered errors"
    - name: "spot_preemption_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_spot_preempted = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of spot instance jobs that were preempted"
    - name: "avg_retry_count"
      expr: AVG(CAST(retry_count AS DOUBLE))
      comment: "Average number of retries per compute job"
    - name: "memory_utilization_efficiency_pct"
      expr: ROUND(100.0 * AVG(CAST(memory_actual_gb AS DOUBLE) / NULLIF(CAST(memory_requested_gb AS DOUBLE), 0)), 2)
      comment: "Average memory utilization efficiency (actual vs requested memory)"
    - name: "cost_per_cpu_core_hour_usd"
      expr: SUM(CAST(estimated_cost_usd AS DOUBLE)) / NULLIF(SUM(CAST(quota_cpu_core_hours_consumed AS DOUBLE)), 0)
      comment: "Average cost per CPU core hour in USD (cost efficiency metric)"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`bioinformatics_genomic_artifact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Genomic data artifact lifecycle and storage metrics tracking file generation, quality, retention compliance, and data classification for regulatory and operational governance"
  source: "`genomics_biotech_ecm`.`bioinformatics`.`genomic_artifact`"
  dimensions:
    - name: "artifact_type"
      expr: artifact_type
      comment: "Type of genomic data artifact (e.g., FASTQ, BAM, VCF, gVCF)"
    - name: "artifact_status"
      expr: artifact_status
      comment: "Lifecycle status of genomic artifact (e.g., active, archived, deleted)"
    - name: "qc_status"
      expr: qc_status
      comment: "Quality control status of genomic artifact"
    - name: "data_classification"
      expr: data_classification
      comment: "Data classification level (e.g., confidential, restricted, public)"
    - name: "use_classification"
      expr: use_classification
      comment: "Use classification of genomic data (e.g., clinical, research, validation)"
    - name: "sequencing_assay_type"
      expr: sequencing_assay_type
      comment: "Type of sequencing assay that generated artifact"
    - name: "genome_build"
      expr: genome_build
      comment: "Reference genome build used (e.g., GRCh38, hg19)"
    - name: "storage_platform"
      expr: storage_platform
      comment: "Storage platform where artifact is stored (e.g., S3, Azure Blob, on-prem)"
    - name: "compression_format"
      expr: compression_format
      comment: "Compression format of artifact file (e.g., gzip, bgzip, uncompressed)"
    - name: "contains_phi"
      expr: contains_phi
      comment: "Boolean indicator whether artifact contains protected health information"
    - name: "is_indexed"
      expr: is_indexed
      comment: "Boolean indicator whether artifact has associated index file for rapid access"
    - name: "is_paired_end"
      expr: is_paired_end
      comment: "Boolean indicator whether artifact represents paired-end sequencing data"
    - name: "retention_policy"
      expr: retention_policy
      comment: "Data retention policy applied to artifact (e.g., 7-year clinical, 2-year research)"
    - name: "pipeline_stage"
      expr: pipeline_stage
      comment: "Pipeline stage that generated artifact (e.g., raw, aligned, variant-called)"
    - name: "creation_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month when genomic artifact was created"
  measures:
    - name: "total_artifacts"
      expr: COUNT(1)
      comment: "Total number of genomic data artifacts managed"
    - name: "total_samples_with_artifacts"
      expr: COUNT(DISTINCT sample_specimen_id)
      comment: "Distinct count of biological samples with genomic artifacts"
    - name: "total_storage_bytes"
      expr: SUM(CAST(file_size_bytes AS BIGINT))
      comment: "Total storage consumed in bytes across all genomic artifacts"
    - name: "total_storage_tb"
      expr: SUM(CAST(file_size_bytes AS BIGINT)) / 1099511627776.0
      comment: "Total storage consumed in terabytes across all genomic artifacts"
    - name: "avg_file_size_gb"
      expr: AVG(CAST(file_size_bytes AS BIGINT)) / 1073741824.0
      comment: "Average file size in gigabytes per genomic artifact"
    - name: "total_read_count"
      expr: SUM(CAST(total_read_count AS BIGINT))
      comment: "Total number of sequencing reads across all genomic artifacts"
    - name: "avg_reads_per_artifact"
      expr: AVG(CAST(total_read_count AS BIGINT))
      comment: "Average number of sequencing reads per genomic artifact"
    - name: "avg_coverage_depth"
      expr: AVG(CAST(mean_coverage_depth AS DOUBLE))
      comment: "Average mean sequencing coverage depth across genomic artifacts"
    - name: "avg_phred_quality_score"
      expr: AVG(CAST(mean_phred_quality_score AS DOUBLE))
      comment: "Average mean Phred quality score across genomic artifacts"
    - name: "avg_q30_pct"
      expr: AVG(CAST(percent_q30 AS DOUBLE))
      comment: "Average percentage of bases with quality score Q30 or higher"
    - name: "qc_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN qc_status = 'pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of genomic artifacts that passed quality control"
    - name: "indexed_artifact_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_indexed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of genomic artifacts with associated index files"
    - name: "phi_artifact_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN contains_phi = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of genomic artifacts containing protected health information"
    - name: "archived_artifact_count"
      expr: SUM(CASE WHEN artifact_status = 'archived' THEN 1 ELSE 0 END)
      comment: "Count of genomic artifacts in archived status"
    - name: "archived_storage_tb"
      expr: SUM(CASE WHEN artifact_status = 'archived' THEN CAST(file_size_bytes AS BIGINT) ELSE 0 END) / 1099511627776.0
      comment: "Total storage in terabytes for archived genomic artifacts"
    - name: "active_storage_tb"
      expr: SUM(CASE WHEN artifact_status = 'active' THEN CAST(file_size_bytes AS BIGINT) ELSE 0 END) / 1099511627776.0
      comment: "Total storage in terabytes for active genomic artifacts"
    - name: "clinical_artifact_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN use_classification = 'clinical' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of genomic artifacts classified for clinical use"
    - name: "avg_variant_count"
      expr: AVG(CAST(variant_count AS BIGINT))
      comment: "Average number of variants per genomic artifact (for VCF files)"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`bioinformatics_pipeline_qc_metric`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pipeline quality control metric performance tracking QC gate pass rates, threshold compliance, and remediation effectiveness for bioinformatics workflow quality assurance"
  source: "`genomics_biotech_ecm`.`bioinformatics`.`pipeline_qc_metric`"
  dimensions:
    - name: "metric_name"
      expr: metric_name
      comment: "Name of quality control metric evaluated (e.g., mapping_rate, coverage_depth)"
    - name: "metric_category"
      expr: metric_category
      comment: "Category of QC metric (e.g., alignment, variant calling, sequencing quality)"
    - name: "qc_status"
      expr: qc_status
      comment: "Quality control status result (e.g., pass, fail, warning)"
    - name: "pipeline_stage"
      expr: pipeline_stage
      comment: "Pipeline stage where QC metric was evaluated"
    - name: "assay_type"
      expr: assay_type
      comment: "Type of genomic assay being quality controlled"
    - name: "qc_tool_name"
      expr: qc_tool_name
      comment: "Quality control tool used for metric evaluation (e.g., FastQC, Picard, MultiQC)"
    - name: "is_qc_gate_blocking"
      expr: is_qc_gate_blocking
      comment: "Boolean indicator whether QC metric failure blocks pipeline progression"
    - name: "threshold_direction"
      expr: threshold_direction
      comment: "Direction of threshold evaluation (e.g., greater_than, less_than, between)"
    - name: "regulatory_use_classification"
      expr: regulatory_use_classification
      comment: "Regulatory classification of QC metric use (e.g., clinical, research)"
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation action for failed QC metrics"
    - name: "compute_environment"
      expr: compute_environment
      comment: "Computational environment where QC metric was evaluated"
    - name: "evaluation_month"
      expr: DATE_TRUNC('month', evaluation_timestamp)
      comment: "Month when QC metric was evaluated"
  measures:
    - name: "total_qc_metrics_evaluated"
      expr: COUNT(1)
      comment: "Total number of quality control metrics evaluated"
    - name: "total_pipeline_runs_qc_checked"
      expr: COUNT(DISTINCT pipeline_run_id)
      comment: "Distinct count of pipeline runs with QC metrics evaluated"
    - name: "qc_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN qc_status = 'pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of QC metrics that passed threshold criteria"
    - name: "qc_fail_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN qc_status = 'fail' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of QC metrics that failed threshold criteria"
    - name: "blocking_qc_failure_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN qc_status = 'fail' AND is_qc_gate_blocking = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of QC metrics that failed and blocked pipeline progression"
    - name: "avg_metric_value"
      expr: AVG(CAST(metric_value AS DOUBLE))
      comment: "Average value of QC metrics evaluated"
    - name: "avg_pass_threshold"
      expr: AVG(CAST(pass_threshold AS DOUBLE))
      comment: "Average pass threshold value for QC metrics"
    - name: "avg_threshold_lower_bound"
      expr: AVG(CAST(threshold_lower_bound AS DOUBLE))
      comment: "Average lower bound threshold for QC metrics"
    - name: "avg_threshold_upper_bound"
      expr: AVG(CAST(threshold_upper_bound AS DOUBLE))
      comment: "Average upper bound threshold for QC metrics"
    - name: "remediation_required_count"
      expr: SUM(CASE WHEN qc_status = 'fail' AND remediation_status IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of failed QC metrics requiring remediation action"
    - name: "remediation_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN remediation_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN qc_status = 'fail' THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of failed QC metrics with completed remediation"
    - name: "clinical_qc_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN qc_status = 'pass' AND regulatory_use_classification = 'clinical' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN regulatory_use_classification = 'clinical' THEN 1 ELSE 0 END), 0), 2)
      comment: "QC pass rate for clinical-use classified metrics (critical regulatory metric)"
    - name: "first_pass_yield_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN qc_status = 'pass' AND review_outcome IS NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of QC metrics passing on first evaluation without review or waiver"
    - name: "waiver_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN waiver_justification IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of QC metrics with waiver justification (quality exception rate)"
$$;