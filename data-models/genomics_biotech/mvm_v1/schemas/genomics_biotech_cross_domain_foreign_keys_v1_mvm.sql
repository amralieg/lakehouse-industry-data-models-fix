-- Cross-Domain Foreign Keys for Business: Genomics Biotech | Version: v1_mvm
-- Generated on: 2026-05-06 15:33:29
-- Total cross-domain FK constraints: 1420
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: bioinformatics, clinical, customer, instrument, manufacturing, order, product, quality, reagent, regulatory, research, sample, sequencing, supply

-- ========= bioinformatics --> clinical (6 constraint(s)) =========
-- Requires: bioinformatics schema, clinical schema
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline` ADD CONSTRAINT `fk_bioinformatics_pipeline_assay_id` FOREIGN KEY (`assay_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`assay`(`assay_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_annotation` ADD CONSTRAINT `fk_bioinformatics_variant_annotation_variant_knowledge_base_id` FOREIGN KEY (`variant_knowledge_base_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base`(`variant_knowledge_base_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_assay_version_id` FOREIGN KEY (`assay_version_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`assay_version`(`assay_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_clia_accreditation_id` FOREIGN KEY (`clia_accreditation_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`clia_accreditation`(`clia_accreditation_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_performing_laboratory_id` FOREIGN KEY (`performing_laboratory_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`performing_laboratory`(`performing_laboratory_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_catalog`(`test_catalog_id`);

-- ========= bioinformatics --> customer (5 constraint(s)) =========
-- Requires: bioinformatics schema, customer schema
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_run` ADD CONSTRAINT `fk_bioinformatics_pipeline_run_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_run` ADD CONSTRAINT `fk_bioinformatics_pipeline_run_installed_instrument_id` FOREIGN KEY (`installed_instrument_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`installed_instrument`(`installed_instrument_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`genomic_artifact` ADD CONSTRAINT `fk_bioinformatics_genomic_artifact_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_accreditation_id` FOREIGN KEY (`accreditation_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`accreditation`(`accreditation_id`);

-- ========= bioinformatics --> instrument (9 constraint(s)) =========
-- Requires: bioinformatics schema, instrument schema
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline` ADD CONSTRAINT `fk_bioinformatics_pipeline_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version` ADD CONSTRAINT `fk_bioinformatics_pipeline_version_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_run` ADD CONSTRAINT `fk_bioinformatics_pipeline_run_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_run` ADD CONSTRAINT `fk_bioinformatics_pipeline_run_instrument_run_id` FOREIGN KEY (`instrument_run_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`instrument_run`(`instrument_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`alignment_result` ADD CONSTRAINT `fk_bioinformatics_alignment_result_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_call_result` ADD CONSTRAINT `fk_bioinformatics_variant_call_result_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_qc_metric` ADD CONSTRAINT `fk_bioinformatics_pipeline_qc_metric_instrument_run_id` FOREIGN KEY (`instrument_run_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`instrument_run`(`instrument_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`genomic_artifact` ADD CONSTRAINT `fk_bioinformatics_genomic_artifact_instrument_run_id` FOREIGN KEY (`instrument_run_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`instrument_run`(`instrument_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);

-- ========= bioinformatics --> manufacturing (4 constraint(s)) =========
-- Requires: bioinformatics schema, manufacturing schema
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_run` ADD CONSTRAINT `fk_bioinformatics_pipeline_run_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_run` ADD CONSTRAINT `fk_bioinformatics_pipeline_run_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_order`(`work_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_manufacturing_bom_id` FOREIGN KEY (`manufacturing_bom_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom`(`manufacturing_bom_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);

-- ========= bioinformatics --> order (4 constraint(s)) =========
-- Requires: bioinformatics schema, order schema
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_run` ADD CONSTRAINT `fk_bioinformatics_pipeline_run_line_id` FOREIGN KEY (`line_id`) REFERENCES `genomics_biotech_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_call_result` ADD CONSTRAINT `fk_bioinformatics_variant_call_result_line_id` FOREIGN KEY (`line_id`) REFERENCES `genomics_biotech_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`genomic_artifact` ADD CONSTRAINT `fk_bioinformatics_genomic_artifact_delivery_line_id` FOREIGN KEY (`delivery_line_id`) REFERENCES `genomics_biotech_ecm`.`order`.`delivery_line`(`delivery_line_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);

-- ========= bioinformatics --> product (7 constraint(s)) =========
-- Requires: bioinformatics schema, product schema
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline` ADD CONSTRAINT `fk_bioinformatics_pipeline_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline` ADD CONSTRAINT `fk_bioinformatics_pipeline_software_release_id` FOREIGN KEY (`software_release_id`) REFERENCES `genomics_biotech_ecm`.`product`.`software_release`(`software_release_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version` ADD CONSTRAINT `fk_bioinformatics_pipeline_version_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version` ADD CONSTRAINT `fk_bioinformatics_pipeline_version_software_release_id` FOREIGN KEY (`software_release_id`) REFERENCES `genomics_biotech_ecm`.`product`.`software_release`(`software_release_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version` ADD CONSTRAINT `fk_bioinformatics_pipeline_version_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`genomic_artifact` ADD CONSTRAINT `fk_bioinformatics_genomic_artifact_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`specification`(`specification_id`);

-- ========= bioinformatics --> quality (36 constraint(s)) =========
-- Requires: bioinformatics schema, quality schema
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline` ADD CONSTRAINT `fk_bioinformatics_pipeline_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline` ADD CONSTRAINT `fk_bioinformatics_pipeline_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version` ADD CONSTRAINT `fk_bioinformatics_pipeline_version_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version` ADD CONSTRAINT `fk_bioinformatics_pipeline_version_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version` ADD CONSTRAINT `fk_bioinformatics_pipeline_version_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version` ADD CONSTRAINT `fk_bioinformatics_pipeline_version_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version` ADD CONSTRAINT `fk_bioinformatics_pipeline_version_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_run` ADD CONSTRAINT `fk_bioinformatics_pipeline_run_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`audit`(`audit_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_run` ADD CONSTRAINT `fk_bioinformatics_pipeline_run_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_run` ADD CONSTRAINT `fk_bioinformatics_pipeline_run_oos_investigation_id` FOREIGN KEY (`oos_investigation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`oos_investigation`(`oos_investigation_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_run_step` ADD CONSTRAINT `fk_bioinformatics_pipeline_run_step_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`compute_job` ADD CONSTRAINT `fk_bioinformatics_compute_job_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`alignment_result` ADD CONSTRAINT `fk_bioinformatics_alignment_result_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`alignment_result` ADD CONSTRAINT `fk_bioinformatics_alignment_result_qc_result_id` FOREIGN KEY (`qc_result_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`qc_result`(`qc_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`alignment_result` ADD CONSTRAINT `fk_bioinformatics_alignment_result_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_call_result` ADD CONSTRAINT `fk_bioinformatics_variant_call_result_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_call_result` ADD CONSTRAINT `fk_bioinformatics_variant_call_result_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_call_result` ADD CONSTRAINT `fk_bioinformatics_variant_call_result_oos_investigation_id` FOREIGN KEY (`oos_investigation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`oos_investigation`(`oos_investigation_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_call_result` ADD CONSTRAINT `fk_bioinformatics_variant_call_result_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_annotation` ADD CONSTRAINT `fk_bioinformatics_variant_annotation_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_annotation` ADD CONSTRAINT `fk_bioinformatics_variant_annotation_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_qc_metric` ADD CONSTRAINT `fk_bioinformatics_pipeline_qc_metric_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_qc_metric` ADD CONSTRAINT `fk_bioinformatics_pipeline_qc_metric_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_qc_metric` ADD CONSTRAINT `fk_bioinformatics_pipeline_qc_metric_oos_investigation_id` FOREIGN KEY (`oos_investigation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`oos_investigation`(`oos_investigation_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_qc_metric` ADD CONSTRAINT `fk_bioinformatics_pipeline_qc_metric_qc_result_id` FOREIGN KEY (`qc_result_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`qc_result`(`qc_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`genomic_artifact` ADD CONSTRAINT `fk_bioinformatics_genomic_artifact_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`genomic_artifact` ADD CONSTRAINT `fk_bioinformatics_genomic_artifact_qc_result_id` FOREIGN KEY (`qc_result_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`qc_result`(`qc_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`data_lineage_event` ADD CONSTRAINT `fk_bioinformatics_data_lineage_event_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`audit`(`audit_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);

-- ========= bioinformatics --> reagent (7 constraint(s)) =========
-- Requires: bioinformatics schema, reagent schema
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version` ADD CONSTRAINT `fk_bioinformatics_pipeline_version_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_run` ADD CONSTRAINT `fk_bioinformatics_pipeline_run_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_run` ADD CONSTRAINT `fk_bioinformatics_pipeline_run_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`alignment_result` ADD CONSTRAINT `fk_bioinformatics_alignment_result_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_call_result` ADD CONSTRAINT `fk_bioinformatics_variant_call_result_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_qc_metric` ADD CONSTRAINT `fk_bioinformatics_pipeline_qc_metric_qc_specification_id` FOREIGN KEY (`qc_specification_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`qc_specification`(`qc_specification_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);

-- ========= bioinformatics --> regulatory (16 constraint(s)) =========
-- Requires: bioinformatics schema, regulatory schema
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline` ADD CONSTRAINT `fk_bioinformatics_pipeline_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version` ADD CONSTRAINT `fk_bioinformatics_pipeline_version_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version` ADD CONSTRAINT `fk_bioinformatics_pipeline_version_device_identifier_id` FOREIGN KEY (`device_identifier_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`device_identifier`(`device_identifier_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version` ADD CONSTRAINT `fk_bioinformatics_pipeline_version_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version` ADD CONSTRAINT `fk_bioinformatics_pipeline_version_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_run` ADD CONSTRAINT `fk_bioinformatics_pipeline_run_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_run` ADD CONSTRAINT `fk_bioinformatics_pipeline_run_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`alignment_result` ADD CONSTRAINT `fk_bioinformatics_alignment_result_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_call_result` ADD CONSTRAINT `fk_bioinformatics_variant_call_result_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_annotation` ADD CONSTRAINT `fk_bioinformatics_variant_annotation_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_qc_metric` ADD CONSTRAINT `fk_bioinformatics_pipeline_qc_metric_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`genomic_artifact` ADD CONSTRAINT `fk_bioinformatics_genomic_artifact_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`data_lineage_event` ADD CONSTRAINT `fk_bioinformatics_data_lineage_event_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);

-- ========= bioinformatics --> research (4 constraint(s)) =========
-- Requires: bioinformatics schema, research schema
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_run` ADD CONSTRAINT `fk_bioinformatics_pipeline_run_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`compute_job` ADD CONSTRAINT `fk_bioinformatics_compute_job_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_study_id` FOREIGN KEY (`study_id`) REFERENCES `genomics_biotech_ecm`.`research`.`study`(`study_id`);

-- ========= bioinformatics --> sample (27 constraint(s)) =========
-- Requires: bioinformatics schema, sample schema
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_run` ADD CONSTRAINT `fk_bioinformatics_pipeline_run_accession_id` FOREIGN KEY (`accession_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`accession`(`accession_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_run` ADD CONSTRAINT `fk_bioinformatics_pipeline_run_aliquot_id` FOREIGN KEY (`aliquot_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`aliquot`(`aliquot_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_run` ADD CONSTRAINT `fk_bioinformatics_pipeline_run_extraction_id` FOREIGN KEY (`extraction_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`extraction`(`extraction_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_run` ADD CONSTRAINT `fk_bioinformatics_pipeline_run_run_sample_id` FOREIGN KEY (`run_sample_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`run_sample`(`run_sample_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_run` ADD CONSTRAINT `fk_bioinformatics_pipeline_run_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`alignment_result` ADD CONSTRAINT `fk_bioinformatics_alignment_result_aliquot_id` FOREIGN KEY (`aliquot_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`aliquot`(`aliquot_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`alignment_result` ADD CONSTRAINT `fk_bioinformatics_alignment_result_extraction_id` FOREIGN KEY (`extraction_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`extraction`(`extraction_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`alignment_result` ADD CONSTRAINT `fk_bioinformatics_alignment_result_run_sample_id` FOREIGN KEY (`run_sample_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`run_sample`(`run_sample_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`alignment_result` ADD CONSTRAINT `fk_bioinformatics_alignment_result_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_call_result` ADD CONSTRAINT `fk_bioinformatics_variant_call_result_accession_id` FOREIGN KEY (`accession_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`accession`(`accession_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_call_result` ADD CONSTRAINT `fk_bioinformatics_variant_call_result_aliquot_id` FOREIGN KEY (`aliquot_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`aliquot`(`aliquot_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_call_result` ADD CONSTRAINT `fk_bioinformatics_variant_call_result_extraction_id` FOREIGN KEY (`extraction_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`extraction`(`extraction_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_call_result` ADD CONSTRAINT `fk_bioinformatics_variant_call_result_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_annotation` ADD CONSTRAINT `fk_bioinformatics_variant_annotation_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_qc_metric` ADD CONSTRAINT `fk_bioinformatics_pipeline_qc_metric_aliquot_id` FOREIGN KEY (`aliquot_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`aliquot`(`aliquot_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_qc_metric` ADD CONSTRAINT `fk_bioinformatics_pipeline_qc_metric_extraction_id` FOREIGN KEY (`extraction_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`extraction`(`extraction_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_qc_metric` ADD CONSTRAINT `fk_bioinformatics_pipeline_qc_metric_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`genomic_artifact` ADD CONSTRAINT `fk_bioinformatics_genomic_artifact_accession_id` FOREIGN KEY (`accession_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`accession`(`accession_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`genomic_artifact` ADD CONSTRAINT `fk_bioinformatics_genomic_artifact_aliquot_id` FOREIGN KEY (`aliquot_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`aliquot`(`aliquot_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`genomic_artifact` ADD CONSTRAINT `fk_bioinformatics_genomic_artifact_extraction_id` FOREIGN KEY (`extraction_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`extraction`(`extraction_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`genomic_artifact` ADD CONSTRAINT `fk_bioinformatics_genomic_artifact_run_sample_id` FOREIGN KEY (`run_sample_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`run_sample`(`run_sample_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`genomic_artifact` ADD CONSTRAINT `fk_bioinformatics_genomic_artifact_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`data_lineage_event` ADD CONSTRAINT `fk_bioinformatics_data_lineage_event_aliquot_id` FOREIGN KEY (`aliquot_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`aliquot`(`aliquot_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`data_lineage_event` ADD CONSTRAINT `fk_bioinformatics_data_lineage_event_extraction_id` FOREIGN KEY (`extraction_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`extraction`(`extraction_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`data_lineage_event` ADD CONSTRAINT `fk_bioinformatics_data_lineage_event_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_cohort_id` FOREIGN KEY (`cohort_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`cohort`(`cohort_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_lab_site_id` FOREIGN KEY (`lab_site_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`lab_site`(`lab_site_id`);

-- ========= bioinformatics --> sequencing (15 constraint(s)) =========
-- Requires: bioinformatics schema, sequencing schema
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_run` ADD CONSTRAINT `fk_bioinformatics_pipeline_run_demux_result_id` FOREIGN KEY (`demux_result_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`demux_result`(`demux_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`alignment_result` ADD CONSTRAINT `fk_bioinformatics_alignment_result_flow_cell_id` FOREIGN KEY (`flow_cell_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`flow_cell`(`flow_cell_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`alignment_result` ADD CONSTRAINT `fk_bioinformatics_alignment_result_library_id` FOREIGN KEY (`library_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`library`(`library_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`alignment_result` ADD CONSTRAINT `fk_bioinformatics_alignment_result_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_run`(`sequencing_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_call_result` ADD CONSTRAINT `fk_bioinformatics_variant_call_result_library_id` FOREIGN KEY (`library_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`library`(`library_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_call_result` ADD CONSTRAINT `fk_bioinformatics_variant_call_result_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_run`(`sequencing_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`variant_annotation` ADD CONSTRAINT `fk_bioinformatics_variant_annotation_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_run`(`sequencing_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_qc_metric` ADD CONSTRAINT `fk_bioinformatics_pipeline_qc_metric_flow_cell_id` FOREIGN KEY (`flow_cell_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`flow_cell`(`flow_cell_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_qc_metric` ADD CONSTRAINT `fk_bioinformatics_pipeline_qc_metric_library_id` FOREIGN KEY (`library_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`library`(`library_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`genomic_artifact` ADD CONSTRAINT `fk_bioinformatics_genomic_artifact_demux_result_id` FOREIGN KEY (`demux_result_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`demux_result`(`demux_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`genomic_artifact` ADD CONSTRAINT `fk_bioinformatics_genomic_artifact_flow_cell_id` FOREIGN KEY (`flow_cell_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`flow_cell`(`flow_cell_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`genomic_artifact` ADD CONSTRAINT `fk_bioinformatics_genomic_artifact_library_id` FOREIGN KEY (`library_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`library`(`library_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`data_lineage_event` ADD CONSTRAINT `fk_bioinformatics_data_lineage_event_demux_result_id` FOREIGN KEY (`demux_result_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`demux_result`(`demux_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`data_lineage_event` ADD CONSTRAINT `fk_bioinformatics_data_lineage_event_library_id` FOREIGN KEY (`library_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`library`(`library_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`data_lineage_event` ADD CONSTRAINT `fk_bioinformatics_data_lineage_event_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_run`(`sequencing_run_id`);

-- ========= bioinformatics --> supply (6 constraint(s)) =========
-- Requires: bioinformatics schema, supply schema
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_run` ADD CONSTRAINT `fk_bioinformatics_pipeline_run_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_run` ADD CONSTRAINT `fk_bioinformatics_pipeline_run_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study` ADD CONSTRAINT `fk_bioinformatics_pipeline_validation_study_supplier_qualification_id` FOREIGN KEY (`supplier_qualification_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier_qualification`(`supplier_qualification_id`);

-- ========= clinical --> bioinformatics (10 constraint(s)) =========
-- Requires: clinical schema, bioinformatics schema
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ADD CONSTRAINT `fk_clinical_test_catalog_pipeline_id` FOREIGN KEY (`pipeline_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`pipeline`(`pipeline_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_pipeline_version_id` FOREIGN KEY (`pipeline_version_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version`(`pipeline_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ADD CONSTRAINT `fk_clinical_analytical_validation_pipeline_version_id` FOREIGN KEY (`pipeline_version_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version`(`pipeline_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ADD CONSTRAINT `fk_clinical_genomic_result_alignment_result_id` FOREIGN KEY (`alignment_result_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`alignment_result`(`alignment_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ADD CONSTRAINT `fk_clinical_genomic_result_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ADD CONSTRAINT `fk_clinical_genomic_result_variant_call_result_id` FOREIGN KEY (`variant_call_result_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`variant_call_result`(`variant_call_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ADD CONSTRAINT `fk_clinical_variant_interpretation_variant_annotation_id` FOREIGN KEY (`variant_annotation_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`variant_annotation`(`variant_annotation_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ADD CONSTRAINT `fk_clinical_variant_interpretation_variant_call_result_id` FOREIGN KEY (`variant_call_result_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`variant_call_result`(`variant_call_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ADD CONSTRAINT `fk_clinical_report_pipeline_version_id` FOREIGN KEY (`pipeline_version_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version`(`pipeline_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`pipeline_run`(`pipeline_run_id`);

-- ========= clinical --> customer (12 constraint(s)) =========
-- Requires: clinical schema, customer schema
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_accreditation_id` FOREIGN KEY (`accreditation_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`accreditation`(`accreditation_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ADD CONSTRAINT `fk_clinical_clinical_specimen_address_id` FOREIGN KEY (`address_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ADD CONSTRAINT `fk_clinical_report_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ADD CONSTRAINT `fk_clinical_clinical_consent_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ADD CONSTRAINT `fk_clinical_clinical_consent_record_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ADD CONSTRAINT `fk_clinical_authorized_orderer_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ADD CONSTRAINT `fk_clinical_authorized_orderer_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`performing_laboratory` ADD CONSTRAINT `fk_clinical_performing_laboratory_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);

-- ========= clinical --> instrument (8 constraint(s)) =========
-- Requires: clinical schema, instrument schema
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ADD CONSTRAINT `fk_clinical_test_catalog_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ADD CONSTRAINT `fk_clinical_analytical_validation_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ADD CONSTRAINT `fk_clinical_genomic_result_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ADD CONSTRAINT `fk_clinical_report_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`configuration`(`configuration_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay` ADD CONSTRAINT `fk_clinical_assay_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);

-- ========= clinical --> manufacturing (10 constraint(s)) =========
-- Requires: clinical schema, manufacturing schema
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ADD CONSTRAINT `fk_clinical_test_catalog_production_routing_id` FOREIGN KEY (`production_routing_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_routing`(`production_routing_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_manufacturing_bom_id` FOREIGN KEY (`manufacturing_bom_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom`(`manufacturing_bom_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ADD CONSTRAINT `fk_clinical_clinical_specimen_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ADD CONSTRAINT `fk_clinical_analytical_validation_equipment_qualification_id` FOREIGN KEY (`equipment_qualification_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification`(`equipment_qualification_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ADD CONSTRAINT `fk_clinical_analytical_validation_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ADD CONSTRAINT `fk_clinical_report_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ADD CONSTRAINT `fk_clinical_clia_accreditation_site_id` FOREIGN KEY (`site_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`performing_laboratory` ADD CONSTRAINT `fk_clinical_performing_laboratory_site_id` FOREIGN KEY (`site_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`site`(`site_id`);

-- ========= clinical --> order (1 constraint(s)) =========
-- Requires: clinical schema, order schema
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);

-- ========= clinical --> product (13 constraint(s)) =========
-- Requires: clinical schema, product schema
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ADD CONSTRAINT `fk_clinical_test_catalog_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ADD CONSTRAINT `fk_clinical_test_catalog_software_release_id` FOREIGN KEY (`software_release_id`) REFERENCES `genomics_biotech_ecm`.`product`.`software_release`(`software_release_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ADD CONSTRAINT `fk_clinical_test_catalog_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_software_release_id` FOREIGN KEY (`software_release_id`) REFERENCES `genomics_biotech_ecm`.`product`.`software_release`(`software_release_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ADD CONSTRAINT `fk_clinical_analytical_validation_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ADD CONSTRAINT `fk_clinical_analytical_validation_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ADD CONSTRAINT `fk_clinical_report_software_release_id` FOREIGN KEY (`software_release_id`) REFERENCES `genomics_biotech_ecm`.`product`.`software_release`(`software_release_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`specification`(`specification_id`);

-- ========= clinical --> quality (20 constraint(s)) =========
-- Requires: clinical schema, quality schema
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ADD CONSTRAINT `fk_clinical_test_catalog_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_complaint_id` FOREIGN KEY (`complaint_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`complaint`(`complaint_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ADD CONSTRAINT `fk_clinical_clinical_specimen_qc_result_id` FOREIGN KEY (`qc_result_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`qc_result`(`qc_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ADD CONSTRAINT `fk_clinical_analytical_validation_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ADD CONSTRAINT `fk_clinical_analytical_validation_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ADD CONSTRAINT `fk_clinical_analytical_validation_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ADD CONSTRAINT `fk_clinical_analytical_validation_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ADD CONSTRAINT `fk_clinical_variant_interpretation_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ADD CONSTRAINT `fk_clinical_report_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ADD CONSTRAINT `fk_clinical_variant_knowledge_base_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ADD CONSTRAINT `fk_clinical_variant_knowledge_base_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ADD CONSTRAINT `fk_clinical_clia_accreditation_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`audit`(`audit_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ADD CONSTRAINT `fk_clinical_clinical_consent_record_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay` ADD CONSTRAINT `fk_clinical_assay_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`performing_laboratory` ADD CONSTRAINT `fk_clinical_performing_laboratory_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`risk_assessment`(`risk_assessment_id`);

-- ========= clinical --> reagent (6 constraint(s)) =========
-- Requires: clinical schema, reagent schema
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ADD CONSTRAINT `fk_clinical_test_catalog_qc_specification_id` FOREIGN KEY (`qc_specification_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`qc_specification`(`qc_specification_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_qc_specification_id` FOREIGN KEY (`qc_specification_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`qc_specification`(`qc_specification_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ADD CONSTRAINT `fk_clinical_clinical_specimen_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ADD CONSTRAINT `fk_clinical_clinical_specimen_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`storage_location`(`storage_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ADD CONSTRAINT `fk_clinical_analytical_validation_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);

-- ========= clinical --> regulatory (16 constraint(s)) =========
-- Requires: clinical schema, regulatory schema
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ADD CONSTRAINT `fk_clinical_test_catalog_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ADD CONSTRAINT `fk_clinical_test_catalog_device_identifier_id` FOREIGN KEY (`device_identifier_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`device_identifier`(`device_identifier_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ADD CONSTRAINT `fk_clinical_test_catalog_ivd_registration_id` FOREIGN KEY (`ivd_registration_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`ivd_registration`(`ivd_registration_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_labeling_id` FOREIGN KEY (`labeling_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`labeling`(`labeling_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ADD CONSTRAINT `fk_clinical_analytical_validation_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ADD CONSTRAINT `fk_clinical_analytical_validation_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ADD CONSTRAINT `fk_clinical_report_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ADD CONSTRAINT `fk_clinical_variant_knowledge_base_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clia_accreditation` ADD CONSTRAINT `fk_clinical_clia_accreditation_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ADD CONSTRAINT `fk_clinical_clinical_consent_record_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`performing_laboratory` ADD CONSTRAINT `fk_clinical_performing_laboratory_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);

-- ========= clinical --> research (21 constraint(s)) =========
-- Requires: clinical schema, research schema
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_catalog` ADD CONSTRAINT `fk_clinical_test_catalog_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_molecular_design_id` FOREIGN KEY (`molecular_design_id`) REFERENCES `genomics_biotech_ecm`.`research`.`molecular_design`(`molecular_design_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_study_id` FOREIGN KEY (`study_id`) REFERENCES `genomics_biotech_ecm`.`research`.`study`(`study_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ADD CONSTRAINT `fk_clinical_clinical_specimen_study_id` FOREIGN KEY (`study_id`) REFERENCES `genomics_biotech_ecm`.`research`.`study`(`study_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ADD CONSTRAINT `fk_clinical_analytical_validation_assay_development_id` FOREIGN KEY (`assay_development_id`) REFERENCES `genomics_biotech_ecm`.`research`.`assay_development`(`assay_development_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ADD CONSTRAINT `fk_clinical_analytical_validation_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ADD CONSTRAINT `fk_clinical_genomic_result_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ADD CONSTRAINT `fk_clinical_genomic_result_study_id` FOREIGN KEY (`study_id`) REFERENCES `genomics_biotech_ecm`.`research`.`study`(`study_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ADD CONSTRAINT `fk_clinical_variant_interpretation_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ADD CONSTRAINT `fk_clinical_report_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ADD CONSTRAINT `fk_clinical_report_study_id` FOREIGN KEY (`study_id`) REFERENCES `genomics_biotech_ecm`.`research`.`study`(`study_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ADD CONSTRAINT `fk_clinical_variant_knowledge_base_assay_development_id` FOREIGN KEY (`assay_development_id`) REFERENCES `genomics_biotech_ecm`.`research`.`assay_development`(`assay_development_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_knowledge_base` ADD CONSTRAINT `fk_clinical_variant_knowledge_base_study_id` FOREIGN KEY (`study_id`) REFERENCES `genomics_biotech_ecm`.`research`.`study`(`study_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ADD CONSTRAINT `fk_clinical_clinical_consent_record_irb_submission_id` FOREIGN KEY (`irb_submission_id`) REFERENCES `genomics_biotech_ecm`.`research`.`irb_submission`(`irb_submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ADD CONSTRAINT `fk_clinical_clinical_consent_record_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_consent_record` ADD CONSTRAINT `fk_clinical_clinical_consent_record_study_id` FOREIGN KEY (`study_id`) REFERENCES `genomics_biotech_ecm`.`research`.`study`(`study_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_assay_development_id` FOREIGN KEY (`assay_development_id`) REFERENCES `genomics_biotech_ecm`.`research`.`assay_development`(`assay_development_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`authorized_orderer` ADD CONSTRAINT `fk_clinical_authorized_orderer_study_id` FOREIGN KEY (`study_id`) REFERENCES `genomics_biotech_ecm`.`research`.`study`(`study_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay` ADD CONSTRAINT `fk_clinical_assay_assay_development_id` FOREIGN KEY (`assay_development_id`) REFERENCES `genomics_biotech_ecm`.`research`.`assay_development`(`assay_development_id`);

-- ========= clinical --> sample (6 constraint(s)) =========
-- Requires: clinical schema, sample schema
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_aliquot_id` FOREIGN KEY (`aliquot_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`aliquot`(`aliquot_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ADD CONSTRAINT `fk_clinical_clinical_specimen_aliquot_id` FOREIGN KEY (`aliquot_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`aliquot`(`aliquot_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ADD CONSTRAINT `fk_clinical_clinical_specimen_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ADD CONSTRAINT `fk_clinical_genomic_result_extraction_id` FOREIGN KEY (`extraction_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`extraction`(`extraction_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);

-- ========= clinical --> sequencing (6 constraint(s)) =========
-- Requires: clinical schema, sequencing schema
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ADD CONSTRAINT `fk_clinical_genomic_result_library_id` FOREIGN KEY (`library_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`library`(`library_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`genomic_result` ADD CONSTRAINT `fk_clinical_genomic_result_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_run`(`sequencing_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`variant_interpretation` ADD CONSTRAINT `fk_clinical_variant_interpretation_library_id` FOREIGN KEY (`library_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`library`(`library_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`report` ADD CONSTRAINT `fk_clinical_report_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_run`(`sequencing_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_flow_cell_id` FOREIGN KEY (`flow_cell_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`flow_cell`(`flow_cell_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_run`(`sequencing_run_id`);

-- ========= clinical --> supply (11 constraint(s)) =========
-- Requires: clinical schema, supply schema
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_version` ADD CONSTRAINT `fk_clinical_assay_version_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`test_order` ADD CONSTRAINT `fk_clinical_test_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`clinical_specimen` ADD CONSTRAINT `fk_clinical_clinical_specimen_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ADD CONSTRAINT `fk_clinical_analytical_validation_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ADD CONSTRAINT `fk_clinical_analytical_validation_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`analytical_validation` ADD CONSTRAINT `fk_clinical_analytical_validation_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`clinical`.`assay_qc_run` ADD CONSTRAINT `fk_clinical_assay_qc_run_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);

-- ========= customer --> bioinformatics (2 constraint(s)) =========
-- Requires: customer schema, bioinformatics schema
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ADD CONSTRAINT `fk_customer_technical_requirement_pipeline_version_id` FOREIGN KEY (`pipeline_version_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version`(`pipeline_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ADD CONSTRAINT `fk_customer_support_case_pipeline_version_id` FOREIGN KEY (`pipeline_version_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version`(`pipeline_version_id`);

-- ========= customer --> instrument (5 constraint(s)) =========
-- Requires: customer schema, instrument schema
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ADD CONSTRAINT `fk_customer_technical_requirement_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ADD CONSTRAINT `fk_customer_accreditation_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ADD CONSTRAINT `fk_customer_installed_instrument_service_contract_id` FOREIGN KEY (`service_contract_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`service_contract`(`service_contract_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ADD CONSTRAINT `fk_customer_installed_instrument_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ADD CONSTRAINT `fk_customer_installed_instrument_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);

-- ========= customer --> order (2 constraint(s)) =========
-- Requires: customer schema, order schema
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ADD CONSTRAINT `fk_customer_technical_requirement_quotation_id` FOREIGN KEY (`quotation_id`) REFERENCES `genomics_biotech_ecm`.`order`.`quotation`(`quotation_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ADD CONSTRAINT `fk_customer_support_case_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);

-- ========= customer --> product (15 constraint(s)) =========
-- Requires: customer schema, product schema
ALTER TABLE `genomics_biotech_ecm`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ADD CONSTRAINT `fk_customer_technical_requirement_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ADD CONSTRAINT `fk_customer_technical_requirement_service_offering_id` FOREIGN KEY (`service_offering_id`) REFERENCES `genomics_biotech_ecm`.`product`.`service_offering`(`service_offering_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ADD CONSTRAINT `fk_customer_technical_requirement_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_service_offering_id` FOREIGN KEY (`service_offering_id`) REFERENCES `genomics_biotech_ecm`.`product`.`service_offering`(`service_offering_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ADD CONSTRAINT `fk_customer_accreditation_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ADD CONSTRAINT `fk_customer_accreditation_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ADD CONSTRAINT `fk_customer_installed_instrument_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ADD CONSTRAINT `fk_customer_installed_instrument_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ADD CONSTRAINT `fk_customer_installed_instrument_software_release_id` FOREIGN KEY (`software_release_id`) REFERENCES `genomics_biotech_ecm`.`product`.`software_release`(`software_release_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ADD CONSTRAINT `fk_customer_support_case_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ADD CONSTRAINT `fk_customer_support_case_software_release_id` FOREIGN KEY (`software_release_id`) REFERENCES `genomics_biotech_ecm`.`product`.`software_release`(`software_release_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ADD CONSTRAINT `fk_customer_support_case_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`specification`(`specification_id`);

-- ========= customer --> reagent (4 constraint(s)) =========
-- Requires: customer schema, reagent schema
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ADD CONSTRAINT `fk_customer_technical_requirement_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ADD CONSTRAINT `fk_customer_support_case_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ADD CONSTRAINT `fk_customer_support_case_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);

-- ========= customer --> regulatory (17 constraint(s)) =========
-- Requires: customer schema, regulatory schema
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ADD CONSTRAINT `fk_customer_technical_requirement_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ADD CONSTRAINT `fk_customer_technical_requirement_ivd_registration_id` FOREIGN KEY (`ivd_registration_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`ivd_registration`(`ivd_registration_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ADD CONSTRAINT `fk_customer_technical_requirement_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_post_market_surveillance_id` FOREIGN KEY (`post_market_surveillance_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance`(`post_market_surveillance_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ADD CONSTRAINT `fk_customer_accreditation_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ADD CONSTRAINT `fk_customer_accreditation_device_identifier_id` FOREIGN KEY (`device_identifier_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`device_identifier`(`device_identifier_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ADD CONSTRAINT `fk_customer_accreditation_ivd_registration_id` FOREIGN KEY (`ivd_registration_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`ivd_registration`(`ivd_registration_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`accreditation` ADD CONSTRAINT `fk_customer_accreditation_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ADD CONSTRAINT `fk_customer_installed_instrument_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ADD CONSTRAINT `fk_customer_installed_instrument_device_identifier_id` FOREIGN KEY (`device_identifier_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`device_identifier`(`device_identifier_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ADD CONSTRAINT `fk_customer_installed_instrument_ivd_registration_id` FOREIGN KEY (`ivd_registration_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`ivd_registration`(`ivd_registration_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ADD CONSTRAINT `fk_customer_installed_instrument_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ADD CONSTRAINT `fk_customer_support_case_adverse_event_report_id` FOREIGN KEY (`adverse_event_report_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`adverse_event_report`(`adverse_event_report_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ADD CONSTRAINT `fk_customer_support_case_field_safety_action_id` FOREIGN KEY (`field_safety_action_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`field_safety_action`(`field_safety_action_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ADD CONSTRAINT `fk_customer_support_case_post_market_surveillance_id` FOREIGN KEY (`post_market_surveillance_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance`(`post_market_surveillance_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ADD CONSTRAINT `fk_customer_support_case_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);

-- ========= customer --> research (3 constraint(s)) =========
-- Requires: customer schema, research schema
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ADD CONSTRAINT `fk_customer_technical_requirement_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);

-- ========= customer --> supply (9 constraint(s)) =========
-- Requires: customer schema, supply schema
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ADD CONSTRAINT `fk_customer_technical_requirement_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`technical_requirement` ADD CONSTRAINT `fk_customer_technical_requirement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ADD CONSTRAINT `fk_customer_installed_instrument_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ADD CONSTRAINT `fk_customer_installed_instrument_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`installed_instrument` ADD CONSTRAINT `fk_customer_installed_instrument_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ADD CONSTRAINT `fk_customer_support_case_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ADD CONSTRAINT `fk_customer_support_case_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`customer`.`support_case` ADD CONSTRAINT `fk_customer_support_case_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);

-- ========= instrument --> bioinformatics (1 constraint(s)) =========
-- Requires: instrument schema, bioinformatics schema
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ADD CONSTRAINT `fk_instrument_configuration_pipeline_version_id` FOREIGN KEY (`pipeline_version_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version`(`pipeline_version_id`);

-- ========= instrument --> clinical (6 constraint(s)) =========
-- Requires: instrument schema, clinical schema
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ADD CONSTRAINT `fk_instrument_asset_clia_accreditation_id` FOREIGN KEY (`clia_accreditation_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`clia_accreditation`(`clia_accreditation_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ADD CONSTRAINT `fk_instrument_installation_qualification_performing_laboratory_id` FOREIGN KEY (`performing_laboratory_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`performing_laboratory`(`performing_laboratory_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ADD CONSTRAINT `fk_instrument_calibration_record_performing_laboratory_id` FOREIGN KEY (`performing_laboratory_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`performing_laboratory`(`performing_laboratory_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ADD CONSTRAINT `fk_instrument_maintenance_event_performing_laboratory_id` FOREIGN KEY (`performing_laboratory_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`performing_laboratory`(`performing_laboratory_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ADD CONSTRAINT `fk_instrument_instrument_run_assay_version_id` FOREIGN KEY (`assay_version_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`assay_version`(`assay_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ADD CONSTRAINT `fk_instrument_instrument_run_performing_laboratory_id` FOREIGN KEY (`performing_laboratory_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`performing_laboratory`(`performing_laboratory_id`);

-- ========= instrument --> customer (19 constraint(s)) =========
-- Requires: instrument schema, customer schema
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ADD CONSTRAINT `fk_instrument_asset_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ADD CONSTRAINT `fk_instrument_asset_address_id` FOREIGN KEY (`address_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ADD CONSTRAINT `fk_instrument_installation_qualification_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ADD CONSTRAINT `fk_instrument_installation_qualification_address_id` FOREIGN KEY (`address_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ADD CONSTRAINT `fk_instrument_installation_qualification_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ADD CONSTRAINT `fk_instrument_calibration_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ADD CONSTRAINT `fk_instrument_pm_schedule_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ADD CONSTRAINT `fk_instrument_maintenance_event_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ADD CONSTRAINT `fk_instrument_maintenance_event_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ADD CONSTRAINT `fk_instrument_maintenance_event_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ADD CONSTRAINT `fk_instrument_field_service_request_address_id` FOREIGN KEY (`address_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ADD CONSTRAINT `fk_instrument_field_service_request_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ADD CONSTRAINT `fk_instrument_field_service_request_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ADD CONSTRAINT `fk_instrument_instrument_run_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ADD CONSTRAINT `fk_instrument_instrument_run_accreditation_id` FOREIGN KEY (`accreditation_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`accreditation`(`accreditation_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ADD CONSTRAINT `fk_instrument_service_contract_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ADD CONSTRAINT `fk_instrument_service_contract_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ADD CONSTRAINT `fk_instrument_service_contract_address_id` FOREIGN KEY (`address_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ADD CONSTRAINT `fk_instrument_configuration_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);

-- ========= instrument --> manufacturing (9 constraint(s)) =========
-- Requires: instrument schema, manufacturing schema
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ADD CONSTRAINT `fk_instrument_asset_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ADD CONSTRAINT `fk_instrument_installation_qualification_equipment_qualification_id` FOREIGN KEY (`equipment_qualification_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification`(`equipment_qualification_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ADD CONSTRAINT `fk_instrument_calibration_record_equipment_qualification_id` FOREIGN KEY (`equipment_qualification_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification`(`equipment_qualification_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ADD CONSTRAINT `fk_instrument_maintenance_event_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ADD CONSTRAINT `fk_instrument_maintenance_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_order`(`work_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ADD CONSTRAINT `fk_instrument_field_service_request_site_id` FOREIGN KEY (`site_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ADD CONSTRAINT `fk_instrument_instrument_run_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ADD CONSTRAINT `fk_instrument_instrument_run_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_order`(`work_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ADD CONSTRAINT `fk_instrument_service_contract_site_id` FOREIGN KEY (`site_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`site`(`site_id`);

-- ========= instrument --> order (1 constraint(s)) =========
-- Requires: instrument schema, order schema
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ADD CONSTRAINT `fk_instrument_service_contract_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);

-- ========= instrument --> product (9 constraint(s)) =========
-- Requires: instrument schema, product schema
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ADD CONSTRAINT `fk_instrument_asset_license_entitlement_id` FOREIGN KEY (`license_entitlement_id`) REFERENCES `genomics_biotech_ecm`.`product`.`license_entitlement`(`license_entitlement_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ADD CONSTRAINT `fk_instrument_asset_software_release_id` FOREIGN KEY (`software_release_id`) REFERENCES `genomics_biotech_ecm`.`product`.`software_release`(`software_release_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ADD CONSTRAINT `fk_instrument_model_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ADD CONSTRAINT `fk_instrument_installation_qualification_software_release_id` FOREIGN KEY (`software_release_id`) REFERENCES `genomics_biotech_ecm`.`product`.`software_release`(`software_release_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ADD CONSTRAINT `fk_instrument_field_service_request_service_offering_id` FOREIGN KEY (`service_offering_id`) REFERENCES `genomics_biotech_ecm`.`product`.`service_offering`(`service_offering_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ADD CONSTRAINT `fk_instrument_service_contract_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ADD CONSTRAINT `fk_instrument_service_contract_service_offering_id` FOREIGN KEY (`service_offering_id`) REFERENCES `genomics_biotech_ecm`.`product`.`service_offering`(`service_offering_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ADD CONSTRAINT `fk_instrument_configuration_license_entitlement_id` FOREIGN KEY (`license_entitlement_id`) REFERENCES `genomics_biotech_ecm`.`product`.`license_entitlement`(`license_entitlement_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ADD CONSTRAINT `fk_instrument_configuration_software_release_id` FOREIGN KEY (`software_release_id`) REFERENCES `genomics_biotech_ecm`.`product`.`software_release`(`software_release_id`);

-- ========= instrument --> quality (17 constraint(s)) =========
-- Requires: instrument schema, quality schema
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ADD CONSTRAINT `fk_instrument_asset_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ADD CONSTRAINT `fk_instrument_model_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ADD CONSTRAINT `fk_instrument_model_test_method_id` FOREIGN KEY (`test_method_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`test_method`(`test_method_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ADD CONSTRAINT `fk_instrument_installation_qualification_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ADD CONSTRAINT `fk_instrument_installation_qualification_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ADD CONSTRAINT `fk_instrument_calibration_record_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ADD CONSTRAINT `fk_instrument_calibration_record_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ADD CONSTRAINT `fk_instrument_pm_schedule_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ADD CONSTRAINT `fk_instrument_pm_schedule_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ADD CONSTRAINT `fk_instrument_maintenance_event_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ADD CONSTRAINT `fk_instrument_maintenance_event_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ADD CONSTRAINT `fk_instrument_field_service_request_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ADD CONSTRAINT `fk_instrument_field_service_request_complaint_id` FOREIGN KEY (`complaint_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`complaint`(`complaint_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ADD CONSTRAINT `fk_instrument_field_service_request_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ADD CONSTRAINT `fk_instrument_instrument_run_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ADD CONSTRAINT `fk_instrument_configuration_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ADD CONSTRAINT `fk_instrument_configuration_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);

-- ========= instrument --> reagent (5 constraint(s)) =========
-- Requires: instrument schema, reagent schema
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ADD CONSTRAINT `fk_instrument_installation_qualification_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ADD CONSTRAINT `fk_instrument_calibration_record_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ADD CONSTRAINT `fk_instrument_instrument_run_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ADD CONSTRAINT `fk_instrument_instrument_run_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ADD CONSTRAINT `fk_instrument_configuration_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);

-- ========= instrument --> regulatory (15 constraint(s)) =========
-- Requires: instrument schema, regulatory schema
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ADD CONSTRAINT `fk_instrument_asset_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ADD CONSTRAINT `fk_instrument_asset_device_identifier_id` FOREIGN KEY (`device_identifier_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`device_identifier`(`device_identifier_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ADD CONSTRAINT `fk_instrument_model_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ADD CONSTRAINT `fk_instrument_model_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ADD CONSTRAINT `fk_instrument_installation_qualification_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ADD CONSTRAINT `fk_instrument_installation_qualification_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ADD CONSTRAINT `fk_instrument_calibration_record_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ADD CONSTRAINT `fk_instrument_pm_schedule_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ADD CONSTRAINT `fk_instrument_maintenance_event_adverse_event_report_id` FOREIGN KEY (`adverse_event_report_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`adverse_event_report`(`adverse_event_report_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ADD CONSTRAINT `fk_instrument_maintenance_event_field_safety_action_id` FOREIGN KEY (`field_safety_action_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`field_safety_action`(`field_safety_action_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ADD CONSTRAINT `fk_instrument_maintenance_event_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ADD CONSTRAINT `fk_instrument_field_service_request_field_safety_action_id` FOREIGN KEY (`field_safety_action_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`field_safety_action`(`field_safety_action_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ADD CONSTRAINT `fk_instrument_instrument_run_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ADD CONSTRAINT `fk_instrument_configuration_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ADD CONSTRAINT `fk_instrument_configuration_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);

-- ========= instrument --> research (6 constraint(s)) =========
-- Requires: instrument schema, research schema
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ADD CONSTRAINT `fk_instrument_asset_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ADD CONSTRAINT `fk_instrument_calibration_record_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ADD CONSTRAINT `fk_instrument_maintenance_event_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ADD CONSTRAINT `fk_instrument_instrument_run_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ADD CONSTRAINT `fk_instrument_instrument_run_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ADD CONSTRAINT `fk_instrument_configuration_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);

-- ========= instrument --> sequencing (3 constraint(s)) =========
-- Requires: instrument schema, sequencing schema
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ADD CONSTRAINT `fk_instrument_maintenance_event_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_run`(`sequencing_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ADD CONSTRAINT `fk_instrument_instrument_run_flow_cell_id` FOREIGN KEY (`flow_cell_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`flow_cell`(`flow_cell_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ADD CONSTRAINT `fk_instrument_instrument_run_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_run`(`sequencing_run_id`);

-- ========= instrument --> supply (15 constraint(s)) =========
-- Requires: instrument schema, supply schema
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ADD CONSTRAINT `fk_instrument_asset_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ADD CONSTRAINT `fk_instrument_asset_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ADD CONSTRAINT `fk_instrument_model_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ADD CONSTRAINT `fk_instrument_model_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ADD CONSTRAINT `fk_instrument_installation_qualification_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ADD CONSTRAINT `fk_instrument_calibration_record_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ADD CONSTRAINT `fk_instrument_calibration_record_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ADD CONSTRAINT `fk_instrument_pm_schedule_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ADD CONSTRAINT `fk_instrument_maintenance_event_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ADD CONSTRAINT `fk_instrument_maintenance_event_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ADD CONSTRAINT `fk_instrument_maintenance_event_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ADD CONSTRAINT `fk_instrument_field_service_request_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ADD CONSTRAINT `fk_instrument_field_service_request_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ADD CONSTRAINT `fk_instrument_instrument_run_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ADD CONSTRAINT `fk_instrument_service_contract_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);

-- ========= manufacturing --> bioinformatics (6 constraint(s)) =========
-- Requires: manufacturing schema, bioinformatics schema
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ADD CONSTRAINT `fk_manufacturing_work_order_pipeline_version_id` FOREIGN KEY (`pipeline_version_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version`(`pipeline_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ADD CONSTRAINT `fk_manufacturing_production_operation_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ADD CONSTRAINT `fk_manufacturing_inprocess_qc_result_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_pipeline_version_id` FOREIGN KEY (`pipeline_version_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version`(`pipeline_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_pipeline_version_id` FOREIGN KEY (`pipeline_version_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version`(`pipeline_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ADD CONSTRAINT `fk_manufacturing_finished_goods_release_pipeline_validation_study_id` FOREIGN KEY (`pipeline_validation_study_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study`(`pipeline_validation_study_id`);

-- ========= manufacturing --> clinical (3 constraint(s)) =========
-- Requires: manufacturing schema, clinical schema
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_assay_version_id` FOREIGN KEY (`assay_version_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`assay_version`(`assay_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_analytical_validation_id` FOREIGN KEY (`analytical_validation_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`analytical_validation`(`analytical_validation_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ADD CONSTRAINT `fk_manufacturing_finished_goods_release_assay_version_id` FOREIGN KEY (`assay_version_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`assay_version`(`assay_version_id`);

-- ========= manufacturing --> customer (8 constraint(s)) =========
-- Requires: manufacturing schema, customer schema
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ADD CONSTRAINT `fk_manufacturing_work_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ADD CONSTRAINT `fk_manufacturing_work_order_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ADD CONSTRAINT `fk_manufacturing_work_order_technical_requirement_id` FOREIGN KEY (`technical_requirement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`technical_requirement`(`technical_requirement_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_installed_instrument_id` FOREIGN KEY (`installed_instrument_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`installed_instrument`(`installed_instrument_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ADD CONSTRAINT `fk_manufacturing_finished_goods_release_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ADD CONSTRAINT `fk_manufacturing_finished_goods_release_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`service_agreement`(`service_agreement_id`);

-- ========= manufacturing --> instrument (3 constraint(s)) =========
-- Requires: manufacturing schema, instrument schema
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ADD CONSTRAINT `fk_manufacturing_equipment_qualification_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment` ADD CONSTRAINT `fk_manufacturing_equipment_service_contract_id` FOREIGN KEY (`service_contract_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`service_contract`(`service_contract_id`);

-- ========= manufacturing --> order (1 constraint(s)) =========
-- Requires: manufacturing schema, order schema
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ADD CONSTRAINT `fk_manufacturing_work_order_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);

-- ========= manufacturing --> product (14 constraint(s)) =========
-- Requires: manufacturing schema, product schema
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ADD CONSTRAINT `fk_manufacturing_work_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ADD CONSTRAINT `fk_manufacturing_production_batch_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ADD CONSTRAINT `fk_manufacturing_production_batch_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_product_bom_id` FOREIGN KEY (`product_bom_id`) REFERENCES `genomics_biotech_ecm`.`product`.`product_bom`(`product_bom_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ADD CONSTRAINT `fk_manufacturing_bom_component_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ADD CONSTRAINT `fk_manufacturing_inprocess_qc_result_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ADD CONSTRAINT `fk_manufacturing_equipment_qualification_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ADD CONSTRAINT `fk_manufacturing_finished_goods_release_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ADD CONSTRAINT `fk_manufacturing_finished_goods_release_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ADD CONSTRAINT `fk_manufacturing_production_routing_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ADD CONSTRAINT `fk_manufacturing_production_routing_product_bom_id` FOREIGN KEY (`product_bom_id`) REFERENCES `genomics_biotech_ecm`.`product`.`product_bom`(`product_bom_id`);

-- ========= manufacturing --> quality (25 constraint(s)) =========
-- Requires: manufacturing schema, quality schema
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ADD CONSTRAINT `fk_manufacturing_work_order_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ADD CONSTRAINT `fk_manufacturing_work_order_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ADD CONSTRAINT `fk_manufacturing_production_batch_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ADD CONSTRAINT `fk_manufacturing_production_operation_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ADD CONSTRAINT `fk_manufacturing_inprocess_qc_result_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ADD CONSTRAINT `fk_manufacturing_inprocess_qc_result_oos_investigation_id` FOREIGN KEY (`oos_investigation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`oos_investigation`(`oos_investigation_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ADD CONSTRAINT `fk_manufacturing_inprocess_qc_result_qc_result_id` FOREIGN KEY (`qc_result_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`qc_result`(`qc_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ADD CONSTRAINT `fk_manufacturing_equipment_qualification_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ADD CONSTRAINT `fk_manufacturing_equipment_qualification_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ADD CONSTRAINT `fk_manufacturing_equipment_qualification_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ADD CONSTRAINT `fk_manufacturing_equipment_qualification_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ADD CONSTRAINT `fk_manufacturing_work_center_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ADD CONSTRAINT `fk_manufacturing_finished_goods_release_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ADD CONSTRAINT `fk_manufacturing_finished_goods_release_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ADD CONSTRAINT `fk_manufacturing_finished_goods_release_qc_result_id` FOREIGN KEY (`qc_result_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`qc_result`(`qc_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ADD CONSTRAINT `fk_manufacturing_production_routing_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);

-- ========= manufacturing --> reagent (6 constraint(s)) =========
-- Requires: manufacturing schema, reagent schema
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ADD CONSTRAINT `fk_manufacturing_bom_component_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ADD CONSTRAINT `fk_manufacturing_inprocess_qc_result_qc_specification_id` FOREIGN KEY (`qc_specification_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`qc_specification`(`qc_specification_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ADD CONSTRAINT `fk_manufacturing_inprocess_qc_result_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ADD CONSTRAINT `fk_manufacturing_equipment_qualification_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ADD CONSTRAINT `fk_manufacturing_finished_goods_release_coa_id` FOREIGN KEY (`coa_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`coa`(`coa_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ADD CONSTRAINT `fk_manufacturing_finished_goods_release_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);

-- ========= manufacturing --> regulatory (18 constraint(s)) =========
-- Requires: manufacturing schema, regulatory schema
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ADD CONSTRAINT `fk_manufacturing_work_order_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ADD CONSTRAINT `fk_manufacturing_work_order_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ADD CONSTRAINT `fk_manufacturing_production_batch_device_identifier_id` FOREIGN KEY (`device_identifier_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`device_identifier`(`device_identifier_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_device_identifier_id` FOREIGN KEY (`device_identifier_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`device_identifier`(`device_identifier_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_labeling_id` FOREIGN KEY (`labeling_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`labeling`(`labeling_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_device_identifier_id` FOREIGN KEY (`device_identifier_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`device_identifier`(`device_identifier_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ADD CONSTRAINT `fk_manufacturing_finished_goods_release_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ADD CONSTRAINT `fk_manufacturing_finished_goods_release_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ADD CONSTRAINT `fk_manufacturing_finished_goods_release_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ADD CONSTRAINT `fk_manufacturing_production_routing_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ADD CONSTRAINT `fk_manufacturing_production_routing_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`site` ADD CONSTRAINT `fk_manufacturing_site_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);

-- ========= manufacturing --> research (10 constraint(s)) =========
-- Requires: manufacturing schema, research schema
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ADD CONSTRAINT `fk_manufacturing_work_order_assay_development_id` FOREIGN KEY (`assay_development_id`) REFERENCES `genomics_biotech_ecm`.`research`.`assay_development`(`assay_development_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ADD CONSTRAINT `fk_manufacturing_work_order_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ADD CONSTRAINT `fk_manufacturing_production_batch_study_id` FOREIGN KEY (`study_id`) REFERENCES `genomics_biotech_ecm`.`research`.`study`(`study_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_assay_development_id` FOREIGN KEY (`assay_development_id`) REFERENCES `genomics_biotech_ecm`.`research`.`assay_development`(`assay_development_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_crispr_construct_id` FOREIGN KEY (`crispr_construct_id`) REFERENCES `genomics_biotech_ecm`.`research`.`crispr_construct`(`crispr_construct_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_molecular_design_id` FOREIGN KEY (`molecular_design_id`) REFERENCES `genomics_biotech_ecm`.`research`.`molecular_design`(`molecular_design_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_study_id` FOREIGN KEY (`study_id`) REFERENCES `genomics_biotech_ecm`.`research`.`study`(`study_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment_qualification` ADD CONSTRAINT `fk_manufacturing_equipment_qualification_assay_development_id` FOREIGN KEY (`assay_development_id`) REFERENCES `genomics_biotech_ecm`.`research`.`assay_development`(`assay_development_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_assay_development_id` FOREIGN KEY (`assay_development_id`) REFERENCES `genomics_biotech_ecm`.`research`.`assay_development`(`assay_development_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ADD CONSTRAINT `fk_manufacturing_production_routing_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);

-- ========= manufacturing --> sample (3 constraint(s)) =========
-- Requires: manufacturing schema, sample schema
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ADD CONSTRAINT `fk_manufacturing_inprocess_qc_result_aliquot_id` FOREIGN KEY (`aliquot_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`aliquot`(`aliquot_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`inprocess_qc_result` ADD CONSTRAINT `fk_manufacturing_inprocess_qc_result_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);

-- ========= manufacturing --> sequencing (3 constraint(s)) =========
-- Requires: manufacturing schema, sequencing schema
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_run`(`sequencing_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_sequencing_protocol_id` FOREIGN KEY (`sequencing_protocol_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol`(`sequencing_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ADD CONSTRAINT `fk_manufacturing_finished_goods_release_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_run`(`sequencing_run_id`);

-- ========= manufacturing --> supply (18 constraint(s)) =========
-- Requires: manufacturing schema, supply schema
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ADD CONSTRAINT `fk_manufacturing_work_order_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_order` ADD CONSTRAINT `fk_manufacturing_work_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ADD CONSTRAINT `fk_manufacturing_production_batch_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ADD CONSTRAINT `fk_manufacturing_production_batch_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_batch` ADD CONSTRAINT `fk_manufacturing_production_batch_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ADD CONSTRAINT `fk_manufacturing_bom_component_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ADD CONSTRAINT `fk_manufacturing_bom_component_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`bom_component` ADD CONSTRAINT `fk_manufacturing_bom_component_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_operation` ADD CONSTRAINT `fk_manufacturing_production_operation_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`work_center` ADD CONSTRAINT `fk_manufacturing_work_center_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ADD CONSTRAINT `fk_manufacturing_finished_goods_release_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release` ADD CONSTRAINT `fk_manufacturing_finished_goods_release_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`production_routing` ADD CONSTRAINT `fk_manufacturing_production_routing_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`manufacturing`.`equipment` ADD CONSTRAINT `fk_manufacturing_equipment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);

-- ========= order --> bioinformatics (2 constraint(s)) =========
-- Requires: order schema, bioinformatics schema
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_pipeline_version_id` FOREIGN KEY (`pipeline_version_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version`(`pipeline_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ADD CONSTRAINT `fk_order_quotation_line_pipeline_id` FOREIGN KEY (`pipeline_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`pipeline`(`pipeline_id`);

-- ========= order --> clinical (13 constraint(s)) =========
-- Requires: order schema, clinical schema
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_test_order_id` FOREIGN KEY (`test_order_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_order`(`test_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ADD CONSTRAINT `fk_order_quotation_performing_laboratory_id` FOREIGN KEY (`performing_laboratory_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`performing_laboratory`(`performing_laboratory_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ADD CONSTRAINT `fk_order_quotation_line_assay_version_id` FOREIGN KEY (`assay_version_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`assay_version`(`assay_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ADD CONSTRAINT `fk_order_quotation_line_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ADD CONSTRAINT `fk_order_delivery_line_test_order_id` FOREIGN KEY (`test_order_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_order`(`test_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_test_order_id` FOREIGN KEY (`test_order_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_order`(`test_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_performing_laboratory_id` FOREIGN KEY (`performing_laboratory_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`performing_laboratory`(`performing_laboratory_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_test_order_id` FOREIGN KEY (`test_order_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_order`(`test_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ADD CONSTRAINT `fk_order_status_event_test_order_id` FOREIGN KEY (`test_order_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_order`(`test_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ADD CONSTRAINT `fk_order_fulfillment_instruction_performing_laboratory_id` FOREIGN KEY (`performing_laboratory_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`performing_laboratory`(`performing_laboratory_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ADD CONSTRAINT `fk_order_fulfillment_instruction_test_order_id` FOREIGN KEY (`test_order_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_order`(`test_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ADD CONSTRAINT `fk_order_credit_memo_test_order_id` FOREIGN KEY (`test_order_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_order`(`test_order_id`);

-- ========= order --> customer (18 constraint(s)) =========
-- Requires: order schema, customer schema
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_header_bill_to_party_account_id` FOREIGN KEY (`header_bill_to_party_account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_header_customer_account_id` FOREIGN KEY (`header_customer_account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_header_sold_to_party_account_id` FOREIGN KEY (`header_sold_to_party_account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_accreditation_id` FOREIGN KEY (`accreditation_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`accreditation`(`accreditation_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ADD CONSTRAINT `fk_order_quotation_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ADD CONSTRAINT `fk_order_quotation_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_address_id` FOREIGN KEY (`address_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_address_id` FOREIGN KEY (`address_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_installed_instrument_id` FOREIGN KEY (`installed_instrument_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`installed_instrument`(`installed_instrument_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ADD CONSTRAINT `fk_order_status_event_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ADD CONSTRAINT `fk_order_fulfillment_instruction_address_id` FOREIGN KEY (`address_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ADD CONSTRAINT `fk_order_credit_memo_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ADD CONSTRAINT `fk_order_customer_po_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ADD CONSTRAINT `fk_order_customer_po_address_id` FOREIGN KEY (`address_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`address`(`address_id`);

-- ========= order --> instrument (7 constraint(s)) =========
-- Requires: order schema, instrument schema
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ADD CONSTRAINT `fk_order_quotation_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ADD CONSTRAINT `fk_order_quotation_line_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ADD CONSTRAINT `fk_order_fulfillment_instruction_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ADD CONSTRAINT `fk_order_fulfillment_instruction_installation_qualification_id` FOREIGN KEY (`installation_qualification_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`installation_qualification`(`installation_qualification_id`);

-- ========= order --> manufacturing (10 constraint(s)) =========
-- Requires: order schema, manufacturing schema
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_order`(`work_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ADD CONSTRAINT `fk_order_quotation_line_manufacturing_bom_id` FOREIGN KEY (`manufacturing_bom_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`manufacturing_bom`(`manufacturing_bom_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ADD CONSTRAINT `fk_order_quotation_line_production_routing_id` FOREIGN KEY (`production_routing_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_routing`(`production_routing_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_finished_goods_release_id` FOREIGN KEY (`finished_goods_release_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`finished_goods_release`(`finished_goods_release_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ADD CONSTRAINT `fk_order_delivery_line_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ADD CONSTRAINT `fk_order_delivery_line_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ADD CONSTRAINT `fk_order_fulfillment_instruction_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_order`(`work_order_id`);

-- ========= order --> product (17 constraint(s)) =========
-- Requires: order schema, product schema
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_service_offering_id` FOREIGN KEY (`service_offering_id`) REFERENCES `genomics_biotech_ecm`.`product`.`service_offering`(`service_offering_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_pricing_id` FOREIGN KEY (`pricing_id`) REFERENCES `genomics_biotech_ecm`.`product`.`pricing`(`pricing_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_service_offering_id` FOREIGN KEY (`service_offering_id`) REFERENCES `genomics_biotech_ecm`.`product`.`service_offering`(`service_offering_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_software_release_id` FOREIGN KEY (`software_release_id`) REFERENCES `genomics_biotech_ecm`.`product`.`software_release`(`software_release_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ADD CONSTRAINT `fk_order_quotation_service_offering_id` FOREIGN KEY (`service_offering_id`) REFERENCES `genomics_biotech_ecm`.`product`.`service_offering`(`service_offering_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ADD CONSTRAINT `fk_order_quotation_line_pricing_id` FOREIGN KEY (`pricing_id`) REFERENCES `genomics_biotech_ecm`.`product`.`pricing`(`pricing_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ADD CONSTRAINT `fk_order_quotation_line_service_offering_id` FOREIGN KEY (`service_offering_id`) REFERENCES `genomics_biotech_ecm`.`product`.`service_offering`(`service_offering_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ADD CONSTRAINT `fk_order_quotation_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ADD CONSTRAINT `fk_order_quotation_line_software_release_id` FOREIGN KEY (`software_release_id`) REFERENCES `genomics_biotech_ecm`.`product`.`software_release`(`software_release_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ADD CONSTRAINT `fk_order_delivery_line_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ADD CONSTRAINT `fk_order_delivery_line_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ADD CONSTRAINT `fk_order_fulfillment_instruction_service_offering_id` FOREIGN KEY (`service_offering_id`) REFERENCES `genomics_biotech_ecm`.`product`.`service_offering`(`service_offering_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ADD CONSTRAINT `fk_order_fulfillment_instruction_software_release_id` FOREIGN KEY (`software_release_id`) REFERENCES `genomics_biotech_ecm`.`product`.`software_release`(`software_release_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ADD CONSTRAINT `fk_order_credit_memo_pricing_id` FOREIGN KEY (`pricing_id`) REFERENCES `genomics_biotech_ecm`.`product`.`pricing`(`pricing_id`);

-- ========= order --> quality (21 constraint(s)) =========
-- Requires: order schema, quality schema
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ADD CONSTRAINT `fk_order_quotation_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ADD CONSTRAINT `fk_order_quotation_line_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_complaint_id` FOREIGN KEY (`complaint_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`complaint`(`complaint_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ADD CONSTRAINT `fk_order_delivery_line_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ADD CONSTRAINT `fk_order_delivery_line_qc_result_id` FOREIGN KEY (`qc_result_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`qc_result`(`qc_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_complaint_id` FOREIGN KEY (`complaint_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`complaint`(`complaint_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ADD CONSTRAINT `fk_order_status_event_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ADD CONSTRAINT `fk_order_fulfillment_instruction_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ADD CONSTRAINT `fk_order_credit_memo_complaint_id` FOREIGN KEY (`complaint_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`complaint`(`complaint_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ADD CONSTRAINT `fk_order_credit_memo_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ADD CONSTRAINT `fk_order_credit_memo_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`nonconformance`(`nonconformance_id`);

-- ========= order --> reagent (14 constraint(s)) =========
-- Requires: order schema, reagent schema
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_qc_specification_id` FOREIGN KEY (`qc_specification_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`qc_specification`(`qc_specification_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ADD CONSTRAINT `fk_order_quotation_line_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ADD CONSTRAINT `fk_order_delivery_line_coa_id` FOREIGN KEY (`coa_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`coa`(`coa_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ADD CONSTRAINT `fk_order_delivery_line_inventory_transaction_id` FOREIGN KEY (`inventory_transaction_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`inventory_transaction`(`inventory_transaction_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ADD CONSTRAINT `fk_order_delivery_line_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ADD CONSTRAINT `fk_order_delivery_line_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`storage_location`(`storage_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_inventory_transaction_id` FOREIGN KEY (`inventory_transaction_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`inventory_transaction`(`inventory_transaction_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_coa_id` FOREIGN KEY (`coa_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`coa`(`coa_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`storage_location`(`storage_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ADD CONSTRAINT `fk_order_fulfillment_instruction_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ADD CONSTRAINT `fk_order_fulfillment_instruction_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`storage_location`(`storage_location_id`);

-- ========= order --> regulatory (13 constraint(s)) =========
-- Requires: order schema, regulatory schema
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_labeling_id` FOREIGN KEY (`labeling_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`labeling`(`labeling_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ADD CONSTRAINT `fk_order_quotation_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ADD CONSTRAINT `fk_order_quotation_line_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ADD CONSTRAINT `fk_order_delivery_line_device_identifier_id` FOREIGN KEY (`device_identifier_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`device_identifier`(`device_identifier_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ADD CONSTRAINT `fk_order_delivery_line_labeling_id` FOREIGN KEY (`labeling_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`labeling`(`labeling_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_field_safety_action_id` FOREIGN KEY (`field_safety_action_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`field_safety_action`(`field_safety_action_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ADD CONSTRAINT `fk_order_fulfillment_instruction_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ADD CONSTRAINT `fk_order_credit_memo_field_safety_action_id` FOREIGN KEY (`field_safety_action_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`field_safety_action`(`field_safety_action_id`);

-- ========= order --> research (12 constraint(s)) =========
-- Requires: order schema, research schema
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_collaboration_agreement_id` FOREIGN KEY (`collaboration_agreement_id`) REFERENCES `genomics_biotech_ecm`.`research`.`collaboration_agreement`(`collaboration_agreement_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_assay_development_id` FOREIGN KEY (`assay_development_id`) REFERENCES `genomics_biotech_ecm`.`research`.`assay_development`(`assay_development_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_crispr_construct_id` FOREIGN KEY (`crispr_construct_id`) REFERENCES `genomics_biotech_ecm`.`research`.`crispr_construct`(`crispr_construct_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `genomics_biotech_ecm`.`research`.`grant`(`grant_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_molecular_design_id` FOREIGN KEY (`molecular_design_id`) REFERENCES `genomics_biotech_ecm`.`research`.`molecular_design`(`molecular_design_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ADD CONSTRAINT `fk_order_quotation_collaboration_agreement_id` FOREIGN KEY (`collaboration_agreement_id`) REFERENCES `genomics_biotech_ecm`.`research`.`collaboration_agreement`(`collaboration_agreement_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ADD CONSTRAINT `fk_order_quotation_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ADD CONSTRAINT `fk_order_quotation_line_crispr_construct_id` FOREIGN KEY (`crispr_construct_id`) REFERENCES `genomics_biotech_ecm`.`research`.`crispr_construct`(`crispr_construct_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ADD CONSTRAINT `fk_order_quotation_line_molecular_design_id` FOREIGN KEY (`molecular_design_id`) REFERENCES `genomics_biotech_ecm`.`research`.`molecular_design`(`molecular_design_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ADD CONSTRAINT `fk_order_customer_po_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);

-- ========= order --> sequencing (9 constraint(s)) =========
-- Requires: order schema, sequencing schema
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_library_id` FOREIGN KEY (`library_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`library`(`library_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_sequencing_protocol_id` FOREIGN KEY (`sequencing_protocol_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol`(`sequencing_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ADD CONSTRAINT `fk_order_quotation_line_sequencing_protocol_id` FOREIGN KEY (`sequencing_protocol_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol`(`sequencing_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_run`(`sequencing_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ADD CONSTRAINT `fk_order_status_event_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_run`(`sequencing_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ADD CONSTRAINT `fk_order_fulfillment_instruction_flow_cell_id` FOREIGN KEY (`flow_cell_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`flow_cell`(`flow_cell_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ADD CONSTRAINT `fk_order_fulfillment_instruction_library_prep_run_id` FOREIGN KEY (`library_prep_run_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`library_prep_run`(`library_prep_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ADD CONSTRAINT `fk_order_fulfillment_instruction_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_run`(`sequencing_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ADD CONSTRAINT `fk_order_credit_memo_sequencing_run_id` FOREIGN KEY (`sequencing_run_id`) REFERENCES `genomics_biotech_ecm`.`sequencing`.`sequencing_run`(`sequencing_run_id`);

-- ========= order --> supply (18 constraint(s)) =========
-- Requires: order schema, supply schema
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ADD CONSTRAINT `fk_order_quotation_line_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ADD CONSTRAINT `fk_order_quotation_line_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ADD CONSTRAINT `fk_order_delivery_line_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ADD CONSTRAINT `fk_order_delivery_line_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ADD CONSTRAINT `fk_order_delivery_line_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ADD CONSTRAINT `fk_order_status_event_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ADD CONSTRAINT `fk_order_fulfillment_instruction_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ADD CONSTRAINT `fk_order_fulfillment_instruction_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`warehouse_location`(`warehouse_location_id`);

-- ========= product --> instrument (3 constraint(s)) =========
-- Requires: product schema, instrument schema
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ADD CONSTRAINT `fk_product_software_release_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ADD CONSTRAINT `fk_product_license_entitlement_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ADD CONSTRAINT `fk_product_service_offering_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);

-- ========= product --> manufacturing (1 constraint(s)) =========
-- Requires: product schema, manufacturing schema
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ADD CONSTRAINT `fk_product_catalog_item_site_id` FOREIGN KEY (`site_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`site`(`site_id`);

-- ========= product --> quality (11 constraint(s)) =========
-- Requires: product schema, quality schema
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ADD CONSTRAINT `fk_product_specification_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ADD CONSTRAINT `fk_product_specification_test_method_id` FOREIGN KEY (`test_method_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`test_method`(`test_method_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ADD CONSTRAINT `fk_product_specification_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ADD CONSTRAINT `fk_product_product_bom_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ADD CONSTRAINT `fk_product_product_bom_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ADD CONSTRAINT `fk_product_regulatory_classification_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ADD CONSTRAINT `fk_product_software_release_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ADD CONSTRAINT `fk_product_software_release_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ADD CONSTRAINT `fk_product_software_release_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ADD CONSTRAINT `fk_product_service_offering_training_curriculum_id` FOREIGN KEY (`training_curriculum_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`training_curriculum`(`training_curriculum_id`);

-- ========= product --> regulatory (8 constraint(s)) =========
-- Requires: product schema, regulatory schema
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ADD CONSTRAINT `fk_product_catalog_item_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ADD CONSTRAINT `fk_product_specification_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ADD CONSTRAINT `fk_product_regulatory_classification_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ADD CONSTRAINT `fk_product_software_release_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ADD CONSTRAINT `fk_product_software_release_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`license_entitlement` ADD CONSTRAINT `fk_product_license_entitlement_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ADD CONSTRAINT `fk_product_service_offering_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`bundle` ADD CONSTRAINT `fk_product_bundle_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);

-- ========= product --> research (8 constraint(s)) =========
-- Requires: product schema, research schema
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ADD CONSTRAINT `fk_product_catalog_item_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`family` ADD CONSTRAINT `fk_product_family_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ADD CONSTRAINT `fk_product_specification_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`specification` ADD CONSTRAINT `fk_product_specification_study_id` FOREIGN KEY (`study_id`) REFERENCES `genomics_biotech_ecm`.`research`.`study`(`study_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ADD CONSTRAINT `fk_product_product_bom_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`software_release` ADD CONSTRAINT `fk_product_software_release_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ADD CONSTRAINT `fk_product_service_offering_assay_development_id` FOREIGN KEY (`assay_development_id`) REFERENCES `genomics_biotech_ecm`.`research`.`assay_development`(`assay_development_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ADD CONSTRAINT `fk_product_service_offering_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);

-- ========= product --> supply (10 constraint(s)) =========
-- Requires: product schema, supply schema
ALTER TABLE `genomics_biotech_ecm`.`product`.`catalog_item` ADD CONSTRAINT `fk_product_catalog_item_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ADD CONSTRAINT `fk_product_product_bom_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`product_bom` ADD CONSTRAINT `fk_product_product_bom_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`bom_line` ADD CONSTRAINT `fk_product_bom_line_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`pricing` ADD CONSTRAINT `fk_product_pricing_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`regulatory_classification` ADD CONSTRAINT `fk_product_regulatory_classification_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`product`.`service_offering` ADD CONSTRAINT `fk_product_service_offering_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);

-- ========= quality --> customer (17 constraint(s)) =========
-- Requires: quality schema, customer schema
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_installed_instrument_id` FOREIGN KEY (`installed_instrument_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`installed_instrument`(`installed_instrument_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ADD CONSTRAINT `fk_quality_deviation_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ADD CONSTRAINT `fk_quality_deviation_installed_instrument_id` FOREIGN KEY (`installed_instrument_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`installed_instrument`(`installed_instrument_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_accreditation_id` FOREIGN KEY (`accreditation_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`accreditation`(`accreditation_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_record` ADD CONSTRAINT `fk_quality_training_record_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_installed_instrument_id` FOREIGN KEY (`installed_instrument_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`installed_instrument`(`installed_instrument_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_installed_instrument_id` FOREIGN KEY (`installed_instrument_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`installed_instrument`(`installed_instrument_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_installed_instrument_id` FOREIGN KEY (`installed_instrument_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`installed_instrument`(`installed_instrument_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_support_case_id` FOREIGN KEY (`support_case_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`support_case`(`support_case_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ADD CONSTRAINT `fk_quality_validation_study_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ADD CONSTRAINT `fk_quality_validation_study_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);

-- ========= quality --> instrument (4 constraint(s)) =========
-- Requires: quality schema, instrument schema
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ADD CONSTRAINT `fk_quality_deviation_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);

-- ========= quality --> manufacturing (5 constraint(s)) =========
-- Requires: quality schema, manufacturing schema
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_site_id` FOREIGN KEY (`site_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ADD CONSTRAINT `fk_quality_validation_study_production_routing_id` FOREIGN KEY (`production_routing_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_routing`(`production_routing_id`);

-- ========= quality --> product (11 constraint(s)) =========
-- Requires: quality schema, product schema
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ADD CONSTRAINT `fk_quality_deviation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ADD CONSTRAINT `fk_quality_controlled_document_family_id` FOREIGN KEY (`family_id`) REFERENCES `genomics_biotech_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ADD CONSTRAINT `fk_quality_validation_study_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`risk_assessment` ADD CONSTRAINT `fk_quality_risk_assessment_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);

-- ========= quality --> reagent (4 constraint(s)) =========
-- Requires: quality schema, reagent schema
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);

-- ========= quality --> regulatory (22 constraint(s)) =========
-- Requires: quality schema, regulatory schema
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ADD CONSTRAINT `fk_quality_deviation_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ADD CONSTRAINT `fk_quality_controlled_document_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`controlled_document` ADD CONSTRAINT `fk_quality_controlled_document_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`training_curriculum` ADD CONSTRAINT `fk_quality_training_curriculum_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_adverse_event_report_id` FOREIGN KEY (`adverse_event_report_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`adverse_event_report`(`adverse_event_report_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ADD CONSTRAINT `fk_quality_validation_study_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ADD CONSTRAINT `fk_quality_validation_study_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`test_method` ADD CONSTRAINT `fk_quality_test_method_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`test_method` ADD CONSTRAINT `fk_quality_test_method_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);

-- ========= quality --> sample (2 constraint(s)) =========
-- Requires: quality schema, sample schema
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);

-- ========= quality --> supply (32 constraint(s)) =========
-- Requires: quality schema, supply schema
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ADD CONSTRAINT `fk_quality_deviation_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ADD CONSTRAINT `fk_quality_deviation_inbound_delivery_id` FOREIGN KEY (`inbound_delivery_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`inbound_delivery`(`inbound_delivery_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ADD CONSTRAINT `fk_quality_deviation_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ADD CONSTRAINT `fk_quality_deviation_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`deviation` ADD CONSTRAINT `fk_quality_deviation_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_inbound_delivery_id` FOREIGN KEY (`inbound_delivery_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`inbound_delivery`(`inbound_delivery_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_inbound_delivery_id` FOREIGN KEY (`inbound_delivery_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`inbound_delivery`(`inbound_delivery_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`qc_result` ADD CONSTRAINT `fk_quality_qc_result_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ADD CONSTRAINT `fk_quality_validation_study_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ADD CONSTRAINT `fk_quality_validation_study_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`validation_study` ADD CONSTRAINT `fk_quality_validation_study_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`risk_assessment` ADD CONSTRAINT `fk_quality_risk_assessment_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`risk_assessment` ADD CONSTRAINT `fk_quality_risk_assessment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`quality`.`test_method` ADD CONSTRAINT `fk_quality_test_method_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);

-- ========= reagent --> bioinformatics (1 constraint(s)) =========
-- Requires: reagent schema, bioinformatics schema
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ADD CONSTRAINT `fk_reagent_qc_specification_pipeline_version_id` FOREIGN KEY (`pipeline_version_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version`(`pipeline_version_id`);

-- ========= reagent --> clinical (1 constraint(s)) =========
-- Requires: reagent schema, clinical schema
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ADD CONSTRAINT `fk_reagent_dispensing_event_clinical_specimen_id` FOREIGN KEY (`clinical_specimen_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`clinical_specimen`(`clinical_specimen_id`);

-- ========= reagent --> customer (11 constraint(s)) =========
-- Requires: reagent schema, customer schema
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ADD CONSTRAINT `fk_reagent_lot_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ADD CONSTRAINT `fk_reagent_coa_accreditation_id` FOREIGN KEY (`accreditation_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`accreditation`(`accreditation_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ADD CONSTRAINT `fk_reagent_coa_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ADD CONSTRAINT `fk_reagent_coa_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ADD CONSTRAINT `fk_reagent_coa_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ADD CONSTRAINT `fk_reagent_inventory_balance_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ADD CONSTRAINT `fk_reagent_inventory_balance_address_id` FOREIGN KEY (`address_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ADD CONSTRAINT `fk_reagent_dispensing_event_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ADD CONSTRAINT `fk_reagent_dispensing_event_address_id` FOREIGN KEY (`address_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ADD CONSTRAINT `fk_reagent_dispensing_event_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ADD CONSTRAINT `fk_reagent_qc_specification_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);

-- ========= reagent --> instrument (3 constraint(s)) =========
-- Requires: reagent schema, instrument schema
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ADD CONSTRAINT `fk_reagent_dispensing_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ADD CONSTRAINT `fk_reagent_qc_specification_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ADD CONSTRAINT `fk_reagent_inventory_transaction_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);

-- ========= reagent --> manufacturing (8 constraint(s)) =========
-- Requires: reagent schema, manufacturing schema
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ADD CONSTRAINT `fk_reagent_lot_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ADD CONSTRAINT `fk_reagent_lot_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_order`(`work_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ADD CONSTRAINT `fk_reagent_coa_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ADD CONSTRAINT `fk_reagent_storage_location_site_id` FOREIGN KEY (`site_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ADD CONSTRAINT `fk_reagent_dispensing_event_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ADD CONSTRAINT `fk_reagent_dispensing_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_order`(`work_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ADD CONSTRAINT `fk_reagent_qc_specification_production_routing_id` FOREIGN KEY (`production_routing_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_routing`(`production_routing_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ADD CONSTRAINT `fk_reagent_inventory_transaction_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);

-- ========= reagent --> product (12 constraint(s)) =========
-- Requires: reagent schema, product schema
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ADD CONSTRAINT `fk_reagent_catalog_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ADD CONSTRAINT `fk_reagent_catalog_family_id` FOREIGN KEY (`family_id`) REFERENCES `genomics_biotech_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ADD CONSTRAINT `fk_reagent_lot_product_bom_id` FOREIGN KEY (`product_bom_id`) REFERENCES `genomics_biotech_ecm`.`product`.`product_bom`(`product_bom_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ADD CONSTRAINT `fk_reagent_lot_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ADD CONSTRAINT `fk_reagent_coa_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ADD CONSTRAINT `fk_reagent_inventory_balance_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ADD CONSTRAINT `fk_reagent_dispensing_event_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ADD CONSTRAINT `fk_reagent_qc_specification_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ADD CONSTRAINT `fk_reagent_qc_specification_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ADD CONSTRAINT `fk_reagent_kit_component_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ADD CONSTRAINT `fk_reagent_kit_component_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ADD CONSTRAINT `fk_reagent_inventory_transaction_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);

-- ========= reagent --> quality (8 constraint(s)) =========
-- Requires: reagent schema, quality schema
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ADD CONSTRAINT `fk_reagent_catalog_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ADD CONSTRAINT `fk_reagent_coa_qc_result_id` FOREIGN KEY (`qc_result_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`qc_result`(`qc_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ADD CONSTRAINT `fk_reagent_qc_specification_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ADD CONSTRAINT `fk_reagent_qc_specification_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ADD CONSTRAINT `fk_reagent_qc_specification_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ADD CONSTRAINT `fk_reagent_qc_specification_test_method_id` FOREIGN KEY (`test_method_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`test_method`(`test_method_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ADD CONSTRAINT `fk_reagent_kit_component_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ADD CONSTRAINT `fk_reagent_kit_component_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);

-- ========= reagent --> regulatory (10 constraint(s)) =========
-- Requires: reagent schema, regulatory schema
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ADD CONSTRAINT `fk_reagent_catalog_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ADD CONSTRAINT `fk_reagent_catalog_device_identifier_id` FOREIGN KEY (`device_identifier_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`device_identifier`(`device_identifier_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ADD CONSTRAINT `fk_reagent_catalog_labeling_id` FOREIGN KEY (`labeling_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`labeling`(`labeling_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ADD CONSTRAINT `fk_reagent_lot_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ADD CONSTRAINT `fk_reagent_lot_labeling_id` FOREIGN KEY (`labeling_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`labeling`(`labeling_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ADD CONSTRAINT `fk_reagent_lot_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ADD CONSTRAINT `fk_reagent_storage_location_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ADD CONSTRAINT `fk_reagent_qc_specification_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ADD CONSTRAINT `fk_reagent_qc_specification_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ADD CONSTRAINT `fk_reagent_inventory_transaction_field_safety_action_id` FOREIGN KEY (`field_safety_action_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`field_safety_action`(`field_safety_action_id`);

-- ========= reagent --> research (11 constraint(s)) =========
-- Requires: reagent schema, research schema
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ADD CONSTRAINT `fk_reagent_catalog_assay_development_id` FOREIGN KEY (`assay_development_id`) REFERENCES `genomics_biotech_ecm`.`research`.`assay_development`(`assay_development_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ADD CONSTRAINT `fk_reagent_catalog_molecular_design_id` FOREIGN KEY (`molecular_design_id`) REFERENCES `genomics_biotech_ecm`.`research`.`molecular_design`(`molecular_design_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ADD CONSTRAINT `fk_reagent_catalog_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ADD CONSTRAINT `fk_reagent_lot_crispr_construct_id` FOREIGN KEY (`crispr_construct_id`) REFERENCES `genomics_biotech_ecm`.`research`.`crispr_construct`(`crispr_construct_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ADD CONSTRAINT `fk_reagent_lot_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ADD CONSTRAINT `fk_reagent_lot_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`coa` ADD CONSTRAINT `fk_reagent_coa_assay_development_id` FOREIGN KEY (`assay_development_id`) REFERENCES `genomics_biotech_ecm`.`research`.`assay_development`(`assay_development_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ADD CONSTRAINT `fk_reagent_dispensing_event_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`dispensing_event` ADD CONSTRAINT `fk_reagent_dispensing_event_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`kit_component` ADD CONSTRAINT `fk_reagent_kit_component_assay_development_id` FOREIGN KEY (`assay_development_id`) REFERENCES `genomics_biotech_ecm`.`research`.`assay_development`(`assay_development_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ADD CONSTRAINT `fk_reagent_inventory_transaction_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);

-- ========= reagent --> supply (10 constraint(s)) =========
-- Requires: reagent schema, supply schema
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`catalog` ADD CONSTRAINT `fk_reagent_catalog_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ADD CONSTRAINT `fk_reagent_lot_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ADD CONSTRAINT `fk_reagent_lot_inbound_delivery_id` FOREIGN KEY (`inbound_delivery_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`inbound_delivery`(`inbound_delivery_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`lot` ADD CONSTRAINT `fk_reagent_lot_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`storage_location` ADD CONSTRAINT `fk_reagent_storage_location_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ADD CONSTRAINT `fk_reagent_inventory_balance_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_balance` ADD CONSTRAINT `fk_reagent_inventory_balance_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`qc_specification` ADD CONSTRAINT `fk_reagent_qc_specification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ADD CONSTRAINT `fk_reagent_inventory_transaction_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`reagent`.`inventory_transaction` ADD CONSTRAINT `fk_reagent_inventory_transaction_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);

-- ========= regulatory --> manufacturing (2 constraint(s)) =========
-- Requires: regulatory schema, manufacturing schema
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ADD CONSTRAINT `fk_regulatory_adverse_event_report_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ADD CONSTRAINT `fk_regulatory_field_safety_action_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);

-- ========= regulatory --> product (5 constraint(s)) =========
-- Requires: regulatory schema, product schema
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ADD CONSTRAINT `fk_regulatory_document_family_id` FOREIGN KEY (`family_id`) REFERENCES `genomics_biotech_ecm`.`product`.`family`(`family_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ADD CONSTRAINT `fk_regulatory_labeling_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ADD CONSTRAINT `fk_regulatory_post_market_surveillance_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ADD CONSTRAINT `fk_regulatory_field_safety_action_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ADD CONSTRAINT `fk_regulatory_device_identifier_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);

-- ========= regulatory --> quality (4 constraint(s)) =========
-- Requires: regulatory schema, quality schema
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ADD CONSTRAINT `fk_regulatory_document_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ADD CONSTRAINT `fk_regulatory_labeling_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ADD CONSTRAINT `fk_regulatory_adverse_event_report_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ADD CONSTRAINT `fk_regulatory_field_safety_action_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);

-- ========= research --> bioinformatics (4 constraint(s)) =========
-- Requires: research schema, bioinformatics schema
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ADD CONSTRAINT `fk_research_experiment_pipeline_validation_study_id` FOREIGN KEY (`pipeline_validation_study_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`pipeline_validation_study`(`pipeline_validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ADD CONSTRAINT `fk_research_experiment_pipeline_version_id` FOREIGN KEY (`pipeline_version_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version`(`pipeline_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ADD CONSTRAINT `fk_research_spend_compute_job_id` FOREIGN KEY (`compute_job_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`compute_job`(`compute_job_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ADD CONSTRAINT `fk_research_publication_pipeline_version_id` FOREIGN KEY (`pipeline_version_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`pipeline_version`(`pipeline_version_id`);

-- ========= research --> customer (7 constraint(s)) =========
-- Requires: research schema, customer schema
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ADD CONSTRAINT `fk_research_project_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ADD CONSTRAINT `fk_research_experiment_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ADD CONSTRAINT `fk_research_research_protocol_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ADD CONSTRAINT `fk_research_assay_development_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ADD CONSTRAINT `fk_research_collaboration_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ADD CONSTRAINT `fk_research_irb_submission_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ADD CONSTRAINT `fk_research_publication_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);

-- ========= research --> instrument (4 constraint(s)) =========
-- Requires: research schema, instrument schema
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ADD CONSTRAINT `fk_research_experiment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ADD CONSTRAINT `fk_research_experiment_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`configuration`(`configuration_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ADD CONSTRAINT `fk_research_assay_development_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ADD CONSTRAINT `fk_research_spend_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);

-- ========= research --> order (1 constraint(s)) =========
-- Requires: research schema, order schema
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ADD CONSTRAINT `fk_research_spend_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);

-- ========= research --> product (3 constraint(s)) =========
-- Requires: research schema, product schema
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ADD CONSTRAINT `fk_research_experiment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ADD CONSTRAINT `fk_research_assay_development_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ADD CONSTRAINT `fk_research_spend_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);

-- ========= research --> quality (17 constraint(s)) =========
-- Requires: research schema, quality schema
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ADD CONSTRAINT `fk_research_milestone_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ADD CONSTRAINT `fk_research_milestone_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ADD CONSTRAINT `fk_research_experiment_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ADD CONSTRAINT `fk_research_experiment_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ADD CONSTRAINT `fk_research_experiment_test_method_id` FOREIGN KEY (`test_method_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`test_method`(`test_method_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ADD CONSTRAINT `fk_research_research_protocol_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ADD CONSTRAINT `fk_research_research_protocol_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ADD CONSTRAINT `fk_research_research_protocol_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ADD CONSTRAINT `fk_research_research_protocol_training_curriculum_id` FOREIGN KEY (`training_curriculum_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`training_curriculum`(`training_curriculum_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ADD CONSTRAINT `fk_research_crispr_construct_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ADD CONSTRAINT `fk_research_assay_development_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ADD CONSTRAINT `fk_research_assay_development_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ADD CONSTRAINT `fk_research_assay_development_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ADD CONSTRAINT `fk_research_assay_development_test_method_id` FOREIGN KEY (`test_method_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`test_method`(`test_method_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ADD CONSTRAINT `fk_research_assay_development_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ADD CONSTRAINT `fk_research_irb_submission_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`audit`(`audit_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`study` ADD CONSTRAINT `fk_research_study_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`risk_assessment`(`risk_assessment_id`);

-- ========= research --> regulatory (21 constraint(s)) =========
-- Requires: research schema, regulatory schema
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ADD CONSTRAINT `fk_research_project_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ADD CONSTRAINT `fk_research_milestone_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ADD CONSTRAINT `fk_research_milestone_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`milestone` ADD CONSTRAINT `fk_research_milestone_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ADD CONSTRAINT `fk_research_experiment_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ADD CONSTRAINT `fk_research_experiment_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ADD CONSTRAINT `fk_research_research_protocol_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`research_protocol` ADD CONSTRAINT `fk_research_research_protocol_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ADD CONSTRAINT `fk_research_assay_development_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ADD CONSTRAINT `fk_research_assay_development_device_identifier_id` FOREIGN KEY (`device_identifier_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`device_identifier`(`device_identifier_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ADD CONSTRAINT `fk_research_assay_development_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ADD CONSTRAINT `fk_research_collaboration_agreement_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`collaboration_agreement` ADD CONSTRAINT `fk_research_collaboration_agreement_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`irb_submission` ADD CONSTRAINT `fk_research_irb_submission_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`ip_disclosure` ADD CONSTRAINT `fk_research_ip_disclosure_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ADD CONSTRAINT `fk_research_publication_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ADD CONSTRAINT `fk_research_publication_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`publication` ADD CONSTRAINT `fk_research_publication_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`grant` ADD CONSTRAINT `fk_research_grant_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`study` ADD CONSTRAINT `fk_research_study_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`study` ADD CONSTRAINT `fk_research_study_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);

-- ========= research --> sample (1 constraint(s)) =========
-- Requires: research schema, sample schema
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ADD CONSTRAINT `fk_research_experiment_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);

-- ========= research --> supply (13 constraint(s)) =========
-- Requires: research schema, supply schema
ALTER TABLE `genomics_biotech_ecm`.`research`.`project` ADD CONSTRAINT `fk_research_project_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ADD CONSTRAINT `fk_research_experiment_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`experiment` ADD CONSTRAINT `fk_research_experiment_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ADD CONSTRAINT `fk_research_crispr_construct_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ADD CONSTRAINT `fk_research_crispr_construct_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`crispr_construct` ADD CONSTRAINT `fk_research_crispr_construct_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ADD CONSTRAINT `fk_research_assay_development_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ADD CONSTRAINT `fk_research_assay_development_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`assay_development` ADD CONSTRAINT `fk_research_assay_development_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ADD CONSTRAINT `fk_research_spend_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ADD CONSTRAINT `fk_research_spend_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`spend` ADD CONSTRAINT `fk_research_spend_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`research`.`molecular_design` ADD CONSTRAINT `fk_research_molecular_design_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);

-- ========= sample --> clinical (11 constraint(s)) =========
-- Requires: sample schema, clinical schema
ALTER TABLE `genomics_biotech_ecm`.`sample`.`accession` ADD CONSTRAINT `fk_sample_accession_authorized_orderer_id` FOREIGN KEY (`authorized_orderer_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`authorized_orderer`(`authorized_orderer_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`accession` ADD CONSTRAINT `fk_sample_accession_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`patient`(`patient_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`accession` ADD CONSTRAINT `fk_sample_accession_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`subject` ADD CONSTRAINT `fk_sample_subject_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`patient`(`patient_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`collection_event` ADD CONSTRAINT `fk_sample_collection_event_test_order_id` FOREIGN KEY (`test_order_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_order`(`test_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_assay_version_id` FOREIGN KEY (`assay_version_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`assay_version`(`assay_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_clinical_specimen_id` FOREIGN KEY (`clinical_specimen_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`clinical_specimen`(`clinical_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`qc_measurement` ADD CONSTRAINT `fk_sample_qc_measurement_assay_version_id` FOREIGN KEY (`assay_version_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`assay_version`(`assay_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`qc_measurement` ADD CONSTRAINT `fk_sample_qc_measurement_test_order_id` FOREIGN KEY (`test_order_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_order`(`test_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`run_sample` ADD CONSTRAINT `fk_sample_run_sample_test_order_id` FOREIGN KEY (`test_order_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_order`(`test_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`lab_site` ADD CONSTRAINT `fk_sample_lab_site_performing_laboratory_id` FOREIGN KEY (`performing_laboratory_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`performing_laboratory`(`performing_laboratory_id`);

-- ========= sample --> customer (8 constraint(s)) =========
-- Requires: sample schema, customer schema
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`accession` ADD CONSTRAINT `fk_sample_accession_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`accession` ADD CONSTRAINT `fk_sample_accession_installed_instrument_id` FOREIGN KEY (`installed_instrument_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`installed_instrument`(`installed_instrument_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`accession` ADD CONSTRAINT `fk_sample_accession_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`subject` ADD CONSTRAINT `fk_sample_subject_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`subject` ADD CONSTRAINT `fk_sample_subject_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`collection_event` ADD CONSTRAINT `fk_sample_collection_event_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`cohort` ADD CONSTRAINT `fk_sample_cohort_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);

-- ========= sample --> instrument (5 constraint(s)) =========
-- Requires: sample schema, instrument schema
ALTER TABLE `genomics_biotech_ecm`.`sample`.`storage_event` ADD CONSTRAINT `fk_sample_storage_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`qc_measurement` ADD CONSTRAINT `fk_sample_qc_measurement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`qc_measurement` ADD CONSTRAINT `fk_sample_qc_measurement_instrument_run_id` FOREIGN KEY (`instrument_run_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`instrument_run`(`instrument_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`run_sample` ADD CONSTRAINT `fk_sample_run_sample_instrument_run_id` FOREIGN KEY (`instrument_run_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`instrument_run`(`instrument_run_id`);

-- ========= sample --> manufacturing (11 constraint(s)) =========
-- Requires: sample schema, manufacturing schema
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_order`(`work_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`aliquot` ADD CONSTRAINT `fk_sample_aliquot_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`aliquot` ADD CONSTRAINT `fk_sample_aliquot_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_order`(`work_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`accession` ADD CONSTRAINT `fk_sample_accession_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`biobank_location` ADD CONSTRAINT `fk_sample_biobank_location_site_id` FOREIGN KEY (`site_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_order`(`work_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`qc_measurement` ADD CONSTRAINT `fk_sample_qc_measurement_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`run_sample` ADD CONSTRAINT `fk_sample_run_sample_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`lab_site` ADD CONSTRAINT `fk_sample_lab_site_site_id` FOREIGN KEY (`site_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`site`(`site_id`);

-- ========= sample --> order (6 constraint(s)) =========
-- Requires: sample schema, order schema
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`aliquot` ADD CONSTRAINT `fk_sample_aliquot_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`accession` ADD CONSTRAINT `fk_sample_accession_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`collection_event` ADD CONSTRAINT `fk_sample_collection_event_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`run_sample` ADD CONSTRAINT `fk_sample_run_sample_line_id` FOREIGN KEY (`line_id`) REFERENCES `genomics_biotech_ecm`.`order`.`line`(`line_id`);

-- ========= sample --> product (10 constraint(s)) =========
-- Requires: sample schema, product schema
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`aliquot` ADD CONSTRAINT `fk_sample_aliquot_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`accession` ADD CONSTRAINT `fk_sample_accession_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`collection_event` ADD CONSTRAINT `fk_sample_collection_event_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`qc_measurement` ADD CONSTRAINT `fk_sample_qc_measurement_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`qc_measurement` ADD CONSTRAINT `fk_sample_qc_measurement_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`run_sample` ADD CONSTRAINT `fk_sample_run_sample_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`run_sample` ADD CONSTRAINT `fk_sample_run_sample_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`cohort` ADD CONSTRAINT `fk_sample_cohort_service_offering_id` FOREIGN KEY (`service_offering_id`) REFERENCES `genomics_biotech_ecm`.`product`.`service_offering`(`service_offering_id`);

-- ========= sample --> quality (39 constraint(s)) =========
-- Requires: sample schema, quality schema
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`aliquot` ADD CONSTRAINT `fk_sample_aliquot_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`accession` ADD CONSTRAINT `fk_sample_accession_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`accession` ADD CONSTRAINT `fk_sample_accession_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`accession` ADD CONSTRAINT `fk_sample_accession_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`biobank_location` ADD CONSTRAINT `fk_sample_biobank_location_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`biobank_location` ADD CONSTRAINT `fk_sample_biobank_location_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`biobank_location` ADD CONSTRAINT `fk_sample_biobank_location_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`storage_event` ADD CONSTRAINT `fk_sample_storage_event_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`storage_event` ADD CONSTRAINT `fk_sample_storage_event_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_consent_record` ADD CONSTRAINT `fk_sample_sample_consent_record_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_consent_record` ADD CONSTRAINT `fk_sample_sample_consent_record_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_consent_record` ADD CONSTRAINT `fk_sample_sample_consent_record_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`subject` ADD CONSTRAINT `fk_sample_subject_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`collection_event` ADD CONSTRAINT `fk_sample_collection_event_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`collection_event` ADD CONSTRAINT `fk_sample_collection_event_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`collection_event` ADD CONSTRAINT `fk_sample_collection_event_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`collection_event` ADD CONSTRAINT `fk_sample_collection_event_training_record_id` FOREIGN KEY (`training_record_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`training_record`(`training_record_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_training_record_id` FOREIGN KEY (`training_record_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`training_record`(`training_record_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`qc_measurement` ADD CONSTRAINT `fk_sample_qc_measurement_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`qc_measurement` ADD CONSTRAINT `fk_sample_qc_measurement_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`qc_measurement` ADD CONSTRAINT `fk_sample_qc_measurement_oos_investigation_id` FOREIGN KEY (`oos_investigation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`oos_investigation`(`oos_investigation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`qc_measurement` ADD CONSTRAINT `fk_sample_qc_measurement_test_method_id` FOREIGN KEY (`test_method_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`test_method`(`test_method_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`container` ADD CONSTRAINT `fk_sample_container_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`container` ADD CONSTRAINT `fk_sample_container_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`run_sample` ADD CONSTRAINT `fk_sample_run_sample_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`run_sample` ADD CONSTRAINT `fk_sample_run_sample_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`run_sample` ADD CONSTRAINT `fk_sample_run_sample_oos_investigation_id` FOREIGN KEY (`oos_investigation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`oos_investigation`(`oos_investigation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`cohort` ADD CONSTRAINT `fk_sample_cohort_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`cohort` ADD CONSTRAINT `fk_sample_cohort_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`lab_site` ADD CONSTRAINT `fk_sample_lab_site_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`audit`(`audit_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`lab_site` ADD CONSTRAINT `fk_sample_lab_site_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`lab_site` ADD CONSTRAINT `fk_sample_lab_site_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`risk_assessment`(`risk_assessment_id`);

-- ========= sample --> reagent (13 constraint(s)) =========
-- Requires: sample schema, reagent schema
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`aliquot` ADD CONSTRAINT `fk_sample_aliquot_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`aliquot` ADD CONSTRAINT `fk_sample_aliquot_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`aliquot` ADD CONSTRAINT `fk_sample_aliquot_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`storage_location`(`storage_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`storage_event` ADD CONSTRAINT `fk_sample_storage_event_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`collection_event` ADD CONSTRAINT `fk_sample_collection_event_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`collection_event` ADD CONSTRAINT `fk_sample_collection_event_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`storage_location`(`storage_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`qc_measurement` ADD CONSTRAINT `fk_sample_qc_measurement_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`qc_measurement` ADD CONSTRAINT `fk_sample_qc_measurement_qc_specification_id` FOREIGN KEY (`qc_specification_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`qc_specification`(`qc_specification_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`container` ADD CONSTRAINT `fk_sample_container_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`container` ADD CONSTRAINT `fk_sample_container_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`storage_location`(`storage_location_id`);

-- ========= sample --> regulatory (12 constraint(s)) =========
-- Requires: sample schema, regulatory schema
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`accession` ADD CONSTRAINT `fk_sample_accession_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`accession` ADD CONSTRAINT `fk_sample_accession_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_consent_record` ADD CONSTRAINT `fk_sample_sample_consent_record_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`subject` ADD CONSTRAINT `fk_sample_subject_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`collection_event` ADD CONSTRAINT `fk_sample_collection_event_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`qc_measurement` ADD CONSTRAINT `fk_sample_qc_measurement_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`run_sample` ADD CONSTRAINT `fk_sample_run_sample_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`cohort` ADD CONSTRAINT `fk_sample_cohort_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`cohort` ADD CONSTRAINT `fk_sample_cohort_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`lab_site` ADD CONSTRAINT `fk_sample_lab_site_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);

-- ========= sample --> research (23 constraint(s)) =========
-- Requires: sample schema, research schema
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`aliquot` ADD CONSTRAINT `fk_sample_aliquot_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`aliquot` ADD CONSTRAINT `fk_sample_aliquot_study_id` FOREIGN KEY (`study_id`) REFERENCES `genomics_biotech_ecm`.`research`.`study`(`study_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`accession` ADD CONSTRAINT `fk_sample_accession_irb_submission_id` FOREIGN KEY (`irb_submission_id`) REFERENCES `genomics_biotech_ecm`.`research`.`irb_submission`(`irb_submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`accession` ADD CONSTRAINT `fk_sample_accession_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`accession` ADD CONSTRAINT `fk_sample_accession_study_id` FOREIGN KEY (`study_id`) REFERENCES `genomics_biotech_ecm`.`research`.`study`(`study_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_consent_record` ADD CONSTRAINT `fk_sample_sample_consent_record_irb_submission_id` FOREIGN KEY (`irb_submission_id`) REFERENCES `genomics_biotech_ecm`.`research`.`irb_submission`(`irb_submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_consent_record` ADD CONSTRAINT `fk_sample_sample_consent_record_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_consent_record` ADD CONSTRAINT `fk_sample_sample_consent_record_study_id` FOREIGN KEY (`study_id`) REFERENCES `genomics_biotech_ecm`.`research`.`study`(`study_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`subject` ADD CONSTRAINT `fk_sample_subject_irb_submission_id` FOREIGN KEY (`irb_submission_id`) REFERENCES `genomics_biotech_ecm`.`research`.`irb_submission`(`irb_submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`subject` ADD CONSTRAINT `fk_sample_subject_study_id` FOREIGN KEY (`study_id`) REFERENCES `genomics_biotech_ecm`.`research`.`study`(`study_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`collection_event` ADD CONSTRAINT `fk_sample_collection_event_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`collection_event` ADD CONSTRAINT `fk_sample_collection_event_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`collection_event` ADD CONSTRAINT `fk_sample_collection_event_study_id` FOREIGN KEY (`study_id`) REFERENCES `genomics_biotech_ecm`.`research`.`study`(`study_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_study_id` FOREIGN KEY (`study_id`) REFERENCES `genomics_biotech_ecm`.`research`.`study`(`study_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`qc_measurement` ADD CONSTRAINT `fk_sample_qc_measurement_assay_development_id` FOREIGN KEY (`assay_development_id`) REFERENCES `genomics_biotech_ecm`.`research`.`assay_development`(`assay_development_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`qc_measurement` ADD CONSTRAINT `fk_sample_qc_measurement_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`run_sample` ADD CONSTRAINT `fk_sample_run_sample_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`run_sample` ADD CONSTRAINT `fk_sample_run_sample_study_id` FOREIGN KEY (`study_id`) REFERENCES `genomics_biotech_ecm`.`research`.`study`(`study_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`cohort` ADD CONSTRAINT `fk_sample_cohort_irb_submission_id` FOREIGN KEY (`irb_submission_id`) REFERENCES `genomics_biotech_ecm`.`research`.`irb_submission`(`irb_submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`cohort` ADD CONSTRAINT `fk_sample_cohort_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`cohort` ADD CONSTRAINT `fk_sample_cohort_study_id` FOREIGN KEY (`study_id`) REFERENCES `genomics_biotech_ecm`.`research`.`study`(`study_id`);

-- ========= sample --> supply (13 constraint(s)) =========
-- Requires: sample schema, supply schema
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`sample_specimen` ADD CONSTRAINT `fk_sample_sample_specimen_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`aliquot` ADD CONSTRAINT `fk_sample_aliquot_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`aliquot` ADD CONSTRAINT `fk_sample_aliquot_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`accession` ADD CONSTRAINT `fk_sample_accession_inbound_delivery_id` FOREIGN KEY (`inbound_delivery_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`inbound_delivery`(`inbound_delivery_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`collection_event` ADD CONSTRAINT `fk_sample_collection_event_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`collection_event` ADD CONSTRAINT `fk_sample_collection_event_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`extraction` ADD CONSTRAINT `fk_sample_extraction_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`qc_measurement` ADD CONSTRAINT `fk_sample_qc_measurement_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`container` ADD CONSTRAINT `fk_sample_container_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`sample`.`container` ADD CONSTRAINT `fk_sample_container_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);

-- ========= sequencing --> bioinformatics (4 constraint(s)) =========
-- Requires: sequencing schema, bioinformatics schema
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`fastq_file` ADD CONSTRAINT `fk_sequencing_fastq_file_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`coverage_stat` ADD CONSTRAINT `fk_sequencing_coverage_stat_genomic_artifact_id` FOREIGN KEY (`genomic_artifact_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`genomic_artifact`(`genomic_artifact_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`coverage_stat` ADD CONSTRAINT `fk_sequencing_coverage_stat_pipeline_run_id` FOREIGN KEY (`pipeline_run_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`pipeline_run`(`pipeline_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol` ADD CONSTRAINT `fk_sequencing_sequencing_protocol_pipeline_id` FOREIGN KEY (`pipeline_id`) REFERENCES `genomics_biotech_ecm`.`bioinformatics`.`pipeline`(`pipeline_id`);

-- ========= sequencing --> clinical (22 constraint(s)) =========
-- Requires: sequencing schema, clinical schema
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_assay_version_id` FOREIGN KEY (`assay_version_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`assay_version`(`assay_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_performing_laboratory_id` FOREIGN KEY (`performing_laboratory_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`performing_laboratory`(`performing_laboratory_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_assay_version_id` FOREIGN KEY (`assay_version_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`assay_version`(`assay_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_test_order_id` FOREIGN KEY (`test_order_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_order`(`test_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_assay_version_id` FOREIGN KEY (`assay_version_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`assay_version`(`assay_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_performing_laboratory_id` FOREIGN KEY (`performing_laboratory_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`performing_laboratory`(`performing_laboratory_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_qc_metric` ADD CONSTRAINT `fk_sequencing_run_qc_metric_assay_version_id` FOREIGN KEY (`assay_version_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`assay_version`(`assay_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_qc_metric` ADD CONSTRAINT `fk_sequencing_run_qc_metric_performing_laboratory_id` FOREIGN KEY (`performing_laboratory_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`performing_laboratory`(`performing_laboratory_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_qc_metric` ADD CONSTRAINT `fk_sequencing_run_qc_metric_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`demux_result` ADD CONSTRAINT `fk_sequencing_demux_result_clinical_specimen_id` FOREIGN KEY (`clinical_specimen_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`clinical_specimen`(`clinical_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`demux_result` ADD CONSTRAINT `fk_sequencing_demux_result_test_order_id` FOREIGN KEY (`test_order_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_order`(`test_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`fastq_file` ADD CONSTRAINT `fk_sequencing_fastq_file_assay_version_id` FOREIGN KEY (`assay_version_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`assay_version`(`assay_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`fastq_file` ADD CONSTRAINT `fk_sequencing_fastq_file_clinical_specimen_id` FOREIGN KEY (`clinical_specimen_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`clinical_specimen`(`clinical_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`fastq_file` ADD CONSTRAINT `fk_sequencing_fastq_file_test_order_id` FOREIGN KEY (`test_order_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_order`(`test_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`coverage_stat` ADD CONSTRAINT `fk_sequencing_coverage_stat_assay_version_id` FOREIGN KEY (`assay_version_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`assay_version`(`assay_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`coverage_stat` ADD CONSTRAINT `fk_sequencing_coverage_stat_performing_laboratory_id` FOREIGN KEY (`performing_laboratory_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`performing_laboratory`(`performing_laboratory_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`coverage_stat` ADD CONSTRAINT `fk_sequencing_coverage_stat_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_catalog`(`test_catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol` ADD CONSTRAINT `fk_sequencing_sequencing_protocol_assay_version_id` FOREIGN KEY (`assay_version_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`assay_version`(`assay_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_sample_sheet` ADD CONSTRAINT `fk_sequencing_run_sample_sheet_assay_version_id` FOREIGN KEY (`assay_version_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`assay_version`(`assay_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_sample_sheet` ADD CONSTRAINT `fk_sequencing_run_sample_sheet_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `genomics_biotech_ecm`.`clinical`.`test_catalog`(`test_catalog_id`);

-- ========= sequencing --> customer (28 constraint(s)) =========
-- Requires: sequencing schema, customer schema
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_accreditation_id` FOREIGN KEY (`accreditation_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`accreditation`(`accreditation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_installed_instrument_id` FOREIGN KEY (`installed_instrument_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`installed_instrument`(`installed_instrument_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_technical_requirement_id` FOREIGN KEY (`technical_requirement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`technical_requirement`(`technical_requirement_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_accreditation_id` FOREIGN KEY (`accreditation_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`accreditation`(`accreditation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_technical_requirement_id` FOREIGN KEY (`technical_requirement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`technical_requirement`(`technical_requirement_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_accreditation_id` FOREIGN KEY (`accreditation_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`accreditation`(`accreditation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_installed_instrument_id` FOREIGN KEY (`installed_instrument_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`installed_instrument`(`installed_instrument_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_technical_requirement_id` FOREIGN KEY (`technical_requirement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`technical_requirement`(`technical_requirement_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`pool` ADD CONSTRAINT `fk_sequencing_pool_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`pool` ADD CONSTRAINT `fk_sequencing_pool_technical_requirement_id` FOREIGN KEY (`technical_requirement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`technical_requirement`(`technical_requirement_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_qc_metric` ADD CONSTRAINT `fk_sequencing_run_qc_metric_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_qc_metric` ADD CONSTRAINT `fk_sequencing_run_qc_metric_support_case_id` FOREIGN KEY (`support_case_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`support_case`(`support_case_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`demux_result` ADD CONSTRAINT `fk_sequencing_demux_result_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`demux_result` ADD CONSTRAINT `fk_sequencing_demux_result_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`fastq_file` ADD CONSTRAINT `fk_sequencing_fastq_file_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`fastq_file` ADD CONSTRAINT `fk_sequencing_fastq_file_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`coverage_stat` ADD CONSTRAINT `fk_sequencing_coverage_stat_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_sample_sheet` ADD CONSTRAINT `fk_sequencing_run_sample_sheet_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_sample_sheet` ADD CONSTRAINT `fk_sequencing_run_sample_sheet_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_sample_sheet` ADD CONSTRAINT `fk_sequencing_run_sample_sheet_technical_requirement_id` FOREIGN KEY (`technical_requirement_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`technical_requirement`(`technical_requirement_id`);

-- ========= sequencing --> instrument (10 constraint(s)) =========
-- Requires: sequencing schema, instrument schema
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`flow_cell` ADD CONSTRAINT `fk_sequencing_flow_cell_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`pool` ADD CONSTRAINT `fk_sequencing_pool_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_lane` ADD CONSTRAINT `fk_sequencing_run_lane_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_qc_metric` ADD CONSTRAINT `fk_sequencing_run_qc_metric_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`fastq_file` ADD CONSTRAINT `fk_sequencing_fastq_file_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_sample_sheet` ADD CONSTRAINT `fk_sequencing_run_sample_sheet_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_sample_sheet` ADD CONSTRAINT `fk_sequencing_run_sample_sheet_configuration_id` FOREIGN KEY (`configuration_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`configuration`(`configuration_id`);

-- ========= sequencing --> manufacturing (7 constraint(s)) =========
-- Requires: sequencing schema, manufacturing schema
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_order`(`work_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`flow_cell` ADD CONSTRAINT `fk_sequencing_flow_cell_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_qc_metric` ADD CONSTRAINT `fk_sequencing_run_qc_metric_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`index_set` ADD CONSTRAINT `fk_sequencing_index_set_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_sample_sheet` ADD CONSTRAINT `fk_sequencing_run_sample_sheet_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);

-- ========= sequencing --> order (2 constraint(s)) =========
-- Requires: sequencing schema, order schema
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);

-- ========= sequencing --> product (39 constraint(s)) =========
-- Requires: sequencing schema, product schema
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_license_entitlement_id` FOREIGN KEY (`license_entitlement_id`) REFERENCES `genomics_biotech_ecm`.`product`.`license_entitlement`(`license_entitlement_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_regulatory_classification_id` FOREIGN KEY (`regulatory_classification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`regulatory_classification`(`regulatory_classification_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_service_offering_id` FOREIGN KEY (`service_offering_id`) REFERENCES `genomics_biotech_ecm`.`product`.`service_offering`(`service_offering_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_software_release_id` FOREIGN KEY (`software_release_id`) REFERENCES `genomics_biotech_ecm`.`product`.`software_release`(`software_release_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`flow_cell` ADD CONSTRAINT `fk_sequencing_flow_cell_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`flow_cell` ADD CONSTRAINT `fk_sequencing_flow_cell_regulatory_classification_id` FOREIGN KEY (`regulatory_classification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`regulatory_classification`(`regulatory_classification_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`flow_cell` ADD CONSTRAINT `fk_sequencing_flow_cell_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`flow_cell` ADD CONSTRAINT `fk_sequencing_flow_cell_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_regulatory_classification_id` FOREIGN KEY (`regulatory_classification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`regulatory_classification`(`regulatory_classification_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_service_offering_id` FOREIGN KEY (`service_offering_id`) REFERENCES `genomics_biotech_ecm`.`product`.`service_offering`(`service_offering_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_software_release_id` FOREIGN KEY (`software_release_id`) REFERENCES `genomics_biotech_ecm`.`product`.`software_release`(`software_release_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`pool` ADD CONSTRAINT `fk_sequencing_pool_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`pool` ADD CONSTRAINT `fk_sequencing_pool_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_lane` ADD CONSTRAINT `fk_sequencing_run_lane_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_qc_metric` ADD CONSTRAINT `fk_sequencing_run_qc_metric_regulatory_classification_id` FOREIGN KEY (`regulatory_classification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`regulatory_classification`(`regulatory_classification_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_qc_metric` ADD CONSTRAINT `fk_sequencing_run_qc_metric_software_release_id` FOREIGN KEY (`software_release_id`) REFERENCES `genomics_biotech_ecm`.`product`.`software_release`(`software_release_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_qc_metric` ADD CONSTRAINT `fk_sequencing_run_qc_metric_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`demux_result` ADD CONSTRAINT `fk_sequencing_demux_result_software_release_id` FOREIGN KEY (`software_release_id`) REFERENCES `genomics_biotech_ecm`.`product`.`software_release`(`software_release_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`fastq_file` ADD CONSTRAINT `fk_sequencing_fastq_file_license_entitlement_id` FOREIGN KEY (`license_entitlement_id`) REFERENCES `genomics_biotech_ecm`.`product`.`license_entitlement`(`license_entitlement_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`fastq_file` ADD CONSTRAINT `fk_sequencing_fastq_file_software_release_id` FOREIGN KEY (`software_release_id`) REFERENCES `genomics_biotech_ecm`.`product`.`software_release`(`software_release_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`fastq_file` ADD CONSTRAINT `fk_sequencing_fastq_file_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`coverage_stat` ADD CONSTRAINT `fk_sequencing_coverage_stat_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`index_set` ADD CONSTRAINT `fk_sequencing_index_set_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`index_set` ADD CONSTRAINT `fk_sequencing_index_set_regulatory_classification_id` FOREIGN KEY (`regulatory_classification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`regulatory_classification`(`regulatory_classification_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`index_set` ADD CONSTRAINT `fk_sequencing_index_set_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol` ADD CONSTRAINT `fk_sequencing_sequencing_protocol_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol` ADD CONSTRAINT `fk_sequencing_sequencing_protocol_software_release_id` FOREIGN KEY (`software_release_id`) REFERENCES `genomics_biotech_ecm`.`product`.`software_release`(`software_release_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol` ADD CONSTRAINT `fk_sequencing_sequencing_protocol_regulatory_classification_id` FOREIGN KEY (`regulatory_classification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`regulatory_classification`(`regulatory_classification_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol` ADD CONSTRAINT `fk_sequencing_sequencing_protocol_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `genomics_biotech_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_sample_sheet` ADD CONSTRAINT `fk_sequencing_run_sample_sheet_software_release_id` FOREIGN KEY (`software_release_id`) REFERENCES `genomics_biotech_ecm`.`product`.`software_release`(`software_release_id`);

-- ========= sequencing --> quality (37 constraint(s)) =========
-- Requires: sequencing schema, quality schema
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`flow_cell` ADD CONSTRAINT `fk_sequencing_flow_cell_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`flow_cell` ADD CONSTRAINT `fk_sequencing_flow_cell_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`flow_cell` ADD CONSTRAINT `fk_sequencing_flow_cell_qc_result_id` FOREIGN KEY (`qc_result_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`qc_result`(`qc_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_oos_investigation_id` FOREIGN KEY (`oos_investigation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`oos_investigation`(`oos_investigation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_qc_result_id` FOREIGN KEY (`qc_result_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`qc_result`(`qc_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`audit`(`audit_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`pool` ADD CONSTRAINT `fk_sequencing_pool_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`pool` ADD CONSTRAINT `fk_sequencing_pool_oos_investigation_id` FOREIGN KEY (`oos_investigation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`oos_investigation`(`oos_investigation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`pool` ADD CONSTRAINT `fk_sequencing_pool_qc_result_id` FOREIGN KEY (`qc_result_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`qc_result`(`qc_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_lane` ADD CONSTRAINT `fk_sequencing_run_lane_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_qc_metric` ADD CONSTRAINT `fk_sequencing_run_qc_metric_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`deviation`(`deviation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_qc_metric` ADD CONSTRAINT `fk_sequencing_run_qc_metric_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_qc_metric` ADD CONSTRAINT `fk_sequencing_run_qc_metric_oos_investigation_id` FOREIGN KEY (`oos_investigation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`oos_investigation`(`oos_investigation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_qc_metric` ADD CONSTRAINT `fk_sequencing_run_qc_metric_qc_result_id` FOREIGN KEY (`qc_result_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`qc_result`(`qc_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`demux_result` ADD CONSTRAINT `fk_sequencing_demux_result_qc_result_id` FOREIGN KEY (`qc_result_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`qc_result`(`qc_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`fastq_file` ADD CONSTRAINT `fk_sequencing_fastq_file_qc_result_id` FOREIGN KEY (`qc_result_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`qc_result`(`qc_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`coverage_stat` ADD CONSTRAINT `fk_sequencing_coverage_stat_oos_investigation_id` FOREIGN KEY (`oos_investigation_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`oos_investigation`(`oos_investigation_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`coverage_stat` ADD CONSTRAINT `fk_sequencing_coverage_stat_qc_result_id` FOREIGN KEY (`qc_result_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`qc_result`(`qc_result_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`index_set` ADD CONSTRAINT `fk_sequencing_index_set_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`index_set` ADD CONSTRAINT `fk_sequencing_index_set_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`index_set` ADD CONSTRAINT `fk_sequencing_index_set_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`index_set` ADD CONSTRAINT `fk_sequencing_index_set_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol` ADD CONSTRAINT `fk_sequencing_sequencing_protocol_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`change_control`(`change_control_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol` ADD CONSTRAINT `fk_sequencing_sequencing_protocol_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol` ADD CONSTRAINT `fk_sequencing_sequencing_protocol_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol` ADD CONSTRAINT `fk_sequencing_sequencing_protocol_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_sample_sheet` ADD CONSTRAINT `fk_sequencing_run_sample_sheet_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_sample_sheet` ADD CONSTRAINT `fk_sequencing_run_sample_sheet_validation_study_id` FOREIGN KEY (`validation_study_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`validation_study`(`validation_study_id`);

-- ========= sequencing --> reagent (14 constraint(s)) =========
-- Requires: sequencing schema, reagent schema
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`flow_cell` ADD CONSTRAINT `fk_sequencing_flow_cell_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`flow_cell` ADD CONSTRAINT `fk_sequencing_flow_cell_coa_id` FOREIGN KEY (`coa_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`coa`(`coa_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`flow_cell` ADD CONSTRAINT `fk_sequencing_flow_cell_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`pool` ADD CONSTRAINT `fk_sequencing_pool_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`pool` ADD CONSTRAINT `fk_sequencing_pool_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`index_set` ADD CONSTRAINT `fk_sequencing_index_set_coa_id` FOREIGN KEY (`coa_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`coa`(`coa_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`index_set` ADD CONSTRAINT `fk_sequencing_index_set_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`index_set` ADD CONSTRAINT `fk_sequencing_index_set_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol` ADD CONSTRAINT `fk_sequencing_sequencing_protocol_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_sample_sheet` ADD CONSTRAINT `fk_sequencing_run_sample_sheet_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);

-- ========= sequencing --> regulatory (9 constraint(s)) =========
-- Requires: sequencing schema, regulatory schema
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`flow_cell` ADD CONSTRAINT `fk_sequencing_flow_cell_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_qc_metric` ADD CONSTRAINT `fk_sequencing_run_qc_metric_post_market_surveillance_id` FOREIGN KEY (`post_market_surveillance_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance`(`post_market_surveillance_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`fastq_file` ADD CONSTRAINT `fk_sequencing_fastq_file_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`index_set` ADD CONSTRAINT `fk_sequencing_index_set_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol` ADD CONSTRAINT `fk_sequencing_sequencing_protocol_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol` ADD CONSTRAINT `fk_sequencing_sequencing_protocol_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);

-- ========= sequencing --> research (21 constraint(s)) =========
-- Requires: sequencing schema, research schema
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_assay_development_id` FOREIGN KEY (`assay_development_id`) REFERENCES `genomics_biotech_ecm`.`research`.`assay_development`(`assay_development_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_assay_development_id` FOREIGN KEY (`assay_development_id`) REFERENCES `genomics_biotech_ecm`.`research`.`assay_development`(`assay_development_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_molecular_design_id` FOREIGN KEY (`molecular_design_id`) REFERENCES `genomics_biotech_ecm`.`research`.`molecular_design`(`molecular_design_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_assay_development_id` FOREIGN KEY (`assay_development_id`) REFERENCES `genomics_biotech_ecm`.`research`.`assay_development`(`assay_development_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_molecular_design_id` FOREIGN KEY (`molecular_design_id`) REFERENCES `genomics_biotech_ecm`.`research`.`molecular_design`(`molecular_design_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`pool` ADD CONSTRAINT `fk_sequencing_pool_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_qc_metric` ADD CONSTRAINT `fk_sequencing_run_qc_metric_assay_development_id` FOREIGN KEY (`assay_development_id`) REFERENCES `genomics_biotech_ecm`.`research`.`assay_development`(`assay_development_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_qc_metric` ADD CONSTRAINT `fk_sequencing_run_qc_metric_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`demux_result` ADD CONSTRAINT `fk_sequencing_demux_result_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`demux_result` ADD CONSTRAINT `fk_sequencing_demux_result_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`fastq_file` ADD CONSTRAINT `fk_sequencing_fastq_file_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`fastq_file` ADD CONSTRAINT `fk_sequencing_fastq_file_project_id` FOREIGN KEY (`project_id`) REFERENCES `genomics_biotech_ecm`.`research`.`project`(`project_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`fastq_file` ADD CONSTRAINT `fk_sequencing_fastq_file_research_protocol_id` FOREIGN KEY (`research_protocol_id`) REFERENCES `genomics_biotech_ecm`.`research`.`research_protocol`(`research_protocol_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`coverage_stat` ADD CONSTRAINT `fk_sequencing_coverage_stat_assay_development_id` FOREIGN KEY (`assay_development_id`) REFERENCES `genomics_biotech_ecm`.`research`.`assay_development`(`assay_development_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`coverage_stat` ADD CONSTRAINT `fk_sequencing_coverage_stat_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `genomics_biotech_ecm`.`research`.`experiment`(`experiment_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol` ADD CONSTRAINT `fk_sequencing_sequencing_protocol_assay_development_id` FOREIGN KEY (`assay_development_id`) REFERENCES `genomics_biotech_ecm`.`research`.`assay_development`(`assay_development_id`);

-- ========= sequencing --> sample (13 constraint(s)) =========
-- Requires: sequencing schema, sample schema
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_lab_site_id` FOREIGN KEY (`lab_site_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`lab_site`(`lab_site_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_aliquot_id` FOREIGN KEY (`aliquot_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`aliquot`(`aliquot_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_container_id` FOREIGN KEY (`container_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`container`(`container_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_extraction_id` FOREIGN KEY (`extraction_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`extraction`(`extraction_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library` ADD CONSTRAINT `fk_sequencing_library_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_aliquot_id` FOREIGN KEY (`aliquot_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`aliquot`(`aliquot_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_extraction_id` FOREIGN KEY (`extraction_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`extraction`(`extraction_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_lab_site_id` FOREIGN KEY (`lab_site_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`lab_site`(`lab_site_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_qc_metric` ADD CONSTRAINT `fk_sequencing_run_qc_metric_extraction_id` FOREIGN KEY (`extraction_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`extraction`(`extraction_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`run_qc_metric` ADD CONSTRAINT `fk_sequencing_run_qc_metric_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`fastq_file` ADD CONSTRAINT `fk_sequencing_fastq_file_extraction_id` FOREIGN KEY (`extraction_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`extraction`(`extraction_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`coverage_stat` ADD CONSTRAINT `fk_sequencing_coverage_stat_extraction_id` FOREIGN KEY (`extraction_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`extraction`(`extraction_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`coverage_stat` ADD CONSTRAINT `fk_sequencing_coverage_stat_sample_specimen_id` FOREIGN KEY (`sample_specimen_id`) REFERENCES `genomics_biotech_ecm`.`sample`.`sample_specimen`(`sample_specimen_id`);

-- ========= sequencing --> supply (14 constraint(s)) =========
-- Requires: sequencing schema, supply schema
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_run` ADD CONSTRAINT `fk_sequencing_sequencing_run_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`flow_cell` ADD CONSTRAINT `fk_sequencing_flow_cell_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`flow_cell` ADD CONSTRAINT `fk_sequencing_flow_cell_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`library_prep_run` ADD CONSTRAINT `fk_sequencing_library_prep_run_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`pool` ADD CONSTRAINT `fk_sequencing_pool_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`index_set` ADD CONSTRAINT `fk_sequencing_index_set_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`index_set` ADD CONSTRAINT `fk_sequencing_index_set_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`index_set` ADD CONSTRAINT `fk_sequencing_index_set_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`index_set` ADD CONSTRAINT `fk_sequencing_index_set_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`sequencing`.`sequencing_protocol` ADD CONSTRAINT `fk_sequencing_sequencing_protocol_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);

-- ========= supply --> customer (4 constraint(s)) =========
-- Requires: supply schema, customer schema
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ADD CONSTRAINT `fk_supply_inventory_stock_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_account_id` FOREIGN KEY (`account_id`) REFERENCES `genomics_biotech_ecm`.`customer`.`account`(`account_id`);

-- ========= supply --> manufacturing (3 constraint(s)) =========
-- Requires: supply schema, manufacturing schema
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_production_batch_id` FOREIGN KEY (`production_batch_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`production_batch`(`production_batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ADD CONSTRAINT `fk_supply_inventory_stock_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_order`(`work_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `genomics_biotech_ecm`.`manufacturing`.`work_order`(`work_order_id`);

-- ========= supply --> product (4 constraint(s)) =========
-- Requires: supply schema, product schema
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ADD CONSTRAINT `fk_supply_material_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `genomics_biotech_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ADD CONSTRAINT `fk_supply_supplier_qualification_catalog_item_id` FOREIGN KEY (`catalog_item_id`) REFERENCES `genomics_biotech_ecm`.`product`.`catalog_item`(`catalog_item_id`);

-- ========= supply --> quality (2 constraint(s)) =========
-- Requires: supply schema, quality schema
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ADD CONSTRAINT `fk_supply_supplier_qualification_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`audit`(`audit_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ADD CONSTRAINT `fk_supply_supplier_qualification_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `genomics_biotech_ecm`.`quality`.`capa`(`capa_id`);

-- ========= supply --> reagent (8 constraint(s)) =========
-- Requires: supply schema, reagent schema
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`catalog`(`catalog_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_coa_id` FOREIGN KEY (`coa_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`coa`(`coa_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`storage_location`(`storage_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ADD CONSTRAINT `fk_supply_inventory_stock_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ADD CONSTRAINT `fk_supply_inventory_stock_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`storage_location`(`storage_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`lot`(`lot_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `genomics_biotech_ecm`.`reagent`.`storage_location`(`storage_location_id`);

-- ========= supply --> regulatory (12 constraint(s)) =========
-- Requires: supply schema, regulatory schema
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ADD CONSTRAINT `fk_supply_supplier_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ADD CONSTRAINT `fk_supply_material_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ADD CONSTRAINT `fk_supply_material_device_identifier_id` FOREIGN KEY (`device_identifier_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`device_identifier`(`device_identifier_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_device_identifier_id` FOREIGN KEY (`device_identifier_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`device_identifier`(`device_identifier_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ADD CONSTRAINT `fk_supply_batch_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ADD CONSTRAINT `fk_supply_batch_device_identifier_id` FOREIGN KEY (`device_identifier_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`device_identifier`(`device_identifier_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ADD CONSTRAINT `fk_supply_inbound_delivery_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ADD CONSTRAINT `fk_supply_supplier_qualification_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ADD CONSTRAINT `fk_supply_supplier_qualification_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`plant` ADD CONSTRAINT `fk_supply_plant_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);

