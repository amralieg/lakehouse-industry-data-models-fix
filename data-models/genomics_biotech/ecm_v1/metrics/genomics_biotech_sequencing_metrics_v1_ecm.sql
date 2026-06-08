-- Metric views for domain: sequencing | Business: Genomics Biotech | Version: 1 | Generated on: 2026-05-06 12:58:41

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`sequencing_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High‑level performance and quality of sequencing runs"
  source: "`genomics_biotech_ecm`.`sequencing`.`sequencing_run`"
  dimensions:
    - name: "run_date"
      expr: DATE_TRUNC('day', start_timestamp)
      comment: "Date of run start (day level)"
    - name: "instrument_platform"
      expr: instrument_platform
      comment: "Sequencing instrument platform (e.g., Illumina, PacBio)"
    - name: "run_type"
      expr: run_type
      comment: "Run type (e.g., Production, Validation)"
    - name: "run_status"
      expr: run_status
      comment: "Current status of the run"
  measures:
    - name: "total_runs"
      expr: COUNT(1)
      comment: "Total number of sequencing runs executed"
    - name: "total_output_yield_gb"
      expr: SUM(CAST(output_yield_gb AS DOUBLE))
      comment: "Total data output in gigabytes produced by runs"
    - name: "avg_q30_pct"
      expr: AVG(CAST(q30_pct AS DOUBLE))
      comment: "Average Q30 percentage (quality threshold) across runs"
    - name: "avg_error_rate_pct"
      expr: AVG(CAST(error_rate_pct AS DOUBLE))
      comment: "Average sequencing error rate percentage"
    - name: "avg_cluster_density"
      expr: AVG(CAST(cluster_density AS DOUBLE))
      comment: "Average cluster density (clusters per mm²) per run"
    - name: "total_passed_runs"
      expr: COUNT(CASE WHEN qc_status = 'Pass' THEN 1 END)
      comment: "Number of runs that passed QC"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`sequencing_coverage_stat`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coverage quality and depth metrics for sequencing experiments"
  source: "`genomics_biotech_ecm`.`sequencing`.`coverage_stat`"
  dimensions:
    - name: "assay_type"
      expr: assay_type
      comment: "Assay type (e.g., WGS, Exome)"
    - name: "genome_assembly_id"
      expr: genome_assembly_id
      comment: "Reference genome assembly identifier"
  measures:
    - name: "total_coverage_records"
      expr: COUNT(1)
      comment: "Number of coverage statistic records"
    - name: "avg_mean_coverage_depth"
      expr: AVG(CAST(mean_coverage_depth AS DOUBLE))
      comment: "Average mean coverage depth across samples"
    - name: "avg_coverage_uniformity_pct"
      expr: AVG(CAST(coverage_uniformity_pct AS DOUBLE))
      comment: "Average coverage uniformity percentage"
    - name: "avg_duplication_rate_pct"
      expr: AVG(CAST(duplication_rate_pct AS DOUBLE))
      comment: "Average duplication rate percentage"
    - name: "total_mapped_reads"
      expr: SUM(CAST(mapped_reads AS DOUBLE))
      comment: "Total number of reads that successfully mapped to the reference"
    - name: "avg_mapping_rate_pct"
      expr: AVG(CAST(mapping_rate_pct AS DOUBLE))
      comment: "Average mapping rate percentage"
    - name: "avg_pct_bases_at_30x"
      expr: AVG(CAST(pct_bases_at_30x AS DOUBLE))
      comment: "Average percentage of bases covered at >=30x depth"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`sequencing_library`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key library preparation efficiency and quality indicators"
  source: "`genomics_biotech_ecm`.`sequencing`.`library`"
  dimensions:
    - name: "library_type"
      expr: library_type
      comment: "Library type (e.g., DNA, RNA)"
    - name: "is_paired_end"
      expr: is_paired_end
      comment: "Whether the library is paired‑end"
    - name: "project_id"
      expr: project_id
      comment: "Associated research project identifier"
    - name: "target_panel_id"
      expr: target_panel_id
      comment: "Target panel identifier for the library"
  measures:
    - name: "total_libraries"
      expr: COUNT(1)
      comment: "Total number of libraries prepared"
    - name: "avg_input_dna_mass_ng"
      expr: AVG(CAST(input_dna_mass_ng AS DOUBLE))
      comment: "Average input DNA mass (ng) per library"
    - name: "avg_concentration_nm"
      expr: AVG(CAST(concentration_nm AS DOUBLE))
      comment: "Average library concentration (nM)"
    - name: "total_resequencing_libraries"
      expr: COUNT(CASE WHEN resequencing_flag = TRUE THEN 1 END)
      comment: "Number of libraries flagged for resequencing"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`sequencing_pool`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pooling efficiency and quality metrics"
  source: "`genomics_biotech_ecm`.`sequencing`.`pool`"
  dimensions:
    - name: "pool_status"
      expr: pool_status
      comment: "Current status of the pool"
    - name: "is_repool"
      expr: is_repool
      comment: "Flag indicating if the pool was repooled"
    - name: "project_id"
      expr: project_id
      comment: "Research project identifier linked to the pool"
  measures:
    - name: "total_pools"
      expr: COUNT(1)
      comment: "Total number of pools created"
    - name: "avg_final_concentration_nm"
      expr: AVG(CAST(final_concentration_nm AS DOUBLE))
      comment: "Average final pool concentration (nM)"
    - name: "total_volume_ul"
      expr: SUM(CAST(total_volume_ul AS DOUBLE))
      comment: "Total pooled volume in microliters"
    - name: "total_repool_pools"
      expr: COUNT(CASE WHEN is_repool = TRUE THEN 1 END)
      comment: "Number of pools that required repooling"
$$;