-- Metric views for domain: reference | Business: Genomics Biotech | Version: 1 | Generated on: 2026-05-06 12:58:41

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`reference_gene_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key gene catalog health and composition metrics for strategic R&D planning"
  source: "`genomics_biotech_ecm`.`reference`.`gene_model`"
  dimensions:
    - name: "gene_name"
      expr: gene_name
      comment: "HGNC gene symbol"
    - name: "gene_biotype"
      expr: gene_biotype
      comment: "Biotype classification (e.g., protein_coding, lncRNA)"
    - name: "chromosome"
      expr: chromosome
      comment: "Chromosome on which the gene resides"
    - name: "gene_status"
      expr: gene_status
      comment: "Current curation status of the gene record"
    - name: "genome_build"
      expr: genome_build
      comment: "Reference genome build used for annotation"
  measures:
    - name: "total_genes"
      expr: COUNT(1)
      comment: "Total number of gene records in the catalog"
    - name: "essential_gene_count"
      expr: SUM(CASE WHEN essential_gene_flag THEN 1 ELSE 0 END)
      comment: "Count of genes flagged as essential, indicating high priority research targets"
    - name: "cancer_gene_census_count"
      expr: SUM(CASE WHEN cancer_gene_census_flag THEN 1 ELSE 0 END)
      comment: "Number of genes included in the Cancer Gene Census, useful for oncology pipeline planning"
    - name: "average_gene_length_bp"
      expr: AVG(CAST(gene_length_bp AS DOUBLE))
      comment: "Average length of genes in base pairs, informs sequencing resource allocation"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`reference_pharmacogenomics_marker`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics to assess the breadth and regulatory status of pharmacogenomic markers for drug development decisions"
  source: "`genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker`"
  dimensions:
    - name: "chromosome"
      expr: chromosome
      comment: "Chromosome where the marker is located"
    - name: "clinical_actionability_status"
      expr: clinical_actionability_status
      comment: "Whether the marker is clinically actionable"
    - name: "gene_model_id"
      expr: gene_model_id
      comment: "Foreign key to associated gene model"
  measures:
    - name: "total_markers"
      expr: COUNT(1)
      comment: "Total pharmacogenomics markers cataloged"
    - name: "fda_labeled_marker_count"
      expr: SUM(CASE WHEN fda_pgx_label_flag THEN 1 ELSE 0 END)
      comment: "Markers with FDA PGx label, indicating regulatory relevance"
    - name: "ema_labeled_marker_count"
      expr: SUM(CASE WHEN ema_pgx_label_flag THEN 1 ELSE 0 END)
      comment: "Markers with EMA PGx label"
    - name: "average_population_frequency"
      expr: AVG(CAST(population_frequency AS DOUBLE))
      comment: "Mean population allele frequency across markers, informs prevalence assessment"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`reference_genomic_region`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic view of curated genomic regions for assay design and regulatory reporting"
  source: "`genomics_biotech_ecm`.`reference`.`genomic_region`"
  dimensions:
    - name: "chromosome"
      expr: chromosome
      comment: "Chromosome of the region"
    - name: "region_type"
      expr: region_type
      comment: "Type of genomic region (e.g., exon, intron, promoter)"
    - name: "clinical_significance"
      expr: clinical_significance
      comment: "Clinical significance annotation"
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the region"
  measures:
    - name: "total_regions"
      expr: COUNT(1)
      comment: "Total genomic regions defined"
    - name: "average_region_length_bp"
      expr: AVG(CAST(region_length_bp AS DOUBLE))
      comment: "Mean length of regions, useful for coverage planning"
    - name: "active_region_count"
      expr: SUM(CASE WHEN artifact_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Count of regions not flagged as artifacts, representing usable regions"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`reference_population_allele_frequency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Population genetics metrics to monitor variant prevalence and guide study design"
  source: "`genomics_biotech_ecm`.`reference`.`population_allele_frequency`"
  dimensions:
    - name: "population_group"
      expr: population_group
      comment: "Population group (e.g., European, Asian)"
    - name: "chromosome"
      expr: chromosome
      comment: "Chromosome of the variant"
    - name: "variant_type"
      expr: variant_type
      comment: "Type of variant (e.g., SNV, INDEL)"
  measures:
    - name: "total_records"
      expr: COUNT(1)
      comment: "Total allele frequency records"
    - name: "average_allele_frequency"
      expr: AVG(CAST(allele_frequency AS DOUBLE))
      comment: "Mean allele frequency across the dataset"
    - name: "high_frequency_allele_count"
      expr: SUM(CASE WHEN allele_frequency > 0.05 THEN 1 ELSE 0 END)
      comment: "Count of alleles with frequency >5%, indicating common variants"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`reference_variant_database`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High‑level view of variant database coverage and activity for strategic data partnership decisions"
  source: "`genomics_biotech_ecm`.`reference`.`variant_database`"
  dimensions:
    - name: "database_name"
      expr: database_name
      comment: "Human‑readable name of the variant database"
    - name: "database_type"
      expr: database_type
      comment: "Type of database (e.g., clinical, research)"
    - name: "genome_build"
      expr: genome_build
      comment: "Reference genome build the database aligns to"
  measures:
    - name: "total_variants"
      expr: SUM(CAST(variant_count AS DOUBLE))
      comment: "Total number of variants across all databases"
    - name: "average_variants_per_database"
      expr: AVG(CAST(variant_count AS DOUBLE))
      comment: "Mean variant count per database"
    - name: "active_database_count"
      expr: SUM(CASE WHEN variant_database_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of variant databases currently active"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`reference_gene_pathway_link`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics on gene‑pathway relationships to support target discovery and pathway analysis initiatives"
  source: "`genomics_biotech_ecm`.`reference`.`gene_pathway_link`"
  dimensions:
    - name: "pathway_id"
      expr: pathway_id
      comment: "Identifier of the linked pathway"
    - name: "species"
      expr: species
      comment: "Species for which the pathway is defined"
    - name: "is_disease_associated"
      expr: is_disease_associated
      comment: "Flag indicating disease relevance"
  measures:
    - name: "total_links"
      expr: COUNT(1)
      comment: "Total gene‑pathway link records"
    - name: "active_link_count"
      expr: SUM(CASE WHEN is_active THEN 1 ELSE 0 END)
      comment: "Count of links currently active"
    - name: "disease_associated_link_count"
      expr: SUM(CASE WHEN is_disease_associated THEN 1 ELSE 0 END)
      comment: "Links flagged as disease associated, informing therapeutic target prioritization"
    - name: "average_membership_confidence"
      expr: AVG(CAST(membership_confidence_score AS DOUBLE))
      comment: "Mean confidence score for gene membership in pathways"
$$;