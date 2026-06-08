-- Metric views for domain: genomics | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`genomics_genomic_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Genomic test ordering metrics tracking order volumes, turnaround, costs, and actionability rates for precision medicine program management."
  source: "`healthcare_ecm_v1`.`genomics`.`genomic_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the genomic order (ordered, in-progress, completed, cancelled)"
    - name: "test_type"
      expr: test_type
      comment: "Type of genomic test ordered (WGS, WES, panel, single gene, pharmacogenomics)"
    - name: "priority"
      expr: priority
      comment: "Order priority level (stat, routine, urgent)"
    - name: "result_status"
      expr: result_status
      comment: "Status of the genomic test result (pending, preliminary, final, amended)"
    - name: "prior_authorization_status"
      expr: prior_authorization_status
      comment: "Insurance prior authorization status for the genomic test"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_datetime)
      comment: "Month the genomic order was placed for trend analysis"
    - name: "sequencing_platform"
      expr: sequencing_platform
      comment: "Sequencing platform used (Illumina, PacBio, Oxford Nanopore)"
    - name: "specimen_type"
      expr: specimen_type
      comment: "Type of specimen collected for genomic testing"
  measures:
    - name: "total_genomic_orders"
      expr: COUNT(1)
      comment: "Total number of genomic test orders placed - baseline volume metric for precision medicine program"
    - name: "orders_with_actionable_findings"
      expr: COUNT(CASE WHEN actionable_findings_flag = TRUE THEN 1 END)
      comment: "Number of orders that yielded clinically actionable findings driving treatment decisions"
    - name: "actionable_findings_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actionable_findings_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of genomic orders yielding actionable findings - key program effectiveness KPI"
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per genomic order for financial planning and payer negotiation"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of genomic orders for budget tracking"
    - name: "avg_patient_responsibility"
      expr: AVG(CAST(patient_responsibility_amount AS DOUBLE))
      comment: "Average patient out-of-pocket responsibility for genomic testing - access equity metric"
    - name: "orders_with_prior_auth"
      expr: COUNT(CASE WHEN prior_authorization_status = 'approved' THEN 1 END)
      comment: "Number of orders with approved prior authorization for revenue cycle tracking"
    - name: "genetic_counseling_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN genetic_counseling_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders with genetic counseling completed - quality and compliance metric"
    - name: "cancelled_order_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN order_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of genomic orders cancelled - operational efficiency and access barrier indicator"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`genomics_genomic_variant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Variant-level analytics for clinical genomics programs tracking pathogenicity distribution, actionability, and variant classification quality."
  source: "`healthcare_ecm_v1`.`genomics`.`genomic_variant`"
  dimensions:
    - name: "clinical_significance"
      expr: clinical_significance
      comment: "ACMG clinical significance classification (pathogenic, likely pathogenic, VUS, likely benign, benign)"
    - name: "variant_type"
      expr: variant_type
      comment: "Type of genomic variant (SNV, indel, CNV, structural)"
    - name: "somatic_or_germline"
      expr: somatic_or_germline
      comment: "Whether variant is somatic (tumor-specific) or germline (inherited)"
    - name: "actionability_tier"
      expr: actionability_tier
      comment: "Clinical actionability tier classification (Tier 1-4 per AMP/ASCO/CAP guidelines)"
    - name: "gene_symbol"
      expr: gene_symbol
      comment: "HUGO gene symbol where variant is located"
    - name: "chromosome"
      expr: chromosome
      comment: "Chromosome location of the variant"
    - name: "interpretation_status"
      expr: interpretation_status
      comment: "Current interpretation review status (pending, reviewed, signed-out)"
    - name: "call_month"
      expr: DATE_TRUNC('MONTH', call_date)
      comment: "Month the variant was called for trend analysis"
  measures:
    - name: "total_variants_detected"
      expr: COUNT(1)
      comment: "Total number of genomic variants detected across all patients"
    - name: "pathogenic_variant_count"
      expr: COUNT(CASE WHEN clinical_significance = 'pathogenic' OR clinical_significance = 'likely_pathogenic' THEN 1 END)
      comment: "Number of pathogenic/likely pathogenic variants requiring clinical action"
    - name: "pathogenic_variant_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN clinical_significance = 'pathogenic' OR clinical_significance = 'likely_pathogenic' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of variants classified as pathogenic/likely pathogenic - clinical yield metric"
    - name: "vous_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN clinical_significance = 'uncertain_significance' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of variants of uncertain significance (VUS) - reclassification workload indicator"
    - name: "reportable_variant_count"
      expr: COUNT(CASE WHEN is_reportable = TRUE THEN 1 END)
      comment: "Number of variants meeting reporting criteria for clinical reports"
    - name: "incidental_finding_count"
      expr: COUNT(CASE WHEN is_incidental_finding = TRUE THEN 1 END)
      comment: "Number of incidental/secondary findings requiring patient disclosure decisions"
    - name: "avg_allele_frequency"
      expr: AVG(CAST(allele_frequency AS DOUBLE))
      comment: "Average variant allele frequency - quality indicator for variant calling sensitivity"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average variant quality score - sequencing and bioinformatics pipeline quality metric"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`genomics_sequencing_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sequencing laboratory operational metrics tracking run quality, throughput, and instrument utilization for genomics lab management."
  source: "`healthcare_ecm_v1`.`genomics`.`sequencing_run`"
  dimensions:
    - name: "platform"
      expr: platform
      comment: "Sequencing platform technology (Illumina NovaSeq, MiSeq, NextSeq, etc.)"
    - name: "sequencing_run_status"
      expr: sequencing_run_status
      comment: "Current status of the sequencing run (running, completed, failed, QC-failed)"
    - name: "run_type"
      expr: run_type
      comment: "Type of sequencing run (clinical, research, validation, proficiency)"
    - name: "qc_status"
      expr: qc_status
      comment: "Quality control pass/fail status of the run"
    - name: "is_clinical"
      expr: CAST(is_clinical AS STRING)
      comment: "Whether this is a clinical (CLIA-regulated) vs research run"
    - name: "run_month"
      expr: DATE_TRUNC('MONTH', run_start_timestamp)
      comment: "Month the sequencing run started for trend analysis"
  measures:
    - name: "total_sequencing_runs"
      expr: COUNT(1)
      comment: "Total number of sequencing runs - laboratory throughput baseline"
    - name: "qc_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN qc_status = 'pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sequencing runs passing QC - critical lab quality metric"
    - name: "failed_run_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sequencing_run_status = 'failed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of failed sequencing runs - cost and efficiency indicator"
    - name: "avg_q30_percent"
      expr: AVG(CAST(percent_q30 AS DOUBLE))
      comment: "Average percentage of bases with quality score >= Q30 - sequencing quality benchmark"
    - name: "avg_cluster_density"
      expr: AVG(CAST(cluster_density AS DOUBLE))
      comment: "Average cluster density per run - loading optimization metric"
    - name: "total_bases_generated"
      expr: SUM(CAST(total_bases_generated AS DOUBLE))
      comment: "Total sequencing output in bases - laboratory capacity metric"
    - name: "avg_run_duration_hours"
      expr: AVG(CAST(run_duration_hours AS DOUBLE))
      comment: "Average run duration in hours - instrument scheduling and throughput planning"
    - name: "avg_data_size_gb"
      expr: AVG(CAST(data_size_gb AS DOUBLE))
      comment: "Average data output per run in GB - storage capacity planning metric"
    - name: "repeat_run_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_repeat_run = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of runs that are repeats due to prior failures - waste and rework indicator"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`genomics_pharmacogenomics`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacogenomics program metrics tracking drug-gene interaction alerts, clinical actionability, and CDS integration effectiveness."
  source: "`healthcare_ecm_v1`.`genomics`.`pharmacogenomics`"
  dimensions:
    - name: "clinical_significance"
      expr: clinical_significance
      comment: "Clinical significance of the pharmacogenomic finding"
    - name: "phenotype"
      expr: phenotype
      comment: "Metabolizer phenotype (poor, intermediate, normal, rapid, ultra-rapid)"
    - name: "gene_name"
      expr: gene_name
      comment: "Pharmacogene name (CYP2D6, CYP2C19, DPYD, etc.)"
    - name: "recommendation_classification"
      expr: recommendation_classification
      comment: "CPIC recommendation strength classification"
    - name: "record_status"
      expr: record_status
      comment: "Status of the pharmacogenomics record"
    - name: "therapeutic_class"
      expr: therapeutic_class
      comment: "Drug therapeutic class affected by the pharmacogenomic finding"
    - name: "ehr_integration_status"
      expr: ehr_integration_status
      comment: "Status of EHR clinical decision support integration"
  measures:
    - name: "total_pgx_results"
      expr: COUNT(1)
      comment: "Total pharmacogenomics results - program volume metric"
    - name: "actionable_result_count"
      expr: COUNT(CASE WHEN is_actionable = TRUE THEN 1 END)
      comment: "Number of actionable pharmacogenomic results requiring prescribing changes"
    - name: "actionable_result_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_actionable = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PGx results that are clinically actionable - program value metric"
    - name: "cds_alert_trigger_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_cds_alert_triggered = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of results triggering CDS alerts - EHR integration effectiveness"
    - name: "cds_alert_override_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cds_alert_override_reason IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN is_cds_alert_triggered = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of CDS alerts overridden by clinicians - alert fatigue and appropriateness indicator"
    - name: "multi_gene_interaction_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_multi_gene_interaction = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of results involving multi-gene interactions - complexity indicator"
    - name: "avg_activity_score"
      expr: AVG(CAST(activity_score AS DOUBLE))
      comment: "Average enzyme activity score across pharmacogenomic results"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`genomics_precision_treatment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Precision medicine treatment plan metrics tracking therapy selection, molecular tumor board utilization, and treatment response for oncology program management."
  source: "`healthcare_ecm_v1`.`genomics`.`precision_treatment_plan`"
  dimensions:
    - name: "precision_treatment_plan_status"
      expr: precision_treatment_plan_status
      comment: "Current status of the precision treatment plan (active, completed, discontinued)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of precision treatment plan (targeted therapy, immunotherapy, combination)"
    - name: "evidence_level"
      expr: evidence_level
      comment: "Level of evidence supporting the treatment selection (Level 1-4)"
    - name: "intent"
      expr: intent
      comment: "Treatment intent (curative, palliative, adjuvant, neoadjuvant)"
    - name: "cancer_stage"
      expr: cancer_stage
      comment: "Cancer stage at time of treatment plan creation"
    - name: "microsatellite_instability_status"
      expr: microsatellite_instability_status
      comment: "MSI status (MSI-H, MSS, MSI-L) driving immunotherapy eligibility"
    - name: "line_of_therapy"
      expr: line_of_therapy
      comment: "Line of therapy (first-line, second-line, etc.)"
  measures:
    - name: "total_precision_plans"
      expr: COUNT(1)
      comment: "Total precision treatment plans created - program adoption metric"
    - name: "molecular_tumor_board_review_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN molecular_tumor_board_reviewed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of plans reviewed by molecular tumor board - governance and quality metric"
    - name: "clinical_trial_eligibility_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN clinical_trial_eligibility_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of patients eligible for clinical trials based on genomic profile - research opportunity metric"
    - name: "hereditary_risk_identification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN hereditary_risk_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of plans identifying hereditary cancer risk - cascade testing opportunity"
    - name: "avg_tumor_mutational_burden"
      expr: AVG(CAST(tumor_mutation_burden AS DOUBLE))
      comment: "Average tumor mutational burden across treatment plans - immunotherapy response predictor"
    - name: "avg_expected_response_rate"
      expr: AVG(CAST(expected_response_rate_percent AS DOUBLE))
      comment: "Average expected response rate for selected therapies - treatment selection quality"
    - name: "genetic_counseling_referral_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN genetic_counseling_recommended_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of plans recommending genetic counseling - patient support completeness"
    - name: "informed_consent_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN informed_consent_obtained_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of plans with documented informed consent - compliance metric"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`genomics_genomic_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Genomic consent management metrics tracking consent rates, scope, and revocation patterns for research governance and patient autonomy."
  source: "`healthcare_ecm_v1`.`genomics`.`genomic_consent`"
  dimensions:
    - name: "genomic_consent_status"
      expr: genomic_consent_status
      comment: "Current consent status (active, revoked, expired, pending)"
    - name: "consent_type"
      expr: consent_type
      comment: "Type of genomic consent (clinical testing, research, biobank, data sharing)"
    - name: "signing_method"
      expr: signing_method
      comment: "Method of consent signature (electronic, paper, verbal)"
    - name: "consent_language"
      expr: consent_language
      comment: "Language in which consent was provided - health equity metric"
    - name: "consent_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month consent became effective for trend analysis"
  measures:
    - name: "total_consents"
      expr: COUNT(1)
      comment: "Total genomic consent records - program enrollment baseline"
    - name: "active_consent_count"
      expr: COUNT(CASE WHEN genomic_consent_status = 'active' THEN 1 END)
      comment: "Number of currently active genomic consents"
    - name: "revocation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN genomic_consent_status = 'revoked' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consents revoked - patient trust and communication effectiveness indicator"
    - name: "research_use_authorization_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN allows_research_use = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of patients authorizing research use of genomic data - biobank growth potential"
    - name: "data_sharing_authorization_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN allows_data_sharing = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of patients authorizing data sharing - collaborative research enablement"
    - name: "biobank_storage_authorization_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN allows_biobank_storage = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of patients authorizing biobank specimen storage - biorepository growth metric"
    - name: "genetic_counseling_provided_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN genetic_counseling_provided = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consents with genetic counseling provided - informed consent quality metric"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`genomics_precision_medicine_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Precision medicine reporting metrics for oncology and rare disease programs tracking clinical utility, trial matching, and therapeutic implications."
  source: "`healthcare_ecm_v1`.`genomics`.`precision_medicine_report`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Current status of the precision medicine report (draft, final, amended)"
    - name: "report_type"
      expr: report_type
      comment: "Type of precision medicine report (comprehensive genomic profiling, liquid biopsy, hereditary)"
    - name: "evidence_level"
      expr: evidence_level
      comment: "Highest evidence level of findings in the report"
    - name: "microsatellite_instability_status"
      expr: microsatellite_instability_status
      comment: "MSI status for immunotherapy eligibility assessment"
    - name: "specimen_type"
      expr: specimen_type
      comment: "Specimen type used for testing (tissue, blood, bone marrow)"
    - name: "report_month"
      expr: DATE_TRUNC('MONTH', report_issued_timestamp)
      comment: "Month report was issued for volume trending"
  measures:
    - name: "total_precision_reports"
      expr: COUNT(1)
      comment: "Total precision medicine reports issued - program volume and growth metric"
    - name: "clinical_trial_eligibility_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN clinical_trial_eligibility_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of patients with clinical trial eligibility based on genomic findings"
    - name: "molecular_tumor_board_review_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN molecular_tumor_board_reviewed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports reviewed by molecular tumor board - quality governance metric"
    - name: "avg_tumor_mutational_burden"
      expr: AVG(CAST(tumor_mutational_burden AS DOUBLE))
      comment: "Average TMB across reports - immunotherapy candidacy population metric"
    - name: "avg_genomic_instability_score"
      expr: AVG(CAST(genomic_instability_score AS DOUBLE))
      comment: "Average genomic instability score - HRD and PARP inhibitor eligibility indicator"
    - name: "avg_mean_sequencing_depth"
      expr: AVG(CAST(mean_sequencing_depth AS DOUBLE))
      comment: "Average sequencing depth across reports - analytical quality metric"
    - name: "incidental_findings_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN incidental_findings_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports with incidental findings requiring patient disclosure"
    - name: "genetic_counseling_recommendation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN genetic_counseling_recommended_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports recommending genetic counseling referral"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`genomics_gene_expression`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gene expression analytics for transcriptomic profiling programs tracking expression patterns, clinical significance, and biomarker discovery."
  source: "`healthcare_ecm_v1`.`genomics`.`gene_expression`"
  dimensions:
    - name: "expression_status"
      expr: expression_status
      comment: "Expression level status (overexpressed, underexpressed, normal)"
    - name: "clinical_significance"
      expr: clinical_significance
      comment: "Clinical significance of the expression finding"
    - name: "result_status"
      expr: result_status
      comment: "Result processing status (preliminary, final, amended)"
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of the expression result"
    - name: "tissue_type"
      expr: tissue_type
      comment: "Tissue type analyzed for expression profiling"
    - name: "assay_platform"
      expr: assay_platform
      comment: "Expression assay platform (RNA-seq, microarray, NanoString)"
    - name: "actionability_category"
      expr: actionability_category
      comment: "Clinical actionability category of the expression finding"
  measures:
    - name: "total_expression_results"
      expr: COUNT(1)
      comment: "Total gene expression results - transcriptomics program volume"
    - name: "outlier_expression_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_outlier = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of expression results flagged as outliers - potential biomarker discovery rate"
    - name: "avg_expression_value"
      expr: AVG(CAST(expression_value AS DOUBLE))
      comment: "Average expression value across results - baseline expression level"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score of expression measurements - analytical reliability metric"
    - name: "avg_rna_integrity_number"
      expr: AVG(CAST(rna_integrity_number AS DOUBLE))
      comment: "Average RNA integrity number - specimen quality indicator for expression validity"
    - name: "avg_log2_fold_change"
      expr: AVG(CAST(log2_fold_change AS DOUBLE))
      comment: "Average log2 fold change - magnitude of differential expression"
    - name: "significant_expression_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN p_value < 0.05 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of expression results reaching statistical significance"
$$;