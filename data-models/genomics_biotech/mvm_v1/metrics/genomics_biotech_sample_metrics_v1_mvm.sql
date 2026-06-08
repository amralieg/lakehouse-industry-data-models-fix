-- Metric views for domain: sample | Business: Genomics Biotech | Version: 1 | Generated on: 2026-05-06 15:25:46

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`sample_accession`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sample accession KPIs tracking receipt, turnaround time, and quality metrics for incoming specimens"
  source: "`genomics_biotech_ecm`.`sample`.`accession`"
  dimensions:
    - name: "accession_status"
      expr: accession_status
      comment: "Current status of the accession (e.g., received, processing, completed, rejected)"
    - name: "specimen_type"
      expr: specimen_type
      comment: "Type of biological specimen (e.g., blood, saliva, tissue)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification for processing (e.g., routine, urgent, stat)"
    - name: "arrival_condition"
      expr: arrival_condition
      comment: "Condition of specimen upon arrival (e.g., acceptable, compromised, rejected)"
    - name: "collection_site"
      expr: collection_site
      comment: "Site where specimen was collected"
    - name: "recollection_requested"
      expr: recollection_requested_flag
      comment: "Whether a recollection was requested due to quality issues"
    - name: "accessioning_month"
      expr: DATE_TRUNC('MONTH', accessioning_timestamp)
      comment: "Month when specimen was accessioned"
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_timestamp)
      comment: "Month when specimen was received"
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Code indicating reason for specimen rejection"
  measures:
    - name: "total_accessions"
      expr: COUNT(1)
      comment: "Total number of accessions received"
    - name: "total_volume_received_ml"
      expr: SUM(CAST(volume_received_ml AS DOUBLE))
      comment: "Total volume of specimens received in milliliters"
    - name: "avg_volume_received_ml"
      expr: AVG(CAST(volume_received_ml AS DOUBLE))
      comment: "Average volume received per accession in milliliters"
    - name: "avg_temperature_at_receipt_c"
      expr: AVG(CAST(temperature_at_receipt_c AS DOUBLE))
      comment: "Average temperature at receipt in Celsius, critical for specimen integrity"
    - name: "recollection_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN recollection_requested_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accessions requiring recollection, key quality indicator"
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN rejection_reason_code IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accessions rejected, critical quality metric"
    - name: "unique_patients"
      expr: COUNT(DISTINCT patient_id)
      comment: "Number of unique patients with accessions"
    - name: "unique_collection_sites"
      expr: COUNT(DISTINCT collection_site)
      comment: "Number of unique collection sites submitting specimens"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`sample_aliquot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aliquot quality and inventory KPIs tracking sample preparation, QC metrics, and storage utilization"
  source: "`genomics_biotech_ecm`.`sample`.`aliquot`"
  dimensions:
    - name: "aliquot_type"
      expr: aliquot_type
      comment: "Type of aliquot (e.g., DNA, RNA, plasma)"
    - name: "qc_status"
      expr: qc_status
      comment: "Quality control status (e.g., passed, failed, pending)"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle state (e.g., active, consumed, archived)"
    - name: "specimen_type"
      expr: specimen_type
      comment: "Type of specimen the aliquot was derived from"
    - name: "purpose"
      expr: purpose
      comment: "Intended use of the aliquot (e.g., sequencing, validation, research)"
    - name: "aliquoting_month"
      expr: DATE_TRUNC('MONTH', aliquoting_timestamp)
      comment: "Month when aliquot was created"
    - name: "container_status"
      expr: container_status
      comment: "Status of the container holding the aliquot"
  measures:
    - name: "total_aliquots"
      expr: COUNT(1)
      comment: "Total number of aliquots created"
    - name: "total_volume_ul"
      expr: SUM(CAST(volume_ul AS DOUBLE))
      comment: "Total volume of all aliquots in microliters"
    - name: "avg_volume_ul"
      expr: AVG(CAST(volume_ul AS DOUBLE))
      comment: "Average aliquot volume in microliters"
    - name: "avg_concentration"
      expr: AVG(CAST(concentration AS DOUBLE))
      comment: "Average concentration across aliquots, key quality metric"
    - name: "avg_purity_260_280"
      expr: AVG(CAST(purity_ratio_260_280 AS DOUBLE))
      comment: "Average 260/280 purity ratio, critical DNA/RNA quality indicator"
    - name: "avg_purity_260_230"
      expr: AVG(CAST(purity_ratio_260_230 AS DOUBLE))
      comment: "Average 260/230 purity ratio, indicates contamination levels"
    - name: "avg_rin_score"
      expr: AVG(CAST(rin_score AS DOUBLE))
      comment: "Average RNA Integrity Number, critical for RNA quality assessment"
    - name: "avg_dna_integrity_number"
      expr: AVG(CAST(dna_integrity_number AS DOUBLE))
      comment: "Average DNA Integrity Number, measures DNA degradation"
    - name: "qc_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN qc_status = 'passed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of aliquots passing QC, key quality indicator"
    - name: "avg_storage_temperature_c"
      expr: AVG(CAST(storage_temperature_c AS DOUBLE))
      comment: "Average storage temperature in Celsius, critical for sample integrity"
    - name: "unique_parent_specimens"
      expr: COUNT(DISTINCT sample_specimen_id)
      comment: "Number of unique parent specimens aliquoted"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`sample_extraction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nucleic acid extraction KPIs tracking yield, purity, and process efficiency"
  source: "`genomics_biotech_ecm`.`sample`.`extraction`"
  dimensions:
    - name: "extraction_method"
      expr: extraction_method
      comment: "Method used for extraction (e.g., magnetic bead, column-based)"
    - name: "nucleic_acid_type"
      expr: nucleic_acid_type
      comment: "Type of nucleic acid extracted (DNA, RNA, cfDNA)"
    - name: "qc_status"
      expr: qc_status
      comment: "Quality control status of extraction"
    - name: "input_material_type"
      expr: input_material_type
      comment: "Type of input material (e.g., whole blood, tissue, saliva)"
    - name: "intended_use"
      expr: intended_use
      comment: "Intended downstream application (e.g., WGS, targeted sequencing)"
    - name: "extraction_month"
      expr: DATE_TRUNC('MONTH', extraction_timestamp)
      comment: "Month when extraction was performed"
    - name: "contamination_detected"
      expr: contamination_flag
      comment: "Whether contamination was detected"
  measures:
    - name: "total_extractions"
      expr: COUNT(1)
      comment: "Total number of extractions performed"
    - name: "avg_concentration_ng_ul"
      expr: AVG(CAST(concentration_ng_per_ul AS DOUBLE))
      comment: "Average concentration in ng/µL, key yield metric"
    - name: "avg_total_yield_ng"
      expr: AVG(CAST(total_yield_ng AS DOUBLE))
      comment: "Average total yield in nanograms, critical efficiency metric"
    - name: "total_yield_ng"
      expr: SUM(CAST(total_yield_ng AS DOUBLE))
      comment: "Total nucleic acid yield across all extractions"
    - name: "avg_purity_260_280"
      expr: AVG(CAST(a260_a280_ratio AS DOUBLE))
      comment: "Average 260/280 absorbance ratio, protein contamination indicator"
    - name: "avg_purity_260_230"
      expr: AVG(CAST(a260_a230_ratio AS DOUBLE))
      comment: "Average 260/230 absorbance ratio, organic contamination indicator"
    - name: "avg_rin_score"
      expr: AVG(CAST(rin_score AS DOUBLE))
      comment: "Average RNA Integrity Number for RNA extractions"
    - name: "avg_dv200_pct"
      expr: AVG(CAST(dv200_percentage AS DOUBLE))
      comment: "Average DV200 percentage, measures RNA fragment size distribution"
    - name: "qc_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN qc_status = 'passed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of extractions passing QC, critical quality metric"
    - name: "contamination_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN contamination_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of extractions with detected contamination"
    - name: "avg_input_volume_ul"
      expr: AVG(CAST(input_volume_ul AS DOUBLE))
      comment: "Average input volume in microliters"
    - name: "avg_elution_volume_ul"
      expr: AVG(CAST(elution_volume_ul AS DOUBLE))
      comment: "Average elution volume in microliters"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`sample_qc_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality control measurement KPIs tracking assay performance, specification compliance, and out-of-spec rates"
  source: "`genomics_biotech_ecm`.`sample`.`qc_measurement`"
  dimensions:
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the QC measurement (e.g., approved, pending, rejected)"
    - name: "control_type"
      expr: control_type
      comment: "Type of control sample (e.g., positive, negative, blank)"
    - name: "specimen_type"
      expr: specimen_type
      comment: "Type of specimen measured"
    - name: "pass_fail_status"
      expr: pass_fail_flag
      comment: "Whether measurement passed or failed specifications"
    - name: "is_control_sample"
      expr: control_sample_flag
      comment: "Whether this is a control sample measurement"
    - name: "repeat_measurement"
      expr: repeat_measurement_flag
      comment: "Whether this is a repeat measurement"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month when measurement was performed"
    - name: "below_lod"
      expr: lod_flag
      comment: "Whether measurement was below limit of detection"
  measures:
    - name: "total_measurements"
      expr: COUNT(1)
      comment: "Total number of QC measurements performed"
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across all measurements"
    - name: "avg_concentration_ng_ul"
      expr: AVG(CAST(concentration_ng_ul AS DOUBLE))
      comment: "Average concentration in ng/µL"
    - name: "avg_rin_score"
      expr: AVG(CAST(rin_score AS DOUBLE))
      comment: "Average RNA Integrity Number"
    - name: "avg_din_score"
      expr: AVG(CAST(din_score AS DOUBLE))
      comment: "Average DNA Integrity Number"
    - name: "avg_purity_260_280"
      expr: AVG(CAST(a260_a280_ratio AS DOUBLE))
      comment: "Average 260/280 purity ratio"
    - name: "avg_purity_260_230"
      expr: AVG(CAST(a260_a230_ratio AS DOUBLE))
      comment: "Average 260/230 purity ratio"
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pass_fail_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measurements passing specifications, critical quality KPI"
    - name: "repeat_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN repeat_measurement_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measurements requiring repeat, efficiency indicator"
    - name: "below_lod_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN lod_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measurements below limit of detection"
    - name: "unique_specimens_measured"
      expr: COUNT(DISTINCT sample_specimen_id)
      comment: "Number of unique specimens with QC measurements"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`sample_run_sample`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sequencing run sample KPIs tracking coverage, quality, and resequencing rates"
  source: "`genomics_biotech_ecm`.`sample`.`run_sample`"
  dimensions:
    - name: "run_qc_status"
      expr: run_qc_status
      comment: "QC status of the run sample (e.g., passed, failed, pending)"
    - name: "resequencing_required"
      expr: resequencing_required
      comment: "Whether sample requires resequencing"
    - name: "lane_number"
      expr: lane_number
      comment: "Sequencing lane number"
    - name: "pool_position"
      expr: pool_position
      comment: "Position in the sequencing pool"
    - name: "run_month"
      expr: DATE_TRUNC('MONTH', assigned_timestamp)
      comment: "Month when sample was assigned to run"
  measures:
    - name: "total_run_samples"
      expr: COUNT(1)
      comment: "Total number of samples sequenced"
    - name: "avg_coverage_depth"
      expr: AVG(CAST(actual_coverage_depth AS DOUBLE))
      comment: "Average sequencing coverage depth, critical quality metric"
    - name: "avg_reads_generated"
      expr: AVG(CAST(actual_reads_generated AS DOUBLE))
      comment: "Average number of reads generated per sample"
    - name: "total_reads_generated"
      expr: SUM(CAST(actual_reads_generated AS DOUBLE))
      comment: "Total reads generated across all samples"
    - name: "avg_percent_aligned"
      expr: AVG(CAST(percent_aligned AS DOUBLE))
      comment: "Average percentage of reads aligned to reference genome"
    - name: "avg_percent_q30"
      expr: AVG(CAST(percent_q30 AS DOUBLE))
      comment: "Average percentage of bases with Q30+ quality score, key quality indicator"
    - name: "avg_duplicate_rate"
      expr: AVG(CAST(duplicate_rate AS DOUBLE))
      comment: "Average PCR duplicate rate, library quality metric"
    - name: "resequencing_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN resequencing_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of samples requiring resequencing, critical efficiency and cost metric"
    - name: "qc_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN run_qc_status = 'passed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of run samples passing QC"
    - name: "avg_loading_concentration_nm"
      expr: AVG(CAST(loading_concentration_nm AS DOUBLE))
      comment: "Average loading concentration in nanomolar"
    - name: "unique_specimens_sequenced"
      expr: COUNT(DISTINCT sample_specimen_id)
      comment: "Number of unique specimens sequenced"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`sample_specimen`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sample specimen lifecycle KPIs tracking quality, consent, and processing metrics"
  source: "`genomics_biotech_ecm`.`sample`.`sample_specimen`"
  dimensions:
    - name: "specimen_type"
      expr: specimen_type
      comment: "Type of biological specimen"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle state (e.g., active, consumed, archived, disposed)"
    - name: "consent_status"
      expr: consent_status
      comment: "Consent status for specimen use"
    - name: "priority_level"
      expr: priority_level
      comment: "Processing priority level"
    - name: "nucleic_acid_type"
      expr: nucleic_acid_type
      comment: "Type of nucleic acid (DNA, RNA, cfDNA)"
    - name: "collection_method"
      expr: collection_method
      comment: "Method used to collect specimen"
    - name: "phi_deidentified"
      expr: phi_deidentified
      comment: "Whether PHI has been deidentified"
    - name: "collection_month"
      expr: DATE_TRUNC('MONTH', collection_timestamp)
      comment: "Month when specimen was collected"
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', received_timestamp)
      comment: "Month when specimen was received"
    - name: "rejection_reason"
      expr: rejection_reason
      comment: "Reason for specimen rejection if applicable"
  measures:
    - name: "total_specimens"
      expr: COUNT(1)
      comment: "Total number of specimens"
    - name: "total_volume_ul"
      expr: SUM(CAST(volume_ul AS DOUBLE))
      comment: "Total specimen volume in microliters"
    - name: "avg_volume_ul"
      expr: AVG(CAST(volume_ul AS DOUBLE))
      comment: "Average specimen volume in microliters"
    - name: "avg_concentration_ng_ul"
      expr: AVG(CAST(concentration_ng_ul AS DOUBLE))
      comment: "Average concentration in ng/µL"
    - name: "avg_rin_score"
      expr: AVG(CAST(rin_score AS DOUBLE))
      comment: "Average RNA Integrity Number"
    - name: "avg_dna_integrity_number"
      expr: AVG(CAST(dna_integrity_number AS DOUBLE))
      comment: "Average DNA Integrity Number"
    - name: "avg_purity_260_280"
      expr: AVG(CAST(a260_a280_ratio AS DOUBLE))
      comment: "Average 260/280 purity ratio"
    - name: "avg_tumor_content_pct"
      expr: AVG(CAST(tumor_content_pct AS DOUBLE))
      comment: "Average tumor content percentage for oncology specimens"
    - name: "avg_storage_temperature_c"
      expr: AVG(CAST(storage_temperature_c AS DOUBLE))
      comment: "Average storage temperature in Celsius"
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN rejection_reason IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of specimens rejected, key quality indicator"
    - name: "consent_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_status = 'approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of specimens with approved consent"
    - name: "unique_subjects"
      expr: COUNT(DISTINCT subject_id)
      comment: "Number of unique subjects contributing specimens"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`sample_biobank_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Biobank storage capacity and utilization KPIs tracking operational efficiency and compliance"
  source: "`genomics_biotech_ecm`.`sample`.`biobank_location`"
  dimensions:
    - name: "storage_unit_type"
      expr: storage_unit_type
      comment: "Type of storage unit (e.g., freezer, LN2 tank, refrigerator)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status (e.g., active, maintenance, decommissioned)"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status (e.g., qualified, pending, expired)"
    - name: "is_gmp_controlled"
      expr: is_gmp_controlled
      comment: "Whether location is under GMP control"
    - name: "is_cryogenic"
      expr: is_cryogenic
      comment: "Whether location provides cryogenic storage"
    - name: "backup_power_protected"
      expr: backup_power_protected
      comment: "Whether location has backup power protection"
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in storage hierarchy (e.g., room, unit, rack, box)"
  measures:
    - name: "total_storage_locations"
      expr: COUNT(1)
      comment: "Total number of storage locations"
    - name: "avg_temperature_setpoint_c"
      expr: AVG(CAST(temperature_setpoint_c AS DOUBLE))
      comment: "Average temperature setpoint in Celsius"
    - name: "avg_temperature_min_c"
      expr: AVG(CAST(temperature_min_c AS DOUBLE))
      comment: "Average minimum temperature threshold"
    - name: "avg_temperature_max_c"
      expr: AVG(CAST(temperature_max_c AS DOUBLE))
      comment: "Average maximum temperature threshold"
    - name: "gmp_controlled_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_gmp_controlled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of locations under GMP control, regulatory compliance metric"
    - name: "backup_power_coverage_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN backup_power_protected = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of locations with backup power, risk mitigation metric"
    - name: "qualification_current_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN qualification_status = 'qualified' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of locations with current qualification, compliance metric"
    - name: "unique_lab_sites"
      expr: COUNT(DISTINCT lab_site_id)
      comment: "Number of unique lab sites with biobank locations"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`sample_cohort`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Research cohort KPIs tracking enrollment, diversity, and data access metrics"
  source: "`genomics_biotech_ecm`.`sample`.`cohort`"
  dimensions:
    - name: "cohort_type"
      expr: cohort_type
      comment: "Type of cohort (e.g., case-control, longitudinal, cross-sectional)"
    - name: "cohort_status"
      expr: cohort_status
      comment: "Current status (e.g., active, recruiting, closed, archived)"
    - name: "disease_focus"
      expr: disease_focus
      comment: "Primary disease or condition focus"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of cohort"
    - name: "privacy_tier"
      expr: privacy_tier
      comment: "Privacy tier classification"
    - name: "data_access_level"
      expr: data_access_level
      comment: "Data access level (e.g., open, controlled, restricted)"
    - name: "consent_required"
      expr: consent_required_flag
      comment: "Whether consent is required for cohort participation"
    - name: "deidentification_applied"
      expr: deidentification_flag
      comment: "Whether data is deidentified"
  measures:
    - name: "total_cohorts"
      expr: COUNT(1)
      comment: "Total number of cohorts"
    - name: "total_sample_count"
      expr: SUM(CAST(sample_count AS DOUBLE))
      comment: "Total samples across all cohorts"
    - name: "avg_sample_count"
      expr: AVG(CAST(sample_count AS DOUBLE))
      comment: "Average sample count per cohort, enrollment efficiency metric"
    - name: "active_cohort_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN cohort_status = 'active' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cohorts currently active"
    - name: "consent_required_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cohorts requiring consent, regulatory compliance metric"
    - name: "deidentified_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN deidentification_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cohorts with deidentified data, privacy compliance metric"
    - name: "unique_studies"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of unique studies associated with cohorts"
    - name: "unique_projects"
      expr: COUNT(DISTINCT project_id)
      comment: "Number of unique projects associated with cohorts"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`sample_subject`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Research subject KPIs tracking enrollment, consent, and diversity metrics"
  source: "`genomics_biotech_ecm`.`sample`.`subject`"
  dimensions:
    - name: "subject_status"
      expr: subject_status
      comment: "Current subject status (e.g., enrolled, active, withdrawn, completed)"
    - name: "subject_type"
      expr: subject_type
      comment: "Type of subject (e.g., patient, healthy control, family member)"
    - name: "biological_sex"
      expr: biological_sex
      comment: "Biological sex of subject"
    - name: "ancestry_group"
      expr: ancestry_group
      comment: "Ancestry group, critical for diversity metrics"
    - name: "disease_indication"
      expr: disease_indication
      comment: "Primary disease indication"
    - name: "collection_country"
      expr: collection_country
      comment: "Country where subject was enrolled"
    - name: "biobank_consent"
      expr: biobank_consent
      comment: "Whether subject consented to biobanking"
    - name: "genomic_data_sharing_consent"
      expr: genomic_data_sharing_consent
      comment: "Whether subject consented to genomic data sharing"
    - name: "incidental_findings_consent"
      expr: incidental_findings_consent
      comment: "Whether subject consented to receive incidental findings"
    - name: "gdpr_applicable"
      expr: gdpr_applicable
      comment: "Whether GDPR regulations apply"
    - name: "hipaa_applicable"
      expr: hipaa_applicable
      comment: "Whether HIPAA regulations apply"
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', subject_date)
      comment: "Month when subject was enrolled"
  measures:
    - name: "total_subjects"
      expr: COUNT(1)
      comment: "Total number of subjects enrolled"
    - name: "biobank_consent_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN biobank_consent = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of subjects consenting to biobanking, critical for sample availability"
    - name: "data_sharing_consent_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN genomic_data_sharing_consent = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage consenting to genomic data sharing, enables research collaboration"
    - name: "incidental_findings_consent_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN incidental_findings_consent = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage consenting to incidental findings return"
    - name: "recontact_consent_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN recontact_consent = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage consenting to future recontact, enables longitudinal studies"
    - name: "withdrawal_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN withdrawal_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of subjects who withdrew, retention metric"
    - name: "gdpr_applicable_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN gdpr_applicable = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of subjects under GDPR, regulatory compliance metric"
    - name: "hipaa_applicable_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN hipaa_applicable = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of subjects under HIPAA, regulatory compliance metric"
    - name: "unique_cohorts"
      expr: COUNT(DISTINCT cohort_id)
      comment: "Number of unique cohorts subjects are enrolled in"
    - name: "unique_studies"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of unique studies subjects participate in"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`sample_storage_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sample storage event KPIs tracking chain of custody, temperature excursions, and compliance"
  source: "`genomics_biotech_ecm`.`sample`.`storage_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of storage event (e.g., storage, retrieval, transfer, disposal)"
    - name: "event_status"
      expr: event_status
      comment: "Status of the event (e.g., completed, pending, failed)"
    - name: "storage_condition_code"
      expr: storage_condition_code
      comment: "Storage condition code (e.g., -80C, -20C, LN2)"
    - name: "temperature_excursion_detected"
      expr: temperature_excursion_flag
      comment: "Whether temperature excursion was detected"
    - name: "deviation_detected"
      expr: deviation_flag
      comment: "Whether deviation was detected"
    - name: "quarantine_status"
      expr: quarantine_flag
      comment: "Whether sample is quarantined"
    - name: "phi_deidentified"
      expr: phi_deidentified_flag
      comment: "Whether PHI is deidentified"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month when event occurred"
  measures:
    - name: "total_storage_events"
      expr: COUNT(1)
      comment: "Total number of storage events"
    - name: "avg_temperature_at_event_c"
      expr: AVG(CAST(temperature_at_event_c AS DOUBLE))
      comment: "Average temperature at event in Celsius"
    - name: "avg_required_temp_min_c"
      expr: AVG(CAST(required_temp_min_c AS DOUBLE))
      comment: "Average required minimum temperature"
    - name: "avg_required_temp_max_c"
      expr: AVG(CAST(required_temp_max_c AS DOUBLE))
      comment: "Average required maximum temperature"
    - name: "temperature_excursion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN temperature_excursion_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events with temperature excursions, critical quality and risk metric"
    - name: "deviation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN deviation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events with deviations, compliance metric"
    - name: "quarantine_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN quarantine_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of samples quarantined, quality control metric"
    - name: "electronic_acknowledgment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN electronic_acknowledgment_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events with electronic acknowledgment, audit trail metric"
    - name: "unique_specimens_handled"
      expr: COUNT(DISTINCT sample_specimen_id)
      comment: "Number of unique specimens involved in storage events"
    - name: "unique_containers_handled"
      expr: COUNT(DISTINCT container_id)
      comment: "Number of unique containers involved in storage events"
$$;