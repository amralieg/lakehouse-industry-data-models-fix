-- Schema for Domain: reference | Business: Genomics Biotech | Version: v1_ecm
-- Generated on: 2026-05-06 13:04:44

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `genomics_biotech_ecm`.`reference` COMMENT 'Curates and governs reference genomic data assets — reference genome assemblies (GRCh38/hg38, T2T), variant databases (dbSNP, ClinVar, gnomAD), gene annotation tracks, pathway databases, and population allele frequency references (MAF). Ensures versioned, auditable reference data integrity for reproducible genomic analysis, annotation pipelines, and regulatory-grade variant interpretation.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` (
    `genome_assembly_id` BIGINT COMMENT 'Unique identifier for the reference genome assembly record. Primary key.',
    `superseded_by_assembly_genome_assembly_id` BIGINT COMMENT 'Foreign key reference to the genome_assembly_id of the newer assembly that supersedes this one. Null if this assembly is current or has not been superseded.',
    `annotation_version` STRING COMMENT 'Version identifier of the gene annotation track associated with this assembly (e.g., GENCODE v42, Ensembl 109). Gene annotations are versioned independently of the assembly.',
    `assembly_accession` STRING COMMENT 'Official accession identifier assigned by the source authority (NCBI/INSDC format: GCA_ for GenBank, GCF_ for RefSeq). Serves as the globally unique external identifier for this assembly build.. Valid values are `^GC[AF]_[0-9]{9}.[0-9]+$`',
    `assembly_alias` STRING COMMENT 'Alternative or legacy name for the assembly (e.g., hg38 for GRCh38, mm10 for GRCm38). Used for cross-referencing with external tools and historical datasets.',
    `assembly_level` STRING COMMENT 'Degree of completeness and contiguity of the assembly. Chromosome = fully assembled chromosomes; Scaffold = ordered contigs with gaps; Contig = unordered contiguous sequences; Complete Genome = fully closed, telomere-to-telomere.. Valid values are `Chromosome|Scaffold|Contig|Complete Genome`',
    `assembly_method` STRING COMMENT 'Bioinformatics software and algorithm used to assemble the genome (e.g., FALCON, Canu, DISCOVAR, SPAdes). Important for reproducibility and quality assessment.',
    `assembly_name` STRING COMMENT 'Human-readable name of the genome assembly (e.g., GRCh38, T2T-CHM13v2.0, GRCm39). This is the canonical label used across all bioinformatics pipelines and publications.',
    `assembly_status` STRING COMMENT 'Lifecycle status of the assembly. Active = currently used in production pipelines; deprecated = no longer recommended but still accessible; superseded = replaced by a newer version; archived = retained for historical reproducibility only.. Valid values are `active|deprecated|superseded|archived`',
    `assembly_type` STRING COMMENT 'Ploidy and structural representation of the assembly. Haploid = single consensus sequence; diploid = phased maternal/paternal; haploid-with-alt-loci = primary assembly plus alternate haplotype scaffolds.. Valid values are `haploid|diploid|haploid-with-alt-loci|alternate-pseudohaplotype`',
    `bowtie2_index_path` STRING COMMENT 'Path to the Bowtie2 index files for this assembly. Alternative aligner index used in some RNA-seq and ChIP-seq pipelines.',
    `bwa_index_path` STRING COMMENT 'Path to the BWA (Burrows-Wheeler Aligner) index files for this assembly. Required for read alignment in NGS pipelines.',
    `chromosome_count` STRING COMMENT 'Total number of chromosomes represented in the assembly, including autosomes, sex chromosomes, and mitochondrial DNA where applicable.',
    `contig_count` STRING COMMENT 'Total number of contiguous sequences (contigs) in the assembly. Lower contig count indicates higher assembly contiguity and quality.',
    `contig_n50_bp` BIGINT COMMENT 'N50 statistic for contigs: the length at which 50% of the total assembly length is contained in contigs of this size or larger. Key quality metric for assembly contiguity.',
    `coverage_depth` DECIMAL(18,2) COMMENT 'Average sequencing coverage depth (fold coverage) used to generate the assembly. Higher coverage generally indicates higher assembly accuracy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this genome assembly record was first created in the Genomics Biotech reference data catalog. Used for audit trail and data lineage.',
    `cytoband_file_path` STRING COMMENT 'Path to the cytoband file defining chromosome banding patterns (Giemsa staining regions). Used for cytogenetic coordinate mapping and visualization.',
    `deprecated_date` DATE COMMENT 'Date on which this assembly was officially deprecated by the source authority or by Genomics Biotech internal policy. Null if the assembly is still active.',
    `fasta_file_path` STRING COMMENT 'Cloud storage or file system path to the primary FASTA file containing the assembly sequences. This is the authoritative artifact used by all downstream pipelines.',
    `fasta_md5_checksum` STRING COMMENT 'MD5 hash of the FASTA file for integrity verification. Ensures the file has not been corrupted or tampered with during transfer or storage.. Valid values are `^[a-f0-9]{32}$`',
    `gc_content_percent` DECIMAL(18,2) COMMENT 'Percentage of guanine (G) and cytosine (C) bases in the total assembly sequence. Species-specific characteristic used for quality control and comparative genomics.',
    `gff_file_path` STRING COMMENT 'Path to the GFF3 file containing genomic features and annotations. Alternative to GTF, used by some annotation pipelines and genome browsers.',
    `gtf_file_path` STRING COMMENT 'Path to the GTF file containing gene annotations (exons, transcripts, genes) for this assembly. Used by RNA-seq and variant annotation pipelines.',
    `index_file_path` STRING COMMENT 'Path to the FASTA index file (.fai) used by bioinformatics tools (e.g., samtools, GATK) for rapid random access to sequences.',
    `is_primary_assembly` BOOLEAN COMMENT 'Boolean flag indicating whether this is the primary/default assembly for the organism. True = primary assembly used by default in all pipelines; False = alternate or legacy assembly.',
    `is_reference_standard` BOOLEAN COMMENT 'Boolean flag indicating whether this assembly is recognized as a community reference standard (e.g., GRCh38 for human). True = reference standard; False = non-standard or custom assembly.',
    `notes` STRING COMMENT 'Free-text field for additional metadata, known issues, usage recommendations, or special handling instructions for this assembly (e.g., Contains unresolved centromeric gaps, Recommended for clinical variant calling).',
    `organism_common_name` STRING COMMENT 'Common or vernacular name of the organism (e.g., human, mouse, thale cress). Used for user-facing displays and non-technical reporting.',
    `organism_name` STRING COMMENT 'Scientific name of the organism for which this genome assembly was built (e.g., Homo sapiens, Mus musculus, Arabidopsis thaliana).',
    `patch_version` STRING COMMENT 'Incremental patch or update number applied to the base assembly (e.g., p13 for GRCh38.p13). Patches correct errors or add alternate loci without changing the primary coordinate system.',
    `ploidy` STRING COMMENT 'Number of complete sets of chromosomes in the organism. Haploid = one set (e.g., bacteria, haploid yeast); diploid = two sets (e.g., human, mouse); polyploid = more than two sets (e.g., wheat, some plants).. Valid values are `haploid|diploid|polyploid`',
    `release_date` DATE COMMENT 'Date on which this assembly version was officially released by the source authority. Critical for reproducibility and version control in genomic analyses.',
    `scaffold_count` STRING COMMENT 'Total number of scaffolds in the assembly. Scaffolds are ordered and oriented contigs connected by gaps of estimated size.',
    `scaffold_n50_bp` BIGINT COMMENT 'N50 statistic for scaffolds: the length at which 50% of the total assembly length is contained in scaffolds of this size or larger. Higher values indicate better long-range contiguity.',
    `sequence_dictionary_path` STRING COMMENT 'Path to the sequence dictionary file (.dict) required by GATK and Picard tools. Contains metadata about each sequence (chromosome) in the assembly.',
    `sequencing_technology` STRING COMMENT 'Primary sequencing platform(s) used to generate the assembly (e.g., Illumina HiSeq, PacBio HiFi, Oxford Nanopore, Sanger). Relevant for understanding assembly characteristics and error profiles.',
    `source_authority` STRING COMMENT 'Organization or consortium responsible for generating and maintaining this assembly (e.g., GRC = Genome Reference Consortium, T2T = Telomere-to-Telomere Consortium).. Valid values are `GRC|NCBI|UCSC|Ensembl|T2T|Other`',
    `submitter_organization` STRING COMMENT 'Name of the organization or consortium that submitted the assembly to the public database (e.g., Genome Reference Consortium, Broad Institute, Sanger Institute).',
    `taxon_number` BIGINT COMMENT 'NCBI Taxonomy database identifier for the organism. Enables linkage to external biological databases and phylogenetic classification.',
    `total_sequence_length_bp` BIGINT COMMENT 'Total number of base pairs across all sequences in the assembly, including chromosomes, scaffolds, contigs, and unplaced sequences. Measured in base pairs (bp).',
    `ungapped_length_bp` BIGINT COMMENT 'Total number of base pairs excluding gaps (N-runs). Represents the actual sequenced and assembled nucleotide content.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this genome assembly record was last modified. Tracks metadata updates, status changes, and artifact path corrections.',
    CONSTRAINT pk_genome_assembly PRIMARY KEY(`genome_assembly_id`)
) COMMENT 'Master catalog of reference genome assemblies used across all Genomics Biotech pipelines and assays. Each record represents a distinct assembly build (e.g., GRCh38, T2T-CHM13, GRCm39) with its organism taxonomy, chromosome count, total base pairs, source authority (GRC/NCBI/UCSC/Ensembl), assembly level, primary FASTA artifact path, MD5 checksum, and active/deprecated lifecycle status. Serves as the authoritative SSOT for genome build identity — every variant coordinate, gene annotation, and region definition in the enterprise references exactly one assembly record.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` (
    `genome_assembly_version_id` BIGINT COMMENT 'Unique identifier for each versioned release of a reference genome assembly. Primary key. Inferred role: MASTER_RESOURCE (reference genome assembly as a managed resource). Canonical categories present: IDENTITY_LABEL (version_tag), BUSINESS_IDENTIFIER (assembly_accession), CLASSIFICATION_OR_TYPE (assembly_type), LIFECYCLE_STATUS (status), MEASUREMENT_OR_VALUE (total_sequence_length_bp).',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Version records track specific releases of a parent genome assembly. Each version belongs to exactly one assembly. Adding genome_assembly_id FK enables proper parent-child relationship. Removes redund',
    `validation_study_id` BIGINT COMMENT 'Identifier of the internal validation study report document that qualifies this assembly version for use. Null if no validation study was performed.',
    `added_sequences_summary` STRING COMMENT 'Summary of sequences added in this assembly version (e.g., new ALT loci, novel patches, additional scaffolds). Null if no sequences were added.',
    `alt_loci_count` STRING COMMENT 'Number of alternate loci sequences included in the assembly. ALT loci represent regions of high variability or structural variation in the population.',
    `assembly_accession` STRING COMMENT 'NCBI GenBank assembly accession identifier (e.g., GCA_000001405.29 for GRCh38.p14). Globally unique identifier for the assembly in public repositories.. Valid values are `^GCA_[0-9]{9}.[0-9]+$`',
    `assembly_type` STRING COMMENT 'Classification of the assembly structure: primary (main reference), alternate (ALT loci), patch (fix or novel patch), haplotype (phased assembly), unplaced (contigs not assigned to chromosomes), unlocalized (contigs assigned to chromosome but not positioned).. Valid values are `primary|alternate|patch|haplotype|unplaced|unlocalized`',
    `checksum_validation_status` STRING COMMENT 'Status of checksum validation performed upon internal ingestion of the assembly file: validated (checksums match), failed (checksums do not match), pending (validation in progress), not_performed (validation skipped).. Valid values are `validated|failed|pending|not_performed`',
    `chromosome_count` STRING COMMENT 'Number of chromosomes represented in the assembly (e.g., 24 for human: 22 autosomes + X + Y). Excludes unplaced and unlocalized contigs.',
    `contig_count` STRING COMMENT 'Total number of contiguous sequences (contigs) in the assembly. Higher contig counts may indicate lower assembly contiguity.',
    `contig_n50_bp` BIGINT COMMENT 'Contig N50 metric: the length of the shortest contig such that 50% of the total assembly length is contained in contigs of this length or longer. Higher N50 indicates better assembly contiguity.',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created this genome assembly version record in the internal data system. Audit trail for accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this genome assembly version record was first created in the internal data system. Audit trail for data lineage and compliance.',
    `decoy_sequence_included` BOOLEAN COMMENT 'Indicates whether decoy sequences (e.g., hs38d1 decoy for GRCh38) are included in this assembly version. Decoy sequences reduce false-positive alignments by capturing reads that do not belong to the primary assembly.',
    `decoy_sequence_name` STRING COMMENT 'Name or identifier of the decoy sequence set included (e.g., hs38d1, hs38DH). Null if no decoy sequences are included.',
    `ebv_sequence_included` BOOLEAN COMMENT 'Indicates whether Epstein-Barr Virus (EBV) reference sequence (chrEBV) is included. EBV is commonly present in immortalized cell lines used for sequencing.',
    `fasta_file_checksum_md5` STRING COMMENT 'MD5 checksum hash of the primary FASTA file for this assembly version. Used to validate file integrity and ensure reproducibility.. Valid values are `^[a-f0-9]{32}$`',
    `fasta_file_checksum_sha256` STRING COMMENT 'SHA-256 checksum hash of the primary FASTA file for this assembly version. Provides stronger integrity validation than MD5.. Valid values are `^[a-f0-9]{64}$`',
    `gap_count` STRING COMMENT 'Total number of gaps (regions of unknown sequence, typically represented by Ns) in the assembly. Lower gap counts indicate more complete assemblies.',
    `genome_assembly_version_status` STRING COMMENT 'Current lifecycle status of this genome assembly version: active (currently used in production pipelines), deprecated (superseded but still available), retired (no longer available for new analyses), under_review (being evaluated for adoption).. Valid values are `active|deprecated|retired|under_review`',
    `internal_adoption_date` DATE COMMENT 'Date on which this genome assembly version was officially adopted for use in internal bioinformatics pipelines and analysis workflows. Critical for audit trails and reproducibility.',
    `mitochondrial_genome_included` BOOLEAN COMMENT 'Indicates whether the mitochondrial genome (chrM) is included in this assembly version. Critical for mitochondrial variant calling and analysis.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this genome assembly version record in the internal data system. Audit trail for accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this genome assembly version record was last modified in the internal data system. Audit trail for data lineage and compliance.',
    `patch_notes` STRING COMMENT 'Detailed release notes describing changes, additions, and corrections in this assembly version compared to the previous version. Includes information on added/removed sequences, ALT loci changes, and bug fixes.',
    `patch_number` STRING COMMENT 'Sequential patch release number for this assembly version (e.g., 14 in GRCh38.p14). Null for base releases without patches.',
    `patch_type` STRING COMMENT 'Type of patch applied: fix (corrects errors in the primary assembly) or novel (adds new alternate loci or sequences without altering primary assembly). Null if not a patch release.. Valid values are `fix|novel`',
    `regulatory_compliance_status` STRING COMMENT 'Indicates whether this genome assembly version meets regulatory requirements for use in Clinical Laboratory Improvement Amendments (CLIA) and College of American Pathologists (CAP) accredited clinical genomic testing. Compliant assemblies have been validated for regulatory-grade variant interpretation.. Valid values are `compliant|non_compliant|under_review|not_applicable`',
    `release_date` DATE COMMENT 'Date on which this genome assembly version was officially released by the source organization (e.g., Genome Reference Consortium, T2T Consortium).',
    `removed_sequences_summary` STRING COMMENT 'Summary of sequences removed or deprecated in this assembly version (e.g., retired ALT loci, corrected errors). Null if no sequences were removed.',
    `retirement_date` DATE COMMENT 'Date on which this genome assembly version was retired from active use in production pipelines. Null if still active. Retired assemblies are retained for historical reproducibility but not used for new analyses.',
    `scaffold_count` STRING COMMENT 'Total number of scaffolds in the assembly. Scaffolds are ordered and oriented sets of contigs separated by gaps.',
    `scaffold_n50_bp` BIGINT COMMENT 'Scaffold N50 metric: the length of the shortest scaffold such that 50% of the total assembly length is contained in scaffolds of this length or longer. Higher N50 indicates better assembly contiguity.',
    `source_organization` STRING COMMENT 'Organization or consortium responsible for producing and releasing this genome assembly (e.g., Genome Reference Consortium, Telomere-to-Telomere Consortium, NCBI).',
    `source_release_url` STRING COMMENT 'URL to the official release page or FTP directory where this assembly version can be downloaded. Ensures traceability to the authoritative source.. Valid values are `^https?://.*$`',
    `total_sequence_length_bp` BIGINT COMMENT 'Total length of all sequences in the assembly measured in base pairs, including chromosomes, scaffolds, contigs, and unplaced sequences. Critical for coverage and alignment QC.',
    `usage_scope` STRING COMMENT 'Intended scope of use for this assembly version: clinical (approved for Clinical Laboratory Improvement Amendments (CLIA) and College of American Pathologists (CAP) testing), research_use_only (Research Use Only (RUO) applications only), internal_development (internal pipeline development and testing), external_collaboration (shared with external research partners).. Valid values are `clinical|research_use_only|internal_development|external_collaboration`',
    `validation_study_performed` BOOLEAN COMMENT 'Indicates whether an internal analytical validation study was performed to qualify this assembly version for clinical or Research Use Only (RUO) use. Required for Clinical Laboratory Improvement Amendments (CLIA) and College of American Pathologists (CAP) compliance.',
    `version_tag` STRING COMMENT 'Human-readable version identifier for the genome assembly release, such as GRCh38.p14, hg38, T2T-CHM13v2.0. This is the canonical label used in bioinformatics pipelines and publications.',
    CONSTRAINT pk_genome_assembly_version PRIMARY KEY(`genome_assembly_version_id`)
) COMMENT 'Versioned release records for each reference genome assembly, tracking the full provenance chain of assembly updates, patches, and deprecations. Captures version tag (e.g., GRCh38.p14), release date, patch notes, added/removed sequences, ALT loci changes, decoy sequence inclusions, source release URL, checksum validation status, internal adoption date, and retirement date. Enables reproducible genomic analysis by ensuring every pipeline run is pinned to a specific, auditable assembly version — critical for regulatory-grade variant interpretation and CAP/CLIA compliance.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reference`.`variant_database` (
    `variant_database_id` BIGINT COMMENT 'Unique identifier for the variant database record. Primary key.',
    `replacement_database_variant_database_id` BIGINT COMMENT 'Reference to the variant_database_id of the newer version that replaces this deprecated database.',
    `annotation_fields` STRING COMMENT 'Comma-separated list of annotation fields or INFO tags provided by this database (e.g., CLNSIG, AF, CADD, SIFT, PolyPhen).',
    `approval_date` DATE COMMENT 'Date when the database was officially approved for use in annotation workflows.',
    `approval_status` STRING COMMENT 'Governance approval status indicating whether this database is authorized for use in production annotation pipelines.. Valid values are `approved|pending|rejected|under_review`',
    `approved_by` STRING COMMENT 'Name or identifier of the data steward or governance committee member who approved this database for use.',
    `checksum_md5` STRING COMMENT 'MD5 hash of the database file(s) for integrity verification after download.',
    `citation` STRING COMMENT 'Full bibliographic citation or DOI for the primary publication describing this variant database, required for regulatory documentation.',
    `clinical_validation_status` STRING COMMENT 'Indicates whether this database has been validated for use in clinical reporting workflows per regulatory requirements.. Valid values are `validated|not_validated|in_progress|not_applicable`',
    `contact_email` STRING COMMENT 'Email address for technical support or inquiries related to this variant database.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this variant database record was first created in the registry.',
    `data_access_tier` STRING COMMENT 'Access control classification indicating who can use this database (public, requires license, restricted to authorized users, or internal only).. Valid values are `public|licensed|restricted|internal`',
    `database_code` STRING COMMENT 'Short code or abbreviation used to reference the database in annotation pipelines and bioinformatics workflows.',
    `database_name` STRING COMMENT 'Official name of the variant database (e.g., dbSNP, ClinVar, gnomAD, COSMIC, OMIM, ClinGen, HGMD).',
    `database_type` STRING COMMENT 'Classification of the database origin and ownership model.. Valid values are `public|commercial|proprietary|internal`',
    `deprecation_date` DATE COMMENT 'Date when this database version was marked as deprecated and should no longer be used in new annotation workflows.',
    `documentation_url` STRING COMMENT 'URL to the official documentation, user guide, or README for this variant database.',
    `download_url` STRING COMMENT 'URL or FTP path where the variant database files can be downloaded or accessed.',
    `file_format` STRING COMMENT 'Primary file format in which the variant database is distributed (e.g., VCF, TSV, JSON, BED, MAF).. Valid values are `VCF|TSV|JSON|XML|BED|MAF`',
    `file_size_gb` DECIMAL(18,2) COMMENT 'Total size of the database files in gigabytes, used for storage planning and download estimation.',
    `genome_build` STRING COMMENT 'Reference genome assembly version that the variant database coordinates are mapped to (e.g., GRCh38/hg38, GRCh37/hg19, T2T-CHM13).. Valid values are `GRCh37|hg19|GRCh38|hg38|T2T-CHM13`',
    `last_updated_date` DATE COMMENT 'Date when the database record metadata was last updated in the internal registry.',
    `license_type` STRING COMMENT 'Type of license governing the use of this variant database (e.g., CC0, CC-BY, proprietary, academic-only, commercial).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this variant database record was last modified in the registry.',
    `notes` STRING COMMENT 'Free-text field for additional information, known issues, usage recommendations, or special handling instructions for this database.',
    `population_coverage` STRING COMMENT 'Description of the populations or ancestries represented in the database (e.g., global, European, African, East Asian, admixed).',
    `release_date` DATE COMMENT 'Date when this version of the variant database was officially released by the source organization.',
    `source_organization` STRING COMMENT 'Name of the organization or consortium that maintains and publishes the variant database (e.g., NCBI, Broad Institute, EMBL-EBI).',
    `update_frequency` STRING COMMENT 'Expected cadence at which the source organization releases new versions of the database.. Valid values are `daily|weekly|monthly|quarterly|annually|irregular`',
    `usage_scope` STRING COMMENT 'Approved scope of use for this database: clinical-grade annotation, research use only (RUO), or both.. Valid values are `clinical|research|both`',
    `variant_count` BIGINT COMMENT 'Total number of variant records contained in this database version.',
    `variant_database_status` STRING COMMENT 'Current lifecycle status of the variant database in the annotation pipeline registry.. Valid values are `active|deprecated|archived|pending_approval`',
    `vcf_schema_version` STRING COMMENT 'Version of the VCF specification that the database files conform to (e.g., VCFv4.2, VCFv4.3).',
    `version` STRING COMMENT 'Version identifier of the variant database release (e.g., b156, 20230101, v3.1.2).',
    CONSTRAINT pk_variant_database PRIMARY KEY(`variant_database_id`)
) COMMENT 'Master catalog of external and internal variant databases integrated into annotation pipelines — including dbSNP, ClinVar, gnomAD, COSMIC, OMIM, ClinGen, HGMD, and proprietary internal variant repositories. Captures database name, version, release date, source organization, variant count, genome build compatibility, data access tier (public/licensed/restricted), annotation fields provided, VCF schema version, download URL, license type, and active/deprecated status. Serves as the authoritative registry governing which variant databases are approved for use in clinical and research annotation workflows.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` (
    `variant_database_version_id` BIGINT COMMENT 'Unique identifier for the variant database version record. Primary key.',
    `variant_database_id` BIGINT COMMENT 'Foreign key linking to reference.variant_database. Business justification: Version records track specific releases of a parent variant database. Each version belongs to exactly one database. Adding variant_database_id FK enables proper parent-child relationship. Removes redu',
    `adoption_date` DATE COMMENT 'Date when this database version was officially adopted for use in production annotation pipelines. Marks the start of active use.',
    `annotation_pipeline_compatibility` STRING COMMENT 'Comma-separated list of internal annotation pipeline versions or tools compatible with this database version (e.g., VEP 105, SnpEff 5.1). Supports pipeline configuration management.',
    `citation_reference` STRING COMMENT 'Bibliographic citation or DOI for the database version, as required by the source authority for publication acknowledgment. Ensures proper attribution in regulatory submissions and publications.',
    `clinical_use_approved` BOOLEAN COMMENT 'Boolean flag indicating whether this database version is approved for use in clinical diagnostic workflows (True) or restricted to research use only (False). Critical for CLIA/CAP compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this database version record was first created in the system. Provides audit trail for data governance.',
    `data_format_version` STRING COMMENT 'Version of the data format specification used (e.g., VCF 4.2, VCF 4.3). Ensures parser compatibility and data structure understanding.',
    `genome_build` STRING COMMENT 'Reference genome assembly build that this variant database version is aligned to (e.g., GRCh38/hg38, GRCh37/hg19, T2T-CHM13). Critical for coordinate mapping and variant interpretation.. Valid values are `GRCh37|hg19|GRCh38|hg38|T2T-CHM13`',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this database version is currently active and approved for use in production pipelines (True) or retired (False).',
    `license_type` STRING COMMENT 'License or usage terms governing this database version (e.g., public domain, CC0, CC-BY, proprietary). Important for compliance with data use agreements.. Valid values are `public_domain|CC0|CC_BY|CC_BY_NC|proprietary|academic_only`',
    `md5_checksum` STRING COMMENT 'MD5 hash of the VCF file for integrity verification. Ensures file has not been corrupted or tampered with during transfer or storage.. Valid values are `^[a-fA-F0-9]{32}$`',
    `modified_by` STRING COMMENT 'Username or identifier of the person who last modified this database version record. Supports change tracking and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this database version record was last modified. Provides audit trail for data governance and change management.',
    `new_pathogenic_count` STRING COMMENT 'Number of newly classified pathogenic or likely pathogenic variants in this release. Critical for clinical variant interpretation updates.',
    `population_coverage` STRING COMMENT 'Description of population groups or ancestries represented in this database version (e.g., global, European, African, East Asian). Important for allele frequency interpretation and health equity.',
    `reclassified_count` STRING COMMENT 'Number of variants with updated clinical significance classifications (e.g., VUS to pathogenic, pathogenic to benign). Tracks curation quality and knowledge evolution.',
    `regulatory_submission_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this database version has been approved for use in regulatory submissions to FDA, EMA, or other authorities (True) or is for Research Use Only (RUO) (False).',
    `release_date` DATE COMMENT 'Official release date of this database version by the source authority. Represents when the variant database snapshot was published.',
    `retirement_date` DATE COMMENT 'Date when this database version was retired from active use and replaced by a newer version. Nullable for currently active versions. Critical for annotation provenance tracking.',
    `retracted_count` STRING COMMENT 'Number of variant entries retracted or deprecated in this release due to errors, duplicates, or updated evidence. Important for data quality auditing.',
    `sample_size` STRING COMMENT 'Number of samples or individuals whose data contributed to this database version. Provides context for allele frequency confidence and statistical power.',
    `sha256_checksum` STRING COMMENT 'SHA-256 cryptographic hash of the VCF file for enhanced integrity verification. Provides stronger security than MD5 for regulatory-grade data validation.. Valid values are `^[a-fA-F0-9]{64}$`',
    `source_url` STRING COMMENT 'Official URL from which this database version was downloaded. Provides traceability to the authoritative source.',
    `validation_date` DATE COMMENT 'Date when internal validation testing was completed for this database version. Documents quality control timeline.',
    `validation_notes` STRING COMMENT 'Free-text notes documenting validation findings, issues identified, or special considerations for this database version. Supports audit trail and troubleshooting.',
    `validation_status` STRING COMMENT 'Status of internal validation testing performed on this database version before adoption (e.g., passed, failed, pending). Ensures quality control before production use.. Valid values are `pending|in_progress|passed|failed|conditional`',
    `variant_count` BIGINT COMMENT 'Total number of variant records included in this database version. Provides scale and coverage metrics for the release.',
    `variant_count_delta` BIGINT COMMENT 'Net change in variant count compared to the previous version (positive for additions, negative for removals). Tracks database growth or curation changes.',
    `vcf_file_path` STRING COMMENT 'Storage location or URI of the VCF file containing the variant database content for this version. Enables reproducible annotation pipeline execution.',
    `vcf_file_size_bytes` BIGINT COMMENT 'Size of the VCF file in bytes. Used for storage planning and data transfer validation.',
    `version_identifier` STRING COMMENT 'Specific version identifier or build number of the database release (e.g., b156 for dbSNP, 2024-03 for ClinVar). Uniquely identifies the snapshot used in annotation pipelines.',
    `created_by` STRING COMMENT 'Username or identifier of the person who created this database version record in the system. Supports audit trail and accountability.',
    CONSTRAINT pk_variant_database_version PRIMARY KEY(`variant_database_version_id`)
) COMMENT 'Versioned release records for each variant database, capturing the specific snapshot used in annotation pipeline runs. Tracks version identifier (e.g., dbSNP b156, ClinVar 2024-03), release date, variant count delta, new pathogenicity classifications, retracted entries, VCF file path, MD5 checksum, genome build alignment, internal validation status, adoption date, and retirement date. Ensures full auditability of variant annotation provenance for regulatory submissions (FDA, EMA) and reproducibility of clinical variant interpretation.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` (
    `gene_annotation_track_id` BIGINT COMMENT 'Unique identifier for the gene annotation track record. Primary key for this entity.',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Each gene annotation track is built against a specific reference genome assembly. The genome_build string attribute should be replaced with a proper FK to genome_assembly. Removes redundant genome_bui',
    `superseded_by_track_gene_annotation_track_id` BIGINT COMMENT 'Reference to the gene_annotation_track_id of the newer annotation track that supersedes this one, if deprecated.',
    `annotation_method` STRING COMMENT 'Description of the computational or manual method used to generate the annotation track (e.g., GENCODE manual curation, Ensembl automated pipeline).',
    `annotation_source` STRING COMMENT 'The authoritative source or provider of the gene annotation track (e.g., GENCODE, RefSeq, Ensembl, UCSC, or Custom internal models).. Valid values are `GENCODE|RefSeq|Ensembl|UCSC|Custom`',
    `biotype_classifications` STRING COMMENT 'Comma-separated list of gene biotype categories included in this track (e.g., protein_coding, lncRNA, miRNA, pseudogene, snRNA, snoRNA).',
    `checksum_md5` STRING COMMENT 'MD5 hash checksum of the annotation file for integrity verification.',
    `citation_reference` STRING COMMENT 'The primary publication or citation reference for this annotation track (e.g., PubMed ID, DOI).',
    `compatible_pipelines` STRING COMMENT 'Comma-separated list of internal bioinformatics pipeline names or identifiers that are compatible with this annotation track.',
    `coordinate_system` STRING COMMENT 'The coordinate system convention used in this annotation track (0-based half-open for BED, 1-based closed for GTF/GFF3).. Valid values are `0-based|1-based`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this annotation track record was first created in the system.',
    `deprecation_date` DATE COMMENT 'Date when this annotation track was deprecated and superseded by a newer version.',
    `file_format` STRING COMMENT 'The file format of the annotation track (e.g., GTF, GFF3, BED, GenBank).. Valid values are `GTF|GFF3|BED|GenBank`',
    `file_path` STRING COMMENT 'The storage location or URI of the annotation file in the data lake or cloud storage (e.g., s3://genomics-data/reference/gencode_v38.gtf.gz).',
    `file_size_bytes` BIGINT COMMENT 'The size of the annotation file in bytes.',
    `gene_annotation_track_status` STRING COMMENT 'Current lifecycle status of the annotation track (active for production use, deprecated for superseded versions, archived for historical reference, under_review for validation in progress).. Valid values are `active|deprecated|archived|under_review`',
    `gene_count` STRING COMMENT 'Total number of gene features annotated in this track.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the data steward or system that last modified this annotation track record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this annotation track record was last modified.',
    `license_type` STRING COMMENT 'The license or terms of use governing the annotation track (e.g., Public Domain, Creative Commons, Proprietary).',
    `lncrna_gene_count` STRING COMMENT 'Number of long non-coding RNA genes annotated in this track.',
    `notes` STRING COMMENT 'Free-text notes or comments about the annotation track, including known issues, special considerations, or usage recommendations.',
    `protein_coding_gene_count` STRING COMMENT 'Number of protein-coding genes in this annotation track.',
    `pseudogene_count` STRING COMMENT 'Number of pseudogenes annotated in this track.',
    `release_date` DATE COMMENT 'The official release date of this annotation track version.',
    `release_version` STRING COMMENT 'The specific release or version number of the annotation track (e.g., v38, Release 109, 2021-07).',
    `source_url` STRING COMMENT 'The official URL or FTP location from which the annotation track was downloaded (e.g., ftp://ftp.ebi.ac.uk/pub/databases/gencode/).',
    `strand_convention` STRING COMMENT 'Indicates whether the annotation track includes strand information (forward, reverse, both, or unstranded).. Valid values are `forward|reverse|both|unstranded`',
    `track_name` STRING COMMENT 'Human-readable name of the gene annotation track (e.g., GENCODE v38, RefSeq GRCh38.p13, Ensembl 104).',
    `transcript_count` STRING COMMENT 'Total number of transcript isoforms annotated in this track.',
    `usage_scope` STRING COMMENT 'Intended usage scope of the annotation track: RUO (Research Use Only), IVD (In Vitro Diagnostic), LDT (Laboratory Developed Test), or Internal (internal research and development).. Valid values are `RUO|IVD|LDT|Internal`',
    `validation_date` DATE COMMENT 'Date when the annotation track was validated for production use.',
    `validation_status` STRING COMMENT 'Indicates whether the annotation track has undergone internal validation for use in clinical or regulatory-grade pipelines.. Valid values are `validated|pending_validation|not_validated`',
    `created_by` STRING COMMENT 'Username or identifier of the data steward or system that created this annotation track record.',
    CONSTRAINT pk_gene_annotation_track PRIMARY KEY(`gene_annotation_track_id`)
) COMMENT 'Master catalog of gene annotation tracks used for genomic feature annotation — including GENCODE, RefSeq, Ensembl, UCSC, and custom internal gene models. Captures track name, annotation source, genome build compatibility, gene count, transcript count, biotype classifications (protein-coding, lncRNA, pseudogene), GTF/GFF3 file path, release version, release date, coordinate system, strand convention, checksum, and active/deprecated status. Authoritative reference for gene-level annotation applied in variant calling, RNA-seq, and clinical assay interpretation pipelines.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reference`.`gene_model` (
    `gene_model_id` BIGINT COMMENT 'Unique identifier for the gene model record. Primary key for the gene model entity.',
    `gene_annotation_track_id` BIGINT COMMENT 'Foreign key linking to reference.gene_annotation_track. Business justification: Gene models are sourced from specific gene annotation tracks (GENCODE, RefSeq, etc.). Each gene model should reference its source annotation track. The source_database string attribute should be repla',
    `acmg_secondary_findings_flag` BOOLEAN COMMENT 'Indicates whether the gene is on the ACMG list of genes recommended for reporting of secondary findings in clinical sequencing. Critical for clinical laboratory compliance and incidental findings workflows.',
    `associated_disease_phenotypes` STRING COMMENT 'Comma-separated list of disease phenotypes or clinical conditions associated with variants in this gene. Supports clinical assay design and variant prioritization workflows.',
    `cancer_gene_census_flag` BOOLEAN COMMENT 'Indicates whether the gene is catalogued in the Cancer Gene Census as a known cancer driver gene. Critical for oncology assay design and somatic variant interpretation.',
    `chromosome` STRING COMMENT 'Chromosome on which the gene is located (1-22, X, Y, or MT for mitochondrial). Critical for cytogenetic reporting and structural variant analysis.. Valid values are `^(chr)?([1-9]|1[0-9]|2[0-2]|X|Y|MT?)$`',
    `constraint_metric_loeuf` DECIMAL(18,2) COMMENT 'Loss-of-Function Observed/Expected Upper Bound Fraction from gnomAD, a continuous measure of gene constraint. Lower LOEUF scores indicate greater intolerance to loss-of-function variants.',
    `constraint_metric_pli` DECIMAL(18,2) COMMENT 'Probability of Loss-of-Function Intolerance score from gnomAD, indicating the genes tolerance to inactivating variants. High pLI (>0.9) suggests the gene is intolerant to loss-of-function variants.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this gene model record was first created in the reference data catalog. Supports audit trail and data lineage tracking for regulatory compliance.',
    `curator_notes` STRING COMMENT 'Free-text notes from the data curation team documenting special considerations, known issues, or manual overrides applied to this gene model. Supports knowledge transfer and audit trails.',
    `effective_end_date` DATE COMMENT 'Date on which this gene model version was superseded or retired. Null for currently active versions. Supports temporal queries and regulatory audit trails.',
    `effective_start_date` DATE COMMENT 'Date from which this gene model version became effective and available for use in production annotation pipelines and clinical assays.',
    `end_position` BIGINT COMMENT 'Genomic coordinate of the gene end position (3 end) in base pairs, relative to the reference genome build. Defines the gene boundary for annotation pipelines.',
    `ensembl_gene_accession` STRING COMMENT 'Stable Ensembl gene identifier used for cross-referencing with Ensembl genome browser and annotation databases.. Valid values are `^ENSG[0-9]{11}$`',
    `entrez_gene_number` BIGINT COMMENT 'NCBI Entrez Gene ID, the primary identifier used in NCBI databases including Gene, PubMed, and ClinVar for gene-level cross-referencing.',
    `essential_gene_flag` BOOLEAN COMMENT 'Indicates whether the gene is essential for cell viability or organism survival based on functional genomics studies. Used in CRISPR screen analysis and drug target prioritization.',
    `gene_biotype` STRING COMMENT 'Functional classification of the gene based on its molecular product type. Determines the genes role in cellular processes and influences analysis pipelines. [ENUM-REF-CANDIDATE: protein_coding|lncRNA|miRNA|snRNA|snoRNA|rRNA|pseudogene — 7 candidates stripped; promote to reference product]',
    `gene_description` STRING COMMENT 'Free-text description of the genes known or predicted function, biological role, and clinical significance. Supports manual curation and knowledge base enrichment.',
    `gene_family` STRING COMMENT 'Gene family or superfamily to which this gene belongs (e.g., kinase, G-protein coupled receptor, immunoglobulin). Supports functional enrichment analysis and pathway mapping.',
    `gene_length_bp` BIGINT COMMENT 'Total length of the gene in base pairs from start to end position. Used for coverage depth normalization and sequencing quality metrics.',
    `gene_name` STRING COMMENT 'Full descriptive name of the gene, providing human-readable context for the gene symbol (e.g., tumor protein p53 for TP53).',
    `gene_status` STRING COMMENT 'Current curation status of the gene record in the reference catalog. Active genes are approved for use in production pipelines; retired or withdrawn genes require remapping.. Valid values are `active|retired|provisional|withdrawn`',
    `gene_synonym_list` STRING COMMENT 'Comma-separated list of alternative names and synonyms for the gene. Enhances search and cross-referencing capabilities across literature and databases.',
    `gene_version` STRING COMMENT 'Version identifier for this gene model record, tracking updates to gene coordinates, annotations, or metadata over time. Ensures reproducibility and audit trail for regulatory compliance.',
    `genome_build` STRING COMMENT 'Reference genome assembly version used for gene coordinates (e.g., GRCh38/hg38, GRCh37/hg19, T2T-CHM13). Essential for coordinate liftover and reproducible variant interpretation.. Valid values are `GRCh38|hg38|GRCh37|hg19|T2T-CHM13`',
    `haploinsufficiency_score` DECIMAL(18,2) COMMENT 'Quantitative score indicating the likelihood that loss of one gene copy (haploinsufficiency) causes disease. Used for copy number variant interpretation and dosage sensitivity analysis.',
    `hgnc_gene_symbol` STRING COMMENT 'Official gene symbol assigned by HGNC, the authoritative naming body for human genes. This is the primary human-readable identifier for the gene.. Valid values are `^[A-Z0-9-]+$`',
    `last_curated_date` DATE COMMENT 'Date when this gene model record was last reviewed and curated by the bioinformatics or clinical genomics team. Supports data quality monitoring and refresh scheduling.',
    `locus_group` STRING COMMENT 'High-level classification of the locus type as defined by HGNC. Groups genes by their primary molecular function category.. Valid values are `protein-coding gene|non-coding RNA|pseudogene|other`',
    `locus_type` STRING COMMENT 'Detailed locus type classification providing finer granularity than locus group (e.g., gene with protein product, RNA, long non-coding).',
    `mane_select_transcript_transcript_model_id` STRING COMMENT 'MANE Select transcript identifier representing the gold-standard transcript for clinical reporting, jointly curated by NCBI and Ensembl.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this gene model record was last modified. Supports change tracking, audit trails, and downstream data refresh orchestration.',
    `omim_number` STRING COMMENT 'OMIM identifier linking the gene to known genetic disorders and phenotypes. Used for clinical variant interpretation and disease association reporting.. Valid values are `^[0-9]{6}$`',
    `pharmacogenomics_relevance_flag` BOOLEAN COMMENT 'Indicates whether the gene has known pharmacogenomic associations affecting drug metabolism, efficacy, or toxicity. Used for precision medicine and clinical decision support.',
    `previous_gene_symbols` STRING COMMENT 'Comma-separated list of previous or alias gene symbols for this gene. Supports legacy data migration and cross-reference mapping.',
    `start_position` BIGINT COMMENT 'Genomic coordinate of the gene start position (5 end) in base pairs, relative to the reference genome build. Used for variant mapping and gene overlap analysis.',
    `strand` STRING COMMENT 'DNA strand on which the gene is encoded: + for forward/sense strand, - for reverse/antisense strand. Critical for transcript orientation and variant effect prediction.. Valid values are `^[+-]$`',
    `transcript_count` STRING COMMENT 'Number of known transcript isoforms for this gene. Indicates alternative splicing complexity and impacts variant annotation strategies.',
    `transcript_model_id` STRING COMMENT 'Identifier of the canonical or representative transcript for this gene, used as the default for variant annotation and clinical reporting.',
    `triplosensitivity_score` DECIMAL(18,2) COMMENT 'Quantitative score indicating the likelihood that gain of one gene copy (triplosensitivity) causes disease. Used for copy number variant interpretation and dosage sensitivity analysis.',
    CONSTRAINT pk_gene_model PRIMARY KEY(`gene_model_id`)
) COMMENT 'Authoritative master record for each gene in the reference catalog — capturing HGNC gene symbol, Ensembl gene ID, Entrez gene ID, gene name, gene biotype, chromosomal locus (chromosome, start, end, strand), genome build, OMIM ID, gene family, associated disease phenotypes, essential gene flag, cancer gene census flag, pharmacogenomics relevance flag, and curation status. Serves as the enterprise SSOT for gene identity, enabling consistent gene-level reporting across variant interpretation, clinical assay design, and research workflows.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` (
    `transcript_model_id` BIGINT COMMENT 'Unique identifier for the transcript model record. Primary key.',
    `gene_annotation_track_id` BIGINT COMMENT 'Foreign key linking to reference.gene_annotation_track. Business justification: Transcript models are sourced from specific gene annotation tracks. Each transcript should reference its source annotation track for full provenance. Removes redundant annotation_source and annotation',
    `gene_model_id` BIGINT COMMENT 'Foreign key reference to the parent gene model that this transcript belongs to.',
    `appris_annotation` STRING COMMENT 'APPRIS annotation classifying the transcript as principal (most functionally important isoform) or alternative, with confidence levels 1-5 for principal isoforms. Principal1 is the highest confidence. Used to prioritize functionally relevant isoforms in variant interpretation. [ENUM-REF-CANDIDATE: principal1|principal2|principal3|principal4|principal5|alternative1|alternative2 — 7 candidates stripped; promote to reference product]',
    `biotype` STRING COMMENT 'Functional classification of the transcript indicating its biological role: protein_coding (translates to protein), lncRNA (long non-coding RNA), miRNA (microRNA), snRNA (small nuclear RNA), snoRNA (small nucleolar RNA), rRNA (ribosomal RNA), pseudogene (non-functional gene copy), processed_transcript (non-coding transcript without clear classification), retained_intron (transcript with retained intron), nonsense_mediated_decay (transcript subject to NMD pathway). Critical for filtering coding vs non-coding variants in clinical pipelines. [ENUM-REF-CANDIDATE: protein_coding|lncRNA|miRNA|snRNA|snoRNA|rRNA|pseudogene|processed_transcript|retained_intron|nonsense_mediated_decay — 10 candidates stripped; promote to reference product]',
    `ccds_accession` STRING COMMENT 'Consensus CDS identifier for transcripts that are identically annotated across multiple annotation sources (Ensembl, RefSeq, UCSC). Null if not part of CCDS. High-confidence coding transcripts used in clinical reporting.. Valid values are `^CCDS[0-9]+(.[0-9]+)?$`',
    `cds_end_position` STRING COMMENT 'Genomic coordinate (1-based) of the coding sequence end position (translation termination site, typically stop codon). Null for non-coding transcripts. Essential for determining whether a variant falls in the coding region or 3 UTR.',
    `cds_start_position` STRING COMMENT 'Genomic coordinate (1-based) of the coding sequence start position (translation initiation site, typically ATG start codon). Null for non-coding transcripts. Essential for determining whether a variant falls in the 5 UTR, coding region, or 3 UTR.',
    `checksum` STRING COMMENT 'MD5 or SHA-256 hash of the transcript sequence and structural coordinates, used to detect data corruption and ensure integrity of reference data in regulatory-grade pipelines per 21 CFR Part 11.. Valid values are `^[a-fA-F0-9]{32,64}$`',
    `chromosome` STRING COMMENT 'Chromosome on which this transcript is located (1-22, X, Y, M/MT for mitochondrial). May include chr prefix depending on genome build convention. Essential for genomic coordinate mapping and variant liftover.. Valid values are `^(chr)?(1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|X|Y|M|MT)$`',
    `coding_length_bp` STRING COMMENT 'Length of the coding sequence (CDS) in base pairs, from start codon to stop codon. Null for non-coding transcripts. Used for protein length calculation (coding_length_bp / 3) and frameshift variant impact assessment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this transcript model record was first created in the system. Used for audit trails and data lineage tracking per GxP requirements.',
    `curation_status` STRING COMMENT 'Quality and review status of the transcript annotation: reviewed (manually curated and validated), validated (experimentally confirmed), predicted (computational prediction), provisional (preliminary annotation pending review), withdrawn (deprecated or superseded). Critical for filtering high-confidence transcripts in clinical assays.. Valid values are `reviewed|validated|predicted|provisional|withdrawn`',
    `data_source_system` STRING COMMENT 'Name of the source system or pipeline that loaded this transcript model record (e.g., Ensembl ETL Pipeline, RefSeq Import Job). Used for data lineage and troubleshooting.',
    `effective_end_date` DATE COMMENT 'Date when this transcript model version was superseded or deprecated. Null for currently active versions. Used for temporal queries and audit trails in regulatory-grade systems.',
    `effective_start_date` DATE COMMENT 'Date when this transcript model version became effective and available for use in annotation pipelines. Used for temporal queries and version control in regulatory-grade systems.',
    `ensembl_transcript_accession` STRING COMMENT 'Ensembl stable transcript identifier with optional version suffix (e.g., ENST00000456328.2). Primary external reference for Ensembl-based annotation pipelines.. Valid values are `^ENST[0-9]{11}(.[0-9]+)?$`',
    `exon_count` STRING COMMENT 'Total number of exons in this transcript model. Used for splice site analysis, exon-level variant annotation, and transcript structure validation.',
    `gencode_tag` STRING COMMENT 'Comma-separated list of GENCODE tags providing additional transcript metadata (e.g., basic, CCDS, appris_principal, MANE_Select, exp_conf). Used for advanced filtering and quality assessment in annotation pipelines.',
    `genome_build` STRING COMMENT 'Reference genome assembly version used for this transcript annotation: GRCh38/hg38 (current standard), GRCh37/hg19 (legacy), T2T-CHM13 (telomere-to-telomere complete assembly). Critical for coordinate liftover and ensuring annotation consistency across pipelines.. Valid values are `GRCh38|hg38|GRCh37|hg19|T2T-CHM13`',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this transcript model is currently active and should be used in annotation pipelines. Inactive transcripts are retained for historical reference and audit purposes but excluded from production workflows.',
    `is_canonical` BOOLEAN COMMENT 'Boolean flag indicating whether this transcript is designated as the canonical (representative) transcript for the gene. Canonical transcripts are typically the longest coding transcript or the most biologically relevant isoform, used as the default for variant annotation when multiple isoforms exist.',
    `is_mane_plus_clinical` BOOLEAN COMMENT 'Boolean flag indicating whether this transcript is designated as a MANE Plus Clinical transcript. MANE Plus Clinical includes additional clinically relevant transcripts beyond MANE Select that are important for clinical variant interpretation, particularly for genes with multiple clinically significant isoforms.',
    `is_mane_select` BOOLEAN COMMENT 'Boolean flag indicating whether this transcript is designated as the MANE Select transcript. MANE Select represents the single agreed-upon transcript per gene between RefSeq and Ensembl/GENCODE, providing a gold-standard reference for clinical reporting and variant interpretation. Critical for regulatory-grade IVD/LDT assays.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this transcript model record was last modified. Used for change tracking and audit trails per GxP requirements.',
    `protein_accession` STRING COMMENT 'Ensembl protein identifier (ENSP) or RefSeq protein accession (NP_ for reviewed, XP_ for predicted) associated with this transcript. Null for non-coding transcripts. Used for protein-level variant annotation and functional impact prediction.. Valid values are `^(ENSP[0-9]{11}(.[0-9]+)?|NP_[0-9]+(.[0-9]+)?|XP_[0-9]+(.[0-9]+)?)$`',
    `refseq_accession` STRING COMMENT 'NCBI RefSeq transcript accession (NM_ for protein-coding mRNA, NR_ for non-coding RNA, XM_/XR_ for predicted models) with optional version. Used for clinical variant reporting and cross-reference to NCBI databases.. Valid values are `^(NM_|NR_|XM_|XR_)[0-9]+(.[0-9]+)?$`',
    `strand` STRING COMMENT 'DNA strand orientation of the transcript: + (forward/sense strand) or - (reverse/antisense strand). Critical for correct variant annotation and HGVS nomenclature generation.. Valid values are `+|-`',
    `transcript_end_position` STRING COMMENT 'Genomic coordinate (1-based) of the transcript end position (transcription termination site). Used for genomic range queries and variant overlap detection.',
    `transcript_length_bp` STRING COMMENT 'Total length of the transcript in base pairs, including all exons from transcription start to transcription end. Used for transcript size filtering and coverage depth calculations in sequencing QC.',
    `transcript_name` STRING COMMENT 'Human-readable name or symbol for the transcript, often derived from the gene symbol with a transcript-specific suffix (e.g., BRCA1-201, TP53-001).',
    `transcript_start_position` STRING COMMENT 'Genomic coordinate (1-based) of the transcript start position (transcription start site). Used for genomic range queries and variant overlap detection.',
    `transcript_support_level` STRING COMMENT 'Ensembl Transcript Support Level (1-5) indicating the quality of experimental evidence supporting the transcript structure: 1 (all splice junctions supported by at least one non-suspect mRNA), 2 (best supporting mRNA is flagged as suspect or support from multiple ESTs), 3 (only support is from single EST), 4 (best supporting EST is flagged as suspect), 5 (no single transcript supports the model structure). Lower values indicate higher confidence. Used for transcript filtering in clinical pipelines.',
    `utr_3_prime_end` STRING COMMENT 'Genomic coordinate (1-based) of the 3 UTR end position (transcript end). Null for non-coding transcripts or transcripts without annotated 3 UTR. Used for regulatory variant analysis and polyadenylation signal assessment.',
    `utr_3_prime_start` STRING COMMENT 'Genomic coordinate (1-based) of the 3 UTR start position (immediately after CDS end). Null for non-coding transcripts or transcripts without annotated 3 UTR. Used for regulatory variant analysis and polyadenylation signal assessment.',
    `utr_5_prime_end` STRING COMMENT 'Genomic coordinate (1-based) of the 5 UTR end position (immediately before CDS start). Null for non-coding transcripts or transcripts without annotated 5 UTR. Used for regulatory variant analysis.',
    `utr_5_prime_start` STRING COMMENT 'Genomic coordinate (1-based) of the 5 UTR start position (transcript start before the CDS). Null for non-coding transcripts or transcripts without annotated 5 UTR. Used for regulatory variant analysis.',
    CONSTRAINT pk_transcript_model PRIMARY KEY(`transcript_model_id`)
) COMMENT 'Reference catalog of gene transcripts associated with each gene model — capturing Ensembl transcript ID, RefSeq accession (NM_/NR_/XM_), transcript name, biotype (protein-coding, lncRNA, retained intron), canonical transcript flag, MANE Select flag, MANE Plus Clinical flag, exon count, CDS start/end, UTR coordinates, protein ID, transcript length (bp), genome build, and curation status. Critical for exon-level variant annotation, splice site analysis, and clinical reporting of coding variants in IVD/LDT assays.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` (
    `population_allele_frequency_id` BIGINT COMMENT 'Unique identifier for the population allele frequency record. Primary key for this reference data product.',
    `gene_model_id` BIGINT COMMENT 'Foreign key linking to reference.gene_model. Business justification: Population allele frequency records reference genes. The gene_symbol string attribute should be replaced with a proper FK to gene_model for referential integrity. Removes redundant gene_symbol which c',
    `transcript_model_id` BIGINT COMMENT 'RefSeq or Ensembl transcript identifier (e.g., NM_000277.1, ENST00000357654) for the canonical transcript affected by this variant.',
    `variant_database_version_id` BIGINT COMMENT 'Foreign key linking to reference.variant_database_version. Business justification: Population allele frequency data is sourced from specific versions of variant databases (gnomAD v3.1.2, 1000 Genomes Phase 3, etc.). Each frequency record should reference the exact database version f',
    `allele_count` STRING COMMENT 'Total number of times the alternate allele was observed in the population cohort. Used to calculate allele frequency.',
    `allele_frequency` DECIMAL(18,2) COMMENT 'Population-level allele frequency calculated as allele_count divided by allele_number. Core metric for MAF-based variant filtering and ACMG BA1/BS1 criteria application.',
    `allele_number` STRING COMMENT 'Total number of alleles successfully genotyped in the population cohort at this position. Denominator for allele frequency calculation.',
    `alternate_allele` STRING COMMENT 'The alternate (variant) allele sequence observed in the population at this genomic position.. Valid values are `^[ACGT]+$`',
    `chromosome` STRING COMMENT 'Chromosome on which the variant is located. Standard nomenclature: 1-22 for autosomes, X, Y for sex chromosomes, MT for mitochondrial DNA.. Valid values are `^(chr)?(1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|X|Y|MT)$`',
    `clinical_significance` STRING COMMENT 'Clinical interpretation of the variant if available from ClinVar or other clinical databases. Values include pathogenic, likely pathogenic, benign, likely benign, uncertain significance, or conflicting interpretations.',
    `consequence` STRING COMMENT 'Predicted functional consequence of the variant on the transcript using Sequence Ontology terms (e.g., missense_variant, synonymous_variant, frameshift_variant, splice_donor_variant).',
    `coverage_depth` STRING COMMENT 'Mean sequencing coverage depth at this genomic position in the source cohort. Indicator of data quality and confidence in frequency estimates.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this population allele frequency record was first ingested into the reference genomics data product. Supports audit trail and data lineage.',
    `data_source_url` STRING COMMENT 'URL or persistent identifier linking to the original source record in the external database (e.g., gnomAD browser link, dbSNP link). Supports audit trail and regulatory traceability.',
    `genome_build` STRING COMMENT 'Reference genome assembly version used for variant coordinates. Critical for reproducible genomic analysis and coordinate liftover.. Valid values are `GRCh37|hg19|GRCh38|hg38|T2T-CHM13`',
    `hemizygote_count` STRING COMMENT 'Number of individuals hemizygous for the alternate allele. Applicable to X and Y chromosome variants in males and mitochondrial variants.',
    `hgvs_coding` STRING COMMENT 'HGVS nomenclature for the variant at the coding DNA level (e.g., NM_000277.1:c.1521_1523delCTT). Standard for clinical reporting.',
    `hgvs_protein` STRING COMMENT 'HGVS nomenclature for the variant at the protein level (e.g., NP_000268.1:p.Phe508del). Used for clinical variant interpretation and reporting.',
    `homozygote_count` STRING COMMENT 'Number of individuals in the population cohort who are homozygous for the alternate allele (carry two copies).',
    `last_updated_date` DATE COMMENT 'Date when this population frequency record was last updated or refreshed from the source database. Critical for version control and reproducibility.',
    `minor_allele_frequency` DECIMAL(18,2) COMMENT 'Frequency of the less common allele in the population. Used for ACMG BA1/BS1 criteria: BA1 if MAF > 5%, BS1 if MAF > 1% in any general population database.',
    `notes` STRING COMMENT 'Free-text field for additional context, caveats, or annotations related to this population frequency record. May include information about population-specific considerations or data quality issues.',
    `population_group` STRING COMMENT 'Population ancestry group for which the allele frequency is calculated. Standard gnomAD population codes: AFR (African/African American), AMR (Latino/Admixed American), ASJ (Ashkenazi Jewish), EAS (East Asian), FIN (Finnish), NFE (Non-Finnish European), SAS (South Asian), OTH (Other), global (all populations combined). [ENUM-REF-CANDIDATE: global|AFR|AMR|ASJ|EAS|FIN|NFE|SAS|OTH — 9 candidates stripped; promote to reference product]',
    `position` BIGINT COMMENT 'Genomic coordinate position of the variant on the chromosome, 1-based coordinate system.',
    `qc_filter_status` STRING COMMENT 'Quality control filter status applied by the source database. PASS indicates the variant passed all QC filters; other values indicate specific QC failure reasons.. Valid values are `PASS|FAIL|LOW_COVERAGE|LOW_QUALITY|STRAND_BIAS|ALLELE_BALANCE`',
    `record_status` STRING COMMENT 'Lifecycle status of this reference data record. Active records are current and approved for use in analysis pipelines; deprecated or superseded records are retained for historical traceability.. Valid values are `active|deprecated|superseded|under_review`',
    `reference_allele` STRING COMMENT 'The reference allele sequence at this genomic position as defined by the reference genome assembly.. Valid values are `^[ACGT]+$`',
    `validation_status` STRING COMMENT 'Indicates whether the population frequency data has been independently validated or cross-referenced across multiple databases. Critical for regulatory-grade variant interpretation.. Valid values are `validated|unvalidated|conflicting|pending`',
    `variant_identifier` STRING COMMENT 'Standard variant identifier, typically rsID from dbSNP (e.g., rs123456) or HGVS nomenclature (e.g., NM_000277.1:c.1521_1523delCTT). Primary business identifier for the variant.',
    `variant_type` STRING COMMENT 'Classification of the variant by structural type. SNP (Single Nucleotide Polymorphism), insertion, deletion, indel (insertion-deletion), MNP (Multi-Nucleotide Polymorphism), or complex structural variant.. Valid values are `SNP|insertion|deletion|indel|MNP|complex`',
    CONSTRAINT pk_population_allele_frequency PRIMARY KEY(`population_allele_frequency_id`)
) COMMENT 'Reference table of population-level allele frequency data for known variants, sourced from gnomAD, 1000 Genomes, TOPMed, and internal cohort databases. Captures variant identifier (rsID/HGVS), chromosome, position, reference allele, alternate allele, genome build, population group (global, AFR, AMR, ASJ, EAS, FIN, NFE, SAS, OTH), allele count, allele number, allele frequency (AF), homozygote count, hemizygote count, source database version, and QC filter status. Foundational reference for MAF-based variant filtering, population stratification, and clinical variant classification (ACMG BA1/BS1 criteria).';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` (
    `pathway_database_id` BIGINT COMMENT 'Unique identifier for the pathway database reference record. Primary key.',
    `annotation_field_schema` STRING COMMENT 'Description or reference to the data schema and field structure used in the pathway database annotation files (e.g., GMT format, OBO format, JSON schema). Enables automated parsing and integration.',
    `approved_for_clinical_use` BOOLEAN COMMENT 'Indicates whether this pathway database version is approved for use in Clinical Laboratory Improvement Amendments (CLIA)-certified or In Vitro Diagnostic (IVD) clinical assays. Critical for regulatory compliance.',
    `approved_for_research_use` BOOLEAN COMMENT 'Indicates whether this pathway database version is approved for Research Use Only (RUO) applications and non-clinical bioinformatics workflows.',
    `checksum_md5` STRING COMMENT 'MD5 hash checksum of the pathway database file(s) for integrity verification. Ensures data has not been corrupted or tampered with during download or storage.',
    `citation_reference` STRING COMMENT 'Primary publication or DOI reference for citing the pathway database in scientific publications and regulatory submissions. Ensures proper attribution and traceability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pathway database reference record was first created in the system. Supports audit trail and data lineage.',
    `data_access_tier` STRING COMMENT 'Access control tier for the pathway database: public (open access), licensed (commercial license required), restricted (institutional agreement), internal (proprietary curation).. Valid values are `public|licensed|restricted|internal`',
    `database_code` STRING COMMENT 'Short standardized code or abbreviation for the pathway database used in bioinformatics pipelines and annotation workflows (e.g., KEGG, GO, REACTOME).',
    `database_name` STRING COMMENT 'Official name of the biological pathway or gene ontology database (e.g., KEGG, Reactome, Gene Ontology, MSigDB, WikiPathways, BioCarta).',
    `database_type` STRING COMMENT 'Classification of the pathway database by its primary biological focus (pathway, gene ontology, molecular signature, disease ontology, drug target, metabolic, signaling, regulatory). [ENUM-REF-CANDIDATE: pathway|gene_ontology|molecular_signature|disease_ontology|drug_target|metabolic|signaling|regulatory — 8 candidates stripped; promote to reference product]',
    `deprecation_date` DATE COMMENT 'Date on which this pathway database version was deprecated and removed from active use in bioinformatics pipelines. Null if still active.',
    `download_url` STRING COMMENT 'Official URL or repository location from which this pathway database version can be downloaded or accessed. Supports reproducibility and audit trails.',
    `file_format` STRING COMMENT 'Primary file format in which the pathway database is distributed (GMT, OBO, XML, JSON, TSV, RDF, BioPAX). Determines parsing and integration approach. [ENUM-REF-CANDIDATE: GMT|OBO|XML|JSON|TSV|RDF|BioPAX — 7 candidates stripped; promote to reference product]',
    `file_size_mb` DECIMAL(18,2) COMMENT 'Total file size of the pathway database distribution in megabytes. Used for storage planning and download time estimation.',
    `gene_count` STRING COMMENT 'Total number of unique genes annotated across all pathways in this database version. Indicates breadth of genomic coverage.',
    `genome_build_compatibility` STRING COMMENT 'Reference genome assembly versions compatible with this pathway database (e.g., GRCh38/hg38, GRCh37/hg19, T2T-CHM13). Critical for coordinate-based annotation alignment.',
    `integration_pipeline_count` STRING COMMENT 'Number of active bioinformatics pipelines currently using this pathway database version. Indicates usage footprint and impact of deprecation.',
    `license_type` STRING COMMENT 'Software or data license governing use of the pathway database (e.g., Creative Commons, Academic Free License, Commercial License, Proprietary). Defines permissible use in research and clinical workflows.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, known issues, usage recommendations, or special handling instructions for this pathway database version.',
    `organism_scope` STRING COMMENT 'Taxonomic scope of the pathway database (e.g., Homo sapiens, multi-species, pan-vertebrate). Defines applicability to genomic analysis workflows.',
    `pathway_count` STRING COMMENT 'Total number of biological pathways or gene sets contained in this database version. Used for coverage assessment and quality validation.',
    `pathway_database_status` STRING COMMENT 'Current lifecycle status of the pathway database reference: active (approved for use), deprecated (superseded by newer version), archived (retained for historical traceability), under_review (validation in progress), pending_approval (awaiting governance approval).. Valid values are `active|deprecated|archived|under_review|pending_approval`',
    `provider_organization` STRING COMMENT 'Organization or consortium responsible for curating and maintaining the pathway database (e.g., KEGG Organization, Reactome Consortium, Gene Ontology Consortium).',
    `release_date` DATE COMMENT 'Official release date of this pathway database version. Used to track currency of reference data and ensure version alignment across pipelines.',
    `superseded_by_version` STRING COMMENT 'Version identifier of the pathway database release that supersedes this version. Used to track version lineage and migration paths.',
    `update_frequency` STRING COMMENT 'Expected frequency of new releases or updates for the pathway database. Informs refresh schedules for bioinformatics pipelines and reference data governance.. Valid values are `monthly|quarterly|biannually|annually|irregular|deprecated`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this pathway database reference record was last modified. Supports audit trail and change tracking.',
    `validation_date` DATE COMMENT 'Date on which the pathway database version completed quality validation and was approved for use in bioinformatics workflows.',
    `validation_status` STRING COMMENT 'Quality validation status of the pathway database for use in regulated bioinformatics pipelines: validated (passed quality checks), pending_validation (under review), failed_validation (quality issues identified), not_required (validation not applicable for this use case).. Valid values are `validated|pending_validation|failed_validation|not_required`',
    `version` STRING COMMENT 'Version identifier of the pathway database release used in bioinformatics pipelines. Critical for reproducibility and regulatory traceability.',
    CONSTRAINT pk_pathway_database PRIMARY KEY(`pathway_database_id`)
) COMMENT 'Master catalog of biological pathway and gene ontology databases integrated into bioinformatics and research workflows — including KEGG, Reactome, GO (Gene Ontology), MSigDB, WikiPathways, and BioCarta. Captures database name, version, release date, pathway count, gene count, organism scope, data access tier, download URL, license type, annotation field schema, genome build compatibility, and active/deprecated status. Governs which pathway databases are approved for use in enrichment analysis, drug target identification, and functional annotation pipelines.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reference`.`pathway` (
    `pathway_id` BIGINT COMMENT 'Unique identifier for the biological pathway record. Primary key.',
    `parent_pathway_id` BIGINT COMMENT 'Reference to the parent pathway in hierarchical pathway databases (e.g., Reactome, GO). Enables navigation of pathway hierarchies from specific sub-pathways to broader biological processes. Null for top-level pathways.',
    `pathway_database_id` BIGINT COMMENT 'Foreign key linking to reference.pathway_database. Business justification: Pathways are sourced from specific pathway databases (KEGG, Reactome, etc.). Each pathway should reference its source database for provenance tracking. The pathway_source string attribute should be re',
    `clinical_relevance_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this pathway has established clinical relevance for disease diagnosis, prognosis, or treatment selection. True indicates the pathway is used in clinical genomics interpretation workflows.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this pathway record was first ingested into the enterprise data warehouse. Used for audit trails and data lineage tracking.',
    `cross_reference_ids` STRING COMMENT 'Pipe-separated list of equivalent pathway identifiers in other databases (e.g., Reactome:R-HSA-168256|GO:0006915|WikiPathways:WP254). Enables cross-database pathway mapping and integration of multi-source pathway annotations in bioinformatics pipelines.',
    `curation_status` STRING COMMENT 'Current curation and quality assurance status of the pathway record (curated = expert-reviewed and validated; reviewed = peer-reviewed; provisional = preliminary curation; deprecated = superseded by newer version; retired = no longer maintained). Ensures only high-quality, auditable reference data is used in regulatory-grade variant interpretation.. Valid values are `curated|reviewed|provisional|deprecated|retired`',
    `disease_association_count` STRING COMMENT 'The number of diseases or clinical phenotypes associated with this pathway in curated disease-pathway databases (e.g., KEGG Disease, DisGeNET, OMIM). Used to prioritize pathways in clinical variant interpretation and disease gene discovery.',
    `drug_target_count` STRING COMMENT 'The number of FDA-approved or investigational drugs that target genes or proteins in this pathway. Used for drug repurposing analysis, precision medicine target identification, and pharmacogenomics workflows.',
    `effective_end_date` DATE COMMENT 'The date when this pathway version was superseded by a newer version or deprecated. Null for currently active pathways. Used for temporal versioning and audit trails in regulatory-grade genomic analysis pipelines.',
    `effective_start_date` DATE COMMENT 'The date from which this pathway version became the active reference in the enterprise data warehouse. Used for temporal versioning and reproducibility of historical genomic analyses.',
    `external_code` STRING COMMENT 'The externally-known unique identifier from the source pathway database (e.g., KEGG pathway ID hsa04010, Reactome ID R-HSA-168256, GO ID GO:0006915). This is the canonical identifier used in scientific literature and bioinformatics pipelines.',
    `gene_member_count` STRING COMMENT 'The total number of genes that are members of this pathway. Used for statistical power calculations in gene-set enrichment analysis (GSEA) and pathway over-representation analysis.',
    `hierarchy_level` STRING COMMENT 'The depth level of this pathway in the hierarchical pathway taxonomy (e.g., 1 = top-level category, 2 = sub-category, 3 = specific pathway). Used for hierarchical pathway enrichment analysis and multi-level pathway visualization. Null for non-hierarchical pathway databases.',
    `is_active` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this pathway record is currently active and should be used in production bioinformatics pipelines. False indicates the pathway is deprecated or retired and should not be used for new analyses.',
    `last_curated_date` DATE COMMENT 'The date when this pathway record was last reviewed and updated by expert curators in the source database. Used to assess data freshness and prioritize pathways for re-curation in quality assurance workflows.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this pathway record was last modified in the enterprise data warehouse. Used for change tracking, audit trails, and data quality monitoring.',
    `oncology_relevance_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this pathway is relevant to cancer biology, tumor progression, or oncology therapeutics. True indicates the pathway is used in oncology genomics analysis and precision oncology workflows.',
    `organism` STRING COMMENT 'The organism or species for which this pathway is defined (e.g., Homo sapiens, Mus musculus, Pan-species). Critical for species-specific genomic analysis and cross-species comparative genomics.',
    `organism_code` STRING COMMENT 'The standardized three-letter organism code (e.g., hsa for Homo sapiens, mmu for Mus musculus) used in pathway databases for compact representation and cross-referencing.',
    `pathway_category` STRING COMMENT 'High-level functional classification of the pathway (e.g., metabolic, signaling, disease, immune response, cell cycle, DNA repair, apoptosis, development, transport). Used for filtering and grouping pathways in enrichment analysis and variant interpretation workflows. [ENUM-REF-CANDIDATE: metabolic|signaling|disease|immune|cell_cycle|dna_repair|apoptosis|development|transport|other — 10 candidates stripped; promote to reference product]',
    `pathway_description` STRING COMMENT 'Detailed textual description of the biological pathway, including its function, key molecular interactions, regulatory mechanisms, and biological significance. Used for pathway interpretation and reporting in clinical genomics workflows.',
    `pathway_name` STRING COMMENT 'The human-readable name of the biological pathway (e.g., MAPK signaling pathway, Apoptosis, Cell cycle). This is the primary label used by researchers and clinicians.',
    `pharmacogenomics_relevance_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this pathway is relevant to drug metabolism, drug response, or adverse drug reactions. True indicates the pathway is used in pharmacogenomics analysis and precision medicine drug selection workflows.',
    `url` STRING COMMENT 'Direct hyperlink to the pathway record in the source database (e.g., https://www.kegg.jp/pathway/hsa04010, https://reactome.org/content/detail/R-HSA-168256). Enables one-click access to authoritative pathway diagrams and detailed annotations for researchers and clinical scientists.',
    `version` STRING COMMENT 'Version identifier of the pathway definition from the source database (e.g., v84, 2023-Q2). Critical for reproducibility and audit trails in regulatory-grade genomic analysis pipelines.',
    CONSTRAINT pk_pathway PRIMARY KEY(`pathway_id`)
) COMMENT 'Reference catalog of individual biological pathways curated from approved pathway databases — capturing pathway ID, pathway name, pathway source (KEGG/Reactome/GO), pathway category (metabolic/signaling/disease/immune/cell cycle), gene member count, organism, parent pathway ID (for hierarchical pathways), description, clinical relevance flag, oncology relevance flag, pharmacogenomics relevance flag, and curation status. Enables gene-set enrichment analysis, drug target pathway mapping, and functional interpretation of variant impact in research and clinical genomics workflows.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reference`.`gene_pathway_link` (
    `gene_pathway_link_id` BIGINT COMMENT 'Primary key for gene_pathway_link',
    `gene_model_id` BIGINT COMMENT 'Foreign key linking to reference.gene_model. Business justification: The gene_pathway_link association entity should reference the authoritative gene_model table rather than storing gene identifiers as strings. This ensures referential integrity and enables proper JOIN',
    `pathway_id` BIGINT COMMENT 'Unique identifier for the biological pathway from the source database (e.g., KEGG pathway ID hsa04110, Reactome ID R-HSA-168256, GO term GO:0006915). Serves as the primary key for pathway reference and enables cross-database pathway enrichment analysis.',
    `annotation_source` STRING COMMENT 'Method by which the gene-pathway association was annotated. Automated indicates computational pipeline without human review; manual indicates expert curator review; hybrid indicates computational prediction followed by manual validation. Influences data quality tier and suitability for regulatory-grade clinical assays.. Valid values are `automated|manual|hybrid`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this gene-pathway association record was first created in the internal reference data repository. Supports audit trails for regulatory compliance (FDA 21 CFR Part 11, ISO 13485), data lineage tracking, and historical analysis of pathway annotation evolution.',
    `cross_reference_code` STRING COMMENT 'Semicolon-separated list of equivalent pathway identifiers from other databases (e.g., GO:0006915; R-HSA-109581; hsa04210), enabling cross-database pathway mapping and integration of multi-source pathway annotations in bioinformatics pipelines.',
    `curation_date` DATE COMMENT 'Date on which the gene-pathway association was curated, validated, or last reviewed by the source database or internal bioinformatics team. Supports data versioning, audit trails for regulatory submissions (FDA 21 CFR Part 11, ISO 13485), and enables time-based filtering to exclude outdated annotations.',
    `data_source_version` STRING COMMENT 'Version or release identifier of the external reference database from which this record was ingested (e.g., KEGG 2024-01, Reactome v83, GO 2023-11-01). Critical for reproducibility, regulatory audit trails, and managing reference data updates in clinical genomics pipelines.',
    `evidence_code` STRING COMMENT 'Gene Ontology (GO) evidence code indicating the type of evidence supporting the gene-pathway association. EXP=experimental; IDA=direct assay; IPI=physical interaction; IMP=mutant phenotype; IGI=genetic interaction; IEP=expression pattern; TAS=traceable author statement; NAS=non-traceable author statement; IC=inferred by curator; IEA=inferred from electronic annotation; ISS=inferred from sequence similarity; ISO=inferred from sequence orthology; ISA=inferred from sequence alignment; ISM=inferred from sequence model; IGC=inferred from genomic context; IBA=inferred from biological aspect of ancestor; IBD=inferred from biological aspect of descendant; IKR=inferred from key residues; IRD=inferred from rapid divergence; RCA=inferred from reviewed computational analysis; ND=no biological data available. Critical for regulatory-grade variant interpretation and clinical assay validation. [ENUM-REF-CANDIDATE: EXP|IDA|IPI|IMP|IGI|IEP|TAS|NAS|IC|IEA|ISS|ISO|ISA|ISM|IGC|IBA|IBD|IKR|IRD|RCA|ND — 21 candidates stripped; promote to reference product]',
    `evidence_source_pmid` STRING COMMENT 'PubMed identifier (PMID) of the peer-reviewed publication providing experimental or computational evidence for the gene-pathway association. Enables traceability to primary literature for regulatory submissions (FDA, EMA) and supports reproducibility requirements under NIH Genomic Data Sharing Policy.',
    `gene_role_in_pathway` STRING COMMENT 'Functional role or mechanism by which the gene participates in the pathway (e.g., enzyme, receptor, transcription factor, structural component, regulator, inhibitor, activator). Provides mechanistic context for variant effect prediction and drug target prioritization.',
    `genome_build` STRING COMMENT 'Reference genome assembly version to which the gene coordinates and Ensembl gene ID are anchored (e.g., GRCh38/hg38, GRCh37/hg19, T2T-CHM13). Critical for ensuring coordinate consistency across variant calling, annotation pipelines, and regulatory submissions. Mismatched genome builds are a leading cause of variant interpretation errors in clinical genomics.. Valid values are `GRCh38|hg38|GRCh37|hg19|T2T-CHM13`',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this gene-pathway association is currently active and should be used in downstream bioinformatics pipelines. Inactive records represent deprecated annotations, retracted publications, or superseded pathway definitions. Supports data lifecycle management and ensures only validated associations are used in clinical variant interpretation.',
    `is_disease_associated` BOOLEAN COMMENT 'Boolean flag indicating whether the pathway is directly associated with a disease phenotype or clinical condition (e.g., cancer pathways, metabolic disorder pathways, immune deficiency pathways). Used to prioritize pathways in clinical variant interpretation and to filter gene sets for disease-focused enrichment analysis.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this gene-pathway association record in the internal reference data repository. Supports audit trails for GxP compliance (Good Practice Regulations), data lineage tracking, and incremental ETL refresh logic in the Databricks lakehouse silver layer.',
    `membership_confidence_score` DECIMAL(18,2) COMMENT 'Quantitative confidence score (0.0000 to 1.0000) representing the strength of evidence supporting the gene-pathway association. Derived from evidence code, publication impact factor, replication count, and cross-database concordance. Used to filter low-confidence associations in clinical variant interpretation pipelines and to prioritize gene sets for functional enrichment analysis.',
    `membership_role` STRING COMMENT 'Classification of how the gene participates in the pathway. Direct indicates experimentally validated membership; inferred indicates computational prediction based on homology or network analysis; predicted indicates machine learning or statistical inference; curated indicates expert manual review. Influences confidence scoring in pathway enrichment analysis.. Valid values are `direct|inferred|predicted|curated`',
    `pathway_source_database` STRING COMMENT 'Name of the authoritative pathway database from which this gene-pathway association was derived. Critical for data provenance, citation requirements, and resolving conflicts when the same gene-pathway pair appears in multiple databases with different evidence levels. [ENUM-REF-CANDIDATE: KEGG|Reactome|GO|BioCarta|WikiPathways|PANTHER|MSigDB — 7 candidates stripped; promote to reference product]',
    `quality_flag` STRING COMMENT 'Data quality classification for the gene-pathway association. Validated indicates high-confidence, multi-source concordance; provisional indicates single-source or low-evidence; deprecated indicates retracted or superseded; conflicting indicates contradictory evidence across databases. Used to filter associations for clinical-grade vs research-use-only (RUO) pipelines.. Valid values are `validated|provisional|deprecated|conflicting`',
    `species` STRING COMMENT 'Taxonomic species for which the gene-pathway association is defined. Homo sapiens is the primary species for clinical genomics; model organisms (mouse, rat, zebrafish, fly, worm) are included to support translational research and cross-species pathway conservation analysis.. Valid values are `Homo sapiens|Mus musculus|Rattus norvegicus|Danio rerio|Drosophila melanogaster|Caenorhabditis elegans`',
    CONSTRAINT pk_gene_pathway_link PRIMARY KEY(`gene_pathway_link_id`)
) COMMENT 'Association entity linking gene models to biological pathways, capturing the many-to-many relationship between genes and pathways with business-relevant metadata. Records gene symbol, Ensembl gene ID, pathway ID, pathway source database, membership role (direct/inferred), evidence code (experimental/computational/curated), evidence source publication (PMID), membership confidence score, genome build, and curation date. Enables pathway-level gene set queries, enrichment analysis inputs, and functional annotation of variant-affected genes across research and clinical genomics pipelines.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` (
    `genomic_region_id` BIGINT COMMENT 'Unique identifier for the genomic region record. Primary key.',
    `gene_model_id` BIGINT COMMENT 'Foreign key linking to reference.gene_model. Business justification: Genomic regions may be associated with specific genes (e.g., exon regions, gene panels). The associated_gene_symbol and associated_gene_id string attributes should be replaced with a proper nullable F',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Genomic regions are defined on a specific reference genome assembly. The genome_build string attribute should be replaced with a proper FK to genome_assembly for referential integrity. Removes redunda',
    `superseded_by_region_genomic_region_id` BIGINT COMMENT 'Identifier of the genomic region record that supersedes this record, if this record has been deprecated or replaced.',
    `approval_date` DATE COMMENT 'Date on which the genomic region record was approved for production use.',
    `approval_status` STRING COMMENT 'Approval status of the genomic region for use in clinical or production workflows, following internal quality and regulatory review.. Valid values are `approved|pending_approval|rejected|under_validation`',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or role who approved this genomic region record for production use.',
    `artifact_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this region is known to produce sequencing artifacts or false-positive variant calls (True if artifact region, False otherwise).',
    `assay_design_purpose` STRING COMMENT 'Intended use or purpose of this genomic region in assay design (e.g., variant detection, copy number analysis, quality control, artifact exclusion).',
    `bed_file_path` STRING COMMENT 'File system or cloud storage path to the BED format file containing the detailed coordinates for this region or region set.',
    `checksum_md5` STRING COMMENT 'MD5 hash checksum of the BED file or region definition, ensuring data integrity and detecting unauthorized modifications.. Valid values are `^[a-f0-9]{32}$`',
    `chromosome` STRING COMMENT 'Chromosome on which the genomic region is located (e.g., chr1, chr22, chrX, chrY, chrM).. Valid values are `^(chr)?([1-9]|1[0-9]|2[0-2]|X|Y|M|MT)$`',
    `clinical_significance` STRING COMMENT 'Clinical interpretation of the genomic region or variants within it, following ACMG/AMP guidelines where applicable. [ENUM-REF-CANDIDATE: pathogenic|likely_pathogenic|uncertain_significance|likely_benign|benign|actionable|not_applicable — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this genomic region record was first created in the data platform.',
    `data_source_system` STRING COMMENT 'Name of the source system or database from which this genomic region record was ingested (e.g., Benchling, LIMS, NCBI, ENCODE).',
    `effective_end_date` DATE COMMENT 'Date until which this genomic region record is effective; nullable for records that remain active indefinitely.',
    `effective_start_date` DATE COMMENT 'Date from which this genomic region record is effective and valid for use in production pipelines.',
    `end_position` BIGINT COMMENT 'Zero-based or one-based end coordinate of the genomic region on the reference genome assembly.',
    `gc_content_percent` DECIMAL(18,2) COMMENT 'Percentage of guanine (G) and cytosine (C) bases in the genomic region, relevant for sequencing bias assessment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this genomic region record was last modified or updated in the data platform.',
    `mappability_score` DECIMAL(18,2) COMMENT 'Mappability score (0.00 to 1.00) indicating how uniquely sequencing reads can be aligned to this region; higher scores indicate better mappability.',
    `modified_by` STRING COMMENT 'Name or identifier of the user or system process that last modified this genomic region record.',
    `region_description` STRING COMMENT 'Detailed textual description of the genomic region, including its biological function, clinical relevance, or technical purpose.',
    `region_identifier` STRING COMMENT 'Externally-known unique identifier or accession number for the region (e.g., vendor catalog number, ENCODE identifier, dbSNP rsID for SNP regions).',
    `region_length_bp` BIGINT COMMENT 'Length of the genomic region in base pairs, calculated as end_position minus start_position.',
    `region_name` STRING COMMENT 'Human-readable name or label for the genomic region (e.g., BRCA1_exon2, chr1_centromere, ACMG_SF_v3.2_gene_panel).',
    `region_set_name` STRING COMMENT 'Name of the parent region set or collection to which this region belongs (e.g., Agilent SureSelect v8, ACMG SF v3.2, ENCODE Blacklist v2).',
    `region_set_version` STRING COMMENT 'Version identifier of the parent region set (e.g., v8, v3.2, 2023-Q1).',
    `region_status` STRING COMMENT 'Current lifecycle status of the genomic region record indicating whether it is approved for use in production pipelines.. Valid values are `active|deprecated|under_review|draft|retired`',
    `region_type` STRING COMMENT 'Classification of the genomic region by its biological, clinical, or technical function. [ENUM-REF-CANDIDATE: exome_capture_target|gene_panel|blacklist_region|artifact_region|segmental_duplication|repeat_masked_region|centromere|telomere|coding_exon|regulatory_element|structural_variant|copy_number_variant — 12 candidates stripped; promote to reference product]',
    `regulatory_classification` STRING COMMENT 'Regulatory classification of the region set: IVD (In Vitro Diagnostic), RUO (Research Use Only), LDT (Laboratory Developed Test), or not applicable.. Valid values are `IVD|RUO|LDT|not_applicable`',
    `repeat_masked_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this region is masked due to repetitive DNA sequences (True if repeat-masked, False otherwise).',
    `source_authority` STRING COMMENT 'Name of the authoritative body or database that curated or published the region definition (e.g., NCBI, ENCODE, ACMG, gnomAD, ClinVar).',
    `source_publication` STRING COMMENT 'PubMed ID (PMID) or DOI of the scientific publication that describes or validates this genomic region.',
    `source_vendor` STRING COMMENT 'Name of the vendor or manufacturer that provided the region definition (e.g., Agilent, Illumina, Twist Bioscience, Roche).',
    `start_position` BIGINT COMMENT 'Zero-based or one-based start coordinate of the genomic region on the reference genome assembly.',
    `strand` STRING COMMENT 'DNA strand orientation of the genomic region: + (forward/sense), - (reverse/antisense), or . (unstranded/not applicable).. Valid values are `+|-|.`',
    `target_coverage_depth` STRING COMMENT 'Recommended or expected sequencing coverage depth (number of reads) for this genomic region in quality control assessments.',
    `version_number` STRING COMMENT 'Version number of this genomic region record, supporting version control and audit trail for regulatory compliance.',
    CONSTRAINT pk_genomic_region PRIMARY KEY(`genomic_region_id`)
) COMMENT 'Reference catalog of curated genomic regions and region sets of biological, clinical, or technical significance. Encompasses exome capture targets, clinically actionable gene panels, blacklist/artifact regions, segmental duplications, repeat-masked regions, centromeres/telomeres, and named region sets (e.g., Agilent SureSelect v8, ACMG SF v3.2, ENCODE blacklist). Captures region identity, type classification, coordinates (chromosome/start/end/strand), genome build, parent set membership, associated gene, clinical significance, BED file path, source vendor/authority, version, and approval status. Foundational reference for assay design, coverage QC, variant filtering, and artifact exclusion in NGS workflows.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` (
    `acmg_classification_rule_id` BIGINT COMMENT 'Unique identifier for the ACMG/AMP variant classification evidence rule record. Primary key.',
    `acmg_classification_rule_status` STRING COMMENT 'Current lifecycle status of this evidence code specification. Active rules are used in production variant interpretation; deprecated rules are retained for historical audit but not applied to new cases.. Valid values are `active|deprecated|draft|under_review`',
    `allelic_data_requirement` STRING COMMENT 'Description of requirements related to allelic phase, compound heterozygosity, or trans configuration for this evidence code. Applicable to PM3, BP2 criteria.',
    `applicable_gene_contexts` STRING COMMENT 'Description of gene or disease mechanism contexts where this evidence code is applicable (e.g., genes where loss-of-function is a known disease mechanism, genes with established functional domains). May reference specific gene lists or disease categories.',
    `applicable_variant_types` STRING COMMENT 'Comma-separated list or description of variant types to which this evidence code applies (e.g., nonsense, frameshift, canonical splice site, missense, in-frame indel). Defines the molecular consequence scope.',
    `authoritative_source` STRING COMMENT 'The authoritative body or publication that defines this evidence code (e.g., ACMG/AMP 2015 Guidelines, ClinGen Hearing Loss Expert Panel, ClinGen CDH1 Variant Curation Expert Panel).',
    `automation_flag` BOOLEAN COMMENT 'Indicates whether this evidence code can be fully or partially automated in computational variant annotation pipelines (True) or requires manual expert review (False).',
    `clingen_refinement_specification` STRING COMMENT 'Reference to ClinGen-specific refinements, gene-disease-specific adaptations, or expert panel recommendations that modify or clarify the application of this evidence code for particular contexts.',
    `computational_prediction_requirement` STRING COMMENT 'Description of in silico prediction tool requirements and consensus thresholds for this evidence code (e.g., multiple lines of computational evidence support deleterious effect). Applicable to PP3, BP4 criteria.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this evidence code record was first created in the reference data system. Supports audit trail and data lineage for regulatory compliance.',
    `data_source_requirements` STRING COMMENT 'List or description of required reference databases, population frequency datasets, functional assay repositories, or literature sources needed to apply this evidence code (e.g., gnomAD, ClinVar, HGMD, functional studies).',
    `de_novo_requirement` STRING COMMENT 'Description of de novo variant occurrence requirements for this evidence code, including maternity/paternity confirmation standards. Applicable to PS2, PM6 criteria.',
    `effective_date` DATE COMMENT 'The date from which this version of the evidence code specification became effective and should be applied in variant interpretation workflows.',
    `evidence_category` STRING COMMENT 'High-level classification of whether this evidence code supports pathogenic or benign interpretation of variants.. Valid values are `pathogenic|benign`',
    `evidence_code` STRING COMMENT 'The standardized ACMG/AMP evidence code identifier (e.g., PVS1, PS1, PM1, PP1, BA1, BS1, BP1). Defines the specific criterion used for variant pathogenicity assessment. [ENUM-REF-CANDIDATE: PVS1|PS1|PS2|PS3|PS4|PM1|PM2|PM3|PM4|PM5|PM6|PP1|PP2|PP3|PP4|PP5|BA1|BS1|BS2|BS3|BS4|BP1|BP2|BP3|BP4|BP5|BP6|BP7 — 28 candidates stripped; promote to reference product]',
    `evidence_description` STRING COMMENT 'Detailed textual description of the evidence criterion, including the biological or clinical rationale, applicability conditions, and interpretation guidance.',
    `evidence_name` STRING COMMENT 'Human-readable short name or title of the evidence criterion (e.g., Null variant in a gene where LOF is a known mechanism, Same amino acid change as established pathogenic variant).',
    `expiration_date` DATE COMMENT 'The date after which this version of the evidence code specification is superseded or no longer valid. Null if currently active.',
    `frequency_threshold` DECIMAL(18,2) COMMENT 'Numeric threshold for population allele frequency (MAF) used in applying this evidence code, if applicable. For example, BA1 uses a threshold of >5% in population databases. Null if not frequency-based.',
    `functional_assay_requirement` STRING COMMENT 'Description of functional or experimental evidence requirements for this criterion (e.g., well-established functional studies showing damaging effect, validated assay demonstrating normal function). Applicable to PS3, BS3, and related codes.',
    `implementation_logic` STRING COMMENT 'Structured or semi-structured description of the computational or manual logic required to evaluate this evidence code. May include decision trees, data source requirements, thresholds, or algorithmic steps for automated variant annotation pipelines.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this evidence code record. Tracks changes to specifications, refinements, or metadata over time.',
    `manual_review_required` BOOLEAN COMMENT 'Indicates whether application of this evidence code mandates manual review by a clinical molecular geneticist or variant scientist, even if computational pre-screening is performed.',
    `notes` STRING COMMENT 'Free-text field for additional implementation guidance, edge case handling, known limitations, or clarifications for variant scientists and bioinformaticians applying this evidence code.',
    `phenotype_specificity_requirement` STRING COMMENT 'Description of patient phenotype matching requirements for this evidence code, including specificity of clinical features to the gene-disease association. Applicable to PP4 criterion.',
    `publication_reference` STRING COMMENT 'Citation or PubMed identifier (PMID) for the primary publication or guideline document that defines this evidence code.',
    `reputable_source_requirement` STRING COMMENT 'Description of requirements for reputable source reporting of this variant as pathogenic or benign, including acceptable databases and curation standards. Applicable to PP5, BP6 criteria.',
    `segregation_requirement` STRING COMMENT 'Description of family segregation analysis requirements for this evidence code, including minimum number of affected family members or LOD score thresholds. Applicable to PP1 and related criteria.',
    `strength_level` STRING COMMENT 'The weight or strength tier assigned to this evidence code (very strong, strong, moderate, supporting, or stand-alone for benign criteria). Determines the contribution of this criterion to the final pathogenicity classification.. Valid values are `very_strong|strong|moderate|supporting|stand_alone`',
    `version` STRING COMMENT 'Version identifier for this evidence code specification, tracking updates to interpretation guidelines, ClinGen refinements, or expert panel recommendations over time.',
    CONSTRAINT pk_acmg_classification_rule PRIMARY KEY(`acmg_classification_rule_id`)
) COMMENT 'Reference catalog of ACMG/AMP variant classification evidence criteria (PVS1 through BP7) with their strength tiers, applicable variant types, gene/disease contexts, and ClinGen-refined specifications. Each record defines one evidence codes logic, applicability conditions, and implementation rules for automated and manual variant classification. Authoritative reference ensuring consistent, auditable application of pathogenicity classification standards across all clinical variant interpretation workflows.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` (
    `ontology_term_id` BIGINT COMMENT 'Unique identifier for the ontology term record. Primary key.',
    `parent_term_ontology_term_id` BIGINT COMMENT 'The term identifier of the immediate parent term in the ontology hierarchy (e.g., for HP:0001250 Seizure, the parent might be HP:0012638 Abnormality of nervous system physiology). Supports hierarchical navigation and subsumption reasoning. May be null for root terms.',
    `primary_replacement_term_ontology_term_id` BIGINT COMMENT 'The term identifier of the replacement or successor term if this term has been deprecated. Null if not deprecated or if no replacement is specified.',
    `child_term_count` STRING COMMENT 'The number of immediate child terms (direct descendants) of this term in the ontology hierarchy. Supports navigation and ontology structure analysis.',
    `comment` STRING COMMENT 'Free-text editorial comment or note about the term, its usage, or its relationship to other terms. May include curator notes, usage warnings, or clarifications.',
    `created_date` DATE COMMENT 'The date when this term was first introduced into the source ontology (format: yyyy-MM-dd). Supports temporal analysis and version tracking.',
    `cross_references` STRING COMMENT 'Pipe-separated list of equivalent or related term identifiers in other ontologies or coding systems (e.g., UMLS:C0036572|SNOMEDCT:91175000|MeSH:D012640). Enables interoperability and cross-ontology mapping.',
    `curation_status` STRING COMMENT 'The internal curation or review status of this term within the enterprise reference data governance workflow. Indicates whether the term has been validated for use in production genomics pipelines.. Valid values are `curated|automated|pending_review|approved|rejected`',
    `deprecated_date` DATE COMMENT 'The date when this term was deprecated or obsoleted (format: yyyy-MM-dd). Null if the term is not deprecated. Supports regulatory audit trails and data quality monitoring.',
    `evidence_code` STRING COMMENT 'The evidence code or provenance indicator describing the basis for the terms inclusion or annotation (e.g., IEA for Inferred from Electronic Annotation, TAS for Traceable Author Statement in GO). Supports data quality assessment.',
    `hierarchy_level` STRING COMMENT 'The depth or level of this term in the ontology hierarchy, with root terms at level 0. Supports hierarchical queries and subsumption analysis.',
    `ingestion_timestamp` TIMESTAMP COMMENT 'The timestamp when this ontology term record was ingested into the enterprise reference data repository (format: yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports data lineage and audit trails.',
    `is_deprecated` BOOLEAN COMMENT 'Boolean flag indicating whether this term has been deprecated or obsoleted in the source ontology. True if deprecated, False if active.',
    `is_root_term` BOOLEAN COMMENT 'Boolean flag indicating whether this term is a root or top-level term in the ontology hierarchy (i.e., has no parent term). True if root, False otherwise.',
    `last_modified_date` DATE COMMENT 'The date when this term was last updated or modified in the source ontology (format: yyyy-MM-dd). Critical for change tracking and data lineage.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this ontology term record was last updated in the enterprise reference data repository (format: yyyy-MM-ddTHH:mm:ss.SSSXXX). Critical for change data capture and incremental processing.',
    `last_used_date` DATE COMMENT 'The most recent date when this term was used in a production annotation, variant interpretation, or clinical report (format: yyyy-MM-dd). Supports term lifecycle management and archival decisions.',
    `namespace` STRING COMMENT 'The namespace or sub-ontology within the source ontology to which this term belongs (e.g., biological_process, molecular_function, cellular_component for GO terms). Provides additional categorization within large ontologies.',
    `ontology_source` STRING COMMENT 'The source ontology or terminology system from which this term originates (e.g., HPO for Human Phenotype Ontology, OMIM for Online Mendelian Inheritance in Man, SNOMED CT for Systematized Nomenclature of Medicine Clinical Terms, SO for Sequence Ontology). [ENUM-REF-CANDIDATE: HPO|OMIM|MedGen|SNOMED CT|ICD-10|ICD-11|LOINC|SO|GO|MONDO|ORDO|GARD|NCIT|UBERON|CL|CHEBI|RxNorm|CPT|HGNC — 19 candidates stripped; promote to reference product]',
    `ontology_version` STRING COMMENT 'The version or release identifier of the source ontology from which this term was extracted (e.g., 2023-10-09, v2023.4, Release 20231101). Critical for reproducibility and regulatory traceability.',
    `regulatory_applicability` STRING COMMENT 'Pipe-separated list of regulatory contexts or jurisdictions for which this term is applicable or required (e.g., FDA|EMA|CLIA|CAP). Supports compliance-driven term selection for clinical reporting.',
    `source_url` STRING COMMENT 'The canonical URL or persistent identifier (e.g., PURL, DOI) for accessing the authoritative definition and metadata for this term in the source ontology (e.g., http://purl.obolibrary.org/obo/HP_0001250).',
    `subset_membership` STRING COMMENT 'Pipe-separated list of subset or slim identifiers to which this term belongs (e.g., goslim_generic|goslim_plant for GO terms, hpo_slim for HPO). Subsets are curated collections of terms for specific use cases or communities.',
    `synonyms` STRING COMMENT 'Pipe-separated list of alternative names, aliases, or synonyms for the term (e.g., epileptic seizure|convulsion|fit). Supports flexible search and mapping from clinical free-text.',
    `term_accession` STRING COMMENT 'The canonical identifier for the ontology term as assigned by the source ontology (e.g., HP:0001250 for HPO, OMIM:600354, SNOMED:73211009). Format is typically prefix:numeric_code.. Valid values are `^[A-Z]+:[0-9]{7,10}$`',
    `term_definition` STRING COMMENT 'The formal textual definition of the ontology term as provided by the source ontology. Describes the precise meaning, scope, and usage of the term.',
    `term_name` STRING COMMENT 'The human-readable label or preferred name for the ontology term (e.g., Seizure, Hypertrophic cardiomyopathy, Single nucleotide variant).',
    `term_status` STRING COMMENT 'The current lifecycle status of the ontology term within the reference data governance framework. Active terms are approved for use in production workflows; deprecated terms are retained for historical traceability but should not be used for new annotations.. Valid values are `active|deprecated|provisional|retired`',
    `term_type` STRING COMMENT 'The ontological type or role of this term within the ontology structure (e.g., class for concepts, property for relationships, individual for instances). Supports ontology reasoning and semantic validation.. Valid values are `class|property|individual|annotation_property|object_property|data_property`',
    `usage_frequency` STRING COMMENT 'The count of how many times this term has been used in annotations, variant interpretations, or clinical reports within the enterprise. Supports term prioritization and quality metrics.',
    `use_case_category` STRING COMMENT 'The primary domain or use case category for which this term is applicable (e.g., phenotype for HPO terms, disease for OMIM/MONDO, variant for SO terms, observation for LOINC). Supports filtering and context-specific term selection. [ENUM-REF-CANDIDATE: phenotype|disease|variant|sequence|gene|pathway|drug|procedure|observation|specimen — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_ontology_term PRIMARY KEY(`ontology_term_id`)
) COMMENT 'Reference catalog of standardized ontology terms used across genomics workflows — including HPO (Human Phenotype Ontology), OMIM, MedGen, SNOMED CT, ICD-10, LOINC, and SO (Sequence Ontology) terms. Captures term ID, term name, ontology source, ontology version, term definition, parent term ID (for hierarchy), synonyms, cross-references to other ontologies, deprecated flag, replacement term ID, and applicable use cases (phenotype/disease/variant/sequence). Enables consistent phenotype-genotype mapping, clinical reporting standardization, and interoperability with external clinical and research systems.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` (
    `pharmacogenomics_marker_id` BIGINT COMMENT 'Unique identifier for the pharmacogenomics marker record. Primary key. Inferred role: MASTER_RESOURCE (reference catalog of PGx variant markers).',
    `gene_model_id` BIGINT COMMENT 'Foreign key linking to reference.gene_model. Business justification: Pharmacogenomics markers are associated with specific genes (e.g., CYP2D6, TPMT). The gene_symbol and gene_name string attributes should be replaced with a proper FK to gene_model for referential inte',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Pharmacogenomics markers are positioned on a specific reference genome assembly. The reference_genome_build string attribute should be replaced with a proper FK to genome_assembly for referential inte',
    `alternate_allele` STRING COMMENT 'Alternate (variant) allele sequence (e.g., G, T, ACGTT). Null for star alleles or diplotypes that represent multi-variant haplotypes.. Valid values are `^[ACGTN]+$`',
    `associated_drugs` STRING COMMENT 'Comma-separated list of drugs for which this PGx marker has documented gene-drug interactions and clinical actionability (e.g., codeine, tamoxifen, clopidogrel, warfarin, fluorouracil). Enables drug-specific PGx reporting.',
    `chromosome` STRING COMMENT 'Chromosome location of the variant (e.g., chr22, 10, X, MT). Follows UCSC or Ensembl chromosome naming conventions.. Valid values are `^(chr)?([1-9]|1[0-9]|2[0-2]|X|Y|MT?)$`',
    `clinical_actionability_status` STRING COMMENT 'Current clinical actionability classification: actionable (guideline-supported dosing or therapy change), informative (known association but no specific guideline), research_only (insufficient evidence for clinical use), or uncertain (conflicting evidence). Lifecycle status field for PGx marker.. Valid values are `actionable|informative|research_only|uncertain`',
    `clinical_annotation` STRING COMMENT 'Free-text clinical interpretation and actionability guidance for the marker, including dosing recommendations, contraindications, or alternative therapy suggestions (e.g., Consider 50% dose reduction for CYP2D6 poor metabolizers on codeine; avoid fluorouracil in DPYD deficiency).',
    `clinvar_variation_number` STRING COMMENT 'ClinVar variation ID for the variant, if the variant has clinical significance annotation in ClinVar (e.g., 12345). Null if not present in ClinVar.. Valid values are `^[0-9]{1,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this PGx marker record was first created in the system (format: yyyy-MM-ddTHH:mm:ss.SSSXXX). Audit trail field for data lineage and compliance.',
    `curation_date` DATE COMMENT 'Date when this PGx marker record was curated or last reviewed by the data stewardship team (format: yyyy-MM-dd). Ensures currency and auditability of reference data.',
    `data_source` STRING COMMENT 'Primary data source or database from which this PGx marker record was curated (e.g., PharmGKB, CPIC, DPWG, FDA Table of PGx Biomarkers, PharmVar). Supports data lineage and provenance tracking.',
    `diplotype` STRING COMMENT 'Two-allele genotype combination representing the diplotype (e.g., *1/*4, *2/*3A). Captures the paired allele configuration that determines metabolizer phenotype. Null for single-variant markers.',
    `ema_pgx_label_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this marker is referenced in EMA-approved drug labeling with pharmacogenomic information (True) or not (False). Supports EU regulatory compliance.',
    `evidence_level` STRING COMMENT 'CPIC evidence level classification for the gene-drug interaction: 1A (high evidence, strong recommendation), 1B (high evidence, moderate recommendation), 2A (moderate evidence, strong recommendation), 2B (moderate evidence, moderate recommendation), 3 (weak evidence), 4 (preliminary evidence). Drives clinical decision support priority.. Valid values are `1A|1B|2A|2B|3|4`',
    `fda_pgx_label_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this marker is referenced in FDA-approved drug labeling with pharmacogenomic information (True) or not (False). Supports regulatory-grade PGx reporting.',
    `functional_impact` STRING COMMENT 'Predicted or experimentally validated functional impact of the variant on gene/protein function: no_function (null allele), decreased_function, normal_function, increased_function, or uncertain_function. Drives phenotype prediction.. Valid values are `no_function|decreased_function|normal_function|increased_function|uncertain_function`',
    `genomic_position` BIGINT COMMENT 'Genomic coordinate (base pair position) of the variant on the reference genome assembly (GRCh38/hg38). For star alleles or haplotypes, this may represent the lead variant position.',
    `guideline_source` STRING COMMENT 'Primary authoritative source for the PGx guideline or recommendation: CPIC (Clinical Pharmacogenetics Implementation Consortium), DPWG (Dutch Pharmacogenetics Working Group), PharmGKB, FDA (U.S. Food and Drug Administration), EMA (European Medicines Agency), or other.. Valid values are `CPIC|DPWG|PharmGKB|FDA|EMA|other`',
    `guideline_version` STRING COMMENT 'Version identifier or publication date of the source guideline (e.g., CPIC v2.1, 2021-08-15). Ensures traceability and reproducibility of PGx recommendations.',
    `hgvs_notation` STRING COMMENT 'Standardized HGVS nomenclature for the variant (e.g., NC_000022.11:g.42130692G>A, NM_000546.5:c.215C>G, NP_000537.3:p.Arg72Pro). Supports genomic (g.), coding (c.), and protein (p.) representations.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this PGx marker record was last modified (format: yyyy-MM-ddTHH:mm:ss.SSSXXX). Audit trail field for change tracking and data governance.',
    `marker_code` STRING COMMENT 'Externally-known unique business identifier for the PGx marker, typically combining gene symbol and variant notation (e.g., CYP2D6_rs1065852, DPYD_c.1905+1G>A). Used for cross-reference with PharmGKB, CPIC, and FDA labeling.. Valid values are `^[A-Z0-9_-]{3,50}$`',
    `marker_name` STRING COMMENT 'Human-readable name or label for the pharmacogenomics marker, often including gene symbol and variant designation (e.g., CYP2D6*4, TPMT c.719A>G).',
    `pharmacogenomics_marker_status` STRING COMMENT 'Lifecycle status of the PGx marker record: active (current and approved for use), deprecated (superseded by newer version), under_review (pending curation or validation), or retired (no longer clinically relevant). Ensures data quality and governance.. Valid values are `active|deprecated|under_review|retired`',
    `pharmgkb_accession` STRING COMMENT 'PharmGKB accession identifier for the variant, gene, or drug-gene interaction (e.g., PA166153631). Enables cross-reference to the PharmGKB knowledge base.. Valid values are `^PA[0-9]{6,10}$`',
    `population_frequency` DECIMAL(18,2) COMMENT 'Global or population-specific minor allele frequency (MAF) for the variant, sourced from gnomAD, 1000 Genomes, or other population databases. Expressed as a decimal (e.g., 0.123456 for 12.3456%). Null if frequency data unavailable.',
    `population_group` STRING COMMENT 'Population or ancestry group for which the allele frequency is reported (e.g., Global, European (Non-Finnish), East Asian, African/African American, Latino/Admixed American). Supports population-stratified PGx analysis.',
    `predicted_phenotype` STRING COMMENT 'Predicted metabolizer or functional phenotype associated with the marker or diplotype (e.g., Poor Metabolizer, Intermediate Metabolizer, Normal Metabolizer, Rapid Metabolizer, Ultrarapid Metabolizer; or Decreased Function, Normal Function, Increased Function). Core clinical actionability field.',
    `reference_allele` STRING COMMENT 'Reference genome allele sequence at the variant position (e.g., A, G, ACGT). Null for star alleles or diplotypes that represent multi-variant haplotypes.. Valid values are `^[ACGTN]+$`',
    `rsid` STRING COMMENT 'dbSNP reference SNP cluster identifier (rsID) for the variant, if applicable (e.g., rs1065852, rs3918290). Null for star alleles or complex haplotypes not represented by a single SNP.. Valid values are `^rs[0-9]{1,12}$`',
    `star_allele_designation` STRING COMMENT 'Named star allele designation for pharmacogenes with established allele nomenclature (e.g., *1, *2, *4, *17 for CYP2D6; *2, *3A for TPMT). Null for variants not part of a star allele system.',
    `variant_type` STRING COMMENT 'Classification of the pharmacogenomic variant type: SNP (Single Nucleotide Polymorphism), CNV (Copy Number Variation), indel (insertion/deletion), star_allele (named allele designation), haplotype (phased variant combination), or diplotype (two-allele genotype).. Valid values are `SNP|CNV|indel|star_allele|haplotype|diplotype`',
    `version` STRING COMMENT 'Version identifier for this PGx marker record (e.g., v1.0, v2.1). Supports versioned reference data management and reproducible genomic analysis pipelines.',
    CONSTRAINT pk_pharmacogenomics_marker PRIMARY KEY(`pharmacogenomics_marker_id`)
) COMMENT 'Reference catalog of pharmacogenomics (PGx) variant markers and star-allele/diplotype definitions sourced from PharmGKB, CPIC, DPWG, and FDA PGx labeling. Each record captures a clinically actionable gene-drug interaction: gene symbol, defining variant(s), diplotype designation (e.g., CYP2D6*1/*4), predicted metabolizer phenotype, associated drug(s), evidence level (CPIC 1A-4), guideline reference, and clinical actionability status. Enables PGx-informed clinical reporting, drug dosing recommendations, and companion diagnostic assay design.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reference`.`gene_tag_assignment` (
    `gene_tag_assignment_id` BIGINT COMMENT 'Unique identifier for this gene-tag assignment record. Primary key.',
    `catalog_tag_id` BIGINT COMMENT 'Foreign key linking to the catalog tag being applied',
    `gene_model_id` BIGINT COMMENT 'Foreign key linking to the gene model being tagged',
    `assigned_by` STRING COMMENT 'Username or system identifier of the user or automated process that created this tag assignment.',
    `assignment_date` DATE COMMENT 'The date when this tag was assigned to the gene. Tracks when the classification was established.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of this tag assignment. Values: active, pending_review, approved, deprecated, rejected.',
    `classification_algorithm` STRING COMMENT 'Name or version identifier of the algorithm, rule set, or curation process that assigned this tag. Examples: CancerGeneCensus_v95, PharmGKB_import_2024Q1, manual_curation.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Quantitative confidence score (0.0 to 1.0) indicating the certainty or strength of evidence for this tag assignment. Used for algorithmic or curated classifications.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this assignment record was first created in the system.',
    `effective_from_date` DATE COMMENT 'The date from which this tag assignment is considered active and valid for use in data catalog search and filtering.',
    `effective_to_date` DATE COMMENT 'The date on which this tag assignment was deprecated or superseded. Null for currently active assignments. Supports temporal tracking of classification changes.',
    `evidence_source` STRING COMMENT 'Reference to the external database, publication, or internal analysis that provides evidence for this tag assignment. Examples: PMID:12345678, ClinVar, internal_variant_analysis.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this assignment record was last modified.',
    `notes` STRING COMMENT 'Free-text notes or comments about this tag assignment, including rationale, caveats, or review comments.',
    `review_required_flag` BOOLEAN COMMENT 'Indicates whether this tag assignment requires manual review or approval by a data steward before being published in the data catalog.',
    CONSTRAINT pk_gene_tag_assignment PRIMARY KEY(`gene_tag_assignment_id`)
) COMMENT 'This association product represents the classification assignment between gene_model and catalog_tag. It captures the controlled tagging of genes with genomics-specific classification labels (cancer gene, pharmacogene, ACMG secondary finding, essential gene) for data catalog discovery and faceted search. Each record links one gene_model to one catalog_tag with metadata about the assignment provenance, confidence, and lifecycle.. Existence Justification: In genomics data catalog operations, a single gene model is tagged with multiple catalog tags (e.g., cancer_gene, pharmacogene, essential_gene, ACMG_secondary_finding) to enable faceted search and discovery, and each catalog tag applies to many genes. The business actively manages these tag assignments as a classification and curation workflow, with assignment dates, confidence scores, algorithm provenance, review status, and temporal validity tracking. This is a recognized operational entity in genomics data governance.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`reference`.`variant_database_qualification` (
    `variant_database_qualification_id` BIGINT COMMENT 'Primary key for the variant_database_qualification association',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee who holds the qualification for this variant database',
    `qualified_by_employee_id` BIGINT COMMENT 'Employee ID of the supervisor or trainer who assessed and certified this qualification. Required for CLIA documentation and audit trail.',
    `variant_database_id` BIGINT COMMENT 'Foreign key linking to the variant database for which the employee is qualified',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numerical score from the qualification assessment or competency test (0.00 to 100.00). Used to document proficiency level and identify personnel requiring additional training.',
    `certification_status` STRING COMMENT 'Current status of the qualification certification. Active certifications allow work assignment; expired or suspended certifications require retraining. Values: Active, Expired, Suspended, Pending Renewal.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this qualification record was created in the system.',
    `expiration_date` DATE COMMENT 'Date when this qualification expires and requires renewal or requalification. Driven by CLIA competency assessment requirements and internal quality management policies.',
    `last_updated_date` TIMESTAMP COMMENT 'Timestamp when this qualification record was last modified.',
    `last_used_date` DATE COMMENT 'Most recent date when the employee actively used this variant database in annotation or interpretation work. Used to track ongoing competency and identify personnel requiring refresher training.',
    `notes` STRING COMMENT 'Free-text notes documenting special conditions, limitations, or observations related to this qualification (e.g., Qualified for somatic variants only, Requires supervision for COSMIC interpretation).',
    `proficiency_level` STRING COMMENT 'Current proficiency level of the employee for this specific variant database. Determines work assignment eligibility and supervision requirements. Values: Trainee, Qualified, Expert, Supervisor.',
    `qualification_date` DATE COMMENT 'Date when the employee successfully completed qualification training and assessment for this variant database. Used for CLIA competency documentation and requalification scheduling.',
    `training_version` STRING COMMENT 'Version of the variant database on which the employee was trained and qualified. Critical for determining whether retraining is required when database versions are updated with significant schema or content changes.',
    CONSTRAINT pk_variant_database_qualification PRIMARY KEY(`variant_database_qualification_id`)
) COMMENT 'This association product represents the qualification and competency certification between clinical variant scientists and variant databases used in annotation pipelines. It captures CLIA-mandated competency assessment, training completion, proficiency levels, and ongoing usage tracking required for regulatory compliance in clinical genomics laboratories. Each record links one employee to one variant database with qualification metadata that exists only in the context of this competency relationship.. Existence Justification: In clinical genomics laboratories operating under CLIA regulations, variant scientists must be individually qualified to interpret variants using specific databases (ClinVar, gnomAD, COSMIC, etc.). Each scientist holds qualifications for multiple databases, and each database requires multiple qualified interpreters to ensure operational coverage. The qualification relationship is actively managed through training programs, competency assessments, proficiency tracking, and periodic recertification—making it a core operational business process, not an analytical correlation.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ADD CONSTRAINT `fk_reference_genome_assembly_superseded_by_assembly_genome_assembly_id` FOREIGN KEY (`superseded_by_assembly_genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ADD CONSTRAINT `fk_reference_genome_assembly_version_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ADD CONSTRAINT `fk_reference_variant_database_replacement_database_variant_database_id` FOREIGN KEY (`replacement_database_variant_database_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database`(`variant_database_id`);
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ADD CONSTRAINT `fk_reference_variant_database_version_variant_database_id` FOREIGN KEY (`variant_database_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database`(`variant_database_id`);
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ADD CONSTRAINT `fk_reference_gene_annotation_track_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ADD CONSTRAINT `fk_reference_gene_annotation_track_superseded_by_track_gene_annotation_track_id` FOREIGN KEY (`superseded_by_track_gene_annotation_track_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_annotation_track`(`gene_annotation_track_id`);
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ADD CONSTRAINT `fk_reference_gene_model_gene_annotation_track_id` FOREIGN KEY (`gene_annotation_track_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_annotation_track`(`gene_annotation_track_id`);
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ADD CONSTRAINT `fk_reference_transcript_model_gene_annotation_track_id` FOREIGN KEY (`gene_annotation_track_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_annotation_track`(`gene_annotation_track_id`);
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ADD CONSTRAINT `fk_reference_transcript_model_gene_model_id` FOREIGN KEY (`gene_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_model`(`gene_model_id`);
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ADD CONSTRAINT `fk_reference_population_allele_frequency_gene_model_id` FOREIGN KEY (`gene_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_model`(`gene_model_id`);
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ADD CONSTRAINT `fk_reference_population_allele_frequency_transcript_model_id` FOREIGN KEY (`transcript_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`transcript_model`(`transcript_model_id`);
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ADD CONSTRAINT `fk_reference_population_allele_frequency_variant_database_version_id` FOREIGN KEY (`variant_database_version_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database_version`(`variant_database_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway` ADD CONSTRAINT `fk_reference_pathway_parent_pathway_id` FOREIGN KEY (`parent_pathway_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`pathway`(`pathway_id`);
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway` ADD CONSTRAINT `fk_reference_pathway_pathway_database_id` FOREIGN KEY (`pathway_database_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`pathway_database`(`pathway_database_id`);
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_pathway_link` ADD CONSTRAINT `fk_reference_gene_pathway_link_gene_model_id` FOREIGN KEY (`gene_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_model`(`gene_model_id`);
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_pathway_link` ADD CONSTRAINT `fk_reference_gene_pathway_link_pathway_id` FOREIGN KEY (`pathway_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`pathway`(`pathway_id`);
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ADD CONSTRAINT `fk_reference_genomic_region_gene_model_id` FOREIGN KEY (`gene_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_model`(`gene_model_id`);
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ADD CONSTRAINT `fk_reference_genomic_region_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ADD CONSTRAINT `fk_reference_genomic_region_superseded_by_region_genomic_region_id` FOREIGN KEY (`superseded_by_region_genomic_region_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genomic_region`(`genomic_region_id`);
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ADD CONSTRAINT `fk_reference_ontology_term_parent_term_ontology_term_id` FOREIGN KEY (`parent_term_ontology_term_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`ontology_term`(`ontology_term_id`);
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ADD CONSTRAINT `fk_reference_ontology_term_primary_replacement_term_ontology_term_id` FOREIGN KEY (`primary_replacement_term_ontology_term_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`ontology_term`(`ontology_term_id`);
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ADD CONSTRAINT `fk_reference_pharmacogenomics_marker_gene_model_id` FOREIGN KEY (`gene_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_model`(`gene_model_id`);
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ADD CONSTRAINT `fk_reference_pharmacogenomics_marker_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_tag_assignment` ADD CONSTRAINT `fk_reference_gene_tag_assignment_gene_model_id` FOREIGN KEY (`gene_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_model`(`gene_model_id`);
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_qualification` ADD CONSTRAINT `fk_reference_variant_database_qualification_variant_database_id` FOREIGN KEY (`variant_database_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database`(`variant_database_id`);

-- ========= TAGS =========
ALTER SCHEMA `genomics_biotech_ecm`.`reference` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `genomics_biotech_ecm`.`reference` SET TAGS ('dbx_domain' = 'reference');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` SET TAGS ('dbx_subdomain' = 'genome_reference');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `superseded_by_assembly_genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Assembly Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `annotation_version` SET TAGS ('dbx_business_glossary_term' = 'Annotation Version');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `assembly_accession` SET TAGS ('dbx_business_glossary_term' = 'Assembly Accession Number');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `assembly_accession` SET TAGS ('dbx_value_regex' = '^GC[AF]_[0-9]{9}.[0-9]+$');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `assembly_alias` SET TAGS ('dbx_business_glossary_term' = 'Assembly Alias');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `assembly_level` SET TAGS ('dbx_business_glossary_term' = 'Assembly Level');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `assembly_level` SET TAGS ('dbx_value_regex' = 'Chromosome|Scaffold|Contig|Complete Genome');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `assembly_method` SET TAGS ('dbx_business_glossary_term' = 'Assembly Method');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `assembly_name` SET TAGS ('dbx_business_glossary_term' = 'Assembly Name');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `assembly_status` SET TAGS ('dbx_business_glossary_term' = 'Assembly Status');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `assembly_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|superseded|archived');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `assembly_type` SET TAGS ('dbx_business_glossary_term' = 'Assembly Type');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `assembly_type` SET TAGS ('dbx_value_regex' = 'haploid|diploid|haploid-with-alt-loci|alternate-pseudohaplotype');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `bowtie2_index_path` SET TAGS ('dbx_business_glossary_term' = 'Bowtie2 Index Path');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `bwa_index_path` SET TAGS ('dbx_business_glossary_term' = 'BWA Index Path');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `chromosome_count` SET TAGS ('dbx_business_glossary_term' = 'Chromosome Count');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `contig_count` SET TAGS ('dbx_business_glossary_term' = 'Contig Count');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `contig_n50_bp` SET TAGS ('dbx_business_glossary_term' = 'Contig N50 in Base Pairs (BP)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `coverage_depth` SET TAGS ('dbx_business_glossary_term' = 'Coverage Depth');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `cytoband_file_path` SET TAGS ('dbx_business_glossary_term' = 'Cytoband File Path');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `deprecated_date` SET TAGS ('dbx_business_glossary_term' = 'Assembly Deprecated Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `fasta_file_path` SET TAGS ('dbx_business_glossary_term' = 'FASTA File Path');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `fasta_md5_checksum` SET TAGS ('dbx_business_glossary_term' = 'FASTA MD5 Checksum');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `fasta_md5_checksum` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{32}$');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `gc_content_percent` SET TAGS ('dbx_business_glossary_term' = 'GC Content Percentage');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `gff_file_path` SET TAGS ('dbx_business_glossary_term' = 'GFF (General Feature Format) File Path');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `gtf_file_path` SET TAGS ('dbx_business_glossary_term' = 'GTF (Gene Transfer Format) File Path');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `index_file_path` SET TAGS ('dbx_business_glossary_term' = 'Index File Path');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `is_primary_assembly` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Assembly Flag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `is_reference_standard` SET TAGS ('dbx_business_glossary_term' = 'Is Reference Standard Flag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assembly Notes');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `organism_common_name` SET TAGS ('dbx_business_glossary_term' = 'Organism Common Name');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `organism_name` SET TAGS ('dbx_business_glossary_term' = 'Organism Scientific Name');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `patch_version` SET TAGS ('dbx_business_glossary_term' = 'Patch Version');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `ploidy` SET TAGS ('dbx_business_glossary_term' = 'Ploidy');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `ploidy` SET TAGS ('dbx_value_regex' = 'haploid|diploid|polyploid');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Assembly Release Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `scaffold_count` SET TAGS ('dbx_business_glossary_term' = 'Scaffold Count');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `scaffold_n50_bp` SET TAGS ('dbx_business_glossary_term' = 'Scaffold N50 in Base Pairs (BP)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `sequence_dictionary_path` SET TAGS ('dbx_business_glossary_term' = 'Sequence Dictionary Path');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `sequencing_technology` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Technology');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `source_authority` SET TAGS ('dbx_business_glossary_term' = 'Source Authority');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `source_authority` SET TAGS ('dbx_value_regex' = 'GRC|NCBI|UCSC|Ensembl|T2T|Other');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `submitter_organization` SET TAGS ('dbx_business_glossary_term' = 'Submitter Organization');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `taxon_number` SET TAGS ('dbx_business_glossary_term' = 'NCBI Taxonomy Identifier (Taxon ID)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `total_sequence_length_bp` SET TAGS ('dbx_business_glossary_term' = 'Total Sequence Length in Base Pairs (BP)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `ungapped_length_bp` SET TAGS ('dbx_business_glossary_term' = 'Ungapped Sequence Length in Base Pairs (BP)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` SET TAGS ('dbx_subdomain' = 'genome_reference');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `genome_assembly_version_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Version Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `validation_study_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Study Report Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `added_sequences_summary` SET TAGS ('dbx_business_glossary_term' = 'Added Sequences Summary');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `alt_loci_count` SET TAGS ('dbx_business_glossary_term' = 'Alternate Loci (ALT) Count');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `assembly_accession` SET TAGS ('dbx_business_glossary_term' = 'Assembly Accession Number');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `assembly_accession` SET TAGS ('dbx_value_regex' = '^GCA_[0-9]{9}.[0-9]+$');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `assembly_type` SET TAGS ('dbx_business_glossary_term' = 'Assembly Type');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `assembly_type` SET TAGS ('dbx_value_regex' = 'primary|alternate|patch|haplotype|unplaced|unlocalized');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `checksum_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Checksum Validation Status');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `checksum_validation_status` SET TAGS ('dbx_value_regex' = 'validated|failed|pending|not_performed');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `chromosome_count` SET TAGS ('dbx_business_glossary_term' = 'Chromosome Count');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `contig_count` SET TAGS ('dbx_business_glossary_term' = 'Contig Count');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `contig_n50_bp` SET TAGS ('dbx_business_glossary_term' = 'Contig N50 in Base Pairs (BP)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `decoy_sequence_included` SET TAGS ('dbx_business_glossary_term' = 'Decoy Sequence Included Flag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `decoy_sequence_name` SET TAGS ('dbx_business_glossary_term' = 'Decoy Sequence Name');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `ebv_sequence_included` SET TAGS ('dbx_business_glossary_term' = 'Epstein-Barr Virus (EBV) Sequence Included Flag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `fasta_file_checksum_md5` SET TAGS ('dbx_business_glossary_term' = 'FASTA File Checksum Message Digest 5 (MD5)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `fasta_file_checksum_md5` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{32}$');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `fasta_file_checksum_sha256` SET TAGS ('dbx_business_glossary_term' = 'FASTA File Checksum Secure Hash Algorithm 256 (SHA-256)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `fasta_file_checksum_sha256` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{64}$');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `gap_count` SET TAGS ('dbx_business_glossary_term' = 'Gap Count');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `genome_assembly_version_status` SET TAGS ('dbx_business_glossary_term' = 'Assembly Version Status');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `genome_assembly_version_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|retired|under_review');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `internal_adoption_date` SET TAGS ('dbx_business_glossary_term' = 'Internal Adoption Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `mitochondrial_genome_included` SET TAGS ('dbx_business_glossary_term' = 'Mitochondrial Genome Included Flag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `patch_notes` SET TAGS ('dbx_business_glossary_term' = 'Patch Notes');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `patch_number` SET TAGS ('dbx_business_glossary_term' = 'Patch Number');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `patch_type` SET TAGS ('dbx_business_glossary_term' = 'Patch Type');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `patch_type` SET TAGS ('dbx_value_regex' = 'fix|novel');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Assembly Release Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `removed_sequences_summary` SET TAGS ('dbx_business_glossary_term' = 'Removed Sequences Summary');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `scaffold_count` SET TAGS ('dbx_business_glossary_term' = 'Scaffold Count');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `scaffold_n50_bp` SET TAGS ('dbx_business_glossary_term' = 'Scaffold N50 in Base Pairs (BP)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `source_organization` SET TAGS ('dbx_business_glossary_term' = 'Source Organization');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `source_release_url` SET TAGS ('dbx_business_glossary_term' = 'Source Release Uniform Resource Locator (URL)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `source_release_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `total_sequence_length_bp` SET TAGS ('dbx_business_glossary_term' = 'Total Sequence Length in Base Pairs (BP)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `usage_scope` SET TAGS ('dbx_business_glossary_term' = 'Usage Scope');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `usage_scope` SET TAGS ('dbx_value_regex' = 'clinical|research_use_only|internal_development|external_collaboration');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `validation_study_performed` SET TAGS ('dbx_business_glossary_term' = 'Validation Study Performed Flag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ALTER COLUMN `version_tag` SET TAGS ('dbx_business_glossary_term' = 'Assembly Version Tag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` SET TAGS ('dbx_subdomain' = 'variant_knowledge');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `variant_database_id` SET TAGS ('dbx_business_glossary_term' = 'Variant Database Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `replacement_database_variant_database_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Database Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `annotation_fields` SET TAGS ('dbx_business_glossary_term' = 'Annotation Fields Provided');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|under_review');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_business_glossary_term' = 'Message Digest 5 (MD5) Checksum');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `citation` SET TAGS ('dbx_business_glossary_term' = 'Citation');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `clinical_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Clinical Validation Status');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `clinical_validation_status` SET TAGS ('dbx_value_regex' = 'validated|not_validated|in_progress|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `data_access_tier` SET TAGS ('dbx_business_glossary_term' = 'Data Access Tier');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `data_access_tier` SET TAGS ('dbx_value_regex' = 'public|licensed|restricted|internal');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `database_code` SET TAGS ('dbx_business_glossary_term' = 'Database Code');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `database_name` SET TAGS ('dbx_business_glossary_term' = 'Database Name');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `database_type` SET TAGS ('dbx_business_glossary_term' = 'Database Type');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `database_type` SET TAGS ('dbx_value_regex' = 'public|commercial|proprietary|internal');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `deprecation_date` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation Uniform Resource Locator (URL)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `download_url` SET TAGS ('dbx_business_glossary_term' = 'Download Uniform Resource Locator (URL)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'VCF|TSV|JSON|XML|BED|MAF');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `file_size_gb` SET TAGS ('dbx_business_glossary_term' = 'File Size in Gigabytes (GB)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `genome_build` SET TAGS ('dbx_business_glossary_term' = 'Reference Genome Build');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `genome_build` SET TAGS ('dbx_value_regex' = 'GRCh37|hg19|GRCh38|hg38|T2T-CHM13');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `population_coverage` SET TAGS ('dbx_business_glossary_term' = 'Population Coverage');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `source_organization` SET TAGS ('dbx_business_glossary_term' = 'Source Organization');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `update_frequency` SET TAGS ('dbx_business_glossary_term' = 'Update Frequency');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `update_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually|irregular');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `usage_scope` SET TAGS ('dbx_business_glossary_term' = 'Usage Scope');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `usage_scope` SET TAGS ('dbx_value_regex' = 'clinical|research|both');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `variant_count` SET TAGS ('dbx_business_glossary_term' = 'Variant Count');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `variant_database_status` SET TAGS ('dbx_business_glossary_term' = 'Database Status');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `variant_database_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|archived|pending_approval');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `vcf_schema_version` SET TAGS ('dbx_business_glossary_term' = 'Variant Call Format (VCF) Schema Version');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Database Version');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` SET TAGS ('dbx_subdomain' = 'variant_knowledge');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `variant_database_version_id` SET TAGS ('dbx_business_glossary_term' = 'Variant Database Version Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `variant_database_id` SET TAGS ('dbx_business_glossary_term' = 'Variant Database Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `adoption_date` SET TAGS ('dbx_business_glossary_term' = 'Adoption Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `annotation_pipeline_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Annotation Pipeline Compatibility');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `citation_reference` SET TAGS ('dbx_business_glossary_term' = 'Citation Reference');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `clinical_use_approved` SET TAGS ('dbx_business_glossary_term' = 'Clinical Use Approved Flag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `data_format_version` SET TAGS ('dbx_business_glossary_term' = 'Data Format Version');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `genome_build` SET TAGS ('dbx_business_glossary_term' = 'Reference Genome Build');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `genome_build` SET TAGS ('dbx_value_regex' = 'GRCh37|hg19|GRCh38|hg38|T2T-CHM13');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Flag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `license_type` SET TAGS ('dbx_value_regex' = 'public_domain|CC0|CC_BY|CC_BY_NC|proprietary|academic_only');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `md5_checksum` SET TAGS ('dbx_business_glossary_term' = 'Message Digest 5 (MD5) Checksum');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `md5_checksum` SET TAGS ('dbx_value_regex' = '^[a-fA-F0-9]{32}$');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `new_pathogenic_count` SET TAGS ('dbx_business_glossary_term' = 'New Pathogenic Variant Count');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `population_coverage` SET TAGS ('dbx_business_glossary_term' = 'Population Coverage');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `reclassified_count` SET TAGS ('dbx_business_glossary_term' = 'Reclassified Variant Count');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `regulatory_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Approved Flag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `retracted_count` SET TAGS ('dbx_business_glossary_term' = 'Retracted Variant Count');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `sha256_checksum` SET TAGS ('dbx_business_glossary_term' = 'Secure Hash Algorithm 256 (SHA-256) Checksum');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `sha256_checksum` SET TAGS ('dbx_value_regex' = '^[a-fA-F0-9]{64}$');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `source_url` SET TAGS ('dbx_business_glossary_term' = 'Source Download Uniform Resource Locator (URL)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `validation_notes` SET TAGS ('dbx_business_glossary_term' = 'Validation Notes');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Internal Validation Status');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|passed|failed|conditional');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `variant_count` SET TAGS ('dbx_business_glossary_term' = 'Total Variant Count');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `variant_count_delta` SET TAGS ('dbx_business_glossary_term' = 'Variant Count Delta');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `vcf_file_path` SET TAGS ('dbx_business_glossary_term' = 'Variant Call Format (VCF) File Path');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `vcf_file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `vcf_file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Variant Call Format (VCF) File Size in Bytes');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `version_identifier` SET TAGS ('dbx_business_glossary_term' = 'Version Identifier');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_version` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` SET TAGS ('dbx_subdomain' = 'genome_reference');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `gene_annotation_track_id` SET TAGS ('dbx_business_glossary_term' = 'Gene Annotation Track Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `superseded_by_track_gene_annotation_track_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Gene Annotation Track Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `annotation_method` SET TAGS ('dbx_business_glossary_term' = 'Annotation Method Description');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `annotation_source` SET TAGS ('dbx_business_glossary_term' = 'Annotation Source Provider');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `annotation_source` SET TAGS ('dbx_value_regex' = 'GENCODE|RefSeq|Ensembl|UCSC|Custom');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `biotype_classifications` SET TAGS ('dbx_business_glossary_term' = 'Gene Biotype Classifications');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_business_glossary_term' = 'File Checksum MD5 Hash');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `citation_reference` SET TAGS ('dbx_business_glossary_term' = 'Annotation Track Citation Reference');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `compatible_pipelines` SET TAGS ('dbx_business_glossary_term' = 'Compatible Bioinformatics Pipelines');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `coordinate_system` SET TAGS ('dbx_business_glossary_term' = 'Genomic Coordinate System');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `coordinate_system` SET TAGS ('dbx_value_regex' = '0-based|1-based');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `deprecation_date` SET TAGS ('dbx_business_glossary_term' = 'Annotation Track Deprecation Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'Annotation File Format');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'GTF|GFF3|BED|GenBank');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `file_path` SET TAGS ('dbx_business_glossary_term' = 'Annotation File Storage Path');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Annotation File Size in Bytes');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `gene_annotation_track_status` SET TAGS ('dbx_business_glossary_term' = 'Annotation Track Lifecycle Status');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `gene_annotation_track_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|archived|under_review');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `gene_count` SET TAGS ('dbx_business_glossary_term' = 'Total Gene Count');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'Annotation Track License Type');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `lncrna_gene_count` SET TAGS ('dbx_business_glossary_term' = 'Long Non-Coding RNA (lncRNA) Gene Count');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Annotation Track Notes');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `protein_coding_gene_count` SET TAGS ('dbx_business_glossary_term' = 'Protein-Coding Gene Count');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `pseudogene_count` SET TAGS ('dbx_business_glossary_term' = 'Pseudogene Count');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Annotation Track Release Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `release_version` SET TAGS ('dbx_business_glossary_term' = 'Annotation Track Release Version');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `source_url` SET TAGS ('dbx_business_glossary_term' = 'Annotation Source URL');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `strand_convention` SET TAGS ('dbx_business_glossary_term' = 'Strand Convention');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `strand_convention` SET TAGS ('dbx_value_regex' = 'forward|reverse|both|unstranded');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `track_name` SET TAGS ('dbx_business_glossary_term' = 'Gene Annotation Track Name');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `transcript_count` SET TAGS ('dbx_business_glossary_term' = 'Total Transcript Count');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `usage_scope` SET TAGS ('dbx_business_glossary_term' = 'Annotation Track Usage Scope');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `usage_scope` SET TAGS ('dbx_value_regex' = 'RUO|IVD|LDT|Internal');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Annotation Track Validation Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Annotation Track Validation Status');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|pending_validation|not_validated');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_annotation_track` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` SET TAGS ('dbx_subdomain' = 'genome_reference');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `gene_model_id` SET TAGS ('dbx_business_glossary_term' = 'Gene Model Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `gene_annotation_track_id` SET TAGS ('dbx_business_glossary_term' = 'Gene Annotation Track Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `acmg_secondary_findings_flag` SET TAGS ('dbx_business_glossary_term' = 'American College of Medical Genetics and Genomics (ACMG) Secondary Findings Flag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `associated_disease_phenotypes` SET TAGS ('dbx_business_glossary_term' = 'Associated Disease Phenotypes');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `cancer_gene_census_flag` SET TAGS ('dbx_business_glossary_term' = 'Cancer Gene Census Flag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `chromosome` SET TAGS ('dbx_business_glossary_term' = 'Chromosome Location');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `chromosome` SET TAGS ('dbx_value_regex' = '^(chr)?([1-9]|1[0-9]|2[0-2]|X|Y|MT?)$');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `constraint_metric_loeuf` SET TAGS ('dbx_business_glossary_term' = 'Loss-of-Function Observed/Expected Upper Bound Fraction (LOEUF) Constraint Metric');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `constraint_metric_pli` SET TAGS ('dbx_business_glossary_term' = 'Probability of Loss-of-Function Intolerance (pLI) Constraint Metric');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `curator_notes` SET TAGS ('dbx_business_glossary_term' = 'Curator Notes');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `end_position` SET TAGS ('dbx_business_glossary_term' = 'Genomic End Position');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `ensembl_gene_accession` SET TAGS ('dbx_business_glossary_term' = 'Ensembl Gene Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `ensembl_gene_accession` SET TAGS ('dbx_value_regex' = '^ENSG[0-9]{11}$');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `entrez_gene_number` SET TAGS ('dbx_business_glossary_term' = 'Entrez Gene Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `essential_gene_flag` SET TAGS ('dbx_business_glossary_term' = 'Essential Gene Flag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `gene_biotype` SET TAGS ('dbx_business_glossary_term' = 'Gene Biotype Classification');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `gene_description` SET TAGS ('dbx_business_glossary_term' = 'Gene Functional Description');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `gene_family` SET TAGS ('dbx_business_glossary_term' = 'Gene Family Classification');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `gene_length_bp` SET TAGS ('dbx_business_glossary_term' = 'Gene Length in Base Pairs (BP)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `gene_name` SET TAGS ('dbx_business_glossary_term' = 'Gene Full Name');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `gene_status` SET TAGS ('dbx_business_glossary_term' = 'Gene Curation Status');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `gene_status` SET TAGS ('dbx_value_regex' = 'active|retired|provisional|withdrawn');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `gene_synonym_list` SET TAGS ('dbx_business_glossary_term' = 'Gene Synonym List');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `gene_version` SET TAGS ('dbx_business_glossary_term' = 'Gene Model Version');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `genome_build` SET TAGS ('dbx_business_glossary_term' = 'Reference Genome Build Version');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `genome_build` SET TAGS ('dbx_value_regex' = 'GRCh38|hg38|GRCh37|hg19|T2T-CHM13');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `haploinsufficiency_score` SET TAGS ('dbx_business_glossary_term' = 'Haploinsufficiency Score');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `hgnc_gene_symbol` SET TAGS ('dbx_business_glossary_term' = 'HUGO Gene Nomenclature Committee (HGNC) Gene Symbol');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `hgnc_gene_symbol` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `last_curated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Curated Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `locus_group` SET TAGS ('dbx_business_glossary_term' = 'Locus Group Classification');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `locus_group` SET TAGS ('dbx_value_regex' = 'protein-coding gene|non-coding RNA|pseudogene|other');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `locus_type` SET TAGS ('dbx_business_glossary_term' = 'Locus Type Classification');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `mane_select_transcript_transcript_model_id` SET TAGS ('dbx_business_glossary_term' = 'Matched Annotation from NCBI and EMBL-EBI (MANE) Select Transcript Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `omim_number` SET TAGS ('dbx_business_glossary_term' = 'Online Mendelian Inheritance in Man (OMIM) Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `omim_number` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `pharmacogenomics_relevance_flag` SET TAGS ('dbx_business_glossary_term' = 'Pharmacogenomics Relevance Flag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `previous_gene_symbols` SET TAGS ('dbx_business_glossary_term' = 'Previous Gene Symbols');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `start_position` SET TAGS ('dbx_business_glossary_term' = 'Genomic Start Position');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `strand` SET TAGS ('dbx_business_glossary_term' = 'DNA Strand Orientation');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `strand` SET TAGS ('dbx_value_regex' = '^[+-]$');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `transcript_count` SET TAGS ('dbx_business_glossary_term' = 'Transcript Count');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `transcript_model_id` SET TAGS ('dbx_business_glossary_term' = 'Canonical Transcript Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_model` ALTER COLUMN `triplosensitivity_score` SET TAGS ('dbx_business_glossary_term' = 'Triplosensitivity Score');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` SET TAGS ('dbx_subdomain' = 'genome_reference');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `transcript_model_id` SET TAGS ('dbx_business_glossary_term' = 'Transcript Model Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `gene_annotation_track_id` SET TAGS ('dbx_business_glossary_term' = 'Gene Annotation Track Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `gene_model_id` SET TAGS ('dbx_business_glossary_term' = 'Gene Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `appris_annotation` SET TAGS ('dbx_business_glossary_term' = 'Annotating Principal Splice Isoforms (APPRIS) Annotation');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `biotype` SET TAGS ('dbx_business_glossary_term' = 'Transcript Biotype');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `ccds_accession` SET TAGS ('dbx_business_glossary_term' = 'Consensus Coding Sequence (CCDS) Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `ccds_accession` SET TAGS ('dbx_value_regex' = '^CCDS[0-9]+(.[0-9]+)?$');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `cds_end_position` SET TAGS ('dbx_business_glossary_term' = 'Coding Sequence (CDS) End Position');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `cds_start_position` SET TAGS ('dbx_business_glossary_term' = 'Coding Sequence (CDS) Start Position');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `checksum` SET TAGS ('dbx_business_glossary_term' = 'Data Integrity Checksum');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `checksum` SET TAGS ('dbx_value_regex' = '^[a-fA-F0-9]{32,64}$');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `chromosome` SET TAGS ('dbx_business_glossary_term' = 'Chromosome');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `chromosome` SET TAGS ('dbx_value_regex' = '^(chr)?(1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|X|Y|M|MT)$');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `coding_length_bp` SET TAGS ('dbx_business_glossary_term' = 'Coding Sequence Length in Base Pairs (bp)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `curation_status` SET TAGS ('dbx_business_glossary_term' = 'Curation Status');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `curation_status` SET TAGS ('dbx_value_regex' = 'reviewed|validated|predicted|provisional|withdrawn');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `ensembl_transcript_accession` SET TAGS ('dbx_business_glossary_term' = 'Ensembl Transcript Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `ensembl_transcript_accession` SET TAGS ('dbx_value_regex' = '^ENST[0-9]{11}(.[0-9]+)?$');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `exon_count` SET TAGS ('dbx_business_glossary_term' = 'Exon Count');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `gencode_tag` SET TAGS ('dbx_business_glossary_term' = 'GENCODE Tag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `genome_build` SET TAGS ('dbx_business_glossary_term' = 'Genome Reference Build');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `genome_build` SET TAGS ('dbx_value_regex' = 'GRCh38|hg38|GRCh37|hg19|T2T-CHM13');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Flag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `is_canonical` SET TAGS ('dbx_business_glossary_term' = 'Canonical Transcript Flag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `is_mane_plus_clinical` SET TAGS ('dbx_business_glossary_term' = 'Matched Annotation from NCBI and EMBL-EBI (MANE) Plus Clinical Flag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `is_mane_select` SET TAGS ('dbx_business_glossary_term' = 'Matched Annotation from NCBI and EMBL-EBI (MANE) Select Flag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `protein_accession` SET TAGS ('dbx_business_glossary_term' = 'Protein Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `protein_accession` SET TAGS ('dbx_value_regex' = '^(ENSP[0-9]{11}(.[0-9]+)?|NP_[0-9]+(.[0-9]+)?|XP_[0-9]+(.[0-9]+)?)$');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `refseq_accession` SET TAGS ('dbx_business_glossary_term' = 'RefSeq Accession Number');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `refseq_accession` SET TAGS ('dbx_value_regex' = '^(NM_|NR_|XM_|XR_)[0-9]+(.[0-9]+)?$');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `strand` SET TAGS ('dbx_business_glossary_term' = 'Genomic Strand');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `strand` SET TAGS ('dbx_value_regex' = '+|-');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `transcript_end_position` SET TAGS ('dbx_business_glossary_term' = 'Transcript End Position');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `transcript_length_bp` SET TAGS ('dbx_business_glossary_term' = 'Transcript Length in Base Pairs (bp)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `transcript_name` SET TAGS ('dbx_business_glossary_term' = 'Transcript Name');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `transcript_start_position` SET TAGS ('dbx_business_glossary_term' = 'Transcript Start Position');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `transcript_support_level` SET TAGS ('dbx_business_glossary_term' = 'Transcript Support Level (TSL)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `utr_3_prime_end` SET TAGS ('dbx_business_glossary_term' = '3 Prime Untranslated Region (UTR) End Position');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `utr_3_prime_start` SET TAGS ('dbx_business_glossary_term' = '3 Prime Untranslated Region (UTR) Start Position');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `utr_5_prime_end` SET TAGS ('dbx_business_glossary_term' = '5 Prime Untranslated Region (UTR) End Position');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`transcript_model` ALTER COLUMN `utr_5_prime_start` SET TAGS ('dbx_business_glossary_term' = '5 Prime Untranslated Region (UTR) Start Position');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` SET TAGS ('dbx_subdomain' = 'variant_knowledge');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `population_allele_frequency_id` SET TAGS ('dbx_business_glossary_term' = 'Population Allele Frequency ID');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `gene_model_id` SET TAGS ('dbx_business_glossary_term' = 'Gene Model Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `transcript_model_id` SET TAGS ('dbx_business_glossary_term' = 'Transcript Identifier');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `variant_database_version_id` SET TAGS ('dbx_business_glossary_term' = 'Variant Database Version Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `allele_count` SET TAGS ('dbx_business_glossary_term' = 'Allele Count (AC)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `allele_frequency` SET TAGS ('dbx_business_glossary_term' = 'Allele Frequency (AF)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `allele_number` SET TAGS ('dbx_business_glossary_term' = 'Allele Number (AN)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `alternate_allele` SET TAGS ('dbx_business_glossary_term' = 'Alternate Allele');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `alternate_allele` SET TAGS ('dbx_value_regex' = '^[ACGT]+$');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `chromosome` SET TAGS ('dbx_business_glossary_term' = 'Chromosome');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `chromosome` SET TAGS ('dbx_value_regex' = '^(chr)?(1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|X|Y|MT)$');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `clinical_significance` SET TAGS ('dbx_business_glossary_term' = 'Clinical Significance');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `consequence` SET TAGS ('dbx_business_glossary_term' = 'Variant Consequence');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `coverage_depth` SET TAGS ('dbx_business_glossary_term' = 'Coverage Depth');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `data_source_url` SET TAGS ('dbx_business_glossary_term' = 'Data Source URL');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `genome_build` SET TAGS ('dbx_business_glossary_term' = 'Genome Build Version');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `genome_build` SET TAGS ('dbx_value_regex' = 'GRCh37|hg19|GRCh38|hg38|T2T-CHM13');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `hemizygote_count` SET TAGS ('dbx_business_glossary_term' = 'Hemizygote Count');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `hgvs_coding` SET TAGS ('dbx_business_glossary_term' = 'HGVS Coding Nomenclature');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `hgvs_protein` SET TAGS ('dbx_business_glossary_term' = 'HGVS Protein Nomenclature');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `homozygote_count` SET TAGS ('dbx_business_glossary_term' = 'Homozygote Count');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `minor_allele_frequency` SET TAGS ('dbx_business_glossary_term' = 'Minor Allele Frequency (MAF)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `population_group` SET TAGS ('dbx_business_glossary_term' = 'Population Group');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `position` SET TAGS ('dbx_business_glossary_term' = 'Genomic Position');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `qc_filter_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Filter Status');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `qc_filter_status` SET TAGS ('dbx_value_regex' = 'PASS|FAIL|LOW_COVERAGE|LOW_QUALITY|STRAND_BIAS|ALLELE_BALANCE');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|superseded|under_review');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `reference_allele` SET TAGS ('dbx_business_glossary_term' = 'Reference Allele');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `reference_allele` SET TAGS ('dbx_value_regex' = '^[ACGT]+$');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|unvalidated|conflicting|pending');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `variant_identifier` SET TAGS ('dbx_business_glossary_term' = 'Variant Identifier');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `variant_type` SET TAGS ('dbx_business_glossary_term' = 'Variant Type');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`population_allele_frequency` ALTER COLUMN `variant_type` SET TAGS ('dbx_value_regex' = 'SNP|insertion|deletion|indel|MNP|complex');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` SET TAGS ('dbx_subdomain' = 'pathway_ontology');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `pathway_database_id` SET TAGS ('dbx_business_glossary_term' = 'Pathway Database Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `annotation_field_schema` SET TAGS ('dbx_business_glossary_term' = 'Annotation Field Schema');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `approved_for_clinical_use` SET TAGS ('dbx_business_glossary_term' = 'Approved for Clinical Use Flag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `approved_for_research_use` SET TAGS ('dbx_business_glossary_term' = 'Approved for Research Use Flag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_business_glossary_term' = 'Checksum Message Digest 5 (MD5)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `citation_reference` SET TAGS ('dbx_business_glossary_term' = 'Citation Reference');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `data_access_tier` SET TAGS ('dbx_business_glossary_term' = 'Data Access Tier');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `data_access_tier` SET TAGS ('dbx_value_regex' = 'public|licensed|restricted|internal');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `database_code` SET TAGS ('dbx_business_glossary_term' = 'Pathway Database Code');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `database_name` SET TAGS ('dbx_business_glossary_term' = 'Pathway Database Name');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `database_type` SET TAGS ('dbx_business_glossary_term' = 'Pathway Database Type');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `deprecation_date` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `download_url` SET TAGS ('dbx_business_glossary_term' = 'Download Uniform Resource Locator (URL)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_business_glossary_term' = 'File Size in Megabytes (MB)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `gene_count` SET TAGS ('dbx_business_glossary_term' = 'Gene Count');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `genome_build_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Genome Build Compatibility');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `integration_pipeline_count` SET TAGS ('dbx_business_glossary_term' = 'Integration Pipeline Count');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Pathway Database Notes');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `organism_scope` SET TAGS ('dbx_business_glossary_term' = 'Organism Scope');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `pathway_count` SET TAGS ('dbx_business_glossary_term' = 'Pathway Count');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `pathway_database_status` SET TAGS ('dbx_business_glossary_term' = 'Pathway Database Status');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `pathway_database_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|archived|under_review|pending_approval');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `provider_organization` SET TAGS ('dbx_business_glossary_term' = 'Provider Organization');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Pathway Database Release Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `superseded_by_version` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Version');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `update_frequency` SET TAGS ('dbx_business_glossary_term' = 'Update Frequency');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `update_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|biannually|annually|irregular|deprecated');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|pending_validation|failed_validation|not_required');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway_database` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Pathway Database Version');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway` SET TAGS ('dbx_subdomain' = 'pathway_ontology');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway` ALTER COLUMN `pathway_id` SET TAGS ('dbx_business_glossary_term' = 'Pathway Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway` ALTER COLUMN `parent_pathway_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Pathway Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway` ALTER COLUMN `pathway_database_id` SET TAGS ('dbx_business_glossary_term' = 'Pathway Database Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway` ALTER COLUMN `clinical_relevance_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Relevance Flag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway` ALTER COLUMN `cross_reference_ids` SET TAGS ('dbx_business_glossary_term' = 'Cross-Reference Identifiers (IDs)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway` ALTER COLUMN `curation_status` SET TAGS ('dbx_business_glossary_term' = 'Curation Status');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway` ALTER COLUMN `curation_status` SET TAGS ('dbx_value_regex' = 'curated|reviewed|provisional|deprecated|retired');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway` ALTER COLUMN `disease_association_count` SET TAGS ('dbx_business_glossary_term' = 'Disease Association Count');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway` ALTER COLUMN `drug_target_count` SET TAGS ('dbx_business_glossary_term' = 'Drug Target Count');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway` ALTER COLUMN `external_code` SET TAGS ('dbx_business_glossary_term' = 'Pathway External Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway` ALTER COLUMN `gene_member_count` SET TAGS ('dbx_business_glossary_term' = 'Gene Member Count');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Pathway Hierarchy Level');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway` ALTER COLUMN `last_curated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Curated Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway` ALTER COLUMN `oncology_relevance_flag` SET TAGS ('dbx_business_glossary_term' = 'Oncology Relevance Flag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway` ALTER COLUMN `organism` SET TAGS ('dbx_business_glossary_term' = 'Organism');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway` ALTER COLUMN `organism_code` SET TAGS ('dbx_business_glossary_term' = 'Organism Code');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway` ALTER COLUMN `pathway_category` SET TAGS ('dbx_business_glossary_term' = 'Pathway Category');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway` ALTER COLUMN `pathway_description` SET TAGS ('dbx_business_glossary_term' = 'Pathway Description');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway` ALTER COLUMN `pathway_name` SET TAGS ('dbx_business_glossary_term' = 'Pathway Name');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway` ALTER COLUMN `pharmacogenomics_relevance_flag` SET TAGS ('dbx_business_glossary_term' = 'Pharmacogenomics (PGx) Relevance Flag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway` ALTER COLUMN `url` SET TAGS ('dbx_business_glossary_term' = 'Pathway Uniform Resource Locator (URL)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pathway` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Pathway Version');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_pathway_link` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_pathway_link` SET TAGS ('dbx_subdomain' = 'pathway_ontology');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_pathway_link` ALTER COLUMN `gene_pathway_link_id` SET TAGS ('dbx_business_glossary_term' = 'Gene Pathway Link Identifier');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_pathway_link` ALTER COLUMN `gene_model_id` SET TAGS ('dbx_business_glossary_term' = 'Gene Model Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_pathway_link` ALTER COLUMN `pathway_id` SET TAGS ('dbx_business_glossary_term' = 'Pathway ID');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_pathway_link` ALTER COLUMN `annotation_source` SET TAGS ('dbx_business_glossary_term' = 'Annotation Source');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_pathway_link` ALTER COLUMN `annotation_source` SET TAGS ('dbx_value_regex' = 'automated|manual|hybrid');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_pathway_link` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_pathway_link` ALTER COLUMN `cross_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Cross-Reference ID');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_pathway_link` ALTER COLUMN `curation_date` SET TAGS ('dbx_business_glossary_term' = 'Curation Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_pathway_link` ALTER COLUMN `data_source_version` SET TAGS ('dbx_business_glossary_term' = 'Data Source Version');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_pathway_link` ALTER COLUMN `evidence_code` SET TAGS ('dbx_business_glossary_term' = 'Evidence Code');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_pathway_link` ALTER COLUMN `evidence_source_pmid` SET TAGS ('dbx_business_glossary_term' = 'Evidence Source PubMed ID (PMID)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_pathway_link` ALTER COLUMN `gene_role_in_pathway` SET TAGS ('dbx_business_glossary_term' = 'Gene Role in Pathway');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_pathway_link` ALTER COLUMN `genome_build` SET TAGS ('dbx_business_glossary_term' = 'Genome Build');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_pathway_link` ALTER COLUMN `genome_build` SET TAGS ('dbx_value_regex' = 'GRCh38|hg38|GRCh37|hg19|T2T-CHM13');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_pathway_link` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_pathway_link` ALTER COLUMN `is_disease_associated` SET TAGS ('dbx_business_glossary_term' = 'Is Disease Associated');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_pathway_link` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_pathway_link` ALTER COLUMN `membership_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Membership Confidence Score');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_pathway_link` ALTER COLUMN `membership_role` SET TAGS ('dbx_business_glossary_term' = 'Membership Role');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_pathway_link` ALTER COLUMN `membership_role` SET TAGS ('dbx_value_regex' = 'direct|inferred|predicted|curated');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_pathway_link` ALTER COLUMN `pathway_source_database` SET TAGS ('dbx_business_glossary_term' = 'Pathway Source Database');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_pathway_link` ALTER COLUMN `quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Flag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_pathway_link` ALTER COLUMN `quality_flag` SET TAGS ('dbx_value_regex' = 'validated|provisional|deprecated|conflicting');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_pathway_link` ALTER COLUMN `species` SET TAGS ('dbx_business_glossary_term' = 'Species');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_pathway_link` ALTER COLUMN `species` SET TAGS ('dbx_value_regex' = 'Homo sapiens|Mus musculus|Rattus norvegicus|Danio rerio|Drosophila melanogaster|Caenorhabditis elegans');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` SET TAGS ('dbx_subdomain' = 'genome_reference');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `genomic_region_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Region Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `gene_model_id` SET TAGS ('dbx_business_glossary_term' = 'Gene Model Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `superseded_by_region_genomic_region_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Genomic Region Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending_approval|rejected|under_validation');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `artifact_flag` SET TAGS ('dbx_business_glossary_term' = 'Artifact Flag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `assay_design_purpose` SET TAGS ('dbx_business_glossary_term' = 'Assay Design Purpose');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `bed_file_path` SET TAGS ('dbx_business_glossary_term' = 'BED File Path');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_business_glossary_term' = 'MD5 Checksum');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{32}$');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `chromosome` SET TAGS ('dbx_business_glossary_term' = 'Chromosome');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `chromosome` SET TAGS ('dbx_value_regex' = '^(chr)?([1-9]|1[0-9]|2[0-2]|X|Y|M|MT)$');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `clinical_significance` SET TAGS ('dbx_business_glossary_term' = 'Clinical Significance');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `end_position` SET TAGS ('dbx_business_glossary_term' = 'Genomic End Position');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `gc_content_percent` SET TAGS ('dbx_business_glossary_term' = 'GC Content Percentage');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `mappability_score` SET TAGS ('dbx_business_glossary_term' = 'Mappability Score');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `region_description` SET TAGS ('dbx_business_glossary_term' = 'Genomic Region Description');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `region_identifier` SET TAGS ('dbx_business_glossary_term' = 'Genomic Region Business Identifier');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `region_length_bp` SET TAGS ('dbx_business_glossary_term' = 'Genomic Region Length in Base Pairs (BP)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `region_name` SET TAGS ('dbx_business_glossary_term' = 'Genomic Region Name');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `region_set_name` SET TAGS ('dbx_business_glossary_term' = 'Genomic Region Set Name');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `region_set_version` SET TAGS ('dbx_business_glossary_term' = 'Genomic Region Set Version');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `region_status` SET TAGS ('dbx_business_glossary_term' = 'Genomic Region Status');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `region_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|under_review|draft|retired');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `region_type` SET TAGS ('dbx_business_glossary_term' = 'Genomic Region Type');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'IVD|RUO|LDT|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `repeat_masked_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Masked Flag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `source_authority` SET TAGS ('dbx_business_glossary_term' = 'Source Authority');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `source_publication` SET TAGS ('dbx_business_glossary_term' = 'Source Publication');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `source_vendor` SET TAGS ('dbx_business_glossary_term' = 'Source Vendor');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `start_position` SET TAGS ('dbx_business_glossary_term' = 'Genomic Start Position');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `strand` SET TAGS ('dbx_business_glossary_term' = 'Genomic Strand');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `strand` SET TAGS ('dbx_value_regex' = '+|-|.');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `target_coverage_depth` SET TAGS ('dbx_business_glossary_term' = 'Target Coverage Depth');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genomic_region` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` SET TAGS ('dbx_subdomain' = 'variant_knowledge');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` ALTER COLUMN `acmg_classification_rule_id` SET TAGS ('dbx_business_glossary_term' = 'ACMG (American College of Medical Genetics and Genomics) Classification Rule Identifier');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` ALTER COLUMN `acmg_classification_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Rule Status');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` ALTER COLUMN `acmg_classification_rule_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|draft|under_review');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` ALTER COLUMN `allelic_data_requirement` SET TAGS ('dbx_business_glossary_term' = 'Allelic Data Requirement');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` ALTER COLUMN `applicable_gene_contexts` SET TAGS ('dbx_business_glossary_term' = 'Applicable Gene Contexts');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` ALTER COLUMN `applicable_variant_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Variant Types');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` ALTER COLUMN `authoritative_source` SET TAGS ('dbx_business_glossary_term' = 'Authoritative Source');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` ALTER COLUMN `automation_flag` SET TAGS ('dbx_business_glossary_term' = 'Automation Flag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` ALTER COLUMN `clingen_refinement_specification` SET TAGS ('dbx_business_glossary_term' = 'ClinGen (Clinical Genome Resource) Refinement Specification');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` ALTER COLUMN `computational_prediction_requirement` SET TAGS ('dbx_business_glossary_term' = 'Computational Prediction Requirement');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` ALTER COLUMN `data_source_requirements` SET TAGS ('dbx_business_glossary_term' = 'Data Source Requirements');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` ALTER COLUMN `de_novo_requirement` SET TAGS ('dbx_business_glossary_term' = 'De Novo Occurrence Requirement');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` ALTER COLUMN `evidence_category` SET TAGS ('dbx_business_glossary_term' = 'Evidence Category');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` ALTER COLUMN `evidence_category` SET TAGS ('dbx_value_regex' = 'pathogenic|benign');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` ALTER COLUMN `evidence_code` SET TAGS ('dbx_business_glossary_term' = 'ACMG (American College of Medical Genetics and Genomics) Evidence Code');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` ALTER COLUMN `evidence_description` SET TAGS ('dbx_business_glossary_term' = 'Evidence Code Description');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` ALTER COLUMN `evidence_name` SET TAGS ('dbx_business_glossary_term' = 'Evidence Code Name');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` ALTER COLUMN `frequency_threshold` SET TAGS ('dbx_business_glossary_term' = 'Population Frequency Threshold');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` ALTER COLUMN `functional_assay_requirement` SET TAGS ('dbx_business_glossary_term' = 'Functional Assay Requirement');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` ALTER COLUMN `implementation_logic` SET TAGS ('dbx_business_glossary_term' = 'Implementation Logic');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` ALTER COLUMN `manual_review_required` SET TAGS ('dbx_business_glossary_term' = 'Manual Review Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Implementation Notes');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` ALTER COLUMN `phenotype_specificity_requirement` SET TAGS ('dbx_business_glossary_term' = 'Phenotype Specificity Requirement');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` ALTER COLUMN `publication_reference` SET TAGS ('dbx_business_glossary_term' = 'Publication Reference');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` ALTER COLUMN `reputable_source_requirement` SET TAGS ('dbx_business_glossary_term' = 'Reputable Source Requirement');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` ALTER COLUMN `segregation_requirement` SET TAGS ('dbx_business_glossary_term' = 'Segregation Requirement');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` ALTER COLUMN `strength_level` SET TAGS ('dbx_business_glossary_term' = 'Evidence Strength Level');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` ALTER COLUMN `strength_level` SET TAGS ('dbx_value_regex' = 'very_strong|strong|moderate|supporting|stand_alone');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`acmg_classification_rule` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Rule Version');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` SET TAGS ('dbx_subdomain' = 'pathway_ontology');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `ontology_term_id` SET TAGS ('dbx_business_glossary_term' = 'Ontology Term Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `parent_term_ontology_term_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Term Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `primary_replacement_term_ontology_term_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Term Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `child_term_count` SET TAGS ('dbx_business_glossary_term' = 'Child Term Count');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `comment` SET TAGS ('dbx_business_glossary_term' = 'Comment');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `cross_references` SET TAGS ('dbx_business_glossary_term' = 'Cross-References (Xrefs)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `curation_status` SET TAGS ('dbx_business_glossary_term' = 'Curation Status');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `curation_status` SET TAGS ('dbx_value_regex' = 'curated|automated|pending_review|approved|rejected');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `deprecated_date` SET TAGS ('dbx_business_glossary_term' = 'Deprecated Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `evidence_code` SET TAGS ('dbx_business_glossary_term' = 'Evidence Code');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `ingestion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ingestion Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `is_deprecated` SET TAGS ('dbx_business_glossary_term' = 'Is Deprecated Flag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `is_root_term` SET TAGS ('dbx_business_glossary_term' = 'Is Root Term Flag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `namespace` SET TAGS ('dbx_business_glossary_term' = 'Namespace');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `ontology_source` SET TAGS ('dbx_business_glossary_term' = 'Ontology Source');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `ontology_version` SET TAGS ('dbx_business_glossary_term' = 'Ontology Version');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `regulatory_applicability` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Applicability');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `source_url` SET TAGS ('dbx_business_glossary_term' = 'Source Uniform Resource Locator (URL)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `subset_membership` SET TAGS ('dbx_business_glossary_term' = 'Subset Membership');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `synonyms` SET TAGS ('dbx_business_glossary_term' = 'Synonyms');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `term_accession` SET TAGS ('dbx_business_glossary_term' = 'Term Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `term_accession` SET TAGS ('dbx_value_regex' = '^[A-Z]+:[0-9]{7,10}$');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `term_definition` SET TAGS ('dbx_business_glossary_term' = 'Term Definition');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `term_name` SET TAGS ('dbx_business_glossary_term' = 'Term Name');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `term_status` SET TAGS ('dbx_business_glossary_term' = 'Term Status');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `term_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|provisional|retired');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `term_type` SET TAGS ('dbx_business_glossary_term' = 'Term Type');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `term_type` SET TAGS ('dbx_value_regex' = 'class|property|individual|annotation_property|object_property|data_property');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `usage_frequency` SET TAGS ('dbx_business_glossary_term' = 'Usage Frequency');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`ontology_term` ALTER COLUMN `use_case_category` SET TAGS ('dbx_business_glossary_term' = 'Use Case Category');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` SET TAGS ('dbx_subdomain' = 'variant_knowledge');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `pharmacogenomics_marker_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacogenomics (PGx) Marker Identifier');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `gene_model_id` SET TAGS ('dbx_business_glossary_term' = 'Gene Model Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `alternate_allele` SET TAGS ('dbx_business_glossary_term' = 'Alternate Allele');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `alternate_allele` SET TAGS ('dbx_value_regex' = '^[ACGTN]+$');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `associated_drugs` SET TAGS ('dbx_business_glossary_term' = 'Associated Drugs');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `chromosome` SET TAGS ('dbx_business_glossary_term' = 'Chromosome');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `chromosome` SET TAGS ('dbx_value_regex' = '^(chr)?([1-9]|1[0-9]|2[0-2]|X|Y|MT?)$');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `clinical_actionability_status` SET TAGS ('dbx_business_glossary_term' = 'Clinical Actionability Status');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `clinical_actionability_status` SET TAGS ('dbx_value_regex' = 'actionable|informative|research_only|uncertain');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `clinical_annotation` SET TAGS ('dbx_business_glossary_term' = 'Clinical Annotation');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `clinvar_variation_number` SET TAGS ('dbx_business_glossary_term' = 'ClinVar Variation Identifier');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `clinvar_variation_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,12}$');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `curation_date` SET TAGS ('dbx_business_glossary_term' = 'Curation Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `diplotype` SET TAGS ('dbx_business_glossary_term' = 'Diplotype');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `ema_pgx_label_flag` SET TAGS ('dbx_business_glossary_term' = 'EMA Pharmacogenomic (PGx) Label Flag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `evidence_level` SET TAGS ('dbx_business_glossary_term' = 'CPIC Evidence Level');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `evidence_level` SET TAGS ('dbx_value_regex' = '1A|1B|2A|2B|3|4');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `fda_pgx_label_flag` SET TAGS ('dbx_business_glossary_term' = 'FDA Pharmacogenomic (PGx) Label Flag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `functional_impact` SET TAGS ('dbx_business_glossary_term' = 'Functional Impact');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `functional_impact` SET TAGS ('dbx_value_regex' = 'no_function|decreased_function|normal_function|increased_function|uncertain_function');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `genomic_position` SET TAGS ('dbx_business_glossary_term' = 'Genomic Position');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `guideline_source` SET TAGS ('dbx_business_glossary_term' = 'Guideline Source');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `guideline_source` SET TAGS ('dbx_value_regex' = 'CPIC|DPWG|PharmGKB|FDA|EMA|other');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `guideline_version` SET TAGS ('dbx_business_glossary_term' = 'Guideline Version');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `hgvs_notation` SET TAGS ('dbx_business_glossary_term' = 'HGVS (Human Genome Variation Society) Notation');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `marker_code` SET TAGS ('dbx_business_glossary_term' = 'Pharmacogenomics (PGx) Marker Code');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `marker_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,50}$');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `marker_name` SET TAGS ('dbx_business_glossary_term' = 'Pharmacogenomics (PGx) Marker Name');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `pharmacogenomics_marker_status` SET TAGS ('dbx_business_glossary_term' = 'Marker Record Status');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `pharmacogenomics_marker_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|under_review|retired');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `pharmgkb_accession` SET TAGS ('dbx_business_glossary_term' = 'PharmGKB Accession Identifier');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `pharmgkb_accession` SET TAGS ('dbx_value_regex' = '^PA[0-9]{6,10}$');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `population_frequency` SET TAGS ('dbx_business_glossary_term' = 'Population Allele Frequency');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `population_group` SET TAGS ('dbx_business_glossary_term' = 'Population Group');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `predicted_phenotype` SET TAGS ('dbx_business_glossary_term' = 'Predicted Metabolizer Phenotype');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `reference_allele` SET TAGS ('dbx_business_glossary_term' = 'Reference Allele');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `reference_allele` SET TAGS ('dbx_value_regex' = '^[ACGTN]+$');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `rsid` SET TAGS ('dbx_business_glossary_term' = 'dbSNP Reference SNP (rs) Identifier');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `rsid` SET TAGS ('dbx_value_regex' = '^rs[0-9]{1,12}$');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `star_allele_designation` SET TAGS ('dbx_business_glossary_term' = 'Star Allele Designation');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `variant_type` SET TAGS ('dbx_business_glossary_term' = 'Variant Type');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `variant_type` SET TAGS ('dbx_value_regex' = 'SNP|CNV|indel|star_allele|haplotype|diplotype');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Marker Record Version');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_tag_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_tag_assignment` SET TAGS ('dbx_subdomain' = 'pathway_ontology');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_tag_assignment` SET TAGS ('dbx_association_edges' = 'reference.gene_model,data.catalog_tag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_tag_assignment` ALTER COLUMN `gene_tag_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Gene Tag Assignment ID');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_tag_assignment` ALTER COLUMN `catalog_tag_id` SET TAGS ('dbx_business_glossary_term' = 'Gene Tag Assignment - Catalog Tag Id');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_tag_assignment` ALTER COLUMN `gene_model_id` SET TAGS ('dbx_business_glossary_term' = 'Gene Tag Assignment - Gene Model Id');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_tag_assignment` ALTER COLUMN `assigned_by` SET TAGS ('dbx_business_glossary_term' = 'Assigned By');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_tag_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_tag_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_tag_assignment` ALTER COLUMN `classification_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Classification Algorithm');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_tag_assignment` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_tag_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_tag_assignment` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_tag_assignment` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_tag_assignment` ALTER COLUMN `evidence_source` SET TAGS ('dbx_business_glossary_term' = 'Evidence Source');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_tag_assignment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_tag_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_tag_assignment` ALTER COLUMN `review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Review Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_qualification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_qualification` SET TAGS ('dbx_subdomain' = 'variant_knowledge');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_qualification` SET TAGS ('dbx_association_edges' = 'workforce.employee,reference.variant_database');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_qualification` ALTER COLUMN `variant_database_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Variant Database Qualification - Variant Database Qualification Id');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Variant Database Qualification - Employee Id');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_qualification` ALTER COLUMN `qualified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Qualified By Employee ID');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_qualification` ALTER COLUMN `qualified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_qualification` ALTER COLUMN `qualified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_qualification` ALTER COLUMN `variant_database_id` SET TAGS ('dbx_business_glossary_term' = 'Variant Database Qualification - Variant Database Id');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_qualification` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_qualification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_qualification` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_qualification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_qualification` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_qualification` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_qualification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_qualification` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Level');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_qualification` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_qualification` ALTER COLUMN `training_version` SET TAGS ('dbx_business_glossary_term' = 'Training Version');
