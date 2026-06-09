-- Cross-Domain Foreign Keys for Business: Clinical Trials | Version: v1_mvm
-- Generated on: 2026-05-07 02:33:34
-- Total cross-domain FK constraints: 1455
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: biostatistics, compliance, data, document, laboratory, monitoring, randomization, regulatory, safety, site, study, subject, supply

-- ========= biostatistics --> compliance (1 constraint(s)) =========
-- Requires: biostatistics schema, compliance schema
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap_amendment` ADD CONSTRAINT `fk_biostatistics_sap_amendment_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);

-- ========= biostatistics --> data (5 constraint(s)) =========
-- Requires: biostatistics schema, data schema
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`adam_dataset_spec` ADD CONSTRAINT `fk_biostatistics_adam_dataset_spec_edc_study_build_id` FOREIGN KEY (`edc_study_build_id`) REFERENCES `clinical_trials_ecm`.`data`.`edc_study_build`(`edc_study_build_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`adam_dataset_spec` ADD CONSTRAINT `fk_biostatistics_adam_dataset_spec_sdtm_dataset_id` FOREIGN KEY (`sdtm_dataset_id`) REFERENCES `clinical_trials_ecm`.`data`.`sdtm_dataset`(`sdtm_dataset_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`interim_analysis` ADD CONSTRAINT `fk_biostatistics_interim_analysis_sdtm_dataset_id` FOREIGN KEY (`sdtm_dataset_id`) REFERENCES `clinical_trials_ecm`.`data`.`sdtm_dataset`(`sdtm_dataset_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`database_lock_event` ADD CONSTRAINT `fk_biostatistics_database_lock_event_dmp_id` FOREIGN KEY (`dmp_id`) REFERENCES `clinical_trials_ecm`.`data`.`dmp`(`dmp_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`database_lock_event` ADD CONSTRAINT `fk_biostatistics_database_lock_event_edc_study_build_id` FOREIGN KEY (`edc_study_build_id`) REFERENCES `clinical_trials_ecm`.`data`.`edc_study_build`(`edc_study_build_id`);

-- ========= biostatistics --> document (7 constraint(s)) =========
-- Requires: biostatistics schema, document schema
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap` ADD CONSTRAINT `fk_biostatistics_sap_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap_amendment` ADD CONSTRAINT `fk_biostatistics_sap_amendment_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`tlf_output` ADD CONSTRAINT `fk_biostatistics_tlf_output_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`interim_analysis` ADD CONSTRAINT `fk_biostatistics_interim_analysis_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`database_lock_event` ADD CONSTRAINT `fk_biostatistics_database_lock_event_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`statistical_endpoint` ADD CONSTRAINT `fk_biostatistics_statistical_endpoint_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`estimand` ADD CONSTRAINT `fk_biostatistics_estimand_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);

-- ========= biostatistics --> laboratory (1 constraint(s)) =========
-- Requires: biostatistics schema, laboratory schema
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`adam_dataset_spec` ADD CONSTRAINT `fk_biostatistics_adam_dataset_spec_lab_panel_id` FOREIGN KEY (`lab_panel_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_panel`(`lab_panel_id`);

-- ========= biostatistics --> randomization (11 constraint(s)) =========
-- Requires: biostatistics schema, randomization schema
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap` ADD CONSTRAINT `fk_biostatistics_sap_rand_scheme_id` FOREIGN KEY (`rand_scheme_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_scheme`(`rand_scheme_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap_amendment` ADD CONSTRAINT `fk_biostatistics_sap_amendment_rand_scheme_id` FOREIGN KEY (`rand_scheme_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_scheme`(`rand_scheme_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sample_size_calc` ADD CONSTRAINT `fk_biostatistics_sample_size_calc_rand_scheme_id` FOREIGN KEY (`rand_scheme_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_scheme`(`rand_scheme_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`adam_variable_spec` ADD CONSTRAINT `fk_biostatistics_adam_variable_spec_stratification_factor_id` FOREIGN KEY (`stratification_factor_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`stratification_factor`(`stratification_factor_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`tlf_shell` ADD CONSTRAINT `fk_biostatistics_tlf_shell_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`interim_analysis` ADD CONSTRAINT `fk_biostatistics_interim_analysis_blinding_config_id` FOREIGN KEY (`blinding_config_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`blinding_config`(`blinding_config_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`interim_analysis` ADD CONSTRAINT `fk_biostatistics_interim_analysis_rand_list_id` FOREIGN KEY (`rand_list_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_list`(`rand_list_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`database_lock_event` ADD CONSTRAINT `fk_biostatistics_database_lock_event_blinding_config_id` FOREIGN KEY (`blinding_config_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`blinding_config`(`blinding_config_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`database_lock_event` ADD CONSTRAINT `fk_biostatistics_database_lock_event_rand_list_id` FOREIGN KEY (`rand_list_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_list`(`rand_list_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`statistical_endpoint` ADD CONSTRAINT `fk_biostatistics_statistical_endpoint_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`estimand` ADD CONSTRAINT `fk_biostatistics_estimand_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);

-- ========= biostatistics --> regulatory (20 constraint(s)) =========
-- Requires: biostatistics schema, regulatory schema
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap` ADD CONSTRAINT `fk_biostatistics_sap_application_id` FOREIGN KEY (`application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`application`(`application_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap` ADD CONSTRAINT `fk_biostatistics_sap_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`strategy`(`strategy_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap` ADD CONSTRAINT `fk_biostatistics_sap_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap_amendment` ADD CONSTRAINT `fk_biostatistics_sap_amendment_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap_amendment` ADD CONSTRAINT `fk_biostatistics_sap_amendment_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`analysis_population` ADD CONSTRAINT `fk_biostatistics_analysis_population_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sample_size_calc` ADD CONSTRAINT `fk_biostatistics_sample_size_calc_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sample_size_calc` ADD CONSTRAINT `fk_biostatistics_sample_size_calc_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`adam_dataset_spec` ADD CONSTRAINT `fk_biostatistics_adam_dataset_spec_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`tlf_output` ADD CONSTRAINT `fk_biostatistics_tlf_output_ctd_dossier_id` FOREIGN KEY (`ctd_dossier_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ctd_dossier`(`ctd_dossier_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`tlf_output` ADD CONSTRAINT `fk_biostatistics_tlf_output_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`interim_analysis` ADD CONSTRAINT `fk_biostatistics_interim_analysis_commitment_id` FOREIGN KEY (`commitment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`commitment`(`commitment_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`interim_analysis` ADD CONSTRAINT `fk_biostatistics_interim_analysis_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`interim_analysis` ADD CONSTRAINT `fk_biostatistics_interim_analysis_safety_report_submission_id` FOREIGN KEY (`safety_report_submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`safety_report_submission`(`safety_report_submission_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`interim_analysis` ADD CONSTRAINT `fk_biostatistics_interim_analysis_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`database_lock_event` ADD CONSTRAINT `fk_biostatistics_database_lock_event_regulatory_milestone_id` FOREIGN KEY (`regulatory_milestone_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_milestone`(`regulatory_milestone_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`database_lock_event` ADD CONSTRAINT `fk_biostatistics_database_lock_event_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`statistical_endpoint` ADD CONSTRAINT `fk_biostatistics_statistical_endpoint_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`statistical_endpoint` ADD CONSTRAINT `fk_biostatistics_statistical_endpoint_special_designation_id` FOREIGN KEY (`special_designation_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`special_designation`(`special_designation_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`estimand` ADD CONSTRAINT `fk_biostatistics_estimand_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);

-- ========= biostatistics --> safety (2 constraint(s)) =========
-- Requires: biostatistics schema, safety schema
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap_amendment` ADD CONSTRAINT `fk_biostatistics_sap_amendment_signal_evaluation_id` FOREIGN KEY (`signal_evaluation_id`) REFERENCES `clinical_trials_ecm`.`safety`.`signal_evaluation`(`signal_evaluation_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`interim_analysis` ADD CONSTRAINT `fk_biostatistics_interim_analysis_signal_id` FOREIGN KEY (`signal_id`) REFERENCES `clinical_trials_ecm`.`safety`.`signal`(`signal_id`);

-- ========= biostatistics --> study (27 constraint(s)) =========
-- Requires: biostatistics schema, study schema
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap` ADD CONSTRAINT `fk_biostatistics_sap_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap` ADD CONSTRAINT `fk_biostatistics_sap_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap_amendment` ADD CONSTRAINT `fk_biostatistics_sap_amendment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap_amendment` ADD CONSTRAINT `fk_biostatistics_sap_amendment_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`analysis_population` ADD CONSTRAINT `fk_biostatistics_analysis_population_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`analysis_population` ADD CONSTRAINT `fk_biostatistics_analysis_population_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sample_size_calc` ADD CONSTRAINT `fk_biostatistics_sample_size_calc_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sample_size_calc` ADD CONSTRAINT `fk_biostatistics_sample_size_calc_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `clinical_trials_ecm`.`study`.`endpoint`(`endpoint_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sample_size_calc` ADD CONSTRAINT `fk_biostatistics_sample_size_calc_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sample_size_calc` ADD CONSTRAINT `fk_biostatistics_sample_size_calc_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`adam_dataset_spec` ADD CONSTRAINT `fk_biostatistics_adam_dataset_spec_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`adam_variable_spec` ADD CONSTRAINT `fk_biostatistics_adam_variable_spec_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`tlf_shell` ADD CONSTRAINT `fk_biostatistics_tlf_shell_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`tlf_shell` ADD CONSTRAINT `fk_biostatistics_tlf_shell_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `clinical_trials_ecm`.`study`.`endpoint`(`endpoint_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`tlf_shell` ADD CONSTRAINT `fk_biostatistics_tlf_shell_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`tlf_shell` ADD CONSTRAINT `fk_biostatistics_tlf_shell_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`tlf_shell` ADD CONSTRAINT `fk_biostatistics_tlf_shell_study_visit_schedule_id` FOREIGN KEY (`study_visit_schedule_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_visit_schedule`(`study_visit_schedule_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`tlf_output` ADD CONSTRAINT `fk_biostatistics_tlf_output_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`interim_analysis` ADD CONSTRAINT `fk_biostatistics_interim_analysis_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`interim_analysis` ADD CONSTRAINT `fk_biostatistics_interim_analysis_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`interim_analysis` ADD CONSTRAINT `fk_biostatistics_interim_analysis_study_milestone_id` FOREIGN KEY (`study_milestone_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_milestone`(`study_milestone_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`database_lock_event` ADD CONSTRAINT `fk_biostatistics_database_lock_event_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`statistical_endpoint` ADD CONSTRAINT `fk_biostatistics_statistical_endpoint_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `clinical_trials_ecm`.`study`.`endpoint`(`endpoint_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`statistical_endpoint` ADD CONSTRAINT `fk_biostatistics_statistical_endpoint_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`estimand` ADD CONSTRAINT `fk_biostatistics_estimand_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `clinical_trials_ecm`.`study`.`endpoint`(`endpoint_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`estimand` ADD CONSTRAINT `fk_biostatistics_estimand_objective_id` FOREIGN KEY (`objective_id`) REFERENCES `clinical_trials_ecm`.`study`.`objective`(`objective_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`estimand` ADD CONSTRAINT `fk_biostatistics_estimand_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);

-- ========= compliance --> biostatistics (14 constraint(s)) =========
-- Requires: compliance schema, biostatistics schema
ALTER TABLE `clinical_trials_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_sap_id` FOREIGN KEY (`sap_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sap`(`sap_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_adam_dataset_spec_id` FOREIGN KEY (`adam_dataset_spec_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`adam_dataset_spec`(`adam_dataset_spec_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_tlf_output_id` FOREIGN KEY (`tlf_output_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`tlf_output`(`tlf_output_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_adam_dataset_spec_id` FOREIGN KEY (`adam_dataset_spec_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`adam_dataset_spec`(`adam_dataset_spec_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_sap_id` FOREIGN KEY (`sap_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sap`(`sap_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`capa` ADD CONSTRAINT `fk_compliance_capa_sap_id` FOREIGN KEY (`sap_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sap`(`sap_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_analysis_population_id` FOREIGN KEY (`analysis_population_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`analysis_population`(`analysis_population_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_estimand_id` FOREIGN KEY (`estimand_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`estimand`(`estimand_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_sap_id` FOREIGN KEY (`sap_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sap`(`sap_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_statistical_endpoint_id` FOREIGN KEY (`statistical_endpoint_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`statistical_endpoint`(`statistical_endpoint_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`quality_event` ADD CONSTRAINT `fk_compliance_quality_event_database_lock_event_id` FOREIGN KEY (`database_lock_event_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`database_lock_event`(`database_lock_event_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`regulatory_commitment` ADD CONSTRAINT `fk_compliance_regulatory_commitment_interim_analysis_id` FOREIGN KEY (`interim_analysis_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`interim_analysis`(`interim_analysis_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`regulatory_commitment` ADD CONSTRAINT `fk_compliance_regulatory_commitment_sap_id` FOREIGN KEY (`sap_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sap`(`sap_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`regulatory_commitment` ADD CONSTRAINT `fk_compliance_regulatory_commitment_statistical_endpoint_id` FOREIGN KEY (`statistical_endpoint_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`statistical_endpoint`(`statistical_endpoint_id`);

-- ========= compliance --> document (18 constraint(s)) =========
-- Requires: compliance schema, document schema
ALTER TABLE `clinical_trials_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_site_file_id` FOREIGN KEY (`site_file_id`) REFERENCES `clinical_trials_ecm`.`document`.`site_file`(`site_file_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_site_file_id` FOREIGN KEY (`site_file_id`) REFERENCES `clinical_trials_ecm`.`document`.`site_file`(`site_file_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`compliance_inspection` ADD CONSTRAINT `fk_compliance_compliance_inspection_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`compliance_inspection` ADD CONSTRAINT `fk_compliance_compliance_inspection_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_site_file_id` FOREIGN KEY (`site_file_id`) REFERENCES `clinical_trials_ecm`.`document`.`site_file`(`site_file_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`capa` ADD CONSTRAINT `fk_compliance_capa_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`sop_training_record` ADD CONSTRAINT `fk_compliance_sop_training_record_signature_id` FOREIGN KEY (`signature_id`) REFERENCES `clinical_trials_ecm`.`document`.`signature`(`signature_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`quality_event` ADD CONSTRAINT `fk_compliance_quality_event_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`regulatory_commitment` ADD CONSTRAINT `fk_compliance_regulatory_commitment_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`regulatory_commitment` ADD CONSTRAINT `fk_compliance_regulatory_commitment_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`ethics_submission` ADD CONSTRAINT `fk_compliance_ethics_submission_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`ethics_approval` ADD CONSTRAINT `fk_compliance_ethics_approval_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`ethics_approval` ADD CONSTRAINT `fk_compliance_ethics_approval_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);

-- ========= compliance --> laboratory (8 constraint(s)) =========
-- Requires: compliance schema, laboratory schema
ALTER TABLE `clinical_trials_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_lab_facility_id` FOREIGN KEY (`lab_facility_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_facility`(`lab_facility_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_bioanalytical_assay_id` FOREIGN KEY (`bioanalytical_assay_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`bioanalytical_assay`(`bioanalytical_assay_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_lab_result_id` FOREIGN KEY (`lab_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_result`(`lab_result_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_lab_result_id` FOREIGN KEY (`lab_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_result`(`lab_result_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_specimen_collection_id` FOREIGN KEY (`specimen_collection_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`specimen_collection`(`specimen_collection_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`quality_event` ADD CONSTRAINT `fk_compliance_quality_event_specimen_collection_id` FOREIGN KEY (`specimen_collection_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`specimen_collection`(`specimen_collection_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`quality_event` ADD CONSTRAINT `fk_compliance_quality_event_specimen_shipment_id` FOREIGN KEY (`specimen_shipment_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`specimen_shipment`(`specimen_shipment_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_lab_facility_id` FOREIGN KEY (`lab_facility_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_facility`(`lab_facility_id`);

-- ========= compliance --> randomization (4 constraint(s)) =========
-- Requires: compliance schema, randomization schema
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`quality_event` ADD CONSTRAINT `fk_compliance_quality_event_kit_assignment_id` FOREIGN KEY (`kit_assignment_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`kit_assignment`(`kit_assignment_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`quality_event` ADD CONSTRAINT `fk_compliance_quality_event_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_blinding_config_id` FOREIGN KEY (`blinding_config_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`blinding_config`(`blinding_config_id`);

-- ========= compliance --> safety (2 constraint(s)) =========
-- Requires: compliance schema, safety schema
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_adverse_event_id` FOREIGN KEY (`adverse_event_id`) REFERENCES `clinical_trials_ecm`.`safety`.`adverse_event`(`adverse_event_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`regulatory_commitment` ADD CONSTRAINT `fk_compliance_regulatory_commitment_dsmb_review_id` FOREIGN KEY (`dsmb_review_id`) REFERENCES `clinical_trials_ecm`.`safety`.`dsmb_review`(`dsmb_review_id`);

-- ========= compliance --> site (16 constraint(s)) =========
-- Requires: compliance schema, site schema
ALTER TABLE `clinical_trials_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `clinical_trials_ecm`.`site`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`compliance_inspection` ADD CONSTRAINT `fk_compliance_compliance_inspection_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`compliance_inspection` ADD CONSTRAINT `fk_compliance_compliance_inspection_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `clinical_trials_ecm`.`site`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`capa` ADD CONSTRAINT `fk_compliance_capa_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_activation_id` FOREIGN KEY (`activation_id`) REFERENCES `clinical_trials_ecm`.`site`.`activation`(`activation_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`sop_training_record` ADD CONSTRAINT `fk_compliance_sop_training_record_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`sop_training_record` ADD CONSTRAINT `fk_compliance_sop_training_record_site_contact_id` FOREIGN KEY (`site_contact_id`) REFERENCES `clinical_trials_ecm`.`site`.`site_contact`(`site_contact_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`quality_event` ADD CONSTRAINT `fk_compliance_quality_event_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`ethics_submission` ADD CONSTRAINT `fk_compliance_ethics_submission_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `clinical_trials_ecm`.`site`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`ethics_submission` ADD CONSTRAINT `fk_compliance_ethics_submission_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`ethics_approval` ADD CONSTRAINT `fk_compliance_ethics_approval_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);

-- ========= compliance --> study (27 constraint(s)) =========
-- Requires: compliance schema, study schema
ALTER TABLE `clinical_trials_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_country_id` FOREIGN KEY (`country_id`) REFERENCES `clinical_trials_ecm`.`study`.`country`(`country_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `clinical_trials_ecm`.`study`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`compliance_inspection` ADD CONSTRAINT `fk_compliance_compliance_inspection_country_id` FOREIGN KEY (`country_id`) REFERENCES `clinical_trials_ecm`.`study`.`country`(`country_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`compliance_inspection` ADD CONSTRAINT `fk_compliance_compliance_inspection_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`capa` ADD CONSTRAINT `fk_compliance_capa_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_dosing_regimen_id` FOREIGN KEY (`dosing_regimen_id`) REFERENCES `clinical_trials_ecm`.`study`.`dosing_regimen`(`dosing_regimen_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_eligibility_criterion_id` FOREIGN KEY (`eligibility_criterion_id`) REFERENCES `clinical_trials_ecm`.`study`.`eligibility_criterion`(`eligibility_criterion_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_visit_procedure_id` FOREIGN KEY (`visit_procedure_id`) REFERENCES `clinical_trials_ecm`.`study`.`visit_procedure`(`visit_procedure_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`sop_training_record` ADD CONSTRAINT `fk_compliance_sop_training_record_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`sop_training_requirement` ADD CONSTRAINT `fk_compliance_sop_training_requirement_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`quality_event` ADD CONSTRAINT `fk_compliance_quality_event_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`ethics_submission` ADD CONSTRAINT `fk_compliance_ethics_submission_country_id` FOREIGN KEY (`country_id`) REFERENCES `clinical_trials_ecm`.`study`.`country`(`country_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`ethics_submission` ADD CONSTRAINT `fk_compliance_ethics_submission_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`ethics_approval` ADD CONSTRAINT `fk_compliance_ethics_approval_country_id` FOREIGN KEY (`country_id`) REFERENCES `clinical_trials_ecm`.`study`.`country`(`country_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`ethics_approval` ADD CONSTRAINT `fk_compliance_ethics_approval_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`ethics_approval` ADD CONSTRAINT `fk_compliance_ethics_approval_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`ethics_approval` ADD CONSTRAINT `fk_compliance_ethics_approval_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);

-- ========= compliance --> subject (2 constraint(s)) =========
-- Requires: compliance schema, subject schema
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);

-- ========= compliance --> supply (4 constraint(s)) =========
-- Requires: compliance schema, supply schema
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `clinical_trials_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`quality_event` ADD CONSTRAINT `fk_compliance_quality_event_manufacture_batch_id` FOREIGN KEY (`manufacture_batch_id`) REFERENCES `clinical_trials_ecm`.`supply`.`manufacture_batch`(`manufacture_batch_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `clinical_trials_ecm`.`supply`.`depot`(`depot_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_imp_master_id` FOREIGN KEY (`imp_master_id`) REFERENCES `clinical_trials_ecm`.`supply`.`imp_master`(`imp_master_id`);

-- ========= data --> biostatistics (7 constraint(s)) =========
-- Requires: data schema, biostatistics schema
ALTER TABLE `clinical_trials_ecm`.`data`.`subject_visit_data` ADD CONSTRAINT `fk_data_subject_visit_data_database_lock_event_id` FOREIGN KEY (`database_lock_event_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`database_lock_event`(`database_lock_event_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`validation_rule` ADD CONSTRAINT `fk_data_validation_rule_sap_id` FOREIGN KEY (`sap_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sap`(`sap_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_sap_id` FOREIGN KEY (`sap_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sap`(`sap_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_dataset` ADD CONSTRAINT `fk_data_sdtm_dataset_sap_id` FOREIGN KEY (`sap_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sap`(`sap_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_mapping` ADD CONSTRAINT `fk_data_sdtm_mapping_sap_id` FOREIGN KEY (`sap_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sap`(`sap_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`edc_study_build` ADD CONSTRAINT `fk_data_edc_study_build_sap_id` FOREIGN KEY (`sap_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sap`(`sap_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_database_lock_event_id` FOREIGN KEY (`database_lock_event_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`database_lock_event`(`database_lock_event_id`);

-- ========= data --> compliance (8 constraint(s)) =========
-- Requires: data schema, compliance schema
ALTER TABLE `clinical_trials_ecm`.`data`.`field_entry` ADD CONSTRAINT `fk_data_field_entry_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`validation_rule` ADD CONSTRAINT `fk_data_validation_rule_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`validation_rule` ADD CONSTRAINT `fk_data_validation_rule_deviation_classification_id` FOREIGN KEY (`deviation_classification_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`deviation_classification`(`deviation_classification_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`external_transfer` ADD CONSTRAINT `fk_data_external_transfer_quality_event_id` FOREIGN KEY (`quality_event_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`quality_event`(`quality_event_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`edc_study_build` ADD CONSTRAINT `fk_data_edc_study_build_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_quality_event_id` FOREIGN KEY (`quality_event_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`quality_event`(`quality_event_id`);

-- ========= data --> document (20 constraint(s)) =========
-- Requires: data schema, document schema
ALTER TABLE `clinical_trials_ecm`.`data`.`ecrf_form` ADD CONSTRAINT `fk_data_ecrf_form_version_id` FOREIGN KEY (`version_id`) REFERENCES `clinical_trials_ecm`.`document`.`version`(`version_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`ecrf_form` ADD CONSTRAINT `fk_data_ecrf_form_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`ecrf_form` ADD CONSTRAINT `fk_data_ecrf_form_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`discrepancy_query` ADD CONSTRAINT `fk_data_discrepancy_query_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`coding_assignment` ADD CONSTRAINT `fk_data_coding_assignment_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_dataset` ADD CONSTRAINT `fk_data_sdtm_dataset_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_dataset` ADD CONSTRAINT `fk_data_sdtm_dataset_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_dataset` ADD CONSTRAINT `fk_data_sdtm_dataset_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_mapping` ADD CONSTRAINT `fk_data_sdtm_mapping_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_mapping` ADD CONSTRAINT `fk_data_sdtm_mapping_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`external_transfer` ADD CONSTRAINT `fk_data_external_transfer_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`external_transfer` ADD CONSTRAINT `fk_data_external_transfer_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`edc_study_build` ADD CONSTRAINT `fk_data_edc_study_build_version_id` FOREIGN KEY (`version_id`) REFERENCES `clinical_trials_ecm`.`document`.`version`(`version_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`edc_study_build` ADD CONSTRAINT `fk_data_edc_study_build_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`edc_study_build` ADD CONSTRAINT `fk_data_edc_study_build_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);

-- ========= data --> laboratory (22 constraint(s)) =========
-- Requires: data schema, laboratory schema
ALTER TABLE `clinical_trials_ecm`.`data`.`ecrf_form` ADD CONSTRAINT `fk_data_ecrf_form_lab_panel_id` FOREIGN KEY (`lab_panel_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_panel`(`lab_panel_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`subject_visit_data` ADD CONSTRAINT `fk_data_subject_visit_data_lab_panel_id` FOREIGN KEY (`lab_panel_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_panel`(`lab_panel_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`subject_visit_data` ADD CONSTRAINT `fk_data_subject_visit_data_specimen_collection_id` FOREIGN KEY (`specimen_collection_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`specimen_collection`(`specimen_collection_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`field_entry` ADD CONSTRAINT `fk_data_field_entry_lab_result_id` FOREIGN KEY (`lab_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_result`(`lab_result_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`discrepancy_query` ADD CONSTRAINT `fk_data_discrepancy_query_lab_result_id` FOREIGN KEY (`lab_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_result`(`lab_result_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`validation_rule` ADD CONSTRAINT `fk_data_validation_rule_critical_value_id` FOREIGN KEY (`critical_value_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`critical_value`(`critical_value_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`validation_rule` ADD CONSTRAINT `fk_data_validation_rule_lab_panel_id` FOREIGN KEY (`lab_panel_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_panel`(`lab_panel_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`validation_rule` ADD CONSTRAINT `fk_data_validation_rule_reference_range_id` FOREIGN KEY (`reference_range_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`reference_range`(`reference_range_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_lab_facility_id` FOREIGN KEY (`lab_facility_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_facility`(`lab_facility_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_dataset` ADD CONSTRAINT `fk_data_sdtm_dataset_bioanalytical_assay_id` FOREIGN KEY (`bioanalytical_assay_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`bioanalytical_assay`(`bioanalytical_assay_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_dataset` ADD CONSTRAINT `fk_data_sdtm_dataset_lab_panel_id` FOREIGN KEY (`lab_panel_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_panel`(`lab_panel_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_dataset` ADD CONSTRAINT `fk_data_sdtm_dataset_reference_range_id` FOREIGN KEY (`reference_range_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`reference_range`(`reference_range_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_mapping` ADD CONSTRAINT `fk_data_sdtm_mapping_lab_panel_id` FOREIGN KEY (`lab_panel_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_panel`(`lab_panel_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`external_transfer` ADD CONSTRAINT `fk_data_external_transfer_bioanalytical_assay_id` FOREIGN KEY (`bioanalytical_assay_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`bioanalytical_assay`(`bioanalytical_assay_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`external_transfer` ADD CONSTRAINT `fk_data_external_transfer_lab_facility_id` FOREIGN KEY (`lab_facility_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_facility`(`lab_facility_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`external_transfer` ADD CONSTRAINT `fk_data_external_transfer_lab_panel_id` FOREIGN KEY (`lab_panel_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_panel`(`lab_panel_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`external_transfer` ADD CONSTRAINT `fk_data_external_transfer_specimen_shipment_id` FOREIGN KEY (`specimen_shipment_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`specimen_shipment`(`specimen_shipment_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`edc_study_build` ADD CONSTRAINT `fk_data_edc_study_build_lab_facility_id` FOREIGN KEY (`lab_facility_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_facility`(`lab_facility_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`edc_study_build` ADD CONSTRAINT `fk_data_edc_study_build_lab_panel_id` FOREIGN KEY (`lab_panel_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_panel`(`lab_panel_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_lab_facility_id` FOREIGN KEY (`lab_facility_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_facility`(`lab_facility_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_lab_result_id` FOREIGN KEY (`lab_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_result`(`lab_result_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_specimen_shipment_id` FOREIGN KEY (`specimen_shipment_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`specimen_shipment`(`specimen_shipment_id`);

-- ========= data --> randomization (22 constraint(s)) =========
-- Requires: data schema, randomization schema
ALTER TABLE `clinical_trials_ecm`.`data`.`ecrf_form` ADD CONSTRAINT `fk_data_ecrf_form_rand_scheme_id` FOREIGN KEY (`rand_scheme_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_scheme`(`rand_scheme_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`subject_visit_data` ADD CONSTRAINT `fk_data_subject_visit_data_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`field_entry` ADD CONSTRAINT `fk_data_field_entry_irt_transaction_id` FOREIGN KEY (`irt_transaction_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`irt_transaction`(`irt_transaction_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`field_entry` ADD CONSTRAINT `fk_data_field_entry_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`discrepancy_query` ADD CONSTRAINT `fk_data_discrepancy_query_irt_transaction_id` FOREIGN KEY (`irt_transaction_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`irt_transaction`(`irt_transaction_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`discrepancy_query` ADD CONSTRAINT `fk_data_discrepancy_query_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`validation_rule` ADD CONSTRAINT `fk_data_validation_rule_rand_scheme_id` FOREIGN KEY (`rand_scheme_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_scheme`(`rand_scheme_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`validation_rule` ADD CONSTRAINT `fk_data_validation_rule_stratification_factor_id` FOREIGN KEY (`stratification_factor_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`stratification_factor`(`stratification_factor_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`validation_rule` ADD CONSTRAINT `fk_data_validation_rule_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_blinding_config_id` FOREIGN KEY (`blinding_config_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`blinding_config`(`blinding_config_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_rand_scheme_id` FOREIGN KEY (`rand_scheme_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_scheme`(`rand_scheme_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`coding_assignment` ADD CONSTRAINT `fk_data_coding_assignment_blinding_config_id` FOREIGN KEY (`blinding_config_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`blinding_config`(`blinding_config_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_dataset` ADD CONSTRAINT `fk_data_sdtm_dataset_blinding_config_id` FOREIGN KEY (`blinding_config_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`blinding_config`(`blinding_config_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_dataset` ADD CONSTRAINT `fk_data_sdtm_dataset_rand_scheme_id` FOREIGN KEY (`rand_scheme_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_scheme`(`rand_scheme_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_mapping` ADD CONSTRAINT `fk_data_sdtm_mapping_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`external_transfer` ADD CONSTRAINT `fk_data_external_transfer_blinding_config_id` FOREIGN KEY (`blinding_config_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`blinding_config`(`blinding_config_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`external_transfer` ADD CONSTRAINT `fk_data_external_transfer_rand_scheme_id` FOREIGN KEY (`rand_scheme_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_scheme`(`rand_scheme_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`edc_study_build` ADD CONSTRAINT `fk_data_edc_study_build_blinding_config_id` FOREIGN KEY (`blinding_config_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`blinding_config`(`blinding_config_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`edc_study_build` ADD CONSTRAINT `fk_data_edc_study_build_rand_scheme_id` FOREIGN KEY (`rand_scheme_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_scheme`(`rand_scheme_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_irt_transaction_id` FOREIGN KEY (`irt_transaction_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`irt_transaction`(`irt_transaction_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_rand_list_id` FOREIGN KEY (`rand_list_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_list`(`rand_list_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);

-- ========= data --> regulatory (11 constraint(s)) =========
-- Requires: data schema, regulatory schema
ALTER TABLE `clinical_trials_ecm`.`data`.`ecrf_form` ADD CONSTRAINT `fk_data_ecrf_form_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`ecrf_form` ADD CONSTRAINT `fk_data_ecrf_form_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`validation_rule` ADD CONSTRAINT `fk_data_validation_rule_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`strategy`(`strategy_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_dataset` ADD CONSTRAINT `fk_data_sdtm_dataset_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_dataset` ADD CONSTRAINT `fk_data_sdtm_dataset_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_mapping` ADD CONSTRAINT `fk_data_sdtm_mapping_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`edc_study_build` ADD CONSTRAINT `fk_data_edc_study_build_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);

-- ========= data --> site (7 constraint(s)) =========
-- Requires: data schema, site schema
ALTER TABLE `clinical_trials_ecm`.`data`.`subject_visit_data` ADD CONSTRAINT `fk_data_subject_visit_data_irb_iec_approval_id` FOREIGN KEY (`irb_iec_approval_id`) REFERENCES `clinical_trials_ecm`.`site`.`irb_iec_approval`(`irb_iec_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`subject_visit_data` ADD CONSTRAINT `fk_data_subject_visit_data_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`field_entry` ADD CONSTRAINT `fk_data_field_entry_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`discrepancy_query` ADD CONSTRAINT `fk_data_discrepancy_query_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`discrepancy_query` ADD CONSTRAINT `fk_data_discrepancy_query_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`external_transfer` ADD CONSTRAINT `fk_data_external_transfer_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);

-- ========= data --> study (39 constraint(s)) =========
-- Requires: data schema, study schema
ALTER TABLE `clinical_trials_ecm`.`data`.`ecrf_form` ADD CONSTRAINT `fk_data_ecrf_form_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `clinical_trials_ecm`.`study`.`endpoint`(`endpoint_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`ecrf_form` ADD CONSTRAINT `fk_data_ecrf_form_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`ecrf_field` ADD CONSTRAINT `fk_data_ecrf_field_eligibility_criterion_id` FOREIGN KEY (`eligibility_criterion_id`) REFERENCES `clinical_trials_ecm`.`study`.`eligibility_criterion`(`eligibility_criterion_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`ecrf_field` ADD CONSTRAINT `fk_data_ecrf_field_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `clinical_trials_ecm`.`study`.`endpoint`(`endpoint_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`ecrf_field` ADD CONSTRAINT `fk_data_ecrf_field_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`ecrf_field` ADD CONSTRAINT `fk_data_ecrf_field_visit_procedure_id` FOREIGN KEY (`visit_procedure_id`) REFERENCES `clinical_trials_ecm`.`study`.`visit_procedure`(`visit_procedure_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`subject_visit_data` ADD CONSTRAINT `fk_data_subject_visit_data_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`subject_visit_data` ADD CONSTRAINT `fk_data_subject_visit_data_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`subject_visit_data` ADD CONSTRAINT `fk_data_subject_visit_data_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`subject_visit_data` ADD CONSTRAINT `fk_data_subject_visit_data_study_visit_schedule_id` FOREIGN KEY (`study_visit_schedule_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_visit_schedule`(`study_visit_schedule_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`field_entry` ADD CONSTRAINT `fk_data_field_entry_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`field_entry` ADD CONSTRAINT `fk_data_field_entry_visit_procedure_id` FOREIGN KEY (`visit_procedure_id`) REFERENCES `clinical_trials_ecm`.`study`.`visit_procedure`(`visit_procedure_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`discrepancy_query` ADD CONSTRAINT `fk_data_discrepancy_query_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `clinical_trials_ecm`.`study`.`endpoint`(`endpoint_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`discrepancy_query` ADD CONSTRAINT `fk_data_discrepancy_query_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`discrepancy_query` ADD CONSTRAINT `fk_data_discrepancy_query_visit_procedure_id` FOREIGN KEY (`visit_procedure_id`) REFERENCES `clinical_trials_ecm`.`study`.`visit_procedure`(`visit_procedure_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`validation_rule` ADD CONSTRAINT `fk_data_validation_rule_eligibility_criterion_id` FOREIGN KEY (`eligibility_criterion_id`) REFERENCES `clinical_trials_ecm`.`study`.`eligibility_criterion`(`eligibility_criterion_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`validation_rule` ADD CONSTRAINT `fk_data_validation_rule_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`validation_rule` ADD CONSTRAINT `fk_data_validation_rule_visit_procedure_id` FOREIGN KEY (`visit_procedure_id`) REFERENCES `clinical_trials_ecm`.`study`.`visit_procedure`(`visit_procedure_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`coding_assignment` ADD CONSTRAINT `fk_data_coding_assignment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_dataset` ADD CONSTRAINT `fk_data_sdtm_dataset_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_dataset` ADD CONSTRAINT `fk_data_sdtm_dataset_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `clinical_trials_ecm`.`study`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_dataset` ADD CONSTRAINT `fk_data_sdtm_dataset_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_mapping` ADD CONSTRAINT `fk_data_sdtm_mapping_dosing_regimen_id` FOREIGN KEY (`dosing_regimen_id`) REFERENCES `clinical_trials_ecm`.`study`.`dosing_regimen`(`dosing_regimen_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_mapping` ADD CONSTRAINT `fk_data_sdtm_mapping_eligibility_criterion_id` FOREIGN KEY (`eligibility_criterion_id`) REFERENCES `clinical_trials_ecm`.`study`.`eligibility_criterion`(`eligibility_criterion_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_mapping` ADD CONSTRAINT `fk_data_sdtm_mapping_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `clinical_trials_ecm`.`study`.`endpoint`(`endpoint_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_mapping` ADD CONSTRAINT `fk_data_sdtm_mapping_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_mapping` ADD CONSTRAINT `fk_data_sdtm_mapping_visit_procedure_id` FOREIGN KEY (`visit_procedure_id`) REFERENCES `clinical_trials_ecm`.`study`.`visit_procedure`(`visit_procedure_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`external_transfer` ADD CONSTRAINT `fk_data_external_transfer_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`external_transfer` ADD CONSTRAINT `fk_data_external_transfer_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`external_transfer` ADD CONSTRAINT `fk_data_external_transfer_visit_procedure_id` FOREIGN KEY (`visit_procedure_id`) REFERENCES `clinical_trials_ecm`.`study`.`visit_procedure`(`visit_procedure_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`edc_study_build` ADD CONSTRAINT `fk_data_edc_study_build_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`edc_study_build` ADD CONSTRAINT `fk_data_edc_study_build_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`edc_study_build` ADD CONSTRAINT `fk_data_edc_study_build_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `clinical_trials_ecm`.`study`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_visit_procedure_id` FOREIGN KEY (`visit_procedure_id`) REFERENCES `clinical_trials_ecm`.`study`.`visit_procedure`(`visit_procedure_id`);

-- ========= data --> subject (8 constraint(s)) =========
-- Requires: data schema, subject schema
ALTER TABLE `clinical_trials_ecm`.`data`.`subject_visit_data` ADD CONSTRAINT `fk_data_subject_visit_data_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`subject_visit_data` ADD CONSTRAINT `fk_data_subject_visit_data_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`field_entry` ADD CONSTRAINT `fk_data_field_entry_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`field_entry` ADD CONSTRAINT `fk_data_field_entry_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`discrepancy_query` ADD CONSTRAINT `fk_data_discrepancy_query_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `clinical_trials_ecm`.`subject`.`deviation`(`deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`discrepancy_query` ADD CONSTRAINT `fk_data_discrepancy_query_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`coding_assignment` ADD CONSTRAINT `fk_data_coding_assignment_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);

-- ========= data --> supply (18 constraint(s)) =========
-- Requires: data schema, supply schema
ALTER TABLE `clinical_trials_ecm`.`data`.`ecrf_form` ADD CONSTRAINT `fk_data_ecrf_form_kit_definition_id` FOREIGN KEY (`kit_definition_id`) REFERENCES `clinical_trials_ecm`.`supply`.`kit_definition`(`kit_definition_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`subject_visit_data` ADD CONSTRAINT `fk_data_subject_visit_data_kit_inventory_id` FOREIGN KEY (`kit_inventory_id`) REFERENCES `clinical_trials_ecm`.`supply`.`kit_inventory`(`kit_inventory_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`field_entry` ADD CONSTRAINT `fk_data_field_entry_dispensing_record_id` FOREIGN KEY (`dispensing_record_id`) REFERENCES `clinical_trials_ecm`.`supply`.`dispensing_record`(`dispensing_record_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`field_entry` ADD CONSTRAINT `fk_data_field_entry_kit_inventory_id` FOREIGN KEY (`kit_inventory_id`) REFERENCES `clinical_trials_ecm`.`supply`.`kit_inventory`(`kit_inventory_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`discrepancy_query` ADD CONSTRAINT `fk_data_discrepancy_query_dispensing_record_id` FOREIGN KEY (`dispensing_record_id`) REFERENCES `clinical_trials_ecm`.`supply`.`dispensing_record`(`dispensing_record_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`discrepancy_query` ADD CONSTRAINT `fk_data_discrepancy_query_kit_inventory_id` FOREIGN KEY (`kit_inventory_id`) REFERENCES `clinical_trials_ecm`.`supply`.`kit_inventory`(`kit_inventory_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`discrepancy_query` ADD CONSTRAINT `fk_data_discrepancy_query_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `clinical_trials_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`validation_rule` ADD CONSTRAINT `fk_data_validation_rule_imp_master_id` FOREIGN KEY (`imp_master_id`) REFERENCES `clinical_trials_ecm`.`supply`.`imp_master`(`imp_master_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`validation_rule` ADD CONSTRAINT `fk_data_validation_rule_kit_definition_id` FOREIGN KEY (`kit_definition_id`) REFERENCES `clinical_trials_ecm`.`supply`.`kit_definition`(`kit_definition_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_supply_plan_id` FOREIGN KEY (`supply_plan_id`) REFERENCES `clinical_trials_ecm`.`supply`.`supply_plan`(`supply_plan_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`coding_assignment` ADD CONSTRAINT `fk_data_coding_assignment_dispensing_record_id` FOREIGN KEY (`dispensing_record_id`) REFERENCES `clinical_trials_ecm`.`supply`.`dispensing_record`(`dispensing_record_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_dataset` ADD CONSTRAINT `fk_data_sdtm_dataset_imp_master_id` FOREIGN KEY (`imp_master_id`) REFERENCES `clinical_trials_ecm`.`supply`.`imp_master`(`imp_master_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_dataset` ADD CONSTRAINT `fk_data_sdtm_dataset_manufacture_batch_id` FOREIGN KEY (`manufacture_batch_id`) REFERENCES `clinical_trials_ecm`.`supply`.`manufacture_batch`(`manufacture_batch_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`external_transfer` ADD CONSTRAINT `fk_data_external_transfer_dispensing_record_id` FOREIGN KEY (`dispensing_record_id`) REFERENCES `clinical_trials_ecm`.`supply`.`dispensing_record`(`dispensing_record_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`external_transfer` ADD CONSTRAINT `fk_data_external_transfer_manufacture_batch_id` FOREIGN KEY (`manufacture_batch_id`) REFERENCES `clinical_trials_ecm`.`supply`.`manufacture_batch`(`manufacture_batch_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`external_transfer` ADD CONSTRAINT `fk_data_external_transfer_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `clinical_trials_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_accountability_reconciliation_id` FOREIGN KEY (`accountability_reconciliation_id`) REFERENCES `clinical_trials_ecm`.`supply`.`accountability_reconciliation`(`accountability_reconciliation_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `clinical_trials_ecm`.`supply`.`shipment`(`shipment_id`);

-- ========= document --> biostatistics (1 constraint(s)) =========
-- Requires: document schema, biostatistics schema
ALTER TABLE `clinical_trials_ecm`.`document`.`archival_record` ADD CONSTRAINT `fk_document_archival_record_database_lock_event_id` FOREIGN KEY (`database_lock_event_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`database_lock_event`(`database_lock_event_id`);

-- ========= document --> compliance (1 constraint(s)) =========
-- Requires: document schema, compliance schema
ALTER TABLE `clinical_trials_ecm`.`document`.`inspection_readiness` ADD CONSTRAINT `fk_document_inspection_readiness_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`capa`(`capa_id`);

-- ========= document --> regulatory (7 constraint(s)) =========
-- Requires: document schema, regulatory schema
ALTER TABLE `clinical_trials_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`site_file` ADD CONSTRAINT `fk_document_site_file_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`inspection_readiness` ADD CONSTRAINT `fk_document_inspection_readiness_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`inspection_readiness` ADD CONSTRAINT `fk_document_inspection_readiness_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`distribution` ADD CONSTRAINT `fk_document_distribution_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`regulatory_binder` ADD CONSTRAINT `fk_document_regulatory_binder_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`archival_record` ADD CONSTRAINT `fk_document_archival_record_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`approval`(`approval_id`);

-- ========= document --> site (6 constraint(s)) =========
-- Requires: document schema, site schema
ALTER TABLE `clinical_trials_ecm`.`document`.`signature` ADD CONSTRAINT `fk_document_signature_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`site_file` ADD CONSTRAINT `fk_document_site_file_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`tmf_completeness` ADD CONSTRAINT `fk_document_tmf_completeness_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`inspection_readiness` ADD CONSTRAINT `fk_document_inspection_readiness_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`distribution` ADD CONSTRAINT `fk_document_distribution_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`archival_record` ADD CONSTRAINT `fk_document_archival_record_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);

-- ========= document --> study (8 constraint(s)) =========
-- Requires: document schema, study schema
ALTER TABLE `clinical_trials_ecm`.`document`.`tmf_document` ADD CONSTRAINT `fk_document_tmf_document_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`signature` ADD CONSTRAINT `fk_document_signature_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`site_file` ADD CONSTRAINT `fk_document_site_file_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`tmf_completeness` ADD CONSTRAINT `fk_document_tmf_completeness_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`inspection_readiness` ADD CONSTRAINT `fk_document_inspection_readiness_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`distribution` ADD CONSTRAINT `fk_document_distribution_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`archival_record` ADD CONSTRAINT `fk_document_archival_record_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);

-- ========= laboratory --> biostatistics (8 constraint(s)) =========
-- Requires: laboratory schema, biostatistics schema
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_result` ADD CONSTRAINT `fk_laboratory_lab_result_database_lock_event_id` FOREIGN KEY (`database_lock_event_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`database_lock_event`(`database_lock_event_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_result` ADD CONSTRAINT `fk_laboratory_lab_result_statistical_endpoint_id` FOREIGN KEY (`statistical_endpoint_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`statistical_endpoint`(`statistical_endpoint_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`reference_range` ADD CONSTRAINT `fk_laboratory_reference_range_sap_id` FOREIGN KEY (`sap_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sap`(`sap_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_assay` ADD CONSTRAINT `fk_laboratory_bioanalytical_assay_sap_id` FOREIGN KEY (`sap_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sap`(`sap_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_result` ADD CONSTRAINT `fk_laboratory_bioanalytical_result_analysis_population_id` FOREIGN KEY (`analysis_population_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`analysis_population`(`analysis_population_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_result` ADD CONSTRAINT `fk_laboratory_bioanalytical_result_database_lock_event_id` FOREIGN KEY (`database_lock_event_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`database_lock_event`(`database_lock_event_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_result` ADD CONSTRAINT `fk_laboratory_bioanalytical_result_statistical_endpoint_id` FOREIGN KEY (`statistical_endpoint_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`statistical_endpoint`(`statistical_endpoint_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_query` ADD CONSTRAINT `fk_laboratory_lab_query_database_lock_event_id` FOREIGN KEY (`database_lock_event_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`database_lock_event`(`database_lock_event_id`);

-- ========= laboratory --> compliance (11 constraint(s)) =========
-- Requires: laboratory schema, compliance schema
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_panel` ADD CONSTRAINT `fk_laboratory_lab_panel_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`reference_range` ADD CONSTRAINT `fk_laboratory_reference_range_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`critical_value` ADD CONSTRAINT `fk_laboratory_critical_value_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`pk_sample` ADD CONSTRAINT `fk_laboratory_pk_sample_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_result` ADD CONSTRAINT `fk_laboratory_bioanalytical_result_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_result` ADD CONSTRAINT `fk_laboratory_bioanalytical_result_quality_event_id` FOREIGN KEY (`quality_event_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`quality_event`(`quality_event_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_accreditation` ADD CONSTRAINT `fk_laboratory_lab_accreditation_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`capa`(`capa_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_accreditation` ADD CONSTRAINT `fk_laboratory_lab_accreditation_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_kit` ADD CONSTRAINT `fk_laboratory_lab_kit_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_query` ADD CONSTRAINT `fk_laboratory_lab_query_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_query` ADD CONSTRAINT `fk_laboratory_lab_query_quality_event_id` FOREIGN KEY (`quality_event_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`quality_event`(`quality_event_id`);

-- ========= laboratory --> data (1 constraint(s)) =========
-- Requires: laboratory schema, data schema
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_collection` ADD CONSTRAINT `fk_laboratory_specimen_collection_ecrf_form_id` FOREIGN KEY (`ecrf_form_id`) REFERENCES `clinical_trials_ecm`.`data`.`ecrf_form`(`ecrf_form_id`);

-- ========= laboratory --> document (8 constraint(s)) =========
-- Requires: laboratory schema, document schema
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_panel` ADD CONSTRAINT `fk_laboratory_lab_panel_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`reference_range` ADD CONSTRAINT `fk_laboratory_reference_range_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`critical_value` ADD CONSTRAINT `fk_laboratory_critical_value_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_assay` ADD CONSTRAINT `fk_laboratory_bioanalytical_assay_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_assay` ADD CONSTRAINT `fk_laboratory_bioanalytical_assay_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_accreditation` ADD CONSTRAINT `fk_laboratory_lab_accreditation_site_file_id` FOREIGN KEY (`site_file_id`) REFERENCES `clinical_trials_ecm`.`document`.`site_file`(`site_file_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_accreditation` ADD CONSTRAINT `fk_laboratory_lab_accreditation_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_kit` ADD CONSTRAINT `fk_laboratory_lab_kit_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);

-- ========= laboratory --> randomization (9 constraint(s)) =========
-- Requires: laboratory schema, randomization schema
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_result` ADD CONSTRAINT `fk_laboratory_lab_result_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_collection` ADD CONSTRAINT `fk_laboratory_specimen_collection_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`reference_range` ADD CONSTRAINT `fk_laboratory_reference_range_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`critical_value` ADD CONSTRAINT `fk_laboratory_critical_value_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`pk_sample` ADD CONSTRAINT `fk_laboratory_pk_sample_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_result` ADD CONSTRAINT `fk_laboratory_bioanalytical_result_blinding_config_id` FOREIGN KEY (`blinding_config_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`blinding_config`(`blinding_config_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_result` ADD CONSTRAINT `fk_laboratory_bioanalytical_result_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_kit` ADD CONSTRAINT `fk_laboratory_lab_kit_rand_scheme_id` FOREIGN KEY (`rand_scheme_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_scheme`(`rand_scheme_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_kit` ADD CONSTRAINT `fk_laboratory_lab_kit_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);

-- ========= laboratory --> regulatory (5 constraint(s)) =========
-- Requires: laboratory schema, regulatory schema
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_panel` ADD CONSTRAINT `fk_laboratory_lab_panel_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_panel` ADD CONSTRAINT `fk_laboratory_lab_panel_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_shipment` ADD CONSTRAINT `fk_laboratory_specimen_shipment_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`critical_value` ADD CONSTRAINT `fk_laboratory_critical_value_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_accreditation` ADD CONSTRAINT `fk_laboratory_lab_accreditation_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`health_authority`(`health_authority_id`);

-- ========= laboratory --> safety (7 constraint(s)) =========
-- Requires: laboratory schema, safety schema
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_result` ADD CONSTRAINT `fk_laboratory_lab_result_ctcae_grade_id` FOREIGN KEY (`ctcae_grade_id`) REFERENCES `clinical_trials_ecm`.`safety`.`ctcae_grade`(`ctcae_grade_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`reference_range` ADD CONSTRAINT `fk_laboratory_reference_range_ctcae_grade_id` FOREIGN KEY (`ctcae_grade_id`) REFERENCES `clinical_trials_ecm`.`safety`.`ctcae_grade`(`ctcae_grade_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`critical_value` ADD CONSTRAINT `fk_laboratory_critical_value_ctcae_grade_id` FOREIGN KEY (`ctcae_grade_id`) REFERENCES `clinical_trials_ecm`.`safety`.`ctcae_grade`(`ctcae_grade_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`critical_value` ADD CONSTRAINT `fk_laboratory_critical_value_meddra_term_id` FOREIGN KEY (`meddra_term_id`) REFERENCES `clinical_trials_ecm`.`safety`.`meddra_term`(`meddra_term_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`pk_sample` ADD CONSTRAINT `fk_laboratory_pk_sample_adverse_event_id` FOREIGN KEY (`adverse_event_id`) REFERENCES `clinical_trials_ecm`.`safety`.`adverse_event`(`adverse_event_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_result` ADD CONSTRAINT `fk_laboratory_bioanalytical_result_adverse_event_id` FOREIGN KEY (`adverse_event_id`) REFERENCES `clinical_trials_ecm`.`safety`.`adverse_event`(`adverse_event_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_query` ADD CONSTRAINT `fk_laboratory_lab_query_adverse_event_id` FOREIGN KEY (`adverse_event_id`) REFERENCES `clinical_trials_ecm`.`safety`.`adverse_event`(`adverse_event_id`);

-- ========= laboratory --> site (9 constraint(s)) =========
-- Requires: laboratory schema, site schema
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_result` ADD CONSTRAINT `fk_laboratory_lab_result_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_collection` ADD CONSTRAINT `fk_laboratory_specimen_collection_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_shipment` ADD CONSTRAINT `fk_laboratory_specimen_shipment_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_shipment` ADD CONSTRAINT `fk_laboratory_specimen_shipment_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`pk_sample` ADD CONSTRAINT `fk_laboratory_pk_sample_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_kit` ADD CONSTRAINT `fk_laboratory_lab_kit_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_query` ADD CONSTRAINT `fk_laboratory_lab_query_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_aliquot` ADD CONSTRAINT `fk_laboratory_specimen_aliquot_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);

-- ========= laboratory --> study (34 constraint(s)) =========
-- Requires: laboratory schema, study schema
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_study_visit_schedule_id` FOREIGN KEY (`study_visit_schedule_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_visit_schedule`(`study_visit_schedule_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_result` ADD CONSTRAINT `fk_laboratory_lab_result_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_result` ADD CONSTRAINT `fk_laboratory_lab_result_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_result` ADD CONSTRAINT `fk_laboratory_lab_result_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_result` ADD CONSTRAINT `fk_laboratory_lab_result_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_result` ADD CONSTRAINT `fk_laboratory_lab_result_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_result` ADD CONSTRAINT `fk_laboratory_lab_result_study_visit_schedule_id` FOREIGN KEY (`study_visit_schedule_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_visit_schedule`(`study_visit_schedule_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_collection` ADD CONSTRAINT `fk_laboratory_specimen_collection_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_collection` ADD CONSTRAINT `fk_laboratory_specimen_collection_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_collection` ADD CONSTRAINT `fk_laboratory_specimen_collection_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_collection` ADD CONSTRAINT `fk_laboratory_specimen_collection_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_collection` ADD CONSTRAINT `fk_laboratory_specimen_collection_study_visit_schedule_id` FOREIGN KEY (`study_visit_schedule_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_visit_schedule`(`study_visit_schedule_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_shipment` ADD CONSTRAINT `fk_laboratory_specimen_shipment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`reference_range` ADD CONSTRAINT `fk_laboratory_reference_range_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`reference_range` ADD CONSTRAINT `fk_laboratory_reference_range_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`reference_range` ADD CONSTRAINT `fk_laboratory_reference_range_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`pk_sample` ADD CONSTRAINT `fk_laboratory_pk_sample_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`pk_sample` ADD CONSTRAINT `fk_laboratory_pk_sample_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`pk_sample` ADD CONSTRAINT `fk_laboratory_pk_sample_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`pk_sample` ADD CONSTRAINT `fk_laboratory_pk_sample_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`pk_sample` ADD CONSTRAINT `fk_laboratory_pk_sample_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`pk_sample` ADD CONSTRAINT `fk_laboratory_pk_sample_study_visit_schedule_id` FOREIGN KEY (`study_visit_schedule_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_visit_schedule`(`study_visit_schedule_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_assay` ADD CONSTRAINT `fk_laboratory_bioanalytical_assay_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `clinical_trials_ecm`.`study`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_result` ADD CONSTRAINT `fk_laboratory_bioanalytical_result_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_result` ADD CONSTRAINT `fk_laboratory_bioanalytical_result_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_result` ADD CONSTRAINT `fk_laboratory_bioanalytical_result_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_result` ADD CONSTRAINT `fk_laboratory_bioanalytical_result_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_result` ADD CONSTRAINT `fk_laboratory_bioanalytical_result_study_visit_schedule_id` FOREIGN KEY (`study_visit_schedule_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_visit_schedule`(`study_visit_schedule_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_kit` ADD CONSTRAINT `fk_laboratory_lab_kit_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_kit` ADD CONSTRAINT `fk_laboratory_lab_kit_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_kit` ADD CONSTRAINT `fk_laboratory_lab_kit_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_kit` ADD CONSTRAINT `fk_laboratory_lab_kit_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_query` ADD CONSTRAINT `fk_laboratory_lab_query_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_aliquot` ADD CONSTRAINT `fk_laboratory_specimen_aliquot_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);

-- ========= laboratory --> subject (17 constraint(s)) =========
-- Requires: laboratory schema, subject schema
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_result` ADD CONSTRAINT `fk_laboratory_lab_result_enrollment_id` FOREIGN KEY (`enrollment_id`) REFERENCES `clinical_trials_ecm`.`subject`.`enrollment`(`enrollment_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_result` ADD CONSTRAINT `fk_laboratory_lab_result_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_result` ADD CONSTRAINT `fk_laboratory_lab_result_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_collection` ADD CONSTRAINT `fk_laboratory_specimen_collection_enrollment_id` FOREIGN KEY (`enrollment_id`) REFERENCES `clinical_trials_ecm`.`subject`.`enrollment`(`enrollment_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_collection` ADD CONSTRAINT `fk_laboratory_specimen_collection_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_collection` ADD CONSTRAINT `fk_laboratory_specimen_collection_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`pk_sample` ADD CONSTRAINT `fk_laboratory_pk_sample_enrollment_id` FOREIGN KEY (`enrollment_id`) REFERENCES `clinical_trials_ecm`.`subject`.`enrollment`(`enrollment_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`pk_sample` ADD CONSTRAINT `fk_laboratory_pk_sample_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`pk_sample` ADD CONSTRAINT `fk_laboratory_pk_sample_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_result` ADD CONSTRAINT `fk_laboratory_bioanalytical_result_enrollment_id` FOREIGN KEY (`enrollment_id`) REFERENCES `clinical_trials_ecm`.`subject`.`enrollment`(`enrollment_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_result` ADD CONSTRAINT `fk_laboratory_bioanalytical_result_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_query` ADD CONSTRAINT `fk_laboratory_lab_query_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_query` ADD CONSTRAINT `fk_laboratory_lab_query_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_aliquot` ADD CONSTRAINT `fk_laboratory_specimen_aliquot_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_aliquot` ADD CONSTRAINT `fk_laboratory_specimen_aliquot_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);

-- ========= laboratory --> supply (9 constraint(s)) =========
-- Requires: laboratory schema, supply schema
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_panel` ADD CONSTRAINT `fk_laboratory_lab_panel_imp_master_id` FOREIGN KEY (`imp_master_id`) REFERENCES `clinical_trials_ecm`.`supply`.`imp_master`(`imp_master_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `clinical_trials_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`critical_value` ADD CONSTRAINT `fk_laboratory_critical_value_imp_master_id` FOREIGN KEY (`imp_master_id`) REFERENCES `clinical_trials_ecm`.`supply`.`imp_master`(`imp_master_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`pk_sample` ADD CONSTRAINT `fk_laboratory_pk_sample_manufacture_batch_id` FOREIGN KEY (`manufacture_batch_id`) REFERENCES `clinical_trials_ecm`.`supply`.`manufacture_batch`(`manufacture_batch_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`pk_sample` ADD CONSTRAINT `fk_laboratory_pk_sample_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `clinical_trials_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_assay` ADD CONSTRAINT `fk_laboratory_bioanalytical_assay_imp_master_id` FOREIGN KEY (`imp_master_id`) REFERENCES `clinical_trials_ecm`.`supply`.`imp_master`(`imp_master_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_result` ADD CONSTRAINT `fk_laboratory_bioanalytical_result_manufacture_batch_id` FOREIGN KEY (`manufacture_batch_id`) REFERENCES `clinical_trials_ecm`.`supply`.`manufacture_batch`(`manufacture_batch_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_accreditation` ADD CONSTRAINT `fk_laboratory_lab_accreditation_imp_master_id` FOREIGN KEY (`imp_master_id`) REFERENCES `clinical_trials_ecm`.`supply`.`imp_master`(`imp_master_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_aliquot` ADD CONSTRAINT `fk_laboratory_specimen_aliquot_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `clinical_trials_ecm`.`supply`.`shipment`(`shipment_id`);

-- ========= monitoring --> biostatistics (4 constraint(s)) =========
-- Requires: monitoring schema, biostatistics schema
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`risk_indicator` ADD CONSTRAINT `fk_monitoring_risk_indicator_statistical_endpoint_id` FOREIGN KEY (`statistical_endpoint_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`statistical_endpoint`(`statistical_endpoint_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_visit_schedule` ADD CONSTRAINT `fk_monitoring_monitoring_visit_schedule_interim_analysis_id` FOREIGN KEY (`interim_analysis_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`interim_analysis`(`interim_analysis_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`central_monitoring_alert` ADD CONSTRAINT `fk_monitoring_central_monitoring_alert_interim_analysis_id` FOREIGN KEY (`interim_analysis_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`interim_analysis`(`interim_analysis_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`central_monitoring_alert` ADD CONSTRAINT `fk_monitoring_central_monitoring_alert_statistical_endpoint_id` FOREIGN KEY (`statistical_endpoint_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`statistical_endpoint`(`statistical_endpoint_id`);

-- ========= monitoring --> compliance (32 constraint(s)) =========
-- Requires: monitoring schema, compliance schema
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_plan` ADD CONSTRAINT `fk_monitoring_monitoring_plan_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_report` ADD CONSTRAINT `fk_monitoring_visit_report_quality_event_id` FOREIGN KEY (`quality_event_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`quality_event`(`quality_event_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`capa`(`capa_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_quality_event_id` FOREIGN KEY (`quality_event_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`quality_event`(`quality_event_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_deviation_finding` ADD CONSTRAINT `fk_monitoring_visit_deviation_finding_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_deviation_finding` ADD CONSTRAINT `fk_monitoring_visit_deviation_finding_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`capa`(`capa_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_deviation_finding` ADD CONSTRAINT `fk_monitoring_visit_deviation_finding_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_deviation_finding` ADD CONSTRAINT `fk_monitoring_visit_deviation_finding_deviation_classification_id` FOREIGN KEY (`deviation_classification_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`deviation_classification`(`deviation_classification_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_deviation_finding` ADD CONSTRAINT `fk_monitoring_visit_deviation_finding_inspection_finding_id` FOREIGN KEY (`inspection_finding_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`inspection_finding`(`inspection_finding_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`capa`(`capa_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_inspection_finding_id` FOREIGN KEY (`inspection_finding_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`inspection_finding`(`inspection_finding_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_action_item` ADD CONSTRAINT `fk_monitoring_monitoring_action_item_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_action_item` ADD CONSTRAINT `fk_monitoring_monitoring_action_item_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`capa`(`capa_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_action_item` ADD CONSTRAINT `fk_monitoring_monitoring_action_item_inspection_finding_id` FOREIGN KEY (`inspection_finding_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`inspection_finding`(`inspection_finding_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_action_item` ADD CONSTRAINT `fk_monitoring_monitoring_action_item_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_action_item` ADD CONSTRAINT `fk_monitoring_monitoring_action_item_quality_event_id` FOREIGN KEY (`quality_event_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`quality_event`(`quality_event_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_action_item` ADD CONSTRAINT `fk_monitoring_monitoring_action_item_regulatory_commitment_id` FOREIGN KEY (`regulatory_commitment_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`regulatory_commitment`(`regulatory_commitment_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`risk_indicator` ADD CONSTRAINT `fk_monitoring_risk_indicator_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`capa`(`capa_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`risk_indicator` ADD CONSTRAINT `fk_monitoring_risk_indicator_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`site_risk_assessment` ADD CONSTRAINT `fk_monitoring_site_risk_assessment_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`site_risk_assessment` ADD CONSTRAINT `fk_monitoring_site_risk_assessment_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`capa`(`capa_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`site_risk_assessment` ADD CONSTRAINT `fk_monitoring_site_risk_assessment_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_cra_assignment` ADD CONSTRAINT `fk_monitoring_monitoring_cra_assignment_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`capa`(`capa_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_checklist` ADD CONSTRAINT `fk_monitoring_visit_checklist_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`capa`(`capa_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_checklist` ADD CONSTRAINT `fk_monitoring_visit_checklist_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_checklist` ADD CONSTRAINT `fk_monitoring_visit_checklist_sop_training_requirement_id` FOREIGN KEY (`sop_training_requirement_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`sop_training_requirement`(`sop_training_requirement_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`central_monitoring_alert` ADD CONSTRAINT `fk_monitoring_central_monitoring_alert_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`capa`(`capa_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`central_monitoring_alert` ADD CONSTRAINT `fk_monitoring_central_monitoring_alert_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`central_monitoring_alert` ADD CONSTRAINT `fk_monitoring_central_monitoring_alert_quality_event_id` FOREIGN KEY (`quality_event_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`quality_event`(`quality_event_id`);

-- ========= monitoring --> data (12 constraint(s)) =========
-- Requires: monitoring schema, data schema
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_visit` ADD CONSTRAINT `fk_monitoring_monitoring_visit_edc_study_build_id` FOREIGN KEY (`edc_study_build_id`) REFERENCES `clinical_trials_ecm`.`data`.`edc_study_build`(`edc_study_build_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_discrepancy_query_id` FOREIGN KEY (`discrepancy_query_id`) REFERENCES `clinical_trials_ecm`.`data`.`discrepancy_query`(`discrepancy_query_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_ecrf_field_id` FOREIGN KEY (`ecrf_field_id`) REFERENCES `clinical_trials_ecm`.`data`.`ecrf_field`(`ecrf_field_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_ecrf_form_id` FOREIGN KEY (`ecrf_form_id`) REFERENCES `clinical_trials_ecm`.`data`.`ecrf_form`(`ecrf_form_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_field_entry_id` FOREIGN KEY (`field_entry_id`) REFERENCES `clinical_trials_ecm`.`data`.`field_entry`(`field_entry_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_subject_visit_data_id` FOREIGN KEY (`subject_visit_data_id`) REFERENCES `clinical_trials_ecm`.`data`.`subject_visit_data`(`subject_visit_data_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_deviation_finding` ADD CONSTRAINT `fk_monitoring_visit_deviation_finding_subject_visit_data_id` FOREIGN KEY (`subject_visit_data_id`) REFERENCES `clinical_trials_ecm`.`data`.`subject_visit_data`(`subject_visit_data_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_discrepancy_query_id` FOREIGN KEY (`discrepancy_query_id`) REFERENCES `clinical_trials_ecm`.`data`.`discrepancy_query`(`discrepancy_query_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_subject_visit_data_id` FOREIGN KEY (`subject_visit_data_id`) REFERENCES `clinical_trials_ecm`.`data`.`subject_visit_data`(`subject_visit_data_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_validation_rule_id` FOREIGN KEY (`validation_rule_id`) REFERENCES `clinical_trials_ecm`.`data`.`validation_rule`(`validation_rule_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`site_risk_assessment` ADD CONSTRAINT `fk_monitoring_site_risk_assessment_dmp_id` FOREIGN KEY (`dmp_id`) REFERENCES `clinical_trials_ecm`.`data`.`dmp`(`dmp_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`central_monitoring_alert` ADD CONSTRAINT `fk_monitoring_central_monitoring_alert_validation_rule_id` FOREIGN KEY (`validation_rule_id`) REFERENCES `clinical_trials_ecm`.`data`.`validation_rule`(`validation_rule_id`);

-- ========= monitoring --> document (17 constraint(s)) =========
-- Requires: monitoring schema, document schema
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_plan` ADD CONSTRAINT `fk_monitoring_monitoring_plan_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_plan` ADD CONSTRAINT `fk_monitoring_monitoring_plan_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_visit` ADD CONSTRAINT `fk_monitoring_monitoring_visit_site_file_id` FOREIGN KEY (`site_file_id`) REFERENCES `clinical_trials_ecm`.`document`.`site_file`(`site_file_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_report` ADD CONSTRAINT `fk_monitoring_visit_report_site_file_id` FOREIGN KEY (`site_file_id`) REFERENCES `clinical_trials_ecm`.`document`.`site_file`(`site_file_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_report` ADD CONSTRAINT `fk_monitoring_visit_report_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_version_id` FOREIGN KEY (`version_id`) REFERENCES `clinical_trials_ecm`.`document`.`version`(`version_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_deviation_finding` ADD CONSTRAINT `fk_monitoring_visit_deviation_finding_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_action_item` ADD CONSTRAINT `fk_monitoring_monitoring_action_item_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`site_risk_assessment` ADD CONSTRAINT `fk_monitoring_site_risk_assessment_inspection_readiness_id` FOREIGN KEY (`inspection_readiness_id`) REFERENCES `clinical_trials_ecm`.`document`.`inspection_readiness`(`inspection_readiness_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`site_risk_assessment` ADD CONSTRAINT `fk_monitoring_site_risk_assessment_site_file_id` FOREIGN KEY (`site_file_id`) REFERENCES `clinical_trials_ecm`.`document`.`site_file`(`site_file_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`site_risk_assessment` ADD CONSTRAINT `fk_monitoring_site_risk_assessment_tmf_completeness_id` FOREIGN KEY (`tmf_completeness_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_completeness`(`tmf_completeness_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_checklist` ADD CONSTRAINT `fk_monitoring_visit_checklist_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_checklist` ADD CONSTRAINT `fk_monitoring_visit_checklist_site_file_id` FOREIGN KEY (`site_file_id`) REFERENCES `clinical_trials_ecm`.`document`.`site_file`(`site_file_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_checklist` ADD CONSTRAINT `fk_monitoring_visit_checklist_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`central_monitoring_alert` ADD CONSTRAINT `fk_monitoring_central_monitoring_alert_inspection_readiness_id` FOREIGN KEY (`inspection_readiness_id`) REFERENCES `clinical_trials_ecm`.`document`.`inspection_readiness`(`inspection_readiness_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`central_monitoring_alert` ADD CONSTRAINT `fk_monitoring_central_monitoring_alert_tmf_completeness_id` FOREIGN KEY (`tmf_completeness_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_completeness`(`tmf_completeness_id`);

-- ========= monitoring --> laboratory (11 constraint(s)) =========
-- Requires: monitoring schema, laboratory schema
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_bioanalytical_result_id` FOREIGN KEY (`bioanalytical_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`bioanalytical_result`(`bioanalytical_result_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_lab_result_id` FOREIGN KEY (`lab_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_result`(`lab_result_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_specimen_collection_id` FOREIGN KEY (`specimen_collection_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`specimen_collection`(`specimen_collection_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_deviation_finding` ADD CONSTRAINT `fk_monitoring_visit_deviation_finding_lab_kit_id` FOREIGN KEY (`lab_kit_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_kit`(`lab_kit_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_deviation_finding` ADD CONSTRAINT `fk_monitoring_visit_deviation_finding_lab_result_id` FOREIGN KEY (`lab_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_result`(`lab_result_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_lab_result_id` FOREIGN KEY (`lab_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_result`(`lab_result_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`risk_indicator` ADD CONSTRAINT `fk_monitoring_risk_indicator_lab_facility_id` FOREIGN KEY (`lab_facility_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_facility`(`lab_facility_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`risk_indicator` ADD CONSTRAINT `fk_monitoring_risk_indicator_lab_panel_id` FOREIGN KEY (`lab_panel_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_panel`(`lab_panel_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`site_risk_assessment` ADD CONSTRAINT `fk_monitoring_site_risk_assessment_lab_accreditation_id` FOREIGN KEY (`lab_accreditation_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_accreditation`(`lab_accreditation_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_checklist` ADD CONSTRAINT `fk_monitoring_visit_checklist_lab_kit_id` FOREIGN KEY (`lab_kit_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_kit`(`lab_kit_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`central_monitoring_alert` ADD CONSTRAINT `fk_monitoring_central_monitoring_alert_lab_result_id` FOREIGN KEY (`lab_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_result`(`lab_result_id`);

-- ========= monitoring --> randomization (7 constraint(s)) =========
-- Requires: monitoring schema, randomization schema
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_plan` ADD CONSTRAINT `fk_monitoring_monitoring_plan_rand_scheme_id` FOREIGN KEY (`rand_scheme_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_scheme`(`rand_scheme_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_visit` ADD CONSTRAINT `fk_monitoring_monitoring_visit_blinding_config_id` FOREIGN KEY (`blinding_config_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`blinding_config`(`blinding_config_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_visit` ADD CONSTRAINT `fk_monitoring_monitoring_visit_rand_list_id` FOREIGN KEY (`rand_list_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_list`(`rand_list_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_deviation_finding` ADD CONSTRAINT `fk_monitoring_visit_deviation_finding_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`risk_indicator` ADD CONSTRAINT `fk_monitoring_risk_indicator_rand_scheme_id` FOREIGN KEY (`rand_scheme_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_scheme`(`rand_scheme_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`central_monitoring_alert` ADD CONSTRAINT `fk_monitoring_central_monitoring_alert_rand_scheme_id` FOREIGN KEY (`rand_scheme_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_scheme`(`rand_scheme_id`);

-- ========= monitoring --> regulatory (15 constraint(s)) =========
-- Requires: monitoring schema, regulatory schema
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_plan` ADD CONSTRAINT `fk_monitoring_monitoring_plan_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_plan` ADD CONSTRAINT `fk_monitoring_monitoring_plan_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_plan` ADD CONSTRAINT `fk_monitoring_monitoring_plan_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_plan` ADD CONSTRAINT `fk_monitoring_monitoring_plan_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`strategy`(`strategy_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_visit` ADD CONSTRAINT `fk_monitoring_monitoring_visit_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_report` ADD CONSTRAINT `fk_monitoring_visit_report_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_deviation_finding` ADD CONSTRAINT `fk_monitoring_visit_deviation_finding_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_action_item` ADD CONSTRAINT `fk_monitoring_monitoring_action_item_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`site_risk_assessment` ADD CONSTRAINT `fk_monitoring_site_risk_assessment_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`site_risk_assessment` ADD CONSTRAINT `fk_monitoring_site_risk_assessment_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_cra_assignment` ADD CONSTRAINT `fk_monitoring_monitoring_cra_assignment_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`central_monitoring_alert` ADD CONSTRAINT `fk_monitoring_central_monitoring_alert_safety_report_submission_id` FOREIGN KEY (`safety_report_submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`safety_report_submission`(`safety_report_submission_id`);

-- ========= monitoring --> safety (10 constraint(s)) =========
-- Requires: monitoring schema, safety schema
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_plan` ADD CONSTRAINT `fk_monitoring_monitoring_plan_reporting_obligation_id` FOREIGN KEY (`reporting_obligation_id`) REFERENCES `clinical_trials_ecm`.`safety`.`reporting_obligation`(`reporting_obligation_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_adverse_event_id` FOREIGN KEY (`adverse_event_id`) REFERENCES `clinical_trials_ecm`.`safety`.`adverse_event`(`adverse_event_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_deviation_finding` ADD CONSTRAINT `fk_monitoring_visit_deviation_finding_adverse_event_id` FOREIGN KEY (`adverse_event_id`) REFERENCES `clinical_trials_ecm`.`safety`.`adverse_event`(`adverse_event_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_adverse_event_id` FOREIGN KEY (`adverse_event_id`) REFERENCES `clinical_trials_ecm`.`safety`.`adverse_event`(`adverse_event_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_action_item` ADD CONSTRAINT `fk_monitoring_monitoring_action_item_serious_adverse_event_id` FOREIGN KEY (`serious_adverse_event_id`) REFERENCES `clinical_trials_ecm`.`safety`.`serious_adverse_event`(`serious_adverse_event_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`risk_indicator` ADD CONSTRAINT `fk_monitoring_risk_indicator_signal_id` FOREIGN KEY (`signal_id`) REFERENCES `clinical_trials_ecm`.`safety`.`signal`(`signal_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_checklist` ADD CONSTRAINT `fk_monitoring_visit_checklist_reporting_obligation_id` FOREIGN KEY (`reporting_obligation_id`) REFERENCES `clinical_trials_ecm`.`safety`.`reporting_obligation`(`reporting_obligation_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`central_monitoring_alert` ADD CONSTRAINT `fk_monitoring_central_monitoring_alert_serious_adverse_event_id` FOREIGN KEY (`serious_adverse_event_id`) REFERENCES `clinical_trials_ecm`.`safety`.`serious_adverse_event`(`serious_adverse_event_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`central_monitoring_alert` ADD CONSTRAINT `fk_monitoring_central_monitoring_alert_signal_id` FOREIGN KEY (`signal_id`) REFERENCES `clinical_trials_ecm`.`safety`.`signal`(`signal_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`central_monitoring_alert` ADD CONSTRAINT `fk_monitoring_central_monitoring_alert_susar_id` FOREIGN KEY (`susar_id`) REFERENCES `clinical_trials_ecm`.`safety`.`susar`(`susar_id`);

-- ========= monitoring --> site (17 constraint(s)) =========
-- Requires: monitoring schema, site schema
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_visit` ADD CONSTRAINT `fk_monitoring_monitoring_visit_activation_id` FOREIGN KEY (`activation_id`) REFERENCES `clinical_trials_ecm`.`site`.`activation`(`activation_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_visit` ADD CONSTRAINT `fk_monitoring_monitoring_visit_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_report` ADD CONSTRAINT `fk_monitoring_visit_report_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_deviation_finding` ADD CONSTRAINT `fk_monitoring_visit_deviation_finding_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_action_item` ADD CONSTRAINT `fk_monitoring_monitoring_action_item_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`risk_indicator` ADD CONSTRAINT `fk_monitoring_risk_indicator_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`site_risk_assessment` ADD CONSTRAINT `fk_monitoring_site_risk_assessment_enrollment_performance_id` FOREIGN KEY (`enrollment_performance_id`) REFERENCES `clinical_trials_ecm`.`site`.`enrollment_performance`(`enrollment_performance_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`site_risk_assessment` ADD CONSTRAINT `fk_monitoring_site_risk_assessment_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`site_risk_assessment` ADD CONSTRAINT `fk_monitoring_site_risk_assessment_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_cra_assignment` ADD CONSTRAINT `fk_monitoring_monitoring_cra_assignment_activation_id` FOREIGN KEY (`activation_id`) REFERENCES `clinical_trials_ecm`.`site`.`activation`(`activation_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_cra_assignment` ADD CONSTRAINT `fk_monitoring_monitoring_cra_assignment_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_visit_schedule` ADD CONSTRAINT `fk_monitoring_monitoring_visit_schedule_activation_id` FOREIGN KEY (`activation_id`) REFERENCES `clinical_trials_ecm`.`site`.`activation`(`activation_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_visit_schedule` ADD CONSTRAINT `fk_monitoring_monitoring_visit_schedule_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_checklist` ADD CONSTRAINT `fk_monitoring_visit_checklist_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`central_monitoring_alert` ADD CONSTRAINT `fk_monitoring_central_monitoring_alert_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);

-- ========= monitoring --> study (41 constraint(s)) =========
-- Requires: monitoring schema, study schema
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_plan` ADD CONSTRAINT `fk_monitoring_monitoring_plan_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `clinical_trials_ecm`.`study`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_plan` ADD CONSTRAINT `fk_monitoring_monitoring_plan_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_plan` ADD CONSTRAINT `fk_monitoring_monitoring_plan_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_visit` ADD CONSTRAINT `fk_monitoring_monitoring_visit_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_visit` ADD CONSTRAINT `fk_monitoring_monitoring_visit_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_visit` ADD CONSTRAINT `fk_monitoring_monitoring_visit_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_report` ADD CONSTRAINT `fk_monitoring_visit_report_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_report` ADD CONSTRAINT `fk_monitoring_visit_report_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_report` ADD CONSTRAINT `fk_monitoring_visit_report_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_study_visit_schedule_id` FOREIGN KEY (`study_visit_schedule_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_visit_schedule`(`study_visit_schedule_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_visit_procedure_id` FOREIGN KEY (`visit_procedure_id`) REFERENCES `clinical_trials_ecm`.`study`.`visit_procedure`(`visit_procedure_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_deviation_finding` ADD CONSTRAINT `fk_monitoring_visit_deviation_finding_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_deviation_finding` ADD CONSTRAINT `fk_monitoring_visit_deviation_finding_eligibility_criterion_id` FOREIGN KEY (`eligibility_criterion_id`) REFERENCES `clinical_trials_ecm`.`study`.`eligibility_criterion`(`eligibility_criterion_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_deviation_finding` ADD CONSTRAINT `fk_monitoring_visit_deviation_finding_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_deviation_finding` ADD CONSTRAINT `fk_monitoring_visit_deviation_finding_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_deviation_finding` ADD CONSTRAINT `fk_monitoring_visit_deviation_finding_visit_procedure_id` FOREIGN KEY (`visit_procedure_id`) REFERENCES `clinical_trials_ecm`.`study`.`visit_procedure`(`visit_procedure_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_eligibility_criterion_id` FOREIGN KEY (`eligibility_criterion_id`) REFERENCES `clinical_trials_ecm`.`study`.`eligibility_criterion`(`eligibility_criterion_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_visit_procedure_id` FOREIGN KEY (`visit_procedure_id`) REFERENCES `clinical_trials_ecm`.`study`.`visit_procedure`(`visit_procedure_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_action_item` ADD CONSTRAINT `fk_monitoring_monitoring_action_item_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_action_item` ADD CONSTRAINT `fk_monitoring_monitoring_action_item_visit_procedure_id` FOREIGN KEY (`visit_procedure_id`) REFERENCES `clinical_trials_ecm`.`study`.`visit_procedure`(`visit_procedure_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`risk_indicator` ADD CONSTRAINT `fk_monitoring_risk_indicator_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `clinical_trials_ecm`.`study`.`endpoint`(`endpoint_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`risk_indicator` ADD CONSTRAINT `fk_monitoring_risk_indicator_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`risk_indicator` ADD CONSTRAINT `fk_monitoring_risk_indicator_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`site_risk_assessment` ADD CONSTRAINT `fk_monitoring_site_risk_assessment_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`site_risk_assessment` ADD CONSTRAINT `fk_monitoring_site_risk_assessment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`site_risk_assessment` ADD CONSTRAINT `fk_monitoring_site_risk_assessment_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_cra_assignment` ADD CONSTRAINT `fk_monitoring_monitoring_cra_assignment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_visit_schedule` ADD CONSTRAINT `fk_monitoring_monitoring_visit_schedule_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_visit_schedule` ADD CONSTRAINT `fk_monitoring_monitoring_visit_schedule_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_visit_schedule` ADD CONSTRAINT `fk_monitoring_monitoring_visit_schedule_study_milestone_id` FOREIGN KEY (`study_milestone_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_milestone`(`study_milestone_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_checklist` ADD CONSTRAINT `fk_monitoring_visit_checklist_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_checklist` ADD CONSTRAINT `fk_monitoring_visit_checklist_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_checklist` ADD CONSTRAINT `fk_monitoring_visit_checklist_study_visit_schedule_id` FOREIGN KEY (`study_visit_schedule_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_visit_schedule`(`study_visit_schedule_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_checklist` ADD CONSTRAINT `fk_monitoring_visit_checklist_visit_procedure_id` FOREIGN KEY (`visit_procedure_id`) REFERENCES `clinical_trials_ecm`.`study`.`visit_procedure`(`visit_procedure_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`central_monitoring_alert` ADD CONSTRAINT `fk_monitoring_central_monitoring_alert_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `clinical_trials_ecm`.`study`.`endpoint`(`endpoint_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`central_monitoring_alert` ADD CONSTRAINT `fk_monitoring_central_monitoring_alert_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);

-- ========= monitoring --> subject (8 constraint(s)) =========
-- Requires: monitoring schema, subject schema
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_deviation_finding` ADD CONSTRAINT `fk_monitoring_visit_deviation_finding_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `clinical_trials_ecm`.`subject`.`deviation`(`deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_deviation_finding` ADD CONSTRAINT `fk_monitoring_visit_deviation_finding_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `clinical_trials_ecm`.`subject`.`deviation`(`deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_action_item` ADD CONSTRAINT `fk_monitoring_monitoring_action_item_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_action_item` ADD CONSTRAINT `fk_monitoring_monitoring_action_item_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`central_monitoring_alert` ADD CONSTRAINT `fk_monitoring_central_monitoring_alert_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);

-- ========= monitoring --> supply (1 constraint(s)) =========
-- Requires: monitoring schema, supply schema
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_temperature_excursion_id` FOREIGN KEY (`temperature_excursion_id`) REFERENCES `clinical_trials_ecm`.`supply`.`temperature_excursion`(`temperature_excursion_id`);

-- ========= randomization --> compliance (3 constraint(s)) =========
-- Requires: randomization schema, compliance schema
ALTER TABLE `clinical_trials_ecm`.`randomization`.`subject_randomization` ADD CONSTRAINT `fk_randomization_subject_randomization_ethics_approval_id` FOREIGN KEY (`ethics_approval_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_approval`(`ethics_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`kit_assignment` ADD CONSTRAINT `fk_randomization_kit_assignment_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_request` ADD CONSTRAINT `fk_randomization_unblinding_request_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);

-- ========= randomization --> data (1 constraint(s)) =========
-- Requires: randomization schema, data schema
ALTER TABLE `clinical_trials_ecm`.`randomization`.`stratification_factor` ADD CONSTRAINT `fk_randomization_stratification_factor_ecrf_field_id` FOREIGN KEY (`ecrf_field_id`) REFERENCES `clinical_trials_ecm`.`data`.`ecrf_field`(`ecrf_field_id`);

-- ========= randomization --> document (13 constraint(s)) =========
-- Requires: randomization schema, document schema
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_scheme` ADD CONSTRAINT `fk_randomization_rand_scheme_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_scheme` ADD CONSTRAINT `fk_randomization_rand_scheme_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_list` ADD CONSTRAINT `fk_randomization_rand_list_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_list` ADD CONSTRAINT `fk_randomization_rand_list_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_list` ADD CONSTRAINT `fk_randomization_rand_list_workflow_id` FOREIGN KEY (`workflow_id`) REFERENCES `clinical_trials_ecm`.`document`.`workflow`(`workflow_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`blinding_config` ADD CONSTRAINT `fk_randomization_blinding_config_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`blinding_config` ADD CONSTRAINT `fk_randomization_blinding_config_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_request` ADD CONSTRAINT `fk_randomization_unblinding_request_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_request` ADD CONSTRAINT `fk_randomization_unblinding_request_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_request` ADD CONSTRAINT `fk_randomization_unblinding_request_workflow_id` FOREIGN KEY (`workflow_id`) REFERENCES `clinical_trials_ecm`.`document`.`workflow`(`workflow_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_approval` ADD CONSTRAINT `fk_randomization_unblinding_approval_signature_id` FOREIGN KEY (`signature_id`) REFERENCES `clinical_trials_ecm`.`document`.`signature`(`signature_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_approval` ADD CONSTRAINT `fk_randomization_unblinding_approval_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_approval` ADD CONSTRAINT `fk_randomization_unblinding_approval_workflow_id` FOREIGN KEY (`workflow_id`) REFERENCES `clinical_trials_ecm`.`document`.`workflow`(`workflow_id`);

-- ========= randomization --> laboratory (1 constraint(s)) =========
-- Requires: randomization schema, laboratory schema
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_request` ADD CONSTRAINT `fk_randomization_unblinding_request_lab_result_id` FOREIGN KEY (`lab_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_result`(`lab_result_id`);

-- ========= randomization --> regulatory (8 constraint(s)) =========
-- Requires: randomization schema, regulatory schema
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_scheme` ADD CONSTRAINT `fk_randomization_rand_scheme_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_list` ADD CONSTRAINT `fk_randomization_rand_list_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`treatment_arm` ADD CONSTRAINT `fk_randomization_treatment_arm_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`treatment_arm` ADD CONSTRAINT `fk_randomization_treatment_arm_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`subject_randomization` ADD CONSTRAINT `fk_randomization_subject_randomization_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`subject_randomization` ADD CONSTRAINT `fk_randomization_subject_randomization_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`subject_randomization` ADD CONSTRAINT `fk_randomization_subject_randomization_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_request` ADD CONSTRAINT `fk_randomization_unblinding_request_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);

-- ========= randomization --> safety (4 constraint(s)) =========
-- Requires: randomization schema, safety schema
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_request` ADD CONSTRAINT `fk_randomization_unblinding_request_causality_assessment_id` FOREIGN KEY (`causality_assessment_id`) REFERENCES `clinical_trials_ecm`.`safety`.`causality_assessment`(`causality_assessment_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_request` ADD CONSTRAINT `fk_randomization_unblinding_request_serious_adverse_event_id` FOREIGN KEY (`serious_adverse_event_id`) REFERENCES `clinical_trials_ecm`.`safety`.`serious_adverse_event`(`serious_adverse_event_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_request` ADD CONSTRAINT `fk_randomization_unblinding_request_susar_id` FOREIGN KEY (`susar_id`) REFERENCES `clinical_trials_ecm`.`safety`.`susar`(`susar_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_approval` ADD CONSTRAINT `fk_randomization_unblinding_approval_serious_adverse_event_id` FOREIGN KEY (`serious_adverse_event_id`) REFERENCES `clinical_trials_ecm`.`safety`.`serious_adverse_event`(`serious_adverse_event_id`);

-- ========= randomization --> site (6 constraint(s)) =========
-- Requires: randomization schema, site schema
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_code` ADD CONSTRAINT `fk_randomization_rand_code_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`subject_randomization` ADD CONSTRAINT `fk_randomization_subject_randomization_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`irt_transaction` ADD CONSTRAINT `fk_randomization_irt_transaction_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`kit_assignment` ADD CONSTRAINT `fk_randomization_kit_assignment_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_request` ADD CONSTRAINT `fk_randomization_unblinding_request_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_approval` ADD CONSTRAINT `fk_randomization_unblinding_approval_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);

-- ========= randomization --> study (25 constraint(s)) =========
-- Requires: randomization schema, study schema
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_scheme` ADD CONSTRAINT `fk_randomization_rand_scheme_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_scheme` ADD CONSTRAINT `fk_randomization_rand_scheme_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_scheme` ADD CONSTRAINT `fk_randomization_rand_scheme_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_list` ADD CONSTRAINT `fk_randomization_rand_list_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_list` ADD CONSTRAINT `fk_randomization_rand_list_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_list` ADD CONSTRAINT `fk_randomization_rand_list_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_code` ADD CONSTRAINT `fk_randomization_rand_code_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`treatment_arm` ADD CONSTRAINT `fk_randomization_treatment_arm_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`treatment_arm` ADD CONSTRAINT `fk_randomization_treatment_arm_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `clinical_trials_ecm`.`study`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`treatment_arm` ADD CONSTRAINT `fk_randomization_treatment_arm_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`stratification_factor` ADD CONSTRAINT `fk_randomization_stratification_factor_eligibility_criterion_id` FOREIGN KEY (`eligibility_criterion_id`) REFERENCES `clinical_trials_ecm`.`study`.`eligibility_criterion`(`eligibility_criterion_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`stratification_factor` ADD CONSTRAINT `fk_randomization_stratification_factor_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`stratification_cell` ADD CONSTRAINT `fk_randomization_stratification_cell_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`subject_randomization` ADD CONSTRAINT `fk_randomization_subject_randomization_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`subject_randomization` ADD CONSTRAINT `fk_randomization_subject_randomization_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`subject_randomization` ADD CONSTRAINT `fk_randomization_subject_randomization_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`subject_randomization` ADD CONSTRAINT `fk_randomization_subject_randomization_study_visit_schedule_id` FOREIGN KEY (`study_visit_schedule_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_visit_schedule`(`study_visit_schedule_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`irt_transaction` ADD CONSTRAINT `fk_randomization_irt_transaction_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`irt_transaction` ADD CONSTRAINT `fk_randomization_irt_transaction_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`irt_transaction` ADD CONSTRAINT `fk_randomization_irt_transaction_study_visit_schedule_id` FOREIGN KEY (`study_visit_schedule_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_visit_schedule`(`study_visit_schedule_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`kit_assignment` ADD CONSTRAINT `fk_randomization_kit_assignment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`kit_assignment` ADD CONSTRAINT `fk_randomization_kit_assignment_study_visit_schedule_id` FOREIGN KEY (`study_visit_schedule_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_visit_schedule`(`study_visit_schedule_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`blinding_config` ADD CONSTRAINT `fk_randomization_blinding_config_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_request` ADD CONSTRAINT `fk_randomization_unblinding_request_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_approval` ADD CONSTRAINT `fk_randomization_unblinding_approval_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);

-- ========= randomization --> subject (6 constraint(s)) =========
-- Requires: randomization schema, subject schema
ALTER TABLE `clinical_trials_ecm`.`randomization`.`subject_randomization` ADD CONSTRAINT `fk_randomization_subject_randomization_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`irt_transaction` ADD CONSTRAINT `fk_randomization_irt_transaction_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`kit_assignment` ADD CONSTRAINT `fk_randomization_kit_assignment_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`kit_assignment` ADD CONSTRAINT `fk_randomization_kit_assignment_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_request` ADD CONSTRAINT `fk_randomization_unblinding_request_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_approval` ADD CONSTRAINT `fk_randomization_unblinding_approval_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);

-- ========= randomization --> supply (2 constraint(s)) =========
-- Requires: randomization schema, supply schema
ALTER TABLE `clinical_trials_ecm`.`randomization`.`irt_transaction` ADD CONSTRAINT `fk_randomization_irt_transaction_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `clinical_trials_ecm`.`supply`.`depot`(`depot_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`kit_assignment` ADD CONSTRAINT `fk_randomization_kit_assignment_kit_inventory_id` FOREIGN KEY (`kit_inventory_id`) REFERENCES `clinical_trials_ecm`.`supply`.`kit_inventory`(`kit_inventory_id`);

-- ========= regulatory --> compliance (20 constraint(s)) =========
-- Requires: regulatory schema, compliance schema
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment` ADD CONSTRAINT `fk_regulatory_regulatory_protocol_amendment_ethics_submission_id` FOREIGN KEY (`ethics_submission_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_submission`(`ethics_submission_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`correspondence` ADD CONSTRAINT `fk_regulatory_correspondence_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`agency_meeting` ADD CONSTRAINT `fk_regulatory_agency_meeting_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`ctd_dossier` ADD CONSTRAINT `fk_regulatory_ctd_dossier_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`ctd_dossier` ADD CONSTRAINT `fk_regulatory_ctd_dossier_ethics_approval_id` FOREIGN KEY (`ethics_approval_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_approval`(`ethics_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_milestone` ADD CONSTRAINT `fk_regulatory_regulatory_milestone_ethics_approval_id` FOREIGN KEY (`ethics_approval_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_approval`(`ethics_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`safety_report_submission` ADD CONSTRAINT `fk_regulatory_safety_report_submission_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`safety_report_submission` ADD CONSTRAINT `fk_regulatory_safety_report_submission_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`strategy` ADD CONSTRAINT `fk_regulatory_strategy_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_inspection` ADD CONSTRAINT `fk_regulatory_regulatory_inspection_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_inspection` ADD CONSTRAINT `fk_regulatory_regulatory_inspection_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`capa`(`capa_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_inspection` ADD CONSTRAINT `fk_regulatory_regulatory_inspection_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_inspection` ADD CONSTRAINT `fk_regulatory_regulatory_inspection_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`commitment` ADD CONSTRAINT `fk_regulatory_commitment_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_action_item` ADD CONSTRAINT `fk_regulatory_regulatory_action_item_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_action_item` ADD CONSTRAINT `fk_regulatory_regulatory_action_item_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`capa`(`capa_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_action_item` ADD CONSTRAINT `fk_regulatory_regulatory_action_item_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`country_registration` ADD CONSTRAINT `fk_regulatory_country_registration_ethics_approval_id` FOREIGN KEY (`ethics_approval_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_approval`(`ethics_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`country_registration` ADD CONSTRAINT `fk_regulatory_country_registration_ethics_submission_id` FOREIGN KEY (`ethics_submission_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_submission`(`ethics_submission_id`);

-- ========= regulatory --> data (2 constraint(s)) =========
-- Requires: regulatory schema, data schema
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`safety_report_submission` ADD CONSTRAINT `fk_regulatory_safety_report_submission_sdtm_dataset_id` FOREIGN KEY (`sdtm_dataset_id`) REFERENCES `clinical_trials_ecm`.`data`.`sdtm_dataset`(`sdtm_dataset_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`submission_content_unit` ADD CONSTRAINT `fk_regulatory_submission_content_unit_sdtm_dataset_id` FOREIGN KEY (`sdtm_dataset_id`) REFERENCES `clinical_trials_ecm`.`data`.`sdtm_dataset`(`sdtm_dataset_id`);

-- ========= regulatory --> document (20 constraint(s)) =========
-- Requires: regulatory schema, document schema
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`submission_sequence` ADD CONSTRAINT `fk_regulatory_submission_sequence_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`submission_sequence` ADD CONSTRAINT `fk_regulatory_submission_sequence_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment` ADD CONSTRAINT `fk_regulatory_regulatory_protocol_amendment_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`correspondence` ADD CONSTRAINT `fk_regulatory_correspondence_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`agency_meeting` ADD CONSTRAINT `fk_regulatory_agency_meeting_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`ctd_dossier` ADD CONSTRAINT `fk_regulatory_ctd_dossier_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`ctd_dossier` ADD CONSTRAINT `fk_regulatory_ctd_dossier_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`safety_report_submission` ADD CONSTRAINT `fk_regulatory_safety_report_submission_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`safety_report_submission` ADD CONSTRAINT `fk_regulatory_safety_report_submission_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization` ADD CONSTRAINT `fk_regulatory_clinical_trial_authorization_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_inspection` ADD CONSTRAINT `fk_regulatory_regulatory_inspection_site_file_id` FOREIGN KEY (`site_file_id`) REFERENCES `clinical_trials_ecm`.`document`.`site_file`(`site_file_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_inspection` ADD CONSTRAINT `fk_regulatory_regulatory_inspection_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`commitment` ADD CONSTRAINT `fk_regulatory_commitment_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`special_designation` ADD CONSTRAINT `fk_regulatory_special_designation_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_action_item` ADD CONSTRAINT `fk_regulatory_regulatory_action_item_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`country_registration` ADD CONSTRAINT `fk_regulatory_country_registration_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`procedure` ADD CONSTRAINT `fk_regulatory_procedure_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`submission_content_unit` ADD CONSTRAINT `fk_regulatory_submission_content_unit_version_id` FOREIGN KEY (`version_id`) REFERENCES `clinical_trials_ecm`.`document`.`version`(`version_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`submission_content_unit` ADD CONSTRAINT `fk_regulatory_submission_content_unit_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);

-- ========= regulatory --> laboratory (1 constraint(s)) =========
-- Requires: regulatory schema, laboratory schema
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_inspection` ADD CONSTRAINT `fk_regulatory_regulatory_inspection_lab_facility_id` FOREIGN KEY (`lab_facility_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_facility`(`lab_facility_id`);

-- ========= regulatory --> monitoring (1 constraint(s)) =========
-- Requires: regulatory schema, monitoring schema
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_action_item` ADD CONSTRAINT `fk_regulatory_regulatory_action_item_monitoring_action_item_id` FOREIGN KEY (`monitoring_action_item_id`) REFERENCES `clinical_trials_ecm`.`monitoring`.`monitoring_action_item`(`monitoring_action_item_id`);

-- ========= regulatory --> randomization (1 constraint(s)) =========
-- Requires: regulatory schema, randomization schema
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_action_item` ADD CONSTRAINT `fk_regulatory_regulatory_action_item_unblinding_request_id` FOREIGN KEY (`unblinding_request_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`unblinding_request`(`unblinding_request_id`);

-- ========= regulatory --> safety (1 constraint(s)) =========
-- Requires: regulatory schema, safety schema
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`safety_report_submission` ADD CONSTRAINT `fk_regulatory_safety_report_submission_icsr_id` FOREIGN KEY (`icsr_id`) REFERENCES `clinical_trials_ecm`.`safety`.`icsr`(`icsr_id`);

-- ========= regulatory --> site (1 constraint(s)) =========
-- Requires: regulatory schema, site schema
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_inspection` ADD CONSTRAINT `fk_regulatory_regulatory_inspection_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);

-- ========= regulatory --> study (23 constraint(s)) =========
-- Requires: regulatory schema, study schema
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`submission_sequence` ADD CONSTRAINT `fk_regulatory_submission_sequence_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment` ADD CONSTRAINT `fk_regulatory_regulatory_protocol_amendment_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment` ADD CONSTRAINT `fk_regulatory_regulatory_protocol_amendment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`correspondence` ADD CONSTRAINT `fk_regulatory_correspondence_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`correspondence` ADD CONSTRAINT `fk_regulatory_correspondence_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`agency_meeting` ADD CONSTRAINT `fk_regulatory_agency_meeting_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`agency_meeting` ADD CONSTRAINT `fk_regulatory_agency_meeting_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_milestone` ADD CONSTRAINT `fk_regulatory_regulatory_milestone_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`safety_report_submission` ADD CONSTRAINT `fk_regulatory_safety_report_submission_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`safety_report_submission` ADD CONSTRAINT `fk_regulatory_safety_report_submission_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization` ADD CONSTRAINT `fk_regulatory_clinical_trial_authorization_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`strategy` ADD CONSTRAINT `fk_regulatory_strategy_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_inspection` ADD CONSTRAINT `fk_regulatory_regulatory_inspection_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_inspection` ADD CONSTRAINT `fk_regulatory_regulatory_inspection_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`commitment` ADD CONSTRAINT `fk_regulatory_commitment_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`commitment` ADD CONSTRAINT `fk_regulatory_commitment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`special_designation` ADD CONSTRAINT `fk_regulatory_special_designation_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_action_item` ADD CONSTRAINT `fk_regulatory_regulatory_action_item_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`submission_content_unit` ADD CONSTRAINT `fk_regulatory_submission_content_unit_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`submission_content_unit` ADD CONSTRAINT `fk_regulatory_submission_content_unit_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);

-- ========= safety --> biostatistics (14 constraint(s)) =========
-- Requires: safety schema, biostatistics schema
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal` ADD CONSTRAINT `fk_safety_signal_analysis_population_id` FOREIGN KEY (`analysis_population_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`analysis_population`(`analysis_population_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal` ADD CONSTRAINT `fk_safety_signal_statistical_endpoint_id` FOREIGN KEY (`statistical_endpoint_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`statistical_endpoint`(`statistical_endpoint_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal_evaluation` ADD CONSTRAINT `fk_safety_signal_evaluation_analysis_population_id` FOREIGN KEY (`analysis_population_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`analysis_population`(`analysis_population_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal_evaluation` ADD CONSTRAINT `fk_safety_signal_evaluation_statistical_endpoint_id` FOREIGN KEY (`statistical_endpoint_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`statistical_endpoint`(`statistical_endpoint_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_review` ADD CONSTRAINT `fk_safety_dsmb_review_database_lock_event_id` FOREIGN KEY (`database_lock_event_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`database_lock_event`(`database_lock_event_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_review` ADD CONSTRAINT `fk_safety_dsmb_review_interim_analysis_id` FOREIGN KEY (`interim_analysis_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`interim_analysis`(`interim_analysis_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_review` ADD CONSTRAINT `fk_safety_dsmb_review_sap_id` FOREIGN KEY (`sap_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sap`(`sap_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_review` ADD CONSTRAINT `fk_safety_dsmb_review_statistical_endpoint_id` FOREIGN KEY (`statistical_endpoint_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`statistical_endpoint`(`statistical_endpoint_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_recommendation` ADD CONSTRAINT `fk_safety_dsmb_recommendation_interim_analysis_id` FOREIGN KEY (`interim_analysis_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`interim_analysis`(`interim_analysis_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_recommendation` ADD CONSTRAINT `fk_safety_dsmb_recommendation_sap_id` FOREIGN KEY (`sap_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sap`(`sap_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_analysis_population_id` FOREIGN KEY (`analysis_population_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`analysis_population`(`analysis_population_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_database_lock_event_id` FOREIGN KEY (`database_lock_event_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`database_lock_event`(`database_lock_event_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_interim_analysis_id` FOREIGN KEY (`interim_analysis_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`interim_analysis`(`interim_analysis_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_sap_id` FOREIGN KEY (`sap_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sap`(`sap_id`);

-- ========= safety --> compliance (4 constraint(s)) =========
-- Requires: safety schema, compliance schema
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_recommendation` ADD CONSTRAINT `fk_safety_dsmb_recommendation_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`capa`(`capa_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`reporting_obligation` ADD CONSTRAINT `fk_safety_reporting_obligation_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`expedited_report_deadline` ADD CONSTRAINT `fk_safety_expedited_report_deadline_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`capa`(`capa_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`communication` ADD CONSTRAINT `fk_safety_communication_ethics_submission_id` FOREIGN KEY (`ethics_submission_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_submission`(`ethics_submission_id`);

-- ========= safety --> data (24 constraint(s)) =========
-- Requires: safety schema, data schema
ALTER TABLE `clinical_trials_ecm`.`safety`.`adverse_event` ADD CONSTRAINT `fk_safety_adverse_event_ecrf_form_id` FOREIGN KEY (`ecrf_form_id`) REFERENCES `clinical_trials_ecm`.`data`.`ecrf_form`(`ecrf_form_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`adverse_event` ADD CONSTRAINT `fk_safety_adverse_event_subject_visit_data_id` FOREIGN KEY (`subject_visit_data_id`) REFERENCES `clinical_trials_ecm`.`data`.`subject_visit_data`(`subject_visit_data_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`serious_adverse_event` ADD CONSTRAINT `fk_safety_serious_adverse_event_discrepancy_query_id` FOREIGN KEY (`discrepancy_query_id`) REFERENCES `clinical_trials_ecm`.`data`.`discrepancy_query`(`discrepancy_query_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`serious_adverse_event` ADD CONSTRAINT `fk_safety_serious_adverse_event_ecrf_form_id` FOREIGN KEY (`ecrf_form_id`) REFERENCES `clinical_trials_ecm`.`data`.`ecrf_form`(`ecrf_form_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`serious_adverse_event` ADD CONSTRAINT `fk_safety_serious_adverse_event_subject_visit_data_id` FOREIGN KEY (`subject_visit_data_id`) REFERENCES `clinical_trials_ecm`.`data`.`subject_visit_data`(`subject_visit_data_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar` ADD CONSTRAINT `fk_safety_susar_ecrf_form_id` FOREIGN KEY (`ecrf_form_id`) REFERENCES `clinical_trials_ecm`.`data`.`ecrf_form`(`ecrf_form_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar` ADD CONSTRAINT `fk_safety_susar_subject_visit_data_id` FOREIGN KEY (`subject_visit_data_id`) REFERENCES `clinical_trials_ecm`.`data`.`subject_visit_data`(`subject_visit_data_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`ae_meddra_coding` ADD CONSTRAINT `fk_safety_ae_meddra_coding_coding_assignment_id` FOREIGN KEY (`coding_assignment_id`) REFERENCES `clinical_trials_ecm`.`data`.`coding_assignment`(`coding_assignment_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`ae_meddra_coding` ADD CONSTRAINT `fk_safety_ae_meddra_coding_discrepancy_query_id` FOREIGN KEY (`discrepancy_query_id`) REFERENCES `clinical_trials_ecm`.`data`.`discrepancy_query`(`discrepancy_query_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`ae_meddra_coding` ADD CONSTRAINT `fk_safety_ae_meddra_coding_ecrf_field_id` FOREIGN KEY (`ecrf_field_id`) REFERENCES `clinical_trials_ecm`.`data`.`ecrf_field`(`ecrf_field_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`ae_meddra_coding` ADD CONSTRAINT `fk_safety_ae_meddra_coding_subject_visit_data_id` FOREIGN KEY (`subject_visit_data_id`) REFERENCES `clinical_trials_ecm`.`data`.`subject_visit_data`(`subject_visit_data_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`causality_assessment` ADD CONSTRAINT `fk_safety_causality_assessment_ecrf_form_id` FOREIGN KEY (`ecrf_form_id`) REFERENCES `clinical_trials_ecm`.`data`.`ecrf_form`(`ecrf_form_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`causality_assessment` ADD CONSTRAINT `fk_safety_causality_assessment_subject_visit_data_id` FOREIGN KEY (`subject_visit_data_id`) REFERENCES `clinical_trials_ecm`.`data`.`subject_visit_data`(`subject_visit_data_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`narrative` ADD CONSTRAINT `fk_safety_narrative_ecrf_form_id` FOREIGN KEY (`ecrf_form_id`) REFERENCES `clinical_trials_ecm`.`data`.`ecrf_form`(`ecrf_form_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`narrative` ADD CONSTRAINT `fk_safety_narrative_subject_visit_data_id` FOREIGN KEY (`subject_visit_data_id`) REFERENCES `clinical_trials_ecm`.`data`.`subject_visit_data`(`subject_visit_data_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`icsr` ADD CONSTRAINT `fk_safety_icsr_ecrf_form_id` FOREIGN KEY (`ecrf_form_id`) REFERENCES `clinical_trials_ecm`.`data`.`ecrf_form`(`ecrf_form_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`icsr` ADD CONSTRAINT `fk_safety_icsr_subject_visit_data_id` FOREIGN KEY (`subject_visit_data_id`) REFERENCES `clinical_trials_ecm`.`data`.`subject_visit_data`(`subject_visit_data_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal` ADD CONSTRAINT `fk_safety_signal_sdtm_dataset_id` FOREIGN KEY (`sdtm_dataset_id`) REFERENCES `clinical_trials_ecm`.`data`.`sdtm_dataset`(`sdtm_dataset_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal_evaluation` ADD CONSTRAINT `fk_safety_signal_evaluation_sdtm_dataset_id` FOREIGN KEY (`sdtm_dataset_id`) REFERENCES `clinical_trials_ecm`.`data`.`sdtm_dataset`(`sdtm_dataset_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_review` ADD CONSTRAINT `fk_safety_dsmb_review_reconciliation_id` FOREIGN KEY (`reconciliation_id`) REFERENCES `clinical_trials_ecm`.`data`.`reconciliation`(`reconciliation_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_review` ADD CONSTRAINT `fk_safety_dsmb_review_sdtm_dataset_id` FOREIGN KEY (`sdtm_dataset_id`) REFERENCES `clinical_trials_ecm`.`data`.`sdtm_dataset`(`sdtm_dataset_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`expedited_report_deadline` ADD CONSTRAINT `fk_safety_expedited_report_deadline_subject_visit_data_id` FOREIGN KEY (`subject_visit_data_id`) REFERENCES `clinical_trials_ecm`.`data`.`subject_visit_data`(`subject_visit_data_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_reconciliation_id` FOREIGN KEY (`reconciliation_id`) REFERENCES `clinical_trials_ecm`.`data`.`reconciliation`(`reconciliation_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_sdtm_dataset_id` FOREIGN KEY (`sdtm_dataset_id`) REFERENCES `clinical_trials_ecm`.`data`.`sdtm_dataset`(`sdtm_dataset_id`);

-- ========= safety --> document (21 constraint(s)) =========
-- Requires: safety schema, document schema
ALTER TABLE `clinical_trials_ecm`.`safety`.`adverse_event` ADD CONSTRAINT `fk_safety_adverse_event_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`serious_adverse_event` ADD CONSTRAINT `fk_safety_serious_adverse_event_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar` ADD CONSTRAINT `fk_safety_susar_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar` ADD CONSTRAINT `fk_safety_susar_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`causality_assessment` ADD CONSTRAINT `fk_safety_causality_assessment_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`narrative` ADD CONSTRAINT `fk_safety_narrative_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`icsr` ADD CONSTRAINT `fk_safety_icsr_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`icsr` ADD CONSTRAINT `fk_safety_icsr_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`icsr` ADD CONSTRAINT `fk_safety_icsr_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal` ADD CONSTRAINT `fk_safety_signal_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal_evaluation` ADD CONSTRAINT `fk_safety_signal_evaluation_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_review` ADD CONSTRAINT `fk_safety_dsmb_review_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_review` ADD CONSTRAINT `fk_safety_dsmb_review_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_recommendation` ADD CONSTRAINT `fk_safety_dsmb_recommendation_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`reporting_obligation` ADD CONSTRAINT `fk_safety_reporting_obligation_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`expedited_report_deadline` ADD CONSTRAINT `fk_safety_expedited_report_deadline_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`review_committee` ADD CONSTRAINT `fk_safety_review_committee_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`communication` ADD CONSTRAINT `fk_safety_communication_site_file_id` FOREIGN KEY (`site_file_id`) REFERENCES `clinical_trials_ecm`.`document`.`site_file`(`site_file_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`communication` ADD CONSTRAINT `fk_safety_communication_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);

-- ========= safety --> laboratory (5 constraint(s)) =========
-- Requires: safety schema, laboratory schema
ALTER TABLE `clinical_trials_ecm`.`safety`.`serious_adverse_event` ADD CONSTRAINT `fk_safety_serious_adverse_event_lab_result_id` FOREIGN KEY (`lab_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_result`(`lab_result_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar` ADD CONSTRAINT `fk_safety_susar_lab_result_id` FOREIGN KEY (`lab_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_result`(`lab_result_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`causality_assessment` ADD CONSTRAINT `fk_safety_causality_assessment_lab_result_id` FOREIGN KEY (`lab_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_result`(`lab_result_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`narrative` ADD CONSTRAINT `fk_safety_narrative_lab_result_id` FOREIGN KEY (`lab_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_result`(`lab_result_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`icsr` ADD CONSTRAINT `fk_safety_icsr_lab_result_id` FOREIGN KEY (`lab_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_result`(`lab_result_id`);

-- ========= safety --> monitoring (2 constraint(s)) =========
-- Requires: safety schema, monitoring schema
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_review` ADD CONSTRAINT `fk_safety_dsmb_review_monitoring_plan_id` FOREIGN KEY (`monitoring_plan_id`) REFERENCES `clinical_trials_ecm`.`monitoring`.`monitoring_plan`(`monitoring_plan_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_monitoring_plan_id` FOREIGN KEY (`monitoring_plan_id`) REFERENCES `clinical_trials_ecm`.`monitoring`.`monitoring_plan`(`monitoring_plan_id`);

-- ========= safety --> randomization (13 constraint(s)) =========
-- Requires: safety schema, randomization schema
ALTER TABLE `clinical_trials_ecm`.`safety`.`adverse_event` ADD CONSTRAINT `fk_safety_adverse_event_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`serious_adverse_event` ADD CONSTRAINT `fk_safety_serious_adverse_event_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar` ADD CONSTRAINT `fk_safety_susar_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`causality_assessment` ADD CONSTRAINT `fk_safety_causality_assessment_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`icsr` ADD CONSTRAINT `fk_safety_icsr_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal` ADD CONSTRAINT `fk_safety_signal_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal_evaluation` ADD CONSTRAINT `fk_safety_signal_evaluation_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_review` ADD CONSTRAINT `fk_safety_dsmb_review_blinding_config_id` FOREIGN KEY (`blinding_config_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`blinding_config`(`blinding_config_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_review` ADD CONSTRAINT `fk_safety_dsmb_review_rand_list_id` FOREIGN KEY (`rand_list_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_list`(`rand_list_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_review` ADD CONSTRAINT `fk_safety_dsmb_review_rand_scheme_id` FOREIGN KEY (`rand_scheme_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_scheme`(`rand_scheme_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_recommendation` ADD CONSTRAINT `fk_safety_dsmb_recommendation_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`communication` ADD CONSTRAINT `fk_safety_communication_blinding_config_id` FOREIGN KEY (`blinding_config_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`blinding_config`(`blinding_config_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`communication` ADD CONSTRAINT `fk_safety_communication_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);

-- ========= safety --> regulatory (53 constraint(s)) =========
-- Requires: safety schema, regulatory schema
ALTER TABLE `clinical_trials_ecm`.`safety`.`adverse_event` ADD CONSTRAINT `fk_safety_adverse_event_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`adverse_event` ADD CONSTRAINT `fk_safety_adverse_event_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`serious_adverse_event` ADD CONSTRAINT `fk_safety_serious_adverse_event_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`serious_adverse_event` ADD CONSTRAINT `fk_safety_serious_adverse_event_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar` ADD CONSTRAINT `fk_safety_susar_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar` ADD CONSTRAINT `fk_safety_susar_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar` ADD CONSTRAINT `fk_safety_susar_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`causality_assessment` ADD CONSTRAINT `fk_safety_causality_assessment_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`narrative` ADD CONSTRAINT `fk_safety_narrative_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`narrative` ADD CONSTRAINT `fk_safety_narrative_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`narrative` ADD CONSTRAINT `fk_safety_narrative_safety_report_submission_id` FOREIGN KEY (`safety_report_submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`safety_report_submission`(`safety_report_submission_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`icsr` ADD CONSTRAINT `fk_safety_icsr_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`icsr` ADD CONSTRAINT `fk_safety_icsr_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`icsr` ADD CONSTRAINT `fk_safety_icsr_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal` ADD CONSTRAINT `fk_safety_signal_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal` ADD CONSTRAINT `fk_safety_signal_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal` ADD CONSTRAINT `fk_safety_signal_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal_evaluation` ADD CONSTRAINT `fk_safety_signal_evaluation_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal_evaluation` ADD CONSTRAINT `fk_safety_signal_evaluation_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal_evaluation` ADD CONSTRAINT `fk_safety_signal_evaluation_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal_evaluation` ADD CONSTRAINT `fk_safety_signal_evaluation_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal_evaluation` ADD CONSTRAINT `fk_safety_signal_evaluation_safety_report_submission_id` FOREIGN KEY (`safety_report_submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`safety_report_submission`(`safety_report_submission_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal_evaluation` ADD CONSTRAINT `fk_safety_signal_evaluation_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_review` ADD CONSTRAINT `fk_safety_dsmb_review_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_review` ADD CONSTRAINT `fk_safety_dsmb_review_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_review` ADD CONSTRAINT `fk_safety_dsmb_review_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_review` ADD CONSTRAINT `fk_safety_dsmb_review_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_recommendation` ADD CONSTRAINT `fk_safety_dsmb_recommendation_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_recommendation` ADD CONSTRAINT `fk_safety_dsmb_recommendation_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_recommendation` ADD CONSTRAINT `fk_safety_dsmb_recommendation_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_recommendation` ADD CONSTRAINT `fk_safety_dsmb_recommendation_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_recommendation` ADD CONSTRAINT `fk_safety_dsmb_recommendation_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`reporting_obligation` ADD CONSTRAINT `fk_safety_reporting_obligation_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`reporting_obligation` ADD CONSTRAINT `fk_safety_reporting_obligation_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`reporting_obligation` ADD CONSTRAINT `fk_safety_reporting_obligation_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`expedited_report_deadline` ADD CONSTRAINT `fk_safety_expedited_report_deadline_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`expedited_report_deadline` ADD CONSTRAINT `fk_safety_expedited_report_deadline_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`expedited_report_deadline` ADD CONSTRAINT `fk_safety_expedited_report_deadline_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`expedited_report_deadline` ADD CONSTRAINT `fk_safety_expedited_report_deadline_safety_report_submission_id` FOREIGN KEY (`safety_report_submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`safety_report_submission`(`safety_report_submission_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_safety_report_submission_id` FOREIGN KEY (`safety_report_submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`safety_report_submission`(`safety_report_submission_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`review_committee` ADD CONSTRAINT `fk_safety_review_committee_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`review_committee` ADD CONSTRAINT `fk_safety_review_committee_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`review_committee` ADD CONSTRAINT `fk_safety_review_committee_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`communication` ADD CONSTRAINT `fk_safety_communication_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`communication` ADD CONSTRAINT `fk_safety_communication_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`communication` ADD CONSTRAINT `fk_safety_communication_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`communication` ADD CONSTRAINT `fk_safety_communication_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`communication` ADD CONSTRAINT `fk_safety_communication_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);

-- ========= safety --> site (17 constraint(s)) =========
-- Requires: safety schema, site schema
ALTER TABLE `clinical_trials_ecm`.`safety`.`adverse_event` ADD CONSTRAINT `fk_safety_adverse_event_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`serious_adverse_event` ADD CONSTRAINT `fk_safety_serious_adverse_event_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`serious_adverse_event` ADD CONSTRAINT `fk_safety_serious_adverse_event_irb_iec_approval_id` FOREIGN KEY (`irb_iec_approval_id`) REFERENCES `clinical_trials_ecm`.`site`.`irb_iec_approval`(`irb_iec_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`serious_adverse_event` ADD CONSTRAINT `fk_safety_serious_adverse_event_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `clinical_trials_ecm`.`site`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`serious_adverse_event` ADD CONSTRAINT `fk_safety_serious_adverse_event_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar` ADD CONSTRAINT `fk_safety_susar_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar` ADD CONSTRAINT `fk_safety_susar_irb_iec_approval_id` FOREIGN KEY (`irb_iec_approval_id`) REFERENCES `clinical_trials_ecm`.`site`.`irb_iec_approval`(`irb_iec_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar` ADD CONSTRAINT `fk_safety_susar_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`causality_assessment` ADD CONSTRAINT `fk_safety_causality_assessment_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`narrative` ADD CONSTRAINT `fk_safety_narrative_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`icsr` ADD CONSTRAINT `fk_safety_icsr_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`icsr` ADD CONSTRAINT `fk_safety_icsr_irb_iec_approval_id` FOREIGN KEY (`irb_iec_approval_id`) REFERENCES `clinical_trials_ecm`.`site`.`irb_iec_approval`(`irb_iec_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`icsr` ADD CONSTRAINT `fk_safety_icsr_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`communication` ADD CONSTRAINT `fk_safety_communication_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`communication` ADD CONSTRAINT `fk_safety_communication_irb_iec_approval_id` FOREIGN KEY (`irb_iec_approval_id`) REFERENCES `clinical_trials_ecm`.`site`.`irb_iec_approval`(`irb_iec_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`communication` ADD CONSTRAINT `fk_safety_communication_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `clinical_trials_ecm`.`site`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`communication` ADD CONSTRAINT `fk_safety_communication_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);

-- ========= safety --> study (44 constraint(s)) =========
-- Requires: safety schema, study schema
ALTER TABLE `clinical_trials_ecm`.`safety`.`adverse_event` ADD CONSTRAINT `fk_safety_adverse_event_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`adverse_event` ADD CONSTRAINT `fk_safety_adverse_event_dosing_regimen_id` FOREIGN KEY (`dosing_regimen_id`) REFERENCES `clinical_trials_ecm`.`study`.`dosing_regimen`(`dosing_regimen_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`adverse_event` ADD CONSTRAINT `fk_safety_adverse_event_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`adverse_event` ADD CONSTRAINT `fk_safety_adverse_event_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`serious_adverse_event` ADD CONSTRAINT `fk_safety_serious_adverse_event_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`serious_adverse_event` ADD CONSTRAINT `fk_safety_serious_adverse_event_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`serious_adverse_event` ADD CONSTRAINT `fk_safety_serious_adverse_event_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`serious_adverse_event` ADD CONSTRAINT `fk_safety_serious_adverse_event_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar` ADD CONSTRAINT `fk_safety_susar_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar` ADD CONSTRAINT `fk_safety_susar_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar` ADD CONSTRAINT `fk_safety_susar_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`ae_meddra_coding` ADD CONSTRAINT `fk_safety_ae_meddra_coding_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`causality_assessment` ADD CONSTRAINT `fk_safety_causality_assessment_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`causality_assessment` ADD CONSTRAINT `fk_safety_causality_assessment_dosing_regimen_id` FOREIGN KEY (`dosing_regimen_id`) REFERENCES `clinical_trials_ecm`.`study`.`dosing_regimen`(`dosing_regimen_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`causality_assessment` ADD CONSTRAINT `fk_safety_causality_assessment_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `clinical_trials_ecm`.`study`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`causality_assessment` ADD CONSTRAINT `fk_safety_causality_assessment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`narrative` ADD CONSTRAINT `fk_safety_narrative_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`narrative` ADD CONSTRAINT `fk_safety_narrative_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`icsr` ADD CONSTRAINT `fk_safety_icsr_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`icsr` ADD CONSTRAINT `fk_safety_icsr_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `clinical_trials_ecm`.`study`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`icsr` ADD CONSTRAINT `fk_safety_icsr_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal` ADD CONSTRAINT `fk_safety_signal_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal` ADD CONSTRAINT `fk_safety_signal_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal` ADD CONSTRAINT `fk_safety_signal_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `clinical_trials_ecm`.`study`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal` ADD CONSTRAINT `fk_safety_signal_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal_evaluation` ADD CONSTRAINT `fk_safety_signal_evaluation_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal_evaluation` ADD CONSTRAINT `fk_safety_signal_evaluation_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_review` ADD CONSTRAINT `fk_safety_dsmb_review_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_review` ADD CONSTRAINT `fk_safety_dsmb_review_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_review` ADD CONSTRAINT `fk_safety_dsmb_review_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_review` ADD CONSTRAINT `fk_safety_dsmb_review_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_recommendation` ADD CONSTRAINT `fk_safety_dsmb_recommendation_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_recommendation` ADD CONSTRAINT `fk_safety_dsmb_recommendation_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`reporting_obligation` ADD CONSTRAINT `fk_safety_reporting_obligation_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `clinical_trials_ecm`.`study`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`reporting_obligation` ADD CONSTRAINT `fk_safety_reporting_obligation_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`reporting_obligation` ADD CONSTRAINT `fk_safety_reporting_obligation_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`expedited_report_deadline` ADD CONSTRAINT `fk_safety_expedited_report_deadline_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`expedited_report_deadline` ADD CONSTRAINT `fk_safety_expedited_report_deadline_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`expedited_report_deadline` ADD CONSTRAINT `fk_safety_expedited_report_deadline_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `clinical_trials_ecm`.`study`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`review_committee` ADD CONSTRAINT `fk_safety_review_committee_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`communication` ADD CONSTRAINT `fk_safety_communication_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);

-- ========= safety --> subject (21 constraint(s)) =========
-- Requires: safety schema, subject schema
ALTER TABLE `clinical_trials_ecm`.`safety`.`adverse_event` ADD CONSTRAINT `fk_safety_adverse_event_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`adverse_event` ADD CONSTRAINT `fk_safety_adverse_event_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`serious_adverse_event` ADD CONSTRAINT `fk_safety_serious_adverse_event_enrollment_id` FOREIGN KEY (`enrollment_id`) REFERENCES `clinical_trials_ecm`.`subject`.`enrollment`(`enrollment_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`serious_adverse_event` ADD CONSTRAINT `fk_safety_serious_adverse_event_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`serious_adverse_event` ADD CONSTRAINT `fk_safety_serious_adverse_event_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar` ADD CONSTRAINT `fk_safety_susar_enrollment_id` FOREIGN KEY (`enrollment_id`) REFERENCES `clinical_trials_ecm`.`subject`.`enrollment`(`enrollment_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar` ADD CONSTRAINT `fk_safety_susar_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar` ADD CONSTRAINT `fk_safety_susar_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`ae_meddra_coding` ADD CONSTRAINT `fk_safety_ae_meddra_coding_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`ae_meddra_coding` ADD CONSTRAINT `fk_safety_ae_meddra_coding_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`causality_assessment` ADD CONSTRAINT `fk_safety_causality_assessment_enrollment_id` FOREIGN KEY (`enrollment_id`) REFERENCES `clinical_trials_ecm`.`subject`.`enrollment`(`enrollment_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`causality_assessment` ADD CONSTRAINT `fk_safety_causality_assessment_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`causality_assessment` ADD CONSTRAINT `fk_safety_causality_assessment_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`narrative` ADD CONSTRAINT `fk_safety_narrative_enrollment_id` FOREIGN KEY (`enrollment_id`) REFERENCES `clinical_trials_ecm`.`subject`.`enrollment`(`enrollment_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`narrative` ADD CONSTRAINT `fk_safety_narrative_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`narrative` ADD CONSTRAINT `fk_safety_narrative_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`icsr` ADD CONSTRAINT `fk_safety_icsr_enrollment_id` FOREIGN KEY (`enrollment_id`) REFERENCES `clinical_trials_ecm`.`subject`.`enrollment`(`enrollment_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`icsr` ADD CONSTRAINT `fk_safety_icsr_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`icsr` ADD CONSTRAINT `fk_safety_icsr_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`expedited_report_deadline` ADD CONSTRAINT `fk_safety_expedited_report_deadline_enrollment_id` FOREIGN KEY (`enrollment_id`) REFERENCES `clinical_trials_ecm`.`subject`.`enrollment`(`enrollment_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`expedited_report_deadline` ADD CONSTRAINT `fk_safety_expedited_report_deadline_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);

-- ========= safety --> supply (21 constraint(s)) =========
-- Requires: safety schema, supply schema
ALTER TABLE `clinical_trials_ecm`.`safety`.`adverse_event` ADD CONSTRAINT `fk_safety_adverse_event_imp_master_id` FOREIGN KEY (`imp_master_id`) REFERENCES `clinical_trials_ecm`.`supply`.`imp_master`(`imp_master_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`adverse_event` ADD CONSTRAINT `fk_safety_adverse_event_manufacture_batch_id` FOREIGN KEY (`manufacture_batch_id`) REFERENCES `clinical_trials_ecm`.`supply`.`manufacture_batch`(`manufacture_batch_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`serious_adverse_event` ADD CONSTRAINT `fk_safety_serious_adverse_event_dispensing_record_id` FOREIGN KEY (`dispensing_record_id`) REFERENCES `clinical_trials_ecm`.`supply`.`dispensing_record`(`dispensing_record_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`serious_adverse_event` ADD CONSTRAINT `fk_safety_serious_adverse_event_imp_master_id` FOREIGN KEY (`imp_master_id`) REFERENCES `clinical_trials_ecm`.`supply`.`imp_master`(`imp_master_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`serious_adverse_event` ADD CONSTRAINT `fk_safety_serious_adverse_event_manufacture_batch_id` FOREIGN KEY (`manufacture_batch_id`) REFERENCES `clinical_trials_ecm`.`supply`.`manufacture_batch`(`manufacture_batch_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar` ADD CONSTRAINT `fk_safety_susar_dispensing_record_id` FOREIGN KEY (`dispensing_record_id`) REFERENCES `clinical_trials_ecm`.`supply`.`dispensing_record`(`dispensing_record_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar` ADD CONSTRAINT `fk_safety_susar_imp_master_id` FOREIGN KEY (`imp_master_id`) REFERENCES `clinical_trials_ecm`.`supply`.`imp_master`(`imp_master_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar` ADD CONSTRAINT `fk_safety_susar_manufacture_batch_id` FOREIGN KEY (`manufacture_batch_id`) REFERENCES `clinical_trials_ecm`.`supply`.`manufacture_batch`(`manufacture_batch_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`causality_assessment` ADD CONSTRAINT `fk_safety_causality_assessment_dispensing_record_id` FOREIGN KEY (`dispensing_record_id`) REFERENCES `clinical_trials_ecm`.`supply`.`dispensing_record`(`dispensing_record_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`causality_assessment` ADD CONSTRAINT `fk_safety_causality_assessment_manufacture_batch_id` FOREIGN KEY (`manufacture_batch_id`) REFERENCES `clinical_trials_ecm`.`supply`.`manufacture_batch`(`manufacture_batch_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`narrative` ADD CONSTRAINT `fk_safety_narrative_dispensing_record_id` FOREIGN KEY (`dispensing_record_id`) REFERENCES `clinical_trials_ecm`.`supply`.`dispensing_record`(`dispensing_record_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`icsr` ADD CONSTRAINT `fk_safety_icsr_dispensing_record_id` FOREIGN KEY (`dispensing_record_id`) REFERENCES `clinical_trials_ecm`.`supply`.`dispensing_record`(`dispensing_record_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`icsr` ADD CONSTRAINT `fk_safety_icsr_imp_master_id` FOREIGN KEY (`imp_master_id`) REFERENCES `clinical_trials_ecm`.`supply`.`imp_master`(`imp_master_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`icsr` ADD CONSTRAINT `fk_safety_icsr_manufacture_batch_id` FOREIGN KEY (`manufacture_batch_id`) REFERENCES `clinical_trials_ecm`.`supply`.`manufacture_batch`(`manufacture_batch_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal` ADD CONSTRAINT `fk_safety_signal_imp_master_id` FOREIGN KEY (`imp_master_id`) REFERENCES `clinical_trials_ecm`.`supply`.`imp_master`(`imp_master_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal` ADD CONSTRAINT `fk_safety_signal_manufacture_batch_id` FOREIGN KEY (`manufacture_batch_id`) REFERENCES `clinical_trials_ecm`.`supply`.`manufacture_batch`(`manufacture_batch_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`reporting_obligation` ADD CONSTRAINT `fk_safety_reporting_obligation_imp_master_id` FOREIGN KEY (`imp_master_id`) REFERENCES `clinical_trials_ecm`.`supply`.`imp_master`(`imp_master_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`expedited_report_deadline` ADD CONSTRAINT `fk_safety_expedited_report_deadline_dispensing_record_id` FOREIGN KEY (`dispensing_record_id`) REFERENCES `clinical_trials_ecm`.`supply`.`dispensing_record`(`dispensing_record_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_imp_master_id` FOREIGN KEY (`imp_master_id`) REFERENCES `clinical_trials_ecm`.`supply`.`imp_master`(`imp_master_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`communication` ADD CONSTRAINT `fk_safety_communication_imp_master_id` FOREIGN KEY (`imp_master_id`) REFERENCES `clinical_trials_ecm`.`supply`.`imp_master`(`imp_master_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`communication` ADD CONSTRAINT `fk_safety_communication_manufacture_batch_id` FOREIGN KEY (`manufacture_batch_id`) REFERENCES `clinical_trials_ecm`.`supply`.`manufacture_batch`(`manufacture_batch_id`);

-- ========= site --> biostatistics (3 constraint(s)) =========
-- Requires: site schema, biostatistics schema
ALTER TABLE `clinical_trials_ecm`.`site`.`selection` ADD CONSTRAINT `fk_site_selection_sample_size_calc_id` FOREIGN KEY (`sample_size_calc_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sample_size_calc`(`sample_size_calc_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`initiation_visit` ADD CONSTRAINT `fk_site_initiation_visit_sap_id` FOREIGN KEY (`sap_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sap`(`sap_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_database_lock_event_id` FOREIGN KEY (`database_lock_event_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`database_lock_event`(`database_lock_event_id`);

-- ========= site --> compliance (12 constraint(s)) =========
-- Requires: site schema, compliance schema
ALTER TABLE `clinical_trials_ecm`.`site`.`activation` ADD CONSTRAINT `fk_site_activation_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`activation` ADD CONSTRAINT `fk_site_activation_ethics_approval_id` FOREIGN KEY (`ethics_approval_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_approval`(`ethics_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`irb_iec_approval` ADD CONSTRAINT `fk_site_irb_iec_approval_ethics_approval_id` FOREIGN KEY (`ethics_approval_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_approval`(`ethics_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`irb_iec_approval` ADD CONSTRAINT `fk_site_irb_iec_approval_ethics_committee_id` FOREIGN KEY (`ethics_committee_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_committee`(`ethics_committee_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`irb_iec_approval` ADD CONSTRAINT `fk_site_irb_iec_approval_ethics_submission_id` FOREIGN KEY (`ethics_submission_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_submission`(`ethics_submission_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`regulatory_submission_site` ADD CONSTRAINT `fk_site_regulatory_submission_site_ethics_committee_id` FOREIGN KEY (`ethics_committee_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_committee`(`ethics_committee_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`initiation_visit` ADD CONSTRAINT `fk_site_initiation_visit_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`initiation_visit` ADD CONSTRAINT `fk_site_initiation_visit_ethics_approval_id` FOREIGN KEY (`ethics_approval_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_approval`(`ethics_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`site_cra_assignment` ADD CONSTRAINT `fk_site_site_cra_assignment_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`site_cra_assignment` ADD CONSTRAINT `fk_site_site_cra_assignment_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`capa`(`capa_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);

-- ========= site --> data (8 constraint(s)) =========
-- Requires: site schema, data schema
ALTER TABLE `clinical_trials_ecm`.`site`.`activation` ADD CONSTRAINT `fk_site_activation_edc_study_build_id` FOREIGN KEY (`edc_study_build_id`) REFERENCES `clinical_trials_ecm`.`data`.`edc_study_build`(`edc_study_build_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`initiation_visit` ADD CONSTRAINT `fk_site_initiation_visit_dmp_id` FOREIGN KEY (`dmp_id`) REFERENCES `clinical_trials_ecm`.`data`.`dmp`(`dmp_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`initiation_visit` ADD CONSTRAINT `fk_site_initiation_visit_edc_study_build_id` FOREIGN KEY (`edc_study_build_id`) REFERENCES `clinical_trials_ecm`.`data`.`edc_study_build`(`edc_study_build_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`enrollment_performance` ADD CONSTRAINT `fk_site_enrollment_performance_dmp_id` FOREIGN KEY (`dmp_id`) REFERENCES `clinical_trials_ecm`.`data`.`dmp`(`dmp_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`enrollment_performance` ADD CONSTRAINT `fk_site_enrollment_performance_edc_study_build_id` FOREIGN KEY (`edc_study_build_id`) REFERENCES `clinical_trials_ecm`.`data`.`edc_study_build`(`edc_study_build_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`site_cra_assignment` ADD CONSTRAINT `fk_site_site_cra_assignment_dmp_id` FOREIGN KEY (`dmp_id`) REFERENCES `clinical_trials_ecm`.`data`.`dmp`(`dmp_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_dmp_id` FOREIGN KEY (`dmp_id`) REFERENCES `clinical_trials_ecm`.`data`.`dmp`(`dmp_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_reconciliation_id` FOREIGN KEY (`reconciliation_id`) REFERENCES `clinical_trials_ecm`.`data`.`reconciliation`(`reconciliation_id`);

-- ========= site --> document (20 constraint(s)) =========
-- Requires: site schema, document schema
ALTER TABLE `clinical_trials_ecm`.`site`.`site_contact` ADD CONSTRAINT `fk_site_site_contact_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`feasibility_assessment` ADD CONSTRAINT `fk_site_feasibility_assessment_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`selection` ADD CONSTRAINT `fk_site_selection_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`activation` ADD CONSTRAINT `fk_site_activation_site_file_id` FOREIGN KEY (`site_file_id`) REFERENCES `clinical_trials_ecm`.`document`.`site_file`(`site_file_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`activation` ADD CONSTRAINT `fk_site_activation_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`irb_iec_approval` ADD CONSTRAINT `fk_site_irb_iec_approval_site_file_id` FOREIGN KEY (`site_file_id`) REFERENCES `clinical_trials_ecm`.`document`.`site_file`(`site_file_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`irb_iec_approval` ADD CONSTRAINT `fk_site_irb_iec_approval_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`regulatory_submission_site` ADD CONSTRAINT `fk_site_regulatory_submission_site_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`regulatory_submission_site` ADD CONSTRAINT `fk_site_regulatory_submission_site_site_file_id` FOREIGN KEY (`site_file_id`) REFERENCES `clinical_trials_ecm`.`document`.`site_file`(`site_file_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`regulatory_submission_site` ADD CONSTRAINT `fk_site_regulatory_submission_site_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`initiation_visit` ADD CONSTRAINT `fk_site_initiation_visit_site_file_id` FOREIGN KEY (`site_file_id`) REFERENCES `clinical_trials_ecm`.`document`.`site_file`(`site_file_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`initiation_visit` ADD CONSTRAINT `fk_site_initiation_visit_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`agreement` ADD CONSTRAINT `fk_site_agreement_site_file_id` FOREIGN KEY (`site_file_id`) REFERENCES `clinical_trials_ecm`.`document`.`site_file`(`site_file_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`agreement` ADD CONSTRAINT `fk_site_agreement_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`site_cra_assignment` ADD CONSTRAINT `fk_site_site_cra_assignment_site_file_id` FOREIGN KEY (`site_file_id`) REFERENCES `clinical_trials_ecm`.`document`.`site_file`(`site_file_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_archival_record_id` FOREIGN KEY (`archival_record_id`) REFERENCES `clinical_trials_ecm`.`document`.`archival_record`(`archival_record_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_inspection_readiness_id` FOREIGN KEY (`inspection_readiness_id`) REFERENCES `clinical_trials_ecm`.`document`.`inspection_readiness`(`inspection_readiness_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_site_file_id` FOREIGN KEY (`site_file_id`) REFERENCES `clinical_trials_ecm`.`document`.`site_file`(`site_file_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_tmf_completeness_id` FOREIGN KEY (`tmf_completeness_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_completeness`(`tmf_completeness_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);

-- ========= site --> laboratory (6 constraint(s)) =========
-- Requires: site schema, laboratory schema
ALTER TABLE `clinical_trials_ecm`.`site`.`investigational_site` ADD CONSTRAINT `fk_site_investigational_site_lab_facility_id` FOREIGN KEY (`lab_facility_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_facility`(`lab_facility_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`feasibility_assessment` ADD CONSTRAINT `fk_site_feasibility_assessment_lab_facility_id` FOREIGN KEY (`lab_facility_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_facility`(`lab_facility_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`study_site` ADD CONSTRAINT `fk_site_study_site_lab_facility_id` FOREIGN KEY (`lab_facility_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_facility`(`lab_facility_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`activation` ADD CONSTRAINT `fk_site_activation_lab_facility_id` FOREIGN KEY (`lab_facility_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_facility`(`lab_facility_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`initiation_visit` ADD CONSTRAINT `fk_site_initiation_visit_lab_facility_id` FOREIGN KEY (`lab_facility_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_facility`(`lab_facility_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`initiation_visit` ADD CONSTRAINT `fk_site_initiation_visit_lab_kit_id` FOREIGN KEY (`lab_kit_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_kit`(`lab_kit_id`);

-- ========= site --> monitoring (5 constraint(s)) =========
-- Requires: site schema, monitoring schema
ALTER TABLE `clinical_trials_ecm`.`site`.`initiation_visit` ADD CONSTRAINT `fk_site_initiation_visit_monitoring_visit_id` FOREIGN KEY (`monitoring_visit_id`) REFERENCES `clinical_trials_ecm`.`monitoring`.`monitoring_visit`(`monitoring_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`site_cra_assignment` ADD CONSTRAINT `fk_site_site_cra_assignment_monitoring_cra_assignment_id` FOREIGN KEY (`monitoring_cra_assignment_id`) REFERENCES `clinical_trials_ecm`.`monitoring`.`monitoring_cra_assignment`(`monitoring_cra_assignment_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`site_cra_assignment` ADD CONSTRAINT `fk_site_site_cra_assignment_monitoring_plan_id` FOREIGN KEY (`monitoring_plan_id`) REFERENCES `clinical_trials_ecm`.`monitoring`.`monitoring_plan`(`monitoring_plan_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_monitoring_visit_id` FOREIGN KEY (`monitoring_visit_id`) REFERENCES `clinical_trials_ecm`.`monitoring`.`monitoring_visit`(`monitoring_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_visit_report_id` FOREIGN KEY (`visit_report_id`) REFERENCES `clinical_trials_ecm`.`monitoring`.`visit_report`(`visit_report_id`);

-- ========= site --> randomization (5 constraint(s)) =========
-- Requires: site schema, randomization schema
ALTER TABLE `clinical_trials_ecm`.`site`.`activation` ADD CONSTRAINT `fk_site_activation_blinding_config_id` FOREIGN KEY (`blinding_config_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`blinding_config`(`blinding_config_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`activation` ADD CONSTRAINT `fk_site_activation_rand_scheme_id` FOREIGN KEY (`rand_scheme_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_scheme`(`rand_scheme_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`initiation_visit` ADD CONSTRAINT `fk_site_initiation_visit_rand_scheme_id` FOREIGN KEY (`rand_scheme_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_scheme`(`rand_scheme_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`enrollment_performance` ADD CONSTRAINT `fk_site_enrollment_performance_rand_scheme_id` FOREIGN KEY (`rand_scheme_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_scheme`(`rand_scheme_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_rand_list_id` FOREIGN KEY (`rand_list_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_list`(`rand_list_id`);

-- ========= site --> regulatory (25 constraint(s)) =========
-- Requires: site schema, regulatory schema
ALTER TABLE `clinical_trials_ecm`.`site`.`selection` ADD CONSTRAINT `fk_site_selection_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`study_site` ADD CONSTRAINT `fk_site_study_site_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`study_site` ADD CONSTRAINT `fk_site_study_site_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`activation` ADD CONSTRAINT `fk_site_activation_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`activation` ADD CONSTRAINT `fk_site_activation_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`activation` ADD CONSTRAINT `fk_site_activation_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`activation` ADD CONSTRAINT `fk_site_activation_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`irb_iec_approval` ADD CONSTRAINT `fk_site_irb_iec_approval_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`irb_iec_approval` ADD CONSTRAINT `fk_site_irb_iec_approval_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`regulatory_submission_site` ADD CONSTRAINT `fk_site_regulatory_submission_site_application_id` FOREIGN KEY (`application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`application`(`application_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`regulatory_submission_site` ADD CONSTRAINT `fk_site_regulatory_submission_site_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`regulatory_submission_site` ADD CONSTRAINT `fk_site_regulatory_submission_site_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`regulatory_submission_site` ADD CONSTRAINT `fk_site_regulatory_submission_site_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`regulatory_submission_site` ADD CONSTRAINT `fk_site_regulatory_submission_site_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`regulatory_submission_site` ADD CONSTRAINT `fk_site_regulatory_submission_site_submission_sequence_id` FOREIGN KEY (`submission_sequence_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission_sequence`(`submission_sequence_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`initiation_visit` ADD CONSTRAINT `fk_site_initiation_visit_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`initiation_visit` ADD CONSTRAINT `fk_site_initiation_visit_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`initiation_visit` ADD CONSTRAINT `fk_site_initiation_visit_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`initiation_visit` ADD CONSTRAINT `fk_site_initiation_visit_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`agreement` ADD CONSTRAINT `fk_site_agreement_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`agreement` ADD CONSTRAINT `fk_site_agreement_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);

-- ========= site --> study (30 constraint(s)) =========
-- Requires: site schema, study schema
ALTER TABLE `clinical_trials_ecm`.`site`.`feasibility_assessment` ADD CONSTRAINT `fk_site_feasibility_assessment_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`feasibility_assessment` ADD CONSTRAINT `fk_site_feasibility_assessment_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`feasibility_assessment` ADD CONSTRAINT `fk_site_feasibility_assessment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`selection` ADD CONSTRAINT `fk_site_selection_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`selection` ADD CONSTRAINT `fk_site_selection_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`selection` ADD CONSTRAINT `fk_site_selection_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`study_site` ADD CONSTRAINT `fk_site_study_site_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`study_site` ADD CONSTRAINT `fk_site_study_site_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`activation` ADD CONSTRAINT `fk_site_activation_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`activation` ADD CONSTRAINT `fk_site_activation_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`irb_iec_approval` ADD CONSTRAINT `fk_site_irb_iec_approval_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`irb_iec_approval` ADD CONSTRAINT `fk_site_irb_iec_approval_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`irb_iec_approval` ADD CONSTRAINT `fk_site_irb_iec_approval_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`regulatory_submission_site` ADD CONSTRAINT `fk_site_regulatory_submission_site_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`regulatory_submission_site` ADD CONSTRAINT `fk_site_regulatory_submission_site_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`initiation_visit` ADD CONSTRAINT `fk_site_initiation_visit_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`initiation_visit` ADD CONSTRAINT `fk_site_initiation_visit_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`initiation_visit` ADD CONSTRAINT `fk_site_initiation_visit_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`enrollment_performance` ADD CONSTRAINT `fk_site_enrollment_performance_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`enrollment_performance` ADD CONSTRAINT `fk_site_enrollment_performance_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`enrollment_performance` ADD CONSTRAINT `fk_site_enrollment_performance_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`enrollment_performance` ADD CONSTRAINT `fk_site_enrollment_performance_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`enrollment_performance` ADD CONSTRAINT `fk_site_enrollment_performance_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`agreement` ADD CONSTRAINT `fk_site_agreement_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`agreement` ADD CONSTRAINT `fk_site_agreement_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`site_cra_assignment` ADD CONSTRAINT `fk_site_site_cra_assignment_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`site_cra_assignment` ADD CONSTRAINT `fk_site_site_cra_assignment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);

-- ========= site --> supply (2 constraint(s)) =========
-- Requires: site schema, supply schema
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_accountability_reconciliation_id` FOREIGN KEY (`accountability_reconciliation_id`) REFERENCES `clinical_trials_ecm`.`supply`.`accountability_reconciliation`(`accountability_reconciliation_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_destruction_record_id` FOREIGN KEY (`destruction_record_id`) REFERENCES `clinical_trials_ecm`.`supply`.`destruction_record`(`destruction_record_id`);

-- ========= study --> data (1 constraint(s)) =========
-- Requires: study schema, data schema
ALTER TABLE `clinical_trials_ecm`.`study`.`visit_procedure` ADD CONSTRAINT `fk_study_visit_procedure_ecrf_form_id` FOREIGN KEY (`ecrf_form_id`) REFERENCES `clinical_trials_ecm`.`data`.`ecrf_form`(`ecrf_form_id`);

-- ========= study --> document (9 constraint(s)) =========
-- Requires: study schema, document schema
ALTER TABLE `clinical_trials_ecm`.`study`.`study_protocol_amendment` ADD CONSTRAINT `fk_study_study_protocol_amendment_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`study_protocol_amendment` ADD CONSTRAINT `fk_study_study_protocol_amendment_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`study_protocol_amendment` ADD CONSTRAINT `fk_study_study_protocol_amendment_version_id` FOREIGN KEY (`version_id`) REFERENCES `clinical_trials_ecm`.`document`.`version`(`version_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`study_milestone` ADD CONSTRAINT `fk_study_study_milestone_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`country` ADD CONSTRAINT `fk_study_country_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`country` ADD CONSTRAINT `fk_study_country_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`investigational_product` ADD CONSTRAINT `fk_study_investigational_product_version_id` FOREIGN KEY (`version_id`) REFERENCES `clinical_trials_ecm`.`document`.`version`(`version_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`investigational_product` ADD CONSTRAINT `fk_study_investigational_product_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`investigational_product` ADD CONSTRAINT `fk_study_investigational_product_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);

-- ========= study --> laboratory (1 constraint(s)) =========
-- Requires: study schema, laboratory schema
ALTER TABLE `clinical_trials_ecm`.`study`.`visit_procedure` ADD CONSTRAINT `fk_study_visit_procedure_lab_panel_id` FOREIGN KEY (`lab_panel_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_panel`(`lab_panel_id`);

-- ========= study --> regulatory (10 constraint(s)) =========
-- Requires: study schema, regulatory schema
ALTER TABLE `clinical_trials_ecm`.`study`.`protocol` ADD CONSTRAINT `fk_study_protocol_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`study_protocol_amendment` ADD CONSTRAINT `fk_study_study_protocol_amendment_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`study_milestone` ADD CONSTRAINT `fk_study_study_milestone_regulatory_milestone_id` FOREIGN KEY (`regulatory_milestone_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_milestone`(`regulatory_milestone_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`country` ADD CONSTRAINT `fk_study_country_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`country` ADD CONSTRAINT `fk_study_country_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`investigational_product` ADD CONSTRAINT `fk_study_investigational_product_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`investigational_product` ADD CONSTRAINT `fk_study_investigational_product_country_registration_id` FOREIGN KEY (`country_registration_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`country_registration`(`country_registration_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`investigational_product` ADD CONSTRAINT `fk_study_investigational_product_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`investigational_product` ADD CONSTRAINT `fk_study_investigational_product_special_designation_id` FOREIGN KEY (`special_designation_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`special_designation`(`special_designation_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`dosing_regimen` ADD CONSTRAINT `fk_study_dosing_regimen_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`approval`(`approval_id`);

-- ========= study --> safety (4 constraint(s)) =========
-- Requires: study schema, safety schema
ALTER TABLE `clinical_trials_ecm`.`study`.`endpoint` ADD CONSTRAINT `fk_study_endpoint_ctcae_grade_id` FOREIGN KEY (`ctcae_grade_id`) REFERENCES `clinical_trials_ecm`.`safety`.`ctcae_grade`(`ctcae_grade_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`endpoint` ADD CONSTRAINT `fk_study_endpoint_meddra_term_id` FOREIGN KEY (`meddra_term_id`) REFERENCES `clinical_trials_ecm`.`safety`.`meddra_term`(`meddra_term_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`eligibility_criterion` ADD CONSTRAINT `fk_study_eligibility_criterion_meddra_term_id` FOREIGN KEY (`meddra_term_id`) REFERENCES `clinical_trials_ecm`.`safety`.`meddra_term`(`meddra_term_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`visit_procedure` ADD CONSTRAINT `fk_study_visit_procedure_ctcae_grade_id` FOREIGN KEY (`ctcae_grade_id`) REFERENCES `clinical_trials_ecm`.`safety`.`ctcae_grade`(`ctcae_grade_id`);

-- ========= study --> site (1 constraint(s)) =========
-- Requires: study schema, site schema
ALTER TABLE `clinical_trials_ecm`.`study`.`study_milestone` ADD CONSTRAINT `fk_study_study_milestone_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);

-- ========= subject --> biostatistics (12 constraint(s)) =========
-- Requires: subject schema, biostatistics schema
ALTER TABLE `clinical_trials_ecm`.`subject`.`randomization_assignment` ADD CONSTRAINT `fk_subject_randomization_assignment_sap_id` FOREIGN KEY (`sap_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sap`(`sap_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`deviation` ADD CONSTRAINT `fk_subject_deviation_analysis_population_id` FOREIGN KEY (`analysis_population_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`analysis_population`(`analysis_population_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`deviation` ADD CONSTRAINT `fk_subject_deviation_sap_id` FOREIGN KEY (`sap_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sap`(`sap_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`disposition` ADD CONSTRAINT `fk_subject_disposition_estimand_id` FOREIGN KEY (`estimand_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`estimand`(`estimand_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`disposition` ADD CONSTRAINT `fk_subject_disposition_sap_id` FOREIGN KEY (`sap_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sap`(`sap_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`status_history` ADD CONSTRAINT `fk_subject_status_history_database_lock_event_id` FOREIGN KEY (`database_lock_event_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`database_lock_event`(`database_lock_event_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`population_assignment` ADD CONSTRAINT `fk_subject_population_assignment_analysis_population_id` FOREIGN KEY (`analysis_population_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`analysis_population`(`analysis_population_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`population_assignment` ADD CONSTRAINT `fk_subject_population_assignment_database_lock_event_id` FOREIGN KEY (`database_lock_event_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`database_lock_event`(`database_lock_event_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`population_assignment` ADD CONSTRAINT `fk_subject_population_assignment_estimand_id` FOREIGN KEY (`estimand_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`estimand`(`estimand_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`population_assignment` ADD CONSTRAINT `fk_subject_population_assignment_interim_analysis_id` FOREIGN KEY (`interim_analysis_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`interim_analysis`(`interim_analysis_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`population_assignment` ADD CONSTRAINT `fk_subject_population_assignment_sap_id` FOREIGN KEY (`sap_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sap`(`sap_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`demographic` ADD CONSTRAINT `fk_subject_demographic_database_lock_event_id` FOREIGN KEY (`database_lock_event_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`database_lock_event`(`database_lock_event_id`);

-- ========= subject --> compliance (9 constraint(s)) =========
-- Requires: subject schema, compliance schema
ALTER TABLE `clinical_trials_ecm`.`subject`.`enrollment` ADD CONSTRAINT `fk_subject_enrollment_ethics_approval_id` FOREIGN KEY (`ethics_approval_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_approval`(`ethics_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`deviation` ADD CONSTRAINT `fk_subject_deviation_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`capa`(`capa_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`deviation` ADD CONSTRAINT `fk_subject_deviation_deviation_classification_id` FOREIGN KEY (`deviation_classification_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`deviation_classification`(`deviation_classification_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`deviation` ADD CONSTRAINT `fk_subject_deviation_ethics_submission_id` FOREIGN KEY (`ethics_submission_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_submission`(`ethics_submission_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`deviation` ADD CONSTRAINT `fk_subject_deviation_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`disposition` ADD CONSTRAINT `fk_subject_disposition_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`eligibility_assessment` ADD CONSTRAINT `fk_subject_eligibility_assessment_ethics_approval_id` FOREIGN KEY (`ethics_approval_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_approval`(`ethics_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`eligibility_assessment` ADD CONSTRAINT `fk_subject_eligibility_assessment_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`status_history` ADD CONSTRAINT `fk_subject_status_history_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);

-- ========= subject --> data (13 constraint(s)) =========
-- Requires: subject schema, data schema
ALTER TABLE `clinical_trials_ecm`.`subject`.`enrollment` ADD CONSTRAINT `fk_subject_enrollment_edc_study_build_id` FOREIGN KEY (`edc_study_build_id`) REFERENCES `clinical_trials_ecm`.`data`.`edc_study_build`(`edc_study_build_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_visit` ADD CONSTRAINT `fk_subject_subject_visit_ecrf_form_id` FOREIGN KEY (`ecrf_form_id`) REFERENCES `clinical_trials_ecm`.`data`.`ecrf_form`(`ecrf_form_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_visit` ADD CONSTRAINT `fk_subject_subject_visit_edc_study_build_id` FOREIGN KEY (`edc_study_build_id`) REFERENCES `clinical_trials_ecm`.`data`.`edc_study_build`(`edc_study_build_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`deviation` ADD CONSTRAINT `fk_subject_deviation_ecrf_form_id` FOREIGN KEY (`ecrf_form_id`) REFERENCES `clinical_trials_ecm`.`data`.`ecrf_form`(`ecrf_form_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`deviation` ADD CONSTRAINT `fk_subject_deviation_validation_rule_id` FOREIGN KEY (`validation_rule_id`) REFERENCES `clinical_trials_ecm`.`data`.`validation_rule`(`validation_rule_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`disposition` ADD CONSTRAINT `fk_subject_disposition_ecrf_form_id` FOREIGN KEY (`ecrf_form_id`) REFERENCES `clinical_trials_ecm`.`data`.`ecrf_form`(`ecrf_form_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`eligibility_assessment` ADD CONSTRAINT `fk_subject_eligibility_assessment_ecrf_form_id` FOREIGN KEY (`ecrf_form_id`) REFERENCES `clinical_trials_ecm`.`data`.`ecrf_form`(`ecrf_form_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`population_assignment` ADD CONSTRAINT `fk_subject_population_assignment_sdtm_dataset_id` FOREIGN KEY (`sdtm_dataset_id`) REFERENCES `clinical_trials_ecm`.`data`.`sdtm_dataset`(`sdtm_dataset_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`demographic` ADD CONSTRAINT `fk_subject_demographic_ecrf_form_id` FOREIGN KEY (`ecrf_form_id`) REFERENCES `clinical_trials_ecm`.`data`.`ecrf_form`(`ecrf_form_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`medical_history` ADD CONSTRAINT `fk_subject_medical_history_coding_assignment_id` FOREIGN KEY (`coding_assignment_id`) REFERENCES `clinical_trials_ecm`.`data`.`coding_assignment`(`coding_assignment_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`medical_history` ADD CONSTRAINT `fk_subject_medical_history_ecrf_form_id` FOREIGN KEY (`ecrf_form_id`) REFERENCES `clinical_trials_ecm`.`data`.`ecrf_form`(`ecrf_form_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`concomitant_medication` ADD CONSTRAINT `fk_subject_concomitant_medication_coding_assignment_id` FOREIGN KEY (`coding_assignment_id`) REFERENCES `clinical_trials_ecm`.`data`.`coding_assignment`(`coding_assignment_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`concomitant_medication` ADD CONSTRAINT `fk_subject_concomitant_medication_ecrf_form_id` FOREIGN KEY (`ecrf_form_id`) REFERENCES `clinical_trials_ecm`.`data`.`ecrf_form`(`ecrf_form_id`);

-- ========= subject --> document (5 constraint(s)) =========
-- Requires: subject schema, document schema
ALTER TABLE `clinical_trials_ecm`.`subject`.`enrollment` ADD CONSTRAINT `fk_subject_enrollment_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`enrollment` ADD CONSTRAINT `fk_subject_enrollment_site_file_id` FOREIGN KEY (`site_file_id`) REFERENCES `clinical_trials_ecm`.`document`.`site_file`(`site_file_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`deviation` ADD CONSTRAINT `fk_subject_deviation_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`deviation` ADD CONSTRAINT `fk_subject_deviation_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`deviation` ADD CONSTRAINT `fk_subject_deviation_workflow_id` FOREIGN KEY (`workflow_id`) REFERENCES `clinical_trials_ecm`.`document`.`workflow`(`workflow_id`);

-- ========= subject --> laboratory (2 constraint(s)) =========
-- Requires: subject schema, laboratory schema
ALTER TABLE `clinical_trials_ecm`.`subject`.`deviation` ADD CONSTRAINT `fk_subject_deviation_lab_result_id` FOREIGN KEY (`lab_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_result`(`lab_result_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`eligibility_assessment` ADD CONSTRAINT `fk_subject_eligibility_assessment_lab_result_id` FOREIGN KEY (`lab_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_result`(`lab_result_id`);

-- ========= subject --> randomization (15 constraint(s)) =========
-- Requires: subject schema, randomization schema
ALTER TABLE `clinical_trials_ecm`.`subject`.`enrollment` ADD CONSTRAINT `fk_subject_enrollment_rand_scheme_id` FOREIGN KEY (`rand_scheme_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_scheme`(`rand_scheme_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`enrollment` ADD CONSTRAINT `fk_subject_enrollment_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`randomization_assignment` ADD CONSTRAINT `fk_subject_randomization_assignment_blinding_config_id` FOREIGN KEY (`blinding_config_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`blinding_config`(`blinding_config_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`randomization_assignment` ADD CONSTRAINT `fk_subject_randomization_assignment_irt_transaction_id` FOREIGN KEY (`irt_transaction_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`irt_transaction`(`irt_transaction_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`randomization_assignment` ADD CONSTRAINT `fk_subject_randomization_assignment_rand_code_id` FOREIGN KEY (`rand_code_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_code`(`rand_code_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`randomization_assignment` ADD CONSTRAINT `fk_subject_randomization_assignment_rand_list_id` FOREIGN KEY (`rand_list_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_list`(`rand_list_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`randomization_assignment` ADD CONSTRAINT `fk_subject_randomization_assignment_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`randomization_assignment` ADD CONSTRAINT `fk_subject_randomization_assignment_stratification_cell_id` FOREIGN KEY (`stratification_cell_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`stratification_cell`(`stratification_cell_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`randomization_assignment` ADD CONSTRAINT `fk_subject_randomization_assignment_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_visit` ADD CONSTRAINT `fk_subject_subject_visit_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`disposition` ADD CONSTRAINT `fk_subject_disposition_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`disposition` ADD CONSTRAINT `fk_subject_disposition_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`status_history` ADD CONSTRAINT `fk_subject_status_history_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`population_assignment` ADD CONSTRAINT `fk_subject_population_assignment_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`demographic` ADD CONSTRAINT `fk_subject_demographic_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);

-- ========= subject --> regulatory (8 constraint(s)) =========
-- Requires: subject schema, regulatory schema
ALTER TABLE `clinical_trials_ecm`.`subject`.`trial_subject` ADD CONSTRAINT `fk_subject_trial_subject_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`enrollment` ADD CONSTRAINT `fk_subject_enrollment_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`enrollment` ADD CONSTRAINT `fk_subject_enrollment_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`enrollment` ADD CONSTRAINT `fk_subject_enrollment_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`deviation` ADD CONSTRAINT `fk_subject_deviation_correspondence_id` FOREIGN KEY (`correspondence_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`correspondence`(`correspondence_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`deviation` ADD CONSTRAINT `fk_subject_deviation_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`deviation` ADD CONSTRAINT `fk_subject_deviation_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`status_history` ADD CONSTRAINT `fk_subject_status_history_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);

-- ========= subject --> safety (4 constraint(s)) =========
-- Requires: subject schema, safety schema
ALTER TABLE `clinical_trials_ecm`.`subject`.`deviation` ADD CONSTRAINT `fk_subject_deviation_adverse_event_id` FOREIGN KEY (`adverse_event_id`) REFERENCES `clinical_trials_ecm`.`safety`.`adverse_event`(`adverse_event_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`disposition` ADD CONSTRAINT `fk_subject_disposition_adverse_event_id` FOREIGN KEY (`adverse_event_id`) REFERENCES `clinical_trials_ecm`.`safety`.`adverse_event`(`adverse_event_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`status_history` ADD CONSTRAINT `fk_subject_status_history_adverse_event_id` FOREIGN KEY (`adverse_event_id`) REFERENCES `clinical_trials_ecm`.`safety`.`adverse_event`(`adverse_event_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`concomitant_medication` ADD CONSTRAINT `fk_subject_concomitant_medication_adverse_event_id` FOREIGN KEY (`adverse_event_id`) REFERENCES `clinical_trials_ecm`.`safety`.`adverse_event`(`adverse_event_id`);

-- ========= subject --> site (30 constraint(s)) =========
-- Requires: subject schema, site schema
ALTER TABLE `clinical_trials_ecm`.`subject`.`trial_subject` ADD CONSTRAINT `fk_subject_trial_subject_irb_iec_approval_id` FOREIGN KEY (`irb_iec_approval_id`) REFERENCES `clinical_trials_ecm`.`site`.`irb_iec_approval`(`irb_iec_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`trial_subject` ADD CONSTRAINT `fk_subject_trial_subject_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`enrollment` ADD CONSTRAINT `fk_subject_enrollment_activation_id` FOREIGN KEY (`activation_id`) REFERENCES `clinical_trials_ecm`.`site`.`activation`(`activation_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`enrollment` ADD CONSTRAINT `fk_subject_enrollment_irb_iec_approval_id` FOREIGN KEY (`irb_iec_approval_id`) REFERENCES `clinical_trials_ecm`.`site`.`irb_iec_approval`(`irb_iec_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`enrollment` ADD CONSTRAINT `fk_subject_enrollment_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `clinical_trials_ecm`.`site`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`enrollment` ADD CONSTRAINT `fk_subject_enrollment_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`randomization_assignment` ADD CONSTRAINT `fk_subject_randomization_assignment_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_visit` ADD CONSTRAINT `fk_subject_subject_visit_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `clinical_trials_ecm`.`site`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_visit` ADD CONSTRAINT `fk_subject_subject_visit_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`deviation` ADD CONSTRAINT `fk_subject_deviation_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`deviation` ADD CONSTRAINT `fk_subject_deviation_irb_iec_approval_id` FOREIGN KEY (`irb_iec_approval_id`) REFERENCES `clinical_trials_ecm`.`site`.`irb_iec_approval`(`irb_iec_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`deviation` ADD CONSTRAINT `fk_subject_deviation_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `clinical_trials_ecm`.`site`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`deviation` ADD CONSTRAINT `fk_subject_deviation_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`disposition` ADD CONSTRAINT `fk_subject_disposition_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `clinical_trials_ecm`.`site`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`disposition` ADD CONSTRAINT `fk_subject_disposition_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`eligibility_assessment` ADD CONSTRAINT `fk_subject_eligibility_assessment_irb_iec_approval_id` FOREIGN KEY (`irb_iec_approval_id`) REFERENCES `clinical_trials_ecm`.`site`.`irb_iec_approval`(`irb_iec_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`eligibility_assessment` ADD CONSTRAINT `fk_subject_eligibility_assessment_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `clinical_trials_ecm`.`site`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`eligibility_assessment` ADD CONSTRAINT `fk_subject_eligibility_assessment_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`status_history` ADD CONSTRAINT `fk_subject_status_history_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`status_history` ADD CONSTRAINT `fk_subject_status_history_irb_iec_approval_id` FOREIGN KEY (`irb_iec_approval_id`) REFERENCES `clinical_trials_ecm`.`site`.`irb_iec_approval`(`irb_iec_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`status_history` ADD CONSTRAINT `fk_subject_status_history_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `clinical_trials_ecm`.`site`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`status_history` ADD CONSTRAINT `fk_subject_status_history_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_contact` ADD CONSTRAINT `fk_subject_subject_contact_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`population_assignment` ADD CONSTRAINT `fk_subject_population_assignment_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`demographic` ADD CONSTRAINT `fk_subject_demographic_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `clinical_trials_ecm`.`site`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`demographic` ADD CONSTRAINT `fk_subject_demographic_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`medical_history` ADD CONSTRAINT `fk_subject_medical_history_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `clinical_trials_ecm`.`site`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`medical_history` ADD CONSTRAINT `fk_subject_medical_history_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`concomitant_medication` ADD CONSTRAINT `fk_subject_concomitant_medication_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `clinical_trials_ecm`.`site`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`concomitant_medication` ADD CONSTRAINT `fk_subject_concomitant_medication_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);

-- ========= subject --> study (31 constraint(s)) =========
-- Requires: subject schema, study schema
ALTER TABLE `clinical_trials_ecm`.`subject`.`trial_subject` ADD CONSTRAINT `fk_subject_trial_subject_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`trial_subject` ADD CONSTRAINT `fk_subject_trial_subject_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`enrollment` ADD CONSTRAINT `fk_subject_enrollment_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`enrollment` ADD CONSTRAINT `fk_subject_enrollment_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`enrollment` ADD CONSTRAINT `fk_subject_enrollment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`randomization_assignment` ADD CONSTRAINT `fk_subject_randomization_assignment_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`randomization_assignment` ADD CONSTRAINT `fk_subject_randomization_assignment_dosing_regimen_id` FOREIGN KEY (`dosing_regimen_id`) REFERENCES `clinical_trials_ecm`.`study`.`dosing_regimen`(`dosing_regimen_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`randomization_assignment` ADD CONSTRAINT `fk_subject_randomization_assignment_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`randomization_assignment` ADD CONSTRAINT `fk_subject_randomization_assignment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_visit` ADD CONSTRAINT `fk_subject_subject_visit_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_visit` ADD CONSTRAINT `fk_subject_subject_visit_study_visit_schedule_id` FOREIGN KEY (`study_visit_schedule_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_visit_schedule`(`study_visit_schedule_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`deviation` ADD CONSTRAINT `fk_subject_deviation_eligibility_criterion_id` FOREIGN KEY (`eligibility_criterion_id`) REFERENCES `clinical_trials_ecm`.`study`.`eligibility_criterion`(`eligibility_criterion_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`deviation` ADD CONSTRAINT `fk_subject_deviation_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`deviation` ADD CONSTRAINT `fk_subject_deviation_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`deviation` ADD CONSTRAINT `fk_subject_deviation_visit_procedure_id` FOREIGN KEY (`visit_procedure_id`) REFERENCES `clinical_trials_ecm`.`study`.`visit_procedure`(`visit_procedure_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`disposition` ADD CONSTRAINT `fk_subject_disposition_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`disposition` ADD CONSTRAINT `fk_subject_disposition_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`eligibility_assessment` ADD CONSTRAINT `fk_subject_eligibility_assessment_eligibility_criterion_id` FOREIGN KEY (`eligibility_criterion_id`) REFERENCES `clinical_trials_ecm`.`study`.`eligibility_criterion`(`eligibility_criterion_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`eligibility_assessment` ADD CONSTRAINT `fk_subject_eligibility_assessment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`eligibility_assessment` ADD CONSTRAINT `fk_subject_eligibility_assessment_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`status_history` ADD CONSTRAINT `fk_subject_status_history_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`status_history` ADD CONSTRAINT `fk_subject_status_history_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`status_history` ADD CONSTRAINT `fk_subject_status_history_study_milestone_id` FOREIGN KEY (`study_milestone_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_milestone`(`study_milestone_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_contact` ADD CONSTRAINT `fk_subject_subject_contact_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`population_assignment` ADD CONSTRAINT `fk_subject_population_assignment_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`population_assignment` ADD CONSTRAINT `fk_subject_population_assignment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`population_assignment` ADD CONSTRAINT `fk_subject_population_assignment_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`demographic` ADD CONSTRAINT `fk_subject_demographic_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`demographic` ADD CONSTRAINT `fk_subject_demographic_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`medical_history` ADD CONSTRAINT `fk_subject_medical_history_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`concomitant_medication` ADD CONSTRAINT `fk_subject_concomitant_medication_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);

-- ========= supply --> biostatistics (8 constraint(s)) =========
-- Requires: supply schema, biostatistics schema
ALTER TABLE `clinical_trials_ecm`.`supply`.`site_inventory` ADD CONSTRAINT `fk_supply_site_inventory_interim_analysis_id` FOREIGN KEY (`interim_analysis_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`interim_analysis`(`interim_analysis_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_sap_id` FOREIGN KEY (`sap_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sap`(`sap_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`dispensing_record` ADD CONSTRAINT `fk_supply_dispensing_record_database_lock_event_id` FOREIGN KEY (`database_lock_event_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`database_lock_event`(`database_lock_event_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`return_record` ADD CONSTRAINT `fk_supply_return_record_database_lock_event_id` FOREIGN KEY (`database_lock_event_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`database_lock_event`(`database_lock_event_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`destruction_record` ADD CONSTRAINT `fk_supply_destruction_record_database_lock_event_id` FOREIGN KEY (`database_lock_event_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`database_lock_event`(`database_lock_event_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_database_lock_event_id` FOREIGN KEY (`database_lock_event_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`database_lock_event`(`database_lock_event_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_sap_id` FOREIGN KEY (`sap_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sap`(`sap_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`resupply_order` ADD CONSTRAINT `fk_supply_resupply_order_interim_analysis_id` FOREIGN KEY (`interim_analysis_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`interim_analysis`(`interim_analysis_id`);

-- ========= supply --> compliance (19 constraint(s)) =========
-- Requires: supply schema, compliance schema
ALTER TABLE `clinical_trials_ecm`.`supply`.`site_inventory` ADD CONSTRAINT `fk_supply_site_inventory_quality_event_id` FOREIGN KEY (`quality_event_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`quality_event`(`quality_event_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`manufacture_batch` ADD CONSTRAINT `fk_supply_manufacture_batch_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`capa`(`capa_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`dispensing_record` ADD CONSTRAINT `fk_supply_dispensing_record_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`return_record` ADD CONSTRAINT `fk_supply_return_record_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`return_record` ADD CONSTRAINT `fk_supply_return_record_quality_event_id` FOREIGN KEY (`quality_event_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`quality_event`(`quality_event_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`destruction_record` ADD CONSTRAINT `fk_supply_destruction_record_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`destruction_record` ADD CONSTRAINT `fk_supply_destruction_record_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`capa`(`capa_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`destruction_record` ADD CONSTRAINT `fk_supply_destruction_record_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`temperature_excursion` ADD CONSTRAINT `fk_supply_temperature_excursion_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`capa`(`capa_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`temperature_excursion` ADD CONSTRAINT `fk_supply_temperature_excursion_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`temperature_excursion` ADD CONSTRAINT `fk_supply_temperature_excursion_deviation_classification_id` FOREIGN KEY (`deviation_classification_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`deviation_classification`(`deviation_classification_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`temperature_excursion` ADD CONSTRAINT `fk_supply_temperature_excursion_quality_event_id` FOREIGN KEY (`quality_event_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`quality_event`(`quality_event_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`capa`(`capa_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_inspection_finding_id` FOREIGN KEY (`inspection_finding_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`inspection_finding`(`inspection_finding_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_quality_event_id` FOREIGN KEY (`quality_event_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`quality_event`(`quality_event_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`depot_inventory` ADD CONSTRAINT `fk_supply_depot_inventory_quality_event_id` FOREIGN KEY (`quality_event_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`quality_event`(`quality_event_id`);

-- ========= supply --> data (2 constraint(s)) =========
-- Requires: supply schema, data schema
ALTER TABLE `clinical_trials_ecm`.`supply`.`dispensing_record` ADD CONSTRAINT `fk_supply_dispensing_record_subject_visit_data_id` FOREIGN KEY (`subject_visit_data_id`) REFERENCES `clinical_trials_ecm`.`data`.`subject_visit_data`(`subject_visit_data_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_subject_visit_data_id` FOREIGN KEY (`subject_visit_data_id`) REFERENCES `clinical_trials_ecm`.`data`.`subject_visit_data`(`subject_visit_data_id`);

-- ========= supply --> document (20 constraint(s)) =========
-- Requires: supply schema, document schema
ALTER TABLE `clinical_trials_ecm`.`supply`.`imp_master` ADD CONSTRAINT `fk_supply_imp_master_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`imp_master` ADD CONSTRAINT `fk_supply_imp_master_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`kit_definition` ADD CONSTRAINT `fk_supply_kit_definition_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`manufacture_batch` ADD CONSTRAINT `fk_supply_manufacture_batch_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`dispensing_record` ADD CONSTRAINT `fk_supply_dispensing_record_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`return_record` ADD CONSTRAINT `fk_supply_return_record_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`destruction_record` ADD CONSTRAINT `fk_supply_destruction_record_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`destruction_record` ADD CONSTRAINT `fk_supply_destruction_record_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`destruction_record` ADD CONSTRAINT `fk_supply_destruction_record_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`temperature_excursion` ADD CONSTRAINT `fk_supply_temperature_excursion_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`temperature_excursion` ADD CONSTRAINT `fk_supply_temperature_excursion_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_site_file_id` FOREIGN KEY (`site_file_id`) REFERENCES `clinical_trials_ecm`.`document`.`site_file`(`site_file_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`import_permit` ADD CONSTRAINT `fk_supply_import_permit_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`import_permit` ADD CONSTRAINT `fk_supply_import_permit_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);

-- ========= supply --> monitoring (7 constraint(s)) =========
-- Requires: supply schema, monitoring schema
ALTER TABLE `clinical_trials_ecm`.`supply`.`site_inventory` ADD CONSTRAINT `fk_supply_site_inventory_site_risk_assessment_id` FOREIGN KEY (`site_risk_assessment_id`) REFERENCES `clinical_trials_ecm`.`monitoring`.`site_risk_assessment`(`site_risk_assessment_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`return_record` ADD CONSTRAINT `fk_supply_return_record_monitoring_visit_id` FOREIGN KEY (`monitoring_visit_id`) REFERENCES `clinical_trials_ecm`.`monitoring`.`monitoring_visit`(`monitoring_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`destruction_record` ADD CONSTRAINT `fk_supply_destruction_record_monitoring_visit_id` FOREIGN KEY (`monitoring_visit_id`) REFERENCES `clinical_trials_ecm`.`monitoring`.`monitoring_visit`(`monitoring_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`temperature_excursion` ADD CONSTRAINT `fk_supply_temperature_excursion_central_monitoring_alert_id` FOREIGN KEY (`central_monitoring_alert_id`) REFERENCES `clinical_trials_ecm`.`monitoring`.`central_monitoring_alert`(`central_monitoring_alert_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`temperature_excursion` ADD CONSTRAINT `fk_supply_temperature_excursion_monitoring_visit_id` FOREIGN KEY (`monitoring_visit_id`) REFERENCES `clinical_trials_ecm`.`monitoring`.`monitoring_visit`(`monitoring_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_visit_report_id` FOREIGN KEY (`visit_report_id`) REFERENCES `clinical_trials_ecm`.`monitoring`.`visit_report`(`visit_report_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`resupply_order` ADD CONSTRAINT `fk_supply_resupply_order_monitoring_visit_id` FOREIGN KEY (`monitoring_visit_id`) REFERENCES `clinical_trials_ecm`.`monitoring`.`monitoring_visit`(`monitoring_visit_id`);

-- ========= supply --> randomization (20 constraint(s)) =========
-- Requires: supply schema, randomization schema
ALTER TABLE `clinical_trials_ecm`.`supply`.`kit_definition` ADD CONSTRAINT `fk_supply_kit_definition_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`kit_inventory` ADD CONSTRAINT `fk_supply_kit_inventory_rand_code_id` FOREIGN KEY (`rand_code_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_code`(`rand_code_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`kit_inventory` ADD CONSTRAINT `fk_supply_kit_inventory_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`site_inventory` ADD CONSTRAINT `fk_supply_site_inventory_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_rand_scheme_id` FOREIGN KEY (`rand_scheme_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_scheme`(`rand_scheme_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`manufacture_batch` ADD CONSTRAINT `fk_supply_manufacture_batch_rand_scheme_id` FOREIGN KEY (`rand_scheme_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_scheme`(`rand_scheme_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`manufacture_batch` ADD CONSTRAINT `fk_supply_manufacture_batch_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`dispensing_record` ADD CONSTRAINT `fk_supply_dispensing_record_kit_assignment_id` FOREIGN KEY (`kit_assignment_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`kit_assignment`(`kit_assignment_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`dispensing_record` ADD CONSTRAINT `fk_supply_dispensing_record_rand_code_id` FOREIGN KEY (`rand_code_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_code`(`rand_code_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`dispensing_record` ADD CONSTRAINT `fk_supply_dispensing_record_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`return_record` ADD CONSTRAINT `fk_supply_return_record_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`return_record` ADD CONSTRAINT `fk_supply_return_record_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`destruction_record` ADD CONSTRAINT `fk_supply_destruction_record_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`temperature_excursion` ADD CONSTRAINT `fk_supply_temperature_excursion_kit_assignment_id` FOREIGN KEY (`kit_assignment_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`kit_assignment`(`kit_assignment_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_rand_scheme_id` FOREIGN KEY (`rand_scheme_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_scheme`(`rand_scheme_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`resupply_order` ADD CONSTRAINT `fk_supply_resupply_order_stratification_cell_id` FOREIGN KEY (`stratification_cell_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`stratification_cell`(`stratification_cell_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`resupply_order` ADD CONSTRAINT `fk_supply_resupply_order_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`depot_inventory` ADD CONSTRAINT `fk_supply_depot_inventory_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);

-- ========= supply --> regulatory (26 constraint(s)) =========
-- Requires: supply schema, regulatory schema
ALTER TABLE `clinical_trials_ecm`.`supply`.`imp_master` ADD CONSTRAINT `fk_supply_imp_master_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`imp_master` ADD CONSTRAINT `fk_supply_imp_master_special_designation_id` FOREIGN KEY (`special_designation_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`special_designation`(`special_designation_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`kit_definition` ADD CONSTRAINT `fk_supply_kit_definition_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`kit_definition` ADD CONSTRAINT `fk_supply_kit_definition_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`kit_inventory` ADD CONSTRAINT `fk_supply_kit_inventory_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`depot` ADD CONSTRAINT `fk_supply_depot_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`depot` ADD CONSTRAINT `fk_supply_depot_country_registration_id` FOREIGN KEY (`country_registration_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`country_registration`(`country_registration_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`site_inventory` ADD CONSTRAINT `fk_supply_site_inventory_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_country_registration_id` FOREIGN KEY (`country_registration_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`country_registration`(`country_registration_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`strategy`(`strategy_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`manufacture_batch` ADD CONSTRAINT `fk_supply_manufacture_batch_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`manufacture_batch` ADD CONSTRAINT `fk_supply_manufacture_batch_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`manufacture_batch` ADD CONSTRAINT `fk_supply_manufacture_batch_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`dispensing_record` ADD CONSTRAINT `fk_supply_dispensing_record_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`return_record` ADD CONSTRAINT `fk_supply_return_record_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`destruction_record` ADD CONSTRAINT `fk_supply_destruction_record_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`temperature_excursion` ADD CONSTRAINT `fk_supply_temperature_excursion_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`resupply_order` ADD CONSTRAINT `fk_supply_resupply_order_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`import_permit` ADD CONSTRAINT `fk_supply_import_permit_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`import_permit` ADD CONSTRAINT `fk_supply_import_permit_country_registration_id` FOREIGN KEY (`country_registration_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`country_registration`(`country_registration_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`import_permit` ADD CONSTRAINT `fk_supply_import_permit_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`depot_inventory` ADD CONSTRAINT `fk_supply_depot_inventory_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);

-- ========= supply --> safety (1 constraint(s)) =========
-- Requires: supply schema, safety schema
ALTER TABLE `clinical_trials_ecm`.`supply`.`temperature_excursion` ADD CONSTRAINT `fk_supply_temperature_excursion_adverse_event_id` FOREIGN KEY (`adverse_event_id`) REFERENCES `clinical_trials_ecm`.`safety`.`adverse_event`(`adverse_event_id`);

-- ========= supply --> site (12 constraint(s)) =========
-- Requires: supply schema, site schema
ALTER TABLE `clinical_trials_ecm`.`supply`.`kit_inventory` ADD CONSTRAINT `fk_supply_kit_inventory_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`site_inventory` ADD CONSTRAINT `fk_supply_site_inventory_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`dispensing_record` ADD CONSTRAINT `fk_supply_dispensing_record_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`return_record` ADD CONSTRAINT `fk_supply_return_record_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`destruction_record` ADD CONSTRAINT `fk_supply_destruction_record_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`temperature_excursion` ADD CONSTRAINT `fk_supply_temperature_excursion_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `clinical_trials_ecm`.`site`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_site_cra_assignment_id` FOREIGN KEY (`site_cra_assignment_id`) REFERENCES `clinical_trials_ecm`.`site`.`site_cra_assignment`(`site_cra_assignment_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`resupply_order` ADD CONSTRAINT `fk_supply_resupply_order_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);

-- ========= supply --> study (31 constraint(s)) =========
-- Requires: supply schema, study schema
ALTER TABLE `clinical_trials_ecm`.`supply`.`kit_definition` ADD CONSTRAINT `fk_supply_kit_definition_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`kit_definition` ADD CONSTRAINT `fk_supply_kit_definition_dosing_regimen_id` FOREIGN KEY (`dosing_regimen_id`) REFERENCES `clinical_trials_ecm`.`study`.`dosing_regimen`(`dosing_regimen_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`kit_definition` ADD CONSTRAINT `fk_supply_kit_definition_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `clinical_trials_ecm`.`study`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`kit_inventory` ADD CONSTRAINT `fk_supply_kit_inventory_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`kit_inventory` ADD CONSTRAINT `fk_supply_kit_inventory_dosing_regimen_id` FOREIGN KEY (`dosing_regimen_id`) REFERENCES `clinical_trials_ecm`.`study`.`dosing_regimen`(`dosing_regimen_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`site_inventory` ADD CONSTRAINT `fk_supply_site_inventory_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`site_inventory` ADD CONSTRAINT `fk_supply_site_inventory_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_country_id` FOREIGN KEY (`country_id`) REFERENCES `clinical_trials_ecm`.`study`.`country`(`country_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_dosing_regimen_id` FOREIGN KEY (`dosing_regimen_id`) REFERENCES `clinical_trials_ecm`.`study`.`dosing_regimen`(`dosing_regimen_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `clinical_trials_ecm`.`study`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`manufacture_batch` ADD CONSTRAINT `fk_supply_manufacture_batch_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `clinical_trials_ecm`.`study`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`manufacture_batch` ADD CONSTRAINT `fk_supply_manufacture_batch_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_country_id` FOREIGN KEY (`country_id`) REFERENCES `clinical_trials_ecm`.`study`.`country`(`country_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`dispensing_record` ADD CONSTRAINT `fk_supply_dispensing_record_study_visit_schedule_id` FOREIGN KEY (`study_visit_schedule_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_visit_schedule`(`study_visit_schedule_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`return_record` ADD CONSTRAINT `fk_supply_return_record_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`destruction_record` ADD CONSTRAINT `fk_supply_destruction_record_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`temperature_excursion` ADD CONSTRAINT `fk_supply_temperature_excursion_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `clinical_trials_ecm`.`study`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`temperature_excursion` ADD CONSTRAINT `fk_supply_temperature_excursion_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`resupply_order` ADD CONSTRAINT `fk_supply_resupply_order_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`resupply_order` ADD CONSTRAINT `fk_supply_resupply_order_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`import_permit` ADD CONSTRAINT `fk_supply_import_permit_country_id` FOREIGN KEY (`country_id`) REFERENCES `clinical_trials_ecm`.`study`.`country`(`country_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`import_permit` ADD CONSTRAINT `fk_supply_import_permit_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`import_permit` ADD CONSTRAINT `fk_supply_import_permit_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`depot_inventory` ADD CONSTRAINT `fk_supply_depot_inventory_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study`(`study_id`);

-- ========= supply --> subject (13 constraint(s)) =========
-- Requires: supply schema, subject schema
ALTER TABLE `clinical_trials_ecm`.`supply`.`kit_inventory` ADD CONSTRAINT `fk_supply_kit_inventory_enrollment_id` FOREIGN KEY (`enrollment_id`) REFERENCES `clinical_trials_ecm`.`subject`.`enrollment`(`enrollment_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`kit_inventory` ADD CONSTRAINT `fk_supply_kit_inventory_randomization_assignment_id` FOREIGN KEY (`randomization_assignment_id`) REFERENCES `clinical_trials_ecm`.`subject`.`randomization_assignment`(`randomization_assignment_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`kit_inventory` ADD CONSTRAINT `fk_supply_kit_inventory_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`kit_inventory` ADD CONSTRAINT `fk_supply_kit_inventory_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`dispensing_record` ADD CONSTRAINT `fk_supply_dispensing_record_enrollment_id` FOREIGN KEY (`enrollment_id`) REFERENCES `clinical_trials_ecm`.`subject`.`enrollment`(`enrollment_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`dispensing_record` ADD CONSTRAINT `fk_supply_dispensing_record_randomization_assignment_id` FOREIGN KEY (`randomization_assignment_id`) REFERENCES `clinical_trials_ecm`.`subject`.`randomization_assignment`(`randomization_assignment_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`dispensing_record` ADD CONSTRAINT `fk_supply_dispensing_record_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`dispensing_record` ADD CONSTRAINT `fk_supply_dispensing_record_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`return_record` ADD CONSTRAINT `fk_supply_return_record_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `clinical_trials_ecm`.`subject`.`deviation`(`deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`return_record` ADD CONSTRAINT `fk_supply_return_record_disposition_id` FOREIGN KEY (`disposition_id`) REFERENCES `clinical_trials_ecm`.`subject`.`disposition`(`disposition_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`return_record` ADD CONSTRAINT `fk_supply_return_record_enrollment_id` FOREIGN KEY (`enrollment_id`) REFERENCES `clinical_trials_ecm`.`subject`.`enrollment`(`enrollment_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`return_record` ADD CONSTRAINT `fk_supply_return_record_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_deviation_id` FOREIGN KEY (`deviation_id`) REFERENCES `clinical_trials_ecm`.`subject`.`deviation`(`deviation_id`);

