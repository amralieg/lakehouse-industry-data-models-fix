-- Cross-Domain Foreign Keys for Business: Genomics Biotech | Version: v1_ecm
-- Generated on: 2026-05-06 13:04:46
-- Total cross-domain FK constraints: 1880
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: bioinformatics, clinical, commercial, customer, data, finance, instrument, manufacturing, order, product, quality, reagent, reference, regulatory, research, sample, sequencing, supply, workforce

-- ========= bioinformatics --> clinical (1 constraint(s)) =========
-- Requires: bioinformatics schema, clinical schema
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_clia_accreditation_id` FOREIGN KEY (`clia_accreditation_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`clia_accreditation`(`clia_accreditation_id`);

-- ========= bioinformatics --> commercial (6 constraint(s)) =========
-- Requires: bioinformatics schema, commercial schema
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline` ADD CONSTRAINT `fk_bioinformatics_pipeline_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`campaign`(`campaign_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`bioinformatics_pipeline_run` ADD CONSTRAINT `fk_bioinformatics_bioinformatics_pipeline_run_field_application_activity_id` FOREIGN KEY (`field_application_activity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`field_application_activity`(`field_application_activity_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`bioinformatics_pipeline_run` ADD CONSTRAINT `fk_bioinformatics_bioinformatics_pipeline_run_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`genomic_artifact` ADD CONSTRAINT `fk_bioinformatics_genomic_artifact_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_authorization` ADD CONSTRAINT `fk_bioinformatics_pipeline_authorization_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`contract`(`contract_id`);

-- ========= bioinformatics --> customer (5 constraint(s)) =========
-- Requires: bioinformatics schema, customer schema
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`bioinformatics_pipeline_run` ADD CONSTRAINT `fk_bioinformatics_bioinformatics_pipeline_run_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`bioinformatics_pipeline_run` ADD CONSTRAINT `fk_bioinformatics_bioinformatics_pipeline_run_installed_instrument_id` FOREIGN KEY (`installed_instrument_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`installed_instrument`(`installed_instrument_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`genomic_artifact` ADD CONSTRAINT `fk_bioinformatics_genomic_artifact_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_authorization` ADD CONSTRAINT `fk_bioinformatics_pipeline_authorization_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);

-- ========= bioinformatics --> data (10 constraint(s)) =========
-- Requires: bioinformatics schema, data schema
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`bioinformatics_pipeline_run` ADD CONSTRAINT `fk_bioinformatics_bioinformatics_pipeline_run_quality_assessment_id` FOREIGN KEY (`quality_assessment_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_assessment`(`quality_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_annotation` ADD CONSTRAINT `fk_bioinformatics_variant_annotation_glossary_term_id` FOREIGN KEY (`glossary_term_id`) REFERENCES `genomics_biotech_ecm`.`data`.`glossary_term`(`glossary_term_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_qc_metric` ADD CONSTRAINT `fk_bioinformatics_pipeline_qc_metric_quality_issue_id` FOREIGN KEY (`quality_issue_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_issue`(`quality_issue_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_qc_metric` ADD CONSTRAINT `fk_bioinformatics_pipeline_qc_metric_quality_rule_id` FOREIGN KEY (`quality_rule_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_rule`(`quality_rule_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`genomic_artifact` ADD CONSTRAINT `fk_bioinformatics_genomic_artifact_genomic_access_control_id` FOREIGN KEY (`genomic_access_control_id`) REFERENCES `genomics_biotech_ecm`.`data`.`genomic_access_control`(`genomic_access_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`genomic_artifact` ADD CONSTRAINT `fk_bioinformatics_genomic_artifact_metadata_schema_id` FOREIGN KEY (`metadata_schema_id`) REFERENCES `genomics_biotech_ecm`.`data`.`metadata_schema`(`metadata_schema_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`genomic_artifact` ADD CONSTRAINT `fk_bioinformatics_genomic_artifact_quality_assessment_id` FOREIGN KEY (`quality_assessment_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_assessment`(`quality_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`genomic_artifact` ADD CONSTRAINT `fk_bioinformatics_genomic_artifact_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`snp_genotype_result` ADD CONSTRAINT `fk_bioinformatics_snp_genotype_result_glossary_term_id` FOREIGN KEY (`glossary_term_id`) REFERENCES `genomics_biotech_ecm`.`data`.`glossary_term`(`glossary_term_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`artifact_tag_assignment` ADD CONSTRAINT `fk_bioinformatics_artifact_tag_assignment_catalog_tag_id` FOREIGN KEY (`catalog_tag_id`) REFERENCES `genomics_biotech_ecm`.`data`.`catalog_tag`(`catalog_tag_id`);

-- ========= bioinformatics --> finance (7 constraint(s)) =========
-- Requires: bioinformatics schema, finance schema
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline` ADD CONSTRAINT `fk_bioinformatics_pipeline_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline` ADD CONSTRAINT `fk_bioinformatics_pipeline_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`bioinformatics_pipeline_run` ADD CONSTRAINT `fk_bioinformatics_bioinformatics_pipeline_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`compute_job` ADD CONSTRAINT `fk_bioinformatics_compute_job_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`compute_job` ADD CONSTRAINT `fk_bioinformatics_compute_job_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`internal_order`(`internal_order_id`);

-- ========= bioinformatics --> instrument (5 constraint(s)) =========
-- Requires: bioinformatics schema, instrument schema
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline` ADD CONSTRAINT `fk_bioinformatics_pipeline_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`bioinformatics_pipeline_run` ADD CONSTRAINT `fk_bioinformatics_bioinformatics_pipeline_run_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`bioinformatics_pipeline_run` ADD CONSTRAINT `fk_bioinformatics_bioinformatics_pipeline_run_instrument_run_id` FOREIGN KEY (`instrument_run_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`instrument_run`(`instrument_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_qc_metric` ADD CONSTRAINT `fk_bioinformatics_pipeline_qc_metric_instrument_run_id` FOREIGN KEY (`instrument_run_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`instrument_run`(`instrument_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`genomic_artifact` ADD CONSTRAINT `fk_bioinformatics_genomic_artifact_instrument_run_id` FOREIGN KEY (`instrument_run_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`instrument_run`(`instrument_run_id`);

-- ========= bioinformatics --> product (3 constraint(s)) =========
-- Requires: bioinformatics schema, product schema
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline` ADD CONSTRAINT `fk_bioinformatics_pipeline_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version` ADD CONSTRAINT `fk_bioinformatics_pipeline_version_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`genomic_artifact` ADD CONSTRAINT `fk_bioinformatics_genomic_artifact_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);

-- ========= bioinformatics --> quality (13 constraint(s)) =========
-- Requires: bioinformatics schema, quality schema
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline` ADD CONSTRAINT `fk_bioinformatics_pipeline_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version` ADD CONSTRAINT `fk_bioinformatics_pipeline_version_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`bioinformatics_pipeline_run` ADD CONSTRAINT `fk_bioinformatics_bioinformatics_pipeline_run_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`audit`(`audit_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`bioinformatics_pipeline_run` ADD CONSTRAINT `fk_bioinformatics_bioinformatics_pipeline_run_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_run_step` ADD CONSTRAINT `fk_bioinformatics_pipeline_run_step_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`compute_job` ADD CONSTRAINT `fk_bioinformatics_compute_job_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`alignment_result` ADD CONSTRAINT `fk_bioinformatics_alignment_result_qc_result_id` FOREIGN KEY (`qc_result_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`qc_result`(`qc_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_call_result` ADD CONSTRAINT `fk_bioinformatics_variant_call_result_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_annotation` ADD CONSTRAINT `fk_bioinformatics_variant_annotation_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`cnv_result` ADD CONSTRAINT `fk_bioinformatics_cnv_result_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_qc_metric` ADD CONSTRAINT `fk_bioinformatics_pipeline_qc_metric_qc_result_id` FOREIGN KEY (`qc_result_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`qc_result`(`qc_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`genomic_artifact` ADD CONSTRAINT `fk_bioinformatics_genomic_artifact_qc_result_id` FOREIGN KEY (`qc_result_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`qc_result`(`qc_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`snp_genotype_result` ADD CONSTRAINT `fk_bioinformatics_snp_genotype_result_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);

-- ========= bioinformatics --> reagent (6 constraint(s)) =========
-- Requires: bioinformatics schema, reagent schema
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version` ADD CONSTRAINT `fk_bioinformatics_pipeline_version_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`bioinformatics_pipeline_run` ADD CONSTRAINT `fk_bioinformatics_bioinformatics_pipeline_run_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`bioinformatics_pipeline_run` ADD CONSTRAINT `fk_bioinformatics_bioinformatics_pipeline_run_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`alignment_result` ADD CONSTRAINT `fk_bioinformatics_alignment_result_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_call_result` ADD CONSTRAINT `fk_bioinformatics_variant_call_result_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);

-- ========= bioinformatics --> reference (17 constraint(s)) =========
-- Requires: bioinformatics schema, reference schema
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline` ADD CONSTRAINT `fk_bioinformatics_pipeline_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version` ADD CONSTRAINT `fk_bioinformatics_pipeline_version_gene_annotation_track_id` FOREIGN KEY (`gene_annotation_track_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_annotation_track`(`gene_annotation_track_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`bioinformatics_pipeline_run` ADD CONSTRAINT `fk_bioinformatics_bioinformatics_pipeline_run_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_run_step` ADD CONSTRAINT `fk_bioinformatics_pipeline_run_step_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`compute_job` ADD CONSTRAINT `fk_bioinformatics_compute_job_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`alignment_result` ADD CONSTRAINT `fk_bioinformatics_alignment_result_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_call_result` ADD CONSTRAINT `fk_bioinformatics_variant_call_result_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_annotation` ADD CONSTRAINT `fk_bioinformatics_variant_annotation_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_annotation` ADD CONSTRAINT `fk_bioinformatics_variant_annotation_pharmacogenomics_marker_id` FOREIGN KEY (`pharmacogenomics_marker_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker`(`pharmacogenomics_marker_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_annotation` ADD CONSTRAINT `fk_bioinformatics_variant_annotation_transcript_model_id` FOREIGN KEY (`transcript_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`transcript_model`(`transcript_model_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_annotation` ADD CONSTRAINT `fk_bioinformatics_variant_annotation_variant_database_version_id` FOREIGN KEY (`variant_database_version_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database_version`(`variant_database_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`cnv_result` ADD CONSTRAINT `fk_bioinformatics_cnv_result_gene_model_id` FOREIGN KEY (`gene_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_model`(`gene_model_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`maf_record` ADD CONSTRAINT `fk_bioinformatics_maf_record_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_qc_metric` ADD CONSTRAINT `fk_bioinformatics_pipeline_qc_metric_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`genomic_artifact` ADD CONSTRAINT `fk_bioinformatics_genomic_artifact_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`data_lineage_event` ADD CONSTRAINT `fk_bioinformatics_data_lineage_event_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`snp_genotype_result` ADD CONSTRAINT `fk_bioinformatics_snp_genotype_result_gene_model_id` FOREIGN KEY (`gene_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_model`(`gene_model_id`);

-- ========= bioinformatics --> regulatory (6 constraint(s)) =========
-- Requires: bioinformatics schema, regulatory schema
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline` ADD CONSTRAINT `fk_bioinformatics_pipeline_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version` ADD CONSTRAINT `fk_bioinformatics_pipeline_version_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version` ADD CONSTRAINT `fk_bioinformatics_pipeline_version_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`alignment_result` ADD CONSTRAINT `fk_bioinformatics_alignment_result_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);

-- ========= bioinformatics --> research (2 constraint(s)) =========
-- Requires: bioinformatics schema, research schema
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`compute_job` ADD CONSTRAINT `fk_bioinformatics_compute_job_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);

-- ========= bioinformatics --> sample (10 constraint(s)) =========
-- Requires: bioinformatics schema, sample schema
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`bioinformatics_pipeline_run` ADD CONSTRAINT `fk_bioinformatics_bioinformatics_pipeline_run_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`alignment_result` ADD CONSTRAINT `fk_bioinformatics_alignment_result_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_call_result` ADD CONSTRAINT `fk_bioinformatics_variant_call_result_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_annotation` ADD CONSTRAINT `fk_bioinformatics_variant_annotation_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`cnv_result` ADD CONSTRAINT `fk_bioinformatics_cnv_result_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`maf_record` ADD CONSTRAINT `fk_bioinformatics_maf_record_cohort_id` FOREIGN KEY (`cohort_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`cohort`(`cohort_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_qc_metric` ADD CONSTRAINT `fk_bioinformatics_pipeline_qc_metric_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`genomic_artifact` ADD CONSTRAINT `fk_bioinformatics_genomic_artifact_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`data_lineage_event` ADD CONSTRAINT `fk_bioinformatics_data_lineage_event_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`snp_genotype_result` ADD CONSTRAINT `fk_bioinformatics_snp_genotype_result_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);

-- ========= bioinformatics --> sequencing (21 constraint(s)) =========
-- Requires: bioinformatics schema, sequencing schema
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`bioinformatics_pipeline_run` ADD CONSTRAINT `fk_bioinformatics_bioinformatics_pipeline_run_demux_result_id` FOREIGN KEY (`demux_result_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`demux_result`(`demux_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`alignment_result` ADD CONSTRAINT `fk_bioinformatics_alignment_result_flow_cell_id` FOREIGN KEY (`flow_cell_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`flow_cell`(`flow_cell_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`alignment_result` ADD CONSTRAINT `fk_bioinformatics_alignment_result_library_id` FOREIGN KEY (`library_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`library`(`library_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`alignment_result` ADD CONSTRAINT `fk_bioinformatics_alignment_result_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_run`(`sequencing_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_call_result` ADD CONSTRAINT `fk_bioinformatics_variant_call_result_library_id` FOREIGN KEY (`library_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`library`(`library_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_call_result` ADD CONSTRAINT `fk_bioinformatics_variant_call_result_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_run`(`sequencing_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_annotation` ADD CONSTRAINT `fk_bioinformatics_variant_annotation_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_run`(`sequencing_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`cnv_result` ADD CONSTRAINT `fk_bioinformatics_cnv_result_library_id` FOREIGN KEY (`library_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`library`(`library_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`cnv_result` ADD CONSTRAINT `fk_bioinformatics_cnv_result_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_run`(`sequencing_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`maf_record` ADD CONSTRAINT `fk_bioinformatics_maf_record_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_run`(`sequencing_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_qc_metric` ADD CONSTRAINT `fk_bioinformatics_pipeline_qc_metric_flow_cell_id` FOREIGN KEY (`flow_cell_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`flow_cell`(`flow_cell_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_qc_metric` ADD CONSTRAINT `fk_bioinformatics_pipeline_qc_metric_library_id` FOREIGN KEY (`library_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`library`(`library_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`genomic_artifact` ADD CONSTRAINT `fk_bioinformatics_genomic_artifact_demux_result_id` FOREIGN KEY (`demux_result_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`demux_result`(`demux_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`genomic_artifact` ADD CONSTRAINT `fk_bioinformatics_genomic_artifact_flow_cell_id` FOREIGN KEY (`flow_cell_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`flow_cell`(`flow_cell_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`genomic_artifact` ADD CONSTRAINT `fk_bioinformatics_genomic_artifact_library_id` FOREIGN KEY (`library_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`library`(`library_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`data_lineage_event` ADD CONSTRAINT `fk_bioinformatics_data_lineage_event_demux_result_id` FOREIGN KEY (`demux_result_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`demux_result`(`demux_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`data_lineage_event` ADD CONSTRAINT `fk_bioinformatics_data_lineage_event_library_id` FOREIGN KEY (`library_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`library`(`library_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`data_lineage_event` ADD CONSTRAINT `fk_bioinformatics_data_lineage_event_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_run`(`sequencing_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`snp_genotype_result` ADD CONSTRAINT `fk_bioinformatics_snp_genotype_result_array_hybridization_id` FOREIGN KEY (`array_hybridization_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`array_hybridization`(`array_hybridization_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`snp_genotype_result` ADD CONSTRAINT `fk_bioinformatics_snp_genotype_result_library_id` FOREIGN KEY (`library_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`library`(`library_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`snp_genotype_result` ADD CONSTRAINT `fk_bioinformatics_snp_genotype_result_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_run`(`sequencing_run_id`);

-- ========= bioinformatics --> supply (5 constraint(s)) =========
-- Requires: bioinformatics schema, supply schema
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`bioinformatics_pipeline_run` ADD CONSTRAINT `fk_bioinformatics_bioinformatics_pipeline_run_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`bioinformatics_pipeline_run` ADD CONSTRAINT `fk_bioinformatics_bioinformatics_pipeline_run_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`genomic_artifact` ADD CONSTRAINT `fk_bioinformatics_genomic_artifact_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);

-- ========= bioinformatics --> workforce (14 constraint(s)) =========
-- Requires: bioinformatics schema, workforce schema
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline` ADD CONSTRAINT `fk_bioinformatics_pipeline_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`bioinformatics_pipeline_run` ADD CONSTRAINT `fk_bioinformatics_bioinformatics_pipeline_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`compute_job` ADD CONSTRAINT `fk_bioinformatics_compute_job_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`compute_job` ADD CONSTRAINT `fk_bioinformatics_compute_job_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`alignment_result` ADD CONSTRAINT `fk_bioinformatics_alignment_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_annotation` ADD CONSTRAINT `fk_bioinformatics_variant_annotation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`cnv_result` ADD CONSTRAINT `fk_bioinformatics_cnv_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_qc_metric` ADD CONSTRAINT `fk_bioinformatics_pipeline_qc_metric_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_qc_metric` ADD CONSTRAINT `fk_bioinformatics_pipeline_qc_metric_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`genomic_artifact` ADD CONSTRAINT `fk_bioinformatics_genomic_artifact_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_primary_pipeline_employee_id` FOREIGN KEY (`primary_pipeline_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`snp_genotype_result` ADD CONSTRAINT `fk_bioinformatics_snp_genotype_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_authorization` ADD CONSTRAINT `fk_bioinformatics_pipeline_authorization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= clinical --> bioinformatics (10 constraint(s)) =========
-- Requires: clinical schema, bioinformatics schema
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_bioinformatics_pipeline_run_id` FOREIGN KEY (`bioinformatics_pipeline_run_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`bioinformatics_pipeline_run`(`bioinformatics_pipeline_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ADD CONSTRAINT `fk_clinical_clinical_specimen_bioinformatics_pipeline_run_id` FOREIGN KEY (`bioinformatics_pipeline_run_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`bioinformatics_pipeline_run`(`bioinformatics_pipeline_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ADD CONSTRAINT `fk_clinical_genomic_result_alignment_result_id` FOREIGN KEY (`alignment_result_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`alignment_result`(`alignment_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ADD CONSTRAINT `fk_clinical_genomic_result_bioinformatics_pipeline_run_id` FOREIGN KEY (`bioinformatics_pipeline_run_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`bioinformatics_pipeline_run`(`bioinformatics_pipeline_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ADD CONSTRAINT `fk_clinical_genomic_result_variant_call_result_id` FOREIGN KEY (`variant_call_result_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`variant_call_result`(`variant_call_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ADD CONSTRAINT `fk_clinical_variant_interpretation_variant_annotation_id` FOREIGN KEY (`variant_annotation_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`variant_annotation`(`variant_annotation_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ADD CONSTRAINT `fk_clinical_variant_interpretation_variant_call_result_id` FOREIGN KEY (`variant_call_result_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`variant_call_result`(`variant_call_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_bioinformatics_pipeline_run_id` FOREIGN KEY (`bioinformatics_pipeline_run_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`bioinformatics_pipeline_run`(`bioinformatics_pipeline_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_pipeline_run` ADD CONSTRAINT `fk_clinical_clinical_pipeline_run_bioinformatics_pipeline_run_id` FOREIGN KEY (`bioinformatics_pipeline_run_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`bioinformatics_pipeline_run`(`bioinformatics_pipeline_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_pipeline_run` ADD CONSTRAINT `fk_clinical_clinical_pipeline_run_pipeline_version_id` FOREIGN KEY (`pipeline_version_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version`(`pipeline_version_id`);

-- ========= clinical --> commercial (7 constraint(s)) =========
-- Requires: clinical schema, commercial schema
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`campaign`(`campaign_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`contract`(`contract_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_reagent_subscription_id` FOREIGN KEY (`reagent_subscription_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`reagent_subscription`(`reagent_subscription_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ADD CONSTRAINT `fk_clinical_patient_lead_id` FOREIGN KEY (`lead_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`lead`(`lead_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ADD CONSTRAINT `fk_clinical_report_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ADD CONSTRAINT `fk_clinical_authorized_orderer_kol_engagement_id` FOREIGN KEY (`kol_engagement_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`kol_engagement`(`kol_engagement_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`orderer_territory_assignment` ADD CONSTRAINT `fk_clinical_orderer_territory_assignment_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`territory`(`territory_id`);

-- ========= clinical --> customer (9 constraint(s)) =========
-- Requires: clinical schema, customer schema
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ADD CONSTRAINT `fk_clinical_clinical_consent_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genetic_counseling_session` ADD CONSTRAINT `fk_clinical_genetic_counseling_session_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ADD CONSTRAINT `fk_clinical_authorized_orderer_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`proficiency_testing` ADD CONSTRAINT `fk_clinical_proficiency_testing_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`pgx_report` ADD CONSTRAINT `fk_clinical_pgx_report_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_service_agreement` ADD CONSTRAINT `fk_clinical_test_service_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`orderer_authorization` ADD CONSTRAINT `fk_clinical_orderer_authorization_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`service_agreement`(`service_agreement_id`);

-- ========= clinical --> data (16 constraint(s)) =========
-- Requires: clinical schema, data schema
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ADD CONSTRAINT `fk_clinical_test_catalog_metadata_schema_id` FOREIGN KEY (`metadata_schema_id`) REFERENCES `genomics_biotech_ecm`.`data`.`metadata_schema`(`metadata_schema_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ADD CONSTRAINT `fk_clinical_test_catalog_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_metadata_schema_id` FOREIGN KEY (`metadata_schema_id`) REFERENCES `genomics_biotech_ecm`.`data`.`metadata_schema`(`metadata_schema_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_access_request_id` FOREIGN KEY (`access_request_id`) REFERENCES `genomics_biotech_ecm`.`data`.`access_request`(`access_request_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_dpia_id` FOREIGN KEY (`dpia_id`) REFERENCES `genomics_biotech_ecm`.`data`.`dpia`(`dpia_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`patient` ADD CONSTRAINT `fk_clinical_patient_genomic_access_control_id` FOREIGN KEY (`genomic_access_control_id`) REFERENCES `genomics_biotech_ecm`.`data`.`genomic_access_control`(`genomic_access_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ADD CONSTRAINT `fk_clinical_clinical_specimen_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ADD CONSTRAINT `fk_clinical_genomic_result_quality_rule_id` FOREIGN KEY (`quality_rule_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_rule`(`quality_rule_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ADD CONSTRAINT `fk_clinical_genomic_result_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ADD CONSTRAINT `fk_clinical_variant_interpretation_quality_assessment_id` FOREIGN KEY (`quality_assessment_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_assessment`(`quality_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ADD CONSTRAINT `fk_clinical_report_quality_assessment_id` FOREIGN KEY (`quality_assessment_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_assessment`(`quality_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ADD CONSTRAINT `fk_clinical_report_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ADD CONSTRAINT `fk_clinical_variant_knowledge_base_quality_assessment_id` FOREIGN KEY (`quality_assessment_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_assessment`(`quality_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ADD CONSTRAINT `fk_clinical_clinical_consent_record_dpia_id` FOREIGN KEY (`dpia_id`) REFERENCES `genomics_biotech_ecm`.`data`.`dpia`(`dpia_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ADD CONSTRAINT `fk_clinical_clinical_consent_record_genomic_access_control_id` FOREIGN KEY (`genomic_access_control_id`) REFERENCES `genomics_biotech_ecm`.`data`.`genomic_access_control`(`genomic_access_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_pipeline_run` ADD CONSTRAINT `fk_clinical_clinical_pipeline_run_quality_assessment_id` FOREIGN KEY (`quality_assessment_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_assessment`(`quality_assessment_id`);

-- ========= clinical --> finance (12 constraint(s)) =========
-- Requires: clinical schema, finance schema
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ADD CONSTRAINT `fk_clinical_test_catalog_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_rd_capitalization_id` FOREIGN KEY (`rd_capitalization_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`rd_capitalization`(`rd_capitalization_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_revenue_recognition_id` FOREIGN KEY (`revenue_recognition_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`revenue_recognition`(`revenue_recognition_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ADD CONSTRAINT `fk_clinical_analytical_validation_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ADD CONSTRAINT `fk_clinical_report_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ADD CONSTRAINT `fk_clinical_clia_accreditation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genetic_counseling_session` ADD CONSTRAINT `fk_clinical_genetic_counseling_session_revenue_recognition_id` FOREIGN KEY (`revenue_recognition_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`revenue_recognition`(`revenue_recognition_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`proficiency_testing` ADD CONSTRAINT `fk_clinical_proficiency_testing_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_pipeline_run` ADD CONSTRAINT `fk_clinical_clinical_pipeline_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= clinical --> instrument (4 constraint(s)) =========
-- Requires: clinical schema, instrument schema
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ADD CONSTRAINT `fk_clinical_genomic_result_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ADD CONSTRAINT `fk_clinical_report_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);

-- ========= clinical --> manufacturing (5 constraint(s)) =========
-- Requires: clinical schema, manufacturing schema
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ADD CONSTRAINT `fk_clinical_test_catalog_process_validation_id` FOREIGN KEY (`process_validation_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`process_validation`(`process_validation_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ADD CONSTRAINT `fk_clinical_test_catalog_production_routing_id` FOREIGN KEY (`production_routing_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_routing`(`production_routing_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ADD CONSTRAINT `fk_clinical_clinical_specimen_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);

-- ========= clinical --> order (2 constraint(s)) =========
-- Requires: clinical schema, order schema
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`proficiency_testing` ADD CONSTRAINT `fk_clinical_proficiency_testing_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);

-- ========= clinical --> product (8 constraint(s)) =========
-- Requires: clinical schema, product schema
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ADD CONSTRAINT `fk_clinical_test_catalog_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ADD CONSTRAINT `fk_clinical_analytical_validation_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_pipeline_run` ADD CONSTRAINT `fk_clinical_clinical_pipeline_run_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`pgx_report` ADD CONSTRAINT `fk_clinical_pgx_report_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);

-- ========= clinical --> quality (20 constraint(s)) =========
-- Requires: clinical schema, quality schema
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ADD CONSTRAINT `fk_clinical_clinical_specimen_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ADD CONSTRAINT `fk_clinical_clinical_specimen_qc_result_id` FOREIGN KEY (`qc_result_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`qc_result`(`qc_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ADD CONSTRAINT `fk_clinical_analytical_validation_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ADD CONSTRAINT `fk_clinical_analytical_validation_primary_analytical_controlled_document_id` FOREIGN KEY (`primary_analytical_controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ADD CONSTRAINT `fk_clinical_analytical_validation_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ADD CONSTRAINT `fk_clinical_variant_interpretation_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report_amendment` ADD CONSTRAINT `fk_clinical_report_amendment_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report_amendment` ADD CONSTRAINT `fk_clinical_report_amendment_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ADD CONSTRAINT `fk_clinical_variant_knowledge_base_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ADD CONSTRAINT `fk_clinical_clia_accreditation_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`audit`(`audit_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ADD CONSTRAINT `fk_clinical_clinical_consent_record_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`incidental_finding` ADD CONSTRAINT `fk_clinical_incidental_finding_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genetic_counseling_session` ADD CONSTRAINT `fk_clinical_genetic_counseling_session_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`proficiency_testing` ADD CONSTRAINT `fk_clinical_proficiency_testing_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`proficiency_testing` ADD CONSTRAINT `fk_clinical_proficiency_testing_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_pipeline_run` ADD CONSTRAINT `fk_clinical_clinical_pipeline_run_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`pgx_report` ADD CONSTRAINT `fk_clinical_pgx_report_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);

-- ========= clinical --> reagent (1 constraint(s)) =========
-- Requires: clinical schema, reagent schema
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);

-- ========= clinical --> reference (18 constraint(s)) =========
-- Requires: clinical schema, reference schema
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ADD CONSTRAINT `fk_clinical_test_catalog_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ADD CONSTRAINT `fk_clinical_analytical_validation_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ADD CONSTRAINT `fk_clinical_genomic_result_gene_model_id` FOREIGN KEY (`gene_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_model`(`gene_model_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ADD CONSTRAINT `fk_clinical_genomic_result_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ADD CONSTRAINT `fk_clinical_genomic_result_transcript_model_id` FOREIGN KEY (`transcript_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`transcript_model`(`transcript_model_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ADD CONSTRAINT `fk_clinical_variant_interpretation_acmg_classification_rule_id` FOREIGN KEY (`acmg_classification_rule_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`acmg_classification_rule`(`acmg_classification_rule_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ADD CONSTRAINT `fk_clinical_variant_interpretation_gene_model_id` FOREIGN KEY (`gene_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_model`(`gene_model_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ADD CONSTRAINT `fk_clinical_variant_interpretation_transcript_model_id` FOREIGN KEY (`transcript_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`transcript_model`(`transcript_model_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ADD CONSTRAINT `fk_clinical_report_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ADD CONSTRAINT `fk_clinical_variant_knowledge_base_acmg_classification_rule_id` FOREIGN KEY (`acmg_classification_rule_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`acmg_classification_rule`(`acmg_classification_rule_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ADD CONSTRAINT `fk_clinical_variant_knowledge_base_gene_model_id` FOREIGN KEY (`gene_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_model`(`gene_model_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`incidental_finding` ADD CONSTRAINT `fk_clinical_incidental_finding_acmg_classification_rule_id` FOREIGN KEY (`acmg_classification_rule_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`acmg_classification_rule`(`acmg_classification_rule_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`incidental_finding` ADD CONSTRAINT `fk_clinical_incidental_finding_gene_model_id` FOREIGN KEY (`gene_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_model`(`gene_model_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_pipeline_run` ADD CONSTRAINT `fk_clinical_clinical_pipeline_run_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`pgx_report` ADD CONSTRAINT `fk_clinical_pgx_report_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`pgx_report` ADD CONSTRAINT `fk_clinical_pgx_report_pharmacogenomics_marker_id` FOREIGN KEY (`pharmacogenomics_marker_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker`(`pharmacogenomics_marker_id`);

-- ========= clinical --> regulatory (10 constraint(s)) =========
-- Requires: clinical schema, regulatory schema
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ADD CONSTRAINT `fk_clinical_test_catalog_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ADD CONSTRAINT `fk_clinical_analytical_validation_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ADD CONSTRAINT `fk_clinical_report_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ADD CONSTRAINT `fk_clinical_variant_knowledge_base_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ADD CONSTRAINT `fk_clinical_clinical_consent_record_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`proficiency_testing` ADD CONSTRAINT `fk_clinical_proficiency_testing_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`pgx_report` ADD CONSTRAINT `fk_clinical_pgx_report_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);

-- ========= clinical --> research (15 constraint(s)) =========
-- Requires: clinical schema, research schema
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ADD CONSTRAINT `fk_clinical_test_catalog_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_assay_development_id` FOREIGN KEY (`assay_development_id`) REFERENCES `genomics_biotech_ecm`.`research`.`assay_development`(`assay_development_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ADD CONSTRAINT `fk_clinical_clinical_specimen_sample_request_id` FOREIGN KEY (`sample_request_id`) REFERENCES `genomics_biotech_ecm`.`research`.`sample_request`(`sample_request_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ADD CONSTRAINT `fk_clinical_analytical_validation_assay_development_id` FOREIGN KEY (`assay_development_id`) REFERENCES `genomics_biotech_ecm`.`research`.`assay_development`(`assay_development_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ADD CONSTRAINT `fk_clinical_genomic_result_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ADD CONSTRAINT `fk_clinical_variant_interpretation_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ADD CONSTRAINT `fk_clinical_report_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ADD CONSTRAINT `fk_clinical_clinical_consent_record_irb_submission_id` FOREIGN KEY (`irb_submission_id`) REFERENCES `genomics_biotech_ecm`.`research`.`irb_submission`(`irb_submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ADD CONSTRAINT `fk_clinical_clinical_consent_record_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`incidental_finding` ADD CONSTRAINT `fk_clinical_incidental_finding_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genetic_counseling_session` ADD CONSTRAINT `fk_clinical_genetic_counseling_session_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_pipeline_run` ADD CONSTRAINT `fk_clinical_clinical_pipeline_run_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`pgx_report` ADD CONSTRAINT `fk_clinical_pgx_report_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_enrollment` ADD CONSTRAINT `fk_clinical_clinical_enrollment_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);

-- ========= clinical --> sample (7 constraint(s)) =========
-- Requires: clinical schema, sample schema
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ADD CONSTRAINT `fk_clinical_clinical_specimen_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ADD CONSTRAINT `fk_clinical_genomic_result_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ADD CONSTRAINT `fk_clinical_variant_interpretation_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_pipeline_run` ADD CONSTRAINT `fk_clinical_clinical_pipeline_run_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`pgx_report` ADD CONSTRAINT `fk_clinical_pgx_report_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);

-- ========= clinical --> sequencing (8 constraint(s)) =========
-- Requires: clinical schema, sequencing schema
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ADD CONSTRAINT `fk_clinical_clinical_specimen_library_id` FOREIGN KEY (`library_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`library`(`library_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ADD CONSTRAINT `fk_clinical_genomic_result_library_id` FOREIGN KEY (`library_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`library`(`library_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ADD CONSTRAINT `fk_clinical_genomic_result_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_run`(`sequencing_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ADD CONSTRAINT `fk_clinical_variant_interpretation_library_id` FOREIGN KEY (`library_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`library`(`library_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ADD CONSTRAINT `fk_clinical_report_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_run`(`sequencing_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_flow_cell_id` FOREIGN KEY (`flow_cell_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`flow_cell`(`flow_cell_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_run`(`sequencing_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_pipeline_run` ADD CONSTRAINT `fk_clinical_clinical_pipeline_run_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_run`(`sequencing_run_id`);

-- ========= clinical --> supply (9 constraint(s)) =========
-- Requires: clinical schema, supply schema
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ADD CONSTRAINT `fk_clinical_test_catalog_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ADD CONSTRAINT `fk_clinical_clinical_specimen_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`proficiency_testing` ADD CONSTRAINT `fk_clinical_proficiency_testing_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_pipeline_run` ADD CONSTRAINT `fk_clinical_clinical_pipeline_run_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);

-- ========= clinical --> workforce (23 constraint(s)) =========
-- Requires: clinical schema, workforce schema
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ADD CONSTRAINT `fk_clinical_analytical_validation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ADD CONSTRAINT `fk_clinical_variant_interpretation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ADD CONSTRAINT `fk_clinical_variant_interpretation_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ADD CONSTRAINT `fk_clinical_variant_interpretation_tertiary_variant_modified_by_user_employee_id` FOREIGN KEY (`tertiary_variant_modified_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report_amendment` ADD CONSTRAINT `fk_clinical_report_amendment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ADD CONSTRAINT `fk_clinical_variant_knowledge_base_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ADD CONSTRAINT `fk_clinical_clia_accreditation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`incidental_finding` ADD CONSTRAINT `fk_clinical_incidental_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`incidental_finding` ADD CONSTRAINT `fk_clinical_incidental_finding_quaternary_incidental_approved_by_user_employee_id` FOREIGN KEY (`quaternary_incidental_approved_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`incidental_finding` ADD CONSTRAINT `fk_clinical_incidental_finding_tertiary_incidental_reviewed_by_user_employee_id` FOREIGN KEY (`tertiary_incidental_reviewed_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genetic_counseling_session` ADD CONSTRAINT `fk_clinical_genetic_counseling_session_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`proficiency_testing` ADD CONSTRAINT `fk_clinical_proficiency_testing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`proficiency_testing` ADD CONSTRAINT `fk_clinical_proficiency_testing_quaternary_proficiency_last_modified_by_user_employee_id` FOREIGN KEY (`quaternary_proficiency_last_modified_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`proficiency_testing` ADD CONSTRAINT `fk_clinical_proficiency_testing_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`proficiency_testing` ADD CONSTRAINT `fk_clinical_proficiency_testing_tertiary_proficiency_created_by_user_employee_id` FOREIGN KEY (`tertiary_proficiency_created_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_pipeline_run` ADD CONSTRAINT `fk_clinical_clinical_pipeline_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`pgx_report` ADD CONSTRAINT `fk_clinical_pgx_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_enrollment` ADD CONSTRAINT `fk_clinical_clinical_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`performing_laboratory` ADD CONSTRAINT `fk_clinical_performing_laboratory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`visit` ADD CONSTRAINT `fk_clinical_visit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`visit` ADD CONSTRAINT `fk_clinical_visit_location_id` FOREIGN KEY (`location_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`location`(`location_id`);

-- ========= commercial --> clinical (4 constraint(s)) =========
-- Requires: commercial schema, clinical schema
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`opportunity_line` ADD CONSTRAINT `fk_commercial_opportunity_line_assay_version_id` FOREIGN KEY (`assay_version_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`assay_version`(`assay_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`opportunity_line` ADD CONSTRAINT `fk_commercial_opportunity_line_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`territory_assignment` ADD CONSTRAINT `fk_commercial_territory_assignment_authorized_orderer_id` FOREIGN KEY (`authorized_orderer_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`authorized_orderer`(`authorized_orderer_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`price_book_entry` ADD CONSTRAINT `fk_commercial_price_book_entry_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_catalog`(`test_catalog_id`);

-- ========= commercial --> customer (24 constraint(s)) =========
-- Requires: commercial schema, customer schema
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`campaign_response` ADD CONSTRAINT `fk_commercial_campaign_response_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`campaign_response` ADD CONSTRAINT `fk_commercial_campaign_response_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`lead` ADD CONSTRAINT `fk_commercial_lead_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`lead` ADD CONSTRAINT `fk_commercial_lead_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`opportunity` ADD CONSTRAINT `fk_commercial_opportunity_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`opportunity` ADD CONSTRAINT `fk_commercial_opportunity_opportunity_partner_account_id` FOREIGN KEY (`opportunity_partner_account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`opportunity` ADD CONSTRAINT `fk_commercial_opportunity_primary_opportunity_account_id` FOREIGN KEY (`primary_opportunity_account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`opportunity_line` ADD CONSTRAINT `fk_commercial_opportunity_line_installed_instrument_id` FOREIGN KEY (`installed_instrument_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`installed_instrument`(`installed_instrument_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`opportunity_line` ADD CONSTRAINT `fk_commercial_opportunity_line_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`territory_assignment` ADD CONSTRAINT `fk_commercial_territory_assignment_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`partner_deal_registration` ADD CONSTRAINT `fk_commercial_partner_deal_registration_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`win_loss_review` ADD CONSTRAINT `fk_commercial_win_loss_review_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`contract` ADD CONSTRAINT `fk_commercial_contract_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`contract` ADD CONSTRAINT `fk_commercial_contract_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`reagent_subscription` ADD CONSTRAINT `fk_commercial_reagent_subscription_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`reagent_subscription` ADD CONSTRAINT `fk_commercial_reagent_subscription_installed_instrument_id` FOREIGN KEY (`installed_instrument_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`installed_instrument`(`installed_instrument_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`reagent_subscription_order` ADD CONSTRAINT `fk_commercial_reagent_subscription_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`reagent_subscription_order` ADD CONSTRAINT `fk_commercial_reagent_subscription_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`reagent_subscription_order` ADD CONSTRAINT `fk_commercial_reagent_subscription_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`discount_approval` ADD CONSTRAINT `fk_commercial_discount_approval_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`field_application_activity` ADD CONSTRAINT `fk_commercial_field_application_activity_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`field_application_activity` ADD CONSTRAINT `fk_commercial_field_application_activity_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`field_application_activity` ADD CONSTRAINT `fk_commercial_field_application_activity_installed_instrument_id` FOREIGN KEY (`installed_instrument_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`installed_instrument`(`installed_instrument_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);

-- ========= commercial --> data (6 constraint(s)) =========
-- Requires: commercial schema, data schema
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`opportunity_line` ADD CONSTRAINT `fk_commercial_opportunity_line_metadata_schema_id` FOREIGN KEY (`metadata_schema_id`) REFERENCES `genomics_biotech_ecm`.`data`.`metadata_schema`(`metadata_schema_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`win_loss_review` ADD CONSTRAINT `fk_commercial_win_loss_review_quality_assessment_id` FOREIGN KEY (`quality_assessment_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_assessment`(`quality_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`reagent_subscription` ADD CONSTRAINT `fk_commercial_reagent_subscription_quality_rule_id` FOREIGN KEY (`quality_rule_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_rule`(`quality_rule_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`field_application_activity` ADD CONSTRAINT `fk_commercial_field_application_activity_quality_issue_id` FOREIGN KEY (`quality_issue_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_issue`(`quality_issue_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_fair_assessment_id` FOREIGN KEY (`fair_assessment_id`) REFERENCES `genomics_biotech_ecm`.`data`.`fair_assessment`(`fair_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`partner_genomic_access_authorization` ADD CONSTRAINT `fk_commercial_partner_genomic_access_authorization_genomic_access_control_id` FOREIGN KEY (`genomic_access_control_id`) REFERENCES `genomics_biotech_ecm`.`data`.`genomic_access_control`(`genomic_access_control_id`);

-- ========= commercial --> finance (3 constraint(s)) =========
-- Requires: commercial schema, finance schema
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`price_book` ADD CONSTRAINT `fk_commercial_price_book_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`price_book` ADD CONSTRAINT `fk_commercial_price_book_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`campaign_allocation` ADD CONSTRAINT `fk_commercial_campaign_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= commercial --> instrument (4 constraint(s)) =========
-- Requires: commercial schema, instrument schema
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`opportunity_line` ADD CONSTRAINT `fk_commercial_opportunity_line_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`reagent_subscription` ADD CONSTRAINT `fk_commercial_reagent_subscription_service_contract_id` FOREIGN KEY (`service_contract_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`service_contract`(`service_contract_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`price_book_entry` ADD CONSTRAINT `fk_commercial_price_book_entry_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`field_application_activity` ADD CONSTRAINT `fk_commercial_field_application_activity_instrument_run_id` FOREIGN KEY (`instrument_run_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`instrument_run`(`instrument_run_id`);

-- ========= commercial --> order (2 constraint(s)) =========
-- Requires: commercial schema, order schema
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`reagent_subscription_order` ADD CONSTRAINT `fk_commercial_reagent_subscription_order_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`discount_approval` ADD CONSTRAINT `fk_commercial_discount_approval_quotation_id` FOREIGN KEY (`quotation_id`) REFERENCES `genomics_biotech_ecm`.`order`.`quotation`(`quotation_id`);

-- ========= commercial --> product (13 constraint(s)) =========
-- Requires: commercial schema, product schema
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`campaign` ADD CONSTRAINT `fk_commercial_campaign_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`campaign` ADD CONSTRAINT `fk_commercial_campaign_family_id` FOREIGN KEY (`family_id`) REFERENCES `genomics_biotech_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`opportunity` ADD CONSTRAINT `fk_commercial_opportunity_family_id` FOREIGN KEY (`family_id`) REFERENCES `genomics_biotech_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`opportunity_line` ADD CONSTRAINT `fk_commercial_opportunity_line_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `genomics_biotech_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`opportunity_line` ADD CONSTRAINT `fk_commercial_opportunity_line_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`market_segment_target` ADD CONSTRAINT `fk_commercial_market_segment_target_family_id` FOREIGN KEY (`family_id`) REFERENCES `genomics_biotech_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`competitive_intel` ADD CONSTRAINT `fk_commercial_competitive_intel_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`reagent_subscription` ADD CONSTRAINT `fk_commercial_reagent_subscription_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`price_book_entry` ADD CONSTRAINT `fk_commercial_price_book_entry_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`price_book_entry` ADD CONSTRAINT `fk_commercial_price_book_entry_family_id` FOREIGN KEY (`family_id`) REFERENCES `genomics_biotech_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`price_book_entry` ADD CONSTRAINT `fk_commercial_price_book_entry_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`field_application_activity` ADD CONSTRAINT `fk_commercial_field_application_activity_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`forecast` ADD CONSTRAINT `fk_commercial_forecast_family_id` FOREIGN KEY (`family_id`) REFERENCES `genomics_biotech_ecm`.`product`.`family`(`family_id`);

-- ========= commercial --> reagent (8 constraint(s)) =========
-- Requires: commercial schema, reagent schema
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`opportunity_line` ADD CONSTRAINT `fk_commercial_opportunity_line_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`competitive_intel` ADD CONSTRAINT `fk_commercial_competitive_intel_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`contract` ADD CONSTRAINT `fk_commercial_contract_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`reagent_subscription` ADD CONSTRAINT `fk_commercial_reagent_subscription_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`reagent_subscription` ADD CONSTRAINT `fk_commercial_reagent_subscription_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`reagent_subscription_order` ADD CONSTRAINT `fk_commercial_reagent_subscription_order_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`price_book_entry` ADD CONSTRAINT `fk_commercial_price_book_entry_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`field_application_activity` ADD CONSTRAINT `fk_commercial_field_application_activity_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);

-- ========= commercial --> reference (7 constraint(s)) =========
-- Requires: commercial schema, reference schema
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`opportunity_line` ADD CONSTRAINT `fk_commercial_opportunity_line_gene_model_id` FOREIGN KEY (`gene_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_model`(`gene_model_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`opportunity_line` ADD CONSTRAINT `fk_commercial_opportunity_line_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`market_segment_target` ADD CONSTRAINT `fk_commercial_market_segment_target_gene_model_id` FOREIGN KEY (`gene_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_model`(`gene_model_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`competitive_intel` ADD CONSTRAINT `fk_commercial_competitive_intel_gene_model_id` FOREIGN KEY (`gene_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_model`(`gene_model_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`field_application_activity` ADD CONSTRAINT `fk_commercial_field_application_activity_gene_model_id` FOREIGN KEY (`gene_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_model`(`gene_model_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`field_application_activity` ADD CONSTRAINT `fk_commercial_field_application_activity_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_gene_model_id` FOREIGN KEY (`gene_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_model`(`gene_model_id`);

-- ========= commercial --> regulatory (3 constraint(s)) =========
-- Requires: commercial schema, regulatory schema
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`opportunity_line` ADD CONSTRAINT `fk_commercial_opportunity_line_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`opportunity_line` ADD CONSTRAINT `fk_commercial_opportunity_line_device_identifier_id` FOREIGN KEY (`device_identifier_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`device_identifier`(`device_identifier_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`reagent_subscription` ADD CONSTRAINT `fk_commercial_reagent_subscription_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);

-- ========= commercial --> supply (5 constraint(s)) =========
-- Requires: commercial schema, supply schema
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`contract` ADD CONSTRAINT `fk_commercial_contract_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`reagent_subscription` ADD CONSTRAINT `fk_commercial_reagent_subscription_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`reagent_subscription_order` ADD CONSTRAINT `fk_commercial_reagent_subscription_order_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`field_application_activity` ADD CONSTRAINT `fk_commercial_field_application_activity_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);

-- ========= commercial --> workforce (38 constraint(s)) =========
-- Requires: commercial schema, workforce schema
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`campaign_response` ADD CONSTRAINT `fk_commercial_campaign_response_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`lead` ADD CONSTRAINT `fk_commercial_lead_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`opportunity_line` ADD CONSTRAINT `fk_commercial_opportunity_line_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`opportunity_line` ADD CONSTRAINT `fk_commercial_opportunity_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`opportunity_line` ADD CONSTRAINT `fk_commercial_opportunity_line_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`territory` ADD CONSTRAINT `fk_commercial_territory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`territory` ADD CONSTRAINT `fk_commercial_territory_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`territory_assignment` ADD CONSTRAINT `fk_commercial_territory_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`sales_quota` ADD CONSTRAINT `fk_commercial_sales_quota_compensation_plan_id` FOREIGN KEY (`compensation_plan_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`compensation_plan`(`compensation_plan_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`sales_quota` ADD CONSTRAINT `fk_commercial_sales_quota_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`sales_quota` ADD CONSTRAINT `fk_commercial_sales_quota_quaternary_sales_modified_by_employee_id` FOREIGN KEY (`quaternary_sales_modified_by_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`sales_quota` ADD CONSTRAINT `fk_commercial_sales_quota_sales_holder_employee_id` FOREIGN KEY (`sales_holder_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`sales_quota` ADD CONSTRAINT `fk_commercial_sales_quota_tertiary_sales_created_by_employee_id` FOREIGN KEY (`tertiary_sales_created_by_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`channel_partner` ADD CONSTRAINT `fk_commercial_channel_partner_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`partner_deal_registration` ADD CONSTRAINT `fk_commercial_partner_deal_registration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`partner_deal_registration` ADD CONSTRAINT `fk_commercial_partner_deal_registration_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`market_segment_target` ADD CONSTRAINT `fk_commercial_market_segment_target_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`contract` ADD CONSTRAINT `fk_commercial_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`reagent_subscription` ADD CONSTRAINT `fk_commercial_reagent_subscription_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`reagent_subscription_order` ADD CONSTRAINT `fk_commercial_reagent_subscription_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`reagent_subscription_order` ADD CONSTRAINT `fk_commercial_reagent_subscription_order_quaternary_reagent_last_modified_by_user_employee_id` FOREIGN KEY (`quaternary_reagent_last_modified_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`reagent_subscription_order` ADD CONSTRAINT `fk_commercial_reagent_subscription_order_tertiary_reagent_created_by_user_employee_id` FOREIGN KEY (`tertiary_reagent_created_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`price_book` ADD CONSTRAINT `fk_commercial_price_book_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`price_book` ADD CONSTRAINT `fk_commercial_price_book_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`price_book_entry` ADD CONSTRAINT `fk_commercial_price_book_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`discount_approval` ADD CONSTRAINT `fk_commercial_discount_approval_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`discount_approval` ADD CONSTRAINT `fk_commercial_discount_approval_primary_discount_employee_id` FOREIGN KEY (`primary_discount_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`field_application_activity` ADD CONSTRAINT `fk_commercial_field_application_activity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`forecast` ADD CONSTRAINT `fk_commercial_forecast_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`forecast` ADD CONSTRAINT `fk_commercial_forecast_forecast_employee_id` FOREIGN KEY (`forecast_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`market_development_fund` ADD CONSTRAINT `fk_commercial_market_development_fund_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`market_development_fund` ADD CONSTRAINT `fk_commercial_market_development_fund_primary_market_employee_id` FOREIGN KEY (`primary_market_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`market_development_fund` ADD CONSTRAINT `fk_commercial_market_development_fund_quaternary_market_modified_by_user_employee_id` FOREIGN KEY (`quaternary_market_modified_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`market_development_fund` ADD CONSTRAINT `fk_commercial_market_development_fund_tertiary_market_created_by_user_employee_id` FOREIGN KEY (`tertiary_market_created_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`partner_genomic_access_authorization` ADD CONSTRAINT `fk_commercial_partner_genomic_access_authorization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`campaign_participation` ADD CONSTRAINT `fk_commercial_campaign_participation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`commercial`.`opportunity_team_member` ADD CONSTRAINT `fk_commercial_opportunity_team_member_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= customer --> bioinformatics (1 constraint(s)) =========
-- Requires: customer schema, bioinformatics schema
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ADD CONSTRAINT `fk_customer_technical_requirement_pipeline_version_id` FOREIGN KEY (`pipeline_version_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version`(`pipeline_version_id`);

-- ========= customer --> commercial (7 constraint(s)) =========
-- Requires: customer schema, commercial schema
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ADD CONSTRAINT `fk_customer_technical_requirement_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`campaign`(`campaign_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ADD CONSTRAINT `fk_customer_support_case_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ADD CONSTRAINT `fk_customer_evaluation_program_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ADD CONSTRAINT `fk_customer_research_collaboration_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);

-- ========= customer --> data (10 constraint(s)) =========
-- Requires: customer schema, data schema
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_mdm_policy_id` FOREIGN KEY (`mdm_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`mdm_policy`(`mdm_policy_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ADD CONSTRAINT `fk_customer_customer_consent_record_dpia_id` FOREIGN KEY (`dpia_id`) REFERENCES `genomics_biotech_ecm`.`data`.`dpia`(`dpia_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`customer_consent_record` ADD CONSTRAINT `fk_customer_customer_consent_record_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ADD CONSTRAINT `fk_customer_accreditation_quality_rule_id` FOREIGN KEY (`quality_rule_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_rule`(`quality_rule_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ADD CONSTRAINT `fk_customer_installed_instrument_quality_rule_id` FOREIGN KEY (`quality_rule_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_rule`(`quality_rule_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ADD CONSTRAINT `fk_customer_support_case_quality_issue_id` FOREIGN KEY (`quality_issue_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_issue`(`quality_issue_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ADD CONSTRAINT `fk_customer_nda_record_genomic_access_control_id` FOREIGN KEY (`genomic_access_control_id`) REFERENCES `genomics_biotech_ecm`.`data`.`genomic_access_control`(`genomic_access_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ADD CONSTRAINT `fk_customer_evaluation_program_genomic_access_control_id` FOREIGN KEY (`genomic_access_control_id`) REFERENCES `genomics_biotech_ecm`.`data`.`genomic_access_control`(`genomic_access_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ADD CONSTRAINT `fk_customer_research_collaboration_dpia_id` FOREIGN KEY (`dpia_id`) REFERENCES `genomics_biotech_ecm`.`data`.`dpia`(`dpia_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ADD CONSTRAINT `fk_customer_research_collaboration_genomic_access_control_id` FOREIGN KEY (`genomic_access_control_id`) REFERENCES `genomics_biotech_ecm`.`data`.`genomic_access_control`(`genomic_access_control_id`);

-- ========= customer --> finance (4 constraint(s)) =========
-- Requires: customer schema, finance schema
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ADD CONSTRAINT `fk_customer_installed_instrument_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ADD CONSTRAINT `fk_customer_training_enrollment_revenue_recognition_id` FOREIGN KEY (`revenue_recognition_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`revenue_recognition`(`revenue_recognition_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ADD CONSTRAINT `fk_customer_evaluation_program_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ADD CONSTRAINT `fk_customer_research_collaboration_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`internal_order`(`internal_order_id`);

-- ========= customer --> instrument (2 constraint(s)) =========
-- Requires: customer schema, instrument schema
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ADD CONSTRAINT `fk_customer_installed_instrument_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ADD CONSTRAINT `fk_customer_installed_instrument_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);

-- ========= customer --> order (3 constraint(s)) =========
-- Requires: customer schema, order schema
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ADD CONSTRAINT `fk_customer_technical_requirement_quotation_id` FOREIGN KEY (`quotation_id`) REFERENCES `genomics_biotech_ecm`.`order`.`quotation`(`quotation_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ADD CONSTRAINT `fk_customer_support_case_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ADD CONSTRAINT `fk_customer_evaluation_program_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);

-- ========= customer --> product (7 constraint(s)) =========
-- Requires: customer schema, product schema
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ADD CONSTRAINT `fk_customer_technical_requirement_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ADD CONSTRAINT `fk_customer_accreditation_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ADD CONSTRAINT `fk_customer_installed_instrument_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ADD CONSTRAINT `fk_customer_support_case_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ADD CONSTRAINT `fk_customer_training_enrollment_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ADD CONSTRAINT `fk_customer_evaluation_program_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);

-- ========= customer --> reagent (7 constraint(s)) =========
-- Requires: customer schema, reagent schema
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ADD CONSTRAINT `fk_customer_technical_requirement_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ADD CONSTRAINT `fk_customer_installed_instrument_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ADD CONSTRAINT `fk_customer_support_case_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ADD CONSTRAINT `fk_customer_support_case_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ADD CONSTRAINT `fk_customer_evaluation_program_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ADD CONSTRAINT `fk_customer_evaluation_program_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);

-- ========= customer --> reference (7 constraint(s)) =========
-- Requires: customer schema, reference schema
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ADD CONSTRAINT `fk_customer_technical_requirement_gene_annotation_track_id` FOREIGN KEY (`gene_annotation_track_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_annotation_track`(`gene_annotation_track_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ADD CONSTRAINT `fk_customer_technical_requirement_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ADD CONSTRAINT `fk_customer_accreditation_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ADD CONSTRAINT `fk_customer_installed_instrument_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ADD CONSTRAINT `fk_customer_support_case_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ADD CONSTRAINT `fk_customer_evaluation_program_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);

-- ========= customer --> regulatory (9 constraint(s)) =========
-- Requires: customer schema, regulatory schema
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ADD CONSTRAINT `fk_customer_accreditation_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ADD CONSTRAINT `fk_customer_installed_instrument_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ADD CONSTRAINT `fk_customer_installed_instrument_device_identifier_id` FOREIGN KEY (`device_identifier_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`device_identifier`(`device_identifier_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ADD CONSTRAINT `fk_customer_support_case_adverse_event_report_id` FOREIGN KEY (`adverse_event_report_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`adverse_event_report`(`adverse_event_report_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ADD CONSTRAINT `fk_customer_support_case_field_safety_action_id` FOREIGN KEY (`field_safety_action_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`field_safety_action`(`field_safety_action_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ADD CONSTRAINT `fk_customer_nda_record_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ADD CONSTRAINT `fk_customer_evaluation_program_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ADD CONSTRAINT `fk_customer_research_collaboration_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);

-- ========= customer --> supply (8 constraint(s)) =========
-- Requires: customer schema, supply schema
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ADD CONSTRAINT `fk_customer_technical_requirement_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ADD CONSTRAINT `fk_customer_installed_instrument_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ADD CONSTRAINT `fk_customer_installed_instrument_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ADD CONSTRAINT `fk_customer_support_case_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ADD CONSTRAINT `fk_customer_support_case_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ADD CONSTRAINT `fk_customer_evaluation_program_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contracted_material` ADD CONSTRAINT `fk_customer_contracted_material_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);

-- ========= customer --> workforce (16 constraint(s)) =========
-- Requires: customer schema, workforce schema
ALTER TABLE `genomics_biotech_ecm`.`customer`.`account_hierarchy` ADD CONSTRAINT `fk_customer_account_hierarchy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ADD CONSTRAINT `fk_customer_technical_requirement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_position_id` FOREIGN KEY (`position_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_interaction_employee_id` FOREIGN KEY (`interaction_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_interaction_last_modified_by_user_employee_id` FOREIGN KEY (`interaction_last_modified_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ADD CONSTRAINT `fk_customer_accreditation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ADD CONSTRAINT `fk_customer_installed_instrument_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ADD CONSTRAINT `fk_customer_support_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ADD CONSTRAINT `fk_customer_support_case_position_id` FOREIGN KEY (`position_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`training_enrollment` ADD CONSTRAINT `fk_customer_training_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`nda_record` ADD CONSTRAINT `fk_customer_nda_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`evaluation_program` ADD CONSTRAINT `fk_customer_evaluation_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`research_collaboration` ADD CONSTRAINT `fk_customer_research_collaboration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= data --> instrument (8 constraint(s)) =========
-- Requires: data schema, instrument schema
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ADD CONSTRAINT `fk_data_quality_rule_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ADD CONSTRAINT `fk_data_quality_assessment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ADD CONSTRAINT `fk_data_quality_assessment_instrument_run_id` FOREIGN KEY (`instrument_run_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`instrument_run`(`instrument_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ADD CONSTRAINT `fk_data_quality_issue_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ADD CONSTRAINT `fk_data_access_request_instrument_run_id` FOREIGN KEY (`instrument_run_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`instrument_run`(`instrument_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ADD CONSTRAINT `fk_data_fair_assessment_instrument_run_id` FOREIGN KEY (`instrument_run_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`instrument_run`(`instrument_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ADD CONSTRAINT `fk_data_fair_assessment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ADD CONSTRAINT `fk_data_asset_tag_assignment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);

-- ========= data --> product (7 constraint(s)) =========
-- Requires: data schema, product schema
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ADD CONSTRAINT `fk_data_quality_rule_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ADD CONSTRAINT `fk_data_quality_rule_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ADD CONSTRAINT `fk_data_quality_rule_software_release_id` FOREIGN KEY (`software_release_id`) REFERENCES `genomics_biotech_ecm`.`product`.`software_release`(`software_release_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ADD CONSTRAINT `fk_data_quality_rule_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ADD CONSTRAINT `fk_data_genomic_access_control_license_entitlement_id` FOREIGN KEY (`license_entitlement_id`) REFERENCES `genomics_biotech_ecm`.`product`.`license_entitlement`(`license_entitlement_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ADD CONSTRAINT `fk_data_retention_policy_regulatory_classification_id` FOREIGN KEY (`regulatory_classification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`regulatory_classification`(`regulatory_classification_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`retention_policy` ADD CONSTRAINT `fk_data_retention_policy_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);

-- ========= data --> reagent (1 constraint(s)) =========
-- Requires: data schema, reagent schema
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ADD CONSTRAINT `fk_data_quality_rule_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);

-- ========= data --> reference (9 constraint(s)) =========
-- Requires: data schema, reference schema
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ADD CONSTRAINT `fk_data_quality_rule_gene_annotation_track_id` FOREIGN KEY (`gene_annotation_track_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_annotation_track`(`gene_annotation_track_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ADD CONSTRAINT `fk_data_quality_rule_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_rule` ADD CONSTRAINT `fk_data_quality_rule_variant_database_version_id` FOREIGN KEY (`variant_database_version_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database_version`(`variant_database_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_assessment` ADD CONSTRAINT `fk_data_quality_assessment_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`genomic_access_control` ADD CONSTRAINT `fk_data_genomic_access_control_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ADD CONSTRAINT `fk_data_fair_assessment_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`metadata_schema` ADD CONSTRAINT `fk_data_metadata_schema_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`dpia` ADD CONSTRAINT `fk_data_dpia_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`glossary_term` ADD CONSTRAINT `fk_data_glossary_term_gene_model_id` FOREIGN KEY (`gene_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_model`(`gene_model_id`);

-- ========= data --> workforce (7 constraint(s)) =========
-- Requires: data schema, workforce schema
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ADD CONSTRAINT `fk_data_quality_issue_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`quality_issue` ADD CONSTRAINT `fk_data_quality_issue_tertiary_quality_verified_by_user_employee_id` FOREIGN KEY (`tertiary_quality_verified_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`access_request` ADD CONSTRAINT `fk_data_access_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`fair_assessment` ADD CONSTRAINT `fk_data_fair_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ADD CONSTRAINT `fk_data_asset_tag_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ADD CONSTRAINT `fk_data_asset_tag_assignment_quaternary_asset_deactivated_by_user_employee_id` FOREIGN KEY (`quaternary_asset_deactivated_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`data`.`asset_tag_assignment` ADD CONSTRAINT `fk_data_asset_tag_assignment_tertiary_asset_approved_by_user_employee_id` FOREIGN KEY (`tertiary_asset_approved_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= finance --> bioinformatics (2 constraint(s)) =========
-- Requires: finance schema, bioinformatics schema
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ADD CONSTRAINT `fk_finance_rd_capitalization_pipeline_id` FOREIGN KEY (`pipeline_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`pipeline`(`pipeline_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ADD CONSTRAINT `fk_finance_rd_capitalization_pipeline_version_id` FOREIGN KEY (`pipeline_version_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version`(`pipeline_version_id`);

-- ========= finance --> commercial (17 constraint(s)) =========
-- Requires: finance schema, commercial schema
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`contract`(`contract_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_market_segment_target_id` FOREIGN KEY (`market_segment_target_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`market_segment_target`(`market_segment_target_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`territory`(`territory_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`campaign`(`campaign_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_reagent_subscription_id` FOREIGN KEY (`reagent_subscription_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`reagent_subscription`(`reagent_subscription_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_channel_partner_id` FOREIGN KEY (`channel_partner_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`channel_partner`(`channel_partner_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`contract`(`contract_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`campaign`(`campaign_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`territory`(`territory_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`campaign`(`campaign_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_conference_event_id` FOREIGN KEY (`conference_event_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`conference_event`(`conference_event_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`contract`(`contract_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`performance_obligation` ADD CONSTRAINT `fk_finance_performance_obligation_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`contract`(`contract_id`);

-- ========= finance --> customer (5 constraint(s)) =========
-- Requires: finance schema, customer schema
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_payment_bank_account_id` FOREIGN KEY (`payment_bank_account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);

-- ========= finance --> data (6 constraint(s)) =========
-- Requires: finance schema, data schema
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_quality_issue_id` FOREIGN KEY (`quality_issue_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_issue`(`quality_issue_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_quality_issue_id` FOREIGN KEY (`quality_issue_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_issue`(`quality_issue_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_mdm_policy_id` FOREIGN KEY (`mdm_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`mdm_policy`(`mdm_policy_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ADD CONSTRAINT `fk_finance_sox_control_mdm_policy_id` FOREIGN KEY (`mdm_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`mdm_policy`(`mdm_policy_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ADD CONSTRAINT `fk_finance_sox_control_quality_assessment_id` FOREIGN KEY (`quality_assessment_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_assessment`(`quality_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ADD CONSTRAINT `fk_finance_sox_control_quality_rule_id` FOREIGN KEY (`quality_rule_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_rule`(`quality_rule_id`);

-- ========= finance --> order (2 constraint(s)) =========
-- Requires: finance schema, order schema
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);

-- ========= finance --> product (4 constraint(s)) =========
-- Requires: finance schema, product schema
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ADD CONSTRAINT `fk_finance_rd_capitalization_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);

-- ========= finance --> reference (1 constraint(s)) =========
-- Requires: finance schema, reference schema
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ADD CONSTRAINT `fk_finance_rd_capitalization_gene_annotation_track_id` FOREIGN KEY (`gene_annotation_track_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_annotation_track`(`gene_annotation_track_id`);

-- ========= finance --> research (2 constraint(s)) =========
-- Requires: finance schema, research schema
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ADD CONSTRAINT `fk_finance_rd_capitalization_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);

-- ========= finance --> supply (2 constraint(s)) =========
-- Requires: finance schema, supply schema
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);

-- ========= finance --> workforce (13 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_approver_employee_id` FOREIGN KEY (`approver_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_primary_internal_technical_lead_employee_id` FOREIGN KEY (`primary_internal_technical_lead_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ADD CONSTRAINT `fk_finance_sox_control_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= instrument --> clinical (1 constraint(s)) =========
-- Requires: instrument schema, clinical schema
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`test_qualification` ADD CONSTRAINT `fk_instrument_test_qualification_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_catalog`(`test_catalog_id`);

-- ========= instrument --> commercial (3 constraint(s)) =========
-- Requires: instrument schema, commercial schema
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ADD CONSTRAINT `fk_instrument_asset_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`contract`(`contract_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ADD CONSTRAINT `fk_instrument_asset_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ADD CONSTRAINT `fk_instrument_field_service_request_field_application_activity_id` FOREIGN KEY (`field_application_activity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`field_application_activity`(`field_application_activity_id`);

-- ========= instrument --> customer (15 constraint(s)) =========
-- Requires: instrument schema, customer schema
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ADD CONSTRAINT `fk_instrument_asset_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ADD CONSTRAINT `fk_instrument_asset_address_id` FOREIGN KEY (`address_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ADD CONSTRAINT `fk_instrument_installation_qualification_address_id` FOREIGN KEY (`address_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ADD CONSTRAINT `fk_instrument_pm_schedule_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ADD CONSTRAINT `fk_instrument_maintenance_event_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ADD CONSTRAINT `fk_instrument_maintenance_event_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ADD CONSTRAINT `fk_instrument_field_service_request_address_id` FOREIGN KEY (`address_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ADD CONSTRAINT `fk_instrument_field_service_request_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ADD CONSTRAINT `fk_instrument_field_service_request_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ADD CONSTRAINT `fk_instrument_performance_telemetry_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ADD CONSTRAINT `fk_instrument_instrument_run_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ADD CONSTRAINT `fk_instrument_service_contract_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ADD CONSTRAINT `fk_instrument_service_contract_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ADD CONSTRAINT `fk_instrument_service_contract_address_id` FOREIGN KEY (`address_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ADD CONSTRAINT `fk_instrument_spare_part_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);

-- ========= instrument --> data (1 constraint(s)) =========
-- Requires: instrument schema, data schema
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ADD CONSTRAINT `fk_instrument_performance_telemetry_quality_assessment_id` FOREIGN KEY (`quality_assessment_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_assessment`(`quality_assessment_id`);

-- ========= instrument --> finance (10 constraint(s)) =========
-- Requires: instrument schema, finance schema
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ADD CONSTRAINT `fk_instrument_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ADD CONSTRAINT `fk_instrument_asset_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ADD CONSTRAINT `fk_instrument_calibration_record_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ADD CONSTRAINT `fk_instrument_pm_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ADD CONSTRAINT `fk_instrument_maintenance_event_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ADD CONSTRAINT `fk_instrument_field_service_request_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ADD CONSTRAINT `fk_instrument_instrument_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ADD CONSTRAINT `fk_instrument_service_contract_revenue_recognition_id` FOREIGN KEY (`revenue_recognition_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`revenue_recognition`(`revenue_recognition_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ADD CONSTRAINT `fk_instrument_configuration_rd_capitalization_id` FOREIGN KEY (`rd_capitalization_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`rd_capitalization`(`rd_capitalization_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_plan` ADD CONSTRAINT `fk_instrument_maintenance_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= instrument --> manufacturing (6 constraint(s)) =========
-- Requires: instrument schema, manufacturing schema
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ADD CONSTRAINT `fk_instrument_asset_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ADD CONSTRAINT `fk_instrument_calibration_record_equipment_qualification_id` FOREIGN KEY (`equipment_qualification_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification`(`equipment_qualification_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ADD CONSTRAINT `fk_instrument_maintenance_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_order`(`work_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ADD CONSTRAINT `fk_instrument_performance_telemetry_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ADD CONSTRAINT `fk_instrument_instrument_run_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_order`(`work_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`batch_test` ADD CONSTRAINT `fk_instrument_batch_test_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);

-- ========= instrument --> order (3 constraint(s)) =========
-- Requires: instrument schema, order schema
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ADD CONSTRAINT `fk_instrument_service_contract_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`blanket_agreement` ADD CONSTRAINT `fk_instrument_blanket_agreement_blanket_order_id` FOREIGN KEY (`blanket_order_id`) REFERENCES `genomics_biotech_ecm`.`order`.`blanket_order`(`blanket_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_parts_supply_agreement` ADD CONSTRAINT `fk_instrument_spare_parts_supply_agreement_blanket_order_id` FOREIGN KEY (`blanket_order_id`) REFERENCES `genomics_biotech_ecm`.`order`.`blanket_order`(`blanket_order_id`);

-- ========= instrument --> product (2 constraint(s)) =========
-- Requires: instrument schema, product schema
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ADD CONSTRAINT `fk_instrument_service_contract_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ADD CONSTRAINT `fk_instrument_spare_part_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);

-- ========= instrument --> quality (5 constraint(s)) =========
-- Requires: instrument schema, quality schema
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ADD CONSTRAINT `fk_instrument_maintenance_event_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ADD CONSTRAINT `fk_instrument_firmware_deployment_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ADD CONSTRAINT `fk_instrument_configuration_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`test_qualification` ADD CONSTRAINT `fk_instrument_test_qualification_qualification_protocol_id` FOREIGN KEY (`qualification_protocol_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`qualification_protocol`(`qualification_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`batch_test` ADD CONSTRAINT `fk_instrument_batch_test_test_method_id` FOREIGN KEY (`test_method_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`test_method`(`test_method_id`);

-- ========= instrument --> reagent (4 constraint(s)) =========
-- Requires: instrument schema, reagent schema
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ADD CONSTRAINT `fk_instrument_model_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ADD CONSTRAINT `fk_instrument_performance_telemetry_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ADD CONSTRAINT `fk_instrument_instrument_run_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ADD CONSTRAINT `fk_instrument_instrument_run_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);

-- ========= instrument --> reference (10 constraint(s)) =========
-- Requires: instrument schema, reference schema
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ADD CONSTRAINT `fk_instrument_performance_telemetry_gene_model_id` FOREIGN KEY (`gene_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_model`(`gene_model_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ADD CONSTRAINT `fk_instrument_performance_telemetry_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ADD CONSTRAINT `fk_instrument_performance_telemetry_genomic_region_id` FOREIGN KEY (`genomic_region_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genomic_region`(`genomic_region_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ADD CONSTRAINT `fk_instrument_instrument_run_gene_annotation_track_id` FOREIGN KEY (`gene_annotation_track_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_annotation_track`(`gene_annotation_track_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ADD CONSTRAINT `fk_instrument_instrument_run_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ADD CONSTRAINT `fk_instrument_instrument_run_genomic_region_id` FOREIGN KEY (`genomic_region_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genomic_region`(`genomic_region_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ADD CONSTRAINT `fk_instrument_instrument_run_variant_database_id` FOREIGN KEY (`variant_database_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database`(`variant_database_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ADD CONSTRAINT `fk_instrument_configuration_gene_annotation_track_id` FOREIGN KEY (`gene_annotation_track_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_annotation_track`(`gene_annotation_track_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ADD CONSTRAINT `fk_instrument_configuration_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ADD CONSTRAINT `fk_instrument_configuration_genomic_region_id` FOREIGN KEY (`genomic_region_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genomic_region`(`genomic_region_id`);

-- ========= instrument --> regulatory (7 constraint(s)) =========
-- Requires: instrument schema, regulatory schema
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ADD CONSTRAINT `fk_instrument_asset_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ADD CONSTRAINT `fk_instrument_model_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ADD CONSTRAINT `fk_instrument_model_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ADD CONSTRAINT `fk_instrument_installation_qualification_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ADD CONSTRAINT `fk_instrument_pm_schedule_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ADD CONSTRAINT `fk_instrument_configuration_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`test_qualification` ADD CONSTRAINT `fk_instrument_test_qualification_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);

-- ========= instrument --> research (5 constraint(s)) =========
-- Requires: instrument schema, research schema
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ADD CONSTRAINT `fk_instrument_calibration_record_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ADD CONSTRAINT `fk_instrument_maintenance_event_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ADD CONSTRAINT `fk_instrument_performance_telemetry_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ADD CONSTRAINT `fk_instrument_instrument_run_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ADD CONSTRAINT `fk_instrument_configuration_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);

-- ========= instrument --> sequencing (3 constraint(s)) =========
-- Requires: instrument schema, sequencing schema
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ADD CONSTRAINT `fk_instrument_performance_telemetry_flow_cell_id` FOREIGN KEY (`flow_cell_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`flow_cell`(`flow_cell_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ADD CONSTRAINT `fk_instrument_instrument_run_flow_cell_id` FOREIGN KEY (`flow_cell_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`flow_cell`(`flow_cell_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ADD CONSTRAINT `fk_instrument_instrument_run_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_run`(`sequencing_run_id`);

-- ========= instrument --> supply (10 constraint(s)) =========
-- Requires: instrument schema, supply schema
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ADD CONSTRAINT `fk_instrument_asset_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ADD CONSTRAINT `fk_instrument_calibration_record_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ADD CONSTRAINT `fk_instrument_pm_schedule_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ADD CONSTRAINT `fk_instrument_maintenance_event_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ADD CONSTRAINT `fk_instrument_maintenance_event_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ADD CONSTRAINT `fk_instrument_field_service_request_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ADD CONSTRAINT `fk_instrument_instrument_run_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ADD CONSTRAINT `fk_instrument_spare_part_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ADD CONSTRAINT `fk_instrument_spare_part_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`cartridge` ADD CONSTRAINT `fk_instrument_cartridge_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);

-- ========= instrument --> workforce (14 constraint(s)) =========
-- Requires: instrument schema, workforce schema
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ADD CONSTRAINT `fk_instrument_asset_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ADD CONSTRAINT `fk_instrument_installation_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ADD CONSTRAINT `fk_instrument_calibration_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ADD CONSTRAINT `fk_instrument_pm_schedule_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ADD CONSTRAINT `fk_instrument_maintenance_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ADD CONSTRAINT `fk_instrument_field_service_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ADD CONSTRAINT `fk_instrument_performance_telemetry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ADD CONSTRAINT `fk_instrument_firmware_deployment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ADD CONSTRAINT `fk_instrument_firmware_deployment_tertiary_firmware_scheduled_by_user_employee_id` FOREIGN KEY (`tertiary_firmware_scheduled_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ADD CONSTRAINT `fk_instrument_instrument_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ADD CONSTRAINT `fk_instrument_service_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ADD CONSTRAINT `fk_instrument_configuration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`batch_test` ADD CONSTRAINT `fk_instrument_batch_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_plan` ADD CONSTRAINT `fk_instrument_maintenance_plan_location_id` FOREIGN KEY (`location_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`location`(`location_id`);

-- ========= manufacturing --> commercial (5 constraint(s)) =========
-- Requires: manufacturing schema, commercial schema
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ADD CONSTRAINT `fk_manufacturing_work_order_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ADD CONSTRAINT `fk_manufacturing_production_batch_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_market_segment_target_id` FOREIGN KEY (`market_segment_target_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`market_segment_target`(`market_segment_target_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ADD CONSTRAINT `fk_manufacturing_finished_goods_release_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`contract`(`contract_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`instrument_build_record` ADD CONSTRAINT `fk_manufacturing_instrument_build_record_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);

-- ========= manufacturing --> customer (4 constraint(s)) =========
-- Requires: manufacturing schema, customer schema
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ADD CONSTRAINT `fk_manufacturing_work_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ADD CONSTRAINT `fk_manufacturing_finished_goods_release_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);

-- ========= manufacturing --> data (15 constraint(s)) =========
-- Requires: manufacturing schema, data schema
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ADD CONSTRAINT `fk_manufacturing_work_order_mdm_policy_id` FOREIGN KEY (`mdm_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`mdm_policy`(`mdm_policy_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ADD CONSTRAINT `fk_manufacturing_work_order_quality_issue_id` FOREIGN KEY (`quality_issue_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_issue`(`quality_issue_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ADD CONSTRAINT `fk_manufacturing_production_batch_mdm_policy_id` FOREIGN KEY (`mdm_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`mdm_policy`(`mdm_policy_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ADD CONSTRAINT `fk_manufacturing_production_batch_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ADD CONSTRAINT `fk_manufacturing_inprocess_qc_result_quality_issue_id` FOREIGN KEY (`quality_issue_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_issue`(`quality_issue_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_dpia_id` FOREIGN KEY (`dpia_id`) REFERENCES `genomics_biotech_ecm`.`data`.`dpia`(`dpia_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_mdm_policy_id` FOREIGN KEY (`mdm_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`mdm_policy`(`mdm_policy_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_quality_assessment_id` FOREIGN KEY (`quality_assessment_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_assessment`(`quality_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_quality_issue_id` FOREIGN KEY (`quality_issue_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_issue`(`quality_issue_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ADD CONSTRAINT `fk_manufacturing_equipment_qualification_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_fair_assessment_id` FOREIGN KEY (`fair_assessment_id`) REFERENCES `genomics_biotech_ecm`.`data`.`fair_assessment`(`fair_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ADD CONSTRAINT `fk_manufacturing_work_center_metadata_schema_id` FOREIGN KEY (`metadata_schema_id`) REFERENCES `genomics_biotech_ecm`.`data`.`metadata_schema`(`metadata_schema_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ADD CONSTRAINT `fk_manufacturing_finished_goods_release_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`retention_policy`(`retention_policy_id`);

-- ========= manufacturing --> finance (8 constraint(s)) =========
-- Requires: manufacturing schema, finance schema
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ADD CONSTRAINT `fk_manufacturing_work_order_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ADD CONSTRAINT `fk_manufacturing_production_batch_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ADD CONSTRAINT `fk_manufacturing_production_batch_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ADD CONSTRAINT `fk_manufacturing_equipment_qualification_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ADD CONSTRAINT `fk_manufacturing_work_center_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`packaging_execution` ADD CONSTRAINT `fk_manufacturing_packaging_execution_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`instrument_build_record` ADD CONSTRAINT `fk_manufacturing_instrument_build_record_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);

-- ========= manufacturing --> instrument (2 constraint(s)) =========
-- Requires: manufacturing schema, instrument schema
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`env_monitoring_result` ADD CONSTRAINT `fk_manufacturing_env_monitoring_result_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment` ADD CONSTRAINT `fk_manufacturing_equipment_service_contract_id` FOREIGN KEY (`service_contract_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`service_contract`(`service_contract_id`);

-- ========= manufacturing --> order (1 constraint(s)) =========
-- Requires: manufacturing schema, order schema
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ADD CONSTRAINT `fk_manufacturing_work_order_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);

-- ========= manufacturing --> product (11 constraint(s)) =========
-- Requires: manufacturing schema, product schema
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ADD CONSTRAINT `fk_manufacturing_work_order_product_bom_id` FOREIGN KEY (`product_bom_id`) REFERENCES `genomics_biotech_ecm`.`product`.`product_bom`(`product_bom_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_product_bom_id` FOREIGN KEY (`product_bom_id`) REFERENCES `genomics_biotech_ecm`.`product`.`product_bom`(`product_bom_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ADD CONSTRAINT `fk_manufacturing_equipment_qualification_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ADD CONSTRAINT `fk_manufacturing_finished_goods_release_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`packaging_execution` ADD CONSTRAINT `fk_manufacturing_packaging_execution_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`instrument_build_record` ADD CONSTRAINT `fk_manufacturing_instrument_build_record_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ADD CONSTRAINT `fk_manufacturing_production_routing_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ADD CONSTRAINT `fk_manufacturing_production_routing_product_bom_id` FOREIGN KEY (`product_bom_id`) REFERENCES `genomics_biotech_ecm`.`product`.`product_bom`(`product_bom_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center_qualification` ADD CONSTRAINT `fk_manufacturing_work_center_qualification_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);

-- ========= manufacturing --> quality (22 constraint(s)) =========
-- Requires: manufacturing schema, quality schema
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ADD CONSTRAINT `fk_manufacturing_work_order_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ADD CONSTRAINT `fk_manufacturing_production_batch_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ADD CONSTRAINT `fk_manufacturing_production_batch_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ADD CONSTRAINT `fk_manufacturing_inprocess_qc_result_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ADD CONSTRAINT `fk_manufacturing_inprocess_qc_result_oos_investigation_id` FOREIGN KEY (`oos_investigation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`oos_investigation`(`oos_investigation_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ADD CONSTRAINT `fk_manufacturing_equipment_qualification_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ADD CONSTRAINT `fk_manufacturing_equipment_qualification_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ADD CONSTRAINT `fk_manufacturing_work_center_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ADD CONSTRAINT `fk_manufacturing_finished_goods_release_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ADD CONSTRAINT `fk_manufacturing_finished_goods_release_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`env_monitoring_result` ADD CONSTRAINT `fk_manufacturing_env_monitoring_result_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`env_monitoring_result` ADD CONSTRAINT `fk_manufacturing_env_monitoring_result_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`packaging_execution` ADD CONSTRAINT `fk_manufacturing_packaging_execution_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`packaging_execution` ADD CONSTRAINT `fk_manufacturing_packaging_execution_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`instrument_build_record` ADD CONSTRAINT `fk_manufacturing_instrument_build_record_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`instrument_build_record` ADD CONSTRAINT `fk_manufacturing_instrument_build_record_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ADD CONSTRAINT `fk_manufacturing_production_routing_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);

-- ========= manufacturing --> reagent (2 constraint(s)) =========
-- Requires: manufacturing schema, reagent schema
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ADD CONSTRAINT `fk_manufacturing_bom_component_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ADD CONSTRAINT `fk_manufacturing_inprocess_qc_result_qc_specification_id` FOREIGN KEY (`qc_specification_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`qc_specification`(`qc_specification_id`);

-- ========= manufacturing --> reference (12 constraint(s)) =========
-- Requires: manufacturing schema, reference schema
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ADD CONSTRAINT `fk_manufacturing_work_order_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ADD CONSTRAINT `fk_manufacturing_work_order_variant_database_id` FOREIGN KEY (`variant_database_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database`(`variant_database_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ADD CONSTRAINT `fk_manufacturing_production_batch_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ADD CONSTRAINT `fk_manufacturing_production_batch_variant_database_version_id` FOREIGN KEY (`variant_database_version_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database_version`(`variant_database_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_genomic_region_id` FOREIGN KEY (`genomic_region_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genomic_region`(`genomic_region_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ADD CONSTRAINT `fk_manufacturing_inprocess_qc_result_gene_model_id` FOREIGN KEY (`gene_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_model`(`gene_model_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_variant_database_id` FOREIGN KEY (`variant_database_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database`(`variant_database_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ADD CONSTRAINT `fk_manufacturing_finished_goods_release_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ADD CONSTRAINT `fk_manufacturing_finished_goods_release_variant_database_version_id` FOREIGN KEY (`variant_database_version_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database_version`(`variant_database_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`instrument_build_record` ADD CONSTRAINT `fk_manufacturing_instrument_build_record_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ADD CONSTRAINT `fk_manufacturing_production_routing_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);

-- ========= manufacturing --> regulatory (9 constraint(s)) =========
-- Requires: manufacturing schema, regulatory schema
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ADD CONSTRAINT `fk_manufacturing_work_order_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ADD CONSTRAINT `fk_manufacturing_finished_goods_release_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ADD CONSTRAINT `fk_manufacturing_finished_goods_release_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`packaging_execution` ADD CONSTRAINT `fk_manufacturing_packaging_execution_labeling_id` FOREIGN KEY (`labeling_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`labeling`(`labeling_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`instrument_build_record` ADD CONSTRAINT `fk_manufacturing_instrument_build_record_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);

-- ========= manufacturing --> research (7 constraint(s)) =========
-- Requires: manufacturing schema, research schema
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ADD CONSTRAINT `fk_manufacturing_work_order_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ADD CONSTRAINT `fk_manufacturing_work_order_technology_transfer_id` FOREIGN KEY (`technology_transfer_id`) REFERENCES `genomics_biotech_ecm`.`research`.`technology_transfer`(`technology_transfer_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_crispr_construct_id` FOREIGN KEY (`crispr_construct_id`) REFERENCES `genomics_biotech_ecm`.`research`.`crispr_construct`(`crispr_construct_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_molecular_design_id` FOREIGN KEY (`molecular_design_id`) REFERENCES `genomics_biotech_ecm`.`research`.`molecular_design`(`molecular_design_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_assay_development_id` FOREIGN KEY (`assay_development_id`) REFERENCES `genomics_biotech_ecm`.`research`.`assay_development`(`assay_development_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_technology_transfer_id` FOREIGN KEY (`technology_transfer_id`) REFERENCES `genomics_biotech_ecm`.`research`.`technology_transfer`(`technology_transfer_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ADD CONSTRAINT `fk_manufacturing_production_routing_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);

-- ========= manufacturing --> supply (6 constraint(s)) =========
-- Requires: manufacturing schema, supply schema
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ADD CONSTRAINT `fk_manufacturing_work_order_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ADD CONSTRAINT `fk_manufacturing_production_batch_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ADD CONSTRAINT `fk_manufacturing_production_batch_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ADD CONSTRAINT `fk_manufacturing_bom_component_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);

-- ========= manufacturing --> workforce (24 constraint(s)) =========
-- Requires: manufacturing schema, workforce schema
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ADD CONSTRAINT `fk_manufacturing_work_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ADD CONSTRAINT `fk_manufacturing_production_batch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ADD CONSTRAINT `fk_manufacturing_production_operation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ADD CONSTRAINT `fk_manufacturing_inprocess_qc_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ADD CONSTRAINT `fk_manufacturing_inprocess_qc_result_primary_inprocess_approved_by_employee_id` FOREIGN KEY (`primary_inprocess_approved_by_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_quaternary_batch_rejected_by_user_employee_id` FOREIGN KEY (`quaternary_batch_rejected_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_tertiary_batch_approved_by_user_employee_id` FOREIGN KEY (`tertiary_batch_approved_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ADD CONSTRAINT `fk_manufacturing_equipment_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ADD CONSTRAINT `fk_manufacturing_work_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ADD CONSTRAINT `fk_manufacturing_finished_goods_release_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`env_monitoring_result` ADD CONSTRAINT `fk_manufacturing_env_monitoring_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`packaging_execution` ADD CONSTRAINT `fk_manufacturing_packaging_execution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`packaging_execution` ADD CONSTRAINT `fk_manufacturing_packaging_execution_tertiary_packaging_qc_released_by_employee_id` FOREIGN KEY (`tertiary_packaging_qc_released_by_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`instrument_build_record` ADD CONSTRAINT `fk_manufacturing_instrument_build_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`instrument_build_record` ADD CONSTRAINT `fk_manufacturing_instrument_build_record_primary_instrument_assembly_technician_employee_id` FOREIGN KEY (`primary_instrument_assembly_technician_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ADD CONSTRAINT `fk_manufacturing_production_routing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ADD CONSTRAINT `fk_manufacturing_production_routing_tertiary_production_responsible_engineer_employee_id` FOREIGN KEY (`tertiary_production_responsible_engineer_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center_qualification` ADD CONSTRAINT `fk_manufacturing_work_center_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`qualification_participation` ADD CONSTRAINT `fk_manufacturing_qualification_participation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_campaign` ADD CONSTRAINT `fk_manufacturing_manufacturing_campaign_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_campaign` ADD CONSTRAINT `fk_manufacturing_manufacturing_campaign_operator_employee_id` FOREIGN KEY (`operator_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`monitoring_event` ADD CONSTRAINT `fk_manufacturing_monitoring_event_location_id` FOREIGN KEY (`location_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`location`(`location_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= order --> clinical (5 constraint(s)) =========
-- Requires: order schema, clinical schema
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ADD CONSTRAINT `fk_order_quotation_line_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_test_order_id` FOREIGN KEY (`test_order_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_order`(`test_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ADD CONSTRAINT `fk_order_credit_memo_test_order_id` FOREIGN KEY (`test_order_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_order`(`test_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_catalog`(`test_catalog_id`);

-- ========= order --> commercial (4 constraint(s)) =========
-- Requires: order schema, commercial schema
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ADD CONSTRAINT `fk_order_quotation_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`contract`(`contract_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);

-- ========= order --> customer (14 constraint(s)) =========
-- Requires: order schema, customer schema
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_bill_to_party_account_id` FOREIGN KEY (`bill_to_party_account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_sold_to_party_account_id` FOREIGN KEY (`sold_to_party_account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ADD CONSTRAINT `fk_order_quotation_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ADD CONSTRAINT `fk_order_quotation_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ADD CONSTRAINT `fk_order_status_event_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ADD CONSTRAINT `fk_order_customer_acceptance_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ADD CONSTRAINT `fk_order_credit_memo_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ADD CONSTRAINT `fk_order_customer_po_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`address`(`address_id`);

-- ========= order --> data (2 constraint(s)) =========
-- Requires: order schema, data schema
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ADD CONSTRAINT `fk_order_customer_acceptance_fair_assessment_id` FOREIGN KEY (`fair_assessment_id`) REFERENCES `genomics_biotech_ecm`.`data`.`fair_assessment`(`fair_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ADD CONSTRAINT `fk_order_trade_compliance_check_dpia_id` FOREIGN KEY (`dpia_id`) REFERENCES `genomics_biotech_ecm`.`data`.`dpia`(`dpia_id`);

-- ========= order --> finance (11 constraint(s)) =========
-- Requires: order schema, finance schema
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ADD CONSTRAINT `fk_order_quotation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ADD CONSTRAINT `fk_order_fulfillment_instruction_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ADD CONSTRAINT `fk_order_customer_acceptance_revenue_recognition_id` FOREIGN KEY (`revenue_recognition_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`revenue_recognition`(`revenue_recognition_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ADD CONSTRAINT `fk_order_credit_memo_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ADD CONSTRAINT `fk_order_trade_compliance_check_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ADD CONSTRAINT `fk_order_customer_po_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`finance_budget`(`finance_budget_id`);

-- ========= order --> instrument (6 constraint(s)) =========
-- Requires: order schema, instrument schema
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ADD CONSTRAINT `fk_order_quotation_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ADD CONSTRAINT `fk_order_quotation_line_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ADD CONSTRAINT `fk_order_fulfillment_instruction_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ADD CONSTRAINT `fk_order_customer_acceptance_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);

-- ========= order --> manufacturing (6 constraint(s)) =========
-- Requires: order schema, manufacturing schema
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_order`(`work_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ADD CONSTRAINT `fk_order_quotation_line_manufacturing_bom_id` FOREIGN KEY (`manufacturing_bom_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom`(`manufacturing_bom_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ADD CONSTRAINT `fk_order_delivery_line_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ADD CONSTRAINT `fk_order_customer_acceptance_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);

-- ========= order --> product (6 constraint(s)) =========
-- Requires: order schema, product schema
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ADD CONSTRAINT `fk_order_quotation_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ADD CONSTRAINT `fk_order_delivery_line_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ADD CONSTRAINT `fk_order_delivery_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);

-- ========= order --> quality (10 constraint(s)) =========
-- Requires: order schema, quality schema
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_complaint_id` FOREIGN KEY (`complaint_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`complaint`(`complaint_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_complaint_id` FOREIGN KEY (`complaint_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`complaint`(`complaint_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_complaint_id` FOREIGN KEY (`complaint_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`complaint`(`complaint_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ADD CONSTRAINT `fk_order_customer_acceptance_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ADD CONSTRAINT `fk_order_credit_memo_complaint_id` FOREIGN KEY (`complaint_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`complaint`(`complaint_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ADD CONSTRAINT `fk_order_trade_compliance_check_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);

-- ========= order --> reagent (7 constraint(s)) =========
-- Requires: order schema, reagent schema
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ADD CONSTRAINT `fk_order_quotation_line_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ADD CONSTRAINT `fk_order_delivery_line_coa_id` FOREIGN KEY (`coa_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`coa`(`coa_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ADD CONSTRAINT `fk_order_delivery_line_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);

-- ========= order --> reference (4 constraint(s)) =========
-- Requires: order schema, reference schema
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_genomic_region_id` FOREIGN KEY (`genomic_region_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genomic_region`(`genomic_region_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ADD CONSTRAINT `fk_order_quotation_line_genomic_region_id` FOREIGN KEY (`genomic_region_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genomic_region`(`genomic_region_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ADD CONSTRAINT `fk_order_customer_acceptance_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ADD CONSTRAINT `fk_order_customer_acceptance_variant_database_version_id` FOREIGN KEY (`variant_database_version_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database_version`(`variant_database_version_id`);

-- ========= order --> regulatory (5 constraint(s)) =========
-- Requires: order schema, regulatory schema
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ADD CONSTRAINT `fk_order_trade_compliance_check_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);

-- ========= order --> research (4 constraint(s)) =========
-- Requires: order schema, research schema
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ADD CONSTRAINT `fk_order_quotation_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ADD CONSTRAINT `fk_order_customer_acceptance_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);

-- ========= order --> sequencing (6 constraint(s)) =========
-- Requires: order schema, sequencing schema
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_library_id` FOREIGN KEY (`library_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`library`(`library_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_sequencing_protocol_id` FOREIGN KEY (`sequencing_protocol_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol`(`sequencing_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ADD CONSTRAINT `fk_order_quotation_line_sequencing_protocol_id` FOREIGN KEY (`sequencing_protocol_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol`(`sequencing_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ADD CONSTRAINT `fk_order_fulfillment_instruction_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_run`(`sequencing_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ADD CONSTRAINT `fk_order_customer_acceptance_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_run`(`sequencing_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_sequencing_protocol_id` FOREIGN KEY (`sequencing_protocol_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol`(`sequencing_protocol_id`);

-- ========= order --> supply (12 constraint(s)) =========
-- Requires: order schema, supply schema
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ADD CONSTRAINT `fk_order_quotation_line_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ADD CONSTRAINT `fk_order_delivery_line_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ADD CONSTRAINT `fk_order_delivery_line_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ADD CONSTRAINT `fk_order_status_event_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ADD CONSTRAINT `fk_order_fulfillment_instruction_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ADD CONSTRAINT `fk_order_customer_acceptance_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);

-- ========= order --> workforce (17 constraint(s)) =========
-- Requires: order schema, workforce schema
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ADD CONSTRAINT `fk_order_quotation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ADD CONSTRAINT `fk_order_quotation_quotation_employee_id` FOREIGN KEY (`quotation_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ADD CONSTRAINT `fk_order_quotation_quotation_prepared_by_user_employee_id` FOREIGN KEY (`quotation_prepared_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ADD CONSTRAINT `fk_order_status_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ADD CONSTRAINT `fk_order_fulfillment_instruction_assigned_team_org_unit_id` FOREIGN KEY (`assigned_team_org_unit_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ADD CONSTRAINT `fk_order_fulfillment_instruction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ADD CONSTRAINT `fk_order_fulfillment_instruction_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ADD CONSTRAINT `fk_order_customer_acceptance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ADD CONSTRAINT `fk_order_credit_memo_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ADD CONSTRAINT `fk_order_trade_compliance_check_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ADD CONSTRAINT `fk_order_customer_po_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ADD CONSTRAINT `fk_order_blanket_order_tertiary_blanket_contract_owner_employee_id` FOREIGN KEY (`tertiary_blanket_contract_owner_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= product --> commercial (2 constraint(s)) =========
-- Requires: product schema, commercial schema
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ADD CONSTRAINT `fk_product_launch_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`campaign`(`campaign_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ADD CONSTRAINT `fk_product_eol_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`campaign`(`campaign_id`);

-- ========= product --> data (1 constraint(s)) =========
-- Requires: product schema, data schema
ALTER TABLE `genomics_biotech_ecm`.`product`.`retention_assignment` ADD CONSTRAINT `fk_product_retention_assignment_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`retention_policy`(`retention_policy_id`);

-- ========= product --> finance (6 constraint(s)) =========
-- Requires: product schema, finance schema
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ADD CONSTRAINT `fk_product_catalog_item_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ADD CONSTRAINT `fk_product_launch_plan_capex_request_id` FOREIGN KEY (`capex_request_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`capex_request`(`capex_request_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ADD CONSTRAINT `fk_product_launch_plan_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ADD CONSTRAINT `fk_product_change_notice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ADD CONSTRAINT `fk_product_service_offering_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ADD CONSTRAINT `fk_product_eol_plan_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`finance_budget`(`finance_budget_id`);

-- ========= product --> instrument (3 constraint(s)) =========
-- Requires: product schema, instrument schema
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ADD CONSTRAINT `fk_product_software_release_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ADD CONSTRAINT `fk_product_license_entitlement_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ADD CONSTRAINT `fk_product_service_offering_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);

-- ========= product --> manufacturing (1 constraint(s)) =========
-- Requires: product schema, manufacturing schema
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku_work_center_qualification` ADD CONSTRAINT `fk_product_sku_work_center_qualification_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_center`(`work_center_id`);

-- ========= product --> quality (14 constraint(s)) =========
-- Requires: product schema, quality schema
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ADD CONSTRAINT `fk_product_specification_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ADD CONSTRAINT `fk_product_product_bom_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ADD CONSTRAINT `fk_product_launch_plan_stability_study_id` FOREIGN KEY (`stability_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`stability_study`(`stability_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ADD CONSTRAINT `fk_product_launch_plan_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ADD CONSTRAINT `fk_product_change_notice_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ADD CONSTRAINT `fk_product_change_notice_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ADD CONSTRAINT `fk_product_compatibility_matrix_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ADD CONSTRAINT `fk_product_software_release_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ADD CONSTRAINT `fk_product_software_release_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ADD CONSTRAINT `fk_product_service_offering_quality_training_curriculum_id` FOREIGN KEY (`quality_training_curriculum_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`quality_training_curriculum`(`quality_training_curriculum_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ADD CONSTRAINT `fk_product_service_offering_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ADD CONSTRAINT `fk_product_eol_plan_stability_study_id` FOREIGN KEY (`stability_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`stability_study`(`stability_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`validation` ADD CONSTRAINT `fk_product_validation_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);

-- ========= product --> reference (13 constraint(s)) =========
-- Requires: product schema, reference schema
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ADD CONSTRAINT `fk_product_catalog_item_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ADD CONSTRAINT `fk_product_catalog_item_variant_database_id` FOREIGN KEY (`variant_database_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database`(`variant_database_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ADD CONSTRAINT `fk_product_specification_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ADD CONSTRAINT `fk_product_specification_variant_database_id` FOREIGN KEY (`variant_database_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database`(`variant_database_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ADD CONSTRAINT `fk_product_regulatory_classification_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ADD CONSTRAINT `fk_product_launch_plan_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ADD CONSTRAINT `fk_product_compatibility_matrix_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ADD CONSTRAINT `fk_product_software_release_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ADD CONSTRAINT `fk_product_software_release_variant_database_id` FOREIGN KEY (`variant_database_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database`(`variant_database_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ADD CONSTRAINT `fk_product_license_entitlement_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ADD CONSTRAINT `fk_product_license_entitlement_variant_database_id` FOREIGN KEY (`variant_database_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database`(`variant_database_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ADD CONSTRAINT `fk_product_service_offering_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);

-- ========= product --> regulatory (9 constraint(s)) =========
-- Requires: product schema, regulatory schema
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ADD CONSTRAINT `fk_product_specification_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ADD CONSTRAINT `fk_product_regulatory_classification_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ADD CONSTRAINT `fk_product_launch_plan_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`change_notice` ADD CONSTRAINT `fk_product_change_notice_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ADD CONSTRAINT `fk_product_compatibility_matrix_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ADD CONSTRAINT `fk_product_software_release_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ADD CONSTRAINT `fk_product_license_entitlement_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ADD CONSTRAINT `fk_product_service_offering_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ADD CONSTRAINT `fk_product_eol_plan_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);

-- ========= product --> research (8 constraint(s)) =========
-- Requires: product schema, research schema
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ADD CONSTRAINT `fk_product_catalog_item_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ADD CONSTRAINT `fk_product_specification_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ADD CONSTRAINT `fk_product_launch_plan_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ADD CONSTRAINT `fk_product_compatibility_matrix_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ADD CONSTRAINT `fk_product_software_release_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ADD CONSTRAINT `fk_product_service_offering_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ADD CONSTRAINT `fk_product_eol_plan_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`citation` ADD CONSTRAINT `fk_product_citation_publication_id` FOREIGN KEY (`publication_id`) REFERENCES `genomics_biotech_ecm`.`research`.`publication`(`publication_id`);

-- ========= product --> supply (4 constraint(s)) =========
-- Requires: product schema, supply schema
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ADD CONSTRAINT `fk_product_service_offering_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ADD CONSTRAINT `fk_product_eol_plan_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`supply_agreement` ADD CONSTRAINT `fk_product_supply_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);

-- ========= product --> workforce (17 constraint(s)) =========
-- Requires: product schema, workforce schema
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ADD CONSTRAINT `fk_product_specification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ADD CONSTRAINT `fk_product_pricing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ADD CONSTRAINT `fk_product_regulatory_classification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ADD CONSTRAINT `fk_product_launch_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`launch_plan` ADD CONSTRAINT `fk_product_launch_plan_tertiary_launch_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_launch_last_modified_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ADD CONSTRAINT `fk_product_compatibility_matrix_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`compatibility_matrix` ADD CONSTRAINT `fk_product_compatibility_matrix_tertiary_compatibility_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_compatibility_last_modified_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ADD CONSTRAINT `fk_product_software_release_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ADD CONSTRAINT `fk_product_license_entitlement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ADD CONSTRAINT `fk_product_service_offering_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ADD CONSTRAINT `fk_product_eol_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ADD CONSTRAINT `fk_product_eol_plan_quaternary_eol_last_modified_by_user_employee_id` FOREIGN KEY (`quaternary_eol_last_modified_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`eol_plan` ADD CONSTRAINT `fk_product_eol_plan_tertiary_eol_created_by_user_employee_id` FOREIGN KEY (`tertiary_eol_created_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku_work_center_qualification` ADD CONSTRAINT `fk_product_sku_work_center_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`validation` ADD CONSTRAINT `fk_product_validation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`validation` ADD CONSTRAINT `fk_product_validation_last_modified_by_employee_id` FOREIGN KEY (`last_modified_by_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= quality --> commercial (8 constraint(s)) =========
-- Requires: quality schema, commercial schema
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_channel_partner_id` FOREIGN KEY (`channel_partner_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`channel_partner`(`channel_partner_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ADD CONSTRAINT `fk_quality_controlled_document_price_book_id` FOREIGN KEY (`price_book_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`price_book`(`price_book_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ADD CONSTRAINT `fk_quality_quality_training_curriculum_channel_partner_id` FOREIGN KEY (`channel_partner_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`channel_partner`(`channel_partner_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`campaign`(`campaign_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ADD CONSTRAINT `fk_quality_validation_study_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);

-- ========= quality --> customer (8 constraint(s)) =========
-- Requires: quality schema, customer schema
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ADD CONSTRAINT `fk_quality_deviation_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ADD CONSTRAINT `fk_quality_training_record_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_support_case_id` FOREIGN KEY (`support_case_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`support_case`(`support_case_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ADD CONSTRAINT `fk_quality_validation_study_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);

-- ========= quality --> data (8 constraint(s)) =========
-- Requires: quality schema, data schema
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_quality_issue_id` FOREIGN KEY (`quality_issue_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_issue`(`quality_issue_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ADD CONSTRAINT `fk_quality_deviation_quality_issue_id` FOREIGN KEY (`quality_issue_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_issue`(`quality_issue_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ADD CONSTRAINT `fk_quality_audit_finding_quality_issue_id` FOREIGN KEY (`quality_issue_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_issue`(`quality_issue_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ADD CONSTRAINT `fk_quality_controlled_document_metadata_schema_id` FOREIGN KEY (`metadata_schema_id`) REFERENCES `genomics_biotech_ecm`.`data`.`metadata_schema`(`metadata_schema_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ADD CONSTRAINT `fk_quality_training_record_metadata_schema_id` FOREIGN KEY (`metadata_schema_id`) REFERENCES `genomics_biotech_ecm`.`data`.`metadata_schema`(`metadata_schema_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_quality_issue_id` FOREIGN KEY (`quality_issue_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_issue`(`quality_issue_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_quality_assessment_id` FOREIGN KEY (`quality_assessment_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_assessment`(`quality_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_quality_issue_id` FOREIGN KEY (`quality_issue_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_issue`(`quality_issue_id`);

-- ========= quality --> finance (8 constraint(s)) =========
-- Requires: quality schema, finance schema
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ADD CONSTRAINT `fk_quality_deviation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ADD CONSTRAINT `fk_quality_training_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ADD CONSTRAINT `fk_quality_validation_study_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= quality --> instrument (5 constraint(s)) =========
-- Requires: quality schema, instrument schema
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ADD CONSTRAINT `fk_quality_deviation_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ADD CONSTRAINT `fk_quality_validation_study_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);

-- ========= quality --> product (2 constraint(s)) =========
-- Requires: quality schema, product schema
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ADD CONSTRAINT `fk_quality_controlled_document_family_id` FOREIGN KEY (`family_id`) REFERENCES `genomics_biotech_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);

-- ========= quality --> reagent (1 constraint(s)) =========
-- Requires: quality schema, reagent schema
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);

-- ========= quality --> reference (14 constraint(s)) =========
-- Requires: quality schema, reference schema
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ADD CONSTRAINT `fk_quality_controlled_document_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ADD CONSTRAINT `fk_quality_controlled_document_variant_database_version_id` FOREIGN KEY (`variant_database_version_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database_version`(`variant_database_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_gene_annotation_track_id` FOREIGN KEY (`gene_annotation_track_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_annotation_track`(`gene_annotation_track_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_variant_database_version_id` FOREIGN KEY (`variant_database_version_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database_version`(`variant_database_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_variant_database_version_id` FOREIGN KEY (`variant_database_version_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database_version`(`variant_database_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ADD CONSTRAINT `fk_quality_validation_study_gene_annotation_track_id` FOREIGN KEY (`gene_annotation_track_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_annotation_track`(`gene_annotation_track_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ADD CONSTRAINT `fk_quality_validation_study_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ADD CONSTRAINT `fk_quality_validation_study_variant_database_version_id` FOREIGN KEY (`variant_database_version_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database_version`(`variant_database_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_gene_annotation_track_id` FOREIGN KEY (`gene_annotation_track_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_annotation_track`(`gene_annotation_track_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_variant_database_version_id` FOREIGN KEY (`variant_database_version_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database_version`(`variant_database_version_id`);

-- ========= quality --> regulatory (14 constraint(s)) =========
-- Requires: quality schema, regulatory schema
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ADD CONSTRAINT `fk_quality_deviation_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_finding` ADD CONSTRAINT `fk_quality_audit_finding_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`inspection`(`inspection_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ADD CONSTRAINT `fk_quality_controlled_document_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ADD CONSTRAINT `fk_quality_controlled_document_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`quality_training_curriculum` ADD CONSTRAINT `fk_quality_quality_training_curriculum_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ADD CONSTRAINT `fk_quality_validation_study_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ADD CONSTRAINT `fk_quality_validation_study_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);

-- ========= quality --> sample (2 constraint(s)) =========
-- Requires: quality schema, sample schema
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);

-- ========= quality --> supply (12 constraint(s)) =========
-- Requires: quality schema, supply schema
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_inbound_delivery_id` FOREIGN KEY (`inbound_delivery_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`inbound_delivery`(`inbound_delivery_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ADD CONSTRAINT `fk_quality_validation_study_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);

-- ========= quality --> workforce (35 constraint(s)) =========
-- Requires: quality schema, workforce schema
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_capa_modified_by_user_employee_id` FOREIGN KEY (`capa_modified_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_capa_quality_approver_employee_id` FOREIGN KEY (`capa_quality_approver_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ADD CONSTRAINT `fk_quality_deviation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ADD CONSTRAINT `fk_quality_deviation_deviation_qa_reviewer_employee_id` FOREIGN KEY (`deviation_qa_reviewer_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ADD CONSTRAINT `fk_quality_deviation_deviation_reported_by_employee_id` FOREIGN KEY (`deviation_reported_by_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_primary_lead_auditor_employee_id` FOREIGN KEY (`primary_lead_auditor_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ADD CONSTRAINT `fk_quality_controlled_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ADD CONSTRAINT `fk_quality_controlled_document_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ADD CONSTRAINT `fk_quality_controlled_document_primary_controlled_employee_id` FOREIGN KEY (`primary_controlled_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ADD CONSTRAINT `fk_quality_training_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ADD CONSTRAINT `fk_quality_training_record_tertiary_training_assessor_employee_id` FOREIGN KEY (`tertiary_training_assessor_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ADD CONSTRAINT `fk_quality_training_record_workforce_assignment_id` FOREIGN KEY (`workforce_assignment_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`workforce_assignment`(`workforce_assignment_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_tertiary_oos_qa_reviewer_user_employee_id` FOREIGN KEY (`tertiary_oos_qa_reviewer_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_complaint_employee_id` FOREIGN KEY (`complaint_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_complaint_modified_by_user_employee_id` FOREIGN KEY (`complaint_modified_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ADD CONSTRAINT `fk_quality_validation_study_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ADD CONSTRAINT `fk_quality_validation_study_primary_validation_employee_id` FOREIGN KEY (`primary_validation_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ADD CONSTRAINT `fk_quality_validation_study_quaternary_validation_regulatory_approver_employee_id` FOREIGN KEY (`quaternary_validation_regulatory_approver_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ADD CONSTRAINT `fk_quality_validation_study_quinary_validation_created_by_user_employee_id` FOREIGN KEY (`quinary_validation_created_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ADD CONSTRAINT `fk_quality_validation_study_tertiary_validation_qa_reviewer_employee_id` FOREIGN KEY (`tertiary_validation_qa_reviewer_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_primary_change_employee_id` FOREIGN KEY (`primary_change_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_quaternary_change_initiator_employee_id` FOREIGN KEY (`quaternary_change_initiator_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_tertiary_change_regulatory_approver_employee_id` FOREIGN KEY (`tertiary_change_regulatory_approver_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`risk_assessment` ADD CONSTRAINT `fk_quality_risk_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`risk_assessment` ADD CONSTRAINT `fk_quality_risk_assessment_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_report` ADD CONSTRAINT `fk_quality_audit_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit_program` ADD CONSTRAINT `fk_quality_audit_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= reagent --> customer (7 constraint(s)) =========
-- Requires: reagent schema, customer schema
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ADD CONSTRAINT `fk_reagent_catalog_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ADD CONSTRAINT `fk_reagent_lot_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ADD CONSTRAINT `fk_reagent_coa_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ADD CONSTRAINT `fk_reagent_inventory_balance_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ADD CONSTRAINT `fk_reagent_dispensing_event_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ADD CONSTRAINT `fk_reagent_qc_specification_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ADD CONSTRAINT `fk_reagent_recall_event_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);

-- ========= reagent --> data (8 constraint(s)) =========
-- Requires: reagent schema, data schema
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ADD CONSTRAINT `fk_reagent_catalog_glossary_term_id` FOREIGN KEY (`glossary_term_id`) REFERENCES `genomics_biotech_ecm`.`data`.`glossary_term`(`glossary_term_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ADD CONSTRAINT `fk_reagent_catalog_metadata_schema_id` FOREIGN KEY (`metadata_schema_id`) REFERENCES `genomics_biotech_ecm`.`data`.`metadata_schema`(`metadata_schema_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ADD CONSTRAINT `fk_reagent_lot_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ADD CONSTRAINT `fk_reagent_coa_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ADD CONSTRAINT `fk_reagent_sds_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ADD CONSTRAINT `fk_reagent_dispensing_event_quality_issue_id` FOREIGN KEY (`quality_issue_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_issue`(`quality_issue_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ADD CONSTRAINT `fk_reagent_qc_specification_quality_rule_id` FOREIGN KEY (`quality_rule_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_rule`(`quality_rule_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`tag_assignment` ADD CONSTRAINT `fk_reagent_tag_assignment_catalog_tag_id` FOREIGN KEY (`catalog_tag_id`) REFERENCES `genomics_biotech_ecm`.`data`.`catalog_tag`(`catalog_tag_id`);

-- ========= reagent --> finance (8 constraint(s)) =========
-- Requires: reagent schema, finance schema
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ADD CONSTRAINT `fk_reagent_catalog_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ADD CONSTRAINT `fk_reagent_lot_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ADD CONSTRAINT `fk_reagent_inventory_balance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ADD CONSTRAINT `fk_reagent_dispensing_event_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ADD CONSTRAINT `fk_reagent_qc_specification_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ADD CONSTRAINT `fk_reagent_disposal_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ADD CONSTRAINT `fk_reagent_recall_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ADD CONSTRAINT `fk_reagent_inventory_transaction_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= reagent --> instrument (2 constraint(s)) =========
-- Requires: reagent schema, instrument schema
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ADD CONSTRAINT `fk_reagent_dispensing_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ADD CONSTRAINT `fk_reagent_inventory_transaction_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);

-- ========= reagent --> manufacturing (5 constraint(s)) =========
-- Requires: reagent schema, manufacturing schema
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ADD CONSTRAINT `fk_reagent_lot_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ADD CONSTRAINT `fk_reagent_lot_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_order`(`work_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ADD CONSTRAINT `fk_reagent_dispensing_event_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ADD CONSTRAINT `fk_reagent_qc_specification_process_validation_id` FOREIGN KEY (`process_validation_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`process_validation`(`process_validation_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ADD CONSTRAINT `fk_reagent_inventory_transaction_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);

-- ========= reagent --> product (10 constraint(s)) =========
-- Requires: reagent schema, product schema
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ADD CONSTRAINT `fk_reagent_catalog_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ADD CONSTRAINT `fk_reagent_lot_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ADD CONSTRAINT `fk_reagent_coa_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ADD CONSTRAINT `fk_reagent_inventory_balance_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ADD CONSTRAINT `fk_reagent_dispensing_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ADD CONSTRAINT `fk_reagent_qc_specification_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ADD CONSTRAINT `fk_reagent_kit_component_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ADD CONSTRAINT `fk_reagent_disposal_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ADD CONSTRAINT `fk_reagent_recall_event_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ADD CONSTRAINT `fk_reagent_inventory_transaction_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);

-- ========= reagent --> quality (10 constraint(s)) =========
-- Requires: reagent schema, quality schema
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ADD CONSTRAINT `fk_reagent_lot_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ADD CONSTRAINT `fk_reagent_lot_stability_study_id` FOREIGN KEY (`stability_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`stability_study`(`stability_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ADD CONSTRAINT `fk_reagent_coa_qc_result_id` FOREIGN KEY (`qc_result_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`qc_result`(`qc_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ADD CONSTRAINT `fk_reagent_sds_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ADD CONSTRAINT `fk_reagent_qc_specification_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ADD CONSTRAINT `fk_reagent_kit_component_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ADD CONSTRAINT `fk_reagent_disposal_record_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ADD CONSTRAINT `fk_reagent_disposal_record_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ADD CONSTRAINT `fk_reagent_recall_event_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ADD CONSTRAINT `fk_reagent_recall_event_internal_investigation_id` FOREIGN KEY (`internal_investigation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`internal_investigation`(`internal_investigation_id`);

-- ========= reagent --> reference (7 constraint(s)) =========
-- Requires: reagent schema, reference schema
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ADD CONSTRAINT `fk_reagent_catalog_gene_annotation_track_id` FOREIGN KEY (`gene_annotation_track_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_annotation_track`(`gene_annotation_track_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ADD CONSTRAINT `fk_reagent_catalog_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ADD CONSTRAINT `fk_reagent_catalog_variant_database_id` FOREIGN KEY (`variant_database_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database`(`variant_database_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ADD CONSTRAINT `fk_reagent_lot_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ADD CONSTRAINT `fk_reagent_qc_specification_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ADD CONSTRAINT `fk_reagent_qc_specification_variant_database_id` FOREIGN KEY (`variant_database_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database`(`variant_database_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ADD CONSTRAINT `fk_reagent_kit_component_gene_annotation_track_id` FOREIGN KEY (`gene_annotation_track_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_annotation_track`(`gene_annotation_track_id`);

-- ========= reagent --> regulatory (5 constraint(s)) =========
-- Requires: reagent schema, regulatory schema
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ADD CONSTRAINT `fk_reagent_catalog_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ADD CONSTRAINT `fk_reagent_sds_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ADD CONSTRAINT `fk_reagent_disposal_record_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ADD CONSTRAINT `fk_reagent_recall_event_field_safety_action_id` FOREIGN KEY (`field_safety_action_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`field_safety_action`(`field_safety_action_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ADD CONSTRAINT `fk_reagent_recall_event_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);

-- ========= reagent --> research (8 constraint(s)) =========
-- Requires: reagent schema, research schema
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ADD CONSTRAINT `fk_reagent_catalog_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ADD CONSTRAINT `fk_reagent_lot_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`sds` ADD CONSTRAINT `fk_reagent_sds_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ADD CONSTRAINT `fk_reagent_dispensing_event_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ADD CONSTRAINT `fk_reagent_qc_specification_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ADD CONSTRAINT `fk_reagent_disposal_record_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ADD CONSTRAINT `fk_reagent_recall_event_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ADD CONSTRAINT `fk_reagent_inventory_transaction_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);

-- ========= reagent --> supply (6 constraint(s)) =========
-- Requires: reagent schema, supply schema
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ADD CONSTRAINT `fk_reagent_catalog_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ADD CONSTRAINT `fk_reagent_lot_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ADD CONSTRAINT `fk_reagent_lot_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ADD CONSTRAINT `fk_reagent_inventory_balance_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ADD CONSTRAINT `fk_reagent_inventory_transaction_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_authorization` ADD CONSTRAINT `fk_reagent_disposal_authorization_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);

-- ========= reagent --> workforce (11 constraint(s)) =========
-- Requires: reagent schema, workforce schema
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ADD CONSTRAINT `fk_reagent_lot_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ADD CONSTRAINT `fk_reagent_coa_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ADD CONSTRAINT `fk_reagent_storage_location_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ADD CONSTRAINT `fk_reagent_inventory_balance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ADD CONSTRAINT `fk_reagent_dispensing_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ADD CONSTRAINT `fk_reagent_dispensing_event_tertiary_dispensing_modified_by_employee_id` FOREIGN KEY (`tertiary_dispensing_modified_by_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ADD CONSTRAINT `fk_reagent_qc_specification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_record` ADD CONSTRAINT `fk_reagent_disposal_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`recall_event` ADD CONSTRAINT `fk_reagent_recall_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ADD CONSTRAINT `fk_reagent_inventory_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`disposal_authorization` ADD CONSTRAINT `fk_reagent_disposal_authorization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= reference --> data (1 constraint(s)) =========
-- Requires: reference schema, data schema
ALTER TABLE `genomics_biotech_ecm`.`reference`.`gene_tag_assignment` ADD CONSTRAINT `fk_reference_gene_tag_assignment_catalog_tag_id` FOREIGN KEY (`catalog_tag_id`) REFERENCES `genomics_biotech_ecm`.`data`.`catalog_tag`(`catalog_tag_id`);

-- ========= reference --> quality (1 constraint(s)) =========
-- Requires: reference schema, quality schema
ALTER TABLE `genomics_biotech_ecm`.`reference`.`genome_assembly_version` ADD CONSTRAINT `fk_reference_genome_assembly_version_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);

-- ========= reference --> workforce (2 constraint(s)) =========
-- Requires: reference schema, workforce schema
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_qualification` ADD CONSTRAINT `fk_reference_variant_database_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`reference`.`variant_database_qualification` ADD CONSTRAINT `fk_reference_variant_database_qualification_qualified_by_employee_id` FOREIGN KEY (`qualified_by_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= regulatory --> commercial (5 constraint(s)) =========
-- Requires: regulatory schema, commercial schema
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_price_book_id` FOREIGN KEY (`price_book_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`price_book`(`price_book_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`intelligence` ADD CONSTRAINT `fk_regulatory_intelligence_market_segment_target_id` FOREIGN KEY (`market_segment_target_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`market_segment_target`(`market_segment_target_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`clinical_evidence` ADD CONSTRAINT `fk_regulatory_clinical_evidence_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`strategy` ADD CONSTRAINT `fk_regulatory_strategy_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);

-- ========= regulatory --> data (11 constraint(s)) =========
-- Requires: regulatory schema, data schema
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ADD CONSTRAINT `fk_regulatory_submission_event_quality_assessment_id` FOREIGN KEY (`quality_assessment_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_assessment`(`quality_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ADD CONSTRAINT `fk_regulatory_document_dpia_id` FOREIGN KEY (`dpia_id`) REFERENCES `genomics_biotech_ecm`.`data`.`dpia`(`dpia_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ADD CONSTRAINT `fk_regulatory_document_metadata_schema_id` FOREIGN KEY (`metadata_schema_id`) REFERENCES `genomics_biotech_ecm`.`data`.`metadata_schema`(`metadata_schema_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ADD CONSTRAINT `fk_regulatory_document_quality_rule_id` FOREIGN KEY (`quality_rule_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_rule`(`quality_rule_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ADD CONSTRAINT `fk_regulatory_adverse_event_report_quality_issue_id` FOREIGN KEY (`quality_issue_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_issue`(`quality_issue_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`intelligence` ADD CONSTRAINT `fk_regulatory_intelligence_glossary_term_id` FOREIGN KEY (`glossary_term_id`) REFERENCES `genomics_biotech_ecm`.`data`.`glossary_term`(`glossary_term_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`commitment` ADD CONSTRAINT `fk_regulatory_commitment_quality_issue_id` FOREIGN KEY (`quality_issue_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_issue`(`quality_issue_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`conformity_assessment` ADD CONSTRAINT `fk_regulatory_conformity_assessment_quality_assessment_id` FOREIGN KEY (`quality_assessment_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_assessment`(`quality_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`strategy` ADD CONSTRAINT `fk_regulatory_strategy_fair_assessment_id` FOREIGN KEY (`fair_assessment_id`) REFERENCES `genomics_biotech_ecm`.`data`.`fair_assessment`(`fair_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`eudamed_registration` ADD CONSTRAINT `fk_regulatory_eudamed_registration_metadata_schema_id` FOREIGN KEY (`metadata_schema_id`) REFERENCES `genomics_biotech_ecm`.`data`.`metadata_schema`(`metadata_schema_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ADD CONSTRAINT `fk_regulatory_device_identifier_metadata_schema_id` FOREIGN KEY (`metadata_schema_id`) REFERENCES `genomics_biotech_ecm`.`data`.`metadata_schema`(`metadata_schema_id`);

-- ========= regulatory --> finance (10 constraint(s)) =========
-- Requires: regulatory schema, finance schema
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ADD CONSTRAINT `fk_regulatory_document_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ADD CONSTRAINT `fk_regulatory_adverse_event_report_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ADD CONSTRAINT `fk_regulatory_post_market_surveillance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ADD CONSTRAINT `fk_regulatory_field_safety_action_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`clinical_evidence` ADD CONSTRAINT `fk_regulatory_clinical_evidence_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`commitment` ADD CONSTRAINT `fk_regulatory_commitment_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`conformity_assessment` ADD CONSTRAINT `fk_regulatory_conformity_assessment_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`strategy` ADD CONSTRAINT `fk_regulatory_strategy_capex_request_id` FOREIGN KEY (`capex_request_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`capex_request`(`capex_request_id`);

-- ========= regulatory --> manufacturing (2 constraint(s)) =========
-- Requires: regulatory schema, manufacturing schema
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ADD CONSTRAINT `fk_regulatory_labeling_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`inspection` ADD CONSTRAINT `fk_regulatory_inspection_manufacturing_site_id` FOREIGN KEY (`manufacturing_site_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`manufacturing_site`(`manufacturing_site_id`);

-- ========= regulatory --> product (6 constraint(s)) =========
-- Requires: regulatory schema, product schema
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ADD CONSTRAINT `fk_regulatory_document_family_id` FOREIGN KEY (`family_id`) REFERENCES `genomics_biotech_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ADD CONSTRAINT `fk_regulatory_labeling_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ADD CONSTRAINT `fk_regulatory_field_safety_action_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`clinical_evidence` ADD CONSTRAINT `fk_regulatory_clinical_evidence_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`strategy` ADD CONSTRAINT `fk_regulatory_strategy_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ADD CONSTRAINT `fk_regulatory_device_identifier_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);

-- ========= regulatory --> quality (6 constraint(s)) =========
-- Requires: regulatory schema, quality schema
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ADD CONSTRAINT `fk_regulatory_document_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ADD CONSTRAINT `fk_regulatory_labeling_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ADD CONSTRAINT `fk_regulatory_adverse_event_report_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ADD CONSTRAINT `fk_regulatory_field_safety_action_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`commitment` ADD CONSTRAINT `fk_regulatory_commitment_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`commitment` ADD CONSTRAINT `fk_regulatory_commitment_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);

-- ========= regulatory --> reference (24 constraint(s)) =========
-- Requires: regulatory schema, reference schema
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_acmg_classification_rule_id` FOREIGN KEY (`acmg_classification_rule_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`acmg_classification_rule`(`acmg_classification_rule_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_pharmacogenomics_marker_id` FOREIGN KEY (`pharmacogenomics_marker_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker`(`pharmacogenomics_marker_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_variant_database_id` FOREIGN KEY (`variant_database_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database`(`variant_database_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ADD CONSTRAINT `fk_regulatory_labeling_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ADD CONSTRAINT `fk_regulatory_labeling_pharmacogenomics_marker_id` FOREIGN KEY (`pharmacogenomics_marker_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker`(`pharmacogenomics_marker_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`clinical_evidence` ADD CONSTRAINT `fk_regulatory_clinical_evidence_acmg_classification_rule_id` FOREIGN KEY (`acmg_classification_rule_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`acmg_classification_rule`(`acmg_classification_rule_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`clinical_evidence` ADD CONSTRAINT `fk_regulatory_clinical_evidence_gene_annotation_track_id` FOREIGN KEY (`gene_annotation_track_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_annotation_track`(`gene_annotation_track_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`clinical_evidence` ADD CONSTRAINT `fk_regulatory_clinical_evidence_gene_model_id` FOREIGN KEY (`gene_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_model`(`gene_model_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`clinical_evidence` ADD CONSTRAINT `fk_regulatory_clinical_evidence_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`clinical_evidence` ADD CONSTRAINT `fk_regulatory_clinical_evidence_ontology_term_id` FOREIGN KEY (`ontology_term_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`ontology_term`(`ontology_term_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`clinical_evidence` ADD CONSTRAINT `fk_regulatory_clinical_evidence_pharmacogenomics_marker_id` FOREIGN KEY (`pharmacogenomics_marker_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker`(`pharmacogenomics_marker_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`clinical_evidence` ADD CONSTRAINT `fk_regulatory_clinical_evidence_transcript_model_id` FOREIGN KEY (`transcript_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`transcript_model`(`transcript_model_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`clinical_evidence` ADD CONSTRAINT `fk_regulatory_clinical_evidence_variant_database_id` FOREIGN KEY (`variant_database_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database`(`variant_database_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`strategy` ADD CONSTRAINT `fk_regulatory_strategy_acmg_classification_rule_id` FOREIGN KEY (`acmg_classification_rule_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`acmg_classification_rule`(`acmg_classification_rule_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`strategy` ADD CONSTRAINT `fk_regulatory_strategy_gene_annotation_track_id` FOREIGN KEY (`gene_annotation_track_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_annotation_track`(`gene_annotation_track_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`strategy` ADD CONSTRAINT `fk_regulatory_strategy_gene_model_id` FOREIGN KEY (`gene_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_model`(`gene_model_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`strategy` ADD CONSTRAINT `fk_regulatory_strategy_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`strategy` ADD CONSTRAINT `fk_regulatory_strategy_ontology_term_id` FOREIGN KEY (`ontology_term_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`ontology_term`(`ontology_term_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`strategy` ADD CONSTRAINT `fk_regulatory_strategy_pharmacogenomics_marker_id` FOREIGN KEY (`pharmacogenomics_marker_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker`(`pharmacogenomics_marker_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`strategy` ADD CONSTRAINT `fk_regulatory_strategy_variant_database_id` FOREIGN KEY (`variant_database_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database`(`variant_database_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ADD CONSTRAINT `fk_regulatory_device_identifier_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ADD CONSTRAINT `fk_regulatory_device_identifier_pharmacogenomics_marker_id` FOREIGN KEY (`pharmacogenomics_marker_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker`(`pharmacogenomics_marker_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ADD CONSTRAINT `fk_regulatory_device_identifier_variant_database_id` FOREIGN KEY (`variant_database_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database`(`variant_database_id`);

-- ========= regulatory --> research (1 constraint(s)) =========
-- Requires: regulatory schema, research schema
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`clinical_evidence` ADD CONSTRAINT `fk_regulatory_clinical_evidence_sample_request_id` FOREIGN KEY (`sample_request_id`) REFERENCES `genomics_biotech_ecm`.`research`.`sample_request`(`sample_request_id`);

-- ========= regulatory --> workforce (13 constraint(s)) =========
-- Requires: regulatory schema, workforce schema
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ADD CONSTRAINT `fk_regulatory_submission_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ADD CONSTRAINT `fk_regulatory_agency_correspondence_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ADD CONSTRAINT `fk_regulatory_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ADD CONSTRAINT `fk_regulatory_adverse_event_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ADD CONSTRAINT `fk_regulatory_post_market_surveillance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ADD CONSTRAINT `fk_regulatory_field_safety_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`intelligence` ADD CONSTRAINT `fk_regulatory_intelligence_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`commitment` ADD CONSTRAINT `fk_regulatory_commitment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`conformity_assessment` ADD CONSTRAINT `fk_regulatory_conformity_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`strategy` ADD CONSTRAINT `fk_regulatory_strategy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ADD CONSTRAINT `fk_regulatory_establishment_registration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`inspection` ADD CONSTRAINT `fk_regulatory_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= research --> bioinformatics (5 constraint(s)) =========
-- Requires: research schema, bioinformatics schema
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ADD CONSTRAINT `fk_research_assay_development_pipeline_id` FOREIGN KEY (`pipeline_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`pipeline`(`pipeline_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ADD CONSTRAINT `fk_research_spend_compute_job_id` FOREIGN KEY (`compute_job_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`compute_job`(`compute_job_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ADD CONSTRAINT `fk_research_notebook_entry_bioinformatics_pipeline_run_id` FOREIGN KEY (`bioinformatics_pipeline_run_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`bioinformatics_pipeline_run`(`bioinformatics_pipeline_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment_analysis` ADD CONSTRAINT `fk_research_experiment_analysis_bioinformatics_pipeline_run_id` FOREIGN KEY (`bioinformatics_pipeline_run_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`bioinformatics_pipeline_run`(`bioinformatics_pipeline_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment_analysis` ADD CONSTRAINT `fk_research_experiment_analysis_pipeline_version_id` FOREIGN KEY (`pipeline_version_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version`(`pipeline_version_id`);

-- ========= research --> clinical (1 constraint(s)) =========
-- Requires: research schema, clinical schema
ALTER TABLE `genomics_biotech_ecm`.`research`.`project_investigator` ADD CONSTRAINT `fk_research_project_investigator_authorized_orderer_id` FOREIGN KEY (`authorized_orderer_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`authorized_orderer`(`authorized_orderer_id`);

-- ========= research --> commercial (5 constraint(s)) =========
-- Requires: research schema, commercial schema
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ADD CONSTRAINT `fk_research_assay_development_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ADD CONSTRAINT `fk_research_collaboration_agreement_channel_partner_id` FOREIGN KEY (`channel_partner_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`channel_partner`(`channel_partner_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ADD CONSTRAINT `fk_research_ip_disclosure_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ADD CONSTRAINT `fk_research_publication_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ADD CONSTRAINT `fk_research_grant_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);

-- ========= research --> customer (9 constraint(s)) =========
-- Requires: research schema, customer schema
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ADD CONSTRAINT `fk_research_project_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ADD CONSTRAINT `fk_research_experiment_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ADD CONSTRAINT `fk_research_research_protocol_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ADD CONSTRAINT `fk_research_assay_development_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ADD CONSTRAINT `fk_research_collaboration_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ADD CONSTRAINT `fk_research_irb_submission_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ADD CONSTRAINT `fk_research_publication_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ADD CONSTRAINT `fk_research_technology_transfer_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ADD CONSTRAINT `fk_research_sample_request_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);

-- ========= research --> data (7 constraint(s)) =========
-- Requires: research schema, data schema
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ADD CONSTRAINT `fk_research_project_metadata_schema_id` FOREIGN KEY (`metadata_schema_id`) REFERENCES `genomics_biotech_ecm`.`data`.`metadata_schema`(`metadata_schema_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ADD CONSTRAINT `fk_research_research_protocol_metadata_schema_id` FOREIGN KEY (`metadata_schema_id`) REFERENCES `genomics_biotech_ecm`.`data`.`metadata_schema`(`metadata_schema_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ADD CONSTRAINT `fk_research_assay_development_metadata_schema_id` FOREIGN KEY (`metadata_schema_id`) REFERENCES `genomics_biotech_ecm`.`data`.`metadata_schema`(`metadata_schema_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ADD CONSTRAINT `fk_research_collaboration_agreement_genomic_access_control_id` FOREIGN KEY (`genomic_access_control_id`) REFERENCES `genomics_biotech_ecm`.`data`.`genomic_access_control`(`genomic_access_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ADD CONSTRAINT `fk_research_irb_submission_genomic_access_control_id` FOREIGN KEY (`genomic_access_control_id`) REFERENCES `genomics_biotech_ecm`.`data`.`genomic_access_control`(`genomic_access_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ADD CONSTRAINT `fk_research_publication_fair_assessment_id` FOREIGN KEY (`fair_assessment_id`) REFERENCES `genomics_biotech_ecm`.`data`.`fair_assessment`(`fair_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ADD CONSTRAINT `fk_research_sample_request_genomic_access_control_id` FOREIGN KEY (`genomic_access_control_id`) REFERENCES `genomics_biotech_ecm`.`data`.`genomic_access_control`(`genomic_access_control_id`);

-- ========= research --> finance (15 constraint(s)) =========
-- Requires: research schema, finance schema
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ADD CONSTRAINT `fk_research_project_capex_request_id` FOREIGN KEY (`capex_request_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`capex_request`(`capex_request_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ADD CONSTRAINT `fk_research_milestone_rd_capitalization_id` FOREIGN KEY (`rd_capitalization_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`rd_capitalization`(`rd_capitalization_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ADD CONSTRAINT `fk_research_assay_development_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ADD CONSTRAINT `fk_research_assay_development_rd_capitalization_id` FOREIGN KEY (`rd_capitalization_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`rd_capitalization`(`rd_capitalization_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ADD CONSTRAINT `fk_research_spend_capex_request_id` FOREIGN KEY (`capex_request_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`capex_request`(`capex_request_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ADD CONSTRAINT `fk_research_spend_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ADD CONSTRAINT `fk_research_spend_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ADD CONSTRAINT `fk_research_spend_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ADD CONSTRAINT `fk_research_collaboration_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ADD CONSTRAINT `fk_research_collaboration_agreement_intercompany_transaction_id` FOREIGN KEY (`intercompany_transaction_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`intercompany_transaction`(`intercompany_transaction_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ADD CONSTRAINT `fk_research_irb_submission_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ADD CONSTRAINT `fk_research_grant_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ADD CONSTRAINT `fk_research_grant_report_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ADD CONSTRAINT `fk_research_research_budget_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ADD CONSTRAINT `fk_research_technology_transfer_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= research --> instrument (3 constraint(s)) =========
-- Requires: research schema, instrument schema
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ADD CONSTRAINT `fk_research_experiment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ADD CONSTRAINT `fk_research_spend_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ADD CONSTRAINT `fk_research_notebook_entry_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);

-- ========= research --> order (3 constraint(s)) =========
-- Requires: research schema, order schema
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ADD CONSTRAINT `fk_research_spend_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ADD CONSTRAINT `fk_research_material_request_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ADD CONSTRAINT `fk_research_sample_request_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);

-- ========= research --> product (5 constraint(s)) =========
-- Requires: research schema, product schema
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ADD CONSTRAINT `fk_research_experiment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ADD CONSTRAINT `fk_research_assay_development_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ADD CONSTRAINT `fk_research_spend_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ADD CONSTRAINT `fk_research_material_request_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ADD CONSTRAINT `fk_research_sample_request_service_offering_id` FOREIGN KEY (`service_offering_id`) REFERENCES `genomics_biotech_ecm`.`product`.`service_offering`(`service_offering_id`);

-- ========= research --> quality (12 constraint(s)) =========
-- Requires: research schema, quality schema
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ADD CONSTRAINT `fk_research_milestone_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ADD CONSTRAINT `fk_research_experiment_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ADD CONSTRAINT `fk_research_research_protocol_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ADD CONSTRAINT `fk_research_research_protocol_quality_training_curriculum_id` FOREIGN KEY (`quality_training_curriculum_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`quality_training_curriculum`(`quality_training_curriculum_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ADD CONSTRAINT `fk_research_assay_development_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ADD CONSTRAINT `fk_research_assay_development_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ADD CONSTRAINT `fk_research_irb_submission_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`audit`(`audit_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ADD CONSTRAINT `fk_research_notebook_entry_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ADD CONSTRAINT `fk_research_material_request_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ADD CONSTRAINT `fk_research_technology_transfer_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ADD CONSTRAINT `fk_research_technology_transfer_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ADD CONSTRAINT `fk_research_sample_request_complaint_id` FOREIGN KEY (`complaint_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`complaint`(`complaint_id`);

-- ========= research --> reference (8 constraint(s)) =========
-- Requires: research schema, reference schema
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ADD CONSTRAINT `fk_research_project_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ADD CONSTRAINT `fk_research_experiment_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ADD CONSTRAINT `fk_research_crispr_construct_gene_model_id` FOREIGN KEY (`gene_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_model`(`gene_model_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ADD CONSTRAINT `fk_research_crispr_construct_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ADD CONSTRAINT `fk_research_assay_development_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ADD CONSTRAINT `fk_research_assay_development_variant_database_id` FOREIGN KEY (`variant_database_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database`(`variant_database_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ADD CONSTRAINT `fk_research_molecular_design_gene_model_id` FOREIGN KEY (`gene_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_model`(`gene_model_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ADD CONSTRAINT `fk_research_molecular_design_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);

-- ========= research --> regulatory (16 constraint(s)) =========
-- Requires: research schema, regulatory schema
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ADD CONSTRAINT `fk_research_project_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ADD CONSTRAINT `fk_research_project_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ADD CONSTRAINT `fk_research_milestone_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ADD CONSTRAINT `fk_research_milestone_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ADD CONSTRAINT `fk_research_experiment_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ADD CONSTRAINT `fk_research_experiment_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ADD CONSTRAINT `fk_research_research_protocol_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ADD CONSTRAINT `fk_research_assay_development_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ADD CONSTRAINT `fk_research_assay_development_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ADD CONSTRAINT `fk_research_collaboration_agreement_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ADD CONSTRAINT `fk_research_ip_disclosure_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ADD CONSTRAINT `fk_research_publication_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ADD CONSTRAINT `fk_research_publication_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ADD CONSTRAINT `fk_research_trl_assessment_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant_report` ADD CONSTRAINT `fk_research_grant_report_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ADD CONSTRAINT `fk_research_notebook_entry_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);

-- ========= research --> sample (4 constraint(s)) =========
-- Requires: research schema, sample schema
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ADD CONSTRAINT `fk_research_experiment_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ADD CONSTRAINT `fk_research_notebook_entry_extraction_id` FOREIGN KEY (`extraction_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`extraction`(`extraction_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ADD CONSTRAINT `fk_research_material_request_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ADD CONSTRAINT `fk_research_sample_request_biobank_location_id` FOREIGN KEY (`biobank_location_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`biobank_location`(`biobank_location_id`);

-- ========= research --> supply (13 constraint(s)) =========
-- Requires: research schema, supply schema
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ADD CONSTRAINT `fk_research_project_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ADD CONSTRAINT `fk_research_experiment_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ADD CONSTRAINT `fk_research_experiment_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ADD CONSTRAINT `fk_research_research_protocol_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ADD CONSTRAINT `fk_research_crispr_construct_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ADD CONSTRAINT `fk_research_assay_development_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ADD CONSTRAINT `fk_research_spend_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ADD CONSTRAINT `fk_research_notebook_entry_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ADD CONSTRAINT `fk_research_material_request_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ADD CONSTRAINT `fk_research_material_request_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ADD CONSTRAINT `fk_research_material_request_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ADD CONSTRAINT `fk_research_technology_transfer_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ADD CONSTRAINT `fk_research_sample_request_inbound_delivery_id` FOREIGN KEY (`inbound_delivery_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`inbound_delivery`(`inbound_delivery_id`);

-- ========= research --> workforce (24 constraint(s)) =========
-- Requires: research schema, workforce schema
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ADD CONSTRAINT `fk_research_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ADD CONSTRAINT `fk_research_project_project_principal_investigator_employee_id` FOREIGN KEY (`project_principal_investigator_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ADD CONSTRAINT `fk_research_milestone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ADD CONSTRAINT `fk_research_experiment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ADD CONSTRAINT `fk_research_spend_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ADD CONSTRAINT `fk_research_collaboration_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ADD CONSTRAINT `fk_research_irb_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ADD CONSTRAINT `fk_research_ip_disclosure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`trl_assessment` ADD CONSTRAINT `fk_research_trl_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ADD CONSTRAINT `fk_research_grant_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ADD CONSTRAINT `fk_research_grant_grant_principal_investigator_employee_id` FOREIGN KEY (`grant_principal_investigator_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ADD CONSTRAINT `fk_research_research_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_budget` ADD CONSTRAINT `fk_research_research_budget_primary_research_employee_id` FOREIGN KEY (`primary_research_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ADD CONSTRAINT `fk_research_molecular_design_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ADD CONSTRAINT `fk_research_notebook_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`notebook_entry` ADD CONSTRAINT `fk_research_notebook_entry_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`material_request` ADD CONSTRAINT `fk_research_material_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`technology_transfer` ADD CONSTRAINT `fk_research_technology_transfer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ADD CONSTRAINT `fk_research_sample_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`sample_request` ADD CONSTRAINT `fk_research_sample_request_tertiary_sample_handoff_recipient_employee_id` FOREIGN KEY (`tertiary_sample_handoff_recipient_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_assignment` ADD CONSTRAINT `fk_research_research_assignment_workforce_assignment_id` FOREIGN KEY (`workforce_assignment_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`workforce_assignment`(`workforce_assignment_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_assignment` ADD CONSTRAINT `fk_research_research_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment_analysis` ADD CONSTRAINT `fk_research_experiment_analysis_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`program` ADD CONSTRAINT `fk_research_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= sample --> clinical (5 constraint(s)) =========
-- Requires: sample schema, clinical schema
ALTER TABLE `genomics_biotech_ecm`.`sample`.`accession` ADD CONSTRAINT `fk_sample_accession_authorized_orderer_id` FOREIGN KEY (`authorized_orderer_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`authorized_orderer`(`authorized_orderer_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`accession` ADD CONSTRAINT `fk_sample_accession_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`patient`(`patient_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`collection_event` ADD CONSTRAINT `fk_sample_collection_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`visit`(`visit_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_enrollment` ADD CONSTRAINT `fk_sample_sample_enrollment_clinical_enrollment_id` FOREIGN KEY (`clinical_enrollment_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`clinical_enrollment`(`clinical_enrollment_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_enrollment` ADD CONSTRAINT `fk_sample_sample_enrollment_study_enrollment_id` FOREIGN KEY (`study_enrollment_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`clinical_enrollment`(`clinical_enrollment_id`);

-- ========= sample --> commercial (5 constraint(s)) =========
-- Requires: sample schema, commercial schema
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`accession` ADD CONSTRAINT `fk_sample_accession_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`collection_event` ADD CONSTRAINT `fk_sample_collection_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`campaign`(`campaign_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`lims_workflow_assignment` ADD CONSTRAINT `fk_sample_lims_workflow_assignment_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`shipment_manifest` ADD CONSTRAINT `fk_sample_shipment_manifest_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);

-- ========= sample --> customer (7 constraint(s)) =========
-- Requires: sample schema, customer schema
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`accession` ADD CONSTRAINT `fk_sample_accession_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_consent_record` ADD CONSTRAINT `fk_sample_sample_consent_record_nda_record_id` FOREIGN KEY (`nda_record_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`nda_record`(`nda_record_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`subject` ADD CONSTRAINT `fk_sample_subject_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`collection_event` ADD CONSTRAINT `fk_sample_collection_event_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`shipment_manifest` ADD CONSTRAINT `fk_sample_shipment_manifest_nda_record_id` FOREIGN KEY (`nda_record_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`nda_record`(`nda_record_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`shipment_manifest` ADD CONSTRAINT `fk_sample_shipment_manifest_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);

-- ========= sample --> data (1 constraint(s)) =========
-- Requires: sample schema, data schema
ALTER TABLE `genomics_biotech_ecm`.`sample`.`disposal_event` ADD CONSTRAINT `fk_sample_disposal_event_access_request_id` FOREIGN KEY (`access_request_id`) REFERENCES `genomics_biotech_ecm`.`data`.`access_request`(`access_request_id`);

-- ========= sample --> finance (7 constraint(s)) =========
-- Requires: sample schema, finance schema
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`accession` ADD CONSTRAINT `fk_sample_accession_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`biobank_location` ADD CONSTRAINT `fk_sample_biobank_location_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`collection_event` ADD CONSTRAINT `fk_sample_collection_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`lims_workflow_assignment` ADD CONSTRAINT `fk_sample_lims_workflow_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`disposal_event` ADD CONSTRAINT `fk_sample_disposal_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= sample --> instrument (7 constraint(s)) =========
-- Requires: sample schema, instrument schema
ALTER TABLE `genomics_biotech_ecm`.`sample`.`aliquot` ADD CONSTRAINT `fk_sample_aliquot_instrument_run_id` FOREIGN KEY (`instrument_run_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`instrument_run`(`instrument_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`lims_workflow_assignment` ADD CONSTRAINT `fk_sample_lims_workflow_assignment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`lims_workflow_assignment` ADD CONSTRAINT `fk_sample_lims_workflow_assignment_instrument_run_id` FOREIGN KEY (`instrument_run_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`instrument_run`(`instrument_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`qc_measurement` ADD CONSTRAINT `fk_sample_qc_measurement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`qc_measurement` ADD CONSTRAINT `fk_sample_qc_measurement_instrument_run_id` FOREIGN KEY (`instrument_run_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`instrument_run`(`instrument_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`run_sample` ADD CONSTRAINT `fk_sample_run_sample_instrument_run_id` FOREIGN KEY (`instrument_run_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`instrument_run`(`instrument_run_id`);

-- ========= sample --> manufacturing (4 constraint(s)) =========
-- Requires: sample schema, manufacturing schema
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_order`(`work_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`aliquot` ADD CONSTRAINT `fk_sample_aliquot_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_order`(`work_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`lims_workflow_assignment` ADD CONSTRAINT `fk_sample_lims_workflow_assignment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_order`(`work_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_order`(`work_order_id`);

-- ========= sample --> order (8 constraint(s)) =========
-- Requires: sample schema, order schema
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`aliquot` ADD CONSTRAINT `fk_sample_aliquot_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`accession` ADD CONSTRAINT `fk_sample_accession_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`lims_workflow_assignment` ADD CONSTRAINT `fk_sample_lims_workflow_assignment_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`qc_measurement` ADD CONSTRAINT `fk_sample_qc_measurement_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`shipment_manifest` ADD CONSTRAINT `fk_sample_shipment_manifest_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `genomics_biotech_ecm`.`order`.`shipment`(`shipment_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`temperature_excursion` ADD CONSTRAINT `fk_sample_temperature_excursion_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `genomics_biotech_ecm`.`order`.`shipment`(`shipment_id`);

-- ========= sample --> product (8 constraint(s)) =========
-- Requires: sample schema, product schema
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`aliquot` ADD CONSTRAINT `fk_sample_aliquot_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`subject` ADD CONSTRAINT `fk_sample_subject_family_id` FOREIGN KEY (`family_id`) REFERENCES `genomics_biotech_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`collection_event` ADD CONSTRAINT `fk_sample_collection_event_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`lims_workflow_assignment` ADD CONSTRAINT `fk_sample_lims_workflow_assignment_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`qc_measurement` ADD CONSTRAINT `fk_sample_qc_measurement_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`container` ADD CONSTRAINT `fk_sample_container_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);

-- ========= sample --> quality (26 constraint(s)) =========
-- Requires: sample schema, quality schema
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_stability_study_id` FOREIGN KEY (`stability_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`stability_study`(`stability_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`aliquot` ADD CONSTRAINT `fk_sample_aliquot_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`aliquot` ADD CONSTRAINT `fk_sample_aliquot_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`aliquot` ADD CONSTRAINT `fk_sample_aliquot_complaint_id` FOREIGN KEY (`complaint_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`complaint`(`complaint_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`aliquot` ADD CONSTRAINT `fk_sample_aliquot_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`aliquot` ADD CONSTRAINT `fk_sample_aliquot_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`aliquot` ADD CONSTRAINT `fk_sample_aliquot_stability_study_id` FOREIGN KEY (`stability_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`stability_study`(`stability_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`aliquot` ADD CONSTRAINT `fk_sample_aliquot_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`biobank_location` ADD CONSTRAINT `fk_sample_biobank_location_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`storage_event` ADD CONSTRAINT `fk_sample_storage_event_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_consent_record` ADD CONSTRAINT `fk_sample_sample_consent_record_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`collection_event` ADD CONSTRAINT `fk_sample_collection_event_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`collection_event` ADD CONSTRAINT `fk_sample_collection_event_training_record_id` FOREIGN KEY (`training_record_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`training_record`(`training_record_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`lims_workflow_assignment` ADD CONSTRAINT `fk_sample_lims_workflow_assignment_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`lims_workflow_assignment` ADD CONSTRAINT `fk_sample_lims_workflow_assignment_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`lims_workflow_assignment` ADD CONSTRAINT `fk_sample_lims_workflow_assignment_training_record_id` FOREIGN KEY (`training_record_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`training_record`(`training_record_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_training_record_id` FOREIGN KEY (`training_record_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`training_record`(`training_record_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`disposal_event` ADD CONSTRAINT `fk_sample_disposal_event_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`shipment_manifest` ADD CONSTRAINT `fk_sample_shipment_manifest_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`temperature_excursion` ADD CONSTRAINT `fk_sample_temperature_excursion_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);

-- ========= sample --> reagent (10 constraint(s)) =========
-- Requires: sample schema, reagent schema
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`aliquot` ADD CONSTRAINT `fk_sample_aliquot_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`aliquot` ADD CONSTRAINT `fk_sample_aliquot_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`storage_location`(`storage_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`collection_event` ADD CONSTRAINT `fk_sample_collection_event_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`lims_workflow_assignment` ADD CONSTRAINT `fk_sample_lims_workflow_assignment_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`qc_measurement` ADD CONSTRAINT `fk_sample_qc_measurement_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`disposal_event` ADD CONSTRAINT `fk_sample_disposal_event_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`storage_location`(`storage_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`container` ADD CONSTRAINT `fk_sample_container_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`storage_location`(`storage_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`temperature_excursion` ADD CONSTRAINT `fk_sample_temperature_excursion_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`storage_location`(`storage_location_id`);

-- ========= sample --> reference (18 constraint(s)) =========
-- Requires: sample schema, reference schema
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_gene_annotation_track_id` FOREIGN KEY (`gene_annotation_track_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_annotation_track`(`gene_annotation_track_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_genomic_region_id` FOREIGN KEY (`genomic_region_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genomic_region`(`genomic_region_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_pathway_id` FOREIGN KEY (`pathway_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`pathway`(`pathway_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_variant_database_id` FOREIGN KEY (`variant_database_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database`(`variant_database_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`accession` ADD CONSTRAINT `fk_sample_accession_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`subject` ADD CONSTRAINT `fk_sample_subject_gene_annotation_track_id` FOREIGN KEY (`gene_annotation_track_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_annotation_track`(`gene_annotation_track_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`subject` ADD CONSTRAINT `fk_sample_subject_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`subject` ADD CONSTRAINT `fk_sample_subject_pharmacogenomics_marker_id` FOREIGN KEY (`pharmacogenomics_marker_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker`(`pharmacogenomics_marker_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`lims_workflow_assignment` ADD CONSTRAINT `fk_sample_lims_workflow_assignment_gene_annotation_track_id` FOREIGN KEY (`gene_annotation_track_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_annotation_track`(`gene_annotation_track_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`lims_workflow_assignment` ADD CONSTRAINT `fk_sample_lims_workflow_assignment_gene_model_id` FOREIGN KEY (`gene_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_model`(`gene_model_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`lims_workflow_assignment` ADD CONSTRAINT `fk_sample_lims_workflow_assignment_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`lims_workflow_assignment` ADD CONSTRAINT `fk_sample_lims_workflow_assignment_genomic_region_id` FOREIGN KEY (`genomic_region_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genomic_region`(`genomic_region_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`lims_workflow_assignment` ADD CONSTRAINT `fk_sample_lims_workflow_assignment_pathway_id` FOREIGN KEY (`pathway_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`pathway`(`pathway_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`lims_workflow_assignment` ADD CONSTRAINT `fk_sample_lims_workflow_assignment_pharmacogenomics_marker_id` FOREIGN KEY (`pharmacogenomics_marker_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker`(`pharmacogenomics_marker_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`lims_workflow_assignment` ADD CONSTRAINT `fk_sample_lims_workflow_assignment_variant_database_id` FOREIGN KEY (`variant_database_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database`(`variant_database_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`qc_measurement` ADD CONSTRAINT `fk_sample_qc_measurement_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);

-- ========= sample --> regulatory (10 constraint(s)) =========
-- Requires: sample schema, regulatory schema
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`accession` ADD CONSTRAINT `fk_sample_accession_clinical_evidence_id` FOREIGN KEY (`clinical_evidence_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`clinical_evidence`(`clinical_evidence_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_consent_record` ADD CONSTRAINT `fk_sample_sample_consent_record_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`collection_event` ADD CONSTRAINT `fk_sample_collection_event_clinical_evidence_id` FOREIGN KEY (`clinical_evidence_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`clinical_evidence`(`clinical_evidence_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`lims_workflow_assignment` ADD CONSTRAINT `fk_sample_lims_workflow_assignment_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_clinical_evidence_id` FOREIGN KEY (`clinical_evidence_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`clinical_evidence`(`clinical_evidence_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`qc_measurement` ADD CONSTRAINT `fk_sample_qc_measurement_clinical_evidence_id` FOREIGN KEY (`clinical_evidence_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`clinical_evidence`(`clinical_evidence_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`disposal_event` ADD CONSTRAINT `fk_sample_disposal_event_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`shipment_manifest` ADD CONSTRAINT `fk_sample_shipment_manifest_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`cohort` ADD CONSTRAINT `fk_sample_cohort_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);

-- ========= sample --> research (16 constraint(s)) =========
-- Requires: sample schema, research schema
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`accession` ADD CONSTRAINT `fk_sample_accession_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`storage_event` ADD CONSTRAINT `fk_sample_storage_event_irb_submission_id` FOREIGN KEY (`irb_submission_id`) REFERENCES `genomics_biotech_ecm`.`research`.`irb_submission`(`irb_submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_consent_record` ADD CONSTRAINT `fk_sample_sample_consent_record_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`subject` ADD CONSTRAINT `fk_sample_subject_irb_submission_id` FOREIGN KEY (`irb_submission_id`) REFERENCES `genomics_biotech_ecm`.`research`.`irb_submission`(`irb_submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`collection_event` ADD CONSTRAINT `fk_sample_collection_event_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`collection_event` ADD CONSTRAINT `fk_sample_collection_event_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`lims_workflow_assignment` ADD CONSTRAINT `fk_sample_lims_workflow_assignment_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`qc_measurement` ADD CONSTRAINT `fk_sample_qc_measurement_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`disposal_event` ADD CONSTRAINT `fk_sample_disposal_event_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`shipment_manifest` ADD CONSTRAINT `fk_sample_shipment_manifest_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`shipment_manifest` ADD CONSTRAINT `fk_sample_shipment_manifest_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_enrollment` ADD CONSTRAINT `fk_sample_sample_enrollment_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`aliquot_consumption` ADD CONSTRAINT `fk_sample_aliquot_consumption_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`cohort` ADD CONSTRAINT `fk_sample_cohort_study_id` FOREIGN KEY (`study_id`) REFERENCES `genomics_biotech_ecm`.`research`.`study`(`study_id`);

-- ========= sample --> supply (9 constraint(s)) =========
-- Requires: sample schema, supply schema
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`collection_event` ADD CONSTRAINT `fk_sample_collection_event_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`lims_workflow_assignment` ADD CONSTRAINT `fk_sample_lims_workflow_assignment_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`lims_workflow_assignment` ADD CONSTRAINT `fk_sample_lims_workflow_assignment_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`qc_measurement` ADD CONSTRAINT `fk_sample_qc_measurement_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`shipment_manifest` ADD CONSTRAINT `fk_sample_shipment_manifest_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`container` ADD CONSTRAINT `fk_sample_container_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);

-- ========= sample --> workforce (18 constraint(s)) =========
-- Requires: sample schema, workforce schema
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`accession` ADD CONSTRAINT `fk_sample_accession_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`storage_event` ADD CONSTRAINT `fk_sample_storage_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`storage_event` ADD CONSTRAINT `fk_sample_storage_event_tertiary_storage_acknowledged_by_employee_id` FOREIGN KEY (`tertiary_storage_acknowledged_by_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_consent_record` ADD CONSTRAINT `fk_sample_sample_consent_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`collection_event` ADD CONSTRAINT `fk_sample_collection_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`lims_workflow_assignment` ADD CONSTRAINT `fk_sample_lims_workflow_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`lims_workflow_assignment` ADD CONSTRAINT `fk_sample_lims_workflow_assignment_quaternary_lims_last_modified_by_user_employee_id` FOREIGN KEY (`quaternary_lims_last_modified_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`lims_workflow_assignment` ADD CONSTRAINT `fk_sample_lims_workflow_assignment_tertiary_lims_created_by_user_employee_id` FOREIGN KEY (`tertiary_lims_created_by_user_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`qc_measurement` ADD CONSTRAINT `fk_sample_qc_measurement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`disposal_event` ADD CONSTRAINT `fk_sample_disposal_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`disposal_event` ADD CONSTRAINT `fk_sample_disposal_event_tertiary_disposal_witness_personnel_employee_id` FOREIGN KEY (`tertiary_disposal_witness_personnel_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`shipment_manifest` ADD CONSTRAINT `fk_sample_shipment_manifest_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`temperature_excursion` ADD CONSTRAINT `fk_sample_temperature_excursion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`run_sample` ADD CONSTRAINT `fk_sample_run_sample_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_enrollment` ADD CONSTRAINT `fk_sample_sample_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`aliquot_consumption` ADD CONSTRAINT `fk_sample_aliquot_consumption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= sequencing --> bioinformatics (1 constraint(s)) =========
-- Requires: sequencing schema, bioinformatics schema
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`coverage_stat` ADD CONSTRAINT `fk_sequencing_coverage_stat_bioinformatics_pipeline_run_id` FOREIGN KEY (`bioinformatics_pipeline_run_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`bioinformatics_pipeline_run`(`bioinformatics_pipeline_run_id`);

-- ========= sequencing --> clinical (1 constraint(s)) =========
-- Requires: sequencing schema, clinical schema
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`coverage_stat` ADD CONSTRAINT `fk_sequencing_coverage_stat_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_catalog`(`test_catalog_id`);

-- ========= sequencing --> commercial (4 constraint(s)) =========
-- Requires: sequencing schema, commercial schema
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`array_hybridization` ADD CONSTRAINT `fk_sequencing_array_hybridization_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);

-- ========= sequencing --> customer (18 constraint(s)) =========
-- Requires: sequencing schema, customer schema
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_technical_requirement_id` FOREIGN KEY (`technical_requirement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`technical_requirement`(`technical_requirement_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_technical_requirement_id` FOREIGN KEY (`technical_requirement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`technical_requirement`(`technical_requirement_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_installed_instrument_id` FOREIGN KEY (`installed_instrument_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`installed_instrument`(`installed_instrument_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`pool` ADD CONSTRAINT `fk_sequencing_pool_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_qc_metric` ADD CONSTRAINT `fk_sequencing_run_qc_metric_support_case_id` FOREIGN KEY (`support_case_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`support_case`(`support_case_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_failure_event` ADD CONSTRAINT `fk_sequencing_run_failure_event_support_case_id` FOREIGN KEY (`support_case_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`support_case`(`support_case_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`array_hybridization` ADD CONSTRAINT `fk_sequencing_array_hybridization_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`array_hybridization` ADD CONSTRAINT `fk_sequencing_array_hybridization_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`array_hybridization` ADD CONSTRAINT `fk_sequencing_array_hybridization_installed_instrument_id` FOREIGN KEY (`installed_instrument_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`installed_instrument`(`installed_instrument_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`array_hybridization` ADD CONSTRAINT `fk_sequencing_array_hybridization_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`array_hybridization` ADD CONSTRAINT `fk_sequencing_array_hybridization_technical_requirement_id` FOREIGN KEY (`technical_requirement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`technical_requirement`(`technical_requirement_id`);

-- ========= sequencing --> data (19 constraint(s)) =========
-- Requires: sequencing schema, data schema
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_quality_issue_id` FOREIGN KEY (`quality_issue_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_issue`(`quality_issue_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_access_request_id` FOREIGN KEY (`access_request_id`) REFERENCES `genomics_biotech_ecm`.`data`.`access_request`(`access_request_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_genomic_access_control_id` FOREIGN KEY (`genomic_access_control_id`) REFERENCES `genomics_biotech_ecm`.`data`.`genomic_access_control`(`genomic_access_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_quality_assessment_id` FOREIGN KEY (`quality_assessment_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_assessment`(`quality_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_quality_issue_id` FOREIGN KEY (`quality_issue_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_issue`(`quality_issue_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_quality_assessment_id` FOREIGN KEY (`quality_assessment_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_assessment`(`quality_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_quality_issue_id` FOREIGN KEY (`quality_issue_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_issue`(`quality_issue_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`demux_result` ADD CONSTRAINT `fk_sequencing_demux_result_quality_issue_id` FOREIGN KEY (`quality_issue_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_issue`(`quality_issue_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`fastq_file` ADD CONSTRAINT `fk_sequencing_fastq_file_access_request_id` FOREIGN KEY (`access_request_id`) REFERENCES `genomics_biotech_ecm`.`data`.`access_request`(`access_request_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`fastq_file` ADD CONSTRAINT `fk_sequencing_fastq_file_genomic_access_control_id` FOREIGN KEY (`genomic_access_control_id`) REFERENCES `genomics_biotech_ecm`.`data`.`genomic_access_control`(`genomic_access_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`fastq_file` ADD CONSTRAINT `fk_sequencing_fastq_file_quality_assessment_id` FOREIGN KEY (`quality_assessment_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_assessment`(`quality_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`fastq_file` ADD CONSTRAINT `fk_sequencing_fastq_file_quality_issue_id` FOREIGN KEY (`quality_issue_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_issue`(`quality_issue_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`fastq_file` ADD CONSTRAINT `fk_sequencing_fastq_file_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol` ADD CONSTRAINT `fk_sequencing_sequencing_protocol_mdm_policy_id` FOREIGN KEY (`mdm_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`mdm_policy`(`mdm_policy_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol` ADD CONSTRAINT `fk_sequencing_sequencing_protocol_metadata_schema_id` FOREIGN KEY (`metadata_schema_id`) REFERENCES `genomics_biotech_ecm`.`data`.`metadata_schema`(`metadata_schema_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`array_hybridization` ADD CONSTRAINT `fk_sequencing_array_hybridization_quality_assessment_id` FOREIGN KEY (`quality_assessment_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_assessment`(`quality_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`array_hybridization` ADD CONSTRAINT `fk_sequencing_array_hybridization_quality_issue_id` FOREIGN KEY (`quality_issue_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_issue`(`quality_issue_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`file_quality_evaluation` ADD CONSTRAINT `fk_sequencing_file_quality_evaluation_quality_rule_id` FOREIGN KEY (`quality_rule_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_rule`(`quality_rule_id`);

-- ========= sequencing --> finance (9 constraint(s)) =========
-- Requires: sequencing schema, finance schema
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_revenue_recognition_id` FOREIGN KEY (`revenue_recognition_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`revenue_recognition`(`revenue_recognition_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_revenue_recognition_id` FOREIGN KEY (`revenue_recognition_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`revenue_recognition`(`revenue_recognition_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol` ADD CONSTRAINT `fk_sequencing_sequencing_protocol_rd_capitalization_id` FOREIGN KEY (`rd_capitalization_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`rd_capitalization`(`rd_capitalization_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`array_hybridization` ADD CONSTRAINT `fk_sequencing_array_hybridization_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`array_hybridization` ADD CONSTRAINT `fk_sequencing_array_hybridization_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`internal_order`(`internal_order_id`);

-- ========= sequencing --> instrument (11 constraint(s)) =========
-- Requires: sequencing schema, instrument schema
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_instrument_asset_id` FOREIGN KEY (`instrument_asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`flow_cell` ADD CONSTRAINT `fk_sequencing_flow_cell_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`pool` ADD CONSTRAINT `fk_sequencing_pool_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_lane` ADD CONSTRAINT `fk_sequencing_run_lane_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_qc_metric` ADD CONSTRAINT `fk_sequencing_run_qc_metric_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`fastq_file` ADD CONSTRAINT `fk_sequencing_fastq_file_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_sample_sheet` ADD CONSTRAINT `fk_sequencing_run_sample_sheet_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_failure_event` ADD CONSTRAINT `fk_sequencing_run_failure_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`array_hybridization` ADD CONSTRAINT `fk_sequencing_array_hybridization_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);

-- ========= sequencing --> manufacturing (5 constraint(s)) =========
-- Requires: sequencing schema, manufacturing schema
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_order`(`work_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`flow_cell` ADD CONSTRAINT `fk_sequencing_flow_cell_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_order`(`work_order_id`);

-- ========= sequencing --> product (9 constraint(s)) =========
-- Requires: sequencing schema, product schema
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`flow_cell` ADD CONSTRAINT `fk_sequencing_flow_cell_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`pool` ADD CONSTRAINT `fk_sequencing_pool_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`index_set` ADD CONSTRAINT `fk_sequencing_index_set_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol` ADD CONSTRAINT `fk_sequencing_sequencing_protocol_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`basecall_model` ADD CONSTRAINT `fk_sequencing_basecall_model_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`array_hybridization` ADD CONSTRAINT `fk_sequencing_array_hybridization_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);

-- ========= sequencing --> quality (22 constraint(s)) =========
-- Requires: sequencing schema, quality schema
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_oos_investigation_id` FOREIGN KEY (`oos_investigation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`oos_investigation`(`oos_investigation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_qc_result_id` FOREIGN KEY (`qc_result_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`qc_result`(`qc_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`audit`(`audit_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`pool` ADD CONSTRAINT `fk_sequencing_pool_oos_investigation_id` FOREIGN KEY (`oos_investigation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`oos_investigation`(`oos_investigation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`pool` ADD CONSTRAINT `fk_sequencing_pool_qc_result_id` FOREIGN KEY (`qc_result_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`qc_result`(`qc_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_qc_metric` ADD CONSTRAINT `fk_sequencing_run_qc_metric_oos_investigation_id` FOREIGN KEY (`oos_investigation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`oos_investigation`(`oos_investigation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_qc_metric` ADD CONSTRAINT `fk_sequencing_run_qc_metric_qc_result_id` FOREIGN KEY (`qc_result_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`qc_result`(`qc_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`index_set` ADD CONSTRAINT `fk_sequencing_index_set_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`index_set` ADD CONSTRAINT `fk_sequencing_index_set_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol` ADD CONSTRAINT `fk_sequencing_sequencing_protocol_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol` ADD CONSTRAINT `fk_sequencing_sequencing_protocol_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol` ADD CONSTRAINT `fk_sequencing_sequencing_protocol_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`basecall_model` ADD CONSTRAINT `fk_sequencing_basecall_model_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`basecall_model` ADD CONSTRAINT `fk_sequencing_basecall_model_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`array_hybridization` ADD CONSTRAINT `fk_sequencing_array_hybridization_qc_result_id` FOREIGN KEY (`qc_result_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`qc_result`(`qc_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`array_hybridization` ADD CONSTRAINT `fk_sequencing_array_hybridization_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);

-- ========= sequencing --> reagent (6 constraint(s)) =========
-- Requires: sequencing schema, reagent schema
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`flow_cell` ADD CONSTRAINT `fk_sequencing_flow_cell_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`flow_cell` ADD CONSTRAINT `fk_sequencing_flow_cell_coa_id` FOREIGN KEY (`coa_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`coa`(`coa_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`index_set` ADD CONSTRAINT `fk_sequencing_index_set_coa_id` FOREIGN KEY (`coa_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`coa`(`coa_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`array_hybridization` ADD CONSTRAINT `fk_sequencing_array_hybridization_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);

-- ========= sequencing --> reference (28 constraint(s)) =========
-- Requires: sequencing schema, reference schema
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_gene_annotation_track_id` FOREIGN KEY (`gene_annotation_track_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_annotation_track`(`gene_annotation_track_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_gene_model_id` FOREIGN KEY (`gene_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_model`(`gene_model_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_genomic_region_id` FOREIGN KEY (`genomic_region_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genomic_region`(`genomic_region_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_variant_database_id` FOREIGN KEY (`variant_database_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database`(`variant_database_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`pool` ADD CONSTRAINT `fk_sequencing_pool_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`pool` ADD CONSTRAINT `fk_sequencing_pool_genomic_region_id` FOREIGN KEY (`genomic_region_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genomic_region`(`genomic_region_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_lane` ADD CONSTRAINT `fk_sequencing_run_lane_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_qc_metric` ADD CONSTRAINT `fk_sequencing_run_qc_metric_gene_annotation_track_id` FOREIGN KEY (`gene_annotation_track_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_annotation_track`(`gene_annotation_track_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_qc_metric` ADD CONSTRAINT `fk_sequencing_run_qc_metric_gene_model_id` FOREIGN KEY (`gene_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_model`(`gene_model_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_qc_metric` ADD CONSTRAINT `fk_sequencing_run_qc_metric_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_qc_metric` ADD CONSTRAINT `fk_sequencing_run_qc_metric_genomic_region_id` FOREIGN KEY (`genomic_region_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genomic_region`(`genomic_region_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_qc_metric` ADD CONSTRAINT `fk_sequencing_run_qc_metric_variant_database_id` FOREIGN KEY (`variant_database_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database`(`variant_database_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`demux_result` ADD CONSTRAINT `fk_sequencing_demux_result_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`fastq_file` ADD CONSTRAINT `fk_sequencing_fastq_file_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`coverage_stat` ADD CONSTRAINT `fk_sequencing_coverage_stat_gene_annotation_track_id` FOREIGN KEY (`gene_annotation_track_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_annotation_track`(`gene_annotation_track_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`coverage_stat` ADD CONSTRAINT `fk_sequencing_coverage_stat_gene_model_id` FOREIGN KEY (`gene_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_model`(`gene_model_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`coverage_stat` ADD CONSTRAINT `fk_sequencing_coverage_stat_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`coverage_stat` ADD CONSTRAINT `fk_sequencing_coverage_stat_genomic_region_id` FOREIGN KEY (`genomic_region_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genomic_region`(`genomic_region_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`coverage_stat` ADD CONSTRAINT `fk_sequencing_coverage_stat_pharmacogenomics_marker_id` FOREIGN KEY (`pharmacogenomics_marker_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`pharmacogenomics_marker`(`pharmacogenomics_marker_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`coverage_stat` ADD CONSTRAINT `fk_sequencing_coverage_stat_variant_database_id` FOREIGN KEY (`variant_database_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database`(`variant_database_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol` ADD CONSTRAINT `fk_sequencing_sequencing_protocol_gene_annotation_track_id` FOREIGN KEY (`gene_annotation_track_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_annotation_track`(`gene_annotation_track_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol` ADD CONSTRAINT `fk_sequencing_sequencing_protocol_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol` ADD CONSTRAINT `fk_sequencing_sequencing_protocol_genomic_region_id` FOREIGN KEY (`genomic_region_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genomic_region`(`genomic_region_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol` ADD CONSTRAINT `fk_sequencing_sequencing_protocol_variant_database_id` FOREIGN KEY (`variant_database_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database`(`variant_database_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`array_hybridization` ADD CONSTRAINT `fk_sequencing_array_hybridization_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);

-- ========= sequencing --> regulatory (7 constraint(s)) =========
-- Requires: sequencing schema, regulatory schema
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_qc_metric` ADD CONSTRAINT `fk_sequencing_run_qc_metric_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol` ADD CONSTRAINT `fk_sequencing_sequencing_protocol_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`basecall_model` ADD CONSTRAINT `fk_sequencing_basecall_model_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`basecall_model` ADD CONSTRAINT `fk_sequencing_basecall_model_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`array_hybridization` ADD CONSTRAINT `fk_sequencing_array_hybridization_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`array_hybridization` ADD CONSTRAINT `fk_sequencing_array_hybridization_clinical_evidence_id` FOREIGN KEY (`clinical_evidence_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`clinical_evidence`(`clinical_evidence_id`);

-- ========= sequencing --> research (17 constraint(s)) =========
-- Requires: sequencing schema, research schema
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`pool` ADD CONSTRAINT `fk_sequencing_pool_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_qc_metric` ADD CONSTRAINT `fk_sequencing_run_qc_metric_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`demux_result` ADD CONSTRAINT `fk_sequencing_demux_result_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`demux_result` ADD CONSTRAINT `fk_sequencing_demux_result_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`fastq_file` ADD CONSTRAINT `fk_sequencing_fastq_file_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`fastq_file` ADD CONSTRAINT `fk_sequencing_fastq_file_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`fastq_file` ADD CONSTRAINT `fk_sequencing_fastq_file_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`coverage_stat` ADD CONSTRAINT `fk_sequencing_coverage_stat_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`basecall_model` ADD CONSTRAINT `fk_sequencing_basecall_model_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`array_hybridization` ADD CONSTRAINT `fk_sequencing_array_hybridization_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`array_hybridization` ADD CONSTRAINT `fk_sequencing_array_hybridization_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`array_hybridization` ADD CONSTRAINT `fk_sequencing_array_hybridization_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);

-- ========= sequencing --> sample (9 constraint(s)) =========
-- Requires: sequencing schema, sample schema
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_container_id` FOREIGN KEY (`container_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`container`(`container_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_lims_workflow_assignment_id` FOREIGN KEY (`lims_workflow_assignment_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`lims_workflow_assignment`(`lims_workflow_assignment_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_qc_metric` ADD CONSTRAINT `fk_sequencing_run_qc_metric_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`demux_result` ADD CONSTRAINT `fk_sequencing_demux_result_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`fastq_file` ADD CONSTRAINT `fk_sequencing_fastq_file_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`coverage_stat` ADD CONSTRAINT `fk_sequencing_coverage_stat_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`array_hybridization` ADD CONSTRAINT `fk_sequencing_array_hybridization_lims_workflow_assignment_id` FOREIGN KEY (`lims_workflow_assignment_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`lims_workflow_assignment`(`lims_workflow_assignment_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`array_hybridization` ADD CONSTRAINT `fk_sequencing_array_hybridization_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);

-- ========= sequencing --> supply (12 constraint(s)) =========
-- Requires: sequencing schema, supply schema
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`flow_cell` ADD CONSTRAINT `fk_sequencing_flow_cell_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`flow_cell` ADD CONSTRAINT `fk_sequencing_flow_cell_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`index_set` ADD CONSTRAINT `fk_sequencing_index_set_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`index_set` ADD CONSTRAINT `fk_sequencing_index_set_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`index_set` ADD CONSTRAINT `fk_sequencing_index_set_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol` ADD CONSTRAINT `fk_sequencing_sequencing_protocol_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);

-- ========= sequencing --> workforce (13 constraint(s)) =========
-- Requires: sequencing schema, workforce schema
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`flow_cell` ADD CONSTRAINT `fk_sequencing_flow_cell_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`pool` ADD CONSTRAINT `fk_sequencing_pool_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`pool_library` ADD CONSTRAINT `fk_sequencing_pool_library_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_lane` ADD CONSTRAINT `fk_sequencing_run_lane_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`demux_result` ADD CONSTRAINT `fk_sequencing_demux_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol` ADD CONSTRAINT `fk_sequencing_sequencing_protocol_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_sample_sheet` ADD CONSTRAINT `fk_sequencing_run_sample_sheet_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_failure_event` ADD CONSTRAINT `fk_sequencing_run_failure_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`basecall_model` ADD CONSTRAINT `fk_sequencing_basecall_model_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`array_hybridization` ADD CONSTRAINT `fk_sequencing_array_hybridization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= supply --> commercial (4 constraint(s)) =========
-- Requires: supply schema, commercial schema
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ADD CONSTRAINT `fk_supply_supplier_channel_partner_id` FOREIGN KEY (`channel_partner_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`channel_partner`(`channel_partner_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_reagent_subscription_id` FOREIGN KEY (`reagent_subscription_id`) REFERENCES `genomics_biotech_ecm`.`commercial`.`reagent_subscription`(`reagent_subscription_id`);

-- ========= supply --> customer (2 constraint(s)) =========
-- Requires: supply schema, customer schema
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);

-- ========= supply --> data (5 constraint(s)) =========
-- Requires: supply schema, data schema
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ADD CONSTRAINT `fk_supply_material_glossary_term_id` FOREIGN KEY (`glossary_term_id`) REFERENCES `genomics_biotech_ecm`.`data`.`glossary_term`(`glossary_term_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ADD CONSTRAINT `fk_supply_material_metadata_schema_id` FOREIGN KEY (`metadata_schema_id`) REFERENCES `genomics_biotech_ecm`.`data`.`metadata_schema`(`metadata_schema_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_mdm_policy_id` FOREIGN KEY (`mdm_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`mdm_policy`(`mdm_policy_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_quality_issue_id` FOREIGN KEY (`quality_issue_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_issue`(`quality_issue_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_mdm_policy_id` FOREIGN KEY (`mdm_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`mdm_policy`(`mdm_policy_id`);

-- ========= supply --> finance (12 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ADD CONSTRAINT `fk_supply_material_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ADD CONSTRAINT `fk_supply_batch_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ADD CONSTRAINT `fk_supply_inbound_delivery_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_capex_request_id` FOREIGN KEY (`capex_request_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`capex_request`(`capex_request_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ADD CONSTRAINT `fk_supply_warehouse_location_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ADD CONSTRAINT `fk_supply_supplier_qualification_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`sox_control`(`sox_control_id`);

-- ========= supply --> instrument (1 constraint(s)) =========
-- Requires: supply schema, instrument schema
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch_quality_test` ADD CONSTRAINT `fk_supply_batch_quality_test_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);

-- ========= supply --> manufacturing (1 constraint(s)) =========
-- Requires: supply schema, manufacturing schema
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ADD CONSTRAINT `fk_supply_batch_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_order`(`work_order_id`);

-- ========= supply --> product (2 constraint(s)) =========
-- Requires: supply schema, product schema
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ADD CONSTRAINT `fk_supply_material_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);

-- ========= supply --> quality (2 constraint(s)) =========
-- Requires: supply schema, quality schema
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ADD CONSTRAINT `fk_supply_supplier_qualification_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`audit`(`audit_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ADD CONSTRAINT `fk_supply_supplier_qualification_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);

-- ========= supply --> reagent (11 constraint(s)) =========
-- Requires: supply schema, reagent schema
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`storage_location`(`storage_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ADD CONSTRAINT `fk_supply_inventory_stock_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ADD CONSTRAINT `fk_supply_inventory_stock_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`storage_location`(`storage_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`storage_location`(`storage_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`storage_location`(`storage_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`contract_line` ADD CONSTRAINT `fk_supply_contract_line_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_reagent_qualification` ADD CONSTRAINT `fk_supply_supplier_reagent_qualification_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);

-- ========= supply --> reference (6 constraint(s)) =========
-- Requires: supply schema, reference schema
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ADD CONSTRAINT `fk_supply_material_gene_model_id` FOREIGN KEY (`gene_model_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`gene_model`(`gene_model_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ADD CONSTRAINT `fk_supply_material_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ADD CONSTRAINT `fk_supply_batch_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ADD CONSTRAINT `fk_supply_batch_variant_database_id` FOREIGN KEY (`variant_database_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database`(`variant_database_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_variant_database_id` FOREIGN KEY (`variant_database_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database`(`variant_database_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ADD CONSTRAINT `fk_supply_supplier_qualification_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);

-- ========= supply --> regulatory (5 constraint(s)) =========
-- Requires: supply schema, regulatory schema
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ADD CONSTRAINT `fk_supply_supplier_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ADD CONSTRAINT `fk_supply_material_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ADD CONSTRAINT `fk_supply_material_device_identifier_id` FOREIGN KEY (`device_identifier_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`device_identifier`(`device_identifier_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ADD CONSTRAINT `fk_supply_batch_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ADD CONSTRAINT `fk_supply_supplier_qualification_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);

-- ========= supply --> workforce (14 constraint(s)) =========
-- Requires: supply schema, workforce schema
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ADD CONSTRAINT `fk_supply_batch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ADD CONSTRAINT `fk_supply_inbound_delivery_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ADD CONSTRAINT `fk_supply_warehouse_location_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ADD CONSTRAINT `fk_supply_supplier_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ADD CONSTRAINT `fk_supply_supplier_performance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material_qualification` ADD CONSTRAINT `fk_supply_material_qualification_assessor_employee_id` FOREIGN KEY (`assessor_employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material_qualification` ADD CONSTRAINT `fk_supply_material_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `genomics_biotech_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= workforce --> customer (2 constraint(s)) =========
-- Requires: workforce schema, customer schema
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`service_agreement`(`service_agreement_id`);

-- ========= workforce --> data (8 constraint(s)) =========
-- Requires: workforce schema, data schema
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_mdm_policy_id` FOREIGN KEY (`mdm_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`mdm_policy`(`mdm_policy_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `genomics_biotech_ecm`.`data`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`job_profile` ADD CONSTRAINT `fk_workforce_job_profile_genomic_access_control_id` FOREIGN KEY (`genomic_access_control_id`) REFERENCES `genomics_biotech_ecm`.`data`.`genomic_access_control`(`genomic_access_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ADD CONSTRAINT `fk_workforce_gxp_training_record_quality_rule_id` FOREIGN KEY (`quality_rule_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_rule`(`quality_rule_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ADD CONSTRAINT `fk_workforce_workforce_training_curriculum_genomic_access_control_id` FOREIGN KEY (`genomic_access_control_id`) REFERENCES `genomics_biotech_ecm`.`data`.`genomic_access_control`(`genomic_access_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ADD CONSTRAINT `fk_workforce_lab_qualification_genomic_access_control_id` FOREIGN KEY (`genomic_access_control_id`) REFERENCES `genomics_biotech_ecm`.`data`.`genomic_access_control`(`genomic_access_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ADD CONSTRAINT `fk_workforce_lab_qualification_quality_rule_id` FOREIGN KEY (`quality_rule_id`) REFERENCES `genomics_biotech_ecm`.`data`.`quality_rule`(`quality_rule_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genomic_access_grant` ADD CONSTRAINT `fk_workforce_genomic_access_grant_genomic_access_control_id` FOREIGN KEY (`genomic_access_control_id`) REFERENCES `genomics_biotech_ecm`.`data`.`genomic_access_control`(`genomic_access_control_id`);

-- ========= workforce --> finance (7 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_assignment` ADD CONSTRAINT `fk_workforce_workforce_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`payroll_result` ADD CONSTRAINT `fk_workforce_payroll_result_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_rd_capitalization_id` FOREIGN KEY (`rd_capitalization_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`rd_capitalization`(`rd_capitalization_id`);

-- ========= workforce --> manufacturing (1 constraint(s)) =========
-- Requires: workforce schema, manufacturing schema
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_order`(`work_order_id`);

-- ========= workforce --> quality (2 constraint(s)) =========
-- Requires: workforce schema, quality schema
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ADD CONSTRAINT `fk_workforce_gxp_training_record_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ADD CONSTRAINT `fk_workforce_lab_qualification_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);

-- ========= workforce --> reference (5 constraint(s)) =========
-- Requires: workforce schema, reference schema
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`gxp_training_record` ADD CONSTRAINT `fk_workforce_gxp_training_record_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ADD CONSTRAINT `fk_workforce_talent_profile_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`talent_profile` ADD CONSTRAINT `fk_workforce_talent_profile_variant_database_id` FOREIGN KEY (`variant_database_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`variant_database`(`variant_database_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`lab_qualification` ADD CONSTRAINT `fk_workforce_lab_qualification_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`genome_qualification` ADD CONSTRAINT `fk_workforce_genome_qualification_genome_assembly_id` FOREIGN KEY (`genome_assembly_id`) REFERENCES `genomics_biotech_ecm`.`reference`.`genome_assembly`(`genome_assembly_id`);

-- ========= workforce --> regulatory (1 constraint(s)) =========
-- Requires: workforce schema, regulatory schema
ALTER TABLE `genomics_biotech_ecm`.`workforce`.`workforce_training_curriculum` ADD CONSTRAINT `fk_workforce_workforce_training_curriculum_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);

