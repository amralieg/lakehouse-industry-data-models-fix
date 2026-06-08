-- Schema for Domain: genomics | Business:  | Version: v5_ecm
-- Generated on: 2026-05-21 09:45:15

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `healthcare_ecm_v1`.`genomics` COMMENT 'Manages precision medicine and clinical genomics data such as test orders, result summaries, clinical interpretations, and care pathway links, explicitly excluding detailed variant, biobank, and pharmacogenomics tables.';

-- ========= TABLES =========
CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`genomic_sequencing` (
    `genomic_sequencing_id` BIGINT COMMENT 'Primary key for genomic_sequencing',
    `mpi_record_id` BIGINT COMMENT 'description',
    CONSTRAINT pk_genomic_sequencing PRIMARY KEY(`genomic_sequencing_id`)
) COMMENT 'Table for genomic sequencing results';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`variant_interpretation` (
    `variant_interpretation_id` BIGINT COMMENT 'Primary key for variant_interpretation',
    `genomic_test_order_id` BIGINT COMMENT 'Identifier of the laboratory or genomic test order that produced the variant data being interpreted.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient for whom the variant interpretation was performed.',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider who ordered the genomic test leading to this interpretation.',
    `variant_interpreting_provider_clinician_id` BIGINT COMMENT 'Identifier of the clinical geneticist or molecular pathologist who performed the variant interpretation.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the genomic test was ordered or results were reviewed.',
    `acmg_classification` STRING COMMENT 'Five-tier clinical significance classification per ACMG/AMP guidelines: pathogenic, likely pathogenic, variant of uncertain significance (VUS), likely benign, or benign.',
    `allele_frequency` DECIMAL(18,2) COMMENT 'Minor allele frequency of the variant in the general population from gnomAD or similar population databases, used to assess rarity.',
    `amended_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent amendment to the interpretation report, if applicable.',
    `amendment_reason` STRING COMMENT 'Explanation for why the variant interpretation report was amended after initial finalization.',
    `associated_condition` STRING COMMENT 'Primary clinical condition or disease phenotype associated with the interpreted variant (e.g., Hereditary Breast and Ovarian Cancer Syndrome).',
    `chromosome` STRING COMMENT 'Chromosome on which the variant is located (e.g., chr17, chrX).',
    `clia_lab_number` STRING COMMENT 'CLIA certification number of the performing laboratory, required for regulatory compliance of clinical genomic testing.',
    `clinical_significance_summary` STRING COMMENT 'Free-text narrative summarizing the clinical significance of the variant in the context of the patients phenotype and family history.',
    `clinvar_accession` STRING COMMENT 'ClinVar submission accession number linking this interpretation to the NCBI ClinVar public archive of variant-disease relationships.',
    `computational_score` DECIMAL(18,2) COMMENT 'Numeric pathogenicity score from the primary computational prediction tool used (e.g., CADD PHRED score, REVEL score).',
    `computational_tool_used` STRING COMMENT 'Name and version of the primary computational prediction tool used to generate the pathogenicity score (e.g., CADD v1.6, REVEL, AlphaMissense).',
    `cosmic_accession` STRING COMMENT 'COSMIC identifier for somatic variants found in cancer genomes, applicable to tumor-related interpretations.',
    `dbsnp_rsid` STRING COMMENT 'dbSNP reference SNP cluster identifier (rsID) for the variant, enabling cross-referencing with public genomic databases.',
    `evidence_criteria_applied` STRING COMMENT 'Comma-separated list of ACMG/AMP evidence criteria codes applied to reach the classification (e.g., PVS1, PM2, PP3).',
    `family_segregation_data` STRING COMMENT 'Summary of family segregation analysis data indicating whether the variant co-segregates with disease in affected family members.',
    `functional_impact_prediction` STRING COMMENT 'Consensus in silico prediction of functional impact from computational tools such as SIFT, PolyPhen-2, CADD, or REVEL.',
    `gene_symbol` STRING COMMENT 'Official HGNC-approved gene symbol for the gene in which the variant was identified (e.g., BRCA1, TP53, EGFR).',
    `genetic_counseling_recommended` BOOLEAN COMMENT 'Indicates whether genetic counseling is recommended for the patient and/or family members based on this interpretation.',
    `genomic_position` BIGINT COMMENT 'Genomic coordinate position of the variant on the reference genome assembly.',
    `hgvs_coding_notation` STRING COMMENT 'HGVS-formatted coding DNA sequence notation describing the variant at the nucleotide level (e.g., c.5266dupC).',
    `hgvs_protein_notation` STRING COMMENT 'HGVS-formatted protein-level notation describing the predicted amino acid change (e.g., p.Gln1756ProfsTer74).',
    `inheritance_pattern` STRING COMMENT 'Mode of inheritance for the condition associated with the variant.',
    `interpretation_date` DATE COMMENT 'Date on which the clinical variant interpretation was completed and signed by the interpreting provider.',
    `interpretation_status` STRING COMMENT 'Current state of the variant interpretation report in its clinical workflow lifecycle.',
    `interpretation_type` STRING COMMENT 'Classification of the type of genomic variant interpretation being performed (germline hereditary, somatic tumor, pharmacogenomic, prenatal, or carrier screening).',
    `is_actionable` BOOLEAN COMMENT 'Indicates whether the variant interpretation has direct clinical actionability (e.g., changes management, qualifies for targeted therapy, or triggers surveillance recommendations).',
    `is_reportable` BOOLEAN COMMENT 'Indicates whether this variant meets criteria for inclusion in the clinical report to the ordering provider (true = reportable, false = not reported).',
    `is_secondary_finding` BOOLEAN COMMENT 'Indicates whether this variant represents an ACMG-recommended secondary finding unrelated to the primary test indication.',
    `performing_laboratory_name` STRING COMMENT 'Name of the CLIA-certified laboratory that performed the genomic sequencing and initial variant calling.',
    `population_database_source` STRING COMMENT 'Reference population database from which the allele frequency was obtained.',
    `read_depth` STRING COMMENT 'Total number of sequencing reads covering the variant position, indicating confidence in the variant call.',
    `reference_genome_build` STRING COMMENT 'Human reference genome assembly version used for variant coordinate mapping.',
    `report_issued_timestamp` TIMESTAMP COMMENT 'Timestamp when the finalized variant interpretation report was officially issued and made available to the ordering provider.',
    `report_number` STRING COMMENT 'Externally-known unique report number assigned to this variant interpretation report for clinical tracking and communication.',
    `review_notes` STRING COMMENT 'Internal notes from the variant review board or molecular tumor board discussion regarding this interpretation.',
    `specimen_type` STRING COMMENT 'Type of biological specimen from which the genomic DNA was extracted for sequencing.',
    `test_methodology` STRING COMMENT 'Laboratory methodology used to detect the variant (whole genome sequencing, whole exome sequencing, targeted gene panel, single gene test, FISH, or array CGH). [ENUM-REF-CANDIDATE: WGS|WES|targeted_panel|single_gene|FISH|array_CGH|RNA_seq — promote to reference product]',
    `test_panel_name` STRING COMMENT 'Name of the specific gene panel or test assay used (e.g., Comprehensive Cancer Panel, Hereditary Cardiac Panel).',
    `therapeutic_implication` STRING COMMENT 'Summary of therapeutic implications including targeted therapy eligibility, drug sensitivity or resistance, and clinical trial candidacy based on the variant.',
    `tier_classification` STRING COMMENT 'Four-tier classification for somatic variants per AMP/ASCO/CAP guidelines indicating level of clinical evidence for actionability. [ENUM-REF-CANDIDATE: tier_I_A|tier_I_B|tier_II_C|tier_II_D|tier_III|tier_IV — promote to reference product]',
    `tumor_mutational_burden` DECIMAL(18,2) COMMENT 'Tumor mutational burden measured in mutations per megabase, relevant for somatic variant interpretations and immunotherapy eligibility assessment.',
    `variant_allele_fraction` DECIMAL(18,2) COMMENT 'Proportion of sequencing reads supporting the variant allele at this position, indicating clonality in somatic contexts or confirming zygosity in germline contexts.',
    `variant_class` STRING COMMENT 'Structural classification of the genomic variant (single nucleotide variant, insertion, deletion, indel, copy number variant, or structural variant).',
    `zygosity` STRING COMMENT 'Zygosity state of the variant in the patient (heterozygous, homozygous, hemizygous, or compound heterozygous).',
    CONSTRAINT pk_variant_interpretation PRIMARY KEY(`variant_interpretation_id`)
) COMMENT 'Variant interpretation reports';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`genomic_sequence` (
    `genomic_sequence_id` BIGINT COMMENT 'Primary key for genomic_sequence',
    `care_site_id` BIGINT COMMENT 'Identifier of the laboratory facility that performed the genomic sequencing.',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider who ordered the genomic sequencing test.',
    `consent_record_id` BIGINT COMMENT 'Identifier of the patient consent record authorizing genomic testing and data use.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient whose genomic material was sequenced.',
    `specimen_id` BIGINT COMMENT 'Identifier of the biological specimen used for genomic sequencing.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the genomic test was ordered or collected.',
    `accession_number` STRING COMMENT 'Unique laboratory accession number assigned to the sequencing specimen for tracking and identification purposes.',
    `bioinformatics_pipeline_version` STRING COMMENT 'Version identifier of the bioinformatics analysis pipeline used for alignment, variant calling, and annotation.',
    `clinical_actionability` STRING COMMENT 'Assessment of whether the genomic findings have direct implications for clinical management or treatment decisions.',
    `collection_date` DATE COMMENT 'Date when the biological specimen was collected from the patient.',
    `cpt_code` STRING COMMENT 'CPT code used for billing the genomic sequencing procedure.',
    `external_lab_reference` STRING COMMENT 'Reference number assigned by an external reference laboratory if the sequencing was performed by a send-out lab.',
    `fhir_diagnostic_report_reference` STRING COMMENT 'FHIR resource identifier for the genomic diagnostic report, enabling interoperability with external systems.',
    `gene_panel_name` STRING COMMENT 'Name of the targeted gene panel used for sequencing, if applicable (e.g., hereditary cancer panel, cardiac panel).',
    `genes_tested_count` STRING COMMENT 'Total number of genes included in the sequencing panel or analysis.',
    `genetic_counseling_recommended` BOOLEAN COMMENT 'Indicates whether genetic counseling is recommended for the patient based on the sequencing results.',
    `genomic_sequence_status` STRING COMMENT 'Current lifecycle status of the genomic sequencing result within the laboratory workflow.',
    `hipaa_minimum_necessary_applied` BOOLEAN COMMENT 'Indicates whether the HIPAA minimum necessary standard was applied when disclosing or using the genomic data.',
    `indication` STRING COMMENT 'Clinical reason or diagnosis prompting the genomic sequencing order, typically an ICD-10 code or free-text clinical indication.',
    `interpreting_geneticist` STRING COMMENT 'Name or identifier of the board-certified clinical geneticist or molecular pathologist who interpreted and signed out the results.',
    `is_reportable` BOOLEAN COMMENT 'Indicates whether the sequencing result meets criteria for inclusion in the clinical report to the ordering provider.',
    `loinc_code` STRING COMMENT 'LOINC code representing the standardized identifier for the genomic test observation.',
    `mean_coverage_depth` DECIMAL(18,2) COMMENT 'Average sequencing read depth across the targeted regions, indicating the quality and reliability of the sequencing data.',
    `microsatellite_instability_status` STRING COMMENT 'Microsatellite instability status determined from sequencing data, a biomarker for immunotherapy response in oncology.',
    `notes` STRING COMMENT 'Free-text clinical notes or comments related to the genomic sequencing order, specimen, or results that provide additional context.',
    `overall_interpretation` STRING COMMENT 'Overall clinical interpretation of the genomic sequencing results categorizing the finding at a high level.',
    `passed_quality_control` BOOLEAN COMMENT 'Indicates whether the sequencing run met all quality control thresholds required for clinical reporting.',
    `pathogenicity_classification` STRING COMMENT 'ACMG five-tier classification of the most clinically significant variant identified in the sequencing results.',
    `percent_bases_above_20x` DECIMAL(18,2) COMMENT 'Percentage of targeted bases with sequencing coverage depth of 20x or greater, a key quality metric for clinical-grade sequencing.',
    `platform` STRING COMMENT 'The sequencing technology platform used to generate the data (e.g., Illumina NovaSeq, PacBio Sequel, Oxford Nanopore). [ENUM-REF-CANDIDATE: illumina_novaseq|illumina_hiseq|pacbio_sequel|oxford_nanopore|ion_torrent|bgi_dnbseq|element_aviti — promote to reference product]',
    `qc_failure_reason` STRING COMMENT 'Description of the reason for quality control failure, if the sequencing run did not pass QC thresholds.',
    `quality_score` DECIMAL(18,2) COMMENT 'Overall quality score for the sequencing run, typically a Phred-based metric indicating base-call accuracy.',
    `received_date` DATE COMMENT 'Date when the specimen was received by the performing laboratory.',
    `recommended_followup` STRING COMMENT 'Clinical follow-up actions recommended based on the genomic sequencing results, such as genetic counseling, cascade testing, or targeted therapy.',
    `reference_genome` STRING COMMENT 'Human reference genome assembly version used for alignment and variant calling (e.g., GRCh37/hg19, GRCh38/hg38).',
    `report_date` DATE COMMENT 'Date when the final genomic sequencing report was issued and made available to the ordering provider.',
    `report_format` STRING COMMENT 'Format in which the genomic sequencing report is delivered to the ordering provider or EHR system.',
    `research_use_authorized` BOOLEAN COMMENT 'Indicates whether the patient has authorized use of their genomic data for research purposes.',
    `result_summary` STRING COMMENT 'High-level narrative summary of the genomic sequencing findings, including key variants and clinical significance.',
    `retention_expiry_date` DATE COMMENT 'Date after which the genomic sequencing record is eligible for archival or deletion per HIPAA retention policy and state regulations.',
    `sequence_type` STRING COMMENT 'Classification of the genomic sequencing methodology used (e.g., whole genome sequencing, whole exome sequencing, targeted gene panel).',
    `sequencing_date` DATE COMMENT 'Date when the actual genomic sequencing run was performed on the instrument.',
    `specimen_type` STRING COMMENT 'Type of biological specimen from which genomic material was extracted for sequencing.',
    `test_code` STRING COMMENT 'Internal or standard code identifying the specific genomic test panel or assay ordered.',
    `test_name` STRING COMMENT 'Human-readable name of the genomic test or panel performed.',
    `tumor_mutational_burden` DECIMAL(18,2) COMMENT 'Tumor mutational burden measured as mutations per megabase, relevant for immunotherapy eligibility assessment in oncology genomics.',
    `tumor_normal_indicator` STRING COMMENT 'Indicates whether the sequencing was performed on tumor tissue only, paired tumor-normal, germline, or somatic analysis context.',
    `turnaround_days` STRING COMMENT 'Number of calendar days from specimen receipt to final report issuance, measuring laboratory operational efficiency.',
    `variants_detected_count` STRING COMMENT 'Total number of reportable variants detected in the sequencing analysis.',
    `patient_id` BIGINT COMMENT 'Medical Record Number linking the sequence to the patient.',
    `sample_id` STRING COMMENT 'Identifier of the biological sample from which the sequence was derived.',
    `file_path` STRING COMMENT 'Storage location URI for the sequence file (e.g., DBFS, S3).',
    `file_format` STRING COMMENT 'Standard file format of the genomic data.. Valid values are `FASTQ|BAM|CRAM|VCF|FASTA`',
    `sequencing_platform` STRING COMMENT 'Technology platform used to generate the sequence.. Valid values are `Illumina|PacBio|Oxford_Nanopore|Ion_Torrent|BGI`',
    `assay_type` STRING COMMENT 'Laboratory assay performed for sequencing.. Valid values are `Whole_Genome|Whole_Exome|Targeted|RNA-Seq|Methylation`',
    `coverage_depth` DECIMAL(18,2) COMMENT 'Average read depth coverage across the genome.',
    `total_reads` BIGINT COMMENT 'Total number of reads generated for the sequence.',
    `read_length_mean` DECIMAL(18,2) COMMENT 'Average length of reads in base pairs.',
    `quality_score_mean` DECIMAL(18,2) COMMENT 'Average base quality score (Phred) across reads.',
    `lab_id` BIGINT COMMENT 'Identifier of the laboratory that performed sequencing.',
    `order_id` BIGINT COMMENT 'Clinical order that requested the sequencing.',
    `status` STRING COMMENT 'Current lifecycle status of the sequence record.. Valid values are `available|archived|pending|failed|withdrawn`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sequence record was created in the system.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the sequence record.',
    `consent_obtained` BOOLEAN COMMENT 'Indicates whether patient consent for genomic testing was obtained.',
    `data_retention_policy` STRING COMMENT 'HIPAA-aligned retention period for the sequence data.. Valid values are `7_years|indefinite|custom`',
    `checksum` STRING COMMENT 'SHA-256 checksum for data integrity verification.. Valid values are `^[a-fA-F0-9]{64}$`',
    `file_size_bytes` BIGINT COMMENT 'Size of the sequence file in bytes.',
    `genomic_build_version` STRING COMMENT 'Version of the genomic build used for alignment.',
    `alignment_tool` STRING COMMENT 'Software tool used for aligning reads to reference.. Valid values are `BWA|Bowtie2|STAR|Minimap2`',
    `alignment_parameters` STRING COMMENT 'Command-line parameters used for alignment.',
    `is_primary_sequence` BOOLEAN COMMENT 'Indicates if this sequence is the primary reference for the patient.',
    `data_source` STRING COMMENT 'Origin system of the sequence data.. Valid values are `EHR|LIS|External|Research`',
    `privacy_classification` STRING COMMENT 'Classification level for privacy compliance.. Valid values are `restricted|confidential|public`',
    `version_number` STRING COMMENT 'Version of the sequence record for SCD Type 2 tracking.',
    `effective_from` TIMESTAMP COMMENT 'Timestamp when this version became effective.',
    `effective_to` TIMESTAMP COMMENT 'Timestamp when this version was superseded (null if current).',
    CONSTRAINT pk_genomic_sequence PRIMARY KEY(`genomic_sequence_id`)
) COMMENT 'Table storing genomic sequencing results.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`variant_annotation` (
    `variant_annotation_id` BIGINT COMMENT 'Primary key for variant_annotation',
    `genomic_test_order_id` BIGINT COMMENT 'Identifier of the clinical genomic test order that generated this variant finding.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient whose genomic sample produced this variant.',
    `clinician_id` BIGINT COMMENT 'Identifier of the ordering or interpreting provider responsible for this variant annotation.',
    `variant_reviewed_by_provider_clinician_id` BIGINT COMMENT 'Identifier of the molecular pathologist or geneticist who reviewed and approved this annotation.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which this genomic variant was identified or reported.',
    `acmg_classification_criteria` STRING COMMENT 'Comma-separated list of ACMG/AMP evidence criteria codes applied (e.g., PVS1, PM2, PP3) supporting the clinical significance determination.',
    `actionability_level` STRING COMMENT 'Level of clinical actionability evidence per ClinGen framework indicating strength of gene-disease-intervention relationship.',
    `allele_frequency_gnomad` DECIMAL(18,2) COMMENT 'Population allele frequency from the gnomAD database used to assess variant rarity.',
    `allele_frequency_population` STRING COMMENT 'Population or ethnic subgroup from which the allele frequency was derived (e.g., European, African, East Asian).',
    `allelic_depth` STRING COMMENT 'Number of sequencing reads supporting the alternate allele at this position.',
    `alternate_allele` STRING COMMENT 'The observed alternate allele differing from the reference at this position.',
    `annotation_notes` STRING COMMENT 'Additional free-text notes from the annotator or reviewer regarding variant context, limitations, or follow-up recommendations.',
    `annotation_source` STRING COMMENT 'Name and version of the annotation tool or pipeline used (e.g., VEP, ANNOVAR, SnpEff).',
    `annotation_source_version` STRING COMMENT 'Version of the reference databases used during annotation (e.g., ClinVar release date, gnomAD version).',
    `chromosome` STRING COMMENT 'Chromosome on which the variant is located, using standard nomenclature.',
    `clinical_significance` STRING COMMENT 'Clinical significance classification per ACMG/AMP guidelines for variant interpretation.',
    `clinical_trial_relevance` STRING COMMENT 'Description of any clinical trial eligibility implications based on this variant, supporting precision medicine enrollment.',
    `clinvar_accession` STRING COMMENT 'ClinVar accession number linking to the NCBI ClinVar database entry for this variant.',
    `cosmic_accession` STRING COMMENT 'COSMIC database identifier for somatic mutations relevant to oncology interpretation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this variant annotation record was first created in the system.',
    `dbsnp_rsid` STRING COMMENT 'dbSNP reference SNP cluster identifier (rsID) for this variant, if catalogued.',
    `disease_association` STRING COMMENT 'Disease or clinical condition associated with this variant per curated databases and literature.',
    `evidence_level` STRING COMMENT 'Strength of evidence supporting the clinical utility of this variant annotation per OncoKB or equivalent framework.',
    `functional_consequence` STRING COMMENT 'Predicted functional consequence of the variant on the gene product. [ENUM-REF-CANDIDATE: missense|nonsense|frameshift|splice_site|synonymous|intronic|start_loss|stop_loss|inframe_insertion|inframe_deletion|UTR — promote to reference product]',
    `gene_symbol` STRING COMMENT 'Official HGNC gene symbol where the variant is located (e.g., BRCA1, TP53, EGFR).',
    `genomic_position_end` BIGINT COMMENT 'End position of the variant on the chromosome; equals start position for single nucleotide variants.',
    `genomic_position_start` BIGINT COMMENT 'Start position of the variant on the chromosome in the reference genome coordinate system.',
    `hgvs_coding` STRING COMMENT 'HGVS nomenclature describing the variant at the coding DNA level (c. notation).',
    `hgvs_protein` STRING COMMENT 'HGVS nomenclature describing the predicted protein-level change (p. notation).',
    `inheritance_pattern` STRING COMMENT 'Mode of inheritance associated with the disease phenotype linked to this variant.',
    `interpretation_summary` STRING COMMENT 'Free-text clinical interpretation narrative summarizing the variant significance in the patient context.',
    `is_incidental_finding` BOOLEAN COMMENT 'Indicates whether this variant is an incidental or secondary finding unrelated to the primary test indication.',
    `is_reportable` BOOLEAN COMMENT 'Indicates whether this variant meets criteria for inclusion in the clinical genomics report.',
    `quality_score` DECIMAL(18,2) COMMENT 'Phred-scaled quality score from the variant caller indicating confidence in the variant call.',
    `reference_allele` STRING COMMENT 'The reference genome allele at the variant position.',
    `reference_genome_build` STRING COMMENT 'Version of the human reference genome assembly used for coordinate mapping.',
    `reported_date` DATE COMMENT 'Date when this variant annotation was included in the final clinical genomics report.',
    `review_date` DATE COMMENT 'Date when the variant annotation was reviewed and clinically validated.',
    `review_status` STRING COMMENT 'Current status of the variant annotation in the clinical review and sign-off workflow.',
    `sample_type` STRING COMMENT 'Indicates whether the variant was detected in germline (constitutional) or somatic (tumor) tissue.',
    `therapeutic_implication` STRING COMMENT 'Summary of therapeutic implications including drug sensitivity, resistance, or eligibility for targeted therapy.',
    `tier_classification` STRING COMMENT 'Tier classification for somatic variants per AMP/ASCO/CAP joint consensus guidelines for clinical reporting.',
    `total_read_depth` STRING COMMENT 'Total number of sequencing reads covering this genomic position, used to assess call confidence.',
    `transcript_accession` STRING COMMENT 'RefSeq or Ensembl transcript identifier used as the reference for annotation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this variant annotation record was last modified.',
    `variant_allele_fraction` DECIMAL(18,2) COMMENT 'Proportion of reads supporting the variant allele relative to total depth, critical for somatic variant assessment.',
    `variant_type` STRING COMMENT 'Classification of the type of genomic variant detected (e.g., single nucleotide variant, insertion, deletion, copy number variant).',
    `zygosity` STRING COMMENT 'Zygosity of the variant in the patient sample indicating allelic state.',
    CONSTRAINT pk_variant_annotation PRIMARY KEY(`variant_annotation_id`)
) COMMENT 'Table storing variant annotations and interpretations.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`genomic_variant` (
    `genomic_variant_id` BIGINT COMMENT 'Primary key for genomic_variant',
    `clinician_id` BIGINT COMMENT 'Identifier of the molecular pathologist or geneticist who performed clinical interpretation of this variant.',
    `genomic_test_order_id` BIGINT COMMENT 'Identifier of the genomic test order that produced this variant call.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient from whom the genomic specimen was obtained.',
    `specimen_id` BIGINT COMMENT 'Identifier of the biological specimen from which DNA/RNA was extracted for sequencing.',
    `actionability_tier` STRING COMMENT 'AMP/ASCO/CAP tier classification indicating the level of clinical evidence supporting actionability of the variant in treatment decisions.',
    `allele_frequency` DECIMAL(18,2) COMMENT 'Population allele frequency of this variant from reference databases such as gnomAD, expressed as a decimal between 0 and 1.',
    `allele_frequency_source` STRING COMMENT 'Reference population database from which the allele frequency was obtained.',
    `allelic_depth_alt` STRING COMMENT 'Number of sequencing reads supporting the alternate allele at this position.',
    `alternate_allele` STRING COMMENT 'Observed alternate allele differing from the reference genome at this position.',
    `annotation_source` STRING COMMENT 'Primary annotation database or tool used for variant effect prediction (e.g., VEP, SnpEff, ANNOVAR).',
    `assay_type` STRING COMMENT 'Type of genomic assay performed: whole genome sequencing (WGS), whole exome sequencing (WES), targeted gene panel, RNA sequencing, or methylation analysis.',
    `bioinformatics_pipeline_version` STRING COMMENT 'Version identifier of the bioinformatics analysis pipeline used for variant calling and annotation.',
    `call_date` DATE COMMENT 'Date on which the variant was initially called by the bioinformatics pipeline.',
    `chromosome` STRING COMMENT 'Chromosome on which the variant is located, using standard nomenclature (1-22, X, Y, MT).',
    `clinical_significance` STRING COMMENT 'ACMG/AMP five-tier classification of the variants clinical significance for patient care decisions.',
    `clinvar_accession` STRING COMMENT 'NCBI ClinVar variation identifier linking to curated clinical significance assessments.',
    `cosmic_accession` STRING COMMENT 'COSMIC database identifier for somatic mutations relevant to oncology.',
    `dbsnp_accession` STRING COMMENT 'NCBI dbSNP reference SNP cluster identifier (rsID) for known variants.',
    `disease_association` STRING COMMENT 'Primary disease or condition associated with this variant based on curated evidence from ClinVar, OMIM, or literature.',
    `evidence_level` STRING COMMENT 'Strength of clinical evidence supporting the variant-disease-drug association per AMP/ASCO/CAP guidelines.',
    `filter_status` STRING COMMENT 'Quality filter status indicating whether the variant passed bioinformatics pipeline quality thresholds.',
    `functional_impact` STRING COMMENT 'Predicted functional consequence of the variant on the gene product.',
    `gene_symbol` STRING COMMENT 'HUGO Gene Nomenclature Committee (HGNC) approved gene symbol where the variant is located.',
    `hgvs_coding` STRING COMMENT 'HGVS coding DNA sequence notation describing the variant at the transcript level (c. notation).',
    `hgvs_protein` STRING COMMENT 'HGVS protein-level notation describing the amino acid change resulting from the variant (p. notation).',
    `hipaa_retention_expiry_date` DATE COMMENT 'Date after which this genomic variant record may be eligible for de-identification or archival per HIPAA retention policies.',
    `inheritance_pattern` STRING COMMENT 'Mode of inheritance associated with the variant-disease relationship.',
    `interpretation_date` DATE COMMENT 'Date on which the clinical interpretation and significance classification was finalized.',
    `interpretation_status` STRING COMMENT 'Current status of clinical interpretation workflow for this variant call.',
    `is_incidental_finding` BOOLEAN COMMENT 'Indicates whether this variant is a secondary or incidental finding unrelated to the primary indication for testing.',
    `is_reportable` BOOLEAN COMMENT 'Indicates whether this variant meets criteria for inclusion in the clinical genomics report per laboratory reporting policies.',
    `notes` STRING COMMENT 'Free-text clinical notes or comments from the interpreting pathologist regarding this variants significance or context.',
    `panel_name` STRING COMMENT 'Name of the targeted gene panel used for sequencing, if applicable (e.g., FoundationOne CDx, Tempus xT).',
    `position_end` BIGINT COMMENT 'End position of the variant on the chromosome; equals position_start for single nucleotide variants.',
    `position_start` BIGINT COMMENT 'Start position of the variant on the chromosome in 1-based coordinate system.',
    `quality_score` DECIMAL(18,2) COMMENT 'Phred-scaled quality score representing confidence that the variant call is genuine and not an artifact.',
    `read_depth` STRING COMMENT 'Total number of sequencing reads covering the variant position, indicating confidence in the call.',
    `reference_allele` STRING COMMENT 'Reference genome allele at the variant position, expressed in standard nucleotide notation.',
    `reference_genome_build` STRING COMMENT 'Human reference genome assembly version used for alignment and variant calling.',
    `reported_date` DATE COMMENT 'Date on which the variant was included in a clinical genomics report delivered to the ordering provider.',
    `sequencing_platform` STRING COMMENT 'Next-generation sequencing platform or technology used to generate the variant call (e.g., Illumina NovaSeq, Ion Torrent, PacBio).',
    `somatic_or_germline` STRING COMMENT 'Classification of whether the variant is of somatic (tumor-acquired) or germline (inherited) origin.',
    `therapeutic_implication` STRING COMMENT 'Summary of therapeutic implications including drug sensitivity, resistance, or eligibility for targeted therapy based on this variant.',
    `transcript_accession` STRING COMMENT 'RefSeq or Ensembl transcript identifier used as the reference for variant annotation.',
    `tumor_type` STRING COMMENT 'Specific tumor or cancer type context in which this somatic variant was identified, if applicable.',
    `variant_allele_fraction` DECIMAL(18,2) COMMENT 'Proportion of reads supporting the alternate allele relative to total reads at this position, critical for somatic variant interpretation.',
    `variant_caller` STRING COMMENT 'Name and version of the variant calling software used (e.g., GATK HaplotypeCaller, Mutect2, Strelka2).',
    `variant_type` STRING COMMENT 'Classification of the genomic variant by structural category (e.g., single nucleotide variant, insertion, deletion, copy number variant, structural variant).',
    `zygosity` STRING COMMENT 'Zygosity state of the variant indicating whether one or both allele copies carry the variant.',
    CONSTRAINT pk_genomic_variant PRIMARY KEY(`genomic_variant_id`)
) COMMENT 'Table storing genomic variant calls.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`sequencing_run` (
    `sequencing_run_id` BIGINT COMMENT 'Primary key for sequencing_run',
    `care_site_id` BIGINT COMMENT 'Reference to the laboratory or genomics core facility where this sequencing run was performed.',
    `clinician_id` BIGINT COMMENT 'Reference to the clinician or provider who ordered the genomic test associated with this sequencing run.',
    `employee_id` BIGINT COMMENT 'Reference to the laboratory technician or operator who initiated and monitored this sequencing run.',
    `instrument_id` BIGINT COMMENT 'Reference to the sequencing instrument (e.g., Illumina NovaSeq, Oxford Nanopore) on which this run was performed.',
    `original_run_sequencing_run_id` BIGINT COMMENT 'Reference to the original sequencing run that this repeat run is intended to replace, if applicable.',
    `accession_number` STRING COMMENT 'Laboratory accession number linking this sequencing run to the originating test order in the Laboratory Information System (LIS).',
    `base_calling_software_version` STRING COMMENT 'Version of the base calling software (e.g., RTA, MinKNOW) used to convert raw signals to base calls.',
    `chemistry_version` STRING COMMENT 'Version of the sequencing chemistry or reagent kit used for this run, critical for quality assessment and reproducibility.',
    `clia_lab_number` STRING COMMENT 'CLIA certification number of the laboratory performing this clinical sequencing run, required for clinical genomics compliance.',
    `cluster_density` DECIMAL(18,2) COMMENT 'Density of clusters per square millimeter on the flow cell, a key metric for Illumina-based sequencing run optimization.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this sequencing run record was first created in the system.',
    `data_size_gb` DECIMAL(18,2) COMMENT 'Total size of the sequencing run output data in gigabytes, relevant for storage planning and data transfer.',
    `demultiplexing_status` STRING COMMENT 'Status of the demultiplexing process that separates pooled sample reads based on index sequences.',
    `error_rate_percent` DECIMAL(18,2) COMMENT 'Estimated error rate as a percentage, calculated from PhiX spike-in or other control metrics.',
    `failure_reason` STRING COMMENT 'Description of the reason for run failure or abort, if applicable, supporting root cause analysis.',
    `flow_cell_barcode` STRING COMMENT 'Unique identifier of the flow cell or chip used in this sequencing run, enabling lot traceability and quality correlation.',
    `flow_cell_type` STRING COMMENT 'Type or model of the flow cell used (e.g., S1, S2, S4 for NovaSeq; R9, R10 for Nanopore), affecting throughput and read characteristics.',
    `hipaa_retention_date` DATE COMMENT 'Date until which this sequencing run data must be retained per HIPAA and state medical record retention requirements.',
    `index_type` STRING COMMENT 'Type of indexing strategy used for sample demultiplexing in this sequencing run.',
    `instrument_serial_number` STRING COMMENT 'Manufacturer serial number of the sequencing instrument used for this run, supporting equipment traceability and maintenance tracking.',
    `is_clinical` BOOLEAN COMMENT 'Indicates whether this sequencing run is for clinical diagnostic purposes (true) versus research-only use (false), affecting regulatory requirements.',
    `is_paired_end` BOOLEAN COMMENT 'Indicates whether the sequencing run uses paired-end reads (true) or single-end reads (false).',
    `is_repeat_run` BOOLEAN COMMENT 'Indicates whether this run is a repeat of a previously failed or suboptimal run.',
    `loading_concentration_pm` DECIMAL(18,2) COMMENT 'Library loading concentration in picomolar (pM) used for this sequencing run.',
    `mean_quality_score` DECIMAL(18,2) COMMENT 'Average Phred quality score across all bases in the run, summarizing overall sequencing accuracy.',
    `notes` STRING COMMENT 'Free-text notes or comments recorded by laboratory staff regarding this sequencing run, including observations or deviations.',
    `number_of_lanes` STRING COMMENT 'Total number of lanes on the flow cell utilized in this sequencing run.',
    `output_folder_path` STRING COMMENT 'File system or cloud storage path where the raw sequencing output (BCL/FASTQ files) is stored.',
    `percent_aligned_phix` DECIMAL(18,2) COMMENT 'Percentage of reads aligned to the PhiX control genome, used for quality monitoring and error rate estimation.',
    `percent_clusters_passing_filter` DECIMAL(18,2) COMMENT 'Percentage of clusters that pass the quality filter, indicating the proportion of usable data from the run.',
    `percent_q30` DECIMAL(18,2) COMMENT 'Percentage of bases with a quality score of Q30 or higher, indicating the proportion of high-confidence base calls.',
    `percent_undetermined_reads` DECIMAL(18,2) COMMENT 'Percentage of reads that could not be assigned to a sample during demultiplexing, indicating index hopping or contamination.',
    `platform` STRING COMMENT 'The sequencing technology platform used for this run, indicating the underlying chemistry and detection method.',
    `qc_status` STRING COMMENT 'Quality control assessment outcome for the sequencing run, determining whether data meets release criteria.',
    `read_configuration` STRING COMMENT 'Configuration of the sequencing reads (e.g., 2x150, 1x100, 2x250), specifying paired-end or single-end and read lengths.',
    `read_length` STRING COMMENT 'The configured read length in base pairs for this sequencing run, determining the length of each sequenced fragment.',
    `reagent_kit_expiration_date` DATE COMMENT 'Expiration date of the reagent kit used, relevant for compliance and quality assurance.',
    `reagent_kit_lot_number` STRING COMMENT 'Lot number of the reagent kit used for this sequencing run, supporting supply chain traceability and quality investigations.',
    `run_duration_hours` DECIMAL(18,2) COMMENT 'Total elapsed time of the sequencing run in hours from start to completion.',
    `run_end_timestamp` TIMESTAMP COMMENT 'Date and time when the sequencing run completed or was terminated on the instrument.',
    `run_name` STRING COMMENT 'Human-readable name or label assigned to the sequencing run, typically following laboratory naming conventions for identification and tracking purposes.',
    `run_number` STRING COMMENT 'Externally-known unique business identifier for the sequencing run, used for cross-system reference and laboratory tracking.',
    `run_start_timestamp` TIMESTAMP COMMENT 'Date and time when the sequencing run was initiated on the instrument.',
    `run_type` STRING COMMENT 'Classification of the sequencing run by the type of genomic assay or application being performed.',
    `sequencing_run_status` STRING COMMENT 'Current lifecycle status of the sequencing run, tracking its progression from planning through completion or failure.',
    `total_bases_generated` BIGINT COMMENT 'Total number of bases (nucleotides) sequenced in this run, representing overall data yield.',
    `total_reads_generated` BIGINT COMMENT 'Total number of sequencing reads generated by this run, a primary throughput metric.',
    `total_samples` STRING COMMENT 'Total number of samples (libraries) loaded onto this sequencing run.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this sequencing run record was last modified.',
    `run_identifier` STRING COMMENT 'External business identifier or accession number assigned to the run by the laboratory.',
    `sample_id` BIGINT COMMENT 'Identifier of the biological sample processed in this run.',
    `patient_id` BIGINT COMMENT 'Identifier of the patient from whom the sample originated.',
    `run_status` STRING COMMENT 'Current lifecycle status of the sequencing run.. Valid values are `pending|running|completed|failed|canceled`',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the run started.',
    `end_timestamp` TIMESTAMP COMMENT 'Date and time when the run completed or was terminated.',
    `run_duration_seconds` STRING COMMENT 'Total elapsed time of the run in seconds.',
    `batch_number` STRING COMMENT 'Identifier for the batch of samples processed together.',
    `lane_count` STRING COMMENT 'Number of flowcell lanes used in the run.',
    `flowcell_id` STRING COMMENT 'Identifier of the flowcell hardware used.',
    `flowcell_type` STRING COMMENT 'Model or type of the flowcell (e.g., NovaSeq S4).',
    `library_prep_kit` STRING COMMENT 'Name of the library preparation kit.',
    `library_prep_kit_version` STRING COMMENT 'Version of the library preparation kit.',
    `total_reads` BIGINT COMMENT 'Total number of sequencing reads generated.',
    `total_bases` BIGINT COMMENT 'Aggregate number of bases sequenced (reads × read length).',
    `yield_gb` DECIMAL(18,2) COMMENT 'Total data output of the run in gigabytes.',
    `qc_pass` BOOLEAN COMMENT 'Indicates whether the run met predefined quality thresholds.',
    `operator_id` BIGINT COMMENT 'Identifier of the staff member who initiated or supervised the run.',
    `run_location` STRING COMMENT 'Physical location or lab where the run was performed.',
    `run_project_code` STRING COMMENT 'Code linking the run to a research or clinical project.',
    `sequencing_center_id` BIGINT COMMENT 'Identifier of the sequencing center or facility hosting the instrument.',
    `data_path` STRING COMMENT 'File system or object storage path where raw and processed data are stored.',
    `data_retention_policy` STRING COMMENT 'Policy name governing how long run data are retained (e.g., HIPAA_7yr).',
    `compliance_retention_days` STRING COMMENT 'Number of days required to retain the run data for regulatory compliance.',
    `is_control_run` BOOLEAN COMMENT 'Indicates whether the run is a control (quality assurance) run.',
    `control_type` STRING COMMENT 'Type of control sample used, if applicable.. Valid values are `positive|negative|none`',
    CONSTRAINT pk_sequencing_run PRIMARY KEY(`sequencing_run_id`)
) COMMENT 'Table storing sequencing run metadata.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` (
    `patient_genomic_profile_id` BIGINT COMMENT 'Primary key for patient_genomic_profile',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient to whom this genomic profile belongs.',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider who ordered the genomic test for this patient.',
    `patient_interpreting_provider_clinician_id` BIGINT COMMENT 'Identifier of the provider or genetic counselor who interpreted the genomic results.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the genomic test was ordered or results were discussed.',
    `accession_number` STRING COMMENT 'Unique laboratory accession number assigned to the genomic specimen and test order by the performing laboratory.',
    `actionable_variants_count` STRING COMMENT 'Number of clinically actionable variants identified that may influence treatment decisions or surveillance recommendations.',
    `amendment_reason` STRING COMMENT 'Reason for any amendment to the genomic profile or report, if the profile status has been amended.',
    `average_coverage_depth` DECIMAL(18,2) COMMENT 'Mean sequencing coverage depth achieved across the targeted regions, indicating data quality.',
    `care_pathway_recommendation` STRING COMMENT 'Recommended clinical care pathway based on genomic findings, such as enhanced surveillance, targeted therapy, or prophylactic intervention.',
    `clinical_significance_summary` STRING COMMENT 'Narrative summary of the clinical significance of the genomic findings, including actionable recommendations for care.',
    `clinical_trial_eligible_flag` BOOLEAN COMMENT 'Indicates whether the genomic profile qualifies the patient for enrollment in relevant clinical trials.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether informed consent for genomic testing and data use was obtained from the patient prior to testing.',
    `counseling_date` DATE COMMENT 'Date on which genetic counseling was provided to the patient regarding their genomic results.',
    `effective_date` DATE COMMENT 'Date from which this genomic profile is considered clinically valid and actionable for care decisions.',
    `expiration_date` DATE COMMENT 'Date after which the genomic profile may require re-evaluation due to evolving variant classification standards or new evidence.',
    `family_history_relevant_flag` BOOLEAN COMMENT 'Indicates whether the patient has a relevant family history that contributed to the decision to order genomic testing.',
    `genes_tested_count` STRING COMMENT 'Total number of genes included in the genomic test panel or analysis.',
    `genetic_counseling_completed_flag` BOOLEAN COMMENT 'Indicates whether the patient received genetic counseling before or after genomic testing.',
    `hereditary_risk_category` STRING COMMENT 'Categorization of the patients hereditary risk level based on genomic findings and family history.',
    `hipaa_retention_expiry_date` DATE COMMENT 'Date after which this genomic record may be eligible for archival or destruction per HIPAA and state retention requirements.',
    `indication_icd_code` STRING COMMENT 'ICD-10-CM diagnosis code representing the clinical indication for the genomic test.',
    `insurance_authorization_status` STRING COMMENT 'Status of insurance prior authorization for the genomic test.',
    `microsatellite_instability_status` STRING COMMENT 'Microsatellite instability status determined from genomic analysis, relevant for immunotherapy response prediction.',
    `mrn` STRING COMMENT 'Medical record number of the patient, used for cross-referencing with the Electronic Health Record (EHR) system.',
    `notes` STRING COMMENT 'Free-text clinical notes or additional context related to the genomic profile, including provider observations or patient-specific considerations.',
    `order_date` DATE COMMENT 'Date on which the genomic test was ordered by the provider.',
    `overall_interpretation` STRING COMMENT 'High-level clinical interpretation summarizing the genomic test findings.',
    `panel_name` STRING COMMENT 'Name of the gene panel used in the test, if applicable (e.g., Hereditary Cancer Panel, Cardiac Panel).',
    `pathogenicity_classification` STRING COMMENT 'ACMG/AMP five-tier classification of the most clinically significant variant identified in the profile.',
    `performing_laboratory_clia_number` STRING COMMENT 'CLIA certification number of the laboratory that performed the genomic test, ensuring regulatory compliance.',
    `performing_laboratory_name` STRING COMMENT 'Name of the CLIA-certified laboratory that performed the genomic sequencing and analysis.',
    `primary_condition_indication` STRING COMMENT 'Primary clinical condition or indication for which the genomic test was ordered (e.g., suspected hereditary breast cancer, pharmacogenomic dosing).',
    `profile_status` STRING COMMENT 'Current lifecycle status of the genomic profile from order through final interpretation.',
    `profile_type` STRING COMMENT 'Classification of the genomic profile by the type of testing performed.',
    `quality_score` DECIMAL(18,2) COMMENT 'Overall quality score of the genomic sequencing run, reflecting data reliability for clinical interpretation.',
    `reference_genome_build` STRING COMMENT 'Human reference genome assembly version used for variant calling and annotation.',
    `report_delivered_date` DATE COMMENT 'Date on which the final genomic report was delivered to the ordering provider or integrated into the EHR.',
    `report_format` STRING COMMENT 'Format in which the genomic test report was delivered to the ordering provider.',
    `research_consent_flag` BOOLEAN COMMENT 'Indicates whether the patient consented to use of their genomic data for research purposes.',
    `result_date` DATE COMMENT 'Date on which the genomic test results were finalized and reported by the performing laboratory.',
    `sequencing_platform` STRING COMMENT 'Technology platform used for genomic sequencing (e.g., Illumina NovaSeq, Ion Torrent, PacBio).',
    `specimen_collection_date` DATE COMMENT 'Date on which the biological specimen was collected from the patient for genomic testing.',
    `specimen_type` STRING COMMENT 'Type of biological specimen collected for genomic analysis.',
    `targeted_therapy_eligible_flag` BOOLEAN COMMENT 'Indicates whether the genomic findings suggest eligibility for a targeted therapy or precision medicine treatment.',
    `test_code` STRING COMMENT 'Standardized code identifying the genomic test, typically mapped to CPT or proprietary lab codes.',
    `test_name` STRING COMMENT 'Name of the specific genomic test or panel performed (e.g., Whole Exome Sequencing, BRCA1/2 Panel, Oncotype DX).',
    `tumor_mutational_burden` DECIMAL(18,2) COMMENT 'Tumor mutational burden score expressed as mutations per megabase, relevant for immunotherapy eligibility in oncology genomics.',
    `turnaround_days` STRING COMMENT 'Number of calendar days from specimen collection to final result reporting.',
    `variants_identified_count` STRING COMMENT 'Total number of reportable variants identified in the genomic analysis.',
    `patient_id` BIGINT COMMENT 'Identifier of the patient to whom this genomic profile belongs.',
    `profile_version` STRING COMMENT 'Version number of the genomic profile, incremented on each update.',
    `profile_creation_timestamp` TIMESTAMP COMMENT 'Date and time when the profile record was first created.',
    `profile_last_updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the profile.',
    `profile_effective_date` DATE COMMENT 'Date when the genomic profile becomes clinically effective.',
    `profile_expiration_date` DATE COMMENT 'Date when the profile is no longer considered valid (nullable).',
    `genomic_sequencing_date` DATE COMMENT 'Date on which the patients DNA was sequenced.',
    `genomic_sequencing_center` STRING COMMENT 'Laboratory or facility that performed the sequencing.',
    `genomic_sequencing_method` STRING COMMENT 'Technology used for sequencing (e.g., Next‑Generation Sequencing, Whole‑Exome, Whole‑Genome).. Valid values are `NGS|WES|WGS`',
    `genomic_reference_genome` STRING COMMENT 'Reference genome version used for alignment (e.g., GRCh38).',
    `clinical_interpretation_date` TIMESTAMP COMMENT 'Timestamp when the clinical interpretation of the genomic data was completed.',
    `clinical_interpretation_summary` STRING COMMENT 'Narrative summary of the clinical interpretation and its implications.',
    `risk_stratification_score` DECIMAL(18,2) COMMENT 'Numeric score indicating the patient’s risk based on genomic findings.',
    `risk_category` STRING COMMENT 'Risk category derived from the stratification score.. Valid values are `low|moderate|high|very_high`',
    `actionability_flag` BOOLEAN COMMENT 'Indicates whether the genomic findings have actionable clinical recommendations.',
    `actionability_summary` STRING COMMENT 'Brief description of recommended clinical actions.',
    `report_id` STRING COMMENT 'External identifier of the generated genomic report.',
    `report_version` STRING COMMENT 'Version string of the report, reflecting updates or revisions.',
    `report_release_date` DATE COMMENT 'Date the genomic report was released to the care team.',
    `report_url` STRING COMMENT 'Link to the electronic version of the genomic report.',
    `consent_status` STRING COMMENT 'Patient consent status for genomic data usage.. Valid values are `consented|revoked|pending`',
    `consent_date` DATE COMMENT 'Date when consent was obtained or last updated.',
    `data_retention_period_years` STRING COMMENT 'Number of years the genomic data must be retained per policy.',
    `genomic_data_file_path` STRING COMMENT 'File system or object storage path to the raw genomic data file.',
    `genomic_data_checksum` STRING COMMENT 'Checksum (e.g., SHA‑256) for data integrity verification.',
    `genomic_data_format` STRING COMMENT 'File format of the stored genomic data.. Valid values are `VCF|BAM|FASTQ`',
    `genomic_data_size_bytes` BIGINT COMMENT 'Size of the genomic data file in bytes.',
    `clinical_trial_association` STRING COMMENT 'Identifier of any clinical trial linked to this genomic profile.',
    `clinical_trial_status` STRING COMMENT 'Current status of the patient’s participation in the trial.. Valid values are `enrolled|completed|withdrawn`',
    `clinical_trial_enrollment_date` DATE COMMENT 'Date the patient enrolled in the associated clinical trial.',
    `clinical_trial_end_date` DATE COMMENT 'Date the patient completed or exited the trial.',
    `patient_age_at_sequencing` STRING COMMENT 'Patient age in years at the time of DNA sequencing.',
    `patient_sex` STRING COMMENT 'Sex of the patient as recorded in the EHR.. Valid values are `male|female|other|unknown`',
    `patient_ethnicity` STRING COMMENT 'Self‑identified ethnicity of the patient.',
    `patient_race` STRING COMMENT 'Self‑identified race of the patient.',
    `patient_family_history_flag` BOOLEAN COMMENT 'Indicates whether a relevant family history of disease exists.',
    `profile_name` STRING COMMENT 'Human‑readable name or label for the genomic profile.',
    `genomic_report_author` STRING COMMENT 'Name of the clinician or laboratory that authored the report.',
    `report_author_contact_email` STRING COMMENT 'Email address of the report author for follow‑up.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `report_author_contact_phone` STRING COMMENT 'Phone number of the report author.',
    `interpretation_confidence_score` DECIMAL(18,2) COMMENT 'Numeric confidence level of the clinical interpretation.',
    `interpretation_confidence_level` STRING COMMENT 'Qualitative confidence level derived from the score.. Valid values are `high|medium|low`',
    CONSTRAINT pk_patient_genomic_profile PRIMARY KEY(`patient_genomic_profile_id`)
) COMMENT 'Table linking patients to genomic profiles.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`sequencing_result` (
    `sequencing_result_id` BIGINT COMMENT 'Primary key for sequencing_result',
    `care_site_id` BIGINT COMMENT 'Identifier of the laboratory facility that performed the sequencing.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient whose specimen was sequenced.',
    `prior_result_sequencing_result_id` BIGINT COMMENT 'Reference to a previous sequencing result that this test is repeating, amending, or reflexing from.',
    `research_study_id` BIGINT COMMENT 'Identifier of an associated clinical trial if the sequencing was performed as part of a research protocol.',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider who ordered the genomic sequencing test.',
    `sequencing_interpreting_geneticist_clinician_id` BIGINT COMMENT 'Identifier of the clinical geneticist or molecular pathologist who interpreted and signed out the sequencing result.',
    `sequencing_run_id` BIGINT COMMENT 'Foreign key linking to genomics.sequencing_run. Business justification: New FK linking sequencing_result to the sequencing_run that produced it. One run produces many results. run_date is redundant as it can be obtained from sequencing_run.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the sequencing was ordered or resulted.',
    `accession_number` STRING COMMENT 'Unique laboratory-assigned identifier for the specimen and sequencing run, used to track the sample through the testing workflow.',
    `actionable_variants_count` STRING COMMENT 'Number of clinically actionable variants identified that may influence treatment decisions or clinical management.',
    `amended_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent amendment to the sequencing result, if the report was corrected or updated after initial release.',
    `amendment_reason` STRING COMMENT 'Explanation for why the sequencing result was amended after initial reporting (e.g., reclassification of variant, additional analysis).',
    `bioinformatics_pipeline_version` STRING COMMENT 'Version identifier of the bioinformatics analysis pipeline used for variant calling and annotation.',
    `clinical_significance_summary` STRING COMMENT 'Narrative summary of the clinical significance of the sequencing findings, including actionability and relevance to the patients condition.',
    `consent_status` STRING COMMENT 'Status of patient consent for genomic testing, including consent for incidental/secondary findings disclosure.',
    `cpt_code` STRING COMMENT 'CPT code representing the specific genomic sequencing procedure performed, used for billing and reimbursement.',
    `genes_tested_count` STRING COMMENT 'Total number of genes included in the sequencing panel or analysis.',
    `indication_code` STRING COMMENT 'ICD-10 diagnosis code representing the clinical indication for ordering the genomic sequencing test.',
    `indication_description` STRING COMMENT 'Free-text description of the clinical reason for ordering the sequencing test (e.g., suspected hereditary breast cancer, acute myeloid leukemia).',
    `insurance_authorization_number` STRING COMMENT 'Prior authorization number from the payer approving coverage for the genomic sequencing test.',
    `is_reflex_test` BOOLEAN COMMENT 'Indicates whether this sequencing was triggered as a reflex test based on a prior laboratory result (e.g., IHC loss triggering MSI sequencing).',
    `is_repeat_test` BOOLEAN COMMENT 'Indicates whether this sequencing was a repeat of a prior test due to quality failure, insufficient specimen, or clinical need for confirmation.',
    `loinc_code` STRING COMMENT 'LOINC code identifying the specific genomic test observation for interoperability and standardized reporting.',
    `mean_coverage_depth` DECIMAL(18,2) COMMENT 'Average sequencing read depth across the targeted regions, indicating the quality and reliability of the sequencing data.',
    `microsatellite_instability_status` STRING COMMENT 'Microsatellite instability classification derived from sequencing data, relevant for immunotherapy eligibility and Lynch syndrome screening.',
    `order_number` STRING COMMENT 'The clinical order number from the ordering system (e.g., Epic Beaker or Cerner PathNet) that initiated this sequencing test.',
    `overall_interpretation` STRING COMMENT 'High-level clinical interpretation summarizing whether clinically significant findings were identified.',
    `panel_name` STRING COMMENT 'Name of the gene panel or test panel used for targeted sequencing (e.g., Oncology 500 Gene Panel, Hereditary Cancer Panel).',
    `pathogenicity_classification` STRING COMMENT 'Highest-level ACMG/AMP variant pathogenicity classification found in this sequencing result.',
    `percent_bases_above_threshold` DECIMAL(18,2) COMMENT 'Percentage of targeted bases that achieved the minimum required coverage depth (typically 20x or 30x), indicating analytical completeness.',
    `platform` STRING COMMENT 'The sequencing technology platform used to generate the data (e.g., Illumina NovaSeq, PacBio Sequel).',
    `quality_flag` STRING COMMENT 'Quality control assessment outcome indicating whether the sequencing data meets minimum analytical validity thresholds.',
    `quality_score` DECIMAL(18,2) COMMENT 'Composite quality metric for the sequencing run reflecting base call accuracy, mapping quality, and coverage uniformity.',
    `reference_genome_build` STRING COMMENT 'Human reference genome assembly version used for read alignment and variant calling.',
    `report_pdf_url` STRING COMMENT 'Storage location or URL for the final clinical genomics report document in PDF format.',
    `result_date` DATE COMMENT 'Date the final sequencing result was reported and made available for clinical review.',
    `result_reported_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the final sequencing result was officially reported and released to the ordering provider.',
    `sample_adequacy` STRING COMMENT 'Assessment of whether the specimen provided sufficient quantity and quality of nucleic acid for reliable sequencing.',
    `secondary_findings_reported` BOOLEAN COMMENT 'Indicates whether ACMG-recommended secondary (incidental) findings were included in the report per patient consent preferences.',
    `sequencing_result_status` STRING COMMENT 'Current lifecycle status of the sequencing result within the laboratory workflow.',
    `specimen_collection_date` DATE COMMENT 'Date the biological specimen was collected from the patient.',
    `specimen_received_date` DATE COMMENT 'Date the specimen was received by the performing laboratory.',
    `specimen_type` STRING COMMENT 'Type of biological specimen from which DNA/RNA was extracted for sequencing.',
    `test_type` STRING COMMENT 'Classification of the genomic sequencing methodology used for this test.',
    `therapy_recommendation` STRING COMMENT 'Summary of targeted therapy or treatment recommendations based on the genomic findings, linking molecular results to precision medicine pathways.',
    `tumor_content_percent` DECIMAL(18,2) COMMENT 'Estimated percentage of tumor cells in the specimen, critical for interpreting variant allele frequencies in oncology sequencing.',
    `tumor_mutational_burden` DECIMAL(18,2) COMMENT 'Number of somatic mutations per megabase of sequenced DNA, used as a biomarker for immunotherapy response prediction in oncology.',
    `turnaround_days` STRING COMMENT 'Number of calendar days from specimen receipt to final result reporting, used for laboratory performance monitoring.',
    `variants_detected_count` STRING COMMENT 'Total number of reportable variants detected in the sequencing analysis.',
    CONSTRAINT pk_sequencing_result PRIMARY KEY(`sequencing_result_id`)
) COMMENT 'Table storing genomic sequencing results.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`genomic_consent` (
    `genomic_consent_id` BIGINT COMMENT 'Primary key for genomic_consent',
    `care_site_id` BIGINT COMMENT 'The healthcare facility or care site where the genomic consent was obtained.',
    `clinician_id` BIGINT COMMENT 'The healthcare provider or genetic counselor who obtained the genomic consent from the patient.',
    `mpi_record_id` BIGINT COMMENT 'The patient who is granting or withholding genomic consent.',
    `research_study_id` BIGINT COMMENT 'Identifier of the specific research study for which this genomic consent was obtained, if consent is study-specific rather than broad.',
    `visit_id` BIGINT COMMENT 'The clinical encounter during which the genomic consent was obtained, if applicable.',
    `allows_biobank_storage` BOOLEAN COMMENT 'Indicates whether the patient consents to long-term storage of their biological specimens in a biobank for future genomic studies.',
    `allows_commercial_use` BOOLEAN COMMENT 'Indicates whether the patient consents to their genomic data or specimens being used for commercial product development.',
    `allows_data_sharing` BOOLEAN COMMENT 'Indicates whether the patient consents to sharing their genomic data with external institutions, registries, or databases.',
    `allows_family_sharing` BOOLEAN COMMENT 'Indicates whether the patient consents to sharing relevant genomic findings with biological family members who may be at risk.',
    `allows_recontact` BOOLEAN COMMENT 'Indicates whether the patient consents to being recontacted about incidental or secondary findings from genomic analysis.',
    `allows_research_use` BOOLEAN COMMENT 'Indicates whether the patient consents to their genomic data being used for research purposes beyond immediate clinical care.',
    `allows_secondary_findings` BOOLEAN COMMENT 'Indicates whether the patient wishes to receive secondary or incidental genomic findings unrelated to the primary test indication.',
    `authorized_representative_name` STRING COMMENT 'Name of the legally authorized representative who signed on behalf of the patient (e.g., parent, guardian, healthcare proxy).',
    `consent_language` STRING COMMENT 'ISO 639-1 language code indicating the language in which the consent form was presented to and signed by the patient.',
    `consent_number` STRING COMMENT 'Externally-visible business identifier for the genomic consent document, used for tracking and correspondence.',
    `consent_type` STRING COMMENT 'Classification of the genomic consent scope indicating what category of genomic activity the patient is consenting to.',
    `consent_version` STRING COMMENT 'Version number of the consent form template used when the patient signed, enabling tracking of form revisions over time.',
    `counseling_date` DATE COMMENT 'Date on which genetic counseling was provided to the patient in connection with this consent.',
    `data_destruction_requested` BOOLEAN COMMENT 'Indicates whether the patient has requested destruction of their genomic data and specimens upon consent withdrawal.',
    `data_use_restriction` STRING COMMENT 'Specific restrictions or limitations placed by the patient on how their genomic data may be used, beyond the standard consent scope.',
    `document_storage_location` STRING COMMENT 'Reference path or location identifier where the signed consent document is stored in the document management system.',
    `effective_date` DATE COMMENT 'Date on which the genomic consent becomes legally binding and enforceable.',
    `expiration_date` DATE COMMENT 'Date on which the genomic consent expires if not renewed. Null indicates open-ended consent.',
    `genetic_counseling_provided` BOOLEAN COMMENT 'Indicates whether the patient received genetic counseling prior to or as part of the consent process.',
    `genomic_consent_status` STRING COMMENT 'Current lifecycle state of the genomic consent record indicating whether it is currently in force.',
    `gina_protections_disclosed` BOOLEAN COMMENT 'Indicates whether the patient was informed about GINA protections against genetic discrimination in employment and health insurance.',
    `hipaa_authorization_included` BOOLEAN COMMENT 'Indicates whether a HIPAA-compliant authorization for use and disclosure of PHI is included as part of this genomic consent.',
    `irb_protocol_number` STRING COMMENT 'IRB protocol number under which this genomic consent was approved, linking to the governing research oversight.',
    `minor_assent_obtained` BOOLEAN COMMENT 'Indicates whether assent was obtained from a minor patient in addition to parental or guardian consent.',
    `notes` STRING COMMENT 'Additional free-text notes or comments related to the consent process, special circumstances, or patient questions.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this genomic consent record was first created in the data platform.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this genomic consent record was last modified in the data platform.',
    `representative_relationship` STRING COMMENT 'Relationship of the authorized representative to the patient, establishing legal authority to consent.',
    `retention_period_years` STRING COMMENT 'Number of years the patient has consented for their genomic data and specimens to be retained.',
    `revocation_date` DATE COMMENT 'Date on which the patient formally revoked their genomic consent, if applicable.',
    `scope_description` STRING COMMENT 'Free-text narrative describing the specific scope and boundaries of the genomic consent, including permitted uses and limitations.',
    `signed_timestamp` TIMESTAMP COMMENT 'Exact date and time when the patient or authorized representative signed the genomic consent form.',
    `signing_method` STRING COMMENT 'Method by which the patient or authorized representative executed the consent document.',
    `source_record_reference` STRING COMMENT 'Original record identifier from the source operational system for traceability and reconciliation.',
    `source_system` STRING COMMENT 'Name of the operational system from which this consent record originated (e.g., Epic EHR, Cerner Millennium, research consent management system).',
    `withdrawal_reason` STRING COMMENT 'Reason provided by the patient for revoking or withdrawing their genomic consent.',
    `witness_name` STRING COMMENT 'Full name of the witness who observed the patient signing the genomic consent form.',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient providing consent.',
    `consent_scope` STRING COMMENT 'Scope of consent indicating whether it applies to research, clinical use, or both.. Valid values are `research|clinical|both`',
    `consent_status` STRING COMMENT 'Current status of the consent.. Valid values are `active|revoked|expired|pending`',
    `effective_from` DATE COMMENT 'Date when the consent becomes effective.',
    `effective_until` DATE COMMENT 'Date when the consent expires, if applicable.',
    `consent_given_date` DATE COMMENT 'Date when the patient signed the consent.',
    `given_by` STRING COMMENT 'Name of the individual (patient or legal guardian) who provided the consent.',
    `signature_method` STRING COMMENT 'Method used to capture the signature.. Valid values are `electronic|paper|phone|mail`',
    `signature_timestamp` TIMESTAMP COMMENT 'Exact timestamp of the signature capture.',
    `consent_document_id` BIGINT COMMENT 'Reference to the stored consent document.',
    `consent_notes` STRING COMMENT 'Additional notes or comments regarding the consent.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consent record was created in the system.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the consent record.',
    `created_by_user_id` BIGINT COMMENT 'Identifier of the system user who created the consent record.',
    `updated_by_user_id` BIGINT COMMENT 'Identifier of the system user who last updated the consent record.',
    CONSTRAINT pk_genomic_consent PRIMARY KEY(`genomic_consent_id`)
) COMMENT 'Table for patient genomic consent.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`precision_medicine_trial` (
    `precision_medicine_trial_id` BIGINT COMMENT 'Primary key for precision_medicine_trial',
    `care_site_id` BIGINT COMMENT 'Reference to the care site or facility where the trial enrollment is being conducted.',
    `genomic_consent_id` BIGINT COMMENT 'Reference to the informed consent record documenting patient agreement to participate in the precision medicine trial.',
    `genomic_test_order_id` BIGINT COMMENT 'Reference to the genomic test order that generated the molecular data supporting trial eligibility.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient enrolled in the precision medicine trial.',
    `clinician_id` BIGINT COMMENT 'Reference to the provider who ordered or initiated the precision medicine trial enrollment for the patient.',
    `precision_principal_investigator_clinician_id` BIGINT COMMENT 'Reference to the principal investigator overseeing this precision medicine trial.',
    `protocol_id` BIGINT COMMENT 'Reference to the research protocol governing this precision medicine trial.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which the trial enrollment was initiated.',
    `adverse_event_grade` STRING COMMENT 'Highest grade of adverse event experienced by the patient during the trial per CTCAE classification.',
    `clinicaltrials_gov_nct_number` STRING COMMENT 'National Clinical Trial identifier registered on ClinicalTrials.gov for public disclosure and regulatory compliance.',
    `cohort_designation` STRING COMMENT 'Identifier for the patient cohort or subgroup within the trial, often based on biomarker or molecular profile.',
    `companion_diagnostic_test` STRING COMMENT 'Name or identifier of the FDA-approved companion diagnostic test used to determine trial eligibility.',
    `completion_date` DATE COMMENT 'Date the patient completed all protocol-required activities in the trial.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this precision medicine trial enrollment record was first created in the system.',
    `data_monitoring_flag` BOOLEAN COMMENT 'Indicates whether this enrollment has been flagged for review by the Data Safety Monitoring Board (DSMB).',
    `dosage_regimen` STRING COMMENT 'Prescribed dosage schedule and regimen for the trial intervention as defined by the protocol.',
    `eligibility_criteria_met` STRING COMMENT 'Description of the specific inclusion criteria satisfied by the patient for trial enrollment.',
    `enrollment_date` DATE COMMENT 'Date the patient was formally enrolled into the precision medicine trial.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the patients enrollment in the precision medicine trial.',
    `exclusion_reason` STRING COMMENT 'Reason for patient exclusion or screen failure if the patient did not meet eligibility criteria.',
    `informed_consent_version` STRING COMMENT 'Version identifier of the informed consent form signed by the patient for this trial enrollment.',
    `intervention_name` STRING COMMENT 'Name of the precision medicine intervention, drug, or therapy being administered in the trial.',
    `irb_approval_number` STRING COMMENT 'IRB protocol approval number authorizing the conduct of this trial at the enrolling institution.',
    `is_blinded` BOOLEAN COMMENT 'Indicates whether the trial enrollment is blinded (single or double-blind) versus open-label.',
    `is_placebo_controlled` BOOLEAN COMMENT 'Indicates whether the trial includes a placebo control arm.',
    `molecular_profile_summary` STRING COMMENT 'High-level summary of the patients molecular or genomic profile relevant to trial eligibility and treatment selection.',
    `next_visit_date` DATE COMMENT 'Date of the next scheduled protocol visit for the enrolled patient.',
    `notes` STRING COMMENT 'Free-text clinical or administrative notes related to the patients trial enrollment.',
    `primary_diagnosis_code` STRING COMMENT 'ICD-10 diagnosis code for the primary condition being treated in the precision medicine trial.',
    `protocol_version` STRING COMMENT 'Version of the trial protocol under which the patient is currently enrolled.',
    `randomization_date` DATE COMMENT 'Date the patient was randomized to a treatment arm, if applicable to the trial design.',
    `response_assessment` STRING COMMENT 'Clinical assessment of patient response to the precision medicine intervention per RECIST or equivalent criteria.',
    `screening_date` DATE COMMENT 'Date the patient began the screening process for trial eligibility determination.',
    `site_number` STRING COMMENT 'Identifier for the clinical trial site within the multi-site study where this enrollment is managed.',
    `sponsor_name` STRING COMMENT 'Name of the pharmaceutical company, institution, or organization sponsoring the precision medicine trial.',
    `subject_number` STRING COMMENT 'De-identified subject number assigned to the patient within the trial for regulatory reporting and data management.',
    `target_biomarker` STRING COMMENT 'Primary molecular biomarker or genomic alteration targeted by the trial intervention (e.g., EGFR, BRCA1, PD-L1).',
    `therapeutic_area` STRING COMMENT 'Clinical therapeutic area or disease domain addressed by the precision medicine trial.',
    `total_protocol_visits` STRING COMMENT 'Total number of protocol-required visits completed by the patient to date.',
    `treatment_arm` STRING COMMENT 'Name or code of the treatment arm to which the patient was assigned within the trial protocol.',
    `treatment_start_date` DATE COMMENT 'Date the patient began receiving the precision medicine intervention or therapy.',
    `trial_number` STRING COMMENT 'Externally-known business identifier for the precision medicine trial enrollment, used for cross-system tracking and regulatory correspondence.',
    `trial_phase` STRING COMMENT 'Phase of the clinical trial per FDA regulatory classification.',
    `trial_type` STRING COMMENT 'Classification of the precision medicine trial by therapeutic approach or study design.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this precision medicine trial enrollment record was last modified.',
    `withdrawal_date` DATE COMMENT 'Date the patient withdrew or was discontinued from the trial, if applicable.',
    `withdrawal_reason` STRING COMMENT 'Documented reason for patient withdrawal or discontinuation from the trial (e.g., adverse event, patient decision, disease progression).',
    CONSTRAINT pk_precision_medicine_trial PRIMARY KEY(`precision_medicine_trial_id`)
) COMMENT 'Table for precision medicine trial enrollments.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`genomic_order` (
    `genomic_order_id` BIGINT COMMENT 'Primary key for genomic_order',
    `clinician_id` BIGINT COMMENT 'The provider (physician, geneticist, or advanced practice provider) who placed the genomic sequencing order.',
    `care_site_id` BIGINT COMMENT 'The reference laboratory or facility responsible for performing the genomic sequencing analysis.',
    `genomic_consent_id` BIGINT COMMENT 'Reference to the specific consent record documenting the patients authorization for genomic testing and data use.',
    `genomic_ordering_facility_care_site_id` BIGINT COMMENT 'The healthcare facility or clinic from which the genomic order was placed.',
    `insurance_coverage_id` BIGINT COMMENT 'Reference to the patients insurance coverage record used for billing and prior authorization of the genomic test.',
    `mpi_record_id` BIGINT COMMENT 'The patient for whom the genomic sequencing test is ordered.',
    `diagnosis_id` BIGINT COMMENT 'Reference to the primary diagnosis record that prompted the genomic testing order.',
    `visit_id` BIGINT COMMENT 'The clinical encounter during which the genomic order was placed.',
    `actionable_findings_flag` BOOLEAN COMMENT 'Indicates whether the genomic test identified clinically actionable findings that may influence treatment decisions or care pathways.',
    `cancellation_reason` STRING COMMENT 'The reason for cancellation if the genomic order was cancelled, including clinical, administrative, or patient-initiated reasons.',
    `cancelled_datetime` TIMESTAMP COMMENT 'The date and time when the genomic order was cancelled, if applicable.',
    `clinical_indication` STRING COMMENT 'The clinical reason or suspected diagnosis prompting the genomic order, describing the medical condition being investigated.',
    `cpt_code` STRING COMMENT 'The CPT code assigned to the genomic test for billing and reimbursement purposes.',
    `created_datetime` TIMESTAMP COMMENT 'The date and time when the genomic order record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this order.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'The estimated cost of the genomic sequencing test as quoted to the patient or payer at the time of order.',
    `expected_turnaround_days` STRING COMMENT 'The expected number of calendar days from specimen receipt to result availability, based on test type and laboratory SLA.',
    `external_order_reference` STRING COMMENT 'External reference number from the performing laboratorys system for cross-system order tracking and reconciliation.',
    `family_history_relevant` BOOLEAN COMMENT 'Indicates whether the patient has a relevant family history of genetic conditions that supports the clinical indication for testing.',
    `genes_of_interest` STRING COMMENT 'Comma-separated list of specific gene names targeted for analysis in the genomic order, relevant for targeted panel tests.',
    `genetic_counseling_completed` BOOLEAN COMMENT 'Indicates whether pre-test genetic counseling was completed with the patient prior to order submission, as recommended by ACMG guidelines.',
    `incidental_findings_reported` BOOLEAN COMMENT 'Indicates whether secondary or incidental findings unrelated to the primary indication were identified and reported per ACMG recommendations.',
    `indication_icd_code` STRING COMMENT 'The ICD-10 diagnosis code associated with the clinical indication for the genomic test order.',
    `informed_consent_obtained` BOOLEAN COMMENT 'Indicates whether informed consent for genomic testing was obtained from the patient, including understanding of potential findings and implications.',
    `order_datetime` TIMESTAMP COMMENT 'The date and time when the genomic sequencing order was placed by the ordering provider via CPOE or manual entry.',
    `order_number` STRING COMMENT 'Externally-visible business identifier for the genomic order, used for tracking and communication between ordering provider and laboratory.',
    `order_reason_text` STRING COMMENT 'Free-text clinical justification provided by the ordering provider explaining why genomic testing is medically necessary.',
    `order_status` STRING COMMENT 'Current lifecycle status of the genomic sequencing order within the clinical workflow.',
    `ordering_department` STRING COMMENT 'The clinical department or service line from which the genomic order originated (e.g., Oncology, Genetics, Neurology).',
    `overall_interpretation` STRING COMMENT 'High-level clinical interpretation summary of the genomic test results, categorizing the overall finding.',
    `patient_responsibility_amount` DECIMAL(18,2) COMMENT 'The estimated out-of-pocket amount the patient is responsible for after insurance coverage determination.',
    `prior_authorization_number` STRING COMMENT 'The insurance prior authorization or pre-certification number obtained for the genomic test, required by many payers for coverage.',
    `prior_authorization_status` STRING COMMENT 'Current status of the insurance prior authorization request for the genomic test order.',
    `priority` STRING COMMENT 'The urgency level assigned to the genomic order, influencing turnaround time expectations and laboratory processing queue.',
    `report_delivery_method` STRING COMMENT 'The method by which the genomic test report is delivered to the ordering provider.',
    `research_use_authorized` BOOLEAN COMMENT 'Indicates whether the patient has authorized the use of their genomic data for research purposes beyond clinical care.',
    `result_available_datetime` TIMESTAMP COMMENT 'The date and time when the genomic test results became available for clinical review by the ordering provider.',
    `result_status` STRING COMMENT 'The status of the genomic test result, indicating whether results are preliminary, final, or have been amended.',
    `sequencing_platform` STRING COMMENT 'The genomic sequencing technology platform used for analysis (e.g., Illumina NovaSeq, PacBio, Oxford Nanopore, Ion Torrent).',
    `special_instructions` STRING COMMENT 'Additional clinical or handling instructions provided by the ordering provider for the performing laboratory.',
    `specimen_accession_number` STRING COMMENT 'The unique laboratory-assigned accession number for tracking the specimen through the sequencing workflow.',
    `specimen_collected_datetime` TIMESTAMP COMMENT 'The date and time when the biological specimen was collected from the patient for genomic analysis.',
    `specimen_received_datetime` TIMESTAMP COMMENT 'The date and time when the performing laboratory received the specimen for processing.',
    `specimen_type` STRING COMMENT 'The type of biological specimen required or collected for the genomic sequencing analysis.',
    `test_code` STRING COMMENT 'Standardized code identifying the specific genomic test, typically mapped to LOINC or laboratory-specific catalog codes.',
    `test_name` STRING COMMENT 'The specific name of the genomic test panel or assay being ordered, as defined in the laboratory test catalog.',
    `test_type` STRING COMMENT 'Classification of the genomic sequencing test being ordered, indicating the scope and methodology of analysis.',
    `updated_datetime` TIMESTAMP COMMENT 'The date and time when the genomic order record was last modified.',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient for whom the genomic test is ordered.',
    `ordering_provider_id` BIGINT COMMENT 'Unique identifier of the clinician who placed the genomic order.',
    `test_priority` STRING COMMENT 'Clinical priority assigned to the test, influencing turnaround time.. Valid values are `routine|stat|urgent`',
    `order_timestamp` TIMESTAMP COMMENT 'Date‑time when the order was placed in the clinical system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the order record was first created in the data lake.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the order record.',
    `specimen_id` STRING COMMENT 'Identifier of the biological specimen linked to the order.',
    `collection_date` DATE COMMENT 'Date the specimen was collected from the patient.',
    `accession_number` STRING COMMENT 'Laboratory accession number assigned to the specimen.',
    `billing_code` STRING COMMENT 'Procedure code used for billing the genomic test.',
    `order_amount` DECIMAL(18,2) COMMENT 'Charged amount for the genomic test before adjustments.',
    `insurance_authorization_id` STRING COMMENT 'Identifier of the payer authorization linked to the order.',
    `consent_status` STRING COMMENT 'Current status of patient consent for genomic testing.. Valid values are `granted|denied|pending|revoked`',
    `result_release_date` DATE COMMENT 'Date the final genomic report was made available to the ordering clinician.',
    `clinical_interpretation` STRING COMMENT 'Narrative interpretation of the genomic findings.',
    `report_url` STRING COMMENT 'Link to the electronic genomic report stored in the EHR.',
    `ordering_facility_id` BIGINT COMMENT 'Identifier of the facility where the order was placed.',
    `ordering_location_id` BIGINT COMMENT 'Identifier of the specific location (e.g., clinic, department) where the order originated.',
    `patient_dob` DATE COMMENT 'Patients birth date, used for age‑based interpretation.',
    `patient_gender` STRING COMMENT 'Recorded gender of the patient.. Valid values are `male|female|other|unknown`',
    `patient_race` STRING COMMENT 'Self‑identified race of the patient for population‑health reporting.',
    `patient_ethnicity` STRING COMMENT 'Self‑identified ethnicity of the patient.',
    `patient_address` STRING COMMENT 'Current residential address of the patient.',
    `patient_phone` STRING COMMENT 'Primary contact telephone number for the patient.',
    `patient_email` STRING COMMENT 'Primary email address for patient communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `clinical_trial_id` STRING COMMENT 'Identifier of the clinical trial associated with the genomic test, if applicable.',
    `research_study_id` STRING COMMENT 'Identifier of the research study linked to the order.',
    `is_clinical_trial` BOOLEAN COMMENT 'Flag indicating whether the order is part of a clinical trial.',
    `is_research` BOOLEAN COMMENT 'Flag indicating whether the order is for research purposes rather than clinical care.',
    `notes` STRING COMMENT 'Free‑text field for additional comments or special instructions.',
    `retention_period_years` STRING COMMENT 'Number of years the order record must be retained to satisfy HIPAA and institutional policies.',
    CONSTRAINT pk_genomic_order PRIMARY KEY(`genomic_order_id`)
) COMMENT 'Genomic sequencing order records.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` (
    `precision_medicine_report_id` BIGINT COMMENT 'Primary key for precision_medicine_report',
    `care_site_id` BIGINT COMMENT 'The facility or care site where the precision medicine report was ordered and will be used for clinical decision-making.',
    `genomic_order_id` BIGINT COMMENT 'Foreign key linking to genomics.genomic_order. Business justification: New FK linking precision_medicine_report to the genomic_order that initiated the testing. Order date can be obtained via join.',
    `mpi_record_id` BIGINT COMMENT 'The patient for whom this precision medicine report was generated.',
    `clinician_id` BIGINT COMMENT 'The provider who ordered the genomic test that resulted in this precision medicine report.',
    `precision_interpreting_provider_clinician_id` BIGINT COMMENT 'The clinical geneticist or molecular pathologist who interpreted the genomic findings and authored the report.',
    `research_document_id` BIGINT COMMENT 'Reference identifier for the PDF document stored in the document management system containing the full precision medicine report.',
    `visit_id` BIGINT COMMENT 'The clinical encounter during which this precision medicine report was ordered or generated.',
    `actionable_variants_count` STRING COMMENT 'Number of clinically actionable genomic variants identified in this report that may influence treatment decisions.',
    `amendment_reason` STRING COMMENT 'Reason for report amendment or correction, if the report has been revised after initial issuance.',
    `clinical_interpretation_summary` STRING COMMENT 'Narrative summary of the clinical interpretation of genomic findings, including therapeutic implications and recommended actions.',
    `clinical_trial_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the genomic findings suggest potential eligibility for one or more clinical trials.',
    `clinical_trial_matches_count` STRING COMMENT 'Number of clinical trials identified as potentially relevant based on the genomic findings in this report.',
    `consent_for_research_flag` BOOLEAN COMMENT 'Indicates whether the patient consented to use of their genomic data for research purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this precision medicine report record was first created in the system.',
    `evidence_level` STRING COMMENT 'Highest level of clinical evidence supporting the therapeutic recommendations in this report, per OncoKB or equivalent tiering system.',
    `gene_panel_name` STRING COMMENT 'Name of the gene panel or assay used for the genomic test (e.g., FoundationOne CDx, Tempus xT, institutional custom panel).',
    `genes_tested_count` STRING COMMENT 'Total number of genes included in the panel or assay used for this precision medicine report.',
    `genetic_counseling_recommended_flag` BOOLEAN COMMENT 'Indicates whether genetic counseling is recommended based on the findings in this report, particularly for germline results.',
    `genomic_instability_score` DECIMAL(18,2) COMMENT 'Homologous recombination deficiency (HRD) or genomic instability score indicating DNA repair pathway deficiency.',
    `her2_status` STRING COMMENT 'HER2 amplification or overexpression status if assessed, relevant for targeted therapy selection.',
    `incidental_findings_flag` BOOLEAN COMMENT 'Indicates whether medically actionable incidental (secondary) findings were identified per ACMG SF list.',
    `mean_sequencing_depth` DECIMAL(18,2) COMMENT 'Average sequencing depth (coverage) achieved across the targeted regions, indicating data quality and variant detection sensitivity.',
    `microsatellite_instability_status` STRING COMMENT 'Microsatellite instability status determined from genomic analysis, relevant for immunotherapy treatment decisions.',
    `molecular_tumor_board_date` DATE COMMENT 'Date when the molecular tumor board reviewed this precision medicine report.',
    `molecular_tumor_board_reviewed_flag` BOOLEAN COMMENT 'Indicates whether this report was reviewed by a molecular tumor board for multidisciplinary treatment planning.',
    `pathogenic_variants_count` STRING COMMENT 'Number of pathogenic or likely pathogenic variants identified in this precision medicine report.',
    `pdl1_expression_score` DECIMAL(18,2) COMMENT 'PD-L1 expression score (tumor proportion score or combined positive score) if assessed as part of the genomic panel.',
    `primary_diagnosis_description` STRING COMMENT 'Clinical description of the primary diagnosis associated with this precision medicine report.',
    `primary_diagnosis_icd_code` STRING COMMENT 'ICD-10 code for the primary clinical diagnosis that prompted the genomic testing.',
    `recommended_therapy` STRING COMMENT 'Primary targeted therapy or treatment recommendation based on the genomic findings in this report.',
    `report_issued_timestamp` TIMESTAMP COMMENT 'Timestamp when the precision medicine report was officially issued and made available for clinical review.',
    `report_number` STRING COMMENT 'Externally-visible business identifier for the precision medicine report, used for clinical communication and tracking.',
    `report_received_timestamp` TIMESTAMP COMMENT 'Timestamp when the precision medicine report was received into the EHR system from the testing laboratory.',
    `report_status` STRING COMMENT 'Current lifecycle status of the precision medicine report within the clinical workflow.',
    `report_type` STRING COMMENT 'Classification of the precision medicine report based on the type of genomic analysis performed. [ENUM-REF-CANDIDATE: somatic|germline|pharmacogenomic|liquid_biopsy|hereditary_cancer|companion_diagnostic|tumor_profiling|whole_exome|whole_genome|rna_expression — promote to reference product]',
    `report_version` STRING COMMENT 'Version number of the report, incremented when amendments or corrections are issued.',
    `specimen_adequacy` STRING COMMENT 'Assessment of whether the submitted specimen met quality and quantity requirements for reliable genomic analysis.',
    `specimen_collection_date` DATE COMMENT 'Date when the biological specimen was collected from the patient for genomic testing.',
    `specimen_type` STRING COMMENT 'Type of biological specimen used for the genomic analysis underlying this report.',
    `test_methodology` STRING COMMENT 'The molecular testing methodology used to generate the genomic data for this report (e.g., Next-Generation Sequencing, PCR, FISH). [ENUM-REF-CANDIDATE: NGS|PCR|FISH|microarray|Sanger|WES|WGS|RNA_seq|methylation|karyotype — promote to reference product]',
    `testing_laboratory_clia_number` STRING COMMENT 'CLIA certification number of the laboratory that performed the genomic test, ensuring regulatory compliance.',
    `testing_laboratory_name` STRING COMMENT 'Name of the external or internal laboratory that performed the genomic sequencing and analysis.',
    `therapeutic_implications` STRING COMMENT 'Summary of treatment implications derived from the genomic findings, including FDA-approved therapies and clinical trial eligibility.',
    `tumor_cellularity_percent` DECIMAL(18,2) COMMENT 'Percentage of tumor cells in the specimen, critical for assessing the reliability of variant allele frequency measurements.',
    `tumor_mutational_burden` DECIMAL(18,2) COMMENT 'Tumor mutational burden score expressed as mutations per megabase (mut/Mb), used to assess immunotherapy eligibility.',
    `tumor_type` STRING COMMENT 'Specific tumor or disease type being evaluated in the genomic analysis (e.g., non-small cell lung cancer, melanoma, AML).',
    `turnaround_time_days` STRING COMMENT 'Number of calendar days from specimen receipt at the laboratory to report issuance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this precision medicine report record was last modified.',
    `variants_of_unknown_significance_count` STRING COMMENT 'Number of variants of uncertain significance identified in this report requiring potential future reclassification.',
    CONSTRAINT pk_precision_medicine_report PRIMARY KEY(`precision_medicine_report_id`)
) COMMENT 'Table storing precision medicine reports linked to patients.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`variant` (
    `variant_id` BIGINT COMMENT 'Primary key for variant',
    `clinician_id` BIGINT COMMENT 'Identifier of the clinical geneticist or molecular pathologist who performed the variant interpretation.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient from whom the specimen was collected for genomic sequencing.',
    `specimen_id` BIGINT COMMENT 'Identifier of the biological specimen from which DNA was extracted for sequencing.',
    `test_order_id` BIGINT COMMENT 'Identifier of the genomic test order that produced this variant call.',
    `actionability_tier` STRING COMMENT 'AMP/ASCO/CAP tier classification indicating the level of clinical evidence supporting therapeutic actionability.',
    `allele_frequency` DECIMAL(18,2) COMMENT 'Observed frequency of the alternate allele in the patient sample reads (variant allele fraction).',
    `alternate_allele` STRING COMMENT 'Observed nucleotide sequence differing from the reference allele in the patient sample.',
    `alternate_read_count` STRING COMMENT 'Number of sequencing reads supporting the alternate allele at this position.',
    `assay_type` STRING COMMENT 'Type of genomic assay used to detect this variant (whole genome, whole exome, targeted panel, etc.).',
    `call_date` TIMESTAMP COMMENT 'Timestamp when the bioinformatics pipeline generated this variant call from sequencing data.',
    `chromosome` STRING COMMENT 'Chromosome on which the variant is located, using standard nomenclature.',
    `clinical_significance` STRING COMMENT 'ACMG/AMP five-tier classification of the variants clinical relevance to disease.',
    `clinvar_accession` STRING COMMENT 'NCBI ClinVar accession number linking to curated clinical significance assertions.',
    `cosmic_accession` STRING COMMENT 'COSMIC database identifier for somatic mutations relevant to oncology interpretation.',
    `dbsnp_accession` STRING COMMENT 'NCBI dbSNP reference SNP cluster identifier for known variants.',
    `disease_association` STRING COMMENT 'Primary disease or condition associated with this variant based on curated clinical evidence.',
    `filter_status` STRING COMMENT 'Outcome of quality control filters applied during variant calling pipeline processing.',
    `functional_effect` STRING COMMENT 'Predicted functional consequence of the variant on the gene product. [ENUM-REF-CANDIDATE: missense|nonsense|frameshift|splice_site|synonymous|intronic|start_loss|stop_loss|inframe_insertion|inframe_deletion|UTR — promote to reference product]',
    `gene_symbol` STRING COMMENT 'HUGO Gene Nomenclature Committee (HGNC) approved symbol for the gene in which the variant is located.',
    `hgvs_coding` STRING COMMENT 'HGVS nomenclature describing the variant at the coding DNA sequence level.',
    `hgvs_protein` STRING COMMENT 'HGVS nomenclature describing the predicted amino acid change resulting from the variant.',
    `inheritance_pattern` STRING COMMENT 'Mode of inheritance for the condition associated with this variant.',
    `interpretation_date` DATE COMMENT 'Date on which the clinical interpretation of this variant was completed or last reviewed.',
    `interpretation_status` STRING COMMENT 'Current lifecycle status of the clinical interpretation for this variant call.',
    `population_frequency` DECIMAL(18,2) COMMENT 'Frequency of this variant in the general population from gnomAD or similar reference databases.',
    `position_end` BIGINT COMMENT 'One-based end position of the variant on the reference genome, relevant for structural variants and indels.',
    `position_start` BIGINT COMMENT 'One-based start position of the variant on the reference genome.',
    `quality_score` DECIMAL(18,2) COMMENT 'Phred-scaled quality score representing confidence that the variant call is genuine and not an artifact.',
    `read_depth` STRING COMMENT 'Total number of sequencing reads covering the variant position, indicating confidence in the call.',
    `reference_allele` STRING COMMENT 'Nucleotide sequence at the variant position in the reference genome assembly.',
    `reference_genome_build` STRING COMMENT 'Version of the human reference genome assembly used for alignment and variant calling.',
    `reporting_notes` STRING COMMENT 'Free-text clinical notes or comments included in the genomic report regarding this variant finding.',
    `sequencing_platform` STRING COMMENT 'Technology platform used for DNA sequencing (e.g., Illumina NovaSeq, PacBio, Oxford Nanopore).',
    `somatic_or_germline` STRING COMMENT 'Indicates whether the variant originated in somatic tissue or is inherited through the germline.',
    `transcript_accession` STRING COMMENT 'RefSeq or Ensembl transcript accession used for variant annotation and effect prediction.',
    `variant_type` STRING COMMENT 'Classification of the genomic alteration type based on the nature of the sequence change.',
    `zygosity` STRING COMMENT 'Indicates whether the variant is present on one or both alleles in the patient genome.',
    CONSTRAINT pk_variant PRIMARY KEY(`variant_id`)
) COMMENT 'Table storing genomic variant calls.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`genome_sequence` (
    `genome_sequence_id` BIGINT COMMENT 'Primary key for genome_sequence',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider who ordered the whole genome sequencing test.',
    `care_site_id` BIGINT COMMENT 'Identifier of the laboratory facility that performed the genome sequencing.',
    `genome_ordering_facility_care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility from which the genome sequencing test was ordered.',
    `genomic_order_id` BIGINT COMMENT 'Foreign key linking to genomics.genomic_order. Business justification: New FK linking genome_sequence to the genomic_order that initiated whole genome sequencing. De-silos this table.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient from whom the genomic sample was collected.',
    `sequencing_run_id` BIGINT COMMENT 'Identifier of the specific sequencing instrument run in which this sample was processed, used for batch tracking and quality traceability.',
    `specimen_id` BIGINT COMMENT 'Unique identifier for the biological sample from which DNA was extracted for sequencing.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the genomic sample was collected or the test was ordered.',
    `accession_number` STRING COMMENT 'Unique laboratory accession number assigned to the genomic specimen for tracking and identification purposes.',
    `bioinformatics_pipeline_version` STRING COMMENT 'Version identifier of the bioinformatics analysis pipeline used for alignment, variant calling, and annotation.',
    `clinical_indication` STRING COMMENT 'Clinical reason or diagnosis prompting the genome sequencing order, typically an ICD-10 code or free-text description of the suspected condition.',
    `clinically_significant_variant_count` STRING COMMENT 'Number of variants classified as pathogenic or likely pathogenic per ACMG guidelines found in this genome sequence.',
    `collection_date` DATE COMMENT 'Date when the biological sample was collected from the patient.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether informed consent for genomic testing and data use was obtained from the patient prior to sequencing.',
    `contamination_estimate_percent` DECIMAL(18,2) COMMENT 'Estimated percentage of DNA contamination from other samples detected during quality control analysis.',
    `cpt_code` STRING COMMENT 'CPT procedure code associated with the genomic sequencing test for billing and reimbursement purposes.',
    `data_file_format` STRING COMMENT 'Primary file format in which the sequencing data is stored (e.g., FASTQ for raw reads, BAM/CRAM for aligned reads, VCF for variants).',
    `data_file_size_gb` DECIMAL(18,2) COMMENT 'Total size of the primary sequencing data file in gigabytes for storage planning and data management.',
    `effective_end_timestamp` TIMESTAMP COMMENT 'Timestamp marking the end of the current version of this record for SCD Type 2 tracking. NULL indicates the current active record.',
    `effective_start_timestamp` TIMESTAMP COMMENT 'Timestamp marking the beginning of the current version of this record for Slowly Changing Dimension Type 2 tracking in the lakehouse.',
    `ethnicity_reported` STRING COMMENT 'Self-reported ethnicity of the patient, relevant for population frequency interpretation of genomic variants.',
    `flowcell_barcode` STRING COMMENT 'Identifier of the flowcell used in the sequencing run, critical for batch-level quality tracking and troubleshooting.',
    `genome_sequence_status` STRING COMMENT 'Current lifecycle status of the genome sequencing workflow from order through completion.',
    `hipaa_retention_expiry_date` DATE COMMENT 'Date after which the genomic data record may be eligible for archival or deletion per HIPAA and state retention requirements.',
    `icd10_indication_code` STRING COMMENT 'ICD-10-CM diagnosis code representing the primary clinical indication for the genomic test order.',
    `interpretation_summary` STRING COMMENT 'High-level clinical interpretation summary of the genomic findings, including actionable results and recommendations.',
    `is_current_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this is the most current version of the genome sequence record in the SCD Type 2 history.',
    `library_preparation_method` STRING COMMENT 'Method used for DNA library preparation prior to sequencing (e.g., PCR-free, PCR-based, tagmentation).',
    `mapped_reads_percent` DECIMAL(18,2) COMMENT 'Percentage of total reads that successfully aligned to the reference genome assembly.',
    `mean_coverage_depth` DECIMAL(18,2) COMMENT 'Average number of times each nucleotide position in the genome was sequenced (e.g., 30x coverage). Key quality metric for whole genome sequencing.',
    `notes` STRING COMMENT 'Free-text clinical or laboratory notes related to the genome sequencing process, sample quality issues, or special handling instructions.',
    `paired_end_flag` BOOLEAN COMMENT 'Indicates whether paired-end sequencing was performed (true) versus single-end sequencing (false).',
    `q30_bases_percent` DECIMAL(18,2) COMMENT 'Percentage of bases with a Phred quality score of 30 or higher, indicating 99.9% base call accuracy.',
    `quality_score` STRING COMMENT 'Overall quality assessment outcome of the sequencing run based on coverage, error rate, and contamination checks.',
    `read_length_bp` STRING COMMENT 'Length of individual sequencing reads in base pairs (e.g., 150bp for short-read, 10000+ for long-read).',
    `reference_genome_assembly` STRING COMMENT 'Human reference genome assembly version used for alignment and variant calling (e.g., GRCh38/hg38).',
    `report_date` DATE COMMENT 'Date when the final genomic sequencing report was issued and made available for clinical review.',
    `research_use_consent_flag` BOOLEAN COMMENT 'Indicates whether the patient consented to use of their genomic data for research purposes beyond clinical care.',
    `sample_type` STRING COMMENT 'Type of biological specimen from which DNA was extracted for sequencing.',
    `sequence_type` STRING COMMENT 'Classification of the sequencing approach used to generate the genomic data.',
    `sequencing_date` DATE COMMENT 'Date when the genome sequencing run was performed on the instrument.',
    `sequencing_instrument_model` STRING COMMENT 'Specific model of the sequencing instrument used (e.g., NovaSeq 6000, HiSeq X Ten, MinION).',
    `sequencing_platform` STRING COMMENT 'Technology platform used to perform the genome sequencing (e.g., Illumina NovaSeq, PacBio Sequel).',
    `sex_at_birth` STRING COMMENT 'Biological sex assigned at birth, required for accurate interpretation of sex-linked genomic variants.',
    `storage_location_uri` STRING COMMENT 'Uniform Resource Identifier (URI) pointing to the cloud or on-premises storage location of the raw sequencing data files.',
    `total_bases_gigabases` DECIMAL(18,2) COMMENT 'Total number of bases sequenced expressed in gigabases (Gb), representing the data yield of the sequencing run.',
    `total_reads` BIGINT COMMENT 'Total number of sequencing reads generated during the sequencing run.',
    `tumor_normal_flag` STRING COMMENT 'Indicates whether the sample is from tumor tissue, normal tissue, or part of a paired tumor-normal analysis for somatic variant detection.',
    `tumor_purity_percent` DECIMAL(18,2) COMMENT 'Estimated percentage of tumor cells in the sample, relevant for somatic variant calling sensitivity in oncology genomics.',
    `turnaround_time_days` STRING COMMENT 'Number of calendar days from sample receipt to final report issuance, used for operational performance monitoring.',
    `variant_count` STRING COMMENT 'Total number of genetic variants identified in the sequencing analysis relative to the reference genome.',
    CONSTRAINT pk_genome_sequence PRIMARY KEY(`genome_sequence_id`)
) COMMENT 'Table storing whole genome sequences.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`gene_expression` (
    `gene_expression_id` BIGINT COMMENT 'Primary key for gene_expression',
    `care_site_id` BIGINT COMMENT 'Identifier of the laboratory that performed the gene expression assay.',
    `clinician_id` BIGINT COMMENT 'Identifier of the clinician who ordered the gene expression test.',
    `genomic_order_id` BIGINT COMMENT 'Identifier of the genomic test order that initiated this gene expression analysis.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient from whom the biological sample was collected for gene expression analysis.',
    `specimen_id` BIGINT COMMENT 'Identifier of the biological specimen used for gene expression profiling.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the gene expression test was ordered or sample collected.',
    `actionability_category` STRING COMMENT 'Tier classification indicating whether the expression finding has direct therapeutic implications per AMP/ASCO/CAP guidelines.',
    `adjusted_p_value` DECIMAL(18,2) COMMENT 'Multiple testing corrected p-value (e.g., Benjamini-Hochberg False Discovery Rate) to control for family-wise error rate in genome-wide analyses.',
    `analysis_date` DATE COMMENT 'Date when the gene expression analysis was completed by the laboratory.',
    `assay_method` STRING COMMENT 'Laboratory method used to quantify gene expression levels.',
    `assay_platform` STRING COMMENT 'Technology platform used for gene expression measurement (e.g., Illumina HiSeq, Affymetrix GeneChip, NanoString nCounter, RT-qPCR).',
    `associated_condition` STRING COMMENT 'Primary disease or clinical condition associated with the observed gene expression pattern (e.g., breast cancer, leukemia).',
    `associated_icd10_code` STRING COMMENT 'ICD-10 diagnosis code linked to the clinical condition for which this gene expression result is relevant.',
    `biomarker_name` STRING COMMENT 'Name of the clinical biomarker this gene expression measurement contributes to (e.g., HER2, EGFR, PD-L1, BRCA1).',
    `chromosome` STRING COMMENT 'Chromosome on which the measured gene is located.',
    `clinical_significance` STRING COMMENT 'Clinical interpretation of the gene expression finding in the context of the patients condition and treatment pathway.',
    `collection_date` DATE COMMENT 'Date when the biological sample was collected from the patient.',
    `confidence_interval_high` DECIMAL(18,2) COMMENT 'Upper bound of the 95% confidence interval for the expression measurement.',
    `confidence_interval_low` DECIMAL(18,2) COMMENT 'Lower bound of the 95% confidence interval for the expression measurement.',
    `ensembl_gene_accession` STRING COMMENT 'Ensembl stable identifier for the gene, used for cross-referencing genomic databases.',
    `expression_status` STRING COMMENT 'Categorical classification of the expression level relative to normal reference ranges for clinical interpretation.',
    `expression_unit` STRING COMMENT 'Unit of measurement for the expression value indicating the normalization method applied (Transcripts Per Million, Fragments Per Kilobase Million, etc.).',
    `expression_value` DECIMAL(18,2) COMMENT 'Quantitative measurement of gene expression level, representing the abundance of mRNA transcripts detected in the sample.',
    `gene_end_position` BIGINT COMMENT 'Genomic end coordinate of the gene on the reference genome assembly.',
    `gene_name` STRING COMMENT 'Full descriptive name of the gene as approved by HGNC.',
    `gene_start_position` BIGINT COMMENT 'Genomic start coordinate of the gene on the reference genome assembly.',
    `gene_symbol` STRING COMMENT 'Official HUGO Gene Nomenclature Committee (HGNC) approved gene symbol representing the gene being measured.',
    `interpretation_notes` STRING COMMENT 'Free-text clinical interpretation notes provided by the molecular pathologist or geneticist regarding the expression finding.',
    `is_outlier` BOOLEAN COMMENT 'Flag indicating whether this expression measurement is a statistical outlier based on quality control thresholds.',
    `log2_fold_change` DECIMAL(18,2) COMMENT 'Log base 2 of the ratio of expression in the sample versus a reference or control, indicating up-regulation (positive) or down-regulation (negative).',
    `loinc_code` STRING COMMENT 'LOINC code identifying the specific gene expression observation type for interoperability and standardized reporting.',
    `normalization_method` STRING COMMENT 'Statistical normalization method applied to raw expression data (e.g., DESeq2, TMM, quantile normalization, housekeeping gene).',
    `p_value` DECIMAL(18,2) COMMENT 'Statistical significance p-value for the differential expression measurement, indicating the probability of observing the result by chance.',
    `panel_name` STRING COMMENT 'Name of the gene expression panel or signature test (e.g., Oncotype DX, MammaPrint, Prosigna) that includes this measurement.',
    `pathway_name` STRING COMMENT 'Name of the biological signaling or metabolic pathway in which the gene participates, relevant for pathway-level analysis.',
    `percentile_rank` DECIMAL(18,2) COMMENT 'Percentile rank of this expression value relative to a reference population distribution for the same gene and tissue type.',
    `quality_score` DECIMAL(18,2) COMMENT 'Quality metric for the expression measurement reflecting RNA integrity, sequencing depth adequacy, or probe hybridization quality.',
    `read_depth` BIGINT COMMENT 'Total number of sequencing reads mapped to this gene, indicating the depth of coverage for RNA-Seq based measurements.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this gene expression record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this gene expression record was last modified.',
    `reference_genome_build` STRING COMMENT 'Version of the human reference genome assembly used for alignment and coordinate mapping.',
    `reference_sample_type` STRING COMMENT 'Type of reference or control sample used for comparative expression analysis.',
    `reported_date` DATE COMMENT 'Date when the gene expression result was officially reported and made available to the ordering clinician.',
    `result_status` STRING COMMENT 'Current status of the gene expression result in the laboratory workflow lifecycle.',
    `rna_integrity_number` DECIMAL(18,2) COMMENT 'RNA Integrity Number (scale 1-10) indicating the quality of RNA extracted from the sample, where higher values indicate less degradation.',
    `sample_type` STRING COMMENT 'Type of biological sample from which RNA was extracted for expression analysis.',
    `tissue_type` STRING COMMENT 'Anatomical tissue type from which the sample was derived (e.g., breast, lung, colon, liver).',
    `transcript_accession` STRING COMMENT 'Ensembl transcript identifier specifying which transcript isoform the expression measurement corresponds to.',
    `validation_status` STRING COMMENT 'Quality control validation status indicating whether the measurement passed laboratory quality thresholds.',
    `z_score` DECIMAL(18,2) COMMENT 'Standard score indicating how many standard deviations the expression value is from the population mean for this gene.',
    CONSTRAINT pk_gene_expression PRIMARY KEY(`gene_expression_id`)
) COMMENT 'Table storing gene expression data.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`clinical_genomics_report` (
    `clinical_genomics_report_id` BIGINT COMMENT 'Primary key for clinical_genomics_report',
    `care_site_id` BIGINT COMMENT 'Identifier of the laboratory facility that performed the genomic analysis and issued the report.',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider who ordered the genomic test.',
    `clinical_interpreting_geneticist_clinician_id` BIGINT COMMENT 'Identifier of the clinical geneticist or molecular pathologist who interpreted and signed the report.',
    `genomic_order_id` BIGINT COMMENT 'Foreign key linking to genomics.genomic_order. Business justification: New FK linking clinical_genomics_report to the genomic_order. order_date is redundant as it exists on genomic_order.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient for whom the genomics report was generated.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the genomic test was ordered or resulted.',
    `accession_number` STRING COMMENT 'Unique laboratory-assigned accession number that externally identifies this genomic test specimen and report.',
    `actionability_category` STRING COMMENT 'Classification of whether the genomic findings are clinically actionable and may influence treatment or management decisions.',
    `clinical_interpretation` STRING COMMENT 'Detailed clinical interpretation of the genomic findings including disease association, inheritance pattern, and clinical significance.',
    `clinical_trial_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the genomic findings may qualify the patient for enrollment in relevant clinical trials.',
    `consent_status` STRING COMMENT 'Status of patient informed consent for genomic testing and result disclosure.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this clinical genomics report record was first created in the system.',
    `gene_panel_name` STRING COMMENT 'Name of the gene panel tested, if a targeted panel was used rather than whole exome or genome sequencing.',
    `genes_analyzed_count` STRING COMMENT 'Total number of genes included in the analysis panel or sequencing scope.',
    `genetic_counseling_recommended_flag` BOOLEAN COMMENT 'Indicates whether genetic counseling is recommended based on the report findings.',
    `genetic_findings_summary` STRING COMMENT 'Narrative summary of the key genetic findings identified in the report, including gene names and variant classifications.',
    `hipaa_retention_end_date` DATE COMMENT 'Date after which this genomic report record may be eligible for archival or destruction per HIPAA medical record retention requirements.',
    `indication_code` STRING COMMENT 'ICD-10 diagnosis code representing the clinical indication or reason for ordering the genomic test.',
    `indication_description` STRING COMMENT 'Free-text description of the clinical indication or suspected condition prompting the genomic test order.',
    `mean_coverage_depth` DECIMAL(18,2) COMMENT 'Average sequencing read depth across the targeted regions, indicating analytical sensitivity of the test.',
    `overall_result` STRING COMMENT 'High-level summary result of the genomic test indicating whether clinically significant findings were identified.',
    `pathogenic_variant_count` STRING COMMENT 'Number of variants classified as pathogenic or likely pathogenic per ACMG criteria.',
    `patient_mrn` STRING COMMENT 'Patient medical record number as recorded on the genomics report for cross-reference with the EHR.',
    `platform` STRING COMMENT 'Name of the sequencing platform or instrument used for the genomic analysis (e.g., Illumina NovaSeq, Ion Torrent).',
    `quality_score` DECIMAL(18,2) COMMENT 'Overall quality metric for the sequencing run, reflecting coverage depth and data reliability.',
    `recommendations` STRING COMMENT 'Clinical recommendations provided by the interpreting geneticist, such as follow-up testing, genetic counseling, or surveillance guidelines.',
    `report_amended_date` DATE COMMENT 'Date on which the report was last amended, if applicable.',
    `report_date` DATE COMMENT 'Date on which the final or preliminary genomics report was issued by the laboratory.',
    `report_status` STRING COMMENT 'Current lifecycle status of the clinical genomics report indicating its stage in the workflow.',
    `report_type` STRING COMMENT 'Classification of the genomic report by the type of genetic analysis performed.',
    `specimen_collection_date` DATE COMMENT 'Date on which the biological specimen was collected from the patient.',
    `specimen_received_date` DATE COMMENT 'Date on which the performing laboratory received the specimen for genomic testing.',
    `specimen_type` STRING COMMENT 'Type of biological specimen collected for genomic analysis.',
    `test_code` STRING COMMENT 'Standardized code identifying the genomic test, typically mapped to CPT or proprietary lab test codes.',
    `test_name` STRING COMMENT 'Name of the specific genomic test or panel ordered (e.g., Whole Exome Sequencing, Hereditary Cancer Panel, Tumor Profiling).',
    `testing_methodology` STRING COMMENT 'Description of the sequencing or analysis methodology used (e.g., Next-Generation Sequencing, Sanger Sequencing, FISH, Microarray).',
    `therapy_implication_flag` BOOLEAN COMMENT 'Indicates whether the genomic findings have direct implications for targeted therapy or drug selection in precision medicine.',
    `turnaround_time_days` STRING COMMENT 'Number of calendar days from specimen receipt to report issuance, used for laboratory performance monitoring.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this clinical genomics report record was last modified.',
    `variant_count` STRING COMMENT 'Total number of variants identified and reported in the genomic analysis.',
    CONSTRAINT pk_clinical_genomics_report PRIMARY KEY(`clinical_genomics_report_id`)
) COMMENT 'Table storing clinical genomics reports.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` (
    `genomics_genomic_order_id` BIGINT COMMENT 'Primary key for genomics_genomic_order',
    `care_site_id` BIGINT COMMENT 'Identifier of the facility where the order was placed.',
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to billing.cdm_entry.BIGINT surrogate key for clean keying. Business justification: Revenue cycle charge capture: genomic test orders must map to CDM entries for proper pricing, charge generation, and reimbursement. Every ordered genomic test triggers a billable charge via CDM lookup',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order.BIGINT surrogate key for clean keying. Business justification: Clinicians place genomic tests via CPOE as clinical orders; the genomic_order is a downstream specialization. Linking back to the originating clinical_order enables order reconciliation, CPOE audit tr',
    `trial_id` BIGINT COMMENT 'Identifier of the clinical trial associated with the genomic test, if applicable.',
    `clinician_id` BIGINT COMMENT 'Unique identifier of the clinician who placed the genomic order.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Genomic test orders require valid CPT codes (e.g., 81225-81479 molecular pathology range) for insurance pre-authorization, claims submission, and reimbursement. Every genomic order must reference a bi',
    `genomic_order_id` BIGINT COMMENT 'System-generated unique identifier for the genomic order record.',
    `genomics_genomic_consent_id` BIGINT COMMENT 'Foreign key linking to genomics.genomic_consent. Business justification: A genomic order requires patient consent before testing can proceed. The consent_status string field becomes redundant when linked to the authoritative genomic_consent record which has full consent li',
    `hipaa_retention_annotation_id` BIGINT COMMENT 'Foreign key linking to uc_tags.hipaa_retention_annotation. Business justification: Genomic orders contain PHI with retention_period_years denormalized. Linking to hipaa_retention_annotation enables compliance officers to trace retention rules to specific regulatory mandates during',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: Genomic test orders require a clinical indication/diagnosis for medical necessity, insurance authorization, and compliance. Standard ordering workflow in oncology and rare disease programs.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient for whom the genomic test is ordered.',
    `order_authorization_id` BIGINT COMMENT 'Identifier of the payer authorization linked to the order.',
    `provider_location_id` BIGINT COMMENT 'Identifier of the specific location (e.g., clinic, department) where the order originated.',
    `research_study_id` BIGINT COMMENT 'Identifier of the research study linked to the order.',
    `specimen_id` BIGINT COMMENT 'Identifier of the biological specimen linked to the order.',
    `trading_partner_id` BIGINT COMMENT 'Foreign key linking to interoperability.trading_partner. Business justification: Genomic test orders are routed to external reference labs (trading partners like Quest, GeneDx). Essential for order routing, result reconciliation, and SLA tracking with send-out genomics labs.',
    `visit_id` BIGINT COMMENT 'Foreign key linking to encounter.visit. Business justification: Genomic tests are ordered during specific clinical encounters. Visit context is required for billing reconciliation, clinical decision audit, and CMS documentation requirements linking orders to encou',
    `accession_number` STRING COMMENT 'Laboratory accession number assigned to the specimen.',
    `clinical_interpretation` STRING COMMENT 'Narrative interpretation of the genomic findings.',
    `collection_date` DATE COMMENT 'Date the specimen was collected from the patient.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the order record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the order amount.. Valid values are `USD|EUR|GBP|CAD|JPY|AUD`',
    `is_clinical_trial` BOOLEAN COMMENT 'Flag indicating whether the order is part of a clinical trial.',
    `is_research` BOOLEAN COMMENT 'Flag indicating whether the order is for research purposes rather than clinical care.',
    `notes` STRING COMMENT 'Free‑text field for additional comments or special instructions.',
    `order_amount` DECIMAL(18,2) COMMENT 'Charged amount for the genomic test before adjustments.',
    `order_number` STRING COMMENT 'Human‑readable business identifier assigned to the order, used for tracking and communication.',
    `order_status` STRING COMMENT 'Current lifecycle state of the genomic order.. Valid values are `draft|submitted|in_progress|completed|cancelled|rejected`',
    `order_timestamp` TIMESTAMP COMMENT 'Date‑time when the order was placed in the clinical system.',
    `report_url` STRING COMMENT 'Link to the electronic genomic report stored in the EHR.',
    `result_release_date` DATE COMMENT 'Date the final genomic report was made available to the ordering clinician.',
    `result_status` STRING COMMENT 'State of the genomic test result generation.. Valid values are `pending|available|failed`',
    `retention_period_years` STRING COMMENT 'Number of years the order record must be retained to satisfy HIPAA and institutional policies.',
    `test_priority` STRING COMMENT 'Clinical priority assigned to the test, influencing turnaround time.. Valid values are `routine|stat|urgent`',
    `test_type` STRING COMMENT 'The specific genomic test requested (e.g., Whole Genome Sequencing, Targeted Panel).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the order record.',
    CONSTRAINT pk_genomics_genomic_order PRIMARY KEY(`genomics_genomic_order_id`)
) COMMENT 'Record of a request for a genomic test or sequencing service, capturing patient, ordering provider, test type, priority, and order status.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` (
    `genomics_sequencing_run_id` BIGINT COMMENT 'Primary key for genomics_sequencing_run',
    `care_site_id` BIGINT COMMENT 'Identifier of the sequencing center or facility hosting the instrument.',
    `employee_id` BIGINT COMMENT 'Identifier of the staff member who initiated or supervised the run.',
    `genomics_genomic_order_id` BIGINT COMMENT 'Foreign key linking to genomics.genomic_order. Business justification: A sequencing run is performed to fulfill a genomic order. Many runs can be associated with one order (e.g., reruns, multi-lane). This links the operational run back to the originating clinical order. ',
    `specimen_id` BIGINT COMMENT 'Identifier of the biological sample processed in this run.',
    `genomics_specimen_id` BIGINT COMMENT 'Foreign key linking to laboratory.specimen. Business justification: Sequencing runs process specific laboratory specimens. Direct specimen traceability on runs is required for quality control, contamination investigations, and regulatory compliance (CAP checklist). Th',
    `hipaa_retention_annotation_id` BIGINT COMMENT 'Foreign key linking to uc_tags.hipaa_retention_annotation. Business justification: Sequencing runs generate massive PHI datasets with compliance_retention_days. Linking to hipaa_retention_annotation enables storage lifecycle management tied to specific regulatory mandates.',
    `instrument_id` BIGINT COMMENT 'Identifier of the sequencing instrument used for the run.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient from whom the sample originated.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Labs must track which reagent kit lot was used per sequencing run for FDA recall response, QC failure investigation, and cost allocation. Domain experts expect reagent traceability to material master ',
    `sequencing_run_id` BIGINT COMMENT 'Unique system-generated identifier for the sequencing run.',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: CLIA regulations require a medical director (credentialed clinician) to authorize/supervise clinical sequencing runs. Distinct from operator_id (technician). Required for lab accreditation compliance ',
    `batch_number` STRING COMMENT 'Identifier for the batch of samples processed together.',
    `chemistry_version` STRING COMMENT 'Version of the sequencing chemistry kit used.',
    `compliance_retention_days` STRING COMMENT 'Number of days required to retain the run data for regulatory compliance.',
    `control_type` STRING COMMENT 'Type of control sample used, if applicable.. Valid values are `positive|negative|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sequencing run record was first created in the system.',
    `data_path` STRING COMMENT 'File system or object storage path where raw and processed data are stored.',
    `data_retention_policy` STRING COMMENT 'Policy name governing how long run data are retained (e.g., HIPAA_7yr).',
    `end_timestamp` TIMESTAMP COMMENT 'Date and time when the run completed or was terminated.',
    `flowcell_code` STRING COMMENT 'Identifier of the flowcell hardware used.',
    `flowcell_type` STRING COMMENT 'Model or type of the flowcell (e.g., NovaSeq S4).',
    `is_control_run` BOOLEAN COMMENT 'Indicates whether the run is a control (quality assurance) run.',
    `lane_count` STRING COMMENT 'Number of flowcell lanes used in the run.',
    `library_prep_kit` STRING COMMENT 'Name of the library preparation kit.',
    `library_prep_kit_version` STRING COMMENT 'Version of the library preparation kit.',
    `mean_quality_score` DECIMAL(18,2) COMMENT 'Average base quality score across all reads.',
    `notes` STRING COMMENT 'Free-text field for additional comments or observations about the run.',
    `percent_q30` DECIMAL(18,2) COMMENT 'Percentage of bases with quality score ≥30.',
    `qc_pass` BOOLEAN COMMENT 'Indicates whether the run met predefined quality thresholds.',
    `read_length` STRING COMMENT 'Target read length in base pairs.',
    `run_duration_seconds` STRING COMMENT 'Total elapsed time of the run in seconds.',
    `run_identifier` STRING COMMENT 'External business identifier or accession number assigned to the run by the laboratory.',
    `run_location` STRING COMMENT 'Physical location or lab where the run was performed.',
    `run_project_code` STRING COMMENT 'Code linking the run to a research or clinical project.',
    `run_status` STRING COMMENT 'Current lifecycle status of the sequencing run.. Valid values are `pending|running|completed|failed|canceled`',
    `run_type` STRING COMMENT 'Category of sequencing performed.. Valid values are `whole_genome|exome|targeted|rna_seq`',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the run started.',
    `total_bases` BIGINT COMMENT 'Aggregate number of bases sequenced (reads × read length).',
    `total_reads` BIGINT COMMENT 'Total number of sequencing reads generated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the sequencing run record.',
    `yield_gb` DECIMAL(18,2) COMMENT 'Total data output of the run in gigabytes.',
    CONSTRAINT pk_genomics_sequencing_run PRIMARY KEY(`genomics_sequencing_run_id`)
) COMMENT 'Operational event representing a single sequencing instrument run, including instrument ID, run start/end times, batch identifiers, and QC metrics.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` (
    `genomics_genomic_sequence_id` BIGINT COMMENT 'Primary key for genomics_genomic_sequence',
    `genomic_sequence_id` BIGINT COMMENT 'Unique surrogate key for the genomic sequence record.',
    `genomics_genomic_order_id` BIGINT COMMENT 'Clinical order that requested the sequencing.',
    `genomics_sequencing_run_id` BIGINT COMMENT 'Foreign key linking to genomics.sequencing_run. Business justification: A genomic sequence (raw/processed data) is produced by a sequencing run. One run can produce multiple sequences (multi-sample). This establishes the provenance chain from data back to the instrument r',
    `hipaa_retention_annotation_id` BIGINT COMMENT 'Foreign key linking to uc_tags.hipaa_retention_annotation. Business justification: HIPAA mandates documented retention policies for genomic PHI. Compliance audits require tracing each sequence datasets retention rule to its regulatory basis and destruction method.',
    `instrument_id` BIGINT COMMENT 'Identifier of the laboratory that performed sequencing.',
    `mpi_record_id` BIGINT COMMENT 'Medical Record Number linking the sequence to the patient.',
    `specimen_id` BIGINT COMMENT 'Identifier of the biological sample from which the sequence was derived.',
    `alignment_parameters` STRING COMMENT 'Command-line parameters used for alignment.',
    `alignment_tool` STRING COMMENT 'Software tool used for aligning reads to reference.. Valid values are `BWA|Bowtie2|STAR|Minimap2`',
    `assay_type` STRING COMMENT 'Laboratory assay performed for sequencing.. Valid values are `Whole_Genome|Whole_Exome|Targeted|RNA-Seq|Methylation`',
    `checksum` STRING COMMENT 'SHA-256 checksum for data integrity verification.. Valid values are `^[a-fA-F0-9]{64}$`',
    `consent_obtained` BOOLEAN COMMENT 'Indicates whether patient consent for genomic testing was obtained.',
    `coverage_depth` DECIMAL(18,2) COMMENT 'Average read depth coverage across the genome.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sequence record was created in the system.',
    `data_retention_policy` STRING COMMENT 'HIPAA-aligned retention period for the sequence data.. Valid values are `7_years|indefinite|custom`',
    `data_source` STRING COMMENT 'Origin system of the sequence data.. Valid values are `EHR|LIS|External|Research`',
    `effective_from` TIMESTAMP COMMENT 'Timestamp when this version became effective.',
    `effective_to` TIMESTAMP COMMENT 'Timestamp when this version was superseded (null if current).',
    `file_format` STRING COMMENT 'Standard file format of the genomic data.. Valid values are `FASTQ|BAM|CRAM|VCF|FASTA`',
    `file_path` STRING COMMENT 'Storage location URI for the sequence file (e.g., DBFS, S3).',
    `file_size_bytes` BIGINT COMMENT 'Size of the sequence file in bytes.',
    `genomic_build_version` STRING COMMENT 'Version of the genomic build used for alignment.',
    `genomics_genomic_sequence_status` STRING COMMENT 'Current lifecycle status of the sequence record.. Valid values are `available|archived|pending|failed|withdrawn`',
    `is_primary_sequence` BOOLEAN COMMENT 'Indicates if this sequence is the primary reference for the patient.',
    `notes` STRING COMMENT 'Free-text notes regarding the sequence, quality concerns, or processing remarks.',
    `privacy_classification` STRING COMMENT 'Classification level for privacy compliance.. Valid values are `restricted|confidential|public`',
    `quality_score_mean` DECIMAL(18,2) COMMENT 'Average base quality score (Phred) across reads.',
    `read_length_mean` DECIMAL(18,2) COMMENT 'Average length of reads in base pairs.',
    `reference_genome` STRING COMMENT 'Reference genome build used (e.g., GRCh38, hg19).',
    `sequence_type` STRING COMMENT 'Category of the sequence data indicating processing stage.. Valid values are `raw|processed|aligned|variant_call|consensus`',
    `sequencing_date` DATE COMMENT 'Date when the sequencing run was performed.',
    `sequencing_platform` STRING COMMENT 'Technology platform used to generate the sequence.. Valid values are `Illumina|PacBio|Oxford_Nanopore|Ion_Torrent|BGI`',
    `total_reads` BIGINT COMMENT 'Total number of reads generated for the sequence.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the sequence record.',
    `version_number` STRING COMMENT 'Version of the sequence record for SCD Type 2 tracking.',
    CONSTRAINT pk_genomics_genomic_sequence PRIMARY KEY(`genomics_genomic_sequence_id`)
) COMMENT 'Master record of the raw or processed genomic sequence data generated for a patient, storing file locations, format, reference genome, and coverage statistics.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`genomic_report` (
    `genomic_report_id` BIGINT COMMENT 'Unique system-generated identifier for the genomic report.',
    `cda_document_id` BIGINT COMMENT 'Foreign key linking to interoperability.cda_document. Business justification: Genomic lab results are transmitted as structured CDA documents (HL7 Genetic Testing Report). Links report to its exchange document for regulatory traceability and 21st Century Cures Act compliance.',
    `clinician_id` BIGINT COMMENT 'FK to provider.clinician',
    `genomic_test_result_id` BIGINT COMMENT 'Foreign key linking to genomics.genomic_test_result. Business justification: A genomic report summarizes and interprets test results. The report references the primary test result it is based on. Population: at report creation. Nullable: YES (some reports may aggregate multipl',
    `genomics_genomic_order_id` BIGINT COMMENT 'Foreign key linking to genomics.genomic_order. Business justification: A genomic report is generated as a deliverable of a genomic order. Multiple reports may exist per order (amended, supplemental). This closes the order-to-report lifecycle loop. Population: at report g',
    `hipaa_retention_annotation_id` BIGINT COMMENT 'Foreign key linking to uc_tags.hipaa_retention_annotation. Business justification: Genomic reports have denormalized hipaa_retention_annotation column. Normalizing to FK enables consistent retention policy enforcement and audit trail for PHI genomic reports per HIPAA requirements.',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Genomic reports require LOINC codes (e.g., 51969-4 Genetic analysis summary) for FHIR Observation/DiagnosticReport resources, HL7 OBX segments, and standardized laboratory information exchange mandate',
    `molecular_test_id` BIGINT COMMENT 'Unique identifier for the specific genomic test performed.',
    `mpi_record_id` BIGINT COMMENT 'Internal medical record number linking the report to the patient.',
    `primary_genomic_clinician_id` BIGINT COMMENT 'Identifier of the provider who ordered the genomic test.',
    `radiology_study_id` BIGINT COMMENT 'Foreign key linking to radiology.radiology_study. Business justification: Precision oncology tumor boards require correlating genomic findings with the imaging study that identified the lesion/prompted biopsy. Standard integrated cancer care workflow.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: CLIA-certified reference labs sign out genomic reports at a different site than the ordering facility. Required for CLIA compliance tracking, billing reconciliation, and turnaround time reporting by l',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: Precision medicine workflow: genomic reports are ordered for a specific clinical diagnosis (e.g., tumor profiling for cancer). Regulatory reporting and clinical decision support require tracing genomi',
    `visit_id` BIGINT COMMENT 'Foreign key linking to encounter.visit. Business justification: Genomic reports are reviewed and acted upon during specific encounters. Clinicians need encounter-contextualized results for treatment decisions, and quality metrics track result-to-action turnaround ',
    `bioinformatics_pipeline` STRING COMMENT 'Name/version of the pipeline used to analyze sequencing data.',
    `clinical_significance` STRING COMMENT 'Overall clinical significance classification of findings.. Valid values are `pathogenic|likely_pathogenic|uncertain|likely_benign|benign`',
    `collection_date` DATE COMMENT 'Date when the specimen was collected from the patient.',
    `confidentiality_level` STRING COMMENT 'Level of data sensitivity for the report.. Valid values are `restricted|confidential|public`',
    `coverage_depth` STRING COMMENT 'Mean read depth across the targeted regions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the report record was created in the data lake.',
    `delta_table_properties` STRING COMMENT 'Key-value pairs for Delta Lake table configuration (e.g., retention, optimize).',
    `interpretation_text` STRING COMMENT 'Detailed clinical interpretation of the genomic findings.',
    `quality_metric` STRING COMMENT 'Overall quality metric score for the sequencing run.',
    `recommendation_text` STRING COMMENT 'Suggested clinical actions based on the report.',
    `report_date` DATE COMMENT 'Date when the report was finalized and issued.',
    `report_format` STRING COMMENT 'File format of the report document.. Valid values are `pdf|html|xml`',
    `report_language` STRING COMMENT 'Language in which the report is written.',
    `report_status` STRING COMMENT 'Current lifecycle status of the report.. Valid values are `draft|final|amended|retracted`',
    `report_type` STRING COMMENT 'Category of the report indicating its intended use.. Valid values are `clinical|research|screening`',
    `report_version` STRING COMMENT 'Version identifier for the report, incremented on amendments.',
    `retention_period_years` STRING COMMENT 'Number of years the report must be retained per policy.',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk assessment derived from the findings.',
    `sequencing_platform` STRING COMMENT 'Technology platform used for sequencing.. Valid values are `illumina|ion_torrent|pacbio|nanopore`',
    `signoff_pathologist_name` STRING COMMENT 'Name of the signing pathologist.',
    `signoff_timestamp` TIMESTAMP COMMENT 'Date and time when the report was signed.',
    `specimen_type` STRING COMMENT 'Biological material type of the specimen.. Valid values are `blood|saliva|tissue|buccal|urine`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the report record.',
    `variant_summary` STRING COMMENT 'Narrative summary of key genomic variants identified.',
    `patient_id` BIGINT COMMENT 'Internal medical record number linking the report to the patient.',
    `patient_name` STRING COMMENT 'Legal name of the patient as recorded in the EHR.',
    `ordering_provider_id` BIGINT COMMENT 'Identifier of the provider who ordered the genomic test.',
    `ordering_provider_name` STRING COMMENT 'Name of the ordering provider.',
    `specimen_id` STRING COMMENT 'Unique identifier for the specimen used for sequencing.',
    `signoff_pathologist_id` BIGINT COMMENT 'Identifier of the molecular pathologist who signed the report.',
    `hipaa_retention_annotation` STRING COMMENT 'Annotation indicating HIPAA-mandated retention requirements.',
    CONSTRAINT pk_genomic_report PRIMARY KEY(`genomic_report_id`)
) COMMENT 'Authoritative clinical report summarizing genomic findings, interpretations, recommended actions, and sign‑off by a molecular pathologist.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` (
    `genomics_genomic_consent_id` BIGINT COMMENT 'Primary key for genomics_genomic_consent',
    `consent_form_template_id` BIGINT COMMENT 'Reference to the stored consent document.',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Genomic consent must link to master consent_record for HIPAA audit trails, consent verification workflows, and regulatory compliance reporting. Domain experts expect genomic-specific consent to chain ',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Genetic testing informed consent requires documentation of which qualified clinician (genetic counselor/physician) explained risks and obtained consent. Regulatory requirement per state genetic testin',
    `data_sharing_agreement_id` BIGINT COMMENT 'Foreign key linking to interoperability.data_sharing_agreement. Business justification: Patient genomic consent must reference the institutional data sharing agreement governing external genomic data exchange (research networks, precision medicine initiatives). Required for HIPAA/GINA co',
    `employee_id` BIGINT COMMENT 'Identifier of the system user who last updated the consent record.',
    `genomic_consent_id` BIGINT COMMENT 'Unique surrogate key for each genomic consent record.',
    `genomics_employee_id` BIGINT COMMENT 'Identifier of the system user who created the consent record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient providing consent.',
    `visit_id` BIGINT COMMENT 'Foreign key linking to encounter.visit. Business justification: HIPAA and informed consent regulations require documenting the encounter context where genomic consent was obtained. Compliance audits trace consent to specific visit for validity verification.',
    `consent_given_date` DATE COMMENT 'Date when the patient signed the consent.',
    `consent_notes` STRING COMMENT 'Additional notes or comments regarding the consent.',
    `consent_number` STRING COMMENT 'External identifier for the consent record used in communications.',
    `consent_scope` STRING COMMENT 'Scope of consent indicating whether it applies to research, clinical use, or both.. Valid values are `research|clinical|both`',
    `consent_status` STRING COMMENT 'Current status of the consent.. Valid values are `active|revoked|expired|pending`',
    `consent_version` STRING COMMENT 'Version number of the consent form.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consent record was created in the system.',
    `effective_from` DATE COMMENT 'Date when the consent becomes effective.',
    `effective_until` DATE COMMENT 'Date when the consent expires, if applicable.',
    `given_by` STRING COMMENT 'Name of the individual (patient or legal guardian) who provided the consent.',
    `revocation_date` DATE COMMENT 'Date when the consent was revoked, if applicable.',
    `signature_method` STRING COMMENT 'Method used to capture the signature.. Valid values are `electronic|paper|phone|mail`',
    `signature_timestamp` TIMESTAMP COMMENT 'Exact timestamp of the signature capture.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the consent record.',
    CONSTRAINT pk_genomics_genomic_consent PRIMARY KEY(`genomics_genomic_consent_id`)
) COMMENT 'Patient consent record specific to genomic testing, capturing consent version, date, scope (research vs clinical), and revocation status.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` (
    `genomics_patient_genomic_profile_id` BIGINT COMMENT 'Primary key for genomics_patient_genomic_profile',
    `genomic_report_id` BIGINT COMMENT 'Foreign key linking to genomics.genomic_report. Business justification: A patient genomic profile is built from authoritative genomic reports. The existing report_id links to a generic report product; this new FK links to the structured genomic_report with full clinical d',
    `genomics_genomic_sequence_id` BIGINT COMMENT 'Foreign key linking to genomics.genomic_sequence. Business justification: A patient genomic profile references the underlying sequence data. genomic_sequence contains file_path, checksum, file_format, file_size_bytes - making the denormalized columns on patient_genomic_prof',
    `genomics_report_id` BIGINT COMMENT 'External identifier of the generated genomic report.',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Precision medicine workflows require a designated clinician (geneticist/oncologist) responsible for maintaining and acting on patient genomic profiles. Essential for care coordination and clinical dec',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient to whom this genomic profile belongs.',
    `patient_genomic_profile_id` BIGINT COMMENT 'Unique surrogate key for the patient genomic profile record.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Replaces denormalized text field genomic_sequencing_center with proper FK. Enables facility-level analytics on sequencing volume, quality metrics by center, and CLIA compliance verification.',
    `actionability_flag` BOOLEAN COMMENT 'Indicates whether the genomic findings have actionable clinical recommendations.',
    `actionability_summary` STRING COMMENT 'Brief description of recommended clinical actions.',
    `clinical_interpretation_date` TIMESTAMP COMMENT 'Timestamp when the clinical interpretation of the genomic data was completed.',
    `clinical_interpretation_summary` STRING COMMENT 'Narrative summary of the clinical interpretation and its implications.',
    `clinical_trial_association` STRING COMMENT 'Identifier of any clinical trial linked to this genomic profile.',
    `clinical_trial_end_date` DATE COMMENT 'Date the patient completed or exited the trial.',
    `clinical_trial_enrollment_date` DATE COMMENT 'Date the patient enrolled in the associated clinical trial.',
    `clinical_trial_status` STRING COMMENT 'Current status of the patient’s participation in the trial.. Valid values are `enrolled|completed|withdrawn`',
    `consent_date` DATE COMMENT 'Date when consent was obtained or last updated.',
    `consent_status` STRING COMMENT 'Patient consent status for genomic data usage.. Valid values are `consented|revoked|pending`',
    `data_retention_period_years` STRING COMMENT 'Number of years the genomic data must be retained per policy.',
    `genomic_reference_genome` STRING COMMENT 'Reference genome version used for alignment (e.g., GRCh38).',
    `genomic_sequencing_date` DATE COMMENT 'Date on which the patients DNA was sequenced.',
    `genomic_sequencing_method` STRING COMMENT 'Technology used for sequencing (e.g., Next‑Generation Sequencing, Whole‑Exome, Whole‑Genome).. Valid values are `NGS|WES|WGS`',
    `interpretation_confidence_level` STRING COMMENT 'Qualitative confidence level derived from the score.. Valid values are `high|medium|low`',
    `interpretation_confidence_score` DECIMAL(18,2) COMMENT 'Numeric confidence level of the clinical interpretation.',
    `patient_age_at_sequencing` STRING COMMENT 'Patient age in years at the time of DNA sequencing.',
    `patient_ethnicity` STRING COMMENT 'Self‑identified ethnicity of the patient.',
    `patient_family_history_flag` BOOLEAN COMMENT 'Indicates whether a relevant family history of disease exists.',
    `patient_race` STRING COMMENT 'Self‑identified race of the patient.',
    `patient_sex` STRING COMMENT 'Sex of the patient as recorded in the EHR.. Valid values are `male|female|other|unknown`',
    `profile_creation_timestamp` TIMESTAMP COMMENT 'Date and time when the profile record was first created.',
    `profile_effective_date` DATE COMMENT 'Date when the genomic profile becomes clinically effective.',
    `profile_expiration_date` DATE COMMENT 'Date when the profile is no longer considered valid (nullable).',
    `profile_last_updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the profile.',
    `profile_name` STRING COMMENT 'Human‑readable name or label for the genomic profile.',
    `profile_status` STRING COMMENT 'Current lifecycle status of the genomic profile.. Valid values are `active|inactive|archived|pending`',
    `profile_type` STRING COMMENT 'Classification of the genomic profile based on its clinical purpose.. Valid values are `germline|somatic|clinical`',
    `profile_version` STRING COMMENT 'Version number of the genomic profile, incremented on each update.',
    `report_release_date` DATE COMMENT 'Date the genomic report was released to the care team.',
    `report_url` STRING COMMENT 'Link to the electronic version of the genomic report.',
    `report_version` STRING COMMENT 'Version string of the report, reflecting updates or revisions.',
    `risk_category` STRING COMMENT 'Risk category derived from the stratification score.. Valid values are `low|moderate|high|very_high`',
    `risk_stratification_score` DECIMAL(18,2) COMMENT 'pii_phi,pii_pii,pii_sensitive',
    CONSTRAINT pk_genomics_patient_genomic_profile PRIMARY KEY(`genomics_patient_genomic_profile_id`)
) COMMENT 'Aggregated profile linking a patient to their genomic sequences, reports, risk stratifications, and clinical actionability flags.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` (
    `genomic_interpretation_id` BIGINT COMMENT 'System‑generated unique identifier for each genomic interpretation record.',
    `care_site_id` BIGINT COMMENT 'Identifier of the laboratory or facility that performed the genomic assay.',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider who ordered the genomic test.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: Variant interpretations must reference the clinical diagnosis they support/modify for clinical actionability reporting, tumor boards, and genetic counseling documentation.',
    `genomic_report_id` BIGINT COMMENT 'Foreign key linking to genomics.genomic_report. Business justification: A genomic interpretation is a structured finding that is documented within a genomic report. Multiple interpretations feed into one report (e.g., multiple variants interpreted). This links the detaile',
    `genomic_test_result_id` BIGINT COMMENT 'Identifier of the underlying genomic test order that generated the raw data.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient to whom the interpretation applies.',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Genomic variant interpretations must be coded using SNOMED CT for standardized clinical documentation, FHIR DiagnosticReport interoperability, and phenotype-genotype correlation reporting required by ',
    `clinical_actionability` STRING COMMENT 'Recommended clinical actions (e.g., treatment, surveillance) based on the interpretation.',
    `clinical_significance` STRING COMMENT 'Clinically interpreted impact of the genomic finding.. Valid values are `pathogenic|likely_pathogenic|uncertain|likely_benign|benign`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the interpretation record was first created.',
    `effective_date` DATE COMMENT 'Date from which the interpretation is considered clinically valid.',
    `evidence_level` STRING COMMENT 'Strength of supporting evidence for the interpretation, aligned with ACMG/AMP guidelines.. Valid values are `A|B|C|D|E`',
    `evidence_score` DECIMAL(18,2) COMMENT 'Quantitative score (0‑100) summarizing overall evidence strength.',
    `expiration_date` DATE COMMENT 'Date after which the interpretation should be reviewed or retired.',
    `gene_symbol` STRING COMMENT 'HGNC‑approved gene symbol(s) referenced in the interpretation.',
    `hipaa_retention_years` STRING COMMENT 'Number of years the interpretation must be retained to satisfy HIPAA regulations.',
    `interpretation_date` DATE COMMENT 'Date the interpretation was authored.',
    `interpretation_status` STRING COMMENT 'Current lifecycle status of the interpretation.. Valid values are `draft|pending|final|retracted`',
    `interpretation_summary` STRING COMMENT 'Brief, human‑readable summary of the genomic findings and their clinical relevance.',
    `interpretation_text` STRING COMMENT 'Full free‑text narrative of the genomic interpretation.',
    `interpretation_type` STRING COMMENT 'Category describing the purpose of the interpretation.. Valid values are `diagnostic|prognostic|pharmacogenomic|research`',
    `interpretation_version` STRING COMMENT 'Version of the interpretation document to support SCD Type 2 change tracking.',
    `phenotype_relevance` STRING COMMENT 'Narrative linking the genomic result to observed patient phenotype(s).',
    `recommended_pathway` STRING COMMENT 'Suggested care pathway or guideline reference (e.g., NCCN, CPIC).',
    `report_date` DATE COMMENT 'Date the interpretation report was released to the ordering provider.',
    `source_system` STRING COMMENT 'Name of the originating source system (e.g., Epic, Cerner) that supplied the raw genomic data.',
    `supporting_evidence_codes` STRING COMMENT 'Comma‑separated list of standard codes (e.g., PMID, ClinVar IDs) that substantiate the interpretation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the interpretation record.',
    `variant_count` STRING COMMENT 'Number of distinct genomic variants considered in this interpretation.',
    `genomic_test_id` BIGINT COMMENT 'Identifier of the underlying genomic test order that generated the raw data.',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient to whom the interpretation applies.',
    `ordering_provider_id` BIGINT COMMENT 'Identifier of the provider who ordered the genomic test.',
    `lab_facility_id` BIGINT COMMENT 'Identifier of the laboratory or facility that performed the genomic assay.',
    CONSTRAINT pk_genomic_interpretation PRIMARY KEY(`genomic_interpretation_id`)
) COMMENT 'Structured interpretation of genomic findings, including phenotype relevance, evidence level, and recommended clinical pathways.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`genomic_test_result` (
    `genomic_test_result_id` BIGINT COMMENT 'Unique surrogate key for each genomic test result record.',
    `clinician_id` BIGINT COMMENT 'Identifier of the clinician who ordered the genomic test.',
    `specimen_id` BIGINT COMMENT 'Laboratory accession number for the specimen.',
    `genomic_specimen_id` BIGINT COMMENT 'Foreign key linking to laboratory.specimen. Business justification: Genomic test results must be directly traceable to the specimen for chain-of-custody compliance, quality investigations, and CAP/CLIA accreditation audits. Direct specimen linkage on results is standa',
    `genomics_genomic_consent_id` BIGINT COMMENT 'Reference to the patient consent governing use of genomic data.',
    `genomics_genomic_order_id` BIGINT COMMENT 'Identifier of the original genomic test order.',
    `genomics_report_id` BIGINT COMMENT 'Identifier assigned by an external genomics vendor.',
    `instrument_id` BIGINT COMMENT 'Identifier of the laboratory that performed the sequencing.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient to whom the result pertains.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Genomic tests are performed at CLIA-certified lab sites distinct from ordering facilities. Regulatory compliance (CLIA, CAP) requires tracking which certified site performed each test for accreditatio',
    `billing_code` STRING COMMENT 'CPT/HCPCS code used for reimbursement of the genomic test.. Valid values are `^[0-9]{5}$`',
    `clinical_significance` STRING COMMENT 'Standardized classification of the clinical impact of the reported variants.. Valid values are `pathogenic|likely_pathogenic|benign|likely_benign|uncertain_significance`',
    `confidence_score` DECIMAL(18,2) COMMENT 'Statistical confidence (0‑100) of the result interpretation.',
    `coverage_depth` STRING COMMENT 'Average read depth across the sequenced regions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the result record was first created in the data lake.',
    `interpretation_summary` STRING COMMENT 'Concise clinical interpretation of the genomic findings.',
    `is_confirmed` BOOLEAN COMMENT 'Indicates whether the result has been clinically validated and signed off.',
    `is_retest_needed` BOOLEAN COMMENT 'True if additional testing is recommended based on the result.',
    `notes` STRING COMMENT 'Additional free‑text comments from the interpreting geneticist.',
    `report_url` STRING COMMENT 'Secure link to the full PDF/HTML report stored in the EHR.',
    `result_code` STRING COMMENT 'System‑generated alphanumeric code identifying the specific test result.. Valid values are `^[A-Z0-9]{10}$`',
    `result_date` TIMESTAMP COMMENT 'Timestamp when the final result was released to the ordering clinician.',
    `result_description` STRING COMMENT 'Free‑text narrative describing the overall outcome of the genomic test.',
    `result_status` STRING COMMENT 'Current lifecycle state of the result record.. Valid values are `final|preliminary|pending|canceled`',
    `result_version` STRING COMMENT 'Version number of the result record to support SCD Type 2 changes.',
    `specimen_type` STRING COMMENT 'Biological material from which DNA was extracted.. Valid values are `blood|saliva|tissue`',
    `test_type` STRING COMMENT 'Category of genomic assay performed.. Valid values are `whole_genome|exome|targeted_panel|pharmacogenomics`',
    `turnaround_time_days` STRING COMMENT 'Number of calendar days from specimen receipt to result release.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the result record.',
    `test_order_id` BIGINT COMMENT 'Identifier of the original genomic test order.',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient to whom the result pertains.',
    `provider_id` BIGINT COMMENT 'Identifier of the clinician who ordered the genomic test.',
    `lab_id` BIGINT COMMENT 'Identifier of the laboratory that performed the sequencing.',
    `consent_id` BIGINT COMMENT 'Reference to the patient consent governing use of genomic data.',
    `external_report_id` STRING COMMENT 'Identifier assigned by an external genomics vendor.',
    `sample_id` STRING COMMENT 'Laboratory accession number for the specimen.. Valid values are `^[A-Z0-9]{8}$`',
    CONSTRAINT pk_genomic_test_result PRIMARY KEY(`genomic_test_result_id`)
) COMMENT 'Result record delivering the final interpreted outcome of a genomic test, with result date, summary metrics, and linkage to the associated report.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` (
    `precision_trial_enroll_id` BIGINT COMMENT 'Unique surrogate key for each precision trial enrollment record.',
    `clinician_id` BIGINT COMMENT 'Identifier of the principal investigator or provider overseeing the enrollment.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee.BIGINT surrogate key for clean keying. Business justification: Clinical research coordinators (CRCs) manage precision medicine trial enrollments—scheduling visits, obtaining consent, tracking follow-up. FDA 21 CFR Part 11 and GCP require documenting responsible p',
    `genomic_test_result_id` BIGINT COMMENT 'Foreign key linking to genomics.genomic_test_result. Business justification: Precision medicine trial enrollment is driven by genomic test results (biomarker-driven eligibility). The biomarker_status field on precision_trial_enroll can be derived from the linked genomic_test_r',
    `genomics_genomic_consent_id` BIGINT COMMENT 'Foreign key linking to genomics.genomic_consent. Business justification: Precision trial enrollment requires genomic-specific consent. Linking to genomic_consent provides the authoritative consent record. consent_version is available on genomic_consent. Population: at enro',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient (master party) participating in the trial.',
    `population_health_cohort_cohort_definition_id` BIGINT COMMENT 'Foreign key linking to population_health_cohort.cohort_definition. Business justification: Precision medicine trials recruit from population health cohorts defined by genomic markers (e.g., BRCA+ cohort). Cohort-based recruitment is a standard workflow where population health identifies eli',
    `research_clinical_trial_matching_eligibility_evaluation_id` BIGINT COMMENT 'Foreign key linking to research_clinical_trial_matching.eligibility_evaluation. Business justification: Precision trial enrollment must reference the eligibility evaluation that qualified the patient. Required for audit trails, regulatory compliance (21 CFR Part 11), and ensuring enrollment decisions ar',
    `research_consent_id` BIGINT COMMENT 'Foreign key linking to consent.research_consent. Business justification: Precision medicine trial enrollment requires IRB-approved research consent per 21 CFR 50. Links enrollment to the formal research consent record tracking comprehension assessment, reconsent, and IRB p',
    `research_study_id` BIGINT COMMENT 'Identifier of the clinical trial to which the patient is being enrolled.',
    `study_site_id` BIGINT COMMENT 'Identifier of the facility or site where the enrollment took place.',
    `consent_date` DATE COMMENT 'Date on which the patient signed the informed consent.',
    `consent_given` BOOLEAN COMMENT 'Indicates whether the patient has provided informed consent for trial participation.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Gross cost charged for the enrollment (e.g., screening fee).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary amounts.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any discount applied to the enrollment cost.',
    `effective_from` DATE COMMENT 'Date when the patient’s participation in the trial becomes effective.',
    `effective_until` DATE COMMENT 'Date when the patient’s participation ends or is expected to end (nullable for ongoing trials).',
    `eligibility_criteria_version` STRING COMMENT 'Version identifier of the eligibility criteria set applied to this enrollment.',
    `eligibility_status` STRING COMMENT 'Result of the eligibility assessment for the patient.. Valid values are `met|not_met|pending_review`',
    `enrollment_date` TIMESTAMP COMMENT 'Timestamp of the enrollment event (when the patient was officially enrolled).',
    `enrollment_number` STRING COMMENT 'Business identifier assigned to the enrollment transaction, used for tracking and reporting.',
    `enrollment_source` STRING COMMENT 'Origin of the enrollment request (e.g., referral, self‑referral, physician order).. Valid values are `referral|self|physician|research_staff`',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the enrollment record.. Valid values are `pending|eligible|ineligible|withdrawn|completed`',
    `enrollment_type` STRING COMMENT 'Indicates whether the enrollment is for screening, full participation, or follow‑up.. Valid values are `screening|full|followup`',
    `follow_up_date` DATE COMMENT 'Planned date for the first follow‑up visit.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether the patient requires scheduled follow‑up after enrollment.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount after discounts and adjustments.',
    `notes` STRING COMMENT 'Free‑form notes entered by staff regarding the enrollment.',
    `protocol_version` STRING COMMENT 'Version of the trial protocol under which the patient is enrolled.',
    `randomization_group` STRING COMMENT 'Assigned randomization arm for the patient.. Valid values are `control|treatment|placebo`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the enrollment record.',
    `trial_id` BIGINT COMMENT 'Identifier of the clinical trial to which the patient is being enrolled.',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient (master party) participating in the trial.',
    `site_id` BIGINT COMMENT 'Identifier of the facility or site where the enrollment took place.',
    `investigator_id` BIGINT COMMENT 'Identifier of the principal investigator or provider overseeing the enrollment.',
    `consent_version` STRING COMMENT 'Version of the consent document that was signed.',
    `biomarker_status` STRING COMMENT 'Result of the key biomarker test used for eligibility.. Valid values are `positive|negative|unknown`',
    CONSTRAINT pk_precision_trial_enroll PRIMARY KEY(`precision_trial_enroll_id`)
) COMMENT 'Enrollment transaction for a patient into a precision‑medicine clinical trial, capturing trial ID, eligibility criteria, consent, and enrollment date.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` (
    `genomic_quality_control_id` BIGINT COMMENT 'Unique identifier for the genomic quality control metric. _canonical_skip_reason: Inferred role REFERENCE_LOOKUP; no minimum categories required.',
    `acceptable_range_lower` DECIMAL(18,2) COMMENT 'Lower bound of the acceptable range for the metric.',
    `acceptable_range_upper` DECIMAL(18,2) COMMENT 'Upper bound of the acceptable range for the metric.',
    `applicable_platform` STRING COMMENT 'Sequencing platform(s) to which the metric applies.. Valid values are `Illumina|PacBio|OxfordNanopore`',
    `applicable_sample_type` STRING COMMENT 'Sample material types for which the metric is valid.. Valid values are `DNA|RNA|FFPE|Fresh`',
    `applicable_sequencing_type` STRING COMMENT 'Sequencing assay types for which the metric is relevant.. Valid values are `WGS|WES|RNA-Seq|Targeted`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the metric record was first created.',
    `genomic_quality_control_status` STRING COMMENT 'Current lifecycle status of the metric definition.. Valid values are `active|inactive|deprecated`',
    `is_deprecated` BOOLEAN COMMENT 'Flag indicating whether the metric definition is deprecated.',
    `last_validated_timestamp` TIMESTAMP COMMENT 'Date‑time when the metric definition was last validated.',
    `metric_category` STRING COMMENT 'High‑level classification of the metric type.. Valid values are `quality|coverage|contamination|alignment|variant|expression`',
    `metric_code` STRING COMMENT 'Standardized code or identifier for the metric, often aligned with external vocabularies.',
    `metric_description` STRING COMMENT 'Detailed description of what the metric measures and its clinical relevance.',
    `metric_name` STRING COMMENT 'Human‑readable name of the quality control metric (e.g., "Mean Coverage").',
    `metric_type` STRING COMMENT 'Data type of the metric value.. Valid values are `numeric|boolean|categorical`',
    `notes` STRING COMMENT 'Free‑form comments or additional information about the metric.',
    `retention_policy` STRING COMMENT 'Data retention rule for the metric record, aligned with HIPAA requirements.. Valid values are `7_years|indefinite`',
    `severity_level` STRING COMMENT 'Indicates the impact level if the metric falls outside the acceptable range.. Valid values are `critical|high|medium|low|info`',
    `source_system` STRING COMMENT 'Originating system or standard that supplied the metric definition.',
    `threshold_unit` STRING COMMENT 'Unit of measure for the threshold (e.g., "x", "percent", "phred").',
    `threshold_value` DECIMAL(18,2) COMMENT 'Numeric threshold that defines acceptable performance for the metric.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the metric record.',
    `validation_method` STRING COMMENT 'Method used to validate the metric definition.. Valid values are `automated|manual|mixed`',
    `version` STRING COMMENT 'Version identifier for the metric definition, allowing change tracking.',
    `status` STRING COMMENT 'Current lifecycle status of the metric definition.. Valid values are `active|inactive|deprecated`',
    CONSTRAINT pk_genomic_quality_control PRIMARY KEY(`genomic_quality_control_id`)
) COMMENT 'Reference table of QC metric definitions and acceptable thresholds used to evaluate sequencing run quality.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`genomic_test` (
    `genomic_test_id` BIGINT COMMENT 'Primary key for genomic_test',
    `care_site_id` BIGINT COMMENT 'The laboratory facility responsible for performing the genomic test.',
    `clinician_id` BIGINT COMMENT 'The provider who placed the genomic test order.',
    `genomic_genetic_counselor_clinician_id` BIGINT COMMENT 'The genetic counselor involved in pre-test or post-test counseling for this order.',
    `genomic_ordering_facility_care_site_id` BIGINT COMMENT 'The healthcare facility or care site from which the genomic test was ordered.',
    `mpi_record_id` BIGINT COMMENT 'The patient for whom the genomic test was ordered.',
    `parent_test_genomic_test_id` BIGINT COMMENT 'Reference to the original genomic test that triggered this reflex or follow-up test.',
    `visit_id` BIGINT COMMENT 'The clinical encounter during which the genomic test was ordered.',
    `accession_number` STRING COMMENT 'Unique laboratory-assigned tracking number for the specimen and test order.',
    `authorization_status` STRING COMMENT 'Status of the insurance prior authorization for the genomic test.',
    `cancellation_reason` STRING COMMENT 'Reason for cancellation if the genomic test order was cancelled (e.g., patient refusal, specimen inadequate, duplicate order).',
    `clinical_indication` STRING COMMENT 'The clinical reason or suspected condition prompting the genomic test (e.g., suspected hereditary breast cancer, unexplained cardiomyopathy).',
    `clinical_significance` STRING COMMENT 'ACMG five-tier classification of the overall clinical significance of findings.',
    `consent_date` DATE COMMENT 'Date on which the patient provided informed consent for the genomic test.',
    `consent_obtained` BOOLEAN COMMENT 'Indicates whether informed consent for genomic testing was obtained from the patient prior to specimen collection.',
    `cpt_code` STRING COMMENT 'CPT code representing the specific genomic test procedure for billing and coding purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the genomic test record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the estimated charge amount.',
    `estimated_charge_amount` DECIMAL(18,2) COMMENT 'Estimated charge amount for the genomic test based on the charge description master (CDM).',
    `family_history_relevant` BOOLEAN COMMENT 'Indicates whether relevant family history of genetic conditions was documented as part of the test order.',
    `genes_tested_count` STRING COMMENT 'Total number of genes included in the test panel or analysis.',
    `genetic_counseling_recommended` BOOLEAN COMMENT 'Indicates whether genetic counseling is recommended based on the test results.',
    `icd10_code` STRING COMMENT 'Primary ICD-10 diagnosis code supporting medical necessity for the genomic test.',
    `insurance_authorization_number` STRING COMMENT 'Prior authorization or pre-certification number obtained from the payer for the genomic test.',
    `interpretation_narrative` STRING COMMENT 'Free-text clinical interpretation and summary of genomic findings authored by the laboratory geneticist or genetic counselor.',
    `is_reflex_test` BOOLEAN COMMENT 'Indicates whether this genomic test was automatically triggered (reflexed) based on a prior test result.',
    `loinc_code` STRING COMMENT 'LOINC code identifying the specific genomic test observation for interoperability and standardized reporting.',
    `mean_coverage_depth` DECIMAL(18,2) COMMENT 'Average sequencing read depth across the targeted regions, indicating data quality.',
    `notes` STRING COMMENT 'Free-text clinical notes or special instructions associated with the genomic test order.',
    `order_date` DATE COMMENT 'Date on which the genomic test was ordered by the provider.',
    `order_number` STRING COMMENT 'The externally-visible order number assigned by the ordering system (e.g., Epic Beaker, Cerner PathNet).',
    `order_timestamp` TIMESTAMP COMMENT 'Precise date and time when the genomic test order was placed in the ordering system.',
    `panel_name` STRING COMMENT 'Name of the specific gene panel or test panel ordered (e.g., Hereditary Cancer Panel, Cardiac Panel).',
    `panel_version` STRING COMMENT 'Version identifier of the gene panel used, reflecting updates to gene content over time.',
    `priority` STRING COMMENT 'Clinical urgency level assigned to the genomic test order.',
    `reference_genome` STRING COMMENT 'Human reference genome assembly version used for variant calling and annotation.',
    `report_delivery_method` STRING COMMENT 'Method by which the genomic test report is delivered to the ordering provider.',
    `report_released_timestamp` TIMESTAMP COMMENT 'Date and time when the final genomic test report was released to the ordering provider.',
    `research_use_consent` BOOLEAN COMMENT 'Indicates whether the patient consented to use of their genomic data for research purposes.',
    `result_date` DATE COMMENT 'Date on which the final genomic test result was reported by the performing laboratory.',
    `result_summary` STRING COMMENT 'High-level summary classification of the genomic test result.',
    `sequencing_platform` STRING COMMENT 'The next-generation sequencing (NGS) platform or technology used for the test (e.g., Illumina NovaSeq, Ion Torrent).',
    `specimen_adequacy` STRING COMMENT 'Assessment of whether the collected specimen meets quality and quantity requirements for genomic analysis.',
    `specimen_collection_date` DATE COMMENT 'Date on which the biological specimen was collected from the patient.',
    `specimen_received_date` DATE COMMENT 'Date on which the performing laboratory received the specimen.',
    `specimen_type` STRING COMMENT 'Type of biological specimen collected for genomic analysis.',
    `test_status` STRING COMMENT 'Current lifecycle status of the genomic test order from placement through result delivery.',
    `test_type` STRING COMMENT 'Classification of the genomic test methodology ordered.',
    `turnaround_days` STRING COMMENT 'Number of calendar days from specimen receipt to final result reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the genomic test record was last modified.',
    `variants_detected_count` STRING COMMENT 'Total number of reportable variants identified in the genomic test.',
    CONSTRAINT pk_genomic_test PRIMARY KEY(`genomic_test_id`)
) COMMENT 'genomic_test table for storing ordered genomic tests.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`genomic_sequencing_result` (
    `genomic_sequencing_result_id` BIGINT COMMENT 'Primary key for genomic_sequencing_result',
    `care_site_id` BIGINT COMMENT 'The laboratory facility that performed the genomic sequencing analysis.',
    `clinician_id` BIGINT COMMENT 'The provider who ordered the genomic sequencing test.',
    `mpi_record_id` BIGINT COMMENT 'The patient for whom the genomic sequencing was performed.',
    `sequencing_run_id` BIGINT COMMENT 'Foreign key linking to genomics.sequencing_run. Business justification: New FK linking genomic_sequencing_result to the sequencing_run that produced it. Connects this result table to the run infrastructure.',
    `visit_id` BIGINT COMMENT 'The clinical encounter during which the genomic test was ordered or resulted.',
    `accession_number` STRING COMMENT 'Unique laboratory-assigned tracking number for the specimen and sequencing run.',
    `actionable_variants_count` STRING COMMENT 'The number of clinically actionable variants identified that may influence treatment decisions.',
    `amended_reason` STRING COMMENT 'Explanation for why the result was amended or corrected after initial release, if applicable.',
    `bioinformatics_pipeline_version` STRING COMMENT 'Version identifier of the bioinformatics analysis pipeline used for variant calling and annotation, supporting reproducibility.',
    `clia_number` STRING COMMENT 'The CLIA certification number of the laboratory that performed the genomic sequencing, required for regulatory compliance.',
    `clinical_significance_summary` STRING COMMENT 'Narrative summary of the clinical significance of the genomic findings, including actionability and relevance to the patients condition.',
    `clinical_trial_eligibility` BOOLEAN COMMENT 'Indicates whether the genomic findings suggest potential eligibility for one or more clinical trials.',
    `cpt_code` STRING COMMENT 'The CPT billing code associated with the genomic sequencing procedure for reimbursement purposes.',
    `external_lab_name` STRING COMMENT 'Name of the external reference laboratory if the sequencing was performed by a send-out lab rather than in-house.',
    `genes_tested_count` STRING COMMENT 'The total number of genes included in the sequencing panel or analysis.',
    `genetic_counseling_recommended` BOOLEAN COMMENT 'Indicates whether genetic counseling is recommended based on the sequencing findings.',
    `hipaa_minimum_necessary_flag` BOOLEAN COMMENT 'Indicates whether the result disclosure complies with HIPAA minimum necessary standard for protected health information sharing.',
    `incidental_findings_reported` BOOLEAN COMMENT 'Indicates whether ACMG-recommended secondary findings were identified and reported to the patient.',
    `indication_for_testing` STRING COMMENT 'The clinical reason or diagnosis prompting the genomic sequencing order (e.g., suspected hereditary cancer, undiagnosed rare disease).',
    `indication_icd_code` STRING COMMENT 'The ICD-10-CM diagnosis code associated with the clinical indication for genomic testing.',
    `interpreting_geneticist` STRING COMMENT 'Name or identifier of the board-certified clinical geneticist or molecular pathologist who interpreted and signed out the result.',
    `mean_coverage_depth` DECIMAL(18,2) COMMENT 'The average sequencing read depth across the targeted regions, indicating data quality and reliability.',
    `microsatellite_instability_status` STRING COMMENT 'Microsatellite instability classification indicating DNA mismatch repair deficiency, relevant for immunotherapy eligibility.',
    `overall_interpretation` STRING COMMENT 'High-level clinical interpretation summarizing whether clinically significant genomic findings were identified.',
    `pathogenicity_classification` STRING COMMENT 'The highest-level ACMG/AMP pathogenicity classification among all variants identified in the result.',
    `patient_consent_for_research` BOOLEAN COMMENT 'Indicates whether the patient consented to use of their genomic data for research purposes.',
    `percent_bases_above_threshold` DECIMAL(18,2) COMMENT 'Percentage of targeted bases that achieved the minimum required coverage depth (typically 20x or 30x), reflecting analytical validity.',
    `quality_score` DECIMAL(18,2) COMMENT 'Composite quality metric for the sequencing run reflecting base call accuracy, mapping quality, and coverage uniformity.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this genomic sequencing result record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this genomic sequencing result record was last modified.',
    `reference_genome_build` STRING COMMENT 'The human reference genome assembly version used for sequence alignment and variant calling.',
    `report_pdf_url` STRING COMMENT 'Secure URL or document reference to the full genomic sequencing report in PDF format.',
    `requisition_number` STRING COMMENT 'The order requisition number linking back to the original test order in the ordering system.',
    `result_date` DATE COMMENT 'The date the final genomic sequencing result was issued by the laboratory.',
    `result_released_to_patient` BOOLEAN COMMENT 'Indicates whether the genomic result has been released to the patient, per 21st Century Cures Act information blocking rules.',
    `result_status` STRING COMMENT 'Current status of the genomic sequencing result in its lifecycle workflow.',
    `result_timestamp` TIMESTAMP COMMENT 'The precise date and time when the result was finalized and released.',
    `sample_adequacy` STRING COMMENT 'Assessment of whether the specimen provided sufficient quantity and quality of nucleic acid for reliable sequencing.',
    `sequencing_method` STRING COMMENT 'The molecular methodology used: Whole Genome Sequencing (WGS), Whole Exome Sequencing (WES), targeted gene panel, RNA sequencing, or methylation analysis.',
    `sequencing_platform` STRING COMMENT 'The technology platform used for sequencing (e.g., Illumina NovaSeq, Ion Torrent, PacBio, Oxford Nanopore).',
    `specimen_collection_date` DATE COMMENT 'The date the biological specimen was collected from the patient.',
    `specimen_received_date` DATE COMMENT 'The date the specimen was received by the performing laboratory.',
    `specimen_type` STRING COMMENT 'The type of biological specimen from which DNA/RNA was extracted for sequencing.',
    `test_code` STRING COMMENT 'Standardized code identifying the specific genomic test or panel, typically mapped to LOINC or CPT.',
    `test_name` STRING COMMENT 'The name of the genomic sequencing test or panel performed (e.g., Whole Exome Sequencing, Targeted Gene Panel, Whole Genome Sequencing).',
    `test_type` STRING COMMENT 'Classification of the genomic test by its clinical purpose and the type of genetic material analyzed.',
    `therapy_recommendation` STRING COMMENT 'Summary of targeted therapy or treatment recommendations based on identified genomic alterations, aligned with precision medicine guidelines.',
    `tumor_mutational_burden` DECIMAL(18,2) COMMENT 'The number of somatic mutations per megabase of sequenced DNA, used as a biomarker for immunotherapy response in oncology cases.',
    `turnaround_days` STRING COMMENT 'Number of calendar days from specimen receipt to final result release, used for laboratory performance monitoring.',
    `variants_detected_count` STRING COMMENT 'The total number of reportable variants detected in the sequencing result.',
    CONSTRAINT pk_genomic_sequencing_result PRIMARY KEY(`genomic_sequencing_result_id`)
) COMMENT 'Table for genomic sequencing results.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` (
    `precision_treatment_plan_id` BIGINT COMMENT 'Primary key for precision_treatment_plan',
    `care_site_id` BIGINT COMMENT 'The facility or care site where the precision treatment plan is being administered.',
    `trial_id` BIGINT COMMENT 'ClinicalTrials.gov NCT number of the recommended or matched clinical trial, if applicable.',
    `genomic_test_order_id` BIGINT COMMENT 'Reference to the genomic or molecular test order whose results informed this treatment plan.',
    `mpi_record_id` BIGINT COMMENT 'The patient for whom this precision treatment plan is developed based on genomic and clinical findings.',
    `clinician_id` BIGINT COMMENT 'The provider who ordered or initiated the precision treatment plan based on genomic test results.',
    `precision_reviewing_pathologist_clinician_id` BIGINT COMMENT 'The molecular pathologist who reviewed the genomic results and contributed to the treatment plan interpretation.',
    `visit_id` BIGINT COMMENT 'The clinical encounter during which this precision treatment plan was initiated or last reviewed.',
    `alternative_therapy_considered` STRING COMMENT 'Alternative precision therapies that were considered but not selected, with brief rationale for exclusion.',
    `best_response` STRING COMMENT 'Best overall response achieved during the precision treatment plan as assessed by the chosen response criteria.',
    `cancer_stage` STRING COMMENT 'AJCC/TNM cancer stage at the time of precision treatment plan creation, informing treatment intensity. [ENUM-REF-CANDIDATE: I|IA|IB|II|IIA|IIB|III|IIIA|IIIB|IIIC|IV|IVA|IVB — promote to reference product]',
    `clinical_trial_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the patients genomic profile makes them eligible for relevant clinical trials based on identified variants.',
    `companion_diagnostic_test` STRING COMMENT 'Name or identifier of the FDA-approved companion diagnostic test that validated the biomarker for treatment selection.',
    `contraindication_notes` STRING COMMENT 'Documentation of any genomic or clinical contraindications identified that influenced treatment selection or exclusion of alternatives.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the precision treatment plan record was first created in the system.',
    `discontinuation_reason` STRING COMMENT 'Reason for discontinuation of the precision treatment plan if status is completed or cancelled.',
    `dosage_adjustment_rationale` STRING COMMENT 'Clinical rationale for any dosage adjustments made based on pharmacogenomic findings or biomarker levels.',
    `effective_end_date` DATE COMMENT 'Date when the precision treatment plan is expected to conclude or was actually terminated.',
    `effective_start_date` DATE COMMENT 'Date when the precision treatment plan becomes clinically active and treatment may commence.',
    `evidence_level` STRING COMMENT 'Level of clinical evidence supporting the genomic-treatment association (e.g., OncoKB or AMP/ASCO/CAP tiered evidence).',
    `expected_response_rate_percent` DECIMAL(18,2) COMMENT 'Published or evidence-based expected objective response rate for the selected therapy in the patients biomarker-defined population.',
    `genetic_counseling_recommended_flag` BOOLEAN COMMENT 'Indicates whether genetic counseling has been recommended for the patient or family members based on findings.',
    `hereditary_risk_flag` BOOLEAN COMMENT 'Indicates whether the genomic findings suggest a hereditary cancer predisposition syndrome requiring family counseling.',
    `informed_consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether informed consent for genomic-guided precision treatment was obtained from the patient.',
    `intent` STRING COMMENT 'The clinical intent or goal of the precision treatment plan (e.g., curative, palliative, preventive).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the precision treatment plan record was last modified.',
    `line_of_therapy` STRING COMMENT 'Numeric indicator of the treatment line (1=first-line, 2=second-line, etc.) representing how many prior systemic regimens the patient has received.',
    `microsatellite_instability_status` STRING COMMENT 'Microsatellite instability status from genomic testing, relevant for immunotherapy treatment decisions.',
    `molecular_tumor_board_reviewed_flag` BOOLEAN COMMENT 'Indicates whether the precision treatment plan was reviewed and discussed at a molecular tumor board meeting.',
    `monitoring_plan_summary` STRING COMMENT 'Summary of the planned monitoring approach including biomarker reassessment intervals, imaging schedule, and liquid biopsy frequency.',
    `next_reassessment_date` DATE COMMENT 'Scheduled date for the next clinical or genomic reassessment of treatment response and plan continuation.',
    `patient_consent_date` DATE COMMENT 'Date when the patient provided informed consent for the precision treatment plan.',
    `pdl1_expression_percent` DECIMAL(18,2) COMMENT 'PD-L1 tumor proportion score as a percentage, used to determine immunotherapy eligibility.',
    `pharmacogenomic_consideration` STRING COMMENT 'Summary of pharmacogenomic factors affecting drug metabolism or toxicity risk relevant to the treatment plan (e.g., DPYD deficiency, UGT1A1 polymorphism).',
    `plan_number` STRING COMMENT 'Externally-known business identifier for the precision treatment plan, used for clinical communication and documentation.',
    `plan_rationale` STRING COMMENT 'Clinical narrative explaining why this specific precision treatment was selected based on the patients genomic profile and clinical context.',
    `plan_type` STRING COMMENT 'Classification of the precision treatment plan based on the therapeutic approach derived from genomic findings.',
    `precision_treatment_plan_status` STRING COMMENT 'Current lifecycle state of the precision treatment plan within the clinical workflow.',
    `primary_diagnosis_code` STRING COMMENT 'The ICD-10 code for the primary diagnosis that the precision treatment plan addresses.',
    `primary_diagnosis_description` STRING COMMENT 'Human-readable description of the primary diagnosis targeted by this precision treatment plan.',
    `priority` STRING COMMENT 'Clinical priority level assigned to the treatment plan based on disease progression and genomic urgency markers.',
    `resistance_mechanism` STRING COMMENT 'Identified or suspected genomic resistance mechanism if treatment failure or progression occurs (e.g., T790M mutation for EGFR TKI resistance).',
    `response_assessment_method` STRING COMMENT 'The standardized criteria used to assess treatment response (e.g., RECIST for solid tumors, Lugano for lymphoma).',
    `target_biomarker` STRING COMMENT 'The primary genomic biomarker or molecular target identified from testing that drives the treatment selection (e.g., EGFR, BRCA1, HER2, PD-L1).',
    `therapeutic_agent_name` STRING COMMENT 'Name of the primary therapeutic agent or drug recommended in the precision treatment plan based on genomic findings.',
    `therapeutic_agent_ndc` STRING COMMENT 'NDC code of the primary therapeutic agent prescribed in the precision treatment plan.',
    `treatment_cycle_count` STRING COMMENT 'Number of treatment cycles planned or completed as part of this precision treatment plan.',
    `treatment_duration_days` STRING COMMENT 'Planned or actual duration of the precision treatment regimen in calendar days.',
    `tumor_board_review_date` DATE COMMENT 'Date when the molecular tumor board reviewed and discussed this precision treatment plan.',
    `tumor_mutation_burden` DECIMAL(18,2) COMMENT 'Tumor mutation burden score (mutations per megabase) used to inform immunotherapy eligibility in the treatment plan.',
    `variant_classification` STRING COMMENT 'ACMG classification of the primary genomic variant driving the treatment plan decision.',
    CONSTRAINT pk_precision_treatment_plan PRIMARY KEY(`precision_treatment_plan_id`)
) COMMENT 'Table storing precision medicine treatment plans';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`sequencing_data` (
    `sequencing_data_id` BIGINT COMMENT 'Primary key for sequencing_data',
    `care_site_id` BIGINT COMMENT 'Identifier of the laboratory facility that performed the genomic sequencing.',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider who ordered the genomic sequencing test.',
    `genomic_order_id` BIGINT COMMENT 'Foreign key linking to genomics.genomic_order. Business justification: New FK linking sequencing_data to the genomic_order. order_date is available via join to genomic_order.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient from whom the biological sample was collected for genomic sequencing.',
    `sequencing_run_id` BIGINT COMMENT 'Unique identifier for the specific sequencing run on the instrument, used for batch traceability.',
    `specimen_id` BIGINT COMMENT 'Unique identifier of the biological specimen used for sequencing, linking to the biospecimen tracking system.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the sequencing was ordered or the sample was collected.',
    `accession_number` STRING COMMENT 'Unique laboratory accession number assigned to the sequencing run for tracking and identification purposes.',
    `aligner_software` STRING COMMENT 'Software tool and version used for read alignment (e.g., BWA-MEM2 v2.2.1, STAR v2.7.10).',
    `analysis_completion_timestamp` TIMESTAMP COMMENT 'Timestamp when the bioinformatics analysis pipeline completed processing for this sample.',
    `bioinformatics_pipeline` STRING COMMENT 'Name and version of the bioinformatics pipeline used for alignment, variant calling, and annotation.',
    `capture_kit` STRING COMMENT 'The hybridization capture kit or panel used for targeted sequencing (e.g., Agilent SureSelect, IDT xGen).',
    `clia_number` STRING COMMENT 'CLIA certification number of the laboratory performing the sequencing, required for clinical reporting.',
    `clinical_indication` STRING COMMENT 'The clinical reason or diagnosis prompting the genomic sequencing order (e.g., suspected hereditary cancer, pharmacogenomics).',
    `consent_status` STRING COMMENT 'Status of patient consent for genomic data use, storage, and potential research sharing.',
    `contamination_estimate_percent` DECIMAL(18,2) COMMENT 'Estimated cross-sample contamination percentage detected during quality control analysis.',
    `data_file_path` STRING COMMENT 'Storage location path for the primary sequencing data files (FASTQ, BAM, CRAM) in the institutional data lake or object store.',
    `duplicate_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of reads identified as PCR or optical duplicates, indicating library complexity and potential bias.',
    `file_format` STRING COMMENT 'Primary file format of the stored sequencing data output.',
    `file_size_gb` DECIMAL(18,2) COMMENT 'Total file size of the sequencing data output in gigabytes, relevant for storage planning and data transfer.',
    `gc_bias_percent` DECIMAL(18,2) COMMENT 'Measure of GC content bias in the sequencing data, which can affect coverage uniformity.',
    `icd10_indication_code` STRING COMMENT 'ICD-10 diagnosis code associated with the clinical indication for sequencing.',
    `insert_size_mean_bp` DECIMAL(18,2) COMMENT 'Average insert size of the sequencing library fragments in base pairs, a library quality metric.',
    `instrument_model` STRING COMMENT 'Specific model of the sequencing instrument used (e.g., NovaSeq 6000, HiSeq X, MinION).',
    `lane_number` STRING COMMENT 'The lane number on the flow cell where this sample was sequenced, relevant for quality control and demultiplexing.',
    `library_preparation_method` STRING COMMENT 'The molecular biology protocol used to prepare the DNA/RNA library for sequencing (e.g., TruSeq, Nextera, KAPA).',
    `mean_base_quality_score` DECIMAL(18,2) COMMENT 'Average Phred quality score across all bases in the sequencing run, indicating base call accuracy.',
    `mean_coverage_depth` DECIMAL(18,2) COMMENT 'Average number of times each base in the target region was sequenced, a primary quality metric for clinical genomics.',
    `on_target_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of mapped reads that fall within the intended target regions, relevant for panel and exome sequencing efficiency.',
    `paired_end_flag` BOOLEAN COMMENT 'Indicates whether the sequencing was performed in paired-end mode (true) or single-end mode (false).',
    `panel_name` STRING COMMENT 'Name of the targeted gene panel used for sequencing, if applicable (e.g., Oncomine Comprehensive, FoundationOne CDx).',
    `percent_bases_above_30x` DECIMAL(18,2) COMMENT 'Percentage of targeted bases with at least 30x coverage depth, a clinical adequacy threshold for variant calling.',
    `percent_q30_bases` DECIMAL(18,2) COMMENT 'Percentage of bases with a Phred quality score of 30 or higher (99.9% accuracy), a standard sequencing quality metric.',
    `platform` STRING COMMENT 'The sequencing technology platform or instrument manufacturer used to generate the data.',
    `qc_status` STRING COMMENT 'Overall quality control status of the sequencing data based on predefined thresholds for coverage, quality scores, and contamination.',
    `read_length_bp` STRING COMMENT 'The length of individual sequencing reads in base pairs, a key parameter affecting data quality and coverage.',
    `reads_mapped` BIGINT COMMENT 'Number of reads that successfully aligned to the reference genome after bioinformatics processing.',
    `reference_genome` STRING COMMENT 'The human reference genome assembly version used for read alignment and variant calling.',
    `sample_collection_date` DATE COMMENT 'Date when the biological sample was collected from the patient.',
    `sample_type` STRING COMMENT 'Classification of the biological sample source material used for sequencing.',
    `sequencing_completion_timestamp` TIMESTAMP COMMENT 'Timestamp when the sequencing instrument run completed for this sample.',
    `sequencing_data_status` STRING COMMENT 'Current lifecycle status of the sequencing data record from order through completion.',
    `sequencing_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the sequencing instrument run began for this sample.',
    `sequencing_type` STRING COMMENT 'Classification of the genomic sequencing methodology used for this run.',
    `tissue_source` STRING COMMENT 'Anatomical site or tissue type from which the sample was obtained (e.g., blood, bone marrow, lung biopsy).',
    `total_reads` BIGINT COMMENT 'Total number of raw sequencing reads generated for this sample in this run.',
    `total_yield_gb` DECIMAL(18,2) COMMENT 'Total sequencing data yield in gigabases generated for this sample.',
    `tumor_purity_percent` DECIMAL(18,2) COMMENT 'Estimated percentage of tumor cells in the sample, critical for somatic variant calling sensitivity in oncology.',
    `variant_caller_software` STRING COMMENT 'Software tool and version used for variant calling (e.g., GATK HaplotypeCaller v4.4, DeepVariant v1.5).',
    CONSTRAINT pk_sequencing_data PRIMARY KEY(`sequencing_data_id`)
) COMMENT 'Genomics sequencing data table.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`sequence_data` (
    `sequence_data_id` BIGINT COMMENT 'Primary key for sequence_data',
    `care_site_id` BIGINT COMMENT 'Identifier of the laboratory facility that performed the genomic sequencing.',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider who ordered the genomic sequencing test.',
    `genomic_order_id` BIGINT COMMENT 'Foreign key linking to genomics.genomic_order. Business justification: New FK linking sequence_data to the genomic_order that initiated the sequencing workflow.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient from whom the biological specimen was collected for genomic sequencing.',
    `specimen_id` BIGINT COMMENT 'Identifier of the biological specimen used for genomic sequencing (e.g., blood, tissue, saliva).',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the sequencing was ordered or specimen collected.',
    `accession_number` STRING COMMENT 'Unique laboratory accession number assigned to the sequencing specimen for tracking and identification purposes.',
    `bioinformatics_pipeline_version` STRING COMMENT 'Version identifier of the bioinformatics analysis pipeline used for alignment, variant calling, and annotation.',
    `clinical_indication` STRING COMMENT 'Clinical reason or diagnosis prompting the genomic sequencing order (e.g., suspected hereditary cancer, pharmacogenomic testing, rare disease workup).',
    `clinically_significant_variants` STRING COMMENT 'Number of variants classified as pathogenic or likely pathogenic per ACMG guidelines that have clinical significance for patient care.',
    `collection_date` DATE COMMENT 'Date when the biological specimen was collected from the patient for sequencing.',
    `consent_status` STRING COMMENT 'Status of patient consent for genomic testing, data storage, and potential research use of sequencing data.',
    `cpt_code` STRING COMMENT 'CPT billing code associated with the genomic sequencing test for reimbursement and revenue cycle purposes.',
    `data_file_format` STRING COMMENT 'Primary file format of the stored sequencing data output.',
    `data_file_size_gb` DECIMAL(18,2) COMMENT 'Total size of the sequencing data files in gigabytes, relevant for storage planning and data transfer.',
    `dna_concentration_ng_ul` DECIMAL(18,2) COMMENT 'Concentration of extracted DNA in nanograms per microliter, used to assess specimen adequacy for sequencing.',
    `duplicate_reads_percent` DECIMAL(18,2) COMMENT 'Percentage of reads identified as PCR or optical duplicates, which are excluded from variant calling to avoid bias.',
    `failure_reason` STRING COMMENT 'Description of the reason for sequencing failure or quality control failure, if applicable (e.g., insufficient DNA, low coverage, contamination).',
    `gc_content_percent` DECIMAL(18,2) COMMENT 'Percentage of guanine-cytosine bases in the sequenced data, used to assess potential sequencing bias.',
    `genetic_counselor_reviewed` BOOLEAN COMMENT 'Indicates whether a certified genetic counselor has reviewed the sequencing results prior to reporting to the patient.',
    `hipaa_minimum_necessary` BOOLEAN COMMENT 'Indicates whether access to this genomic data record complies with HIPAA minimum necessary standard for data sharing.',
    `icd10_indication_code` STRING COMMENT 'ICD-10 diagnosis code representing the clinical indication for the genomic sequencing order.',
    `interpretation_summary` STRING COMMENT 'High-level summary of the clinical interpretation of sequencing results, including overall findings and recommendations for the ordering provider.',
    `library_prep_method` STRING COMMENT 'Method used for sequencing library preparation (e.g., PCR-based, hybrid capture, amplicon-based), which affects coverage uniformity and bias.',
    `mapped_reads_percent` DECIMAL(18,2) COMMENT 'Percentage of total reads that successfully aligned to the reference genome, indicating data quality.',
    `mean_coverage_depth` DECIMAL(18,2) COMMENT 'Average number of times each nucleotide position in the target region was sequenced. Higher coverage improves variant calling confidence.',
    `notes` STRING COMMENT 'Free-text notes from laboratory staff or bioinformaticians regarding the sequencing run, specimen handling, or analysis observations.',
    `on_target_percent` DECIMAL(18,2) COMMENT 'Percentage of reads that map to the intended target regions for panel or exome sequencing, indicating capture efficiency.',
    `order_date` DATE COMMENT 'Date when the genomic sequencing test was ordered by the provider.',
    `overall_result_classification` STRING COMMENT 'High-level classification of the sequencing result indicating whether clinically actionable findings were identified.',
    `panel_name` STRING COMMENT 'Name of the targeted gene panel used for sequencing, if applicable (e.g., Oncology 500 Gene Panel, Hereditary Cancer Panel).',
    `platform` STRING COMMENT 'The sequencing instrument platform used to generate the data (e.g., Illumina NovaSeq, PacBio Sequel, Oxford Nanopore). [ENUM-REF-CANDIDATE: illumina_novaseq|illumina_hiseq|illumina_miseq|pacbio_sequel|oxford_nanopore|ion_torrent|bgi_dnbseq — promote to reference product]',
    `q30_percent` DECIMAL(18,2) COMMENT 'Percentage of bases with a Phred quality score of 30 or higher (99.9% base call accuracy), a key quality metric for sequencing data.',
    `quality_control_status` STRING COMMENT 'Outcome of quality control assessment for the sequencing run, determining whether results meet minimum quality thresholds for clinical reporting.',
    `read_length_bp` STRING COMMENT 'Length of individual sequencing reads in base pairs, which impacts alignment accuracy and variant detection sensitivity.',
    `reference_genome` STRING COMMENT 'Human reference genome assembly version used for alignment and variant calling (e.g., GRCh38 is the current standard).',
    `research_use_authorized` BOOLEAN COMMENT 'Indicates whether the patient has authorized secondary use of their genomic data for research purposes.',
    `result_reported_date` DATE COMMENT 'Date when the final sequencing results were reported and made available to the ordering provider.',
    `retention_expiry_date` DATE COMMENT 'Date after which the sequencing data may be archived or purged per organizational data retention policy and regulatory requirements.',
    `run_completion_timestamp` TIMESTAMP COMMENT 'Timestamp when the sequencing instrument run completed data generation.',
    `run_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the sequencing instrument run began processing the specimen.',
    `sample_type` STRING COMMENT 'Type of biological sample from which DNA/RNA was extracted for sequencing.',
    `sequencing_status` STRING COMMENT 'Current lifecycle status of the genomic sequencing workflow from order through completion or failure.',
    `sequencing_type` STRING COMMENT 'Classification of the genomic sequencing methodology used. WGS=Whole Genome Sequencing, WES=Whole Exome Sequencing, targeted_panel=Gene Panel, RNA_seq=RNA Sequencing.',
    `storage_location_uri` STRING COMMENT 'Uniform Resource Identifier pointing to the cloud or on-premises storage location of the raw and processed sequencing data files.',
    `total_reads` BIGINT COMMENT 'Total number of sequencing reads generated during the run for this specimen.',
    `total_variants_detected` STRING COMMENT 'Total number of genomic variants identified in the sequencing analysis, including SNVs, indels, and structural variants.',
    `tumor_normal_indicator` STRING COMMENT 'Indicates whether the sequencing was performed on tumor tissue, matched normal tissue, or germline DNA, relevant for oncology genomics.',
    `tumor_purity_percent` DECIMAL(18,2) COMMENT 'Estimated percentage of tumor cells in the sequenced specimen, critical for accurate somatic variant calling in oncology.',
    `turnaround_time_days` STRING COMMENT 'Number of calendar days from specimen receipt to final result reporting, used for operational performance monitoring.',
    CONSTRAINT pk_sequence_data PRIMARY KEY(`sequence_data_id`)
) COMMENT 'Table storing genomic sequencing data.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`sequence` (
    `sequence_id` BIGINT COMMENT 'Primary key for sequence',
    `care_site_id` BIGINT COMMENT 'Identifier of the laboratory facility that performed the genomic sequencing.',
    `clinician_id` BIGINT COMMENT 'Identifier of the clinician who ordered the genomic sequencing test.',
    `genomic_order_id` BIGINT COMMENT 'Identifier of the laboratory or genomic test order that initiated this sequencing run.',
    `instrument_id` BIGINT COMMENT 'Identifier of the specific sequencing instrument used, supporting maintenance tracking and batch quality investigations.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient from whom the biological specimen was collected for genomic sequencing.',
    `prior_sequence_id` BIGINT COMMENT 'Reference to the original sequence record when this is a repeat run, enabling lineage tracking.',
    `sequencing_run_id` BIGINT COMMENT 'Unique identifier for the sequencing run/flowcell, enabling batch-level quality tracking across multiple samples.',
    `specimen_id` BIGINT COMMENT 'Identifier of the biological specimen (blood, tissue, saliva) used for DNA/RNA extraction and sequencing.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the genomic test was ordered or specimen collected.',
    `accession_number` STRING COMMENT 'Unique laboratory-assigned accession number for tracking the sequencing sample through the laboratory workflow.',
    `clinical_indication` STRING COMMENT 'Clinical reason or diagnosis prompting the genomic sequencing order (e.g., suspected hereditary cancer, pharmacogenomic guidance).',
    `collection_date` DATE COMMENT 'Date the biological specimen was collected from the patient for genomic analysis.',
    `cpt_code` STRING COMMENT 'CPT procedure code representing the specific genomic test performed, used for billing and reimbursement.',
    `external_accession_number` STRING COMMENT 'Accession identifier assigned by an external reference laboratory or genomic testing vendor (e.g., Foundation Medicine, Tempus, Guardant).',
    `gene_count` STRING COMMENT 'Number of genes covered by the sequencing panel or assay.',
    `hipaa_retention_expiry_date` DATE COMMENT 'Date after which this genomic sequence record may be eligible for archival or deletion per HIPAA retention policies (minimum 6 years from creation).',
    `indication_icd_code` STRING COMMENT 'ICD-10-CM diagnosis code associated with the clinical indication for genomic testing.',
    `is_repeat_run` BOOLEAN COMMENT 'Indicates whether this sequencing run is a repeat of a prior failed or inconclusive run for the same specimen.',
    `mapped_reads_percent` DECIMAL(18,2) COMMENT 'Percentage of total reads that successfully mapped to the reference genome, indicating alignment quality.',
    `nucleic_acid_type` STRING COMMENT 'Type of nucleic acid extracted and sequenced (DNA, RNA, cell-free DNA, or circulating tumor DNA).',
    `panel_name` STRING COMMENT 'Name of the targeted gene panel used for sequencing when type is targeted_panel (e.g., FoundationOne CDx, Oncomine).',
    `platform` STRING COMMENT 'The next-generation sequencing (NGS) instrument platform used to generate the sequence reads.',
    `qc_failure_reason` STRING COMMENT 'Description of the reason for QC failure when the sequence did not meet minimum quality thresholds.',
    `qc_status` STRING COMMENT 'Outcome of quality control assessment for the sequencing run, determining whether results are reportable.',
    `quality_score_mean` DECIMAL(18,2) COMMENT 'Mean Phred quality score across all base calls, representing the average base-calling accuracy.',
    `read_depth_mean` DECIMAL(18,2) COMMENT 'Average sequencing read depth (coverage) across all targeted regions, indicating data quality and confidence level.',
    `read_depth_minimum` DECIMAL(18,2) COMMENT 'Minimum sequencing read depth observed across targeted regions, used to assess coverage uniformity.',
    `received_date` DATE COMMENT 'Date the specimen was received by the performing laboratory for processing.',
    `reference_genome` STRING COMMENT 'Human reference genome assembly version used for read alignment and variant calling (e.g., GRCh38).',
    `report_date` DATE COMMENT 'Date the final genomic sequencing report was issued and made available to the ordering clinician.',
    `run_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the sequencing instrument run completed for this sample.',
    `run_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the sequencing instrument run began for this sample.',
    `sequence_status` STRING COMMENT 'Current lifecycle status of the genomic sequence from order through completion or failure.',
    `sequence_type` STRING COMMENT 'Classification of the genomic sequencing methodology used to generate this sequence data.',
    `specimen_type` STRING COMMENT 'Type of biological specimen from which nucleic acid was extracted for sequencing.',
    `total_reads` BIGINT COMMENT 'Total number of sequencing reads generated for this sample run.',
    `tumor_purity_percent` DECIMAL(18,2) COMMENT 'Estimated percentage of tumor cells in the specimen for oncology sequencing, affecting variant allele frequency interpretation.',
    `turnaround_days` STRING COMMENT 'Number of calendar days from specimen receipt to final report issuance, measuring laboratory operational efficiency.',
    CONSTRAINT pk_sequence PRIMARY KEY(`sequence_id`)
) COMMENT 'genomics.sequence';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`assay` (
    `assay_id` BIGINT COMMENT 'Primary key for assay',
    `care_site_id` BIGINT COMMENT 'Identifier of the primary laboratory facility certified to perform this assay.',
    `clinician_id` BIGINT COMMENT 'Identifier of the physician medical director responsible for clinical oversight and sign-off of this assay.',
    `assay_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying this assay in laboratory information systems and order catalogs.',
    `assay_description` STRING COMMENT 'Detailed narrative description of the assay purpose, scope, and clinical utility for ordering providers and patients.',
    `assay_name` STRING COMMENT 'Human-readable name of the genomic assay as displayed in clinical ordering systems and reports.',
    `assay_status` STRING COMMENT 'Current lifecycle state of the assay indicating whether it is available for clinical ordering.',
    `assay_type` STRING COMMENT 'Classification of the assay by scope of genomic analysis performed.',
    `bioinformatics_pipeline_version` STRING COMMENT 'Version identifier of the bioinformatics analysis pipeline used for variant calling and annotation.',
    `cap_accreditation_required` BOOLEAN COMMENT 'Indicates whether performing this assay requires CAP laboratory accreditation.',
    `clia_complexity` STRING COMMENT 'CLIA test complexity classification determining laboratory certification requirements.',
    `clinical_indication` STRING COMMENT 'Primary clinical indication or disease area for which this assay is designed (e.g., hereditary cancer, pharmacogenomics screening, rare disease).',
    `consent_required` BOOLEAN COMMENT 'Indicates whether specific genetic testing informed consent must be obtained before ordering this assay.',
    `cpt_code` STRING COMMENT 'Primary CPT code used for billing and reimbursement of this genomic assay.',
    `created_at` TIMESTAMP COMMENT 'Timestamp when this assay record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the list price.',
    `effective_date` DATE COMMENT 'Date from which this assay version became available for clinical ordering.',
    `fda_clearance_status` STRING COMMENT 'FDA regulatory clearance or approval status. LDT indicates laboratory-developed test not requiring FDA clearance.',
    `gene_count` STRING COMMENT 'Total number of genes included in the assay panel. Null for whole exome or whole genome assays.',
    `hipaa_retention_years` STRING COMMENT 'Minimum number of years that assay results and supporting data must be retained per HIPAA and state regulations.',
    `insurance_prior_auth_required` BOOLEAN COMMENT 'Indicates whether most insurance payers require prior authorization before this assay can be ordered.',
    `interpretation_guideline` STRING COMMENT 'Clinical interpretation framework applied to variants detected by this assay (e.g., ACMG/AMP 2015 guidelines).',
    `is_research_use_only` BOOLEAN COMMENT 'Indicates whether this assay is designated for research use only (RUO) and not for clinical diagnostic purposes.',
    `limitations` STRING COMMENT 'Known analytical and clinical limitations of the assay that must be communicated in the test report.',
    `list_price` DECIMAL(18,2) COMMENT 'Standard list price for performing this assay before insurance adjustments or contractual discounts.',
    `loinc_code` STRING COMMENT 'LOINC code mapped to this assay for standardized laboratory result reporting and interoperability.',
    `methodology` STRING COMMENT 'Primary laboratory methodology or technology platform used to perform the assay (e.g., Next-Generation Sequencing, PCR, FISH, Microarray, Sanger sequencing).',
    `minimum_coverage_depth` STRING COMMENT 'Minimum sequencing read depth required across target regions to meet quality standards for clinical reporting.',
    `minimum_dna_input_ng` DECIMAL(18,2) COMMENT 'Minimum quantity of extracted DNA required to perform the assay, measured in nanograms.',
    `ordering_provider_specialty` STRING COMMENT 'Clinical specialty restriction for providers authorized to order this assay (e.g., medical genetics, oncology). Null if unrestricted.',
    `platform` STRING COMMENT 'Specific instrument or sequencing platform used to execute the assay (e.g., Illumina NovaSeq, Ion Torrent, PacBio).',
    `proficiency_testing_program` STRING COMMENT 'External proficiency testing program in which the laboratory participates for this assay (e.g., CAP Surveys, ACMG PT).',
    `quality_control_frequency` STRING COMMENT 'Frequency at which quality control samples must be run alongside patient specimens for this assay.',
    `reference_genome_build` STRING COMMENT 'Human reference genome assembly version used for sequence alignment and variant calling.',
    `reflex_testing_available` BOOLEAN COMMENT 'Indicates whether this assay supports automatic reflex testing to confirmatory or expanded panels based on initial findings.',
    `reportable_variant_classes` STRING COMMENT 'Comma-separated list of variant classes this assay is validated to detect and report (e.g., SNV, indel, CNV, fusion, MSI).',
    `retirement_date` DATE COMMENT 'Date on which this assay version was retired from active clinical use. Null if currently active.',
    `sensitivity_threshold` DECIMAL(18,2) COMMENT 'Validated analytical sensitivity (detection rate) of the assay expressed as a decimal fraction (e.g., 0.9950 for 99.50%).',
    `specificity_threshold` DECIMAL(18,2) COMMENT 'Validated analytical specificity (true negative rate) of the assay expressed as a decimal fraction.',
    `specimen_type` STRING COMMENT 'Primary specimen type required for this assay.',
    `target_region_size_kb` DECIMAL(18,2) COMMENT 'Total size of the genomic target region covered by the assay, measured in kilobases (kb).',
    `turnaround_time_days` STRING COMMENT 'Expected number of calendar days from specimen receipt to final report availability.',
    `updated_at` TIMESTAMP COMMENT 'Timestamp when this assay record was last modified.',
    `validation_date` DATE COMMENT 'Date on which the assay completed analytical and clinical validation and was approved for clinical use.',
    `version` STRING COMMENT 'Version number of the assay protocol, reflecting updates to gene panels, reagents, or analytical pipelines.',
    CONSTRAINT pk_assay PRIMARY KEY(`assay_id`)
) COMMENT 'genomics.assay';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`genomics_report` (
    `genomics_report_id` BIGINT COMMENT 'Primary key for genomics_report',
    `care_site_id` BIGINT COMMENT 'Identifier of the laboratory facility that performed the genomic analysis.',
    `genomic_order_id` BIGINT COMMENT 'Identifier of the original clinical order that initiated this genomic test.',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider who ordered the genomic test.',
    `genomics_interpreting_provider_clinician_id` BIGINT COMMENT 'Identifier of the clinical geneticist or molecular pathologist who interpreted and signed out the genomics report.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient for whom this genomics report was generated.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the genomic test was ordered or results were reviewed.',
    `accession_number` STRING COMMENT 'Externally-visible unique laboratory accession number assigned to this genomics report for tracking and reference across clinical systems.',
    `actionable_finding_flag` BOOLEAN COMMENT 'Indicates whether the report contains clinically actionable findings that may influence treatment decisions or clinical management.',
    `amendment_reason` STRING COMMENT 'Reason for report amendment or correction when the report version is greater than one.',
    `clinical_indication` STRING COMMENT 'Clinical reason or diagnosis prompting the genomic test order, typically an ICD-10 code description or free-text clinical question.',
    `clinical_trial_eligibility_flag` BOOLEAN COMMENT 'Indicates whether identified genomic alterations may qualify the patient for relevant clinical trials.',
    `confidentiality_level` STRING COMMENT 'Data classification level for access control and governance purposes within the Unity Catalog.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether informed consent for genomic testing and result disclosure was obtained from the patient.',
    `cpt_code` STRING COMMENT 'Primary CPT code associated with the genomic test for billing and reimbursement purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this genomics report record was first created in the data platform.',
    `external_lab_report_reference` STRING COMMENT 'Report identifier assigned by an external reference laboratory (e.g., Foundation Medicine, Tempus, Guardant Health) when testing is performed externally.',
    `fhir_resource_reference` STRING COMMENT 'HL7 FHIR DiagnosticReport resource identifier enabling interoperability with external health information exchanges.',
    `genes_tested_count` STRING COMMENT 'Total number of genes included in the genomic panel or analysis.',
    `genetic_counseling_recommended_flag` BOOLEAN COMMENT 'Indicates whether genetic counseling is recommended based on the genomic findings.',
    `genomics_report_status` STRING COMMENT 'Current lifecycle status of the genomics report indicating its clinical validity and completeness.',
    `hereditary_risk_flag` BOOLEAN COMMENT 'Indicates whether the report identifies germline variants associated with hereditary cancer or genetic disease risk requiring genetic counseling.',
    `hipaa_retention_years` STRING COMMENT 'Required retention period in years for this genomic report per HIPAA and state-specific medical record retention regulations.',
    `indication_icd_code` STRING COMMENT 'ICD-10 diagnosis code representing the clinical indication for the genomic test.',
    `interpretation_summary` STRING COMMENT 'Free-text narrative summary of the genomic findings and their clinical significance as authored by the interpreting geneticist.',
    `mean_coverage_depth` DECIMAL(18,2) COMMENT 'Average sequencing read depth across targeted regions, indicating the quality and reliability of the genomic data.',
    `methodology` STRING COMMENT 'Laboratory methodology or platform used to perform the genomic analysis. [ENUM-REF-CANDIDATE: next_gen_sequencing|pcr|fish|microarray|sanger|whole_genome|whole_exome|karyotype|methylation|rna_seq — promote to reference product]',
    `microsatellite_instability_status` STRING COMMENT 'Microsatellite instability classification indicating DNA mismatch repair deficiency, relevant for immunotherapy treatment decisions.',
    `overall_interpretation` STRING COMMENT 'Summary-level clinical interpretation of the genomic findings indicating whether clinically significant variants were identified.',
    `pathogenic_variant_count` STRING COMMENT 'Number of variants classified as pathogenic or likely pathogenic per ACMG criteria.',
    `pdf_document_url` STRING COMMENT 'Storage location or URL reference to the full PDF version of the genomics report for clinical review.',
    `percent_bases_above_threshold` DECIMAL(18,2) COMMENT 'Percentage of targeted bases achieving minimum acceptable coverage depth, a key quality metric for NGS assay performance.',
    `platform_name` STRING COMMENT 'Name of the sequencing instrument or platform used (e.g., Illumina NovaSeq, Ion Torrent, PacBio Sequel).',
    `prior_authorization_number` STRING COMMENT 'Insurance prior authorization reference number obtained before performing the genomic test.',
    `report_date` DATE COMMENT 'Date when the genomics report was finalized and made available for clinical review. This is the principal business event date.',
    `report_issued_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the genomics report was officially issued and released to the ordering provider.',
    `report_type` STRING COMMENT 'Classification of the genomic test type indicating the clinical purpose and methodology category.',
    `report_version` STRING COMMENT 'Version number of the report, incremented when amendments or corrections are issued.',
    `research_use_consent_flag` BOOLEAN COMMENT 'Indicates whether the patient consented to use of their genomic data for research purposes.',
    `specimen_collection_date` DATE COMMENT 'Date when the biological specimen was collected from the patient for genomic testing.',
    `specimen_received_date` DATE COMMENT 'Date when the performing laboratory received the specimen for processing.',
    `specimen_type` STRING COMMENT 'Type of biological specimen from which DNA/RNA was extracted for genomic analysis.',
    `test_code` STRING COMMENT 'Standardized code identifying the genomic test or panel, typically a LOINC code or laboratory-specific catalogue code.',
    `test_name` STRING COMMENT 'Human-readable name of the specific genomic test or panel performed (e.g., Comprehensive Genomic Profiling, BRCA1/2 Panel, Whole Exome Sequencing).',
    `therapy_recommendation` STRING COMMENT 'Summary of targeted therapy or treatment recommendations based on identified genomic alterations.',
    `tumor_cellularity_percent` DECIMAL(18,2) COMMENT 'Estimated percentage of tumor cells in the specimen, critical for interpreting variant allele frequencies in somatic testing.',
    `tumor_mutational_burden` DECIMAL(18,2) COMMENT 'Tumor mutational burden score expressed as mutations per megabase, relevant for immunotherapy eligibility assessment in oncology genomics.',
    `turnaround_days` STRING COMMENT 'Number of calendar days from specimen receipt to report issuance, measuring laboratory operational efficiency.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this genomics report record was last modified in the data platform.',
    `variant_count` STRING COMMENT 'Total number of reportable variants identified in this genomic analysis.',
    CONSTRAINT pk_genomics_report PRIMARY KEY(`genomics_report_id`)
) COMMENT 'genomics.report';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`phenotype_association` (
    `phenotype_association_id` BIGINT COMMENT 'Primary key for phenotype_association',
    `clinician_id` BIGINT COMMENT 'Reference to the clinical geneticist or molecular pathologist who reviewed and curated this association.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient for whom this phenotype-variant association was identified, if patient-specific.',
    `snomed_concept_id` BIGINT COMMENT 'SNOMED CT concept identifier for the phenotype or clinical finding in this association.',
    `variant_id` BIGINT COMMENT 'Reference to the specific genomic variant involved in this phenotype association.',
    `actionability_category` STRING COMMENT 'ClinGen actionability classification indicating whether clinical interventions exist for this variant-phenotype pair.',
    `ancestry_group` STRING COMMENT 'Population or ancestry group in which this phenotype association was characterized or is most prevalent.',
    `assertion_method` STRING COMMENT 'Method or guideline framework used to assert the clinical significance (e.g., ACMG 2015 criteria, ClinGen SOP).',
    `association_type` STRING COMMENT 'Classification of the relationship between the variant and the phenotype.',
    `clinical_significance` STRING COMMENT 'ACMG/AMP classification of the clinical significance of this variant-phenotype association.',
    `clinvar_accession` STRING COMMENT 'ClinVar submission or record accession number supporting this phenotype-variant association.',
    `condition_icd10_code` STRING COMMENT 'ICD-10 diagnosis code corresponding to the clinical condition or phenotype in this association.',
    `confidence_interval_lower` DECIMAL(18,2) COMMENT 'Lower bound of the 95% confidence interval for the odds ratio or effect size.',
    `confidence_interval_upper` DECIMAL(18,2) COMMENT 'Upper bound of the 95% confidence interval for the odds ratio or effect size.',
    `curation_source` STRING COMMENT 'Organization or consortium that curated this association (e.g., ClinGen, OMIM, institutional lab).',
    `disease_mechanism` STRING COMMENT 'Molecular mechanism by which the variant leads to the associated phenotype.',
    `effective_date` DATE COMMENT 'Date from which this phenotype-variant association classification is considered valid and current.',
    `evidence_level` STRING COMMENT 'Strength of evidence supporting the variant-phenotype association per ClinGen framework.',
    `evidence_source` STRING COMMENT 'Primary database or literature source providing evidence for this association (e.g., ClinVar, OMIM, GWAS Catalog, literature PMID).',
    `expiration_date` DATE COMMENT 'Date after which this association classification should be re-evaluated or is no longer considered current.',
    `external_accession_number` STRING COMMENT 'Accession or record identifier in the external source database (e.g., ClinVar variation ID, GWAS Catalog association ID).',
    `functional_impact_predictor` STRING COMMENT 'Name of the in-silico prediction tool used to generate the functional impact score.',
    `functional_impact_score` DECIMAL(18,2) COMMENT 'Computational prediction score (e.g., CADD, REVEL) indicating the functional impact of the variant on the gene product.',
    `gene_symbol` STRING COMMENT 'Official HGNC gene symbol associated with the variant in this phenotype relationship.',
    `hpo_code` STRING COMMENT 'Standardized HPO term code representing the phenotype in this association.',
    `inheritance_pattern` STRING COMMENT 'Mode of inheritance for the phenotype associated with this variant.',
    `is_incidental_finding` BOOLEAN COMMENT 'Indicates whether this phenotype association was discovered incidentally outside the primary indication for testing.',
    `is_reportable` BOOLEAN COMMENT 'Indicates whether this association meets criteria for inclusion in a clinical genomics report per ACMG secondary findings guidelines.',
    `notes` STRING COMMENT 'Free-text clinical notes or interpretation comments from the reviewing geneticist regarding this association.',
    `odds_ratio` DECIMAL(18,2) COMMENT 'Statistical odds ratio quantifying the strength of association between the variant and phenotype from case-control studies.',
    `omim_number` STRING COMMENT 'OMIM catalog number for the Mendelian condition or phenotype linked to this variant.',
    `onset_category` STRING COMMENT 'Typical age of onset category for the phenotype when associated with this variant. [ENUM-REF-CANDIDATE: prenatal|neonatal|infantile|childhood|juvenile|adult|variable — promote to reference product]',
    `p_value` DECIMAL(18,2) COMMENT 'Statistical significance p-value for the variant-phenotype association from genome-wide or targeted studies.',
    `penetrance` STRING COMMENT 'Proportion of individuals carrying the variant who express the associated phenotype.',
    `phenotype_code` BIGINT COMMENT 'Reference to the clinical phenotype (observable trait or disease) associated with the variant.',
    `population_allele_frequency` DECIMAL(18,2) COMMENT 'Frequency of the variant allele in the general population or relevant sub-population from gnomAD or similar databases.',
    `pubmed_accession` STRING COMMENT 'PubMed article identifier for the primary literature citation supporting this association.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this phenotype association record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this phenotype association record was last modified.',
    `review_date` DATE COMMENT 'Date when this phenotype-variant association was last reviewed or curated by a qualified professional.',
    `review_status` STRING COMMENT 'Current review and curation status of this phenotype-variant association record.',
    `sample_size` STRING COMMENT 'Number of individuals in the study or dataset from which this association was derived.',
    `severity` STRING COMMENT 'Typical severity of the phenotype manifestation when associated with this variant.',
    `source_study_type` STRING COMMENT 'Type of research study that established or supports this phenotype-variant association.',
    `therapeutic_implication` STRING COMMENT 'Description of therapeutic implications or targeted treatment options informed by this variant-phenotype association.',
    `zygosity` STRING COMMENT 'Zygosity context in which the variant-phenotype association is observed or expected to manifest.',
    CONSTRAINT pk_phenotype_association PRIMARY KEY(`phenotype_association_id`)
) COMMENT 'phenotype_association table linking variants to clinical phenotypes.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`variant_call` (
    `variant_call_id` BIGINT COMMENT 'Primary key for variant_call',
    `care_site_id` BIGINT COMMENT 'Identifier of the laboratory or genomics facility that performed the sequencing and variant calling.',
    `genomic_test_order_id` BIGINT COMMENT 'Identifier of the clinical genomic test order that initiated the sequencing workflow producing this variant call.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient from whom the genomic specimen was collected and sequenced.',
    `specimen_id` BIGINT COMMENT 'Identifier of the biological specimen (e.g., blood, tissue, saliva) from which DNA was extracted for sequencing.',
    `clinician_id` BIGINT COMMENT 'Identifier of the clinician who ordered the genomic test that produced this variant call.',
    `variant_interpreting_pathologist_clinician_id` BIGINT COMMENT 'Identifier of the molecular pathologist or clinical geneticist who performed the clinical interpretation and classification.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the genomic test was ordered or results were reviewed.',
    `acmg_criteria` STRING COMMENT 'Comma-separated list of ACMG/AMP evidence criteria codes applied during variant classification (e.g., PVS1, PM2, PP3).',
    `actionability_category` STRING COMMENT 'AMP/ASCO/CAP tier classification indicating the level of clinical actionability for somatic variants in oncology contexts.',
    `allele_frequency` DECIMAL(18,2) COMMENT 'Fraction of sequencing reads supporting the alternate allele relative to total reads at this position (0.0 to 1.0).',
    `alternate_allele` STRING COMMENT 'Observed variant nucleotide sequence differing from the reference allele at this genomic position.',
    `alternate_allele_depth` STRING COMMENT 'Number of sequencing reads supporting the alternate allele at this position.',
    `assay_type` STRING COMMENT 'Type of genomic assay performed: whole genome sequencing (WGS), whole exome sequencing (WES), targeted gene panel, or other methodology.',
    `associated_condition` STRING COMMENT 'Primary disease or clinical condition associated with this variant based on curated evidence (e.g., ClinVar condition, OMIM phenotype).',
    `call_timestamp` TIMESTAMP COMMENT 'Date and time when the variant calling pipeline completed analysis and generated this variant call record.',
    `chromosome` STRING COMMENT 'Chromosome on which the variant is located, using standard nomenclature (e.g., chr1 through chr22, chrX, chrY, chrM). [ENUM-REF-CANDIDATE: chr1|chr2|chr3|chr4|chr5|chr6|chr7|chr8|chr9|chr10|chr11|chr12|chr13|chr14|chr15|chr16|chr17|chr18|chr19|chr20|chr21|chr22|chrX|chrY|chrM — promote to reference product]',
    `clinical_significance` STRING COMMENT 'Clinical interpretation of the variants pathogenicity according to ACMG/AMP five-tier classification guidelines.',
    `clinvar_accession` STRING COMMENT 'NCBI ClinVar database variation identifier linking this variant to curated clinical significance assertions.',
    `cosmic_accession` STRING COMMENT 'Catalogue of Somatic Mutations in Cancer (COSMIC) identifier for somatic variants relevant to oncology.',
    `dbsnp_accession` STRING COMMENT 'NCBI dbSNP reference SNP cluster identifier for this variant, enabling cross-referencing with public variant databases.',
    `end_position` BIGINT COMMENT '1-based coordinate of the end position of the variant on the reference genome, relevant for structural variants and indels spanning multiple bases.',
    `filter_status` STRING COMMENT 'Result of quality filtering applied to the variant call indicating whether it passed all quality thresholds or was flagged for specific issues.',
    `functional_consequence` STRING COMMENT 'Predicted functional effect of the variant on the gene product (e.g., missense, nonsense, frameshift). [ENUM-REF-CANDIDATE: missense|nonsense|frameshift|splice_site|synonymous|intronic|UTR|intergenic|stop_gain|stop_loss|inframe_insertion|inframe_deletion — promote to reference product]',
    `gene_symbol` STRING COMMENT 'HUGO Gene Nomenclature Committee (HGNC) approved gene symbol in which the variant is located or nearest to.',
    `genomic_position` BIGINT COMMENT '1-based coordinate position of the variant on the reference genome assembly, indicating the start position of the variant.',
    `genotype` STRING COMMENT 'Genotype call for this variant position expressed in VCF format (e.g., 0/1 for heterozygous, 1/1 for homozygous alternate).',
    `hgvs_coding` STRING COMMENT 'Human Genome Variation Society (HGVS) nomenclature for the variant at the coding DNA level (c. notation).',
    `hgvs_protein` STRING COMMENT 'Human Genome Variation Society (HGVS) nomenclature for the predicted protein-level change (p. notation).',
    `inheritance_pattern` STRING COMMENT 'Mode of inheritance associated with the variants linked condition, relevant for genetic counseling and family cascade testing.',
    `interpretation_status` STRING COMMENT 'Current status of clinical interpretation workflow for this variant call, tracking progress from detection through final reporting.',
    `interpretation_timestamp` TIMESTAMP COMMENT 'Date and time when the clinical interpretation and classification of this variant was finalized by the molecular pathologist.',
    `is_incidental_finding` BOOLEAN COMMENT 'Indicates whether this variant is an incidental or secondary finding unrelated to the primary indication for testing, per ACMG SF list.',
    `is_reportable` BOOLEAN COMMENT 'Indicates whether this variant meets criteria for inclusion in the clinical genomic report delivered to the ordering provider.',
    `pipeline_version` STRING COMMENT 'Version identifier of the complete bioinformatics analysis pipeline used for alignment, variant calling, and annotation.',
    `population_allele_frequency` DECIMAL(18,2) COMMENT 'Frequency of this variant allele in the general population from gnomAD or similar population databases, used for rarity assessment.',
    `quality_score` DECIMAL(18,2) COMMENT 'Phred-scaled quality score representing the confidence that the variant call is genuine and not a sequencing artifact.',
    `read_depth` STRING COMMENT 'Total number of sequencing reads covering this genomic position, indicating the depth of coverage supporting the variant call.',
    `reference_allele` STRING COMMENT 'Nucleotide sequence at this position in the reference genome assembly (e.g., A, C, G, T, or multi-base for indels).',
    `reference_genome_build` STRING COMMENT 'Version of the human reference genome assembly used for alignment and variant calling (e.g., GRCh37/hg19, GRCh38/hg38).',
    `reported_date` DATE COMMENT 'Date when this variant was included in a finalized clinical genomic report released to the ordering provider.',
    `review_notes` STRING COMMENT 'Free-text clinical notes documenting the rationale for variant classification, evidence reviewed, and any caveats noted during interpretation.',
    `sequencing_platform` STRING COMMENT 'Technology platform used for DNA sequencing that generated the raw reads from which this variant was called.',
    `somatic_germline_status` STRING COMMENT 'Classification of whether the variant originated in somatic (tumor) tissue or is present in the germline (inherited), critical for treatment decisions.',
    `strand_bias_score` DECIMAL(18,2) COMMENT 'Statistical measure of strand bias indicating whether the variant is supported equally by forward and reverse reads, used as a quality metric.',
    `therapeutic_implication` STRING COMMENT 'Summary of treatment implications including drug sensitivity, resistance, or eligibility for targeted therapy based on this variant.',
    `transcript_accession` STRING COMMENT 'RefSeq or Ensembl transcript identifier used for annotation of the variants functional impact.',
    `variant_caller` STRING COMMENT 'Name and version of the bioinformatics variant calling software used to identify this variant (e.g., GATK HaplotypeCaller 4.3, DeepVariant 1.5).',
    `variant_type` STRING COMMENT 'Classification of the genomic variant by structural category: single nucleotide variant (SNV), insertion, deletion, indel, multi-nucleotide variant (MNV), or copy number variant (CNV).',
    `zygosity` STRING COMMENT 'Allelic state of the variant in the patients genome indicating whether one or both allele copies carry the variant.',
    CONSTRAINT pk_variant_call PRIMARY KEY(`variant_call_id`)
) COMMENT 'genomics.variant_call';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`genomic_test_order` (
    `genomic_test_order_id` BIGINT COMMENT 'Primary key for genomic_test_order',
    `clinician_id` BIGINT COMMENT 'Reference to the provider who placed the genomic test order, typically a geneticist, oncologist, or primary care physician.',
    `care_site_id` BIGINT COMMENT 'Reference to the laboratory facility that performs the genomic analysis (e.g., reference lab such as Foundation Medicine, Invitae, or in-house molecular pathology lab).',
    `genomic_ordering_facility_care_site_id` BIGINT COMMENT 'Reference to the healthcare facility where the genomic test was ordered.',
    `insurance_coverage_id` BIGINT COMMENT 'Reference to the patients insurance coverage record used for billing and prior authorization of the genomic test.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient for whom the genomic test is ordered.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which the genomic test was ordered.',
    `actionable_variants_count` STRING COMMENT 'Count of clinically actionable variants identified that may influence treatment decisions or clinical management.',
    `clinical_indication` STRING COMMENT 'Clinical reason or diagnosis prompting the genomic test order, such as suspected hereditary cancer syndrome, pharmacogenomic guidance, or tumor characterization.',
    `clinical_trial_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the genomic test results identified variants that make the patient potentially eligible for clinical trials or targeted therapy studies.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether informed consent for genetic testing was obtained from the patient prior to specimen collection, as required by GINA and state genetic privacy laws.',
    `cpt_code` STRING COMMENT 'CPT code associated with the genomic test for billing and reimbursement purposes (e.g., 81235 for EGFR gene analysis).',
    `created_datetime` TIMESTAMP COMMENT 'Timestamp when the genomic test order record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the estimated charge amount.',
    `estimated_charge_amount` DECIMAL(18,2) COMMENT 'Estimated charge amount for the genomic test based on the charge description master (CDM), used for patient financial counseling and revenue forecasting.',
    `family_history_relevant_flag` BOOLEAN COMMENT 'Indicates whether the patient has a relevant family history that contributed to the clinical decision to order genomic testing.',
    `genes_tested_count` STRING COMMENT 'Total number of genes included in the genomic test panel, indicating the breadth of analysis performed.',
    `genetic_counseling_flag` BOOLEAN COMMENT 'Indicates whether pre-test or post-test genetic counseling was provided to the patient in conjunction with this genomic test order.',
    `hipaa_minimum_necessary_flag` BOOLEAN COMMENT 'Indicates whether the genomic test order and result disclosure comply with HIPAA minimum necessary standard for genetic information sharing.',
    `icd10_code` STRING COMMENT 'ICD-10 diagnosis code supporting medical necessity for the genomic test order.',
    `microsatellite_instability_status` STRING COMMENT 'Microsatellite instability status determined by genomic analysis, used for immunotherapy treatment decisions and Lynch syndrome screening.',
    `notes` STRING COMMENT 'Free-text clinical notes or special instructions associated with the genomic test order, such as relevant clinical history or specimen handling requirements.',
    `order_datetime` TIMESTAMP COMMENT 'Date and time when the genomic test order was placed by the ordering provider via CPOE or manual entry.',
    `order_number` STRING COMMENT 'Externally-visible business identifier for the genomic test order, used for tracking and communication between ordering provider, laboratory, and patient.',
    `order_status` STRING COMMENT 'Current lifecycle status of the genomic test order from placement through result delivery.',
    `ordering_department` STRING COMMENT 'Clinical department or service line from which the genomic test was ordered (e.g., Medical Oncology, Genetics, Pulmonology).',
    `overall_interpretation` STRING COMMENT 'High-level clinical interpretation summary of the genomic test results indicating whether actionable findings were identified.',
    `pathogenicity_classification` STRING COMMENT 'Highest-level variant pathogenicity classification found in the test results per ACMG/AMP five-tier system.',
    `prior_authorization_number` STRING COMMENT 'Authorization reference number issued by the payer approving coverage for the genomic test.',
    `prior_authorization_status` STRING COMMENT 'Status of insurance prior authorization for the genomic test, critical for reimbursement of high-cost molecular diagnostics.',
    `priority` STRING COMMENT 'Clinical urgency level of the genomic test order, influencing turnaround time expectations and laboratory processing queue.',
    `reason_for_cancellation` STRING COMMENT 'Documented reason if the genomic test order was cancelled, such as patient refusal, specimen inadequacy, duplicate order, or insurance denial.',
    `report_delivery_method` STRING COMMENT 'Method by which the genomic test report is delivered to the ordering provider (e.g., HL7 interface to EHR, laboratory portal, or fax).',
    `result_datetime` TIMESTAMP COMMENT 'Date and time when the genomic test results were finalized and made available to the ordering provider.',
    `result_report_url` STRING COMMENT 'Secure URL or document reference to the full genomic test report in the laboratory portal or document management system.',
    `result_status` STRING COMMENT 'Status of the genomic test result indicating whether findings are preliminary, final, or have been amended after initial release.',
    `specimen_adequacy` STRING COMMENT 'Assessment of whether the collected specimen meets quality and quantity requirements for successful genomic analysis.',
    `specimen_collected_datetime` TIMESTAMP COMMENT 'Date and time when the biological specimen was collected from the patient for genomic analysis.',
    `specimen_received_datetime` TIMESTAMP COMMENT 'Date and time when the performing laboratory received the specimen for processing.',
    `specimen_type` STRING COMMENT 'Type of biological specimen required or collected for the genomic test (e.g., peripheral blood for germline, FFPE tissue for somatic).',
    `test_code` STRING COMMENT 'Standardized code identifying the genomic test, typically a LOINC code or laboratory-specific catalog code used for ordering and billing.',
    `test_name` STRING COMMENT 'Human-readable name of the specific genomic test panel or assay ordered (e.g., FoundationOne CDx, Oncotype DX, BRCA1/2 Panel).',
    `test_type` STRING COMMENT 'Classification of the genomic test methodology ordered, determining the scope and depth of sequencing analysis.',
    `treatment_impact_flag` BOOLEAN COMMENT 'Indicates whether the genomic test results directly influenced or changed the patients treatment plan, supporting precision medicine outcomes tracking.',
    `tumor_mutational_burden` DECIMAL(18,2) COMMENT 'Tumor mutational burden score measured in mutations per megabase (mut/Mb), relevant for immunotherapy eligibility assessment in oncology genomics.',
    `turnaround_days_actual` STRING COMMENT 'Actual number of calendar days from specimen receipt to result finalization, used for laboratory performance monitoring and SLA compliance.',
    `turnaround_days_expected` STRING COMMENT 'Expected number of calendar days from specimen receipt to result delivery, based on the performing laboratorys stated turnaround time for the test type.',
    `updated_datetime` TIMESTAMP COMMENT 'Timestamp when the genomic test order record was last modified, supporting audit trail and data lineage requirements.',
    `variants_detected_count` STRING COMMENT 'Total number of reportable genetic variants identified in the test results.',
    CONSTRAINT pk_genomic_test_order PRIMARY KEY(`genomic_test_order_id`)
) COMMENT 'Table for genomic test orders and results.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` (
    `patient_genomic_study_id` BIGINT COMMENT 'Primary key for patient_genomic_study',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider who ordered the genomic study for the patient.',
    `genomic_order_id` BIGINT COMMENT 'Foreign key linking to genomics.genomic_order. Business justification: New FK linking patient_genomic_study to the genomic_order. Studies are initiated by orders.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient enrolled in or linked to the genomic study.',
    `research_document_id` BIGINT COMMENT 'Identifier or reference to the full genomic study report document stored in the document management or EHR system.',
    `research_study_id` BIGINT COMMENT 'Identifier of the genomic study to which the patient is linked.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the genomic study was ordered or initiated for this patient.',
    `accession_number` STRING COMMENT 'Laboratory-assigned accession number uniquely identifying the genomic specimen and test order within the performing laboratory system.',
    `actionable_finding_flag` BOOLEAN COMMENT 'Indicates whether the genomic study identified clinically actionable findings that may influence treatment decisions or care pathways.',
    `authorization_status` STRING COMMENT 'Status of the insurance prior authorization for the genomic study.',
    `cancelled_reason` STRING COMMENT 'Reason for cancellation if the genomic study was cancelled, such as patient withdrawal, specimen inadequacy, or insurance denial.',
    `care_pathway_description` STRING COMMENT 'Description of the precision medicine care pathway or treatment protocol activated based on genomic study findings.',
    `care_pathway_linked_flag` BOOLEAN COMMENT 'Indicates whether the genomic study results have been linked to a precision medicine care pathway or treatment protocol.',
    `clinical_trial_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the genomic study results suggest potential eligibility for clinical trials based on identified molecular targets.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether informed consent for genomic testing and data use was obtained from the patient prior to specimen collection.',
    `consent_scope` STRING COMMENT 'Scope of the patient consent indicating whether genomic data may be used for clinical purposes only, research, or both.',
    `cpt_code` STRING COMMENT 'CPT billing code associated with the genomic study procedure for claims and reimbursement purposes.',
    `family_history_relevant_flag` BOOLEAN COMMENT 'Indicates whether the patient has a relevant family history that contributed to the decision to order the genomic study.',
    `genes_tested_count` STRING COMMENT 'Number of genes included in the genomic test panel that were analyzed for the patient.',
    `genetic_counseling_completed_flag` BOOLEAN COMMENT 'Indicates whether the patient completed a genetic counseling session in relation to this genomic study.',
    `genetic_counseling_offered_flag` BOOLEAN COMMENT 'Indicates whether genetic counseling was offered to the patient before or after the genomic study.',
    `indication` STRING COMMENT 'Clinical reason or diagnosis prompting the genomic study, typically an ICD-10 code description or free-text clinical rationale.',
    `indication_icd_code` STRING COMMENT 'ICD-10-CM diagnosis code representing the clinical indication for the genomic study.',
    `insurance_authorization_number` STRING COMMENT 'Prior authorization number obtained from the patients insurance payer for coverage of the genomic study.',
    `microsatellite_instability_status` STRING COMMENT 'Microsatellite instability status determined by the genomic study, relevant for immunotherapy treatment decisions.',
    `notes` STRING COMMENT 'Free-text clinical notes or comments related to the patients genomic study, including provider observations or special circumstances.',
    `order_date` DATE COMMENT 'Date on which the genomic study was ordered for the patient.',
    `overall_interpretation` STRING COMMENT 'Overall clinical interpretation of the genomic study results indicating whether actionable findings were identified.',
    `pathogenic_variant_count` STRING COMMENT 'Number of pathogenic or likely pathogenic variants identified in the genomic study results.',
    `patient_genomic_study_status` STRING COMMENT 'Current lifecycle status of the patients genomic study from order through completion or cancellation.',
    `performing_lab_clia_number` STRING COMMENT 'CLIA certification number of the laboratory performing the genomic study, required for regulatory compliance.',
    `performing_lab_name` STRING COMMENT 'Name of the laboratory that performed the genomic analysis, which may be internal or an external reference laboratory.',
    `platform_technology` STRING COMMENT 'Sequencing technology or platform used for the genomic analysis, such as next-generation sequencing (NGS), microarray, or PCR-based methods.',
    `priority` STRING COMMENT 'Priority level assigned to the genomic study order indicating clinical urgency.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this patient genomic study record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this patient genomic study record was last modified.',
    `research_use_authorized_flag` BOOLEAN COMMENT 'Indicates whether the patient has authorized use of their genomic data for research purposes beyond clinical care.',
    `result_disclosed_to_patient_flag` BOOLEAN COMMENT 'Indicates whether the genomic study results have been formally disclosed and communicated to the patient.',
    `result_disclosure_date` DATE COMMENT 'Date on which the genomic study results were disclosed to the patient.',
    `result_received_date` DATE COMMENT 'Date on which the genomic study results were received from the performing laboratory.',
    `result_summary` STRING COMMENT 'High-level summary of the genomic study findings, including overall pathogenicity classification and key findings narrative.',
    `secondary_findings_reported_flag` BOOLEAN COMMENT 'Indicates whether ACMG-recommended secondary (incidental) findings were reported to the patient as part of the genomic study.',
    `specimen_collection_date` DATE COMMENT 'Date on which the biological specimen was collected from the patient for genomic analysis.',
    `specimen_source_site` STRING COMMENT 'Anatomical body site from which the specimen was collected, particularly relevant for tumor profiling studies.',
    `specimen_type` STRING COMMENT 'Type of biological specimen collected from the patient for genomic testing.',
    `study_type` STRING COMMENT 'Classification of the genomic study methodology performed on the patient specimen.',
    `test_panel_code` STRING COMMENT 'Standardized code identifying the genomic test panel, often mapped to CPT or proprietary laboratory codes.',
    `test_panel_name` STRING COMMENT 'Name of the specific genomic test panel or assay performed, such as a hereditary cancer panel or comprehensive genomic profiling panel.',
    `tumor_mutational_burden` DECIMAL(18,2) COMMENT 'Tumor mutational burden score expressed as mutations per megabase, relevant for immunotherapy eligibility assessment in oncology genomic studies.',
    `turnaround_days` STRING COMMENT 'Number of calendar days from specimen collection to result receipt, measuring laboratory turnaround performance.',
    `vous_count` STRING COMMENT 'Number of variants of uncertain significance identified in the genomic study results.',
    CONSTRAINT pk_patient_genomic_study PRIMARY KEY(`patient_genomic_study_id`)
) COMMENT 'Table linking patients to genomic studies.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`test_order` (
    `test_order_id` BIGINT COMMENT 'Primary key for test_order',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider (physician, genetic counselor, or other clinician) who placed the genomic test order.',
    `diagnosis_id` BIGINT COMMENT 'Identifier linking to the primary diagnosis record that prompted the genomic test order.',
    `genomic_consent_id` BIGINT COMMENT 'Identifier linking to the specific consent record documenting the patients authorization for genomic testing.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient for whom the genomic test is ordered.',
    `care_site_id` BIGINT COMMENT 'Identifier of the laboratory facility responsible for performing the genomic test (e.g., reference lab, in-house molecular lab).',
    `test_facility_care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility from which the genomic test order originated.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the genomic test was ordered.',
    `actionable_finding` BOOLEAN COMMENT 'Indicates whether the genomic test results contain clinically actionable findings that may influence treatment decisions or care pathways.',
    `authorization_status` STRING COMMENT 'Status of the insurance prior authorization request for the genomic test order.',
    `cancellation_reason` STRING COMMENT 'Reason for cancellation if the genomic test order was cancelled (e.g., patient refusal, specimen inadequate, duplicate order, insurance denial).',
    `cancelled_datetime` TIMESTAMP COMMENT 'Date and time when the genomic test order was cancelled, if applicable.',
    `clinical_indication` STRING COMMENT 'Clinical reason or diagnosis prompting the genomic test order, describing the patients condition or suspected genetic disorder.',
    `clinical_significance` STRING COMMENT 'Overall clinical significance classification of the genomic test findings per ACMG/AMP guidelines, summarizing the highest-impact variant finding.',
    `coverage_depth_requested` STRING COMMENT 'Minimum sequencing coverage depth (e.g., 30x, 100x) requested for the genomic test to ensure analytical validity.',
    `cpt_code` STRING COMMENT 'CPT code associated with the genomic test for billing and reimbursement purposes.',
    `created_datetime` TIMESTAMP COMMENT 'Timestamp when the genomic test order record was first created in the system.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated cost of the genomic test in USD, used for patient financial counseling and revenue cycle planning.',
    `expected_turnaround_days` STRING COMMENT 'Expected number of calendar days from specimen receipt to result availability, based on the test type and performing laboratory SLA.',
    `external_lab_order_reference` STRING COMMENT 'Order identifier assigned by the external reference laboratory, used for cross-system reconciliation and result matching.',
    `family_history_relevant` BOOLEAN COMMENT 'Indicates whether the patient has a relevant family history of genetic conditions that supports the clinical indication for testing.',
    `genetic_counseling_completed` BOOLEAN COMMENT 'Indicates whether pre-test genetic counseling was completed prior to or concurrent with the test order, as recommended by clinical guidelines.',
    `incidental_findings_preference` STRING COMMENT 'Patients stated preference regarding the reporting of secondary or incidental genomic findings unrelated to the primary indication.',
    `indication_icd_code` STRING COMMENT 'ICD-10 diagnosis code associated with the clinical indication for the genomic test order.',
    `informed_consent_obtained` BOOLEAN COMMENT 'Indicates whether informed consent for genomic testing was obtained from the patient, including understanding of potential findings and implications.',
    `insurance_authorization_number` STRING COMMENT 'Prior authorization or pre-certification number obtained from the patients insurance payer for the genomic test.',
    `loinc_code` STRING COMMENT 'LOINC code identifying the genomic test observation for interoperability and standardized reporting.',
    `notes` STRING COMMENT 'Free-text clinical notes or special instructions provided by the ordering provider to accompany the genomic test order.',
    `order_datetime` TIMESTAMP COMMENT 'Date and time when the genomic test order was placed by the ordering provider. This is the principal business event timestamp.',
    `order_number` STRING COMMENT 'Externally-visible business identifier for the genomic test order, used for tracking and communication between ordering providers, laboratories, and patients.',
    `order_source` STRING COMMENT 'Channel or system through which the genomic test order was initiated (e.g., CPOE, paper requisition, external referral, patient portal).',
    `order_status` STRING COMMENT 'Current lifecycle status of the genomic test order reflecting its progression through the ordering workflow.',
    `ordering_department` STRING COMMENT 'Name or code of the clinical department from which the genomic test order originated (e.g., Oncology, Cardiology, Prenatal).',
    `panel_name` STRING COMMENT 'Name of the gene panel if the test is a targeted panel test (e.g., BRCA1/BRCA2 Panel, Cardio Panel). Null for non-panel tests.',
    `patient_responsibility_amount` DECIMAL(18,2) COMMENT 'Estimated out-of-pocket amount the patient is responsible for after insurance coverage determination.',
    `priority` STRING COMMENT 'Urgency level of the genomic test order, influencing turnaround time expectations and laboratory processing queue.',
    `referral_to_genetics` BOOLEAN COMMENT 'Indicates whether a referral to a genetics specialist or genetic counselor was generated based on test results.',
    `report_delivery_method` STRING COMMENT 'Method by which the genomic test report is delivered to the ordering provider.',
    `research_use_authorized` BOOLEAN COMMENT 'Indicates whether the patient has authorized use of their genomic data for research purposes beyond clinical care.',
    `result_available_datetime` TIMESTAMP COMMENT 'Date and time when the genomic test results became available for clinical review.',
    `result_status` STRING COMMENT 'Status of the genomic test result, indicating whether results are pending, preliminary, finalized, or amended.',
    `sequencing_platform` STRING COMMENT 'Technology platform used or requested for genomic sequencing (e.g., Illumina NovaSeq, PacBio, Oxford Nanopore).',
    `specimen_accession_number` STRING COMMENT 'Unique accession number assigned by the laboratory to the specimen upon receipt, used for internal tracking.',
    `specimen_collected_datetime` TIMESTAMP COMMENT 'Date and time when the biological specimen was collected from the patient for genomic testing.',
    `specimen_received_datetime` TIMESTAMP COMMENT 'Date and time when the performing laboratory received the specimen for processing.',
    `specimen_type` STRING COMMENT 'Type of biological specimen required or collected for the genomic test.',
    `test_code` STRING COMMENT 'Standardized code identifying the specific genomic test, typically mapped to CPT or proprietary lab catalog codes.',
    `test_name` STRING COMMENT 'Human-readable name of the specific genomic test or panel being ordered (e.g., Hereditary Cancer Panel, Comprehensive Genomic Profiling).',
    `test_type` STRING COMMENT 'Classification of the genomic test being ordered, indicating the scope and methodology of sequencing or analysis.',
    `updated_datetime` TIMESTAMP COMMENT 'Timestamp when the genomic test order record was last modified.',
    CONSTRAINT pk_test_order PRIMARY KEY(`test_order_id`)
) COMMENT 'Table storing genomic test orders.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`genomics_test_result` (
    `genomics_test_result_id` BIGINT COMMENT 'Primary key for genomics_test_result',
    `care_site_id` BIGINT COMMENT 'The laboratory facility that performed the genomic analysis and generated the result.',
    `genomic_order_id` BIGINT COMMENT 'Foreign key linking to genomics.genomic_order. Business justification: New FK linking genomics_test_result to the genomic_order that initiated the test.',
    `clinician_id` BIGINT COMMENT 'The provider who ordered the genomic test.',
    `genomics_interpreting_geneticist_clinician_id` BIGINT COMMENT 'The clinical geneticist or molecular pathologist who interpreted and signed out the genomic test result.',
    `mpi_record_id` BIGINT COMMENT 'The patient for whom the genomic test was performed.',
    `research_document_id` BIGINT COMMENT 'Reference identifier to the full genomic test report document stored in the document management system.',
    `visit_id` BIGINT COMMENT 'The clinical encounter during which the genomic test was ordered or resulted.',
    `accession_number` STRING COMMENT 'Unique laboratory-assigned tracking number for the specimen and test order.',
    `actionable_finding_flag` BOOLEAN COMMENT 'Indicates whether the result contains clinically actionable findings that may alter patient management or treatment.',
    `clinical_significance` STRING COMMENT 'ACMG/AMP five-tier classification of the most significant variant identified in the test result.',
    `consent_for_secondary_findings` BOOLEAN COMMENT 'Indicates whether the patient consented to receive secondary/incidental genomic findings.',
    `coverage_depth` DECIMAL(18,2) COMMENT 'Average sequencing read depth across the targeted regions, indicating analytical sensitivity of the test.',
    `cpt_code` STRING COMMENT 'CPT code used for billing the genomic test procedure.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this genomic test result record was first created in the system.',
    `external_lab_reference_number` STRING COMMENT 'Reference number assigned by an external or send-out laboratory if the test was performed outside the health system.',
    `family_history_relevant_flag` BOOLEAN COMMENT 'Indicates whether family history was considered relevant to the interpretation of genomic test results.',
    `gene_panel_name` STRING COMMENT 'Name of the gene panel tested if a targeted panel was used (e.g., Hereditary Cancer Panel, Cardiac Panel).',
    `genes_tested_count` STRING COMMENT 'Total number of genes analyzed in the genomic test panel.',
    `genetic_counseling_recommended` BOOLEAN COMMENT 'Indicates whether genetic counseling is recommended based on the test findings.',
    `hereditary_risk_category` STRING COMMENT 'Categorization of hereditary disease risk based on genomic findings for germline tests.',
    `hipaa_retention_expiry_date` DATE COMMENT 'Date after which the genomic test result record may be eligible for archival or destruction per HIPAA and state retention requirements.',
    `icd10_indication_code` STRING COMMENT 'ICD-10-CM diagnosis code representing the clinical indication for the genomic test.',
    `incidental_finding_flag` BOOLEAN COMMENT 'Indicates whether secondary or incidental findings unrelated to the primary indication were identified per ACMG guidelines.',
    `insurance_prior_auth_number` STRING COMMENT 'Prior authorization number obtained from the payer for coverage of the genomic test.',
    `microsatellite_instability_status` STRING COMMENT 'Microsatellite instability status determined by genomic analysis, relevant for immunotherapy treatment decisions.',
    `order_date` DATE COMMENT 'Date the genomic test was ordered by the provider.',
    `overall_interpretation` STRING COMMENT 'High-level clinical interpretation summarizing the genomic test findings (e.g., pathogenic variant detected, no clinically significant findings).',
    `pathogenic_variants_count` STRING COMMENT 'Number of variants classified as pathogenic or likely pathogenic in the result.',
    `percent_bases_above_threshold` DECIMAL(18,2) COMMENT 'Percentage of targeted bases that achieved the minimum required coverage depth for clinical reporting.',
    `primary_condition_indication` STRING COMMENT 'The primary clinical condition or indication for which the genomic test was ordered (e.g., suspected hereditary breast cancer, cardiomyopathy evaluation).',
    `quality_score` DECIMAL(18,2) COMMENT 'Overall quality metric for the sequencing run (e.g., average Phred quality score or equivalent composite quality indicator).',
    `reanalysis_recommended_flag` BOOLEAN COMMENT 'Indicates whether periodic reanalysis of the genomic data is recommended as new evidence emerges.',
    `reference_genome_build` STRING COMMENT 'Human reference genome assembly version used for variant calling and annotation.',
    `reported_timestamp` TIMESTAMP COMMENT 'Timestamp when the genomic test result was officially reported to the ordering provider or EHR system.',
    `research_consent_flag` BOOLEAN COMMENT 'Indicates whether the patient consented to use of their genomic data for research purposes.',
    `result_date` DATE COMMENT 'Date the genomic test result was finalized and made available.',
    `result_status` STRING COMMENT 'Current status of the genomic test result in its lifecycle workflow.',
    `result_summary` STRING COMMENT 'Free-text clinical narrative summarizing the genomic test findings, clinical context, and recommendations.',
    `specimen_collected_date` DATE COMMENT 'Date the biological specimen was collected from the patient.',
    `specimen_type` STRING COMMENT 'Type of biological specimen collected for genomic testing.',
    `test_code` STRING COMMENT 'Standard code identifying the specific genomic test panel or assay performed (e.g., LOINC code for the test).',
    `test_methodology` STRING COMMENT 'The laboratory methodology or technology platform used to perform the genomic analysis.',
    `test_name` STRING COMMENT 'Human-readable name of the genomic test or panel performed (e.g., Whole Exome Sequencing, BRCA1/2 Panel, Oncology Comprehensive Panel).',
    `test_type` STRING COMMENT 'Classification of the genomic test by clinical purpose.',
    `therapy_implication_summary` STRING COMMENT 'Summary of therapeutic implications based on genomic findings, including potential targeted therapies or clinical trial eligibility.',
    `tumor_mutational_burden` DECIMAL(18,2) COMMENT 'Tumor mutational burden measured in mutations per megabase, relevant for immunotherapy eligibility assessment in oncology genomics.',
    `tumor_normal_indicator` STRING COMMENT 'Indicates whether the analysis was performed on tumor tissue only, paired tumor-normal, or germline specimen for somatic testing.',
    `turnaround_days` STRING COMMENT 'Number of calendar days from specimen receipt at the lab to result finalization.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this genomic test result record was last modified.',
    `variants_detected_count` STRING COMMENT 'Total number of reportable variants detected in the genomic test result.',
    CONSTRAINT pk_genomics_test_result PRIMARY KEY(`genomics_test_result_id`)
) COMMENT 'Table storing genomic test results.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`patient_profile` (
    `patient_profile_id` BIGINT COMMENT 'Primary key for patient_profile',
    `consent_record_id` BIGINT COMMENT 'Reference to the informed consent record authorizing genomic testing and data use for this patient.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient whose genomic profile this record represents.',
    `clinician_id` BIGINT COMMENT 'Reference to the provider who ordered the genomic test that generated this profile.',
    `patient_interpreting_provider_clinician_id` BIGINT COMMENT 'Reference to the clinical geneticist or molecular pathologist who interpreted the genomic results.',
    `test_order_id` BIGINT COMMENT 'Reference to the clinical order that initiated the genomic testing for this profile.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which the genomic test was ordered or results were discussed.',
    `actionability_category` STRING COMMENT 'Classification of how actionable the genomic findings are for clinical decision-making and care pathway modification.',
    `ancestry_population` STRING COMMENT 'Self-reported or genomically-inferred ancestry population group used for variant frequency interpretation and risk calibration.',
    `benign_variant_count` STRING COMMENT 'Number of variants classified as benign or likely benign identified in this genomic profile.',
    `clinical_significance_summary` STRING COMMENT 'Narrative summary of the clinical significance of genomic findings, including implications for diagnosis, prognosis, and treatment.',
    `clinical_trial_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the genomic findings may qualify the patient for enrollment in precision medicine clinical trials.',
    `cpt_code` STRING COMMENT 'CPT billing code for the genomic test procedure performed, used for claims submission and reimbursement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this patient genomic profile record was first created in the system.',
    `data_sharing_consent_level` STRING COMMENT 'Level of consent granted by the patient for sharing genomic data with external databases, registries, or research networks.',
    `family_history_relevant_flag` BOOLEAN COMMENT 'Indicates whether the patients family history was considered relevant to the genomic testing indication and interpretation.',
    `genes_tested_count` STRING COMMENT 'Total number of genes included in the genomic analysis panel or sequencing scope.',
    `genetic_counseling_date` DATE COMMENT 'Date when genetic counseling was provided to the patient regarding their genomic profile results.',
    `genetic_counseling_recommended_flag` BOOLEAN COMMENT 'Indicates whether genetic counseling is recommended based on the genomic profile findings, particularly for hereditary conditions.',
    `hereditary_risk_flag` BOOLEAN COMMENT 'Indicates whether the genomic profile reveals hereditary risk factors that may affect family members and warrant genetic counseling.',
    `hipaa_minimum_necessary_flag` BOOLEAN COMMENT 'Indicates whether access to this genomic profile is restricted to minimum necessary information per HIPAA requirements.',
    `icd10_indication_code` STRING COMMENT 'ICD-10-CM diagnosis code representing the clinical indication for genomic testing.',
    `insurance_authorization_number` STRING COMMENT 'Prior authorization number from the insurance payer approving coverage for the genomic test.',
    `microsatellite_instability_status` STRING COMMENT 'Microsatellite instability status determined from genomic analysis, relevant for immunotherapy treatment decisions and Lynch syndrome screening.',
    `mrn` STRING COMMENT 'Medical record number linking this genomic profile to the patients clinical record in the EHR system.',
    `overall_interpretation` STRING COMMENT 'Summary clinical interpretation of the genomic profile results indicating whether actionable findings were identified.',
    `panel_name` STRING COMMENT 'Name of the specific gene panel used for targeted genomic testing (e.g., hereditary cancer panel, cardiac panel, pharmacogenomics panel).',
    `pathogenic_variant_count` STRING COMMENT 'Number of variants classified as pathogenic or likely pathogenic identified in this genomic profile per ACMG/AMP guidelines.',
    `patient_profile_status` STRING COMMENT 'Current lifecycle status of the patient genomic profile from initial creation through completion and any subsequent amendments.',
    `primary_condition_indication` STRING COMMENT 'Primary clinical condition or indication for which the genomic testing was ordered (e.g., hereditary breast cancer, familial hypercholesterolemia).',
    `profile_type` STRING COMMENT 'Classification of the genomic profile indicating the type of genomic analysis performed (germline for inherited variants, somatic for tumor-specific, pharmacogenomic for drug response, etc.).',
    `quality_score` DECIMAL(18,2) COMMENT 'Overall quality score for the genomic profile based on sequencing metrics, coverage uniformity, and analytical validation criteria.',
    `reference_genome_build` STRING COMMENT 'Human reference genome assembly version used for variant calling and annotation in this genomic profile.',
    `report_amended_date` DATE COMMENT 'Date when the genomic profile report was last amended due to variant reclassification or additional findings.',
    `report_date` DATE COMMENT 'Date when the final genomic profile report was issued by the testing laboratory.',
    `research_use_authorized_flag` BOOLEAN COMMENT 'Indicates whether the patient has authorized use of their genomic data for research purposes beyond clinical care.',
    `retention_expiry_date` DATE COMMENT 'Date after which this genomic profile record is eligible for archival or deletion per organizational data retention policy and regulatory requirements.',
    `secondary_findings_reported_flag` BOOLEAN COMMENT 'Indicates whether ACMG-recommended secondary (incidental) findings were included in the genomic report per patient opt-in preference.',
    `sequencing_depth_mean` DECIMAL(18,2) COMMENT 'Average sequencing depth (coverage) achieved across the targeted regions, indicating data quality and confidence in variant calls.',
    `specimen_accession_number` STRING COMMENT 'Laboratory-assigned unique accession number for the specimen used in genomic analysis.',
    `specimen_collection_date` DATE COMMENT 'Date when the biological specimen was collected from the patient for genomic testing.',
    `specimen_type` STRING COMMENT 'Type of biological specimen collected for genomic analysis.',
    `test_methodology` STRING COMMENT 'Sequencing or analysis methodology used to generate the genomic profile. [ENUM-REF-CANDIDATE: whole_genome_sequencing|whole_exome_sequencing|targeted_panel|microarray|fish|pcr|rna_sequencing — promote to reference product]',
    `testing_laboratory_clia_number` STRING COMMENT 'CLIA certification number of the laboratory that performed the genomic testing, required for regulatory compliance.',
    `testing_laboratory_name` STRING COMMENT 'Name of the CLIA-certified laboratory that performed the genomic sequencing and analysis.',
    `therapy_recommendation_flag` BOOLEAN COMMENT 'Indicates whether the genomic profile results include specific targeted therapy or treatment recommendations.',
    `tumor_mutational_burden` DECIMAL(18,2) COMMENT 'Tumor mutational burden score measured in mutations per megabase, relevant for immunotherapy eligibility assessment in oncology genomic profiles.',
    `turnaround_days` STRING COMMENT 'Number of calendar days from specimen collection to final report issuance, used for laboratory performance monitoring.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this patient genomic profile record was last modified.',
    `vous_count` STRING COMMENT 'Number of variants of uncertain significance identified in this genomic profile requiring potential future reclassification.',
    CONSTRAINT pk_patient_profile PRIMARY KEY(`patient_profile_id`)
) COMMENT 'Table storing patient genomic profiles.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`genomics_data` (
    `genomics_data_id` BIGINT COMMENT 'Primary key for genomics_data',
    `genomic_order_id` BIGINT COMMENT 'Foreign key linking to genomics.genomic_order. Business justification: New FK linking genomics_data to the genomic_order. De-silos this general genomics data table.',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider who ordered the genomic test.',
    `genomics_interpreting_provider_clinician_id` BIGINT COMMENT 'Identifier of the clinical geneticist or molecular pathologist who interpreted the genomic results.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient for whom the genomic test was performed.',
    `research_document_id` BIGINT COMMENT 'Reference identifier to the full genomic test report PDF stored in the document management system.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the genomic test was ordered or resulted.',
    `accession_number` STRING COMMENT 'Unique laboratory-assigned accession number for the genomic specimen and test order, used for tracking through the testing workflow.',
    `actionable_variant_count` STRING COMMENT 'Number of clinically actionable variants identified that have associated therapeutic, diagnostic, or prognostic implications.',
    `average_coverage_depth` DECIMAL(18,2) COMMENT 'Mean sequencing read depth across the targeted regions, indicating the quality and reliability of variant detection.',
    `care_pathway_linked_flag` BOOLEAN COMMENT 'Indicates whether the genomic result has been linked to a precision medicine care pathway or treatment protocol in the clinical system.',
    `clinical_significance_summary` STRING COMMENT 'Narrative summary of the clinical significance of genomic findings, including therapeutic implications and recommended actions.',
    `clinical_trial_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the genomic findings suggest potential eligibility for clinical trials based on identified biomarkers.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether informed consent for genomic testing was obtained from the patient, including consent for incidental findings disclosure.',
    `consent_scope` STRING COMMENT 'Scope of patient consent regarding use of genomic data and disclosure of incidental or secondary findings.',
    `counseling_completed_flag` BOOLEAN COMMENT 'Indicates whether the recommended genetic counseling session has been completed with the patient.',
    `coverage_determination` STRING COMMENT 'Payer coverage determination for the genomic test, indicating whether the test is covered under the patients benefit plan.',
    `disclosure_date` DATE COMMENT 'Date on which the genomic test results were disclosed to the patient.',
    `gene_name` STRING COMMENT 'HUGO Gene Nomenclature Committee (HGNC) approved symbol for the primary gene of interest in the test result (e.g., BRCA1, EGFR, TP53).',
    `gene_panel_name` STRING COMMENT 'Name of the multi-gene panel tested when applicable (e.g., Hereditary Cancer Panel, Cardiac Panel).',
    `genetic_counseling_recommended` BOOLEAN COMMENT 'Indicates whether genetic counseling is recommended based on the test results.',
    `hereditary_risk_flag` BOOLEAN COMMENT 'Indicates whether the genomic result identifies a hereditary risk requiring genetic counseling and family cascade testing.',
    `indication_description` STRING COMMENT 'Free-text description of the clinical reason or suspected condition prompting the genomic test order.',
    `indication_diagnosis_code` STRING COMMENT 'ICD-10-CM diagnosis code representing the clinical indication for ordering the genomic test.',
    `insurance_authorization_number` STRING COMMENT 'Prior authorization number obtained from the payer for coverage of the genomic test.',
    `microsatellite_instability_status` STRING COMMENT 'Microsatellite instability status determined by genomic analysis, relevant for immunotherapy eligibility and Lynch syndrome screening.',
    `notes` STRING COMMENT 'Free-text clinical notes or comments related to the genomic test, including additional context from the ordering or interpreting provider.',
    `number_of_variants_detected` STRING COMMENT 'Total count of reportable genomic variants identified in the analysis.',
    `order_date` DATE COMMENT 'Date the genomic test was ordered by the clinician.',
    `overall_interpretation` STRING COMMENT 'High-level clinical interpretation summary of the genomic test result indicating whether actionable findings were identified.',
    `pathogenicity_classification` STRING COMMENT 'ACMG/AMP five-tier classification of the most clinically significant variant identified, where VUS indicates Variant of Uncertain Significance.',
    `performing_lab_clia_number` STRING COMMENT 'CLIA certification number of the laboratory that performed the genomic test, required for regulatory compliance.',
    `performing_lab_name` STRING COMMENT 'Name of the CLIA-certified laboratory that performed the genomic analysis.',
    `platform_technology` STRING COMMENT 'Sequencing technology platform used for the genomic analysis (e.g., Illumina NovaSeq, Ion Torrent, Oxford Nanopore).',
    `quality_score` DECIMAL(18,2) COMMENT 'Composite quality metric for the genomic test run, reflecting sequencing quality, coverage uniformity, and analytical validity.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this genomics data record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this genomics data record was last modified.',
    `reference_genome_build` STRING COMMENT 'Human reference genome assembly version used for variant calling and annotation.',
    `result_date` DATE COMMENT 'Date the final genomic test result was reported by the performing laboratory.',
    `result_disclosed_to_patient_flag` BOOLEAN COMMENT 'Indicates whether the genomic test results have been formally disclosed and discussed with the patient.',
    `result_received_timestamp` TIMESTAMP COMMENT 'Timestamp when the genomic result was received into the EHR system from the performing laboratory.',
    `result_status` STRING COMMENT 'Current status of the genomic test result in the clinical workflow lifecycle.',
    `sample_adequacy` STRING COMMENT 'Assessment of whether the submitted specimen met minimum quality and quantity requirements for genomic analysis.',
    `specimen_collection_date` DATE COMMENT 'Date the biological specimen was collected from the patient for genomic analysis.',
    `specimen_site` STRING COMMENT 'Anatomical site from which the specimen was collected, particularly relevant for tumor biopsies.',
    `specimen_type` STRING COMMENT 'Type of biological specimen submitted for genomic testing.',
    `test_code` STRING COMMENT 'Standardized code identifying the genomic test, typically mapped to CPT or proprietary laboratory codes.',
    `test_name` STRING COMMENT 'Human-readable name of the specific genomic test or panel ordered (e.g., Oncotype DX, FoundationOne CDx, Invitae Comprehensive Panel).',
    `test_type` STRING COMMENT 'Classification of the genomic test methodology performed on the specimen.',
    `therapy_recommendation` STRING COMMENT 'Targeted therapy or treatment recommendation based on genomic findings, linking precision medicine results to actionable care pathways.',
    `tumor_mutational_burden` DECIMAL(18,2) COMMENT 'Quantitative measure of mutations per megabase in tumor tissue, used as a biomarker for immunotherapy response prediction.',
    `tumor_type` STRING COMMENT 'Classification of the tumor type for oncology genomic tests, aligned with WHO tumor classification.',
    `turnaround_days` STRING COMMENT 'Number of calendar days from specimen receipt at the laboratory to final result reporting.',
    CONSTRAINT pk_genomics_data PRIMARY KEY(`genomics_data_id`)
) COMMENT 'genomics table for precision medicine data.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`genomic_variant_result` (
    `genomic_variant_result_id` BIGINT COMMENT 'Primary key for genomic_variant_result',
    `care_site_id` BIGINT COMMENT 'Identifier of the laboratory facility that performed the genomic sequencing and variant calling.',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider who ordered the genomic test that produced this variant result.',
    `genomic_interpreting_pathologist_clinician_id` BIGINT COMMENT 'Identifier of the molecular pathologist or geneticist who reviewed and interpreted the variant result.',
    `genomic_test_order_id` BIGINT COMMENT 'Identifier of the genomic test order that initiated this variant analysis.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient from whom the genomic specimen was collected and for whom the variant result applies.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the genomic test was ordered or the result was reported.',
    `accession_number` STRING COMMENT 'Unique laboratory-assigned accession number for the specimen and test run that produced this variant result.',
    `actionability_tier` STRING COMMENT 'AMP/ASCO/CAP tier classification indicating the level of clinical actionability for somatic variants in oncology.',
    `allele_frequency` DECIMAL(18,2) COMMENT 'The fraction of sequencing reads supporting the alternate allele at this position, expressed as a decimal between 0 and 1.',
    `alternate_allele` STRING COMMENT 'The observed nucleotide sequence that differs from the reference allele at the variant position.',
    `associated_condition` STRING COMMENT 'The disease or clinical condition associated with this variant finding, typically expressed as an ICD-10 or OMIM condition.',
    `chromosome` STRING COMMENT 'Chromosome on which the variant is located, using standard nomenclature (1-22, X, Y, MT).',
    `clinical_significance` STRING COMMENT 'ACMG/AMP five-tier classification of the clinical significance of the variant for the patients condition.',
    `clinical_trial_eligibility_flag` BOOLEAN COMMENT 'Indicates whether this variant finding makes the patient potentially eligible for one or more clinical trials.',
    `clinvar_accession` STRING COMMENT 'The NCBI ClinVar variation identifier linking to curated clinical significance assertions for this variant.',
    `cosmic_accession` STRING COMMENT 'COSMIC database identifier for somatic variants found in cancer, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this genomic variant result record was first created in the system.',
    `dbsnp_accession` STRING COMMENT 'The NCBI dbSNP reference SNP cluster identifier (rsID) for this variant, if catalogued.',
    `evidence_level` STRING COMMENT 'Strength of clinical evidence supporting the variant-disease or variant-drug association, per AMP/ASCO/CAP evidence framework.',
    `exon_number` STRING COMMENT 'The exon or intron number within the gene where the variant is located, if applicable.',
    `functional_effect` STRING COMMENT 'Predicted functional consequence of the variant on the gene product (e.g., missense, nonsense, frameshift, splice site alteration). [ENUM-REF-CANDIDATE: missense|nonsense|frameshift|splice_site|synonymous|intronic|in_frame_deletion|in_frame_insertion|start_loss|stop_loss — promote to reference product]',
    `gene_symbol` STRING COMMENT 'Official HUGO Gene Nomenclature Committee (HGNC) approved gene symbol where the variant is located (e.g., BRCA1, EGFR, TP53).',
    `genomic_position_end` BIGINT COMMENT 'End position of the variant on the chromosome in the reference genome coordinate system.',
    `genomic_position_start` BIGINT COMMENT 'Start position of the variant on the chromosome in the reference genome coordinate system.',
    `hgvs_coding` STRING COMMENT 'HGVS nomenclature for the variant at the coding DNA level (c. notation), providing standardized variant description.',
    `hgvs_protein` STRING COMMENT 'HGVS nomenclature for the predicted protein change (p. notation), describing the amino acid alteration.',
    `incidental_finding_flag` BOOLEAN COMMENT 'Indicates whether this variant is an incidental or secondary finding unrelated to the primary test indication, per ACMG SF guidelines.',
    `inheritance_pattern` STRING COMMENT 'The mode of inheritance associated with the gene and variant, relevant for genetic counseling and family risk assessment.',
    `interpretation_date` DATE COMMENT 'Date when the clinical interpretation and significance classification were finalized by the reviewing pathologist.',
    `interpretation_notes` STRING COMMENT 'Free-text clinical notes from the interpreting pathologist providing additional context, evidence citations, or caveats about the variant classification.',
    `interpretation_status` STRING COMMENT 'Current status of the clinical interpretation for this variant result within the reporting workflow.',
    `loinc_code` STRING COMMENT 'LOINC code representing the specific genomic observation or test result for interoperability and standardized reporting.',
    `panel_name` STRING COMMENT 'Name of the specific gene panel or test assay used if the methodology is a targeted panel approach.',
    `population_frequency` DECIMAL(18,2) COMMENT 'Frequency of the alternate allele in the general population from gnomAD or similar population databases, used to assess rarity.',
    `quality_score` DECIMAL(18,2) COMMENT 'Phred-scaled quality score representing the confidence that the variant call is correct.',
    `read_depth` STRING COMMENT 'Total number of sequencing reads covering the variant position, indicating the confidence level of the variant call.',
    `reference_allele` STRING COMMENT 'The nucleotide sequence at the variant position in the reference genome assembly.',
    `reference_genome_build` STRING COMMENT 'The human reference genome assembly version used for alignment and variant calling (e.g., GRCh37/hg19, GRCh38/hg38).',
    `report_date` DATE COMMENT 'Date when the final genomic variant report was issued and made available to the ordering provider.',
    `reportable_flag` BOOLEAN COMMENT 'Indicates whether this variant meets criteria for inclusion in the final clinical report to the ordering provider.',
    `result_timestamp` TIMESTAMP COMMENT 'Timestamp when the variant result was first generated by the bioinformatics pipeline or laboratory system.',
    `somatic_germline_flag` STRING COMMENT 'Classification of whether the variant is somatic (acquired in tumor) or germline (inherited), critical for treatment decisions.',
    `specimen_collection_date` DATE COMMENT 'Date when the biological specimen was collected from the patient for genomic testing.',
    `specimen_type` STRING COMMENT 'Type of biological specimen from which DNA was extracted for genomic sequencing.',
    `test_methodology` STRING COMMENT 'The genomic testing methodology used to detect this variant (e.g., whole genome sequencing, whole exome sequencing, targeted gene panel).',
    `therapeutic_implication` STRING COMMENT 'Summary of therapeutic implications of the variant, including associated targeted therapies, drug sensitivity, or resistance information.',
    `transcript_accession` STRING COMMENT 'RefSeq or Ensembl transcript identifier used as the reference for coding and protein-level annotations.',
    `tumor_normal_indicator` STRING COMMENT 'Indicates whether the variant was detected from a tumor-only analysis, paired tumor-normal comparison, or germline testing.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this genomic variant result record was last modified or updated.',
    `variant_type` STRING COMMENT 'Classification of the type of genomic variant detected (e.g., single nucleotide variant, insertion, deletion, copy number variant, structural variant).',
    `zygosity` STRING COMMENT 'The zygosity state of the variant in the patient sample, indicating whether one or both alleles carry the variant.',
    CONSTRAINT pk_genomic_variant_result PRIMARY KEY(`genomic_variant_result_id`)
) COMMENT 'Table for genomic variant results.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`pharmacogenomics` (
    `pharmacogenomics_id` BIGINT COMMENT 'Primary key for pharmacogenomics',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider who ordered the pharmacogenomic test or consultation.',
    `drug_master_id` BIGINT COMMENT 'Identifier of the medication for which pharmacogenomic guidance is being provided.',
    `employee_id` BIGINT COMMENT 'Identifier of the clinical pharmacist or pharmacogenomics specialist who reviewed and interpreted the result.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient for whom pharmacogenomic testing and interpretation was performed.',
    `genomic_test_id` BIGINT COMMENT 'Identifier linking to the original genomic test order from which this pharmacogenomic interpretation was derived.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the pharmacogenomic assessment was ordered or reviewed.',
    `activity_score` DECIMAL(18,2) COMMENT 'Numeric activity score assigned to the diplotype used to translate genotype to phenotype per CPIC guidelines (e.g., 0, 0.5, 1.0, 1.5, 2.0).',
    `adverse_event_risk_category` STRING COMMENT 'Categorization of the patients risk for adverse drug events based on their pharmacogenomic profile for the specified medication.',
    `alternative_drug_recommendation` STRING COMMENT 'Recommended alternative medication(s) when the pharmacogenomic result indicates the primary drug may be ineffective or carry increased toxicity risk.',
    `cds_alert_override_reason` STRING COMMENT 'Reason documented by the provider if the clinical decision support alert based on pharmacogenomic data was overridden.',
    `clinical_note` STRING COMMENT 'Free-text clinical note documenting the pharmacogenomics specialists interpretation, clinical context, and rationale for the recommendation.',
    `clinical_review_date` DATE COMMENT 'Date when the pharmacogenomic result was reviewed and interpreted by a clinical pharmacist or pharmacogenomics specialist.',
    `clinical_significance` STRING COMMENT 'Overall clinical significance of the pharmacogenomic finding in the context of the patients current or planned medication therapy.',
    `consent_status` STRING COMMENT 'Status of patient consent for pharmacogenomic testing and result storage, required under genetic information nondiscrimination regulations.',
    `cpic_guideline_version` STRING COMMENT 'Version of the CPIC guideline used to generate the therapeutic recommendation for this gene-drug pair.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pharmacogenomics record was first created in the system.',
    `diplotype` STRING COMMENT 'The diplotype assignment representing the combination of two haplotypes (star alleles) identified for the gene (e.g., *1/*2, *1/*17, *4/*5).',
    `dosing_guidance` STRING COMMENT 'Specific dosing guidance text derived from pharmacogenomic interpretation, including percentage adjustments or absolute dose recommendations.',
    `drug_gene_interaction_level` STRING COMMENT 'CPIC evidence level classification indicating the strength of evidence for the gene-drug interaction (1A = guideline available with strong evidence, through 4 = limited evidence).',
    `drug_interaction_risk` STRING COMMENT 'Risk level for adverse drug reactions or therapeutic failure based on the pharmacogenomic profile for the specified medication.',
    `drug_metabolism_pathway` STRING COMMENT 'Primary metabolic pathway affected by the gene variant (e.g., CYP450 oxidation, glucuronidation, acetylation, thiopurine methylation).',
    `effective_date` DATE COMMENT 'Date from which this pharmacogenomic interpretation is considered clinically valid and applicable to prescribing decisions.',
    `ehr_integration_status` STRING COMMENT 'Status indicating whether the pharmacogenomic result has been successfully integrated into the patients electronic health record for clinical decision support.',
    `ethnicity_context` STRING COMMENT 'Self-reported ethnicity or ancestry used to contextualize allele frequency and phenotype prediction, as pharmacogenomic prevalence varies by population.',
    `expiration_date` DATE COMMENT 'Date after which this pharmacogenomic interpretation should be re-evaluated due to updated guidelines, new evidence, or assay limitations.',
    `fda_label_annotation` STRING COMMENT 'Category of pharmacogenomic information present in the FDA-approved drug label (required testing, recommended testing, actionable, informative, or none).',
    `gene_name` STRING COMMENT 'HUGO Gene Nomenclature Committee (HGNC) approved symbol for the gene assessed in this pharmacogenomic evaluation (e.g., CYP2D6, CYP2C19, VKORC1, DPYD, TPMT, UGT1A1).',
    `is_actionable` BOOLEAN COMMENT 'Indicates whether the pharmacogenomic result requires a clinical action such as dose modification, drug change, or enhanced monitoring.',
    `is_cds_alert_triggered` BOOLEAN COMMENT 'Indicates whether a clinical decision support alert was triggered in the EHR based on this pharmacogenomic result when a relevant medication was ordered.',
    `is_multi_gene_interaction` BOOLEAN COMMENT 'Indicates whether this pharmacogenomic assessment involves interactions across multiple genes affecting the same drug metabolism pathway.',
    `performing_laboratory_clia_number` STRING COMMENT 'CLIA certification number of the laboratory that performed the pharmacogenomic test, ensuring regulatory compliance.',
    `performing_laboratory_name` STRING COMMENT 'Name of the CLIA-certified laboratory that performed the pharmacogenomic testing.',
    `pharmgkb_annotation_accession` STRING COMMENT 'Identifier from the Pharmacogenomics Knowledge Base (PharmGKB) linking to the curated annotation for this gene-drug relationship.',
    `phenotype` STRING COMMENT 'The predicted metabolizer phenotype derived from the diplotype (e.g., poor metabolizer, intermediate metabolizer, normal metabolizer, rapid metabolizer, ultrarapid metabolizer). [ENUM-REF-CANDIDATE: poor_metabolizer|intermediate_metabolizer|normal_metabolizer|rapid_metabolizer|ultrarapid_metabolizer|indeterminate|likely_poor|likely_intermediate — promote to reference product]',
    `population_frequency` DECIMAL(18,2) COMMENT 'Frequency of the identified allele or diplotype in the general population or relevant ethnic subpopulation, used for clinical context.',
    `recommendation_classification` STRING COMMENT 'Strength classification of the pharmacogenomic recommendation indicating how strongly the clinical action is supported by evidence.',
    `record_status` STRING COMMENT 'Current lifecycle status of this pharmacogenomics record indicating whether it is active, has been amended, entered in error, or made inactive.',
    `result_disclosure_status` STRING COMMENT 'Status of whether the pharmacogenomic result has been disclosed to the patient, per genetic counseling and informed consent requirements.',
    `result_reported_date` DATE COMMENT 'Date when the pharmacogenomic test result was officially reported by the performing laboratory.',
    `specimen_collection_date` DATE COMMENT 'Date when the biological specimen was collected from the patient for pharmacogenomic testing.',
    `test_methodology` STRING COMMENT 'Laboratory methodology used for genotyping (e.g., targeted genotyping panel, whole exome sequencing, microarray, PCR-based assay, next-generation sequencing).',
    `test_platform` STRING COMMENT 'Name or identifier of the genotyping platform or assay used to generate the pharmacogenomic result.',
    `therapeutic_class` STRING COMMENT 'Therapeutic class of the medication being evaluated (e.g., antidepressant, anticoagulant, analgesic, antineoplastic, immunosuppressant).',
    `therapeutic_recommendation` STRING COMMENT 'Clinical recommendation for drug therapy based on the pharmacogenomic result, such as dose adjustment, alternative drug selection, or standard dosing.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this pharmacogenomics record was last modified or updated.',
    CONSTRAINT pk_pharmacogenomics PRIMARY KEY(`pharmacogenomics_id`)
) COMMENT 'Table for pharmacogenomics data.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`genomic_profile` (
    `genomic_profile_id` BIGINT COMMENT 'Primary key for genomic_profile',
    `care_site_id` BIGINT COMMENT 'Identifier of the laboratory facility that performed the genomic sequencing or analysis.',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider who ordered the genomic test.',
    `genomic_order_id` BIGINT COMMENT 'Foreign key linking to genomics.genomic_order. Business justification: New FK linking genomic_profile to the originating genomic_order. order_date is redundant.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient whose genomic material was profiled.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the genomic test was ordered or collected.',
    `accession_number` STRING COMMENT 'Unique laboratory-assigned tracking number for the genomic specimen and test order.',
    `actionable_variant_count` STRING COMMENT 'Number of clinically actionable genomic variants identified that may inform treatment decisions.',
    `amendment_reason` STRING COMMENT 'Reason for any amendment or correction to the original genomic profile report, if applicable.',
    `brca_status` STRING COMMENT 'BRCA1/BRCA2 mutation status indicating presence of pathogenic variants relevant for PARP inhibitor therapy and hereditary risk counseling.',
    `clinical_significance_summary` STRING COMMENT 'Free-text narrative summarizing the clinical implications of the genomic findings for the patients care plan.',
    `clinical_trial_match_flag` BOOLEAN COMMENT 'Indicates whether the genomic findings match eligibility criteria for any active clinical trials.',
    `consent_status` STRING COMMENT 'Status of patient informed consent for genomic testing, including acknowledgment of incidental findings disclosure preferences.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the genomic profile record was first created in the system.',
    `data_sharing_consent_flag` BOOLEAN COMMENT 'Indicates whether the patient consented to sharing de-identified genomic data for research purposes.',
    `external_report_reference` STRING COMMENT 'Unique report identifier assigned by the external reference laboratory performing the genomic analysis.',
    `genetic_counseling_referral_flag` BOOLEAN COMMENT 'Indicates whether the genomic findings triggered a referral to genetic counseling services.',
    `genomic_profile_status` STRING COMMENT 'Current lifecycle status of the genomic profile from order through final reporting.',
    `her2_status` STRING COMMENT 'HER2 amplification or overexpression status determined through genomic analysis, relevant for targeted therapy selection.',
    `hereditary_risk_flag` BOOLEAN COMMENT 'Indicates whether the profile identified germline variants associated with hereditary cancer or disease predisposition syndromes.',
    `hl7_message_control_number` STRING COMMENT 'Identifier of the HL7 or FHIR message through which the genomic results were electronically received into the EHR.',
    `insurance_authorization_status` STRING COMMENT 'Status of insurance prior authorization for the genomic test, impacting billing and patient financial responsibility.',
    `interpreting_pathologist` STRING COMMENT 'Name of the molecular pathologist or geneticist who signed out the genomic interpretation report.',
    `mean_coverage_depth` DECIMAL(18,2) COMMENT 'Average number of times each nucleotide position was sequenced, indicating data quality and confidence level.',
    `microsatellite_instability_status` STRING COMMENT 'Microsatellite instability classification indicating DNA mismatch repair deficiency, relevant for immunotherapy eligibility.',
    `overall_interpretation` STRING COMMENT 'Summary clinical significance classification of the genomic findings per ACMG/AMP variant interpretation guidelines.',
    `panel_gene_count` STRING COMMENT 'Number of genes included in the targeted genomic panel used for this profile.',
    `pdl1_expression_score` DECIMAL(18,2) COMMENT 'Programmed death-ligand 1 expression score (tumor proportion score or combined positive score) when assessed alongside genomic profiling.',
    `primary_diagnosis_code` STRING COMMENT 'ICD-10-CM diagnosis code representing the clinical condition for which genomic profiling was ordered.',
    `profile_type` STRING COMMENT 'Classification of the genomic profiling approach used, distinguishing between somatic tumor profiling, germline hereditary testing, paired tumor-normal analysis, liquid biopsy, targeted panel, or whole exome sequencing.',
    `received_date` DATE COMMENT 'Date when the performing laboratory received the specimen for genomic analysis.',
    `recommended_therapies` STRING COMMENT 'Comma-separated list of FDA-approved or guideline-recommended targeted therapies matched to the identified genomic alterations.',
    `report_date` DATE COMMENT 'Date when the final genomic profile report was issued by the performing laboratory.',
    `report_pdf_url` STRING COMMENT 'Secure URL or document reference to the full genomic profile report in PDF format stored in the document management system.',
    `resistance_markers` STRING COMMENT 'Identified genomic markers associated with resistance to specific therapeutic agents, informing treatment avoidance decisions.',
    `result_reviewed_date` DATE COMMENT 'Date when the ordering provider reviewed and acknowledged the genomic profile results.',
    `sample_adequacy` STRING COMMENT 'Assessment of whether the submitted specimen met minimum quality and quantity requirements for successful genomic analysis.',
    `sequencing_platform` STRING COMMENT 'Technology platform used for genomic sequencing (e.g., Illumina NovaSeq, Ion Torrent, Oxford Nanopore).',
    `specimen_collection_date` DATE COMMENT 'Date when the biological specimen was collected from the patient for genomic testing.',
    `specimen_site` STRING COMMENT 'Anatomical site from which the specimen was obtained, coded per SNOMED CT body structure hierarchy.',
    `specimen_type` STRING COMMENT 'Type of biological specimen used for genomic analysis, such as tissue biopsy, blood draw, saliva, bone marrow, cell-free DNA, or formalin-fixed paraffin-embedded tissue.',
    `test_code` STRING COMMENT 'Standardized code identifying the genomic test, typically mapped to CPT or proprietary lab codes.',
    `test_name` STRING COMMENT 'Name of the specific genomic test or panel performed (e.g., FoundationOne CDx, Tempus xT, Guardant360).',
    `therapy_match_flag` BOOLEAN COMMENT 'Indicates whether the genomic profile identified at least one FDA-approved or NCCN-recommended targeted therapy option.',
    `total_variant_count` STRING COMMENT 'Total number of genomic variants detected across all significance tiers in this profile.',
    `tumor_mutational_burden` DECIMAL(18,2) COMMENT 'Number of somatic mutations per megabase of sequenced DNA, used as a biomarker for immunotherapy response prediction.',
    `tumor_purity_percent` DECIMAL(18,2) COMMENT 'Estimated percentage of tumor cells in the specimen, critical for variant allele frequency interpretation and analytical sensitivity.',
    `tumor_type` STRING COMMENT 'Specific tumor or disease classification relevant to the genomic profile, typically aligned with oncology nomenclature.',
    `turnaround_days` STRING COMMENT 'Number of calendar days from specimen receipt at the lab to final report issuance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the genomic profile record was last modified.',
    CONSTRAINT pk_genomic_profile PRIMARY KEY(`genomic_profile_id`)
) COMMENT 'Genomic Profile table';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`genomic_cohort_qualification` (
    `genomic_cohort_qualification_id` BIGINT COMMENT 'Unique surrogate key for the genomic cohort qualification record',
    `genomics_patient_genomic_profile_id` BIGINT COMMENT 'Foreign key linking to the patient genomic profile that qualified for the cohort',
    `population_health_cohort_mgmt_cohort_definition_id` BIGINT COMMENT 'Foreign key linking to the cohort definition the profile qualified for',
    `genomic_risk_score` DECIMAL(18,2) COMMENT 'Risk score calculated in the context of this specific cohort qualification, derived from the genomic profile data',
    `inclusion_confidence` DECIMAL(18,2) COMMENT 'Confidence level (0-1) that the genomic profile truly meets the cohort inclusion criteria',
    `qualification_criteria_met` STRING COMMENT 'Specific inclusion criteria from the cohort definition that this genomic profile satisfies',
    `qualification_date` DATE COMMENT 'Date when the patient genomic profile was determined to qualify for the cohort',
    CONSTRAINT pk_genomic_cohort_qualification PRIMARY KEY(`genomic_cohort_qualification_id`)
) COMMENT 'This association product represents the Qualification event between patient_genomic_profile and cohort_definition. It captures the operational record of a patients genomic profile meeting the inclusion criteria for a population health cohort. Each record links one patient_genomic_profile to one cohort_definition with attributes that exist only in the context of this qualification relationship, including when the qualification occurred, which criteria were met, the genomic risk score in context, and the confidence of inclusion.. Existence Justification: In precision medicine and population health management, a single patients genomic profile qualifies them for multiple cohorts simultaneously (e.g., BRCA1+ cohort, high pharmacogenomic risk cohort, hereditary cancer cohort), and each cohort definition includes many patients with different genomic profiles. Healthcare organizations actively manage these qualifications as part of clinical trial matching, targeted intervention programs, and population health stratification. The relationship Genomic Cohort Qualification is an operational entity that clinicians and research coordinators create, review, and update.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`genomic_cohort_inclusion` (
    `genomic_cohort_inclusion_id` BIGINT COMMENT 'Unique surrogate key for the genomic cohort inclusion record',
    `genomics_patient_genomic_profile_id` BIGINT COMMENT 'Foreign key linking to the patient genomic profile that qualified for cohort inclusion',
    `population_health_cohort_cohort_definition_id` BIGINT COMMENT 'Foreign key linking to the cohort definition the genomic profile was included in',
    `eligibility_status` STRING COMMENT 'Current eligibility status of this genomic profile within the cohort',
    `genomic_criteria_met` STRING COMMENT 'Description of which specific genomic findings (variants, mutations, markers) triggered cohort inclusion',
    `inclusion_date` DATE COMMENT 'Date when the genomic profile was determined to meet cohort criteria and was included',
    `risk_score_at_inclusion` DECIMAL(18,2) COMMENT 'The patient risk stratification score captured at the time of cohort inclusion, providing a temporal snapshot',
    CONSTRAINT pk_genomic_cohort_inclusion PRIMARY KEY(`genomic_cohort_inclusion_id`)
) COMMENT 'This association product represents the Inclusion event between patient_genomic_profile and cohort_definition. It captures which specific genomic findings drove a patients genomic profile to be included in a population health cohort, along with the risk score at time of inclusion and ongoing eligibility status. Each record links one patient_genomic_profile to one cohort_definition with attributes that exist only in the context of this relationship.. Existence Justification: In healthcare population health management, a single patients genomic profile can qualify them for multiple cohorts simultaneously (e.g., BRCA mutation cohort, pharmacogenomics cohort, hereditary cancer cohort, Lynch syndrome cohort). Conversely, each cohort definition includes many genomic profiles that meet its criteria. Health systems actively manage these cohort memberships as operational entities — population health teams review which genomic profiles triggered inclusion, track when criteria were met, and monitor eligibility status changes over time.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`genomics`.`genomics_trial_eligibility_match` (
    `genomics_trial_eligibility_match_id` BIGINT COMMENT 'Primary key for genomics_trial_eligibility_match',
    `genomic_test_result_id` BIGINT COMMENT 'Foreign key linking to the genomic test result being evaluated against trial eligibility criteria',
    `research_clinical_trial_matching_eligibility_criteria_id` BIGINT COMMENT 'Foreign key linking to the clinical trial eligibility criterion being evaluated',
    `trial_match_id` BIGINT COMMENT 'Unique surrogate key for each trial eligibility match evaluation record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the match record was first created in the data lake',
    `criterion_met_flag` BOOLEAN COMMENT 'Indicates whether the genomic test result definitively satisfies the eligibility criterion after clinical review',
    `evaluation_date` TIMESTAMP COMMENT 'Timestamp when the match between this genomic result and eligibility criterion was evaluated by the matching system or clinical trial coordinator',
    `match_score` DECIMAL(18,2) COMMENT 'Quantitative score (0-100) indicating how strongly the genomic result satisfies the eligibility criterion, computed by the matching algorithm',
    `match_status` STRING COMMENT 'Current lifecycle state of the match evaluation: pending_review, confirmed, rejected, expired, or withdrawn',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the match record',
    CONSTRAINT pk_genomics_trial_eligibility_match PRIMARY KEY(`genomics_trial_eligibility_match_id`)
) COMMENT 'This association product represents the evaluated match between a genomic test result and a clinical trial eligibility criterion. It captures the precision medicine trial matching workflow where genomic findings are systematically evaluated against trial inclusion/exclusion criteria. Each record links one genomic test result to one eligibility criterion with match scoring, evaluation status, and temporal tracking that exist only in the context of this matching relationship.. Existence Justification: In precision medicine and clinical trial matching, a single genomic test result (e.g., BRCA1 mutation detected) can satisfy eligibility criteria for multiple clinical trials simultaneously, and a single set of eligibility criteria (e.g., must have HER2+ status) can be matched by genomic results from many different patients. Healthcare organizations like Academic Medical Centers actively manage this matching process as an operational workflow — clinical trial coordinators evaluate genomic results against trial criteria, record match scores, and track evaluation status. This is a core operational process in precision oncology programs.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ADD CONSTRAINT `fk_genomics_variant_interpretation_genomic_test_order_id` FOREIGN KEY (`genomic_test_order_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_test_order`(`genomic_test_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_annotation` ADD CONSTRAINT `fk_genomics_variant_annotation_genomic_test_order_id` FOREIGN KEY (`genomic_test_order_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_test_order`(`genomic_test_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant` ADD CONSTRAINT `fk_genomics_genomic_variant_genomic_test_order_id` FOREIGN KEY (`genomic_test_order_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_test_order`(`genomic_test_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ADD CONSTRAINT `fk_genomics_sequencing_run_original_run_sequencing_run_id` FOREIGN KEY (`original_run_sequencing_run_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`sequencing_run`(`sequencing_run_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ADD CONSTRAINT `fk_genomics_sequencing_result_prior_result_sequencing_result_id` FOREIGN KEY (`prior_result_sequencing_result_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`sequencing_result`(`sequencing_result_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ADD CONSTRAINT `fk_genomics_sequencing_result_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`sequencing_run`(`sequencing_run_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_trial` ADD CONSTRAINT `fk_genomics_precision_medicine_trial_genomic_consent_id` FOREIGN KEY (`genomic_consent_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_consent`(`genomic_consent_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_trial` ADD CONSTRAINT `fk_genomics_precision_medicine_trial_genomic_test_order_id` FOREIGN KEY (`genomic_test_order_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_test_order`(`genomic_test_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ADD CONSTRAINT `fk_genomics_genomic_order_genomic_consent_id` FOREIGN KEY (`genomic_consent_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_consent`(`genomic_consent_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` ADD CONSTRAINT `fk_genomics_precision_medicine_report_genomic_order_id` FOREIGN KEY (`genomic_order_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_order`(`genomic_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant` ADD CONSTRAINT `fk_genomics_variant_test_order_id` FOREIGN KEY (`test_order_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`test_order`(`test_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genome_sequence` ADD CONSTRAINT `fk_genomics_genome_sequence_genomic_order_id` FOREIGN KEY (`genomic_order_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_order`(`genomic_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genome_sequence` ADD CONSTRAINT `fk_genomics_genome_sequence_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`sequencing_run`(`sequencing_run_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`gene_expression` ADD CONSTRAINT `fk_genomics_gene_expression_genomic_order_id` FOREIGN KEY (`genomic_order_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_order`(`genomic_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`clinical_genomics_report` ADD CONSTRAINT `fk_genomics_clinical_genomics_report_genomic_order_id` FOREIGN KEY (`genomic_order_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_order`(`genomic_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ADD CONSTRAINT `fk_genomics_genomics_genomic_order_genomic_order_id` FOREIGN KEY (`genomic_order_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_order`(`genomic_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ADD CONSTRAINT `fk_genomics_genomics_genomic_order_genomics_genomic_consent_id` FOREIGN KEY (`genomics_genomic_consent_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent`(`genomics_genomic_consent_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ADD CONSTRAINT `fk_genomics_genomics_sequencing_run_genomics_genomic_order_id` FOREIGN KEY (`genomics_genomic_order_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order`(`genomics_genomic_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ADD CONSTRAINT `fk_genomics_genomics_sequencing_run_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`sequencing_run`(`sequencing_run_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ADD CONSTRAINT `fk_genomics_genomics_genomic_sequence_genomic_sequence_id` FOREIGN KEY (`genomic_sequence_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_sequence`(`genomic_sequence_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ADD CONSTRAINT `fk_genomics_genomics_genomic_sequence_genomics_genomic_order_id` FOREIGN KEY (`genomics_genomic_order_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order`(`genomics_genomic_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ADD CONSTRAINT `fk_genomics_genomics_genomic_sequence_genomics_sequencing_run_id` FOREIGN KEY (`genomics_sequencing_run_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run`(`genomics_sequencing_run_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ADD CONSTRAINT `fk_genomics_genomic_report_genomic_test_result_id` FOREIGN KEY (`genomic_test_result_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_test_result`(`genomic_test_result_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ADD CONSTRAINT `fk_genomics_genomic_report_genomics_genomic_order_id` FOREIGN KEY (`genomics_genomic_order_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order`(`genomics_genomic_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ADD CONSTRAINT `fk_genomics_genomics_genomic_consent_genomic_consent_id` FOREIGN KEY (`genomic_consent_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_consent`(`genomic_consent_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ADD CONSTRAINT `fk_genomics_genomics_patient_genomic_profile_genomic_report_id` FOREIGN KEY (`genomic_report_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_report`(`genomic_report_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ADD CONSTRAINT `fk_genomics_genomics_patient_genomic_profile_genomics_genomic_sequence_id` FOREIGN KEY (`genomics_genomic_sequence_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence`(`genomics_genomic_sequence_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ADD CONSTRAINT `fk_genomics_genomics_patient_genomic_profile_genomics_report_id` FOREIGN KEY (`genomics_report_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomics_report`(`genomics_report_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ADD CONSTRAINT `fk_genomics_genomics_patient_genomic_profile_patient_genomic_profile_id` FOREIGN KEY (`patient_genomic_profile_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile`(`patient_genomic_profile_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ADD CONSTRAINT `fk_genomics_genomic_interpretation_genomic_report_id` FOREIGN KEY (`genomic_report_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_report`(`genomic_report_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ADD CONSTRAINT `fk_genomics_genomic_interpretation_genomic_test_result_id` FOREIGN KEY (`genomic_test_result_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_test_result`(`genomic_test_result_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ADD CONSTRAINT `fk_genomics_genomic_test_result_genomics_genomic_consent_id` FOREIGN KEY (`genomics_genomic_consent_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent`(`genomics_genomic_consent_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ADD CONSTRAINT `fk_genomics_genomic_test_result_genomics_genomic_order_id` FOREIGN KEY (`genomics_genomic_order_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order`(`genomics_genomic_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ADD CONSTRAINT `fk_genomics_genomic_test_result_genomics_report_id` FOREIGN KEY (`genomics_report_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomics_report`(`genomics_report_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ADD CONSTRAINT `fk_genomics_precision_trial_enroll_genomic_test_result_id` FOREIGN KEY (`genomic_test_result_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_test_result`(`genomic_test_result_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ADD CONSTRAINT `fk_genomics_precision_trial_enroll_genomics_genomic_consent_id` FOREIGN KEY (`genomics_genomic_consent_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent`(`genomics_genomic_consent_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test` ADD CONSTRAINT `fk_genomics_genomic_test_parent_test_genomic_test_id` FOREIGN KEY (`parent_test_genomic_test_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_test`(`genomic_test_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequencing_result` ADD CONSTRAINT `fk_genomics_genomic_sequencing_result_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`sequencing_run`(`sequencing_run_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ADD CONSTRAINT `fk_genomics_precision_treatment_plan_genomic_test_order_id` FOREIGN KEY (`genomic_test_order_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_test_order`(`genomic_test_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_data` ADD CONSTRAINT `fk_genomics_sequencing_data_genomic_order_id` FOREIGN KEY (`genomic_order_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_order`(`genomic_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_data` ADD CONSTRAINT `fk_genomics_sequencing_data_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`sequencing_run`(`sequencing_run_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence_data` ADD CONSTRAINT `fk_genomics_sequence_data_genomic_order_id` FOREIGN KEY (`genomic_order_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_order`(`genomic_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence` ADD CONSTRAINT `fk_genomics_sequence_genomic_order_id` FOREIGN KEY (`genomic_order_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_order`(`genomic_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence` ADD CONSTRAINT `fk_genomics_sequence_prior_sequence_id` FOREIGN KEY (`prior_sequence_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`sequence`(`sequence_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence` ADD CONSTRAINT `fk_genomics_sequence_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`sequencing_run`(`sequencing_run_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_report` ADD CONSTRAINT `fk_genomics_genomics_report_genomic_order_id` FOREIGN KEY (`genomic_order_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_order`(`genomic_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`phenotype_association` ADD CONSTRAINT `fk_genomics_phenotype_association_variant_id` FOREIGN KEY (`variant_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`variant`(`variant_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ADD CONSTRAINT `fk_genomics_variant_call_genomic_test_order_id` FOREIGN KEY (`genomic_test_order_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_test_order`(`genomic_test_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ADD CONSTRAINT `fk_genomics_patient_genomic_study_genomic_order_id` FOREIGN KEY (`genomic_order_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_order`(`genomic_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`test_order` ADD CONSTRAINT `fk_genomics_test_order_genomic_consent_id` FOREIGN KEY (`genomic_consent_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_consent`(`genomic_consent_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_test_result` ADD CONSTRAINT `fk_genomics_genomics_test_result_genomic_order_id` FOREIGN KEY (`genomic_order_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_order`(`genomic_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_profile` ADD CONSTRAINT `fk_genomics_patient_profile_test_order_id` FOREIGN KEY (`test_order_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`test_order`(`test_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_data` ADD CONSTRAINT `fk_genomics_genomics_data_genomic_order_id` FOREIGN KEY (`genomic_order_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_order`(`genomic_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant_result` ADD CONSTRAINT `fk_genomics_genomic_variant_result_genomic_test_order_id` FOREIGN KEY (`genomic_test_order_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_test_order`(`genomic_test_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`pharmacogenomics` ADD CONSTRAINT `fk_genomics_pharmacogenomics_genomic_test_id` FOREIGN KEY (`genomic_test_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_test`(`genomic_test_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ADD CONSTRAINT `fk_genomics_genomic_profile_genomic_order_id` FOREIGN KEY (`genomic_order_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_order`(`genomic_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_cohort_qualification` ADD CONSTRAINT `fk_genomics_genomic_cohort_qualification_genomics_patient_genomic_profile_id` FOREIGN KEY (`genomics_patient_genomic_profile_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile`(`genomics_patient_genomic_profile_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_cohort_inclusion` ADD CONSTRAINT `fk_genomics_genomic_cohort_inclusion_genomics_patient_genomic_profile_id` FOREIGN KEY (`genomics_patient_genomic_profile_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile`(`genomics_patient_genomic_profile_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_trial_eligibility_match` ADD CONSTRAINT `fk_genomics_genomics_trial_eligibility_match_genomic_test_result_id` FOREIGN KEY (`genomic_test_result_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_test_result`(`genomic_test_result_id`);

-- ========= TAGS =========
ALTER SCHEMA `healthcare_ecm_v1`.`genomics` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `healthcare_ecm_v1`.`genomics` SET TAGS ('dbx_domain' = 'genomics');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequencing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequencing` SET TAGS ('dbx_subdomain' = 'sequencing_operations');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequencing` ALTER COLUMN `genomic_sequencing_id` SET TAGS ('dbx_business_glossary_term' = 'genomic_sequencing Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` SET TAGS ('dbx_subdomain' = 'variant_analysis');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `variant_interpretation_id` SET TAGS ('dbx_business_glossary_term' = 'variant_interpretation Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `acmg_classification` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `acmg_classification` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `associated_condition` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `associated_condition` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `chromosome` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `chromosome` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `clinical_significance_summary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `clinical_significance_summary` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `family_segregation_data` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `family_segregation_data` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `gene_symbol` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `gene_symbol` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `genomic_position` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `genomic_position` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `hgvs_coding_notation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `hgvs_coding_notation` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `hgvs_protein_notation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `hgvs_protein_notation` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `inheritance_pattern` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `inheritance_pattern` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `therapeutic_implication` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `therapeutic_implication` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `tier_classification` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `tier_classification` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `tumor_mutational_burden` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `tumor_mutational_burden` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `variant_allele_fraction` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `variant_allele_fraction` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `variant_class` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `variant_class` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `zygosity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ALTER COLUMN `zygosity` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` SET TAGS ('dbx_subdomain' = 'sequencing_operations');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` SET TAGS ('dbx_delta_tuneFileSizesForRewrites' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` SET TAGS ('dbx_delta_autoOptimize_optimizeWrite' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` SET TAGS ('dbx_hipaa_retention_years' = '10');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` SET TAGS ('dbx_scd_type' = '2');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `genomic_sequence_id` SET TAGS ('dbx_business_glossary_term' = 'genomic_sequence Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `accession_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `accession_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `clinical_actionability` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `clinical_actionability` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `indication` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `indication` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `microsatellite_instability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `microsatellite_instability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `overall_interpretation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `overall_interpretation` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `pathogenicity_classification` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `pathogenicity_classification` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `recommended_followup` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `recommended_followup` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `result_summary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `result_summary` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `tumor_mutational_burden` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `tumor_mutational_burden` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `sample_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `sample_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `file_path` SET TAGS ('dbx_business_glossary_term' = 'File Path');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'FASTQ|BAM|CRAM|VCF|FASTA');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `sequencing_platform` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Platform');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `sequencing_platform` SET TAGS ('dbx_value_regex' = 'Illumina|PacBio|Oxford_Nanopore|Ion_Torrent|BGI');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `assay_type` SET TAGS ('dbx_business_glossary_term' = 'Assay Type');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `assay_type` SET TAGS ('dbx_value_regex' = 'Whole_Genome|Whole_Exome|Targeted|RNA-Seq|Methylation');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `coverage_depth` SET TAGS ('dbx_business_glossary_term' = 'Coverage Depth (X)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `total_reads` SET TAGS ('dbx_business_glossary_term' = 'Total Reads');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `read_length_mean` SET TAGS ('dbx_business_glossary_term' = 'Mean Read Length');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `quality_score_mean` SET TAGS ('dbx_business_glossary_term' = 'Mean Quality Score');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `lab_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Sequence Status');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'available|archived|pending|failed|withdrawn');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `data_retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Policy');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `data_retention_policy` SET TAGS ('dbx_value_regex' = '7_years|indefinite|custom');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `checksum` SET TAGS ('dbx_business_glossary_term' = 'File Checksum (SHA-256)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `checksum` SET TAGS ('dbx_value_regex' = '^[a-fA-F0-9]{64}$');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `genomic_build_version` SET TAGS ('dbx_business_glossary_term' = 'Genomic Build Version');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `alignment_tool` SET TAGS ('dbx_business_glossary_term' = 'Alignment Tool');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `alignment_tool` SET TAGS ('dbx_value_regex' = 'BWA|Bowtie2|STAR|Minimap2');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `alignment_parameters` SET TAGS ('dbx_business_glossary_term' = 'Alignment Parameters');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `is_primary_sequence` SET TAGS ('dbx_business_glossary_term' = 'Primary Sequence Flag');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'EHR|LIS|External|Research');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `privacy_classification` SET TAGS ('dbx_business_glossary_term' = 'Privacy Classification');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `privacy_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|public');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ALTER COLUMN `effective_to` SET TAGS ('dbx_business_glossary_term' = 'Effective To Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_annotation` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_annotation` SET TAGS ('dbx_subdomain' = 'variant_analysis');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_annotation` ALTER COLUMN `variant_annotation_id` SET TAGS ('dbx_business_glossary_term' = 'variant_annotation Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_annotation` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_annotation` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_annotation` ALTER COLUMN `disease_association` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_annotation` ALTER COLUMN `disease_association` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_annotation` ALTER COLUMN `interpretation_summary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_annotation` ALTER COLUMN `interpretation_summary` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_annotation` ALTER COLUMN `therapeutic_implication` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_annotation` ALTER COLUMN `therapeutic_implication` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant` SET TAGS ('dbx_subdomain' = 'variant_analysis');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant` ALTER COLUMN `genomic_variant_id` SET TAGS ('dbx_business_glossary_term' = 'genomic_variant Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant` ALTER COLUMN `alternate_allele` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant` ALTER COLUMN `alternate_allele` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant` ALTER COLUMN `clinical_significance` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant` ALTER COLUMN `clinical_significance` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant` ALTER COLUMN `disease_association` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant` ALTER COLUMN `disease_association` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant` ALTER COLUMN `hgvs_coding` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant` ALTER COLUMN `hgvs_coding` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant` ALTER COLUMN `hgvs_protein` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant` ALTER COLUMN `hgvs_protein` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant` ALTER COLUMN `notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant` ALTER COLUMN `reference_allele` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant` ALTER COLUMN `reference_allele` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant` ALTER COLUMN `therapeutic_implication` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant` ALTER COLUMN `therapeutic_implication` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant` ALTER COLUMN `tumor_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant` ALTER COLUMN `tumor_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant` ALTER COLUMN `zygosity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant` ALTER COLUMN `zygosity` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` SET TAGS ('dbx_subdomain' = 'sequencing_operations');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` SET TAGS ('dbx_delta_tuneFileSizesForRewrites' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` SET TAGS ('dbx_delta_autoOptimize_optimizeWrite' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` SET TAGS ('dbx_hipaa_retention_years' = '7');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` SET TAGS ('dbx_scd_type' = '2');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `sequencing_run_id` SET TAGS ('dbx_business_glossary_term' = 'sequencing_run Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `run_identifier` SET TAGS ('dbx_business_glossary_term' = 'Run Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `sample_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `sample_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Run Status');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'pending|running|completed|failed|canceled');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Start Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run End Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `run_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Run Duration (Seconds)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `lane_count` SET TAGS ('dbx_business_glossary_term' = 'Lane Count');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `flowcell_id` SET TAGS ('dbx_business_glossary_term' = 'Flowcell ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `flowcell_type` SET TAGS ('dbx_business_glossary_term' = 'Flowcell Type');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `library_prep_kit` SET TAGS ('dbx_business_glossary_term' = 'Library Preparation Kit');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `library_prep_kit_version` SET TAGS ('dbx_business_glossary_term' = 'Library Prep Kit Version');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `total_reads` SET TAGS ('dbx_business_glossary_term' = 'Total Reads');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `total_bases` SET TAGS ('dbx_business_glossary_term' = 'Total Bases');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `yield_gb` SET TAGS ('dbx_business_glossary_term' = 'Yield (GB)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `qc_pass` SET TAGS ('dbx_business_glossary_term' = 'QC Pass Flag');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `operator_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `operator_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `operator_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `run_location` SET TAGS ('dbx_business_glossary_term' = 'Run Location');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `run_project_code` SET TAGS ('dbx_business_glossary_term' = 'Run Project Code');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `sequencing_center_id` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Center ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `data_path` SET TAGS ('dbx_business_glossary_term' = 'Data Path');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `data_retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Policy');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `compliance_retention_days` SET TAGS ('dbx_business_glossary_term' = 'Compliance Retention Days');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `is_control_run` SET TAGS ('dbx_business_glossary_term' = 'Control Run Flag');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `control_type` SET TAGS ('dbx_business_glossary_term' = 'Control Type');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ALTER COLUMN `control_type` SET TAGS ('dbx_value_regex' = 'positive|negative|none');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` SET TAGS ('dbx_subdomain' = 'clinical_reporting');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` SET TAGS ('dbx_delta_tuneFileSizesForRewrites' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` SET TAGS ('dbx_delta_autoOptimize_optimizeWrite' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` SET TAGS ('dbx_hipaa_retention_years' = '10');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` SET TAGS ('dbx_scd_type' = '2');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `patient_genomic_profile_id` SET TAGS ('dbx_business_glossary_term' = 'patient_genomic_profile Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `care_pathway_recommendation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `care_pathway_recommendation` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `clinical_significance_summary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `clinical_significance_summary` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `hereditary_risk_category` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `hereditary_risk_category` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `microsatellite_instability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `microsatellite_instability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `overall_interpretation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `overall_interpretation` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `pathogenicity_classification` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `pathogenicity_classification` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `primary_condition_indication` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `primary_condition_indication` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `targeted_therapy_eligible_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `targeted_therapy_eligible_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `tumor_mutational_burden` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `tumor_mutational_burden` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `profile_version` SET TAGS ('dbx_business_glossary_term' = 'Profile Version');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `profile_creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `profile_last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Last Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `profile_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Profile Effective Date');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `profile_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Profile Expiration Date');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `genomic_sequencing_date` SET TAGS ('dbx_business_glossary_term' = 'Genomic Sequencing Date');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `genomic_sequencing_center` SET TAGS ('dbx_business_glossary_term' = 'Genomic Sequencing Center');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `genomic_sequencing_method` SET TAGS ('dbx_business_glossary_term' = 'Genomic Sequencing Method');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `genomic_sequencing_method` SET TAGS ('dbx_value_regex' = 'NGS|WES|WGS');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `genomic_reference_genome` SET TAGS ('dbx_business_glossary_term' = 'Reference Genome Build');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `clinical_interpretation_date` SET TAGS ('dbx_business_glossary_term' = 'Clinical Interpretation Date');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `clinical_interpretation_summary` SET TAGS ('dbx_business_glossary_term' = 'Clinical Interpretation Summary');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `risk_stratification_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Stratification Score');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'low|moderate|high|very_high');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `actionability_flag` SET TAGS ('dbx_business_glossary_term' = 'Actionability Flag');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `actionability_summary` SET TAGS ('dbx_business_glossary_term' = 'Actionability Summary');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `report_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Report ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `report_version` SET TAGS ('dbx_business_glossary_term' = 'Report Version');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `report_release_date` SET TAGS ('dbx_business_glossary_term' = 'Report Release Date');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `report_url` SET TAGS ('dbx_business_glossary_term' = 'Report URL');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'consented|revoked|pending');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `data_retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Years)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `genomic_data_file_path` SET TAGS ('dbx_business_glossary_term' = 'Genomic Data File Path');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `genomic_data_checksum` SET TAGS ('dbx_business_glossary_term' = 'Genomic Data Checksum');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `genomic_data_format` SET TAGS ('dbx_business_glossary_term' = 'Genomic Data Format');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `genomic_data_format` SET TAGS ('dbx_value_regex' = 'VCF|BAM|FASTQ');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `genomic_data_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Genomic Data Size (Bytes)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `clinical_trial_association` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Association');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `clinical_trial_status` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Status');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `clinical_trial_status` SET TAGS ('dbx_value_regex' = 'enrolled|completed|withdrawn');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `clinical_trial_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Enrollment Date');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `clinical_trial_end_date` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial End Date');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `patient_age_at_sequencing` SET TAGS ('dbx_business_glossary_term' = 'Patient Age at Sequencing');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `patient_sex` SET TAGS ('dbx_business_glossary_term' = 'Patient Sex');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `patient_sex` SET TAGS ('dbx_value_regex' = 'male|female|other|unknown');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `patient_ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Patient Ethnicity');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `patient_race` SET TAGS ('dbx_business_glossary_term' = 'Patient Race');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `patient_family_history_flag` SET TAGS ('dbx_business_glossary_term' = 'Family History Flag');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_business_glossary_term' = 'Profile Name');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `genomic_report_author` SET TAGS ('dbx_business_glossary_term' = 'Genomic Report Author');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `report_author_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Report Author Contact Email');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `report_author_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `report_author_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `report_author_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `report_author_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Report Author Contact Phone');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `report_author_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `report_author_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `interpretation_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Confidence Score');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `interpretation_confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Confidence Level');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ALTER COLUMN `interpretation_confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` SET TAGS ('dbx_subdomain' = 'sequencing_operations');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ALTER COLUMN `sequencing_result_id` SET TAGS ('dbx_business_glossary_term' = 'sequencing_result Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ALTER COLUMN `sequencing_run_id` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Run Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ALTER COLUMN `accession_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ALTER COLUMN `accession_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ALTER COLUMN `actionable_variants_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ALTER COLUMN `actionable_variants_count` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ALTER COLUMN `clinical_significance_summary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ALTER COLUMN `clinical_significance_summary` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ALTER COLUMN `indication_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ALTER COLUMN `indication_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ALTER COLUMN `indication_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ALTER COLUMN `indication_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ALTER COLUMN `microsatellite_instability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ALTER COLUMN `microsatellite_instability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ALTER COLUMN `overall_interpretation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ALTER COLUMN `overall_interpretation` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ALTER COLUMN `pathogenicity_classification` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ALTER COLUMN `pathogenicity_classification` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ALTER COLUMN `report_pdf_url` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ALTER COLUMN `report_pdf_url` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ALTER COLUMN `therapy_recommendation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ALTER COLUMN `therapy_recommendation` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ALTER COLUMN `tumor_content_percent` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ALTER COLUMN `tumor_content_percent` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ALTER COLUMN `tumor_mutational_burden` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ALTER COLUMN `tumor_mutational_burden` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ALTER COLUMN `variants_detected_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ALTER COLUMN `variants_detected_count` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` SET TAGS ('dbx_subdomain' = 'precision_therapeutics');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` SET TAGS ('dbx_delta_tuneFileSizesForRewrites' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` SET TAGS ('dbx_delta_autoOptimize_optimizeWrite' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` SET TAGS ('dbx_hipaa_retention_years' = '10');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` SET TAGS ('dbx_scd_type' = '2');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` ALTER COLUMN `genomic_consent_id` SET TAGS ('dbx_business_glossary_term' = 'genomic_consent Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` ALTER COLUMN `authorized_representative_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` ALTER COLUMN `authorized_representative_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` ALTER COLUMN `consent_scope` SET TAGS ('dbx_business_glossary_term' = 'Consent Scope');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` ALTER COLUMN `consent_scope` SET TAGS ('dbx_value_regex' = 'research|clinical|both');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'active|revoked|expired|pending');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` ALTER COLUMN `consent_given_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Given Date');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` ALTER COLUMN `given_by` SET TAGS ('dbx_business_glossary_term' = 'Consent Given By (Name)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` ALTER COLUMN `given_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` ALTER COLUMN `given_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` ALTER COLUMN `signature_method` SET TAGS ('dbx_business_glossary_term' = 'Signature Method');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` ALTER COLUMN `signature_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|phone|mail');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` ALTER COLUMN `signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Signature Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` ALTER COLUMN `consent_document_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Document ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` ALTER COLUMN `consent_notes` SET TAGS ('dbx_business_glossary_term' = 'Consent Notes');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` ALTER COLUMN `created_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` ALTER COLUMN `updated_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_trial` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_trial` SET TAGS ('dbx_subdomain' = 'precision_therapeutics');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_trial` ALTER COLUMN `precision_medicine_trial_id` SET TAGS ('dbx_business_glossary_term' = 'precision_medicine_trial Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_trial` ALTER COLUMN `adverse_event_grade` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_trial` ALTER COLUMN `adverse_event_grade` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_trial` ALTER COLUMN `molecular_profile_summary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_trial` ALTER COLUMN `molecular_profile_summary` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_trial` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_trial` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_trial` ALTER COLUMN `response_assessment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_trial` ALTER COLUMN `response_assessment` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_trial` ALTER COLUMN `subject_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_trial` ALTER COLUMN `subject_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_trial` ALTER COLUMN `target_biomarker` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_trial` ALTER COLUMN `target_biomarker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_trial` ALTER COLUMN `treatment_arm` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_trial` ALTER COLUMN `treatment_arm` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_trial` ALTER COLUMN `treatment_start_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_trial` ALTER COLUMN `treatment_start_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` SET TAGS ('dbx_subdomain' = 'sequencing_operations');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` SET TAGS ('dbx_delta_tuneFileSizesForRewrites' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` SET TAGS ('dbx_delta_autoOptimize_optimizeWrite' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` SET TAGS ('dbx_hipaa_retention_years' = '10');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` SET TAGS ('dbx_scd_type' = '2');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `genomic_order_id` SET TAGS ('dbx_business_glossary_term' = 'genomic_order Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `actionable_findings_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `actionable_findings_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `family_history_relevant` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `family_history_relevant` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `genes_of_interest` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `genes_of_interest` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `incidental_findings_reported` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `incidental_findings_reported` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `indication_icd_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `indication_icd_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `order_reason_text` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `order_reason_text` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `overall_interpretation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `overall_interpretation` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (PAT_ID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `ordering_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider Identifier (PROV_ID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `ordering_provider_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `ordering_provider_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `test_priority` SET TAGS ('dbx_business_glossary_term' = 'Test Priority (PRIORITY)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `test_priority` SET TAGS ('dbx_value_regex' = 'routine|stat|urgent');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `order_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Timestamp (ORDER_TS)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Specimen Identifier (SPEC_ID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `collection_date` SET TAGS ('dbx_business_glossary_term' = 'Specimen Collection Date (COLL_DATE)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `accession_number` SET TAGS ('dbx_business_glossary_term' = 'Accession Number (ACC_NUM)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `billing_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Code (CPT/HCPCS)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `order_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Amount (AMOUNT)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `insurance_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Authorization ID (AUTH_ID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status (CONSENT_STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|denied|pending|revoked');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `result_release_date` SET TAGS ('dbx_business_glossary_term' = 'Result Release Date (RESULT_DATE)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `clinical_interpretation` SET TAGS ('dbx_business_glossary_term' = 'Clinical Interpretation (INTERPRETATION)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `report_url` SET TAGS ('dbx_business_glossary_term' = 'Report URL (REPORT_URL)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `ordering_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Facility Identifier (FAC_ID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `ordering_location_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Location Identifier (LOC_ID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `patient_dob` SET TAGS ('dbx_business_glossary_term' = 'Patient Date of Birth (DOB)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `patient_dob` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `patient_dob` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `patient_gender` SET TAGS ('dbx_business_glossary_term' = 'Patient Gender (GENDER)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `patient_gender` SET TAGS ('dbx_value_regex' = 'male|female|other|unknown');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `patient_race` SET TAGS ('dbx_business_glossary_term' = 'Patient Race (RACE)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `patient_ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Patient Ethnicity (ETHNICITY)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `patient_address` SET TAGS ('dbx_business_glossary_term' = 'Patient Address (ADDRESS)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `patient_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `patient_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `patient_phone` SET TAGS ('dbx_business_glossary_term' = 'Patient Phone Number (PHONE)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `patient_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `patient_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `patient_email` SET TAGS ('dbx_business_glossary_term' = 'Patient Email Address (EMAIL)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `patient_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `patient_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `patient_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `clinical_trial_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Identifier (TRIAL_ID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Identifier (STUDY_ID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `is_clinical_trial` SET TAGS ('dbx_business_glossary_term' = 'Is Clinical Trial (IS_TRIAL)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `is_research` SET TAGS ('dbx_business_glossary_term' = 'Is Research Order (IS_RESEARCH)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Order Notes (NOTES)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (RETENTION_YRS)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` SET TAGS ('dbx_subdomain' = 'clinical_reporting');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` ALTER COLUMN `precision_medicine_report_id` SET TAGS ('dbx_business_glossary_term' = 'precision_medicine_report Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` ALTER COLUMN `genomic_order_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` ALTER COLUMN `clinical_interpretation_summary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` ALTER COLUMN `clinical_interpretation_summary` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` ALTER COLUMN `genomic_instability_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` ALTER COLUMN `genomic_instability_score` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` ALTER COLUMN `her2_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` ALTER COLUMN `her2_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` ALTER COLUMN `microsatellite_instability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` ALTER COLUMN `microsatellite_instability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` ALTER COLUMN `pdl1_expression_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` ALTER COLUMN `pdl1_expression_score` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` ALTER COLUMN `primary_diagnosis_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` ALTER COLUMN `primary_diagnosis_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` ALTER COLUMN `primary_diagnosis_icd_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` ALTER COLUMN `primary_diagnosis_icd_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` ALTER COLUMN `recommended_therapy` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` ALTER COLUMN `recommended_therapy` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` ALTER COLUMN `therapeutic_implications` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` ALTER COLUMN `therapeutic_implications` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` ALTER COLUMN `tumor_mutational_burden` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` ALTER COLUMN `tumor_mutational_burden` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` ALTER COLUMN `tumor_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` ALTER COLUMN `tumor_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant` SET TAGS ('dbx_subdomain' = 'variant_analysis');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant` ALTER COLUMN `variant_id` SET TAGS ('dbx_business_glossary_term' = 'variant Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant` ALTER COLUMN `reporting_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant` ALTER COLUMN `reporting_notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genome_sequence` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genome_sequence` SET TAGS ('dbx_subdomain' = 'clinical_reporting');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genome_sequence` ALTER COLUMN `genome_sequence_id` SET TAGS ('dbx_business_glossary_term' = 'genome_sequence Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genome_sequence` ALTER COLUMN `genomic_order_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genome_sequence` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genome_sequence` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genome_sequence` ALTER COLUMN `specimen_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genome_sequence` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genome_sequence` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genome_sequence` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genome_sequence` ALTER COLUMN `ethnicity_reported` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genome_sequence` ALTER COLUMN `ethnicity_reported` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genome_sequence` ALTER COLUMN `icd10_indication_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genome_sequence` ALTER COLUMN `icd10_indication_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genome_sequence` ALTER COLUMN `interpretation_summary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genome_sequence` ALTER COLUMN `interpretation_summary` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genome_sequence` ALTER COLUMN `sex_at_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genome_sequence` ALTER COLUMN `sex_at_birth` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`gene_expression` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`gene_expression` SET TAGS ('dbx_subdomain' = 'variant_analysis');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`gene_expression` ALTER COLUMN `gene_expression_id` SET TAGS ('dbx_business_glossary_term' = 'gene_expression Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`gene_expression` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`gene_expression` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`gene_expression` ALTER COLUMN `interpretation_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`gene_expression` ALTER COLUMN `interpretation_notes` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`clinical_genomics_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`clinical_genomics_report` SET TAGS ('dbx_subdomain' = 'clinical_reporting');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`clinical_genomics_report` ALTER COLUMN `clinical_genomics_report_id` SET TAGS ('dbx_business_glossary_term' = 'clinical_genomics_report Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`clinical_genomics_report` ALTER COLUMN `genomic_order_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`clinical_genomics_report` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`clinical_genomics_report` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`clinical_genomics_report` ALTER COLUMN `clinical_interpretation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`clinical_genomics_report` ALTER COLUMN `clinical_interpretation` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`clinical_genomics_report` ALTER COLUMN `genetic_findings_summary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`clinical_genomics_report` ALTER COLUMN `genetic_findings_summary` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`clinical_genomics_report` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`clinical_genomics_report` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` SET TAGS ('dbx_subdomain' = 'sequencing_operations');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `genomics_genomic_order_id` SET TAGS ('dbx_business_glossary_term' = 'genomics_genomic_order Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Facility Identifier (FAC_ID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cdm Entry Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Identifier (TRIAL_ID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider Identifier (PROV_ID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `clinician_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `genomic_order_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Order ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `genomics_genomic_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Consent Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `hipaa_retention_annotation_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Annotation Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Indication Diagnosis Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (PAT_ID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `order_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Authorization ID (AUTH_ID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `provider_location_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Location Identifier (LOC_ID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Identifier (STUDY_ID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Specimen Identifier (SPEC_ID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `trading_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `accession_number` SET TAGS ('dbx_business_glossary_term' = 'Accession Number (ACC_NUM)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `clinical_interpretation` SET TAGS ('dbx_business_glossary_term' = 'Clinical Interpretation (INTERPRETATION)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `collection_date` SET TAGS ('dbx_business_glossary_term' = 'Specimen Collection Date (COLL_DATE)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY|AUD');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `is_clinical_trial` SET TAGS ('dbx_business_glossary_term' = 'Is Clinical Trial (IS_TRIAL)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `is_research` SET TAGS ('dbx_business_glossary_term' = 'Is Research Order (IS_RESEARCH)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Order Notes (NOTES)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `order_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Amount (AMOUNT)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number (ORD_NUM)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status (STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|in_progress|completed|cancelled|rejected');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `order_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Timestamp (ORDER_TS)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `report_url` SET TAGS ('dbx_business_glossary_term' = 'Report URL (REPORT_URL)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `result_release_date` SET TAGS ('dbx_business_glossary_term' = 'Result Release Date (RESULT_DATE)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status (RESULT_STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `result_status` SET TAGS ('dbx_value_regex' = 'pending|available|failed');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (RETENTION_YRS)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `test_priority` SET TAGS ('dbx_business_glossary_term' = 'Test Priority (PRIORITY)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `test_priority` SET TAGS ('dbx_value_regex' = 'routine|stat|urgent');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Genomic Test Type (TEST_TYPE)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` SET TAGS ('dbx_subdomain' = 'sequencing_operations');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `genomics_sequencing_run_id` SET TAGS ('dbx_business_glossary_term' = 'genomics_sequencing_run Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Center ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `genomics_genomic_order_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Sample ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `specimen_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `genomics_specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Specimen Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `hipaa_retention_annotation_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Annotation Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Kit Material Master Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `sequencing_run_id` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Run ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Supervising Clinician Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `chemistry_version` SET TAGS ('dbx_business_glossary_term' = 'Chemistry Version');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `compliance_retention_days` SET TAGS ('dbx_business_glossary_term' = 'Compliance Retention Days');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `control_type` SET TAGS ('dbx_business_glossary_term' = 'Control Type');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `control_type` SET TAGS ('dbx_value_regex' = 'positive|negative|none');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `data_path` SET TAGS ('dbx_business_glossary_term' = 'Data Path');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `data_retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Policy');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run End Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `flowcell_code` SET TAGS ('dbx_business_glossary_term' = 'Flowcell ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `flowcell_type` SET TAGS ('dbx_business_glossary_term' = 'Flowcell Type');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `is_control_run` SET TAGS ('dbx_business_glossary_term' = 'Control Run Flag');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `lane_count` SET TAGS ('dbx_business_glossary_term' = 'Lane Count');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `library_prep_kit` SET TAGS ('dbx_business_glossary_term' = 'Library Preparation Kit');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `library_prep_kit_version` SET TAGS ('dbx_business_glossary_term' = 'Library Prep Kit Version');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `mean_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Mean Quality Score');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Run Notes');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `percent_q30` SET TAGS ('dbx_business_glossary_term' = 'Percent Q30');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `qc_pass` SET TAGS ('dbx_business_glossary_term' = 'QC Pass Flag');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `read_length` SET TAGS ('dbx_business_glossary_term' = 'Read Length (bp)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `run_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Run Duration (Seconds)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `run_identifier` SET TAGS ('dbx_business_glossary_term' = 'Run Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `run_location` SET TAGS ('dbx_business_glossary_term' = 'Run Location');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `run_project_code` SET TAGS ('dbx_business_glossary_term' = 'Run Project Code');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Run Status');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'pending|running|completed|failed|canceled');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Run Type');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `run_type` SET TAGS ('dbx_value_regex' = 'whole_genome|exome|targeted|rna_seq');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Start Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `total_bases` SET TAGS ('dbx_business_glossary_term' = 'Total Bases');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `total_reads` SET TAGS ('dbx_business_glossary_term' = 'Total Reads');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ALTER COLUMN `yield_gb` SET TAGS ('dbx_business_glossary_term' = 'Yield (GB)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` SET TAGS ('dbx_subdomain' = 'sequencing_operations');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `genomics_genomic_sequence_id` SET TAGS ('dbx_business_glossary_term' = 'genomics_genomic_sequence Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `genomic_sequence_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Sequence ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `genomics_genomic_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `genomics_sequencing_run_id` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Run Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `hipaa_retention_annotation_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Annotation Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `specimen_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `alignment_parameters` SET TAGS ('dbx_business_glossary_term' = 'Alignment Parameters');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `alignment_tool` SET TAGS ('dbx_business_glossary_term' = 'Alignment Tool');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `alignment_tool` SET TAGS ('dbx_value_regex' = 'BWA|Bowtie2|STAR|Minimap2');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `assay_type` SET TAGS ('dbx_business_glossary_term' = 'Assay Type');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `assay_type` SET TAGS ('dbx_value_regex' = 'Whole_Genome|Whole_Exome|Targeted|RNA-Seq|Methylation');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `checksum` SET TAGS ('dbx_business_glossary_term' = 'File Checksum (SHA-256)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `checksum` SET TAGS ('dbx_value_regex' = '^[a-fA-F0-9]{64}$');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `coverage_depth` SET TAGS ('dbx_business_glossary_term' = 'Coverage Depth (X)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `data_retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Policy');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `data_retention_policy` SET TAGS ('dbx_value_regex' = '7_years|indefinite|custom');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'EHR|LIS|External|Research');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `effective_to` SET TAGS ('dbx_business_glossary_term' = 'Effective To Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'FASTQ|BAM|CRAM|VCF|FASTA');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `file_path` SET TAGS ('dbx_business_glossary_term' = 'File Path');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `genomic_build_version` SET TAGS ('dbx_business_glossary_term' = 'Genomic Build Version');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `genomics_genomic_sequence_status` SET TAGS ('dbx_business_glossary_term' = 'Sequence Status');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `genomics_genomic_sequence_status` SET TAGS ('dbx_value_regex' = 'available|archived|pending|failed|withdrawn');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `is_primary_sequence` SET TAGS ('dbx_business_glossary_term' = 'Primary Sequence Flag');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Sequence Notes');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `privacy_classification` SET TAGS ('dbx_business_glossary_term' = 'Privacy Classification');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `privacy_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|public');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `quality_score_mean` SET TAGS ('dbx_business_glossary_term' = 'Mean Quality Score');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `read_length_mean` SET TAGS ('dbx_business_glossary_term' = 'Mean Read Length');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `reference_genome` SET TAGS ('dbx_business_glossary_term' = 'Reference Genome');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `sequence_type` SET TAGS ('dbx_business_glossary_term' = 'Sequence Type');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `sequence_type` SET TAGS ('dbx_value_regex' = 'raw|processed|aligned|variant_call|consensus');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `sequencing_date` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Date');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `sequencing_platform` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Platform');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `sequencing_platform` SET TAGS ('dbx_value_regex' = 'Illumina|PacBio|Oxford_Nanopore|Ion_Torrent|BGI');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `total_reads` SET TAGS ('dbx_business_glossary_term' = 'Total Reads');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` SET TAGS ('dbx_subdomain' = 'clinical_reporting');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` SET TAGS ('dbx_delta_tuneFileSizesForRewrites' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` SET TAGS ('dbx_delta_autoOptimize_optimizeWrite' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` SET TAGS ('dbx_hipaa_retention_years' = '10');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` SET TAGS ('dbx_scd_type' = '2');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `genomic_report_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Report Identifier (GRID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `cda_document_id` SET TAGS ('dbx_business_glossary_term' = 'Cda Document Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `clinician_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `genomic_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Test Result Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `genomics_genomic_order_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `hipaa_retention_annotation_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Annotation Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `molecular_test_id` SET TAGS ('dbx_business_glossary_term' = 'Molecular Test Identifier (MTID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `primary_genomic_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider Identifier (OPID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `radiology_study_id` SET TAGS ('dbx_business_glossary_term' = 'Radiology Study Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Care Site Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Diagnosis Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `bioinformatics_pipeline` SET TAGS ('dbx_business_glossary_term' = 'Bioinformatics Pipeline (BP)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `clinical_significance` SET TAGS ('dbx_business_glossary_term' = 'Clinical Significance (CS)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `clinical_significance` SET TAGS ('dbx_value_regex' = 'pathogenic|likely_pathogenic|uncertain|likely_benign|benign');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `collection_date` SET TAGS ('dbx_business_glossary_term' = 'Specimen Collection Date (SCD)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `collection_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level (CL)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'restricted|confidential|public');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `coverage_depth` SET TAGS ('dbx_business_glossary_term' = 'Average Coverage Depth (ACD)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (RCT)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `delta_table_properties` SET TAGS ('dbx_business_glossary_term' = 'Delta Table Properties (DTP)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `interpretation_text` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Text (IT)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `quality_metric` SET TAGS ('dbx_business_glossary_term' = 'Quality Metric (QM)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `recommendation_text` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Text (RTX)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `report_date` SET TAGS ('dbx_business_glossary_term' = 'Report Date (RD)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `report_date` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `report_format` SET TAGS ('dbx_business_glossary_term' = 'Report Format (RF)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `report_format` SET TAGS ('dbx_value_regex' = 'pdf|html|xml');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `report_language` SET TAGS ('dbx_business_glossary_term' = 'Report Language (RL)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status (RS)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'draft|final|amended|retracted');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type (RT)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `report_type` SET TAGS ('dbx_value_regex' = 'clinical|research|screening');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `report_version` SET TAGS ('dbx_business_glossary_term' = 'Report Version (RV)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (RPY)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RSK)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `sequencing_platform` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Platform (SP)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `sequencing_platform` SET TAGS ('dbx_value_regex' = 'illumina|ion_torrent|pacbio|nanopore');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `signoff_pathologist_name` SET TAGS ('dbx_business_glossary_term' = 'Signoff Pathologist Name (SPN)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `signoff_pathologist_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `signoff_pathologist_name` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `signoff_pathologist_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `signoff_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Signoff Timestamp (ST)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `specimen_type` SET TAGS ('dbx_business_glossary_term' = 'Specimen Type (ST)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `specimen_type` SET TAGS ('dbx_value_regex' = 'blood|saliva|tissue|buccal|urine');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (RUT)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `variant_summary` SET TAGS ('dbx_business_glossary_term' = 'Variant Summary (VS)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `patient_name` SET TAGS ('dbx_business_glossary_term' = 'Patient Full Name (PN)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `patient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `patient_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `ordering_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider Identifier (OPID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `ordering_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider Name (OPN)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Specimen Identifier (SID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `signoff_pathologist_id` SET TAGS ('dbx_business_glossary_term' = 'Signoff Pathologist Identifier (SPI)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ALTER COLUMN `hipaa_retention_annotation` SET TAGS ('dbx_business_glossary_term' = 'HIPAA Retention Annotation (HRA)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` SET TAGS ('dbx_subdomain' = 'precision_therapeutics');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `genomics_genomic_consent_id` SET TAGS ('dbx_business_glossary_term' = 'genomics_genomic_consent Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `consent_form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Document ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Consenting Clinician Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `data_sharing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Agreement Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `genomic_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Consent ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `genomics_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `genomics_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `genomics_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `consent_given_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Given Date');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `consent_notes` SET TAGS ('dbx_business_glossary_term' = 'Consent Notes');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `consent_number` SET TAGS ('dbx_business_glossary_term' = 'Consent Number');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `consent_scope` SET TAGS ('dbx_business_glossary_term' = 'Consent Scope');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `consent_scope` SET TAGS ('dbx_value_regex' = 'research|clinical|both');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'active|revoked|expired|pending');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `given_by` SET TAGS ('dbx_business_glossary_term' = 'Consent Given By (Name)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `given_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `given_by` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `given_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Revocation Date');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `signature_method` SET TAGS ('dbx_business_glossary_term' = 'Signature Method');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `signature_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|phone|mail');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Signature Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` SET TAGS ('dbx_subdomain' = 'clinical_reporting');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `genomics_patient_genomic_profile_id` SET TAGS ('dbx_business_glossary_term' = 'genomics_patient_genomic_profile Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `genomic_report_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Report Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `genomics_genomic_sequence_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Sequence Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `genomics_report_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Report ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Managing Clinician Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `patient_genomic_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Genomic Profile ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Center Care Site Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `actionability_flag` SET TAGS ('dbx_business_glossary_term' = 'Actionability Flag');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `actionability_summary` SET TAGS ('dbx_business_glossary_term' = 'Actionability Summary');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `clinical_interpretation_date` SET TAGS ('dbx_business_glossary_term' = 'Clinical Interpretation Date');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `clinical_interpretation_summary` SET TAGS ('dbx_business_glossary_term' = 'Clinical Interpretation Summary');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `clinical_trial_association` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Association');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `clinical_trial_end_date` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial End Date');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `clinical_trial_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Enrollment Date');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `clinical_trial_status` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Status');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `clinical_trial_status` SET TAGS ('dbx_value_regex' = 'enrolled|completed|withdrawn');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'consented|revoked|pending');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `data_retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Years)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `genomic_reference_genome` SET TAGS ('dbx_business_glossary_term' = 'Reference Genome Build');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `genomic_sequencing_date` SET TAGS ('dbx_business_glossary_term' = 'Genomic Sequencing Date');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `genomic_sequencing_method` SET TAGS ('dbx_business_glossary_term' = 'Genomic Sequencing Method');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `genomic_sequencing_method` SET TAGS ('dbx_value_regex' = 'NGS|WES|WGS');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `interpretation_confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Confidence Level');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `interpretation_confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `interpretation_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Confidence Score');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `patient_age_at_sequencing` SET TAGS ('dbx_business_glossary_term' = 'Patient Age at Sequencing');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `patient_age_at_sequencing` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `patient_ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Patient Ethnicity');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `patient_ethnicity` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `patient_family_history_flag` SET TAGS ('dbx_business_glossary_term' = 'Family History Flag');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `patient_race` SET TAGS ('dbx_business_glossary_term' = 'Patient Race');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `patient_race` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `patient_sex` SET TAGS ('dbx_business_glossary_term' = 'Patient Sex');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `patient_sex` SET TAGS ('dbx_value_regex' = 'male|female|other|unknown');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `patient_sex` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `profile_creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `profile_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Profile Effective Date');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `profile_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Profile Expiration Date');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `profile_last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Last Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_business_glossary_term' = 'Profile Name');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Profile Status');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|pending');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `profile_type` SET TAGS ('dbx_business_glossary_term' = 'Profile Type');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `profile_type` SET TAGS ('dbx_value_regex' = 'germline|somatic|clinical');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `profile_version` SET TAGS ('dbx_business_glossary_term' = 'Profile Version');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `report_release_date` SET TAGS ('dbx_business_glossary_term' = 'Report Release Date');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `report_url` SET TAGS ('dbx_business_glossary_term' = 'Report URL');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `report_version` SET TAGS ('dbx_business_glossary_term' = 'Report Version');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'low|moderate|high|very_high');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ALTER COLUMN `risk_stratification_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Stratification Score');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` SET TAGS ('dbx_subdomain' = 'variant_analysis');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` SET TAGS ('dbx_delta_tuneFileSizesForRewrites' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` SET TAGS ('dbx_delta_autoOptimize_optimizeWrite' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` SET TAGS ('dbx_hipaa_retention_years' = '10');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` SET TAGS ('dbx_scd_type' = '2');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `genomic_interpretation_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Interpretation ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Facility ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `clinician_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Related Diagnosis Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `genomic_report_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Report Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `genomic_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Test ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `clinical_actionability` SET TAGS ('dbx_business_glossary_term' = 'Clinical Actionability');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `clinical_significance` SET TAGS ('dbx_business_glossary_term' = 'Clinical Significance');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `clinical_significance` SET TAGS ('dbx_value_regex' = 'pathogenic|likely_pathogenic|uncertain|likely_benign|benign');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `evidence_level` SET TAGS ('dbx_business_glossary_term' = 'Evidence Level');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `evidence_level` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `evidence_score` SET TAGS ('dbx_business_glossary_term' = 'Evidence Score');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `gene_symbol` SET TAGS ('dbx_business_glossary_term' = 'Gene Symbol');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `hipaa_retention_years` SET TAGS ('dbx_business_glossary_term' = 'HIPAA Retention Period (Years)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `interpretation_date` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Date');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `interpretation_status` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Status');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `interpretation_status` SET TAGS ('dbx_value_regex' = 'draft|pending|final|retracted');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `interpretation_summary` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Summary');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `interpretation_text` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Text');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `interpretation_type` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Type');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `interpretation_type` SET TAGS ('dbx_value_regex' = 'diagnostic|prognostic|pharmacogenomic|research');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `interpretation_version` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Version Number');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `phenotype_relevance` SET TAGS ('dbx_business_glossary_term' = 'Phenotype Relevance');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `recommended_pathway` SET TAGS ('dbx_business_glossary_term' = 'Recommended Care Pathway');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `report_date` SET TAGS ('dbx_business_glossary_term' = 'Report Date');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `supporting_evidence_codes` SET TAGS ('dbx_business_glossary_term' = 'Supporting Evidence Codes');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `variant_count` SET TAGS ('dbx_business_glossary_term' = 'Variant Count');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `genomic_test_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Test ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `ordering_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `ordering_provider_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `ordering_provider_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ALTER COLUMN `lab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Facility ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` SET TAGS ('dbx_subdomain' = 'variant_analysis');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` SET TAGS ('dbx_delta_tuneFileSizesForRewrites' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` SET TAGS ('dbx_delta_autoOptimize_optimizeWrite' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` SET TAGS ('dbx_hipaa_retention_years' = '10');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` SET TAGS ('dbx_scd_type' = '2');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `genomic_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Test Result ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider ID (OPID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Sample ID (SID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `genomic_specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Specimen Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `genomics_genomic_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Consent ID (CID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `genomics_genomic_order_id` SET TAGS ('dbx_business_glossary_term' = 'Test Order ID (TOID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `genomics_report_id` SET TAGS ('dbx_business_glossary_term' = 'External Report ID (ERID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory ID (LID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID (PID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Care Site Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `billing_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Code (BC)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `billing_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `clinical_significance` SET TAGS ('dbx_business_glossary_term' = 'Clinical Significance (CS)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `clinical_significance` SET TAGS ('dbx_value_regex' = 'pathogenic|likely_pathogenic|benign|likely_benign|uncertain_significance');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score (CS)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `coverage_depth` SET TAGS ('dbx_business_glossary_term' = 'Coverage Depth (CD)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `interpretation_summary` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Summary (IS)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `is_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Result Confirmation Flag (RCF)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `is_retest_needed` SET TAGS ('dbx_business_glossary_term' = 'Retest Needed Flag (RNF)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Result Notes (RN)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `report_url` SET TAGS ('dbx_business_glossary_term' = 'Report URL (RURL)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `result_code` SET TAGS ('dbx_business_glossary_term' = 'Result Code (RC)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `result_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `result_date` SET TAGS ('dbx_business_glossary_term' = 'Result Date (RD)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `result_description` SET TAGS ('dbx_business_glossary_term' = 'Result Description (RD)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status (RS)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `result_status` SET TAGS ('dbx_value_regex' = 'final|preliminary|pending|canceled');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `result_version` SET TAGS ('dbx_business_glossary_term' = 'Result Version (RV)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `specimen_type` SET TAGS ('dbx_business_glossary_term' = 'Specimen Type (ST)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `specimen_type` SET TAGS ('dbx_value_regex' = 'blood|saliva|tissue');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type (TT)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'whole_genome|exome|targeted_panel|pharmacogenomics');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `turnaround_time_days` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time (TT)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `test_order_id` SET TAGS ('dbx_business_glossary_term' = 'Test Order ID (TOID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID (PID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Provider ID (OPID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `lab_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory ID (LID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `consent_id` SET TAGS ('dbx_business_glossary_term' = 'Consent ID (CID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `external_report_id` SET TAGS ('dbx_business_glossary_term' = 'External Report ID (ERID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample ID (SID)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ALTER COLUMN `sample_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8}$');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` SET TAGS ('dbx_subdomain' = 'precision_therapeutics');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` SET TAGS ('dbx_delta_tuneFileSizesForRewrites' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` SET TAGS ('dbx_delta_autoOptimize_optimizeWrite' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` SET TAGS ('dbx_hipaa_retention_years' = '10');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` SET TAGS ('dbx_scd_type' = '2');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `precision_trial_enroll_id` SET TAGS ('dbx_business_glossary_term' = 'Precision Trial Enrollment ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Investigator (Provider) ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Coordinator Employee Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `genomic_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Test Result Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `genomics_genomic_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Consent Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `population_health_cohort_cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort Definition Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `population_health_cohort_cohort_definition_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `population_health_cohort_cohort_definition_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `research_clinical_trial_matching_eligibility_evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Evaluation Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `research_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Research Consent Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `study_site_id` SET TAGS ('dbx_business_glossary_term' = 'Site (Facility) ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date (CNS_DT)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `consent_given` SET TAGS ('dbx_business_glossary_term' = 'Consent Given (CNS_GVN)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Cost Amount (COST_AMT)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `cost_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `cost_amount` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp (CRT_TS)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (DISC_AMT)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `discount_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `discount_amount` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFF_FROM)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFF_UNTIL)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `eligibility_criteria_version` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria Version (ELG_VER)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status (ELG_STS)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'met|not_met|pending_review');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Event Timestamp (ENR_TS)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number (ENR)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source (ENR_SRC)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'referral|self|physician|research_staff');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status (ENR_STS)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'pending|eligible|ineligible|withdrawn|completed');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Type (ENR_TYP)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_value_regex' = 'screening|full|followup');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Date (FUP_DT)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Required (FUP_REQ)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount (NET_AMT)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `net_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `net_amount` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes (ENR_NOTES)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `protocol_version` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version (PROTO_VER)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `randomization_group` SET TAGS ('dbx_business_glossary_term' = 'Randomization Group (RAND_GRP)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `randomization_group` SET TAGS ('dbx_value_regex' = 'control|treatment|placebo');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp (UPD_TS)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site (Facility) ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Investigator (Provider) ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Document Version (CNS_VER)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `biomarker_status` SET TAGS ('dbx_business_glossary_term' = 'Biomarker Status (BMK_STS)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ALTER COLUMN `biomarker_status` SET TAGS ('dbx_value_regex' = 'positive|negative|unknown');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` SET TAGS ('dbx_subdomain' = 'sequencing_operations');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` SET TAGS ('dbx_delta_tuneFileSizesForRewrites' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` SET TAGS ('dbx_delta_autoOptimize_optimizeWrite' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` SET TAGS ('dbx_hipaa_retention_years' = '7');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` SET TAGS ('dbx_scd_type' = '1');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `genomic_quality_control_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Quality Control ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `acceptable_range_lower` SET TAGS ('dbx_business_glossary_term' = 'Acceptable Range Lower Bound');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `acceptable_range_upper` SET TAGS ('dbx_business_glossary_term' = 'Acceptable Range Upper Bound');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `applicable_platform` SET TAGS ('dbx_business_glossary_term' = 'Applicable Platform');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `applicable_platform` SET TAGS ('dbx_value_regex' = 'Illumina|PacBio|OxfordNanopore');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `applicable_sample_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Sample Type');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `applicable_sample_type` SET TAGS ('dbx_value_regex' = 'DNA|RNA|FFPE|Fresh');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `applicable_sequencing_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Sequencing Type');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `applicable_sequencing_type` SET TAGS ('dbx_value_regex' = 'WGS|WES|RNA-Seq|Targeted');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `genomic_quality_control_status` SET TAGS ('dbx_business_glossary_term' = 'Metric Status');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `genomic_quality_control_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `is_deprecated` SET TAGS ('dbx_business_glossary_term' = 'Is Deprecated');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `last_validated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Validated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `metric_category` SET TAGS ('dbx_business_glossary_term' = 'Metric Category');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `metric_category` SET TAGS ('dbx_value_regex' = 'quality|coverage|contamination|alignment|variant|expression');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `metric_code` SET TAGS ('dbx_business_glossary_term' = 'Metric Code');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `metric_description` SET TAGS ('dbx_business_glossary_term' = 'Metric Description');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `metric_name` SET TAGS ('dbx_business_glossary_term' = 'Metric Name');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `metric_type` SET TAGS ('dbx_business_glossary_term' = 'Metric Type');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `metric_type` SET TAGS ('dbx_value_regex' = 'numeric|boolean|categorical');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `retention_policy` SET TAGS ('dbx_value_regex' = '7_years|indefinite');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|info');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `validation_method` SET TAGS ('dbx_business_glossary_term' = 'Validation Method');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `validation_method` SET TAGS ('dbx_value_regex' = 'automated|manual|mixed');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Metric Version');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Metric Status');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_quality_control` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test` SET TAGS ('dbx_subdomain' = 'sequencing_operations');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test` ALTER COLUMN `genomic_test_id` SET TAGS ('dbx_business_glossary_term' = 'genomic_test Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test` ALTER COLUMN `clinical_significance` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test` ALTER COLUMN `clinical_significance` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test` ALTER COLUMN `icd10_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test` ALTER COLUMN `icd10_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test` ALTER COLUMN `interpretation_narrative` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test` ALTER COLUMN `interpretation_narrative` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test` ALTER COLUMN `result_summary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test` ALTER COLUMN `result_summary` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test` ALTER COLUMN `variants_detected_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test` ALTER COLUMN `variants_detected_count` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequencing_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequencing_result` SET TAGS ('dbx_subdomain' = 'sequencing_operations');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequencing_result` ALTER COLUMN `genomic_sequencing_result_id` SET TAGS ('dbx_business_glossary_term' = 'genomic_sequencing_result Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequencing_result` ALTER COLUMN `sequencing_run_id` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Run Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequencing_result` ALTER COLUMN `clinical_significance_summary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequencing_result` ALTER COLUMN `clinical_significance_summary` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequencing_result` ALTER COLUMN `indication_for_testing` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequencing_result` ALTER COLUMN `indication_for_testing` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequencing_result` ALTER COLUMN `indication_icd_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequencing_result` ALTER COLUMN `indication_icd_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequencing_result` ALTER COLUMN `microsatellite_instability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequencing_result` ALTER COLUMN `microsatellite_instability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequencing_result` ALTER COLUMN `overall_interpretation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequencing_result` ALTER COLUMN `overall_interpretation` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequencing_result` ALTER COLUMN `pathogenicity_classification` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequencing_result` ALTER COLUMN `pathogenicity_classification` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequencing_result` ALTER COLUMN `report_pdf_url` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequencing_result` ALTER COLUMN `report_pdf_url` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequencing_result` ALTER COLUMN `therapy_recommendation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequencing_result` ALTER COLUMN `therapy_recommendation` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequencing_result` ALTER COLUMN `tumor_mutational_burden` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequencing_result` ALTER COLUMN `tumor_mutational_burden` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` SET TAGS ('dbx_subdomain' = 'precision_therapeutics');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ALTER COLUMN `precision_treatment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'precision_treatment_plan Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ALTER COLUMN `best_response` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ALTER COLUMN `best_response` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ALTER COLUMN `cancer_stage` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ALTER COLUMN `cancer_stage` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ALTER COLUMN `contraindication_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ALTER COLUMN `contraindication_notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ALTER COLUMN `microsatellite_instability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ALTER COLUMN `microsatellite_instability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ALTER COLUMN `pdl1_expression_percent` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ALTER COLUMN `pdl1_expression_percent` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ALTER COLUMN `pharmacogenomic_consideration` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ALTER COLUMN `pharmacogenomic_consideration` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ALTER COLUMN `primary_diagnosis_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ALTER COLUMN `primary_diagnosis_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ALTER COLUMN `resistance_mechanism` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ALTER COLUMN `resistance_mechanism` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ALTER COLUMN `target_biomarker` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ALTER COLUMN `target_biomarker` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ALTER COLUMN `treatment_cycle_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ALTER COLUMN `treatment_cycle_count` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ALTER COLUMN `treatment_duration_days` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ALTER COLUMN `treatment_duration_days` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ALTER COLUMN `tumor_mutation_burden` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ALTER COLUMN `tumor_mutation_burden` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ALTER COLUMN `variant_classification` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ALTER COLUMN `variant_classification` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_data` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_data` SET TAGS ('dbx_subdomain' = 'sequencing_operations');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_data` ALTER COLUMN `sequencing_data_id` SET TAGS ('dbx_business_glossary_term' = 'sequencing_data Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_data` ALTER COLUMN `genomic_order_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_data` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_data` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_data` ALTER COLUMN `specimen_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_data` ALTER COLUMN `specimen_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_data` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_data` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_data` ALTER COLUMN `data_file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_data` ALTER COLUMN `icd10_indication_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_data` ALTER COLUMN `icd10_indication_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_data` ALTER COLUMN `tissue_source` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_data` ALTER COLUMN `tissue_source` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence_data` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence_data` SET TAGS ('dbx_subdomain' = 'sequencing_operations');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence_data` ALTER COLUMN `sequence_data_id` SET TAGS ('dbx_business_glossary_term' = 'sequence_data Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence_data` ALTER COLUMN `genomic_order_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence_data` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence_data` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence_data` ALTER COLUMN `icd10_indication_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence_data` ALTER COLUMN `icd10_indication_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence_data` ALTER COLUMN `interpretation_summary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence_data` ALTER COLUMN `interpretation_summary` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence` SET TAGS ('dbx_subdomain' = 'sequencing_operations');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence` ALTER COLUMN `sequence_id` SET TAGS ('dbx_business_glossary_term' = 'sequence Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence` ALTER COLUMN `indication_icd_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence` ALTER COLUMN `indication_icd_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`assay` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`assay` SET TAGS ('dbx_subdomain' = 'sequencing_operations');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`assay` ALTER COLUMN `assay_id` SET TAGS ('dbx_business_glossary_term' = 'assay Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_report` SET TAGS ('dbx_subdomain' = 'clinical_reporting');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_report` ALTER COLUMN `genomics_report_id` SET TAGS ('dbx_business_glossary_term' = 'genomics_report Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_report` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_report` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_report` ALTER COLUMN `accession_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_report` ALTER COLUMN `accession_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_report` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_report` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_report` ALTER COLUMN `indication_icd_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_report` ALTER COLUMN `indication_icd_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_report` ALTER COLUMN `interpretation_summary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_report` ALTER COLUMN `interpretation_summary` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_report` ALTER COLUMN `microsatellite_instability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_report` ALTER COLUMN `microsatellite_instability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_report` ALTER COLUMN `overall_interpretation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_report` ALTER COLUMN `overall_interpretation` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_report` ALTER COLUMN `pdf_document_url` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_report` ALTER COLUMN `pdf_document_url` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_report` ALTER COLUMN `therapy_recommendation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_report` ALTER COLUMN `therapy_recommendation` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_report` ALTER COLUMN `tumor_cellularity_percent` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_report` ALTER COLUMN `tumor_cellularity_percent` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_report` ALTER COLUMN `tumor_mutational_burden` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_report` ALTER COLUMN `tumor_mutational_burden` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`phenotype_association` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`phenotype_association` SET TAGS ('dbx_subdomain' = 'variant_analysis');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`phenotype_association` ALTER COLUMN `phenotype_association_id` SET TAGS ('dbx_business_glossary_term' = 'phenotype_association Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`phenotype_association` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`phenotype_association` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` SET TAGS ('dbx_subdomain' = 'variant_analysis');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ALTER COLUMN `variant_call_id` SET TAGS ('dbx_business_glossary_term' = 'variant_call Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ALTER COLUMN `allele_frequency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ALTER COLUMN `allele_frequency` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ALTER COLUMN `alternate_allele` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ALTER COLUMN `alternate_allele` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ALTER COLUMN `associated_condition` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ALTER COLUMN `associated_condition` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ALTER COLUMN `chromosome` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ALTER COLUMN `chromosome` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ALTER COLUMN `clinical_significance` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ALTER COLUMN `clinical_significance` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ALTER COLUMN `end_position` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ALTER COLUMN `end_position` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ALTER COLUMN `gene_symbol` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ALTER COLUMN `gene_symbol` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ALTER COLUMN `genomic_position` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ALTER COLUMN `genomic_position` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ALTER COLUMN `genotype` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ALTER COLUMN `genotype` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ALTER COLUMN `hgvs_coding` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ALTER COLUMN `hgvs_coding` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ALTER COLUMN `hgvs_protein` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ALTER COLUMN `hgvs_protein` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ALTER COLUMN `reference_allele` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ALTER COLUMN `reference_allele` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ALTER COLUMN `review_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ALTER COLUMN `review_notes` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ALTER COLUMN `somatic_germline_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ALTER COLUMN `somatic_germline_status` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ALTER COLUMN `therapeutic_implication` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ALTER COLUMN `therapeutic_implication` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ALTER COLUMN `zygosity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ALTER COLUMN `zygosity` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_order` SET TAGS ('dbx_subdomain' = 'sequencing_operations');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_order` ALTER COLUMN `genomic_test_order_id` SET TAGS ('dbx_business_glossary_term' = 'genomic_test_order Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_order` ALTER COLUMN `microsatellite_instability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_order` ALTER COLUMN `microsatellite_instability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_order` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_order` ALTER COLUMN `notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_order` ALTER COLUMN `overall_interpretation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_order` ALTER COLUMN `overall_interpretation` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_order` ALTER COLUMN `pathogenicity_classification` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_order` ALTER COLUMN `pathogenicity_classification` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_order` ALTER COLUMN `treatment_impact_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_order` ALTER COLUMN `treatment_impact_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_order` ALTER COLUMN `tumor_mutational_burden` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_order` ALTER COLUMN `tumor_mutational_burden` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` SET TAGS ('dbx_subdomain' = 'clinical_reporting');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `patient_genomic_study_id` SET TAGS ('dbx_business_glossary_term' = 'patient_genomic_study Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `genomic_order_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `research_document_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `research_document_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `actionable_finding_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `actionable_finding_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `care_pathway_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `care_pathway_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `indication` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `indication` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `indication_icd_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `indication_icd_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `insurance_authorization_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `insurance_authorization_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `microsatellite_instability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `microsatellite_instability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `overall_interpretation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `overall_interpretation` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `pathogenic_variant_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `pathogenic_variant_count` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `result_summary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `result_summary` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `secondary_findings_reported_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `secondary_findings_reported_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `specimen_source_site` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `specimen_source_site` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `tumor_mutational_burden` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `tumor_mutational_burden` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `vous_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ALTER COLUMN `vous_count` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`test_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`test_order` SET TAGS ('dbx_subdomain' = 'sequencing_operations');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`test_order` ALTER COLUMN `test_order_id` SET TAGS ('dbx_business_glossary_term' = 'test_order Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`test_order` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`test_order` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`test_order` ALTER COLUMN `actionable_finding` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`test_order` ALTER COLUMN `actionable_finding` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`test_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`test_order` ALTER COLUMN `clinical_indication` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`test_order` ALTER COLUMN `clinical_significance` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`test_order` ALTER COLUMN `clinical_significance` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`test_order` ALTER COLUMN `family_history_relevant` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`test_order` ALTER COLUMN `family_history_relevant` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`test_order` ALTER COLUMN `indication_icd_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`test_order` ALTER COLUMN `indication_icd_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`test_order` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`test_order` ALTER COLUMN `notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_test_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_test_result` SET TAGS ('dbx_subdomain' = 'variant_analysis');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_test_result` ALTER COLUMN `genomics_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'genomics_test_result Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_test_result` ALTER COLUMN `genomic_order_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_test_result` ALTER COLUMN `clinical_significance` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_test_result` ALTER COLUMN `clinical_significance` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_test_result` ALTER COLUMN `hereditary_risk_category` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_test_result` ALTER COLUMN `hereditary_risk_category` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_test_result` ALTER COLUMN `microsatellite_instability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_test_result` ALTER COLUMN `microsatellite_instability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_test_result` ALTER COLUMN `overall_interpretation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_test_result` ALTER COLUMN `overall_interpretation` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_test_result` ALTER COLUMN `primary_condition_indication` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_test_result` ALTER COLUMN `primary_condition_indication` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_test_result` ALTER COLUMN `result_summary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_test_result` ALTER COLUMN `result_summary` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_test_result` ALTER COLUMN `therapy_implication_summary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_test_result` ALTER COLUMN `therapy_implication_summary` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_test_result` ALTER COLUMN `tumor_mutational_burden` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_test_result` ALTER COLUMN `tumor_mutational_burden` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_profile` SET TAGS ('dbx_subdomain' = 'clinical_reporting');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_profile` ALTER COLUMN `patient_profile_id` SET TAGS ('dbx_business_glossary_term' = 'patient_profile Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_profile` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_profile` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_profile` ALTER COLUMN `ancestry_population` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_profile` ALTER COLUMN `ancestry_population` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_profile` ALTER COLUMN `clinical_significance_summary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_profile` ALTER COLUMN `clinical_significance_summary` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_profile` ALTER COLUMN `hereditary_risk_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_profile` ALTER COLUMN `hereditary_risk_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_profile` ALTER COLUMN `microsatellite_instability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_profile` ALTER COLUMN `microsatellite_instability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_profile` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_profile` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_profile` ALTER COLUMN `overall_interpretation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_profile` ALTER COLUMN `overall_interpretation` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_profile` ALTER COLUMN `primary_condition_indication` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_profile` ALTER COLUMN `primary_condition_indication` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_profile` ALTER COLUMN `tumor_mutational_burden` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_profile` ALTER COLUMN `tumor_mutational_burden` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_data` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_data` SET TAGS ('dbx_subdomain' = 'sequencing_operations');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_data` ALTER COLUMN `genomics_data_id` SET TAGS ('dbx_business_glossary_term' = 'genomics_data Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_data` ALTER COLUMN `genomic_order_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_data` ALTER COLUMN `clinical_significance_summary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_data` ALTER COLUMN `clinical_significance_summary` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_data` ALTER COLUMN `indication_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_data` ALTER COLUMN `indication_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_data` ALTER COLUMN `indication_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_data` ALTER COLUMN `indication_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_data` ALTER COLUMN `microsatellite_instability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_data` ALTER COLUMN `microsatellite_instability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_data` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_data` ALTER COLUMN `notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_data` ALTER COLUMN `overall_interpretation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_data` ALTER COLUMN `overall_interpretation` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_data` ALTER COLUMN `pathogenicity_classification` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_data` ALTER COLUMN `pathogenicity_classification` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_data` ALTER COLUMN `therapy_recommendation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_data` ALTER COLUMN `therapy_recommendation` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_data` ALTER COLUMN `tumor_mutational_burden` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_data` ALTER COLUMN `tumor_mutational_burden` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_data` ALTER COLUMN `tumor_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_data` ALTER COLUMN `tumor_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant_result` SET TAGS ('dbx_subdomain' = 'variant_analysis');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant_result` ALTER COLUMN `genomic_variant_result_id` SET TAGS ('dbx_business_glossary_term' = 'genomic_variant_result Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant_result` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant_result` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant_result` ALTER COLUMN `associated_condition` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant_result` ALTER COLUMN `associated_condition` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant_result` ALTER COLUMN `interpretation_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant_result` ALTER COLUMN `interpretation_notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant_result` ALTER COLUMN `therapeutic_implication` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant_result` ALTER COLUMN `therapeutic_implication` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`pharmacogenomics` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`pharmacogenomics` SET TAGS ('dbx_subdomain' = 'precision_therapeutics');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`pharmacogenomics` ALTER COLUMN `pharmacogenomics_id` SET TAGS ('dbx_business_glossary_term' = 'pharmacogenomics Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`pharmacogenomics` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`pharmacogenomics` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`pharmacogenomics` ALTER COLUMN `activity_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`pharmacogenomics` ALTER COLUMN `activity_score` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`pharmacogenomics` ALTER COLUMN `alternative_drug_recommendation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`pharmacogenomics` ALTER COLUMN `alternative_drug_recommendation` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`pharmacogenomics` ALTER COLUMN `clinical_note` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`pharmacogenomics` ALTER COLUMN `clinical_note` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`pharmacogenomics` ALTER COLUMN `diplotype` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`pharmacogenomics` ALTER COLUMN `diplotype` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`pharmacogenomics` ALTER COLUMN `dosing_guidance` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`pharmacogenomics` ALTER COLUMN `dosing_guidance` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`pharmacogenomics` ALTER COLUMN `ethnicity_context` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`pharmacogenomics` ALTER COLUMN `ethnicity_context` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`pharmacogenomics` ALTER COLUMN `gene_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`pharmacogenomics` ALTER COLUMN `gene_name` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`pharmacogenomics` ALTER COLUMN `phenotype` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`pharmacogenomics` ALTER COLUMN `phenotype` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`pharmacogenomics` ALTER COLUMN `therapeutic_recommendation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`pharmacogenomics` ALTER COLUMN `therapeutic_recommendation` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` SET TAGS ('dbx_subdomain' = 'clinical_reporting');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ALTER COLUMN `genomic_profile_id` SET TAGS ('dbx_business_glossary_term' = 'genomic_profile Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ALTER COLUMN `genomic_order_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ALTER COLUMN `brca_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ALTER COLUMN `brca_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ALTER COLUMN `clinical_significance_summary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ALTER COLUMN `clinical_significance_summary` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ALTER COLUMN `her2_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ALTER COLUMN `her2_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ALTER COLUMN `hereditary_risk_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ALTER COLUMN `hereditary_risk_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ALTER COLUMN `microsatellite_instability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ALTER COLUMN `microsatellite_instability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ALTER COLUMN `overall_interpretation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ALTER COLUMN `overall_interpretation` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ALTER COLUMN `pdl1_expression_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ALTER COLUMN `pdl1_expression_score` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ALTER COLUMN `recommended_therapies` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ALTER COLUMN `recommended_therapies` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ALTER COLUMN `report_pdf_url` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ALTER COLUMN `report_pdf_url` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ALTER COLUMN `resistance_markers` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ALTER COLUMN `resistance_markers` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ALTER COLUMN `tumor_mutational_burden` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ALTER COLUMN `tumor_mutational_burden` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ALTER COLUMN `tumor_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ALTER COLUMN `tumor_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_cohort_qualification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_cohort_qualification` SET TAGS ('dbx_subdomain' = 'precision_therapeutics');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_cohort_qualification` SET TAGS ('dbx_association_edges' = 'genomics.patient_genomic_profile,population_health_cohort_mgmt.cohort_definition');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_cohort_qualification` ALTER COLUMN `genomic_cohort_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Cohort Qualification ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_cohort_qualification` ALTER COLUMN `genomics_patient_genomic_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Cohort Qualification - Patient Genomic Profile Id');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_cohort_qualification` ALTER COLUMN `population_health_cohort_mgmt_cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Cohort Qualification - Cohort Definition Id');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_cohort_qualification` ALTER COLUMN `population_health_cohort_mgmt_cohort_definition_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_cohort_qualification` ALTER COLUMN `population_health_cohort_mgmt_cohort_definition_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_cohort_qualification` ALTER COLUMN `genomic_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Genomic Risk Score');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_cohort_qualification` ALTER COLUMN `genomic_risk_score` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_cohort_qualification` ALTER COLUMN `genomic_risk_score` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_cohort_qualification` ALTER COLUMN `inclusion_confidence` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Confidence');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_cohort_qualification` ALTER COLUMN `qualification_criteria_met` SET TAGS ('dbx_business_glossary_term' = 'Qualification Criteria Met');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_cohort_qualification` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_cohort_inclusion` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_cohort_inclusion` SET TAGS ('dbx_subdomain' = 'precision_therapeutics');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_cohort_inclusion` SET TAGS ('dbx_association_edges' = 'genomics.patient_genomic_profile,population_health_cohort.cohort_definition');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_cohort_inclusion` ALTER COLUMN `genomic_cohort_inclusion_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Cohort Inclusion ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_cohort_inclusion` ALTER COLUMN `genomics_patient_genomic_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Cohort Inclusion - Patient Genomic Profile Id');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_cohort_inclusion` ALTER COLUMN `population_health_cohort_cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Cohort Inclusion - Cohort Definition Id');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_cohort_inclusion` ALTER COLUMN `population_health_cohort_cohort_definition_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_cohort_inclusion` ALTER COLUMN `population_health_cohort_cohort_definition_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_cohort_inclusion` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Cohort Eligibility Status');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_cohort_inclusion` ALTER COLUMN `genomic_criteria_met` SET TAGS ('dbx_business_glossary_term' = 'Genomic Criteria Met');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_cohort_inclusion` ALTER COLUMN `inclusion_date` SET TAGS ('dbx_business_glossary_term' = 'Cohort Inclusion Date');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_cohort_inclusion` ALTER COLUMN `risk_score_at_inclusion` SET TAGS ('dbx_business_glossary_term' = 'Risk Score at Inclusion');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_cohort_inclusion` ALTER COLUMN `risk_score_at_inclusion` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_cohort_inclusion` ALTER COLUMN `risk_score_at_inclusion` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_trial_eligibility_match` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_trial_eligibility_match` SET TAGS ('dbx_subdomain' = 'precision_therapeutics');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_trial_eligibility_match` SET TAGS ('dbx_association_edges' = 'genomics.genomic_test_result,research_clinical_trial_matching.eligibility_criteria');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_trial_eligibility_match` ALTER COLUMN `genomics_trial_eligibility_match_id` SET TAGS ('dbx_business_glossary_term' = 'genomics_trial_eligibility_match Identifier');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_trial_eligibility_match` ALTER COLUMN `genomic_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Trial Eligibility Match - Genomic Test Result Id');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_trial_eligibility_match` ALTER COLUMN `research_clinical_trial_matching_eligibility_criteria_id` SET TAGS ('dbx_business_glossary_term' = 'Trial Eligibility Match - Eligibility Criteria Id');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_trial_eligibility_match` ALTER COLUMN `trial_match_id` SET TAGS ('dbx_business_glossary_term' = 'Trial Eligibility Match ID');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_trial_eligibility_match` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_trial_eligibility_match` ALTER COLUMN `criterion_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Criterion Met Flag');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_trial_eligibility_match` ALTER COLUMN `evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Date');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_trial_eligibility_match` ALTER COLUMN `match_score` SET TAGS ('dbx_business_glossary_term' = 'Match Score');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_trial_eligibility_match` ALTER COLUMN `match_status` SET TAGS ('dbx_business_glossary_term' = 'Match Status');
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_trial_eligibility_match` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
