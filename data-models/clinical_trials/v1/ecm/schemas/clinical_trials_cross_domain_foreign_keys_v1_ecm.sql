-- Cross-Domain Foreign Keys for Business: Clinical Trials | Version: v1_ecm
-- Generated on: 2026-05-06 23:40:07
-- Total cross-domain FK constraints: 2230
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: agreement, biostatistics, compliance, consent, data, document, finance, laboratory, monitoring, program, randomization, regulatory, safety, site, sponsor, study, subject, supply, workforce

-- ========= agreement --> compliance (19 constraint(s)) =========
-- Requires: agreement schema, compliance schema
ALTER TABLE `clinical_trials_ecm`.`agreement`.`master_service_agreement` ADD CONSTRAINT `fk_agreement_master_service_agreement_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`scope_of_work` ADD CONSTRAINT `fk_agreement_scope_of_work_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`change_order` ADD CONSTRAINT `fk_agreement_change_order_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`contract_amendment` ADD CONSTRAINT `fk_agreement_contract_amendment_inspection_finding_id` FOREIGN KEY (`inspection_finding_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`inspection_finding`(`inspection_finding_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`service_level_agreement` ADD CONSTRAINT `fk_agreement_service_level_agreement_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`service_level_agreement` ADD CONSTRAINT `fk_agreement_service_level_agreement_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`deliverable` ADD CONSTRAINT `fk_agreement_deliverable_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`deliverable` ADD CONSTRAINT `fk_agreement_deliverable_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`investigator_grant` ADD CONSTRAINT `fk_agreement_investigator_grant_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`investigator_grant` ADD CONSTRAINT `fk_agreement_investigator_grant_ethics_approval_id` FOREIGN KEY (`ethics_approval_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_approval`(`ethics_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`investigator_grant` ADD CONSTRAINT `fk_agreement_investigator_grant_ethics_submission_id` FOREIGN KEY (`ethics_submission_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_submission`(`ethics_submission_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`contract_negotiation` ADD CONSTRAINT `fk_agreement_contract_negotiation_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`contract_obligation` ADD CONSTRAINT `fk_agreement_contract_obligation_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`contract_obligation` ADD CONSTRAINT `fk_agreement_contract_obligation_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`contract_obligation` ADD CONSTRAINT `fk_agreement_contract_obligation_regulatory_commitment_id` FOREIGN KEY (`regulatory_commitment_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`regulatory_commitment`(`regulatory_commitment_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`preferred_provider_agreement` ADD CONSTRAINT `fk_agreement_preferred_provider_agreement_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`subcontract` ADD CONSTRAINT `fk_agreement_subcontract_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`subcontract` ADD CONSTRAINT `fk_agreement_subcontract_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`subcontract` ADD CONSTRAINT `fk_agreement_subcontract_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);

-- ========= agreement --> consent (1 constraint(s)) =========
-- Requires: agreement schema, consent schema
ALTER TABLE `clinical_trials_ecm`.`agreement`.`deliverable` ADD CONSTRAINT `fk_agreement_deliverable_consent_icf_version_id` FOREIGN KEY (`consent_icf_version_id`) REFERENCES `clinical_trials_ecm`.`consent`.`consent_icf_version`(`consent_icf_version_id`);

-- ========= agreement --> document (9 constraint(s)) =========
-- Requires: agreement schema, document schema
ALTER TABLE `clinical_trials_ecm`.`agreement`.`study_contract` ADD CONSTRAINT `fk_agreement_study_contract_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`scope_of_work` ADD CONSTRAINT `fk_agreement_scope_of_work_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`change_order` ADD CONSTRAINT `fk_agreement_change_order_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`contract_amendment` ADD CONSTRAINT `fk_agreement_contract_amendment_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`contract_amendment` ADD CONSTRAINT `fk_agreement_contract_amendment_version_id` FOREIGN KEY (`version_id`) REFERENCES `clinical_trials_ecm`.`document`.`version`(`version_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`investigator_grant` ADD CONSTRAINT `fk_agreement_investigator_grant_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`contract_negotiation` ADD CONSTRAINT `fk_agreement_contract_negotiation_version_id` FOREIGN KEY (`version_id`) REFERENCES `clinical_trials_ecm`.`document`.`version`(`version_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`contract_obligation` ADD CONSTRAINT `fk_agreement_contract_obligation_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`confidentiality_agreement` ADD CONSTRAINT `fk_agreement_confidentiality_agreement_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);

-- ========= agreement --> laboratory (7 constraint(s)) =========
-- Requires: agreement schema, laboratory schema
ALTER TABLE `clinical_trials_ecm`.`agreement`.`service_level_agreement` ADD CONSTRAINT `fk_agreement_service_level_agreement_lab_facility_id` FOREIGN KEY (`lab_facility_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_facility`(`lab_facility_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`deliverable` ADD CONSTRAINT `fk_agreement_deliverable_lab_accreditation_id` FOREIGN KEY (`lab_accreditation_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_accreditation`(`lab_accreditation_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`deliverable` ADD CONSTRAINT `fk_agreement_deliverable_lab_certification_id` FOREIGN KEY (`lab_certification_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_certification`(`lab_certification_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`confidentiality_agreement` ADD CONSTRAINT `fk_agreement_confidentiality_agreement_lab_facility_id` FOREIGN KEY (`lab_facility_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_facility`(`lab_facility_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`subcontract` ADD CONSTRAINT `fk_agreement_subcontract_lab_facility_id` FOREIGN KEY (`lab_facility_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_facility`(`lab_facility_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`rate_card` ADD CONSTRAINT `fk_agreement_rate_card_lab_facility_id` FOREIGN KEY (`lab_facility_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_facility`(`lab_facility_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`rate_card` ADD CONSTRAINT `fk_agreement_rate_card_lab_panel_id` FOREIGN KEY (`lab_panel_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_panel`(`lab_panel_id`);

-- ========= agreement --> program (7 constraint(s)) =========
-- Requires: agreement schema, program schema
ALTER TABLE `clinical_trials_ecm`.`agreement`.`master_service_agreement` ADD CONSTRAINT `fk_agreement_master_service_agreement_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`master_service_agreement` ADD CONSTRAINT `fk_agreement_master_service_agreement_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `clinical_trials_ecm`.`program`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`study_contract` ADD CONSTRAINT `fk_agreement_study_contract_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `clinical_trials_ecm`.`program`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`contract_negotiation` ADD CONSTRAINT `fk_agreement_contract_negotiation_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`preferred_provider_agreement` ADD CONSTRAINT `fk_agreement_preferred_provider_agreement_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`preferred_provider_agreement` ADD CONSTRAINT `fk_agreement_preferred_provider_agreement_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `clinical_trials_ecm`.`program`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`rate_card` ADD CONSTRAINT `fk_agreement_rate_card_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `clinical_trials_ecm`.`program`.`therapeutic_area`(`therapeutic_area_id`);

-- ========= agreement --> regulatory (10 constraint(s)) =========
-- Requires: agreement schema, regulatory schema
ALTER TABLE `clinical_trials_ecm`.`agreement`.`study_contract` ADD CONSTRAINT `fk_agreement_study_contract_application_id` FOREIGN KEY (`application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`application`(`application_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`change_order` ADD CONSTRAINT `fk_agreement_change_order_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`contract_amendment` ADD CONSTRAINT `fk_agreement_contract_amendment_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`service_level_agreement` ADD CONSTRAINT `fk_agreement_service_level_agreement_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`agreement_billing_milestone` ADD CONSTRAINT `fk_agreement_agreement_billing_milestone_regulatory_milestone_id` FOREIGN KEY (`regulatory_milestone_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_milestone`(`regulatory_milestone_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`agreement_billing_milestone` ADD CONSTRAINT `fk_agreement_agreement_billing_milestone_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`deliverable` ADD CONSTRAINT `fk_agreement_deliverable_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`investigator_grant` ADD CONSTRAINT `fk_agreement_investigator_grant_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`contract_negotiation` ADD CONSTRAINT `fk_agreement_contract_negotiation_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`strategy`(`strategy_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`contract_obligation` ADD CONSTRAINT `fk_agreement_contract_obligation_regulatory_action_item_id` FOREIGN KEY (`regulatory_action_item_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_action_item`(`regulatory_action_item_id`);

-- ========= agreement --> site (3 constraint(s)) =========
-- Requires: agreement schema, site schema
ALTER TABLE `clinical_trials_ecm`.`agreement`.`investigator_grant` ADD CONSTRAINT `fk_agreement_investigator_grant_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`investigator_grant` ADD CONSTRAINT `fk_agreement_investigator_grant_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `clinical_trials_ecm`.`site`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`investigator_grant` ADD CONSTRAINT `fk_agreement_investigator_grant_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);

-- ========= agreement --> sponsor (12 constraint(s)) =========
-- Requires: agreement schema, sponsor schema
ALTER TABLE `clinical_trials_ecm`.`agreement`.`study_contract` ADD CONSTRAINT `fk_agreement_study_contract_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`scope_of_work` ADD CONSTRAINT `fk_agreement_scope_of_work_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`change_order` ADD CONSTRAINT `fk_agreement_change_order_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`contract_amendment` ADD CONSTRAINT `fk_agreement_contract_amendment_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`service_level_agreement` ADD CONSTRAINT `fk_agreement_service_level_agreement_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`agreement_billing_milestone` ADD CONSTRAINT `fk_agreement_agreement_billing_milestone_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`deliverable` ADD CONSTRAINT `fk_agreement_deliverable_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`deliverable` ADD CONSTRAINT `fk_agreement_deliverable_sponsor_contact_id` FOREIGN KEY (`sponsor_contact_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`sponsor_contact`(`sponsor_contact_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`investigator_grant` ADD CONSTRAINT `fk_agreement_investigator_grant_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`contract_negotiation` ADD CONSTRAINT `fk_agreement_contract_negotiation_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`subcontract` ADD CONSTRAINT `fk_agreement_subcontract_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`rate_card` ADD CONSTRAINT `fk_agreement_rate_card_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);

-- ========= agreement --> study (11 constraint(s)) =========
-- Requires: agreement schema, study schema
ALTER TABLE `clinical_trials_ecm`.`agreement`.`study_contract` ADD CONSTRAINT `fk_agreement_study_contract_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`scope_of_work` ADD CONSTRAINT `fk_agreement_scope_of_work_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`change_order` ADD CONSTRAINT `fk_agreement_change_order_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`change_order` ADD CONSTRAINT `fk_agreement_change_order_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`contract_amendment` ADD CONSTRAINT `fk_agreement_contract_amendment_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`service_level_agreement` ADD CONSTRAINT `fk_agreement_service_level_agreement_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`agreement_billing_milestone` ADD CONSTRAINT `fk_agreement_agreement_billing_milestone_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`deliverable` ADD CONSTRAINT `fk_agreement_deliverable_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`investigator_grant` ADD CONSTRAINT `fk_agreement_investigator_grant_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`contract_obligation` ADD CONSTRAINT `fk_agreement_contract_obligation_study_milestone_id` FOREIGN KEY (`study_milestone_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_milestone`(`study_milestone_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`subcontract` ADD CONSTRAINT `fk_agreement_subcontract_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);

-- ========= agreement --> workforce (13 constraint(s)) =========
-- Requires: agreement schema, workforce schema
ALTER TABLE `clinical_trials_ecm`.`agreement`.`study_contract` ADD CONSTRAINT `fk_agreement_study_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`scope_of_work` ADD CONSTRAINT `fk_agreement_scope_of_work_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`change_order` ADD CONSTRAINT `fk_agreement_change_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`service_level_agreement` ADD CONSTRAINT `fk_agreement_service_level_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`agreement_billing_milestone` ADD CONSTRAINT `fk_agreement_agreement_billing_milestone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`deliverable` ADD CONSTRAINT `fk_agreement_deliverable_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`investigator_grant` ADD CONSTRAINT `fk_agreement_investigator_grant_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`contract_negotiation` ADD CONSTRAINT `fk_agreement_contract_negotiation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`contract_obligation` ADD CONSTRAINT `fk_agreement_contract_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`preferred_provider_agreement` ADD CONSTRAINT `fk_agreement_preferred_provider_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`subcontract` ADD CONSTRAINT `fk_agreement_subcontract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`rate_card` ADD CONSTRAINT `fk_agreement_rate_card_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`agreement`.`rate_card` ADD CONSTRAINT `fk_agreement_rate_card_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`job_profile`(`job_profile_id`);

-- ========= biostatistics --> agreement (3 constraint(s)) =========
-- Requires: biostatistics schema, agreement schema
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap_amendment` ADD CONSTRAINT `fk_biostatistics_sap_amendment_change_order_id` FOREIGN KEY (`change_order_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`change_order`(`change_order_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`tlf_output` ADD CONSTRAINT `fk_biostatistics_tlf_output_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`deliverable`(`deliverable_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`tlf_output` ADD CONSTRAINT `fk_biostatistics_tlf_output_service_level_agreement_id` FOREIGN KEY (`service_level_agreement_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`service_level_agreement`(`service_level_agreement_id`);

-- ========= biostatistics --> compliance (3 constraint(s)) =========
-- Requires: biostatistics schema, compliance schema
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap_amendment` ADD CONSTRAINT `fk_biostatistics_sap_amendment_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`interim_analysis` ADD CONSTRAINT `fk_biostatistics_interim_analysis_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`dsmb_charter` ADD CONSTRAINT `fk_biostatistics_dsmb_charter_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);

-- ========= biostatistics --> consent (2 constraint(s)) =========
-- Requires: biostatistics schema, consent schema
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap_amendment` ADD CONSTRAINT `fk_biostatistics_sap_amendment_icf_amendment_id` FOREIGN KEY (`icf_amendment_id`) REFERENCES `clinical_trials_ecm`.`consent`.`icf_amendment`(`icf_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`analysis_population` ADD CONSTRAINT `fk_biostatistics_analysis_population_consent_icf_version_id` FOREIGN KEY (`consent_icf_version_id`) REFERENCES `clinical_trials_ecm`.`consent`.`consent_icf_version`(`consent_icf_version_id`);

-- ========= biostatistics --> data (3 constraint(s)) =========
-- Requires: biostatistics schema, data schema
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`adam_dataset_spec` ADD CONSTRAINT `fk_biostatistics_adam_dataset_spec_sdtm_dataset_id` FOREIGN KEY (`sdtm_dataset_id`) REFERENCES `clinical_trials_ecm`.`data`.`sdtm_dataset`(`sdtm_dataset_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`interim_analysis` ADD CONSTRAINT `fk_biostatistics_interim_analysis_sdtm_dataset_id` FOREIGN KEY (`sdtm_dataset_id`) REFERENCES `clinical_trials_ecm`.`data`.`sdtm_dataset`(`sdtm_dataset_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`pk_analysis_spec` ADD CONSTRAINT `fk_biostatistics_pk_analysis_spec_external_transfer_id` FOREIGN KEY (`external_transfer_id`) REFERENCES `clinical_trials_ecm`.`data`.`external_transfer`(`external_transfer_id`);

-- ========= biostatistics --> document (4 constraint(s)) =========
-- Requires: biostatistics schema, document schema
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap` ADD CONSTRAINT `fk_biostatistics_sap_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap_amendment` ADD CONSTRAINT `fk_biostatistics_sap_amendment_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`interim_analysis` ADD CONSTRAINT `fk_biostatistics_interim_analysis_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`pk_analysis_spec` ADD CONSTRAINT `fk_biostatistics_pk_analysis_spec_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);

-- ========= biostatistics --> finance (1 constraint(s)) =========
-- Requires: biostatistics schema, finance schema
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`tlf_output` ADD CONSTRAINT `fk_biostatistics_tlf_output_finance_billing_milestone_id` FOREIGN KEY (`finance_billing_milestone_id`) REFERENCES `clinical_trials_ecm`.`finance`.`finance_billing_milestone`(`finance_billing_milestone_id`);

-- ========= biostatistics --> laboratory (4 constraint(s)) =========
-- Requires: biostatistics schema, laboratory schema
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`adam_dataset_spec` ADD CONSTRAINT `fk_biostatistics_adam_dataset_spec_lab_panel_id` FOREIGN KEY (`lab_panel_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_panel`(`lab_panel_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`adam_variable_spec` ADD CONSTRAINT `fk_biostatistics_adam_variable_spec_lab_analyte_id` FOREIGN KEY (`lab_analyte_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_analyte`(`lab_analyte_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`statistical_endpoint` ADD CONSTRAINT `fk_biostatistics_statistical_endpoint_lab_analyte_id` FOREIGN KEY (`lab_analyte_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_analyte`(`lab_analyte_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`pk_analysis_spec` ADD CONSTRAINT `fk_biostatistics_pk_analysis_spec_bioanalytical_assay_id` FOREIGN KEY (`bioanalytical_assay_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`bioanalytical_assay`(`bioanalytical_assay_id`);

-- ========= biostatistics --> program (3 constraint(s)) =========
-- Requires: biostatistics schema, program schema
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap` ADD CONSTRAINT `fk_biostatistics_sap_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap_amendment` ADD CONSTRAINT `fk_biostatistics_sap_amendment_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `clinical_trials_ecm`.`program`.`amendment`(`amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`dsmb_charter` ADD CONSTRAINT `fk_biostatistics_dsmb_charter_governance_id` FOREIGN KEY (`governance_id`) REFERENCES `clinical_trials_ecm`.`program`.`governance`(`governance_id`);

-- ========= biostatistics --> randomization (13 constraint(s)) =========
-- Requires: biostatistics schema, randomization schema
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap` ADD CONSTRAINT `fk_biostatistics_sap_blinding_config_id` FOREIGN KEY (`blinding_config_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`blinding_config`(`blinding_config_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap` ADD CONSTRAINT `fk_biostatistics_sap_rand_scheme_id` FOREIGN KEY (`rand_scheme_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_scheme`(`rand_scheme_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`analysis_population` ADD CONSTRAINT `fk_biostatistics_analysis_population_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sample_size_calc` ADD CONSTRAINT `fk_biostatistics_sample_size_calc_rand_scheme_id` FOREIGN KEY (`rand_scheme_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_scheme`(`rand_scheme_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`adam_variable_spec` ADD CONSTRAINT `fk_biostatistics_adam_variable_spec_stratification_factor_id` FOREIGN KEY (`stratification_factor_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`stratification_factor`(`stratification_factor_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`tlf_shell` ADD CONSTRAINT `fk_biostatistics_tlf_shell_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`interim_analysis` ADD CONSTRAINT `fk_biostatistics_interim_analysis_blinding_config_id` FOREIGN KEY (`blinding_config_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`blinding_config`(`blinding_config_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`interim_analysis` ADD CONSTRAINT `fk_biostatistics_interim_analysis_rand_list_id` FOREIGN KEY (`rand_list_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_list`(`rand_list_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`database_lock_event` ADD CONSTRAINT `fk_biostatistics_database_lock_event_rand_list_id` FOREIGN KEY (`rand_list_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_list`(`rand_list_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`statistical_endpoint` ADD CONSTRAINT `fk_biostatistics_statistical_endpoint_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`dsmb_charter` ADD CONSTRAINT `fk_biostatistics_dsmb_charter_blinding_config_id` FOREIGN KEY (`blinding_config_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`blinding_config`(`blinding_config_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`dsmb_charter` ADD CONSTRAINT `fk_biostatistics_dsmb_charter_rand_scheme_id` FOREIGN KEY (`rand_scheme_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_scheme`(`rand_scheme_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`dsmb_meeting` ADD CONSTRAINT `fk_biostatistics_dsmb_meeting_blinding_config_id` FOREIGN KEY (`blinding_config_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`blinding_config`(`blinding_config_id`);

-- ========= biostatistics --> regulatory (10 constraint(s)) =========
-- Requires: biostatistics schema, regulatory schema
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap` ADD CONSTRAINT `fk_biostatistics_sap_application_id` FOREIGN KEY (`application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`application`(`application_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap` ADD CONSTRAINT `fk_biostatistics_sap_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`strategy`(`strategy_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap` ADD CONSTRAINT `fk_biostatistics_sap_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap_amendment` ADD CONSTRAINT `fk_biostatistics_sap_amendment_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap_amendment` ADD CONSTRAINT `fk_biostatistics_sap_amendment_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`tlf_output` ADD CONSTRAINT `fk_biostatistics_tlf_output_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`interim_analysis` ADD CONSTRAINT `fk_biostatistics_interim_analysis_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`interim_analysis` ADD CONSTRAINT `fk_biostatistics_interim_analysis_safety_report_submission_id` FOREIGN KEY (`safety_report_submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`safety_report_submission`(`safety_report_submission_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`interim_analysis` ADD CONSTRAINT `fk_biostatistics_interim_analysis_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`dsmb_charter` ADD CONSTRAINT `fk_biostatistics_dsmb_charter_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);

-- ========= biostatistics --> sponsor (11 constraint(s)) =========
-- Requires: biostatistics schema, sponsor schema
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap` ADD CONSTRAINT `fk_biostatistics_sap_delivery_preference_id` FOREIGN KEY (`delivery_preference_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`delivery_preference`(`delivery_preference_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap` ADD CONSTRAINT `fk_biostatistics_sap_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap` ADD CONSTRAINT `fk_biostatistics_sap_pipeline_asset_id` FOREIGN KEY (`pipeline_asset_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`pipeline_asset`(`pipeline_asset_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap` ADD CONSTRAINT `fk_biostatistics_sap_regulatory_strategy_id` FOREIGN KEY (`regulatory_strategy_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`regulatory_strategy`(`regulatory_strategy_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sample_size_calc` ADD CONSTRAINT `fk_biostatistics_sample_size_calc_pipeline_asset_id` FOREIGN KEY (`pipeline_asset_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`pipeline_asset`(`pipeline_asset_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`adam_dataset_spec` ADD CONSTRAINT `fk_biostatistics_adam_dataset_spec_delivery_preference_id` FOREIGN KEY (`delivery_preference_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`delivery_preference`(`delivery_preference_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`tlf_output` ADD CONSTRAINT `fk_biostatistics_tlf_output_delivery_preference_id` FOREIGN KEY (`delivery_preference_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`delivery_preference`(`delivery_preference_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`interim_analysis` ADD CONSTRAINT `fk_biostatistics_interim_analysis_pipeline_asset_id` FOREIGN KEY (`pipeline_asset_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`pipeline_asset`(`pipeline_asset_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`statistical_endpoint` ADD CONSTRAINT `fk_biostatistics_statistical_endpoint_regulatory_strategy_id` FOREIGN KEY (`regulatory_strategy_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`regulatory_strategy`(`regulatory_strategy_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`pk_analysis_spec` ADD CONSTRAINT `fk_biostatistics_pk_analysis_spec_pipeline_asset_id` FOREIGN KEY (`pipeline_asset_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`pipeline_asset`(`pipeline_asset_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`estimand` ADD CONSTRAINT `fk_biostatistics_estimand_regulatory_strategy_id` FOREIGN KEY (`regulatory_strategy_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`regulatory_strategy`(`regulatory_strategy_id`);

-- ========= biostatistics --> study (29 constraint(s)) =========
-- Requires: biostatistics schema, study schema
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap` ADD CONSTRAINT `fk_biostatistics_sap_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap_amendment` ADD CONSTRAINT `fk_biostatistics_sap_amendment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap_amendment` ADD CONSTRAINT `fk_biostatistics_sap_amendment_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`analysis_population` ADD CONSTRAINT `fk_biostatistics_analysis_population_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sample_size_calc` ADD CONSTRAINT `fk_biostatistics_sample_size_calc_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sample_size_calc` ADD CONSTRAINT `fk_biostatistics_sample_size_calc_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`adam_dataset_spec` ADD CONSTRAINT `fk_biostatistics_adam_dataset_spec_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`adam_variable_spec` ADD CONSTRAINT `fk_biostatistics_adam_variable_spec_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`tlf_shell` ADD CONSTRAINT `fk_biostatistics_tlf_shell_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`tlf_shell` ADD CONSTRAINT `fk_biostatistics_tlf_shell_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `clinical_trials_ecm`.`study`.`endpoint`(`endpoint_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`tlf_shell` ADD CONSTRAINT `fk_biostatistics_tlf_shell_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`tlf_output` ADD CONSTRAINT `fk_biostatistics_tlf_output_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`interim_analysis` ADD CONSTRAINT `fk_biostatistics_interim_analysis_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`interim_analysis` ADD CONSTRAINT `fk_biostatistics_interim_analysis_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`interim_analysis` ADD CONSTRAINT `fk_biostatistics_interim_analysis_study_milestone_id` FOREIGN KEY (`study_milestone_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_milestone`(`study_milestone_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`database_lock_event` ADD CONSTRAINT `fk_biostatistics_database_lock_event_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`database_lock_event` ADD CONSTRAINT `fk_biostatistics_database_lock_event_study_milestone_id` FOREIGN KEY (`study_milestone_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_milestone`(`study_milestone_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`statistical_endpoint` ADD CONSTRAINT `fk_biostatistics_statistical_endpoint_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `clinical_trials_ecm`.`study`.`endpoint`(`endpoint_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`statistical_endpoint` ADD CONSTRAINT `fk_biostatistics_statistical_endpoint_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`pk_analysis_spec` ADD CONSTRAINT `fk_biostatistics_pk_analysis_spec_dosing_regimen_id` FOREIGN KEY (`dosing_regimen_id`) REFERENCES `clinical_trials_ecm`.`study`.`dosing_regimen`(`dosing_regimen_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`pk_analysis_spec` ADD CONSTRAINT `fk_biostatistics_pk_analysis_spec_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `clinical_trials_ecm`.`study`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`pk_analysis_spec` ADD CONSTRAINT `fk_biostatistics_pk_analysis_spec_pk_sampling_schedule_id` FOREIGN KEY (`pk_sampling_schedule_id`) REFERENCES `clinical_trials_ecm`.`study`.`pk_sampling_schedule`(`pk_sampling_schedule_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`pk_analysis_spec` ADD CONSTRAINT `fk_biostatistics_pk_analysis_spec_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`estimand` ADD CONSTRAINT `fk_biostatistics_estimand_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `clinical_trials_ecm`.`study`.`endpoint`(`endpoint_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`estimand` ADD CONSTRAINT `fk_biostatistics_estimand_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`dsmb_charter` ADD CONSTRAINT `fk_biostatistics_dsmb_charter_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`dsmb_charter` ADD CONSTRAINT `fk_biostatistics_dsmb_charter_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`dsmb_charter` ADD CONSTRAINT `fk_biostatistics_dsmb_charter_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`dsmb_meeting` ADD CONSTRAINT `fk_biostatistics_dsmb_meeting_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);

-- ========= biostatistics --> workforce (16 constraint(s)) =========
-- Requires: biostatistics schema, workforce schema
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap` ADD CONSTRAINT `fk_biostatistics_sap_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap_amendment` ADD CONSTRAINT `fk_biostatistics_sap_amendment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap_amendment` ADD CONSTRAINT `fk_biostatistics_sap_amendment_primary_sap_employee_id` FOREIGN KEY (`primary_sap_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sap_amendment` ADD CONSTRAINT `fk_biostatistics_sap_amendment_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`sample_size_calc` ADD CONSTRAINT `fk_biostatistics_sample_size_calc_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`adam_dataset_spec` ADD CONSTRAINT `fk_biostatistics_adam_dataset_spec_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`adam_variable_spec` ADD CONSTRAINT `fk_biostatistics_adam_variable_spec_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`tlf_shell` ADD CONSTRAINT `fk_biostatistics_tlf_shell_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`tlf_output` ADD CONSTRAINT `fk_biostatistics_tlf_output_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`tlf_output` ADD CONSTRAINT `fk_biostatistics_tlf_output_primary_tlf_employee_id` FOREIGN KEY (`primary_tlf_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`database_lock_event` ADD CONSTRAINT `fk_biostatistics_database_lock_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`database_lock_event` ADD CONSTRAINT `fk_biostatistics_database_lock_event_quaternary_database_unblinding_authorized_by_employee_id` FOREIGN KEY (`quaternary_database_unblinding_authorized_by_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`database_lock_event` ADD CONSTRAINT `fk_biostatistics_database_lock_event_tertiary_database_medical_monitor_approver_employee_id` FOREIGN KEY (`tertiary_database_medical_monitor_approver_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`pk_analysis_spec` ADD CONSTRAINT `fk_biostatistics_pk_analysis_spec_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`estimand` ADD CONSTRAINT `fk_biostatistics_estimand_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`biostatistics`.`dsmb_charter` ADD CONSTRAINT `fk_biostatistics_dsmb_charter_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= compliance --> biostatistics (5 constraint(s)) =========
-- Requires: compliance schema, biostatistics schema
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_analysis_population_id` FOREIGN KEY (`analysis_population_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`analysis_population`(`analysis_population_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_database_lock_event_id` FOREIGN KEY (`database_lock_event_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`database_lock_event`(`database_lock_event_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_estimand_id` FOREIGN KEY (`estimand_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`estimand`(`estimand_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`quality_event` ADD CONSTRAINT `fk_compliance_quality_event_database_lock_event_id` FOREIGN KEY (`database_lock_event_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`database_lock_event`(`database_lock_event_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`regulatory_commitment` ADD CONSTRAINT `fk_compliance_regulatory_commitment_interim_analysis_id` FOREIGN KEY (`interim_analysis_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`interim_analysis`(`interim_analysis_id`);

-- ========= compliance --> consent (6 constraint(s)) =========
-- Requires: compliance schema, consent schema
ALTER TABLE `clinical_trials_ecm`.`compliance`.`quality_event` ADD CONSTRAINT `fk_compliance_quality_event_subject_consent_id` FOREIGN KEY (`subject_consent_id`) REFERENCES `clinical_trials_ecm`.`consent`.`subject_consent`(`subject_consent_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`ethics_submission` ADD CONSTRAINT `fk_compliance_ethics_submission_consent_icf_version_id` FOREIGN KEY (`consent_icf_version_id`) REFERENCES `clinical_trials_ecm`.`consent`.`consent_icf_version`(`consent_icf_version_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`ethics_correspondence` ADD CONSTRAINT `fk_compliance_ethics_correspondence_consent_icf_version_id` FOREIGN KEY (`consent_icf_version_id`) REFERENCES `clinical_trials_ecm`.`consent`.`consent_icf_version`(`consent_icf_version_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`vulnerable_population` ADD CONSTRAINT `fk_compliance_vulnerable_population_capacity_assessment_id` FOREIGN KEY (`capacity_assessment_id`) REFERENCES `clinical_trials_ecm`.`consent`.`capacity_assessment`(`capacity_assessment_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`vulnerable_population` ADD CONSTRAINT `fk_compliance_vulnerable_population_consent_icf_version_id` FOREIGN KEY (`consent_icf_version_id`) REFERENCES `clinical_trials_ecm`.`consent`.`consent_icf_version`(`consent_icf_version_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`vulnerable_population` ADD CONSTRAINT `fk_compliance_vulnerable_population_lar_representative_id` FOREIGN KEY (`lar_representative_id`) REFERENCES `clinical_trials_ecm`.`consent`.`lar_representative`(`lar_representative_id`);

-- ========= compliance --> document (7 constraint(s)) =========
-- Requires: compliance schema, document schema
ALTER TABLE `clinical_trials_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_template_id` FOREIGN KEY (`template_id`) REFERENCES `clinical_trials_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`sop_training_record` ADD CONSTRAINT `fk_compliance_sop_training_record_signature_id` FOREIGN KEY (`signature_id`) REFERENCES `clinical_trials_ecm`.`document`.`signature`(`signature_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`ethics_approval` ADD CONSTRAINT `fk_compliance_ethics_approval_document_icf_version_id` FOREIGN KEY (`document_icf_version_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_icf_version`(`document_icf_version_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`continuing_review` ADD CONSTRAINT `fk_compliance_continuing_review_document_icf_version_id` FOREIGN KEY (`document_icf_version_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_icf_version`(`document_icf_version_id`);

-- ========= compliance --> laboratory (10 constraint(s)) =========
-- Requires: compliance schema, laboratory schema
ALTER TABLE `clinical_trials_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_lab_facility_id` FOREIGN KEY (`lab_facility_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_facility`(`lab_facility_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_bioanalytical_assay_id` FOREIGN KEY (`bioanalytical_assay_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`bioanalytical_assay`(`bioanalytical_assay_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_lab_result_id` FOREIGN KEY (`lab_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_result`(`lab_result_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_lab_result_id` FOREIGN KEY (`lab_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_result`(`lab_result_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_protocol_lab_schedule_id` FOREIGN KEY (`protocol_lab_schedule_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`protocol_lab_schedule`(`protocol_lab_schedule_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_specimen_collection_id` FOREIGN KEY (`specimen_collection_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`specimen_collection`(`specimen_collection_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`quality_event` ADD CONSTRAINT `fk_compliance_quality_event_lab_result_id` FOREIGN KEY (`lab_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_result`(`lab_result_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`quality_event` ADD CONSTRAINT `fk_compliance_quality_event_specimen_collection_id` FOREIGN KEY (`specimen_collection_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`specimen_collection`(`specimen_collection_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`quality_event` ADD CONSTRAINT `fk_compliance_quality_event_specimen_shipment_id` FOREIGN KEY (`specimen_shipment_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`specimen_shipment`(`specimen_shipment_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_lab_facility_id` FOREIGN KEY (`lab_facility_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_facility`(`lab_facility_id`);

-- ========= compliance --> program (7 constraint(s)) =========
-- Requires: compliance schema, program schema
ALTER TABLE `clinical_trials_ecm`.`compliance`.`deviation_classification` ADD CONSTRAINT `fk_compliance_deviation_classification_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `clinical_trials_ecm`.`program`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`compliance_sop` ADD CONSTRAINT `fk_compliance_compliance_sop_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `clinical_trials_ecm`.`program`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_risk_id` FOREIGN KEY (`risk_id`) REFERENCES `clinical_trials_ecm`.`program`.`risk`(`risk_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `clinical_trials_ecm`.`program`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`ethics_committee` ADD CONSTRAINT `fk_compliance_ethics_committee_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`irb_reliance` ADD CONSTRAINT `fk_compliance_irb_reliance_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);

-- ========= compliance --> safety (3 constraint(s)) =========
-- Requires: compliance schema, safety schema
ALTER TABLE `clinical_trials_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_signal_id` FOREIGN KEY (`signal_id`) REFERENCES `clinical_trials_ecm`.`safety`.`signal`(`signal_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`regulatory_commitment` ADD CONSTRAINT `fk_compliance_regulatory_commitment_dsmb_review_id` FOREIGN KEY (`dsmb_review_id`) REFERENCES `clinical_trials_ecm`.`safety`.`dsmb_review`(`dsmb_review_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`ethics_submission` ADD CONSTRAINT `fk_compliance_ethics_submission_investigator_brochure_safety_id` FOREIGN KEY (`investigator_brochure_safety_id`) REFERENCES `clinical_trials_ecm`.`safety`.`investigator_brochure_safety`(`investigator_brochure_safety_id`);

-- ========= compliance --> site (14 constraint(s)) =========
-- Requires: compliance schema, site schema
ALTER TABLE `clinical_trials_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`compliance_capa` ADD CONSTRAINT `fk_compliance_compliance_capa_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`sop_training_record` ADD CONSTRAINT `fk_compliance_sop_training_record_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`quality_event` ADD CONSTRAINT `fk_compliance_quality_event_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`ethics_submission` ADD CONSTRAINT `fk_compliance_ethics_submission_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `clinical_trials_ecm`.`site`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`ethics_submission` ADD CONSTRAINT `fk_compliance_ethics_submission_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`ethics_approval` ADD CONSTRAINT `fk_compliance_ethics_approval_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`continuing_review` ADD CONSTRAINT `fk_compliance_continuing_review_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `clinical_trials_ecm`.`site`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`continuing_review` ADD CONSTRAINT `fk_compliance_continuing_review_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`ethics_correspondence` ADD CONSTRAINT `fk_compliance_ethics_correspondence_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`vulnerable_population` ADD CONSTRAINT `fk_compliance_vulnerable_population_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`irb_reliance` ADD CONSTRAINT `fk_compliance_irb_reliance_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);

-- ========= compliance --> sponsor (19 constraint(s)) =========
-- Requires: compliance schema, sponsor schema
ALTER TABLE `clinical_trials_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_master_agreement_id` FOREIGN KEY (`master_agreement_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`master_agreement`(`master_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_sponsor_engagement_id` FOREIGN KEY (`sponsor_engagement_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`sponsor_engagement`(`sponsor_engagement_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_vendor_organization_id` FOREIGN KEY (`vendor_organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`compliance_inspection` ADD CONSTRAINT `fk_compliance_compliance_inspection_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`compliance_inspection` ADD CONSTRAINT `fk_compliance_compliance_inspection_sponsor_engagement_id` FOREIGN KEY (`sponsor_engagement_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`sponsor_engagement`(`sponsor_engagement_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`compliance_capa` ADD CONSTRAINT `fk_compliance_compliance_capa_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`compliance_capa` ADD CONSTRAINT `fk_compliance_compliance_capa_sponsor_engagement_id` FOREIGN KEY (`sponsor_engagement_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`sponsor_engagement`(`sponsor_engagement_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`quality_event` ADD CONSTRAINT `fk_compliance_quality_event_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`quality_event` ADD CONSTRAINT `fk_compliance_quality_event_sponsor_engagement_id` FOREIGN KEY (`sponsor_engagement_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`sponsor_engagement`(`sponsor_engagement_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_sponsor_engagement_id` FOREIGN KEY (`sponsor_engagement_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`sponsor_engagement`(`sponsor_engagement_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`regulatory_commitment` ADD CONSTRAINT `fk_compliance_regulatory_commitment_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`regulatory_commitment` ADD CONSTRAINT `fk_compliance_regulatory_commitment_sponsor_engagement_id` FOREIGN KEY (`sponsor_engagement_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`sponsor_engagement`(`sponsor_engagement_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`ethics_submission` ADD CONSTRAINT `fk_compliance_ethics_submission_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`ethics_submission` ADD CONSTRAINT `fk_compliance_ethics_submission_sponsor_engagement_id` FOREIGN KEY (`sponsor_engagement_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`sponsor_engagement`(`sponsor_engagement_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`ethics_approval` ADD CONSTRAINT `fk_compliance_ethics_approval_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`irb_reliance` ADD CONSTRAINT `fk_compliance_irb_reliance_master_agreement_id` FOREIGN KEY (`master_agreement_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`master_agreement`(`master_agreement_id`);

-- ========= compliance --> study (27 constraint(s)) =========
-- Requires: compliance schema, study schema
ALTER TABLE `clinical_trials_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`compliance_inspection` ADD CONSTRAINT `fk_compliance_compliance_inspection_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`compliance_capa` ADD CONSTRAINT `fk_compliance_compliance_capa_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`sop_training_record` ADD CONSTRAINT `fk_compliance_sop_training_record_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`sop_training_requirement` ADD CONSTRAINT `fk_compliance_sop_training_requirement_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`quality_event` ADD CONSTRAINT `fk_compliance_quality_event_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`ethics_submission` ADD CONSTRAINT `fk_compliance_ethics_submission_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`ethics_submission` ADD CONSTRAINT `fk_compliance_ethics_submission_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`ethics_approval` ADD CONSTRAINT `fk_compliance_ethics_approval_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`ethics_approval` ADD CONSTRAINT `fk_compliance_ethics_approval_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`ethics_approval` ADD CONSTRAINT `fk_compliance_ethics_approval_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`continuing_review` ADD CONSTRAINT `fk_compliance_continuing_review_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`continuing_review` ADD CONSTRAINT `fk_compliance_continuing_review_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`ethics_correspondence` ADD CONSTRAINT `fk_compliance_ethics_correspondence_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`ethics_correspondence` ADD CONSTRAINT `fk_compliance_ethics_correspondence_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`ethics_correspondence` ADD CONSTRAINT `fk_compliance_ethics_correspondence_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`vulnerable_population` ADD CONSTRAINT `fk_compliance_vulnerable_population_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`vulnerable_population` ADD CONSTRAINT `fk_compliance_vulnerable_population_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`irb_reliance` ADD CONSTRAINT `fk_compliance_irb_reliance_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`irb_reliance` ADD CONSTRAINT `fk_compliance_irb_reliance_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`irb_reliance` ADD CONSTRAINT `fk_compliance_irb_reliance_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`training_plan` ADD CONSTRAINT `fk_compliance_training_plan_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);

-- ========= compliance --> subject (3 constraint(s)) =========
-- Requires: compliance schema, subject schema
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`vulnerable_population` ADD CONSTRAINT `fk_compliance_vulnerable_population_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);

-- ========= compliance --> supply (4 constraint(s)) =========
-- Requires: compliance schema, supply schema
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `clinical_trials_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`quality_event` ADD CONSTRAINT `fk_compliance_quality_event_manufacture_batch_id` FOREIGN KEY (`manufacture_batch_id`) REFERENCES `clinical_trials_ecm`.`supply`.`manufacture_batch`(`manufacture_batch_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `clinical_trials_ecm`.`supply`.`depot`(`depot_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_imp_master_id` FOREIGN KEY (`imp_master_id`) REFERENCES `clinical_trials_ecm`.`supply`.`imp_master`(`imp_master_id`);

-- ========= compliance --> workforce (31 constraint(s)) =========
-- Requires: compliance schema, workforce schema
ALTER TABLE `clinical_trials_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`compliance_inspection` ADD CONSTRAINT `fk_compliance_compliance_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`compliance_capa` ADD CONSTRAINT `fk_compliance_compliance_capa_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`compliance_capa` ADD CONSTRAINT `fk_compliance_compliance_capa_quaternary_compliance_responsible_owner_employee_id` FOREIGN KEY (`quaternary_compliance_responsible_owner_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`compliance_capa` ADD CONSTRAINT `fk_compliance_compliance_capa_tertiary_compliance_approved_by_employee_id` FOREIGN KEY (`tertiary_compliance_approved_by_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`compliance_capa` ADD CONSTRAINT `fk_compliance_compliance_capa_training_curriculum_id` FOREIGN KEY (`training_curriculum_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`training_curriculum`(`training_curriculum_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`capa_action_item` ADD CONSTRAINT `fk_compliance_capa_action_item_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`capa_action_item` ADD CONSTRAINT `fk_compliance_capa_action_item_quaternary_capa_assigned_owner_employee_id` FOREIGN KEY (`quaternary_capa_assigned_owner_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`capa_action_item` ADD CONSTRAINT `fk_compliance_capa_action_item_tertiary_capa_escalated_to_employee_id` FOREIGN KEY (`tertiary_capa_escalated_to_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`capa_action_item` ADD CONSTRAINT `fk_compliance_capa_action_item_training_curriculum_id` FOREIGN KEY (`training_curriculum_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`training_curriculum`(`training_curriculum_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`protocol_deviation` ADD CONSTRAINT `fk_compliance_protocol_deviation_training_curriculum_id` FOREIGN KEY (`training_curriculum_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`training_curriculum`(`training_curriculum_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`deviation_classification` ADD CONSTRAINT `fk_compliance_deviation_classification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`compliance_sop` ADD CONSTRAINT `fk_compliance_compliance_sop_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`compliance_sop` ADD CONSTRAINT `fk_compliance_compliance_sop_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`sop_training_record` ADD CONSTRAINT `fk_compliance_sop_training_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`sop_training_record` ADD CONSTRAINT `fk_compliance_sop_training_record_training_curriculum_id` FOREIGN KEY (`training_curriculum_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`training_curriculum`(`training_curriculum_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`sop_training_requirement` ADD CONSTRAINT `fk_compliance_sop_training_requirement_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`sop_training_requirement` ADD CONSTRAINT `fk_compliance_sop_training_requirement_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`quality_event` ADD CONSTRAINT `fk_compliance_quality_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_quaternary_risk_approved_by_employee_id` FOREIGN KEY (`quaternary_risk_approved_by_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`risk_assessment` ADD CONSTRAINT `fk_compliance_risk_assessment_tertiary_risk_assessed_by_employee_id` FOREIGN KEY (`tertiary_risk_assessed_by_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`regulatory_commitment` ADD CONSTRAINT `fk_compliance_regulatory_commitment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`regulatory_commitment` ADD CONSTRAINT `fk_compliance_regulatory_commitment_quaternary_regulatory_responsible_owner_employee_id` FOREIGN KEY (`quaternary_regulatory_responsible_owner_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`regulatory_commitment` ADD CONSTRAINT `fk_compliance_regulatory_commitment_tertiary_regulatory_approved_by_employee_id` FOREIGN KEY (`tertiary_regulatory_approved_by_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_obligation_employee_id` FOREIGN KEY (`obligation_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `clinical_trials_ecm`.`compliance`.`training_plan` ADD CONSTRAINT `fk_compliance_training_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`org_unit`(`org_unit_id`);

-- ========= consent --> agreement (2 constraint(s)) =========
-- Requires: consent schema, agreement schema
ALTER TABLE `clinical_trials_ecm`.`consent`.`reconsent_trigger` ADD CONSTRAINT `fk_consent_reconsent_trigger_change_order_id` FOREIGN KEY (`change_order_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`change_order`(`change_order_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`translation` ADD CONSTRAINT `fk_consent_translation_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`subcontract`(`subcontract_id`);

-- ========= consent --> compliance (11 constraint(s)) =========
-- Requires: consent schema, compliance schema
ALTER TABLE `clinical_trials_ecm`.`consent`.`subject_consent` ADD CONSTRAINT `fk_consent_subject_consent_ethics_approval_id` FOREIGN KEY (`ethics_approval_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_approval`(`ethics_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`reconsent_trigger` ADD CONSTRAINT `fk_consent_reconsent_trigger_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`withdrawal` ADD CONSTRAINT `fk_consent_withdrawal_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`assent_record` ADD CONSTRAINT `fk_consent_assent_record_ethics_approval_id` FOREIGN KEY (`ethics_approval_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_approval`(`ethics_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`waiver` ADD CONSTRAINT `fk_consent_waiver_ethics_approval_id` FOREIGN KEY (`ethics_approval_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_approval`(`ethics_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`waiver` ADD CONSTRAINT `fk_consent_waiver_ethics_committee_id` FOREIGN KEY (`ethics_committee_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_committee`(`ethics_committee_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`waiver` ADD CONSTRAINT `fk_consent_waiver_ethics_submission_id` FOREIGN KEY (`ethics_submission_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_submission`(`ethics_submission_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`gdpr_data_consent` ADD CONSTRAINT `fk_consent_gdpr_data_consent_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`translation` ADD CONSTRAINT `fk_consent_translation_ethics_approval_id` FOREIGN KEY (`ethics_approval_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_approval`(`ethics_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`consent_deviation` ADD CONSTRAINT `fk_consent_consent_deviation_compliance_capa_id` FOREIGN KEY (`compliance_capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_capa`(`compliance_capa_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`consent_deviation` ADD CONSTRAINT `fk_consent_consent_deviation_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);

-- ========= consent --> document (10 constraint(s)) =========
-- Requires: consent schema, document schema
ALTER TABLE `clinical_trials_ecm`.`consent`.`consent_icf_version` ADD CONSTRAINT `fk_consent_consent_icf_version_template_id` FOREIGN KEY (`template_id`) REFERENCES `clinical_trials_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`subject_consent` ADD CONSTRAINT `fk_consent_subject_consent_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`capacity_assessment` ADD CONSTRAINT `fk_consent_capacity_assessment_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`lar_representative` ADD CONSTRAINT `fk_consent_lar_representative_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`icf_amendment` ADD CONSTRAINT `fk_consent_icf_amendment_workflow_id` FOREIGN KEY (`workflow_id`) REFERENCES `clinical_trials_ecm`.`document`.`workflow`(`workflow_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`consent_delegation_log` ADD CONSTRAINT `fk_consent_consent_delegation_log_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`assent_record` ADD CONSTRAINT `fk_consent_assent_record_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`waiver` ADD CONSTRAINT `fk_consent_waiver_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`translation` ADD CONSTRAINT `fk_consent_translation_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`consent_deviation` ADD CONSTRAINT `fk_consent_consent_deviation_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);

-- ========= consent --> randomization (3 constraint(s)) =========
-- Requires: consent schema, randomization schema
ALTER TABLE `clinical_trials_ecm`.`consent`.`reconsent_trigger` ADD CONSTRAINT `fk_consent_reconsent_trigger_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`withdrawal` ADD CONSTRAINT `fk_consent_withdrawal_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`consent_deviation` ADD CONSTRAINT `fk_consent_consent_deviation_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);

-- ========= consent --> regulatory (2 constraint(s)) =========
-- Requires: consent schema, regulatory schema
ALTER TABLE `clinical_trials_ecm`.`consent`.`icf_amendment` ADD CONSTRAINT `fk_consent_icf_amendment_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`waiver` ADD CONSTRAINT `fk_consent_waiver_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);

-- ========= consent --> safety (5 constraint(s)) =========
-- Requires: consent schema, safety schema
ALTER TABLE `clinical_trials_ecm`.`consent`.`reconsent_trigger` ADD CONSTRAINT `fk_consent_reconsent_trigger_dsmb_recommendation_id` FOREIGN KEY (`dsmb_recommendation_id`) REFERENCES `clinical_trials_ecm`.`safety`.`dsmb_recommendation`(`dsmb_recommendation_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`reconsent_trigger` ADD CONSTRAINT `fk_consent_reconsent_trigger_safety_communication_id` FOREIGN KEY (`safety_communication_id`) REFERENCES `clinical_trials_ecm`.`safety`.`safety_communication`(`safety_communication_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`reconsent_trigger` ADD CONSTRAINT `fk_consent_reconsent_trigger_safety_letter_safety_communication_id` FOREIGN KEY (`safety_letter_safety_communication_id`) REFERENCES `clinical_trials_ecm`.`safety`.`safety_communication`(`safety_communication_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`icf_amendment` ADD CONSTRAINT `fk_consent_icf_amendment_investigator_brochure_safety_id` FOREIGN KEY (`investigator_brochure_safety_id`) REFERENCES `clinical_trials_ecm`.`safety`.`investigator_brochure_safety`(`investigator_brochure_safety_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`icf_amendment` ADD CONSTRAINT `fk_consent_icf_amendment_safety_communication_id` FOREIGN KEY (`safety_communication_id`) REFERENCES `clinical_trials_ecm`.`safety`.`safety_communication`(`safety_communication_id`);

-- ========= consent --> site (20 constraint(s)) =========
-- Requires: consent schema, site schema
ALTER TABLE `clinical_trials_ecm`.`consent`.`consent_icf_version` ADD CONSTRAINT `fk_consent_consent_icf_version_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`subject_consent` ADD CONSTRAINT `fk_consent_subject_consent_irb_iec_approval_id` FOREIGN KEY (`irb_iec_approval_id`) REFERENCES `clinical_trials_ecm`.`site`.`irb_iec_approval`(`irb_iec_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`subject_consent` ADD CONSTRAINT `fk_consent_subject_consent_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`econsent_session` ADD CONSTRAINT `fk_consent_econsent_session_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`reconsent_trigger` ADD CONSTRAINT `fk_consent_reconsent_trigger_irb_iec_approval_id` FOREIGN KEY (`irb_iec_approval_id`) REFERENCES `clinical_trials_ecm`.`site`.`irb_iec_approval`(`irb_iec_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`reconsent_trigger` ADD CONSTRAINT `fk_consent_reconsent_trigger_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`capacity_assessment` ADD CONSTRAINT `fk_consent_capacity_assessment_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`withdrawal` ADD CONSTRAINT `fk_consent_withdrawal_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`audit_entry` ADD CONSTRAINT `fk_consent_audit_entry_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`lar_representative` ADD CONSTRAINT `fk_consent_lar_representative_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`icf_amendment` ADD CONSTRAINT `fk_consent_icf_amendment_irb_iec_approval_id` FOREIGN KEY (`irb_iec_approval_id`) REFERENCES `clinical_trials_ecm`.`site`.`irb_iec_approval`(`irb_iec_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`consent_delegation_log` ADD CONSTRAINT `fk_consent_consent_delegation_log_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`assent_record` ADD CONSTRAINT `fk_consent_assent_record_irb_iec_approval_id` FOREIGN KEY (`irb_iec_approval_id`) REFERENCES `clinical_trials_ecm`.`site`.`irb_iec_approval`(`irb_iec_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`assent_record` ADD CONSTRAINT `fk_consent_assent_record_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`waiver` ADD CONSTRAINT `fk_consent_waiver_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`waiver` ADD CONSTRAINT `fk_consent_waiver_irb_iec_approval_id` FOREIGN KEY (`irb_iec_approval_id`) REFERENCES `clinical_trials_ecm`.`site`.`irb_iec_approval`(`irb_iec_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`gdpr_data_consent` ADD CONSTRAINT `fk_consent_gdpr_data_consent_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`translation` ADD CONSTRAINT `fk_consent_translation_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`translation` ADD CONSTRAINT `fk_consent_translation_irb_iec_approval_id` FOREIGN KEY (`irb_iec_approval_id`) REFERENCES `clinical_trials_ecm`.`site`.`irb_iec_approval`(`irb_iec_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`consent_deviation` ADD CONSTRAINT `fk_consent_consent_deviation_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);

-- ========= consent --> sponsor (5 constraint(s)) =========
-- Requires: consent schema, sponsor schema
ALTER TABLE `clinical_trials_ecm`.`consent`.`consent_icf_version` ADD CONSTRAINT `fk_consent_consent_icf_version_delivery_preference_id` FOREIGN KEY (`delivery_preference_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`delivery_preference`(`delivery_preference_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`consent_icf_version` ADD CONSTRAINT `fk_consent_consent_icf_version_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`consent_icf_version` ADD CONSTRAINT `fk_consent_consent_icf_version_regulatory_strategy_id` FOREIGN KEY (`regulatory_strategy_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`regulatory_strategy`(`regulatory_strategy_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`waiver` ADD CONSTRAINT `fk_consent_waiver_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`gdpr_data_consent` ADD CONSTRAINT `fk_consent_gdpr_data_consent_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);

-- ========= consent --> study (19 constraint(s)) =========
-- Requires: consent schema, study schema
ALTER TABLE `clinical_trials_ecm`.`consent`.`consent_icf_version` ADD CONSTRAINT `fk_consent_consent_icf_version_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`consent_icf_version` ADD CONSTRAINT `fk_consent_consent_icf_version_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`consent_icf_version` ADD CONSTRAINT `fk_consent_consent_icf_version_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`subject_consent` ADD CONSTRAINT `fk_consent_subject_consent_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`econsent_session` ADD CONSTRAINT `fk_consent_econsent_session_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`reconsent_trigger` ADD CONSTRAINT `fk_consent_reconsent_trigger_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`reconsent_trigger` ADD CONSTRAINT `fk_consent_reconsent_trigger_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`capacity_assessment` ADD CONSTRAINT `fk_consent_capacity_assessment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`audit_entry` ADD CONSTRAINT `fk_consent_audit_entry_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`lar_representative` ADD CONSTRAINT `fk_consent_lar_representative_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`consent_delegation_log` ADD CONSTRAINT `fk_consent_consent_delegation_log_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`assent_record` ADD CONSTRAINT `fk_consent_assent_record_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`waiver` ADD CONSTRAINT `fk_consent_waiver_country_id` FOREIGN KEY (`country_id`) REFERENCES `clinical_trials_ecm`.`study`.`country`(`country_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`waiver` ADD CONSTRAINT `fk_consent_waiver_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`waiver` ADD CONSTRAINT `fk_consent_waiver_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`gdpr_data_consent` ADD CONSTRAINT `fk_consent_gdpr_data_consent_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`translation` ADD CONSTRAINT `fk_consent_translation_country_id` FOREIGN KEY (`country_id`) REFERENCES `clinical_trials_ecm`.`study`.`country`(`country_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`translation` ADD CONSTRAINT `fk_consent_translation_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`consent_deviation` ADD CONSTRAINT `fk_consent_consent_deviation_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);

-- ========= consent --> subject (10 constraint(s)) =========
-- Requires: consent schema, subject schema
ALTER TABLE `clinical_trials_ecm`.`consent`.`subject_consent` ADD CONSTRAINT `fk_consent_subject_consent_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`econsent_session` ADD CONSTRAINT `fk_consent_econsent_session_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`reconsent_trigger` ADD CONSTRAINT `fk_consent_reconsent_trigger_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`capacity_assessment` ADD CONSTRAINT `fk_consent_capacity_assessment_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`withdrawal` ADD CONSTRAINT `fk_consent_withdrawal_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`audit_entry` ADD CONSTRAINT `fk_consent_audit_entry_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`lar_representative` ADD CONSTRAINT `fk_consent_lar_representative_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`assent_record` ADD CONSTRAINT `fk_consent_assent_record_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`gdpr_data_consent` ADD CONSTRAINT `fk_consent_gdpr_data_consent_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`consent_deviation` ADD CONSTRAINT `fk_consent_consent_deviation_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);

-- ========= consent --> supply (1 constraint(s)) =========
-- Requires: consent schema, supply schema
ALTER TABLE `clinical_trials_ecm`.`consent`.`consent_deviation` ADD CONSTRAINT `fk_consent_consent_deviation_dispensing_record_id` FOREIGN KEY (`dispensing_record_id`) REFERENCES `clinical_trials_ecm`.`supply`.`dispensing_record`(`dispensing_record_id`);

-- ========= consent --> workforce (19 constraint(s)) =========
-- Requires: consent schema, workforce schema
ALTER TABLE `clinical_trials_ecm`.`consent`.`consent_icf_version` ADD CONSTRAINT `fk_consent_consent_icf_version_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`subject_consent` ADD CONSTRAINT `fk_consent_subject_consent_study_assignment_id` FOREIGN KEY (`study_assignment_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`study_assignment`(`study_assignment_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`subject_consent` ADD CONSTRAINT `fk_consent_subject_consent_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`econsent_session` ADD CONSTRAINT `fk_consent_econsent_session_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`reconsent_trigger` ADD CONSTRAINT `fk_consent_reconsent_trigger_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`capacity_assessment` ADD CONSTRAINT `fk_consent_capacity_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`withdrawal` ADD CONSTRAINT `fk_consent_withdrawal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`audit_entry` ADD CONSTRAINT `fk_consent_audit_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`lar_representative` ADD CONSTRAINT `fk_consent_lar_representative_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`icf_amendment` ADD CONSTRAINT `fk_consent_icf_amendment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`consent_delegation_log` ADD CONSTRAINT `fk_consent_consent_delegation_log_gcp_training_record_id` FOREIGN KEY (`gcp_training_record_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`gcp_training_record`(`gcp_training_record_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`consent_delegation_log` ADD CONSTRAINT `fk_consent_consent_delegation_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`consent_delegation_log` ADD CONSTRAINT `fk_consent_consent_delegation_log_protocol_training_record_id` FOREIGN KEY (`protocol_training_record_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`protocol_training_record`(`protocol_training_record_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`consent_delegation_log` ADD CONSTRAINT `fk_consent_consent_delegation_log_study_assignment_id` FOREIGN KEY (`study_assignment_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`study_assignment`(`study_assignment_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`consent_delegation_log` ADD CONSTRAINT `fk_consent_consent_delegation_log_workforce_delegation_log_id` FOREIGN KEY (`workforce_delegation_log_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`workforce_delegation_log`(`workforce_delegation_log_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`assent_record` ADD CONSTRAINT `fk_consent_assent_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`waiver` ADD CONSTRAINT `fk_consent_waiver_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`translation` ADD CONSTRAINT `fk_consent_translation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`consent`.`consent_deviation` ADD CONSTRAINT `fk_consent_consent_deviation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= data --> agreement (17 constraint(s)) =========
-- Requires: data schema, agreement schema
ALTER TABLE `clinical_trials_ecm`.`data`.`ecrf_form` ADD CONSTRAINT `fk_data_ecrf_form_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`deliverable`(`deliverable_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`discrepancy_query` ADD CONSTRAINT `fk_data_discrepancy_query_service_level_agreement_id` FOREIGN KEY (`service_level_agreement_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`service_level_agreement`(`service_level_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_change_order_id` FOREIGN KEY (`change_order_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`change_order`(`change_order_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_scope_of_work_id` FOREIGN KEY (`scope_of_work_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`scope_of_work`(`scope_of_work_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_service_level_agreement_id` FOREIGN KEY (`service_level_agreement_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`service_level_agreement`(`service_level_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_study_contract_id` FOREIGN KEY (`study_contract_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`study_contract`(`study_contract_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_dataset` ADD CONSTRAINT `fk_data_sdtm_dataset_agreement_billing_milestone_id` FOREIGN KEY (`agreement_billing_milestone_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`agreement_billing_milestone`(`agreement_billing_milestone_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_dataset` ADD CONSTRAINT `fk_data_sdtm_dataset_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`deliverable`(`deliverable_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_mapping` ADD CONSTRAINT `fk_data_sdtm_mapping_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`deliverable`(`deliverable_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`external_transfer` ADD CONSTRAINT `fk_data_external_transfer_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`deliverable`(`deliverable_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`external_transfer` ADD CONSTRAINT `fk_data_external_transfer_scope_of_work_id` FOREIGN KEY (`scope_of_work_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`scope_of_work`(`scope_of_work_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`external_transfer` ADD CONSTRAINT `fk_data_external_transfer_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`subcontract`(`subcontract_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`edc_study_build` ADD CONSTRAINT `fk_data_edc_study_build_change_order_id` FOREIGN KEY (`change_order_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`change_order`(`change_order_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`edc_study_build` ADD CONSTRAINT `fk_data_edc_study_build_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`deliverable`(`deliverable_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`edc_study_build` ADD CONSTRAINT `fk_data_edc_study_build_scope_of_work_id` FOREIGN KEY (`scope_of_work_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`scope_of_work`(`scope_of_work_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`deliverable`(`deliverable_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_scope_of_work_id` FOREIGN KEY (`scope_of_work_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`scope_of_work`(`scope_of_work_id`);

-- ========= data --> biostatistics (7 constraint(s)) =========
-- Requires: data schema, biostatistics schema
ALTER TABLE `clinical_trials_ecm`.`data`.`ecrf_form` ADD CONSTRAINT `fk_data_ecrf_form_statistical_endpoint_id` FOREIGN KEY (`statistical_endpoint_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`statistical_endpoint`(`statistical_endpoint_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`ecrf_field` ADD CONSTRAINT `fk_data_ecrf_field_statistical_endpoint_id` FOREIGN KEY (`statistical_endpoint_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`statistical_endpoint`(`statistical_endpoint_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`validation_rule` ADD CONSTRAINT `fk_data_validation_rule_sap_id` FOREIGN KEY (`sap_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sap`(`sap_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_sap_id` FOREIGN KEY (`sap_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sap`(`sap_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_dataset` ADD CONSTRAINT `fk_data_sdtm_dataset_sap_id` FOREIGN KEY (`sap_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sap`(`sap_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_mapping` ADD CONSTRAINT `fk_data_sdtm_mapping_sap_id` FOREIGN KEY (`sap_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sap`(`sap_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_database_lock_event_id` FOREIGN KEY (`database_lock_event_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`database_lock_event`(`database_lock_event_id`);

-- ========= data --> compliance (11 constraint(s)) =========
-- Requires: data schema, compliance schema
ALTER TABLE `clinical_trials_ecm`.`data`.`ecrf_form` ADD CONSTRAINT `fk_data_ecrf_form_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`validation_rule` ADD CONSTRAINT `fk_data_validation_rule_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`coding_assignment` ADD CONSTRAINT `fk_data_coding_assignment_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_dataset` ADD CONSTRAINT `fk_data_sdtm_dataset_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_dataset` ADD CONSTRAINT `fk_data_sdtm_dataset_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_mapping` ADD CONSTRAINT `fk_data_sdtm_mapping_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`alcoa_audit_entry` ADD CONSTRAINT `fk_data_alcoa_audit_entry_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`alcoa_audit_entry` ADD CONSTRAINT `fk_data_alcoa_audit_entry_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);

-- ========= data --> consent (6 constraint(s)) =========
-- Requires: data schema, consent schema
ALTER TABLE `clinical_trials_ecm`.`data`.`ecrf_form` ADD CONSTRAINT `fk_data_ecrf_form_consent_icf_version_id` FOREIGN KEY (`consent_icf_version_id`) REFERENCES `clinical_trials_ecm`.`consent`.`consent_icf_version`(`consent_icf_version_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`subject_visit_data` ADD CONSTRAINT `fk_data_subject_visit_data_subject_consent_id` FOREIGN KEY (`subject_consent_id`) REFERENCES `clinical_trials_ecm`.`consent`.`subject_consent`(`subject_consent_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`external_transfer` ADD CONSTRAINT `fk_data_external_transfer_subject_consent_id` FOREIGN KEY (`subject_consent_id`) REFERENCES `clinical_trials_ecm`.`consent`.`subject_consent`(`subject_consent_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`edc_study_build` ADD CONSTRAINT `fk_data_edc_study_build_consent_icf_version_id` FOREIGN KEY (`consent_icf_version_id`) REFERENCES `clinical_trials_ecm`.`consent`.`consent_icf_version`(`consent_icf_version_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_subject_consent_id` FOREIGN KEY (`subject_consent_id`) REFERENCES `clinical_trials_ecm`.`consent`.`subject_consent`(`subject_consent_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`alcoa_audit_entry` ADD CONSTRAINT `fk_data_alcoa_audit_entry_subject_consent_id` FOREIGN KEY (`subject_consent_id`) REFERENCES `clinical_trials_ecm`.`consent`.`subject_consent`(`subject_consent_id`);

-- ========= data --> document (10 constraint(s)) =========
-- Requires: data schema, document schema
ALTER TABLE `clinical_trials_ecm`.`data`.`validation_rule` ADD CONSTRAINT `fk_data_validation_rule_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_template_id` FOREIGN KEY (`template_id`) REFERENCES `clinical_trials_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_dataset` ADD CONSTRAINT `fk_data_sdtm_dataset_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`external_transfer` ADD CONSTRAINT `fk_data_external_transfer_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`edc_study_build` ADD CONSTRAINT `fk_data_edc_study_build_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`edc_study_build` ADD CONSTRAINT `fk_data_edc_study_build_version_id` FOREIGN KEY (`version_id`) REFERENCES `clinical_trials_ecm`.`document`.`version`(`version_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`edc_study_build` ADD CONSTRAINT `fk_data_edc_study_build_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);

-- ========= data --> laboratory (10 constraint(s)) =========
-- Requires: data schema, laboratory schema
ALTER TABLE `clinical_trials_ecm`.`data`.`ecrf_form` ADD CONSTRAINT `fk_data_ecrf_form_lab_panel_id` FOREIGN KEY (`lab_panel_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_panel`(`lab_panel_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`ecrf_field` ADD CONSTRAINT `fk_data_ecrf_field_lab_analyte_id` FOREIGN KEY (`lab_analyte_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_analyte`(`lab_analyte_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`field_entry` ADD CONSTRAINT `fk_data_field_entry_lab_result_id` FOREIGN KEY (`lab_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_result`(`lab_result_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`discrepancy_query` ADD CONSTRAINT `fk_data_discrepancy_query_lab_result_id` FOREIGN KEY (`lab_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_result`(`lab_result_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`validation_rule` ADD CONSTRAINT `fk_data_validation_rule_lab_analyte_id` FOREIGN KEY (`lab_analyte_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_analyte`(`lab_analyte_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`validation_rule` ADD CONSTRAINT `fk_data_validation_rule_reference_range_id` FOREIGN KEY (`reference_range_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`reference_range`(`reference_range_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_dataset` ADD CONSTRAINT `fk_data_sdtm_dataset_bioanalytical_assay_id` FOREIGN KEY (`bioanalytical_assay_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`bioanalytical_assay`(`bioanalytical_assay_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_mapping` ADD CONSTRAINT `fk_data_sdtm_mapping_lab_analyte_id` FOREIGN KEY (`lab_analyte_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_analyte`(`lab_analyte_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`external_transfer` ADD CONSTRAINT `fk_data_external_transfer_lab_facility_id` FOREIGN KEY (`lab_facility_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_facility`(`lab_facility_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`alcoa_audit_entry` ADD CONSTRAINT `fk_data_alcoa_audit_entry_lab_result_id` FOREIGN KEY (`lab_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_result`(`lab_result_id`);

-- ========= data --> program (6 constraint(s)) =========
-- Requires: data schema, program schema
ALTER TABLE `clinical_trials_ecm`.`data`.`validation_rule` ADD CONSTRAINT `fk_data_validation_rule_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `clinical_trials_ecm`.`program`.`indication`(`indication_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_program_plan_id` FOREIGN KEY (`program_plan_id`) REFERENCES `clinical_trials_ecm`.`program`.`program_plan`(`program_plan_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `clinical_trials_ecm`.`program`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`coding_assignment` ADD CONSTRAINT `fk_data_coding_assignment_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `clinical_trials_ecm`.`program`.`indication`(`indication_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_dataset` ADD CONSTRAINT `fk_data_sdtm_dataset_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_program_milestone_id` FOREIGN KEY (`program_milestone_id`) REFERENCES `clinical_trials_ecm`.`program`.`program_milestone`(`program_milestone_id`);

-- ========= data --> randomization (10 constraint(s)) =========
-- Requires: data schema, randomization schema
ALTER TABLE `clinical_trials_ecm`.`data`.`subject_visit_data` ADD CONSTRAINT `fk_data_subject_visit_data_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`field_entry` ADD CONSTRAINT `fk_data_field_entry_irt_transaction_id` FOREIGN KEY (`irt_transaction_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`irt_transaction`(`irt_transaction_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`field_entry` ADD CONSTRAINT `fk_data_field_entry_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`validation_rule` ADD CONSTRAINT `fk_data_validation_rule_rand_scheme_id` FOREIGN KEY (`rand_scheme_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_scheme`(`rand_scheme_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_dataset` ADD CONSTRAINT `fk_data_sdtm_dataset_blinding_config_id` FOREIGN KEY (`blinding_config_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`blinding_config`(`blinding_config_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_dataset` ADD CONSTRAINT `fk_data_sdtm_dataset_rand_scheme_id` FOREIGN KEY (`rand_scheme_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_scheme`(`rand_scheme_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`external_transfer` ADD CONSTRAINT `fk_data_external_transfer_rand_scheme_id` FOREIGN KEY (`rand_scheme_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_scheme`(`rand_scheme_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_rand_list_id` FOREIGN KEY (`rand_list_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_list`(`rand_list_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`alcoa_audit_entry` ADD CONSTRAINT `fk_data_alcoa_audit_entry_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);

-- ========= data --> regulatory (4 constraint(s)) =========
-- Requires: data schema, regulatory schema
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`strategy`(`strategy_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_dataset` ADD CONSTRAINT `fk_data_sdtm_dataset_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);

-- ========= data --> site (8 constraint(s)) =========
-- Requires: data schema, site schema
ALTER TABLE `clinical_trials_ecm`.`data`.`subject_visit_data` ADD CONSTRAINT `fk_data_subject_visit_data_irb_iec_approval_id` FOREIGN KEY (`irb_iec_approval_id`) REFERENCES `clinical_trials_ecm`.`site`.`irb_iec_approval`(`irb_iec_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`subject_visit_data` ADD CONSTRAINT `fk_data_subject_visit_data_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`field_entry` ADD CONSTRAINT `fk_data_field_entry_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`discrepancy_query` ADD CONSTRAINT `fk_data_discrepancy_query_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`external_transfer` ADD CONSTRAINT `fk_data_external_transfer_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`alcoa_audit_entry` ADD CONSTRAINT `fk_data_alcoa_audit_entry_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`data_entry_session` ADD CONSTRAINT `fk_data_data_entry_session_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);

-- ========= data --> sponsor (7 constraint(s)) =========
-- Requires: data schema, sponsor schema
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_delivery_preference_id` FOREIGN KEY (`delivery_preference_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`delivery_preference`(`delivery_preference_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_regulatory_strategy_id` FOREIGN KEY (`regulatory_strategy_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`regulatory_strategy`(`regulatory_strategy_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_dataset` ADD CONSTRAINT `fk_data_sdtm_dataset_delivery_preference_id` FOREIGN KEY (`delivery_preference_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`delivery_preference`(`delivery_preference_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_dataset` ADD CONSTRAINT `fk_data_sdtm_dataset_regulatory_strategy_id` FOREIGN KEY (`regulatory_strategy_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`regulatory_strategy`(`regulatory_strategy_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`external_transfer` ADD CONSTRAINT `fk_data_external_transfer_delivery_preference_id` FOREIGN KEY (`delivery_preference_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`delivery_preference`(`delivery_preference_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`edc_study_build` ADD CONSTRAINT `fk_data_edc_study_build_delivery_preference_id` FOREIGN KEY (`delivery_preference_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`delivery_preference`(`delivery_preference_id`);

-- ========= data --> study (15 constraint(s)) =========
-- Requires: data schema, study schema
ALTER TABLE `clinical_trials_ecm`.`data`.`ecrf_field` ADD CONSTRAINT `fk_data_ecrf_field_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`subject_visit_data` ADD CONSTRAINT `fk_data_subject_visit_data_study_visit_schedule_id` FOREIGN KEY (`study_visit_schedule_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_visit_schedule`(`study_visit_schedule_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`field_entry` ADD CONSTRAINT `fk_data_field_entry_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`discrepancy_query` ADD CONSTRAINT `fk_data_discrepancy_query_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`validation_rule` ADD CONSTRAINT `fk_data_validation_rule_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`validation_rule` ADD CONSTRAINT `fk_data_validation_rule_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`coding_assignment` ADD CONSTRAINT `fk_data_coding_assignment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_dataset` ADD CONSTRAINT `fk_data_sdtm_dataset_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_mapping` ADD CONSTRAINT `fk_data_sdtm_mapping_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`external_transfer` ADD CONSTRAINT `fk_data_external_transfer_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`alcoa_audit_entry` ADD CONSTRAINT `fk_data_alcoa_audit_entry_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`data_entry_session` ADD CONSTRAINT `fk_data_data_entry_session_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);

-- ========= data --> subject (10 constraint(s)) =========
-- Requires: data schema, subject schema
ALTER TABLE `clinical_trials_ecm`.`data`.`subject_visit_data` ADD CONSTRAINT `fk_data_subject_visit_data_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`subject_visit_data` ADD CONSTRAINT `fk_data_subject_visit_data_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`field_entry` ADD CONSTRAINT `fk_data_field_entry_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`field_entry` ADD CONSTRAINT `fk_data_field_entry_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`discrepancy_query` ADD CONSTRAINT `fk_data_discrepancy_query_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`coding_assignment` ADD CONSTRAINT `fk_data_coding_assignment_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`alcoa_audit_entry` ADD CONSTRAINT `fk_data_alcoa_audit_entry_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`data_entry_session` ADD CONSTRAINT `fk_data_data_entry_session_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`data_entry_session` ADD CONSTRAINT `fk_data_data_entry_session_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);

-- ========= data --> supply (12 constraint(s)) =========
-- Requires: data schema, supply schema
ALTER TABLE `clinical_trials_ecm`.`data`.`ecrf_form` ADD CONSTRAINT `fk_data_ecrf_form_kit_definition_id` FOREIGN KEY (`kit_definition_id`) REFERENCES `clinical_trials_ecm`.`supply`.`kit_definition`(`kit_definition_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`field_entry` ADD CONSTRAINT `fk_data_field_entry_dispensing_record_id` FOREIGN KEY (`dispensing_record_id`) REFERENCES `clinical_trials_ecm`.`supply`.`dispensing_record`(`dispensing_record_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`discrepancy_query` ADD CONSTRAINT `fk_data_discrepancy_query_dispensing_record_id` FOREIGN KEY (`dispensing_record_id`) REFERENCES `clinical_trials_ecm`.`supply`.`dispensing_record`(`dispensing_record_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`discrepancy_query` ADD CONSTRAINT `fk_data_discrepancy_query_kit_inventory_id` FOREIGN KEY (`kit_inventory_id`) REFERENCES `clinical_trials_ecm`.`supply`.`kit_inventory`(`kit_inventory_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`coding_assignment` ADD CONSTRAINT `fk_data_coding_assignment_comparator_drug_id` FOREIGN KEY (`comparator_drug_id`) REFERENCES `clinical_trials_ecm`.`supply`.`comparator_drug`(`comparator_drug_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_mapping` ADD CONSTRAINT `fk_data_sdtm_mapping_kit_definition_id` FOREIGN KEY (`kit_definition_id`) REFERENCES `clinical_trials_ecm`.`supply`.`kit_definition`(`kit_definition_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`external_transfer` ADD CONSTRAINT `fk_data_external_transfer_dispensing_record_id` FOREIGN KEY (`dispensing_record_id`) REFERENCES `clinical_trials_ecm`.`supply`.`dispensing_record`(`dispensing_record_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`external_transfer` ADD CONSTRAINT `fk_data_external_transfer_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `clinical_trials_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_accountability_reconciliation_id` FOREIGN KEY (`accountability_reconciliation_id`) REFERENCES `clinical_trials_ecm`.`supply`.`accountability_reconciliation`(`accountability_reconciliation_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `clinical_trials_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`alcoa_audit_entry` ADD CONSTRAINT `fk_data_alcoa_audit_entry_dispensing_record_id` FOREIGN KEY (`dispensing_record_id`) REFERENCES `clinical_trials_ecm`.`supply`.`dispensing_record`(`dispensing_record_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`alcoa_audit_entry` ADD CONSTRAINT `fk_data_alcoa_audit_entry_kit_inventory_id` FOREIGN KEY (`kit_inventory_id`) REFERENCES `clinical_trials_ecm`.`supply`.`kit_inventory`(`kit_inventory_id`);

-- ========= data --> workforce (17 constraint(s)) =========
-- Requires: data schema, workforce schema
ALTER TABLE `clinical_trials_ecm`.`data`.`ecrf_form` ADD CONSTRAINT `fk_data_ecrf_form_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`ecrf_field` ADD CONSTRAINT `fk_data_ecrf_field_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`subject_visit_data` ADD CONSTRAINT `fk_data_subject_visit_data_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`field_entry` ADD CONSTRAINT `fk_data_field_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`discrepancy_query` ADD CONSTRAINT `fk_data_discrepancy_query_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`validation_rule` ADD CONSTRAINT `fk_data_validation_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`dmp` ADD CONSTRAINT `fk_data_dmp_dmp_employee_id` FOREIGN KEY (`dmp_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`coding_assignment` ADD CONSTRAINT `fk_data_coding_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`coding_assignment` ADD CONSTRAINT `fk_data_coding_assignment_primary_coding_employee_id` FOREIGN KEY (`primary_coding_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_dataset` ADD CONSTRAINT `fk_data_sdtm_dataset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`sdtm_mapping` ADD CONSTRAINT `fk_data_sdtm_mapping_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`external_transfer` ADD CONSTRAINT `fk_data_external_transfer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`edc_study_build` ADD CONSTRAINT `fk_data_edc_study_build_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`reconciliation` ADD CONSTRAINT `fk_data_reconciliation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`alcoa_audit_entry` ADD CONSTRAINT `fk_data_alcoa_audit_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`data`.`data_entry_session` ADD CONSTRAINT `fk_data_data_entry_session_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= document --> compliance (4 constraint(s)) =========
-- Requires: document schema, compliance schema
ALTER TABLE `clinical_trials_ecm`.`document`.`inspection_readiness` ADD CONSTRAINT `fk_document_inspection_readiness_compliance_capa_id` FOREIGN KEY (`compliance_capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_capa`(`compliance_capa_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`inspection_readiness` ADD CONSTRAINT `fk_document_inspection_readiness_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`access_log` ADD CONSTRAINT `fk_document_access_log_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`template` ADD CONSTRAINT `fk_document_template_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);

-- ========= document --> program (4 constraint(s)) =========
-- Requires: document schema, program schema
ALTER TABLE `clinical_trials_ecm`.`document`.`document_sop` ADD CONSTRAINT `fk_document_document_sop_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `clinical_trials_ecm`.`program`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`regulatory_binder` ADD CONSTRAINT `fk_document_regulatory_binder_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `clinical_trials_ecm`.`program`.`indication`(`indication_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`regulatory_binder` ADD CONSTRAINT `fk_document_regulatory_binder_program_plan_id` FOREIGN KEY (`program_plan_id`) REFERENCES `clinical_trials_ecm`.`program`.`program_plan`(`program_plan_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`etmf_exchange` ADD CONSTRAINT `fk_document_etmf_exchange_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);

-- ========= document --> regulatory (3 constraint(s)) =========
-- Requires: document schema, regulatory schema
ALTER TABLE `clinical_trials_ecm`.`document`.`inspection_readiness` ADD CONSTRAINT `fk_document_inspection_readiness_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`regulatory_binder` ADD CONSTRAINT `fk_document_regulatory_binder_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`document_icf_version` ADD CONSTRAINT `fk_document_document_icf_version_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);

-- ========= document --> site (10 constraint(s)) =========
-- Requires: document schema, site schema
ALTER TABLE `clinical_trials_ecm`.`document`.`signature` ADD CONSTRAINT `fk_document_signature_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`site_file` ADD CONSTRAINT `fk_document_site_file_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`site_file_document` ADD CONSTRAINT `fk_document_site_file_document_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`tmf_completeness` ADD CONSTRAINT `fk_document_tmf_completeness_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`inspection_readiness` ADD CONSTRAINT `fk_document_inspection_readiness_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`distribution` ADD CONSTRAINT `fk_document_distribution_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`archival_record` ADD CONSTRAINT `fk_document_archival_record_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`access_log` ADD CONSTRAINT `fk_document_access_log_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`delegation_of_authority` ADD CONSTRAINT `fk_document_delegation_of_authority_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `clinical_trials_ecm`.`site`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`delegation_of_authority` ADD CONSTRAINT `fk_document_delegation_of_authority_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);

-- ========= document --> sponsor (6 constraint(s)) =========
-- Requires: document schema, sponsor schema
ALTER TABLE `clinical_trials_ecm`.`document`.`signature` ADD CONSTRAINT `fk_document_signature_sponsor_contact_id` FOREIGN KEY (`sponsor_contact_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`sponsor_contact`(`sponsor_contact_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`tmf_completeness` ADD CONSTRAINT `fk_document_tmf_completeness_master_agreement_id` FOREIGN KEY (`master_agreement_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`master_agreement`(`master_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`inspection_readiness` ADD CONSTRAINT `fk_document_inspection_readiness_regulatory_strategy_id` FOREIGN KEY (`regulatory_strategy_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`regulatory_strategy`(`regulatory_strategy_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`regulatory_binder` ADD CONSTRAINT `fk_document_regulatory_binder_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`etmf_exchange` ADD CONSTRAINT `fk_document_etmf_exchange_master_agreement_id` FOREIGN KEY (`master_agreement_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`master_agreement`(`master_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`etmf_exchange` ADD CONSTRAINT `fk_document_etmf_exchange_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);

-- ========= document --> study (12 constraint(s)) =========
-- Requires: document schema, study schema
ALTER TABLE `clinical_trials_ecm`.`document`.`tmf_document` ADD CONSTRAINT `fk_document_tmf_document_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`signature` ADD CONSTRAINT `fk_document_signature_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`site_file` ADD CONSTRAINT `fk_document_site_file_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`tmf_completeness` ADD CONSTRAINT `fk_document_tmf_completeness_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`inspection_readiness` ADD CONSTRAINT `fk_document_inspection_readiness_study_study_id` FOREIGN KEY (`study_study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`inspection_readiness` ADD CONSTRAINT `fk_document_inspection_readiness_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`distribution` ADD CONSTRAINT `fk_document_distribution_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`archival_record` ADD CONSTRAINT `fk_document_archival_record_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`access_log` ADD CONSTRAINT `fk_document_access_log_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`etmf_exchange` ADD CONSTRAINT `fk_document_etmf_exchange_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`delegation_of_authority` ADD CONSTRAINT `fk_document_delegation_of_authority_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);

-- ========= document --> workforce (21 constraint(s)) =========
-- Requires: document schema, workforce schema
ALTER TABLE `clinical_trials_ecm`.`document`.`tmf_document` ADD CONSTRAINT `fk_document_tmf_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`version` ADD CONSTRAINT `fk_document_version_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`version` ADD CONSTRAINT `fk_document_version_version_author_employee_id` FOREIGN KEY (`version_author_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`document_sop` ADD CONSTRAINT `fk_document_document_sop_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`document_sop` ADD CONSTRAINT `fk_document_document_sop_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`document_sop` ADD CONSTRAINT `fk_document_document_sop_training_curriculum_id` FOREIGN KEY (`training_curriculum_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`training_curriculum`(`training_curriculum_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_workflow_initiated_by_user_employee_id` FOREIGN KEY (`workflow_initiated_by_user_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`signature` ADD CONSTRAINT `fk_document_signature_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`signature` ADD CONSTRAINT `fk_document_signature_signature_voided_by_user_employee_id` FOREIGN KEY (`signature_voided_by_user_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`site_file` ADD CONSTRAINT `fk_document_site_file_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`site_file_document` ADD CONSTRAINT `fk_document_site_file_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`tmf_completeness` ADD CONSTRAINT `fk_document_tmf_completeness_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`inspection_readiness` ADD CONSTRAINT `fk_document_inspection_readiness_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`distribution` ADD CONSTRAINT `fk_document_distribution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`regulatory_binder` ADD CONSTRAINT `fk_document_regulatory_binder_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`binder_document` ADD CONSTRAINT `fk_document_binder_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`archival_record` ADD CONSTRAINT `fk_document_archival_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`access_log` ADD CONSTRAINT `fk_document_access_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`document_icf_version` ADD CONSTRAINT `fk_document_document_icf_version_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`document`.`template` ADD CONSTRAINT `fk_document_template_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= finance --> agreement (17 constraint(s)) =========
-- Requires: finance schema, agreement schema
ALTER TABLE `clinical_trials_ecm`.`finance`.`study_budget` ADD CONSTRAINT `fk_finance_study_budget_change_order_id` FOREIGN KEY (`change_order_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`change_order`(`change_order_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`study_budget` ADD CONSTRAINT `fk_finance_study_budget_scope_of_work_id` FOREIGN KEY (`scope_of_work_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`scope_of_work`(`scope_of_work_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`sponsor_invoice` ADD CONSTRAINT `fk_finance_sponsor_invoice_study_contract_id` FOREIGN KEY (`study_contract_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`study_contract`(`study_contract_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`deliverable`(`deliverable_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`rate_card`(`rate_card_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_study_contract_id` FOREIGN KEY (`study_contract_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`study_contract`(`study_contract_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`subcontract`(`subcontract_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`vendor_invoice` ADD CONSTRAINT `fk_finance_vendor_invoice_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`subcontract`(`subcontract_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_agreement_billing_milestone_id` FOREIGN KEY (`agreement_billing_milestone_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`agreement_billing_milestone`(`agreement_billing_milestone_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_investigator_grant_id` FOREIGN KEY (`investigator_grant_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`investigator_grant`(`investigator_grant_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_study_contract_id` FOREIGN KEY (`study_contract_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`study_contract`(`study_contract_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_study_contract_id` FOREIGN KEY (`study_contract_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`study_contract`(`study_contract_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`deliverable`(`deliverable_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_scope_of_work_id` FOREIGN KEY (`scope_of_work_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`scope_of_work`(`scope_of_work_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_scope_of_work_id` FOREIGN KEY (`scope_of_work_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`scope_of_work`(`scope_of_work_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_change_order_id` FOREIGN KEY (`change_order_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`change_order`(`change_order_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`rate_card`(`rate_card_id`);

-- ========= finance --> biostatistics (5 constraint(s)) =========
-- Requires: finance schema, biostatistics schema
ALTER TABLE `clinical_trials_ecm`.`finance`.`study_budget` ADD CONSTRAINT `fk_finance_study_budget_sample_size_calc_id` FOREIGN KEY (`sample_size_calc_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sample_size_calc`(`sample_size_calc_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_database_lock_event_id` FOREIGN KEY (`database_lock_event_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`database_lock_event`(`database_lock_event_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_database_lock_event_id` FOREIGN KEY (`database_lock_event_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`database_lock_event`(`database_lock_event_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_interim_analysis_id` FOREIGN KEY (`interim_analysis_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`interim_analysis`(`interim_analysis_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_sample_size_calc_id` FOREIGN KEY (`sample_size_calc_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sample_size_calc`(`sample_size_calc_id`);

-- ========= finance --> compliance (3 constraint(s)) =========
-- Requires: finance schema, compliance schema
ALTER TABLE `clinical_trials_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_compliance_capa_id` FOREIGN KEY (`compliance_capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_capa`(`compliance_capa_id`);

-- ========= finance --> consent (3 constraint(s)) =========
-- Requires: finance schema, consent schema
ALTER TABLE `clinical_trials_ecm`.`finance`.`patient_stipend` ADD CONSTRAINT `fk_finance_patient_stipend_subject_consent_id` FOREIGN KEY (`subject_consent_id`) REFERENCES `clinical_trials_ecm`.`consent`.`subject_consent`(`subject_consent_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`vendor_invoice` ADD CONSTRAINT `fk_finance_vendor_invoice_icf_amendment_id` FOREIGN KEY (`icf_amendment_id`) REFERENCES `clinical_trials_ecm`.`consent`.`icf_amendment`(`icf_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_icf_amendment_id` FOREIGN KEY (`icf_amendment_id`) REFERENCES `clinical_trials_ecm`.`consent`.`icf_amendment`(`icf_amendment_id`);

-- ========= finance --> data (7 constraint(s)) =========
-- Requires: finance schema, data schema
ALTER TABLE `clinical_trials_ecm`.`finance`.`study_budget` ADD CONSTRAINT `fk_finance_study_budget_dmp_id` FOREIGN KEY (`dmp_id`) REFERENCES `clinical_trials_ecm`.`data`.`dmp`(`dmp_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`sponsor_invoice` ADD CONSTRAINT `fk_finance_sponsor_invoice_sdtm_dataset_id` FOREIGN KEY (`sdtm_dataset_id`) REFERENCES `clinical_trials_ecm`.`data`.`sdtm_dataset`(`sdtm_dataset_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`patient_stipend` ADD CONSTRAINT `fk_finance_patient_stipend_subject_visit_data_id` FOREIGN KEY (`subject_visit_data_id`) REFERENCES `clinical_trials_ecm`.`data`.`subject_visit_data`(`subject_visit_data_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`vendor_invoice` ADD CONSTRAINT `fk_finance_vendor_invoice_external_transfer_id` FOREIGN KEY (`external_transfer_id`) REFERENCES `clinical_trials_ecm`.`data`.`external_transfer`(`external_transfer_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_sdtm_dataset_id` FOREIGN KEY (`sdtm_dataset_id`) REFERENCES `clinical_trials_ecm`.`data`.`sdtm_dataset`(`sdtm_dataset_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`finance_billing_milestone` ADD CONSTRAINT `fk_finance_finance_billing_milestone_sdtm_dataset_id` FOREIGN KEY (`sdtm_dataset_id`) REFERENCES `clinical_trials_ecm`.`data`.`sdtm_dataset`(`sdtm_dataset_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_edc_study_build_id` FOREIGN KEY (`edc_study_build_id`) REFERENCES `clinical_trials_ecm`.`data`.`edc_study_build`(`edc_study_build_id`);

-- ========= finance --> document (5 constraint(s)) =========
-- Requires: finance schema, document schema
ALTER TABLE `clinical_trials_ecm`.`finance`.`patient_stipend` ADD CONSTRAINT `fk_finance_patient_stipend_document_icf_version_id` FOREIGN KEY (`document_icf_version_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_icf_version`(`document_icf_version_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`finance_billing_milestone` ADD CONSTRAINT `fk_finance_finance_billing_milestone_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`finance_billing_milestone` ADD CONSTRAINT `fk_finance_finance_billing_milestone_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`finance_billing_milestone` ADD CONSTRAINT `fk_finance_finance_billing_milestone_workflow_id` FOREIGN KEY (`workflow_id`) REFERENCES `clinical_trials_ecm`.`document`.`workflow`(`workflow_id`);

-- ========= finance --> laboratory (12 constraint(s)) =========
-- Requires: finance schema, laboratory schema
ALTER TABLE `clinical_trials_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_lab_panel_id` FOREIGN KEY (`lab_panel_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_panel`(`lab_panel_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`patient_stipend` ADD CONSTRAINT `fk_finance_patient_stipend_specimen_collection_id` FOREIGN KEY (`specimen_collection_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`specimen_collection`(`specimen_collection_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_bioanalytical_assay_id` FOREIGN KEY (`bioanalytical_assay_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`bioanalytical_assay`(`bioanalytical_assay_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_lab_facility_id` FOREIGN KEY (`lab_facility_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_facility`(`lab_facility_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`vendor_invoice` ADD CONSTRAINT `fk_finance_vendor_invoice_bioanalytical_assay_id` FOREIGN KEY (`bioanalytical_assay_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`bioanalytical_assay`(`bioanalytical_assay_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`vendor_invoice` ADD CONSTRAINT `fk_finance_vendor_invoice_lab_facility_id` FOREIGN KEY (`lab_facility_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_facility`(`lab_facility_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`vendor_invoice` ADD CONSTRAINT `fk_finance_vendor_invoice_specimen_shipment_id` FOREIGN KEY (`specimen_shipment_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`specimen_shipment`(`specimen_shipment_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_lab_facility_id` FOREIGN KEY (`lab_facility_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_facility`(`lab_facility_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_lab_facility_id` FOREIGN KEY (`lab_facility_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_facility`(`lab_facility_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_bioanalytical_assay_id` FOREIGN KEY (`bioanalytical_assay_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`bioanalytical_assay`(`bioanalytical_assay_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_lab_panel_id` FOREIGN KEY (`lab_panel_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_panel`(`lab_panel_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_protocol_lab_schedule_id` FOREIGN KEY (`protocol_lab_schedule_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`protocol_lab_schedule`(`protocol_lab_schedule_id`);

-- ========= finance --> monitoring (7 constraint(s)) =========
-- Requires: finance schema, monitoring schema
ALTER TABLE `clinical_trials_ecm`.`finance`.`site_payment` ADD CONSTRAINT `fk_finance_site_payment_monitoring_visit_id` FOREIGN KEY (`monitoring_visit_id`) REFERENCES `clinical_trials_ecm`.`monitoring`.`monitoring_visit`(`monitoring_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`vendor_invoice` ADD CONSTRAINT `fk_finance_vendor_invoice_monitoring_cra_assignment_id` FOREIGN KEY (`monitoring_cra_assignment_id`) REFERENCES `clinical_trials_ecm`.`monitoring`.`monitoring_cra_assignment`(`monitoring_cra_assignment_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`vendor_invoice` ADD CONSTRAINT `fk_finance_vendor_invoice_monitoring_visit_id` FOREIGN KEY (`monitoring_visit_id`) REFERENCES `clinical_trials_ecm`.`monitoring`.`monitoring_visit`(`monitoring_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_monitoring_visit_id` FOREIGN KEY (`monitoring_visit_id`) REFERENCES `clinical_trials_ecm`.`monitoring`.`monitoring_visit`(`monitoring_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_visit_report_id` FOREIGN KEY (`visit_report_id`) REFERENCES `clinical_trials_ecm`.`monitoring`.`visit_report`(`visit_report_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_monitoring_plan_id` FOREIGN KEY (`monitoring_plan_id`) REFERENCES `clinical_trials_ecm`.`monitoring`.`monitoring_plan`(`monitoring_plan_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_monitoring_plan_id` FOREIGN KEY (`monitoring_plan_id`) REFERENCES `clinical_trials_ecm`.`monitoring`.`monitoring_plan`(`monitoring_plan_id`);

-- ========= finance --> program (6 constraint(s)) =========
-- Requires: finance schema, program schema
ALTER TABLE `clinical_trials_ecm`.`finance`.`study_budget` ADD CONSTRAINT `fk_finance_study_budget_program_plan_id` FOREIGN KEY (`program_plan_id`) REFERENCES `clinical_trials_ecm`.`program`.`program_plan`(`program_plan_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_program_milestone_id` FOREIGN KEY (`program_milestone_id`) REFERENCES `clinical_trials_ecm`.`program`.`program_milestone`(`program_milestone_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_program_milestone_id` FOREIGN KEY (`program_milestone_id`) REFERENCES `clinical_trials_ecm`.`program`.`program_milestone`(`program_milestone_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_timeline_id` FOREIGN KEY (`timeline_id`) REFERENCES `clinical_trials_ecm`.`program`.`timeline`(`timeline_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`finance_billing_milestone` ADD CONSTRAINT `fk_finance_finance_billing_milestone_program_milestone_id` FOREIGN KEY (`program_milestone_id`) REFERENCES `clinical_trials_ecm`.`program`.`program_milestone`(`program_milestone_id`);

-- ========= finance --> randomization (3 constraint(s)) =========
-- Requires: finance schema, randomization schema
ALTER TABLE `clinical_trials_ecm`.`finance`.`patient_stipend` ADD CONSTRAINT `fk_finance_patient_stipend_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`finance_billing_milestone` ADD CONSTRAINT `fk_finance_finance_billing_milestone_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);

-- ========= finance --> regulatory (13 constraint(s)) =========
-- Requires: finance schema, regulatory schema
ALTER TABLE `clinical_trials_ecm`.`finance`.`sponsor_invoice` ADD CONSTRAINT `fk_finance_sponsor_invoice_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`vendor_invoice` ADD CONSTRAINT `fk_finance_vendor_invoice_rems_program_id` FOREIGN KEY (`rems_program_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`rems_program`(`rems_program_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_commitment_id` FOREIGN KEY (`commitment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`commitment`(`commitment_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`finance_billing_milestone` ADD CONSTRAINT `fk_finance_finance_billing_milestone_nda_bla_application_id` FOREIGN KEY (`nda_bla_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`nda_bla_application`(`nda_bla_application_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`finance_billing_milestone` ADD CONSTRAINT `fk_finance_finance_billing_milestone_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`finance_billing_milestone` ADD CONSTRAINT `fk_finance_finance_billing_milestone_commitment_id` FOREIGN KEY (`commitment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`commitment`(`commitment_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`finance_billing_milestone` ADD CONSTRAINT `fk_finance_finance_billing_milestone_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`finance_billing_milestone` ADD CONSTRAINT `fk_finance_finance_billing_milestone_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);

-- ========= finance --> safety (7 constraint(s)) =========
-- Requires: finance schema, safety schema
ALTER TABLE `clinical_trials_ecm`.`finance`.`sponsor_invoice` ADD CONSTRAINT `fk_finance_sponsor_invoice_icsr_id` FOREIGN KEY (`icsr_id`) REFERENCES `clinical_trials_ecm`.`safety`.`icsr`(`icsr_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_dsmb_review_id` FOREIGN KEY (`dsmb_review_id`) REFERENCES `clinical_trials_ecm`.`safety`.`dsmb_review`(`dsmb_review_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_icsr_id` FOREIGN KEY (`icsr_id`) REFERENCES `clinical_trials_ecm`.`safety`.`icsr`(`icsr_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_serious_adverse_event_id` FOREIGN KEY (`serious_adverse_event_id`) REFERENCES `clinical_trials_ecm`.`safety`.`serious_adverse_event`(`serious_adverse_event_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_benefit_risk_assessment_id` FOREIGN KEY (`benefit_risk_assessment_id`) REFERENCES `clinical_trials_ecm`.`safety`.`benefit_risk_assessment`(`benefit_risk_assessment_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_dsmb_review_id` FOREIGN KEY (`dsmb_review_id`) REFERENCES `clinical_trials_ecm`.`safety`.`dsmb_review`(`dsmb_review_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_reporting_obligation_id` FOREIGN KEY (`reporting_obligation_id`) REFERENCES `clinical_trials_ecm`.`safety`.`reporting_obligation`(`reporting_obligation_id`);

-- ========= finance --> site (6 constraint(s)) =========
-- Requires: finance schema, site schema
ALTER TABLE `clinical_trials_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`site_payment` ADD CONSTRAINT `fk_finance_site_payment_site_agreement_id` FOREIGN KEY (`site_agreement_id`) REFERENCES `clinical_trials_ecm`.`site`.`site_agreement`(`site_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`site_payment` ADD CONSTRAINT `fk_finance_site_payment_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`patient_stipend` ADD CONSTRAINT `fk_finance_patient_stipend_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`vendor_invoice` ADD CONSTRAINT `fk_finance_vendor_invoice_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);

-- ========= finance --> sponsor (20 constraint(s)) =========
-- Requires: finance schema, sponsor schema
ALTER TABLE `clinical_trials_ecm`.`finance`.`study_budget` ADD CONSTRAINT `fk_finance_study_budget_delivery_preference_id` FOREIGN KEY (`delivery_preference_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`delivery_preference`(`delivery_preference_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`study_budget` ADD CONSTRAINT `fk_finance_study_budget_master_agreement_id` FOREIGN KEY (`master_agreement_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`master_agreement`(`master_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`study_budget` ADD CONSTRAINT `fk_finance_study_budget_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`study_budget` ADD CONSTRAINT `fk_finance_study_budget_pipeline_asset_id` FOREIGN KEY (`pipeline_asset_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`pipeline_asset`(`pipeline_asset_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`study_budget` ADD CONSTRAINT `fk_finance_study_budget_proposal_id` FOREIGN KEY (`proposal_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`proposal`(`proposal_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`sponsor_invoice` ADD CONSTRAINT `fk_finance_sponsor_invoice_sponsor_contact_id` FOREIGN KEY (`sponsor_contact_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`sponsor_contact`(`sponsor_contact_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`sponsor_invoice` ADD CONSTRAINT `fk_finance_sponsor_invoice_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_proposal_line_id` FOREIGN KEY (`proposal_line_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`proposal_line`(`proposal_line_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`site_payment` ADD CONSTRAINT `fk_finance_site_payment_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_account_plan_id` FOREIGN KEY (`account_plan_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`account_plan`(`account_plan_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_pipeline_asset_id` FOREIGN KEY (`pipeline_asset_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`pipeline_asset`(`pipeline_asset_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_sponsor_engagement_id` FOREIGN KEY (`sponsor_engagement_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`sponsor_engagement`(`sponsor_engagement_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`finance_billing_milestone` ADD CONSTRAINT `fk_finance_finance_billing_milestone_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`finance_billing_milestone` ADD CONSTRAINT `fk_finance_finance_billing_milestone_proposal_id` FOREIGN KEY (`proposal_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`proposal`(`proposal_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_proposal_line_id` FOREIGN KEY (`proposal_line_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`proposal_line`(`proposal_line_id`);

-- ========= finance --> study (31 constraint(s)) =========
-- Requires: finance schema, study schema
ALTER TABLE `clinical_trials_ecm`.`finance`.`study_budget` ADD CONSTRAINT `fk_finance_study_budget_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`study_budget` ADD CONSTRAINT `fk_finance_study_budget_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`study_budget` ADD CONSTRAINT `fk_finance_study_budget_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`sponsor_invoice` ADD CONSTRAINT `fk_finance_sponsor_invoice_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`site_payment` ADD CONSTRAINT `fk_finance_site_payment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`patient_stipend` ADD CONSTRAINT `fk_finance_patient_stipend_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`patient_stipend` ADD CONSTRAINT `fk_finance_patient_stipend_study_visit_schedule_id` FOREIGN KEY (`study_visit_schedule_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_visit_schedule`(`study_visit_schedule_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `clinical_trials_ecm`.`study`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`vendor_invoice` ADD CONSTRAINT `fk_finance_vendor_invoice_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_country_id` FOREIGN KEY (`country_id`) REFERENCES `clinical_trials_ecm`.`study`.`country`(`country_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `clinical_trials_ecm`.`study`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_country_id` FOREIGN KEY (`country_id`) REFERENCES `clinical_trials_ecm`.`study`.`country`(`country_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_study_milestone_id` FOREIGN KEY (`study_milestone_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_milestone`(`study_milestone_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`finance_billing_milestone` ADD CONSTRAINT `fk_finance_finance_billing_milestone_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`finance_billing_milestone` ADD CONSTRAINT `fk_finance_finance_billing_milestone_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_dosing_regimen_id` FOREIGN KEY (`dosing_regimen_id`) REFERENCES `clinical_trials_ecm`.`study`.`dosing_regimen`(`dosing_regimen_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_pk_sampling_schedule_id` FOREIGN KEY (`pk_sampling_schedule_id`) REFERENCES `clinical_trials_ecm`.`study`.`pk_sampling_schedule`(`pk_sampling_schedule_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_study_visit_schedule_id` FOREIGN KEY (`study_visit_schedule_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_visit_schedule`(`study_visit_schedule_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_visit_procedure_id` FOREIGN KEY (`visit_procedure_id`) REFERENCES `clinical_trials_ecm`.`study`.`visit_procedure`(`visit_procedure_id`);

-- ========= finance --> subject (3 constraint(s)) =========
-- Requires: finance schema, subject schema
ALTER TABLE `clinical_trials_ecm`.`finance`.`patient_stipend` ADD CONSTRAINT `fk_finance_patient_stipend_enrollment_id` FOREIGN KEY (`enrollment_id`) REFERENCES `clinical_trials_ecm`.`subject`.`enrollment`(`enrollment_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`patient_stipend` ADD CONSTRAINT `fk_finance_patient_stipend_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`patient_stipend` ADD CONSTRAINT `fk_finance_patient_stipend_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);

-- ========= finance --> workforce (18 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `clinical_trials_ecm`.`finance`.`study_budget` ADD CONSTRAINT `fk_finance_study_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_tertiary_cost_responsible_manager_employee_id` FOREIGN KEY (`tertiary_cost_responsible_manager_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_payroll_record_id` FOREIGN KEY (`payroll_record_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`payroll_record`(`payroll_record_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`sponsor_invoice` ADD CONSTRAINT `fk_finance_sponsor_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`invoice_line` ADD CONSTRAINT `fk_finance_invoice_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`site_payment` ADD CONSTRAINT `fk_finance_site_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`patient_stipend` ADD CONSTRAINT `fk_finance_patient_stipend_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`vendor_invoice` ADD CONSTRAINT `fk_finance_vendor_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`accrual` ADD CONSTRAINT `fk_finance_accrual_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_primary_financial_preparer_employee_id` FOREIGN KEY (`primary_financial_preparer_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_workforce_resource_plan_id` FOREIGN KEY (`workforce_resource_plan_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`workforce_resource_plan`(`workforce_resource_plan_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`finance_billing_milestone` ADD CONSTRAINT `fk_finance_finance_billing_milestone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= laboratory --> agreement (9 constraint(s)) =========
-- Requires: laboratory schema, agreement schema
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_shipment` ADD CONSTRAINT `fk_laboratory_specimen_shipment_service_level_agreement_id` FOREIGN KEY (`service_level_agreement_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`service_level_agreement`(`service_level_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_shipment` ADD CONSTRAINT `fk_laboratory_specimen_shipment_study_contract_id` FOREIGN KEY (`study_contract_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`study_contract`(`study_contract_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_assay` ADD CONSTRAINT `fk_laboratory_bioanalytical_assay_master_service_agreement_id` FOREIGN KEY (`master_service_agreement_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`master_service_agreement`(`master_service_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_kit` ADD CONSTRAINT `fk_laboratory_lab_kit_scope_of_work_id` FOREIGN KEY (`scope_of_work_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`scope_of_work`(`scope_of_work_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_kit` ADD CONSTRAINT `fk_laboratory_lab_kit_study_contract_id` FOREIGN KEY (`study_contract_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`study_contract`(`study_contract_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_query` ADD CONSTRAINT `fk_laboratory_lab_query_service_level_agreement_id` FOREIGN KEY (`service_level_agreement_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`service_level_agreement`(`service_level_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`protocol_lab_schedule` ADD CONSTRAINT `fk_laboratory_protocol_lab_schedule_change_order_id` FOREIGN KEY (`change_order_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`change_order`(`change_order_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`protocol_lab_schedule` ADD CONSTRAINT `fk_laboratory_protocol_lab_schedule_scope_of_work_id` FOREIGN KEY (`scope_of_work_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`scope_of_work`(`scope_of_work_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`sow_lab_panel_requirement` ADD CONSTRAINT `fk_laboratory_sow_lab_panel_requirement_scope_of_work_id` FOREIGN KEY (`scope_of_work_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`scope_of_work`(`scope_of_work_id`);

-- ========= laboratory --> biostatistics (2 constraint(s)) =========
-- Requires: laboratory schema, biostatistics schema
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`reference_range` ADD CONSTRAINT `fk_laboratory_reference_range_sap_id` FOREIGN KEY (`sap_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sap`(`sap_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_result` ADD CONSTRAINT `fk_laboratory_bioanalytical_result_pk_analysis_spec_id` FOREIGN KEY (`pk_analysis_spec_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`pk_analysis_spec`(`pk_analysis_spec_id`);

-- ========= laboratory --> compliance (5 constraint(s)) =========
-- Requires: laboratory schema, compliance schema
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`critical_value` ADD CONSTRAINT `fk_laboratory_critical_value_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_result` ADD CONSTRAINT `fk_laboratory_bioanalytical_result_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_accreditation` ADD CONSTRAINT `fk_laboratory_lab_accreditation_compliance_capa_id` FOREIGN KEY (`compliance_capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_capa`(`compliance_capa_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_accreditation` ADD CONSTRAINT `fk_laboratory_lab_accreditation_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_query` ADD CONSTRAINT `fk_laboratory_lab_query_quality_event_id` FOREIGN KEY (`quality_event_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`quality_event`(`quality_event_id`);

-- ========= laboratory --> consent (5 constraint(s)) =========
-- Requires: laboratory schema, consent schema
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_collection` ADD CONSTRAINT `fk_laboratory_specimen_collection_consent_icf_version_id` FOREIGN KEY (`consent_icf_version_id`) REFERENCES `clinical_trials_ecm`.`consent`.`consent_icf_version`(`consent_icf_version_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_collection` ADD CONSTRAINT `fk_laboratory_specimen_collection_subject_consent_id` FOREIGN KEY (`subject_consent_id`) REFERENCES `clinical_trials_ecm`.`consent`.`subject_consent`(`subject_consent_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_result` ADD CONSTRAINT `fk_laboratory_bioanalytical_result_subject_consent_id` FOREIGN KEY (`subject_consent_id`) REFERENCES `clinical_trials_ecm`.`consent`.`subject_consent`(`subject_consent_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_aliquot` ADD CONSTRAINT `fk_laboratory_specimen_aliquot_subject_consent_id` FOREIGN KEY (`subject_consent_id`) REFERENCES `clinical_trials_ecm`.`consent`.`subject_consent`(`subject_consent_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_aliquot` ADD CONSTRAINT `fk_laboratory_specimen_aliquot_withdrawal_id` FOREIGN KEY (`withdrawal_id`) REFERENCES `clinical_trials_ecm`.`consent`.`withdrawal`(`withdrawal_id`);

-- ========= laboratory --> data (1 constraint(s)) =========
-- Requires: laboratory schema, data schema
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_collection` ADD CONSTRAINT `fk_laboratory_specimen_collection_ecrf_form_id` FOREIGN KEY (`ecrf_form_id`) REFERENCES `clinical_trials_ecm`.`data`.`ecrf_form`(`ecrf_form_id`);

-- ========= laboratory --> document (4 constraint(s)) =========
-- Requires: laboratory schema, document schema
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_panel` ADD CONSTRAINT `fk_laboratory_lab_panel_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_assay` ADD CONSTRAINT `fk_laboratory_bioanalytical_assay_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_assay` ADD CONSTRAINT `fk_laboratory_bioanalytical_assay_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_certification` ADD CONSTRAINT `fk_laboratory_lab_certification_tmf_artifact_id` FOREIGN KEY (`tmf_artifact_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_artifact`(`tmf_artifact_id`);

-- ========= laboratory --> finance (1 constraint(s)) =========
-- Requires: laboratory schema, finance schema
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_service_contract` ADD CONSTRAINT `fk_laboratory_lab_service_contract_study_budget_id` FOREIGN KEY (`study_budget_id`) REFERENCES `clinical_trials_ecm`.`finance`.`study_budget`(`study_budget_id`);

-- ========= laboratory --> program (2 constraint(s)) =========
-- Requires: laboratory schema, program schema
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_assay` ADD CONSTRAINT `fk_laboratory_bioanalytical_assay_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_qualification` ADD CONSTRAINT `fk_laboratory_lab_qualification_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);

-- ========= laboratory --> randomization (7 constraint(s)) =========
-- Requires: laboratory schema, randomization schema
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_result` ADD CONSTRAINT `fk_laboratory_lab_result_blinding_config_id` FOREIGN KEY (`blinding_config_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`blinding_config`(`blinding_config_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_result` ADD CONSTRAINT `fk_laboratory_lab_result_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_collection` ADD CONSTRAINT `fk_laboratory_specimen_collection_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`pk_sample` ADD CONSTRAINT `fk_laboratory_pk_sample_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_result` ADD CONSTRAINT `fk_laboratory_bioanalytical_result_blinding_config_id` FOREIGN KEY (`blinding_config_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`blinding_config`(`blinding_config_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_result` ADD CONSTRAINT `fk_laboratory_bioanalytical_result_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`protocol_lab_schedule` ADD CONSTRAINT `fk_laboratory_protocol_lab_schedule_rand_scheme_id` FOREIGN KEY (`rand_scheme_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_scheme`(`rand_scheme_id`);

-- ========= laboratory --> regulatory (8 constraint(s)) =========
-- Requires: laboratory schema, regulatory schema
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`reference_range` ADD CONSTRAINT `fk_laboratory_reference_range_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`critical_value` ADD CONSTRAINT `fk_laboratory_critical_value_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_assay` ADD CONSTRAINT `fk_laboratory_bioanalytical_assay_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_accreditation` ADD CONSTRAINT `fk_laboratory_lab_accreditation_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_accreditation` ADD CONSTRAINT `fk_laboratory_lab_accreditation_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`protocol_lab_schedule` ADD CONSTRAINT `fk_laboratory_protocol_lab_schedule_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_certification` ADD CONSTRAINT `fk_laboratory_lab_certification_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_certification` ADD CONSTRAINT `fk_laboratory_lab_certification_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);

-- ========= laboratory --> safety (7 constraint(s)) =========
-- Requires: laboratory schema, safety schema
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_result` ADD CONSTRAINT `fk_laboratory_lab_result_ctcae_grade_id` FOREIGN KEY (`ctcae_grade_id`) REFERENCES `clinical_trials_ecm`.`safety`.`ctcae_grade`(`ctcae_grade_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_collection` ADD CONSTRAINT `fk_laboratory_specimen_collection_adverse_event_id` FOREIGN KEY (`adverse_event_id`) REFERENCES `clinical_trials_ecm`.`safety`.`adverse_event`(`adverse_event_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`critical_value` ADD CONSTRAINT `fk_laboratory_critical_value_ctcae_grade_id` FOREIGN KEY (`ctcae_grade_id`) REFERENCES `clinical_trials_ecm`.`safety`.`ctcae_grade`(`ctcae_grade_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`critical_value` ADD CONSTRAINT `fk_laboratory_critical_value_meddra_term_id` FOREIGN KEY (`meddra_term_id`) REFERENCES `clinical_trials_ecm`.`safety`.`meddra_term`(`meddra_term_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`pk_sample` ADD CONSTRAINT `fk_laboratory_pk_sample_adverse_event_id` FOREIGN KEY (`adverse_event_id`) REFERENCES `clinical_trials_ecm`.`safety`.`adverse_event`(`adverse_event_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_query` ADD CONSTRAINT `fk_laboratory_lab_query_adverse_event_id` FOREIGN KEY (`adverse_event_id`) REFERENCES `clinical_trials_ecm`.`safety`.`adverse_event`(`adverse_event_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_analyte` ADD CONSTRAINT `fk_laboratory_lab_analyte_meddra_term_id` FOREIGN KEY (`meddra_term_id`) REFERENCES `clinical_trials_ecm`.`safety`.`meddra_term`(`meddra_term_id`);

-- ========= laboratory --> site (9 constraint(s)) =========
-- Requires: laboratory schema, site schema
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_result` ADD CONSTRAINT `fk_laboratory_lab_result_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_collection` ADD CONSTRAINT `fk_laboratory_specimen_collection_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_shipment` ADD CONSTRAINT `fk_laboratory_specimen_shipment_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`pk_sample` ADD CONSTRAINT `fk_laboratory_pk_sample_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_kit` ADD CONSTRAINT `fk_laboratory_lab_kit_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_query` ADD CONSTRAINT `fk_laboratory_lab_query_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_aliquot` ADD CONSTRAINT `fk_laboratory_specimen_aliquot_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`shipment_manifest` ADD CONSTRAINT `fk_laboratory_shipment_manifest_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);

-- ========= laboratory --> sponsor (6 constraint(s)) =========
-- Requires: laboratory schema, sponsor schema
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`reference_range` ADD CONSTRAINT `fk_laboratory_reference_range_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`critical_value` ADD CONSTRAINT `fk_laboratory_critical_value_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_assay` ADD CONSTRAINT `fk_laboratory_bioanalytical_assay_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_assay` ADD CONSTRAINT `fk_laboratory_bioanalytical_assay_pipeline_asset_id` FOREIGN KEY (`pipeline_asset_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`pipeline_asset`(`pipeline_asset_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_accreditation` ADD CONSTRAINT `fk_laboratory_lab_accreditation_master_agreement_id` FOREIGN KEY (`master_agreement_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`master_agreement`(`master_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_accreditation` ADD CONSTRAINT `fk_laboratory_lab_accreditation_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);

-- ========= laboratory --> study (33 constraint(s)) =========
-- Requires: laboratory schema, study schema
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_study_visit_schedule_id` FOREIGN KEY (`study_visit_schedule_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_visit_schedule`(`study_visit_schedule_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_result` ADD CONSTRAINT `fk_laboratory_lab_result_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_result` ADD CONSTRAINT `fk_laboratory_lab_result_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_result` ADD CONSTRAINT `fk_laboratory_lab_result_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_result` ADD CONSTRAINT `fk_laboratory_lab_result_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_result` ADD CONSTRAINT `fk_laboratory_lab_result_study_visit_schedule_id` FOREIGN KEY (`study_visit_schedule_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_visit_schedule`(`study_visit_schedule_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_collection` ADD CONSTRAINT `fk_laboratory_specimen_collection_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_collection` ADD CONSTRAINT `fk_laboratory_specimen_collection_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_collection` ADD CONSTRAINT `fk_laboratory_specimen_collection_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_collection` ADD CONSTRAINT `fk_laboratory_specimen_collection_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_collection` ADD CONSTRAINT `fk_laboratory_specimen_collection_study_visit_schedule_id` FOREIGN KEY (`study_visit_schedule_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_visit_schedule`(`study_visit_schedule_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_shipment` ADD CONSTRAINT `fk_laboratory_specimen_shipment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`reference_range` ADD CONSTRAINT `fk_laboratory_reference_range_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`reference_range` ADD CONSTRAINT `fk_laboratory_reference_range_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`pk_sample` ADD CONSTRAINT `fk_laboratory_pk_sample_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`pk_sample` ADD CONSTRAINT `fk_laboratory_pk_sample_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`pk_sample` ADD CONSTRAINT `fk_laboratory_pk_sample_pk_sampling_schedule_id` FOREIGN KEY (`pk_sampling_schedule_id`) REFERENCES `clinical_trials_ecm`.`study`.`pk_sampling_schedule`(`pk_sampling_schedule_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`pk_sample` ADD CONSTRAINT `fk_laboratory_pk_sample_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_assay` ADD CONSTRAINT `fk_laboratory_bioanalytical_assay_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `clinical_trials_ecm`.`study`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_result` ADD CONSTRAINT `fk_laboratory_bioanalytical_result_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_result` ADD CONSTRAINT `fk_laboratory_bioanalytical_result_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_result` ADD CONSTRAINT `fk_laboratory_bioanalytical_result_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_result` ADD CONSTRAINT `fk_laboratory_bioanalytical_result_study_visit_schedule_id` FOREIGN KEY (`study_visit_schedule_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_visit_schedule`(`study_visit_schedule_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_kit` ADD CONSTRAINT `fk_laboratory_lab_kit_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_kit` ADD CONSTRAINT `fk_laboratory_lab_kit_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_kit` ADD CONSTRAINT `fk_laboratory_lab_kit_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_query` ADD CONSTRAINT `fk_laboratory_lab_query_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_aliquot` ADD CONSTRAINT `fk_laboratory_specimen_aliquot_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`protocol_lab_schedule` ADD CONSTRAINT `fk_laboratory_protocol_lab_schedule_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`protocol_lab_schedule` ADD CONSTRAINT `fk_laboratory_protocol_lab_schedule_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`protocol_lab_schedule` ADD CONSTRAINT `fk_laboratory_protocol_lab_schedule_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`protocol_lab_schedule` ADD CONSTRAINT `fk_laboratory_protocol_lab_schedule_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`shipment_manifest` ADD CONSTRAINT `fk_laboratory_shipment_manifest_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);

-- ========= laboratory --> subject (13 constraint(s)) =========
-- Requires: laboratory schema, subject schema
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_result` ADD CONSTRAINT `fk_laboratory_lab_result_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_result` ADD CONSTRAINT `fk_laboratory_lab_result_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_collection` ADD CONSTRAINT `fk_laboratory_specimen_collection_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_collection` ADD CONSTRAINT `fk_laboratory_specimen_collection_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`pk_sample` ADD CONSTRAINT `fk_laboratory_pk_sample_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`pk_sample` ADD CONSTRAINT `fk_laboratory_pk_sample_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_result` ADD CONSTRAINT `fk_laboratory_bioanalytical_result_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_query` ADD CONSTRAINT `fk_laboratory_lab_query_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_query` ADD CONSTRAINT `fk_laboratory_lab_query_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_aliquot` ADD CONSTRAINT `fk_laboratory_specimen_aliquot_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_aliquot` ADD CONSTRAINT `fk_laboratory_specimen_aliquot_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);

-- ========= laboratory --> supply (6 constraint(s)) =========
-- Requires: laboratory schema, supply schema
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `clinical_trials_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`pk_sample` ADD CONSTRAINT `fk_laboratory_pk_sample_manufacture_batch_id` FOREIGN KEY (`manufacture_batch_id`) REFERENCES `clinical_trials_ecm`.`supply`.`manufacture_batch`(`manufacture_batch_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`pk_sample` ADD CONSTRAINT `fk_laboratory_pk_sample_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `clinical_trials_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_assay` ADD CONSTRAINT `fk_laboratory_bioanalytical_assay_imp_master_id` FOREIGN KEY (`imp_master_id`) REFERENCES `clinical_trials_ecm`.`supply`.`imp_master`(`imp_master_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_result` ADD CONSTRAINT `fk_laboratory_bioanalytical_result_manufacture_batch_id` FOREIGN KEY (`manufacture_batch_id`) REFERENCES `clinical_trials_ecm`.`supply`.`manufacture_batch`(`manufacture_batch_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_aliquot` ADD CONSTRAINT `fk_laboratory_specimen_aliquot_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `clinical_trials_ecm`.`supply`.`shipment`(`shipment_id`);

-- ========= laboratory --> workforce (12 constraint(s)) =========
-- Requires: laboratory schema, workforce schema
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`specimen_collection` ADD CONSTRAINT `fk_laboratory_specimen_collection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`reference_range` ADD CONSTRAINT `fk_laboratory_reference_range_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`critical_value` ADD CONSTRAINT `fk_laboratory_critical_value_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`pk_sample` ADD CONSTRAINT `fk_laboratory_pk_sample_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`bioanalytical_assay` ADD CONSTRAINT `fk_laboratory_bioanalytical_assay_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_accreditation` ADD CONSTRAINT `fk_laboratory_lab_accreditation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_kit` ADD CONSTRAINT `fk_laboratory_lab_kit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_query` ADD CONSTRAINT `fk_laboratory_lab_query_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_query` ADD CONSTRAINT `fk_laboratory_lab_query_quaternary_lab_resolved_by_user_employee_id` FOREIGN KEY (`quaternary_lab_resolved_by_user_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_query` ADD CONSTRAINT `fk_laboratory_lab_query_tertiary_lab_responded_by_user_employee_id` FOREIGN KEY (`tertiary_lab_responded_by_user_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`laboratory`.`lab_certification` ADD CONSTRAINT `fk_laboratory_lab_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= monitoring --> agreement (9 constraint(s)) =========
-- Requires: monitoring schema, agreement schema
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_visit` ADD CONSTRAINT `fk_monitoring_monitoring_visit_service_level_agreement_id` FOREIGN KEY (`service_level_agreement_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`service_level_agreement`(`service_level_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_report` ADD CONSTRAINT `fk_monitoring_visit_report_service_level_agreement_id` FOREIGN KEY (`service_level_agreement_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`service_level_agreement`(`service_level_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`risk_indicator` ADD CONSTRAINT `fk_monitoring_risk_indicator_service_level_agreement_id` FOREIGN KEY (`service_level_agreement_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`service_level_agreement`(`service_level_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`site_risk_assessment` ADD CONSTRAINT `fk_monitoring_site_risk_assessment_investigator_grant_id` FOREIGN KEY (`investigator_grant_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`investigator_grant`(`investigator_grant_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_cra_assignment` ADD CONSTRAINT `fk_monitoring_monitoring_cra_assignment_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`rate_card`(`rate_card_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_cra_assignment` ADD CONSTRAINT `fk_monitoring_monitoring_cra_assignment_scope_of_work_id` FOREIGN KEY (`scope_of_work_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`scope_of_work`(`scope_of_work_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_cra_assignment` ADD CONSTRAINT `fk_monitoring_monitoring_cra_assignment_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`subcontract`(`subcontract_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`ip_accountability_log` ADD CONSTRAINT `fk_monitoring_ip_accountability_log_investigator_grant_id` FOREIGN KEY (`investigator_grant_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`investigator_grant`(`investigator_grant_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`escalation_record` ADD CONSTRAINT `fk_monitoring_escalation_record_contract_obligation_id` FOREIGN KEY (`contract_obligation_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`contract_obligation`(`contract_obligation_id`);

-- ========= monitoring --> biostatistics (2 constraint(s)) =========
-- Requires: monitoring schema, biostatistics schema
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`risk_indicator` ADD CONSTRAINT `fk_monitoring_risk_indicator_statistical_endpoint_id` FOREIGN KEY (`statistical_endpoint_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`statistical_endpoint`(`statistical_endpoint_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`central_monitoring_alert` ADD CONSTRAINT `fk_monitoring_central_monitoring_alert_statistical_endpoint_id` FOREIGN KEY (`statistical_endpoint_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`statistical_endpoint`(`statistical_endpoint_id`);

-- ========= monitoring --> compliance (22 constraint(s)) =========
-- Requires: monitoring schema, compliance schema
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_plan` ADD CONSTRAINT `fk_monitoring_monitoring_plan_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_compliance_capa_id` FOREIGN KEY (`compliance_capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_capa`(`compliance_capa_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_deviation_finding` ADD CONSTRAINT `fk_monitoring_visit_deviation_finding_compliance_capa_id` FOREIGN KEY (`compliance_capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_capa`(`compliance_capa_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_deviation_finding` ADD CONSTRAINT `fk_monitoring_visit_deviation_finding_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_deviation_finding` ADD CONSTRAINT `fk_monitoring_visit_deviation_finding_deviation_classification_id` FOREIGN KEY (`deviation_classification_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`deviation_classification`(`deviation_classification_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_compliance_capa_id` FOREIGN KEY (`compliance_capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_capa`(`compliance_capa_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_action_item` ADD CONSTRAINT `fk_monitoring_monitoring_action_item_compliance_capa_id` FOREIGN KEY (`compliance_capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_capa`(`compliance_capa_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_action_item` ADD CONSTRAINT `fk_monitoring_monitoring_action_item_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`risk_indicator` ADD CONSTRAINT `fk_monitoring_risk_indicator_compliance_capa_id` FOREIGN KEY (`compliance_capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_capa`(`compliance_capa_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`risk_indicator` ADD CONSTRAINT `fk_monitoring_risk_indicator_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`site_risk_assessment` ADD CONSTRAINT `fk_monitoring_site_risk_assessment_compliance_capa_id` FOREIGN KEY (`compliance_capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_capa`(`compliance_capa_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`site_risk_assessment` ADD CONSTRAINT `fk_monitoring_site_risk_assessment_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_cra_assignment` ADD CONSTRAINT `fk_monitoring_monitoring_cra_assignment_compliance_capa_id` FOREIGN KEY (`compliance_capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_capa`(`compliance_capa_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`ip_accountability_log` ADD CONSTRAINT `fk_monitoring_ip_accountability_log_compliance_capa_id` FOREIGN KEY (`compliance_capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_capa`(`compliance_capa_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`escalation_record` ADD CONSTRAINT `fk_monitoring_escalation_record_compliance_capa_id` FOREIGN KEY (`compliance_capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_capa`(`compliance_capa_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`escalation_record` ADD CONSTRAINT `fk_monitoring_escalation_record_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_checklist` ADD CONSTRAINT `fk_monitoring_visit_checklist_compliance_capa_id` FOREIGN KEY (`compliance_capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_capa`(`compliance_capa_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_checklist` ADD CONSTRAINT `fk_monitoring_visit_checklist_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`central_monitoring_alert` ADD CONSTRAINT `fk_monitoring_central_monitoring_alert_compliance_capa_id` FOREIGN KEY (`compliance_capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_capa`(`compliance_capa_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`central_monitoring_alert` ADD CONSTRAINT `fk_monitoring_central_monitoring_alert_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);

-- ========= monitoring --> consent (8 constraint(s)) =========
-- Requires: monitoring schema, consent schema
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_report` ADD CONSTRAINT `fk_monitoring_visit_report_consent_icf_version_id` FOREIGN KEY (`consent_icf_version_id`) REFERENCES `clinical_trials_ecm`.`consent`.`consent_icf_version`(`consent_icf_version_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_subject_consent_id` FOREIGN KEY (`subject_consent_id`) REFERENCES `clinical_trials_ecm`.`consent`.`subject_consent`(`subject_consent_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_subject_consent_id` FOREIGN KEY (`subject_consent_id`) REFERENCES `clinical_trials_ecm`.`consent`.`subject_consent`(`subject_consent_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_visit_schedule` ADD CONSTRAINT `fk_monitoring_monitoring_visit_schedule_reconsent_trigger_id` FOREIGN KEY (`reconsent_trigger_id`) REFERENCES `clinical_trials_ecm`.`consent`.`reconsent_trigger`(`reconsent_trigger_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`escalation_record` ADD CONSTRAINT `fk_monitoring_escalation_record_consent_deviation_id` FOREIGN KEY (`consent_deviation_id`) REFERENCES `clinical_trials_ecm`.`consent`.`consent_deviation`(`consent_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`escalation_record` ADD CONSTRAINT `fk_monitoring_escalation_record_reconsent_trigger_id` FOREIGN KEY (`reconsent_trigger_id`) REFERENCES `clinical_trials_ecm`.`consent`.`reconsent_trigger`(`reconsent_trigger_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_checklist` ADD CONSTRAINT `fk_monitoring_visit_checklist_consent_icf_version_id` FOREIGN KEY (`consent_icf_version_id`) REFERENCES `clinical_trials_ecm`.`consent`.`consent_icf_version`(`consent_icf_version_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`central_monitoring_alert` ADD CONSTRAINT `fk_monitoring_central_monitoring_alert_consent_deviation_id` FOREIGN KEY (`consent_deviation_id`) REFERENCES `clinical_trials_ecm`.`consent`.`consent_deviation`(`consent_deviation_id`);

-- ========= monitoring --> data (6 constraint(s)) =========
-- Requires: monitoring schema, data schema
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_discrepancy_query_id` FOREIGN KEY (`discrepancy_query_id`) REFERENCES `clinical_trials_ecm`.`data`.`discrepancy_query`(`discrepancy_query_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_ecrf_field_id` FOREIGN KEY (`ecrf_field_id`) REFERENCES `clinical_trials_ecm`.`data`.`ecrf_field`(`ecrf_field_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_ecrf_form_id` FOREIGN KEY (`ecrf_form_id`) REFERENCES `clinical_trials_ecm`.`data`.`ecrf_form`(`ecrf_form_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_field_entry_id` FOREIGN KEY (`field_entry_id`) REFERENCES `clinical_trials_ecm`.`data`.`field_entry`(`field_entry_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_subject_visit_data_id` FOREIGN KEY (`subject_visit_data_id`) REFERENCES `clinical_trials_ecm`.`data`.`subject_visit_data`(`subject_visit_data_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_discrepancy_query_id` FOREIGN KEY (`discrepancy_query_id`) REFERENCES `clinical_trials_ecm`.`data`.`discrepancy_query`(`discrepancy_query_id`);

-- ========= monitoring --> document (12 constraint(s)) =========
-- Requires: monitoring schema, document schema
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_visit` ADD CONSTRAINT `fk_monitoring_monitoring_visit_document_icf_version_id` FOREIGN KEY (`document_icf_version_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_icf_version`(`document_icf_version_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_report` ADD CONSTRAINT `fk_monitoring_visit_report_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_deviation_finding` ADD CONSTRAINT `fk_monitoring_visit_deviation_finding_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`site_risk_assessment` ADD CONSTRAINT `fk_monitoring_site_risk_assessment_inspection_readiness_id` FOREIGN KEY (`inspection_readiness_id`) REFERENCES `clinical_trials_ecm`.`document`.`inspection_readiness`(`inspection_readiness_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`site_risk_assessment` ADD CONSTRAINT `fk_monitoring_site_risk_assessment_tmf_completeness_id` FOREIGN KEY (`tmf_completeness_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_completeness`(`tmf_completeness_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`ip_accountability_log` ADD CONSTRAINT `fk_monitoring_ip_accountability_log_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`escalation_record` ADD CONSTRAINT `fk_monitoring_escalation_record_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_checklist` ADD CONSTRAINT `fk_monitoring_visit_checklist_template_id` FOREIGN KEY (`template_id`) REFERENCES `clinical_trials_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_checklist` ADD CONSTRAINT `fk_monitoring_visit_checklist_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`central_monitoring_alert` ADD CONSTRAINT `fk_monitoring_central_monitoring_alert_tmf_completeness_id` FOREIGN KEY (`tmf_completeness_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_completeness`(`tmf_completeness_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`checklist_item` ADD CONSTRAINT `fk_monitoring_checklist_item_template_id` FOREIGN KEY (`template_id`) REFERENCES `clinical_trials_ecm`.`document`.`template`(`template_id`);

-- ========= monitoring --> finance (1 constraint(s)) =========
-- Requires: monitoring schema, finance schema
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_cra_assignment` ADD CONSTRAINT `fk_monitoring_monitoring_cra_assignment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `clinical_trials_ecm`.`finance`.`purchase_order`(`purchase_order_id`);

-- ========= monitoring --> laboratory (7 constraint(s)) =========
-- Requires: monitoring schema, laboratory schema
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_lab_result_id` FOREIGN KEY (`lab_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_result`(`lab_result_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_specimen_collection_id` FOREIGN KEY (`specimen_collection_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`specimen_collection`(`specimen_collection_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_deviation_finding` ADD CONSTRAINT `fk_monitoring_visit_deviation_finding_lab_result_id` FOREIGN KEY (`lab_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_result`(`lab_result_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_lab_result_id` FOREIGN KEY (`lab_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_result`(`lab_result_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`risk_indicator` ADD CONSTRAINT `fk_monitoring_risk_indicator_lab_panel_id` FOREIGN KEY (`lab_panel_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_panel`(`lab_panel_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`site_risk_assessment` ADD CONSTRAINT `fk_monitoring_site_risk_assessment_lab_facility_id` FOREIGN KEY (`lab_facility_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_facility`(`lab_facility_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`escalation_record` ADD CONSTRAINT `fk_monitoring_escalation_record_lab_result_id` FOREIGN KEY (`lab_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_result`(`lab_result_id`);

-- ========= monitoring --> program (11 constraint(s)) =========
-- Requires: monitoring schema, program schema
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_plan` ADD CONSTRAINT `fk_monitoring_monitoring_plan_program_plan_id` FOREIGN KEY (`program_plan_id`) REFERENCES `clinical_trials_ecm`.`program`.`program_plan`(`program_plan_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_visit` ADD CONSTRAINT `fk_monitoring_monitoring_visit_program_milestone_id` FOREIGN KEY (`program_milestone_id`) REFERENCES `clinical_trials_ecm`.`program`.`program_milestone`(`program_milestone_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`risk_indicator` ADD CONSTRAINT `fk_monitoring_risk_indicator_kri_id` FOREIGN KEY (`kri_id`) REFERENCES `clinical_trials_ecm`.`program`.`kri`(`kri_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`risk_indicator` ADD CONSTRAINT `fk_monitoring_risk_indicator_risk_id` FOREIGN KEY (`risk_id`) REFERENCES `clinical_trials_ecm`.`program`.`risk`(`risk_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`site_risk_assessment` ADD CONSTRAINT `fk_monitoring_site_risk_assessment_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`site_risk_assessment` ADD CONSTRAINT `fk_monitoring_site_risk_assessment_risk_id` FOREIGN KEY (`risk_id`) REFERENCES `clinical_trials_ecm`.`program`.`risk`(`risk_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_cra_assignment` ADD CONSTRAINT `fk_monitoring_monitoring_cra_assignment_program_resource_plan_id` FOREIGN KEY (`program_resource_plan_id`) REFERENCES `clinical_trials_ecm`.`program`.`program_resource_plan`(`program_resource_plan_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_visit_schedule` ADD CONSTRAINT `fk_monitoring_monitoring_visit_schedule_timeline_id` FOREIGN KEY (`timeline_id`) REFERENCES `clinical_trials_ecm`.`program`.`timeline`(`timeline_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`escalation_record` ADD CONSTRAINT `fk_monitoring_escalation_record_decision_id` FOREIGN KEY (`decision_id`) REFERENCES `clinical_trials_ecm`.`program`.`decision`(`decision_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`escalation_record` ADD CONSTRAINT `fk_monitoring_escalation_record_governance_id` FOREIGN KEY (`governance_id`) REFERENCES `clinical_trials_ecm`.`program`.`governance`(`governance_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`central_monitoring_alert` ADD CONSTRAINT `fk_monitoring_central_monitoring_alert_risk_id` FOREIGN KEY (`risk_id`) REFERENCES `clinical_trials_ecm`.`program`.`risk`(`risk_id`);

-- ========= monitoring --> randomization (6 constraint(s)) =========
-- Requires: monitoring schema, randomization schema
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_rand_deviation_id` FOREIGN KEY (`rand_deviation_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_deviation`(`rand_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_cra_assignment` ADD CONSTRAINT `fk_monitoring_monitoring_cra_assignment_blinding_config_id` FOREIGN KEY (`blinding_config_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`blinding_config`(`blinding_config_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`ip_accountability_log` ADD CONSTRAINT `fk_monitoring_ip_accountability_log_kit_assignment_id` FOREIGN KEY (`kit_assignment_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`kit_assignment`(`kit_assignment_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`escalation_record` ADD CONSTRAINT `fk_monitoring_escalation_record_unblinding_request_id` FOREIGN KEY (`unblinding_request_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`unblinding_request`(`unblinding_request_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`central_monitoring_alert` ADD CONSTRAINT `fk_monitoring_central_monitoring_alert_rand_deviation_id` FOREIGN KEY (`rand_deviation_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_deviation`(`rand_deviation_id`);

-- ========= monitoring --> regulatory (15 constraint(s)) =========
-- Requires: monitoring schema, regulatory schema
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_plan` ADD CONSTRAINT `fk_monitoring_monitoring_plan_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_plan` ADD CONSTRAINT `fk_monitoring_monitoring_plan_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_plan` ADD CONSTRAINT `fk_monitoring_monitoring_plan_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`strategy`(`strategy_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_visit` ADD CONSTRAINT `fk_monitoring_monitoring_visit_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_visit` ADD CONSTRAINT `fk_monitoring_monitoring_visit_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_report` ADD CONSTRAINT `fk_monitoring_visit_report_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_deviation_finding` ADD CONSTRAINT `fk_monitoring_visit_deviation_finding_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`site_risk_assessment` ADD CONSTRAINT `fk_monitoring_site_risk_assessment_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_cra_assignment` ADD CONSTRAINT `fk_monitoring_monitoring_cra_assignment_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`ip_accountability_log` ADD CONSTRAINT `fk_monitoring_ip_accountability_log_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`escalation_record` ADD CONSTRAINT `fk_monitoring_escalation_record_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`escalation_record` ADD CONSTRAINT `fk_monitoring_escalation_record_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`escalation_record` ADD CONSTRAINT `fk_monitoring_escalation_record_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`central_monitoring_alert` ADD CONSTRAINT `fk_monitoring_central_monitoring_alert_safety_report_submission_id` FOREIGN KEY (`safety_report_submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`safety_report_submission`(`safety_report_submission_id`);

-- ========= monitoring --> safety (6 constraint(s)) =========
-- Requires: monitoring schema, safety schema
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_adverse_event_id` FOREIGN KEY (`adverse_event_id`) REFERENCES `clinical_trials_ecm`.`safety`.`adverse_event`(`adverse_event_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_deviation_finding` ADD CONSTRAINT `fk_monitoring_visit_deviation_finding_adverse_event_id` FOREIGN KEY (`adverse_event_id`) REFERENCES `clinical_trials_ecm`.`safety`.`adverse_event`(`adverse_event_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_adverse_event_id` FOREIGN KEY (`adverse_event_id`) REFERENCES `clinical_trials_ecm`.`safety`.`adverse_event`(`adverse_event_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`escalation_record` ADD CONSTRAINT `fk_monitoring_escalation_record_adverse_event_id` FOREIGN KEY (`adverse_event_id`) REFERENCES `clinical_trials_ecm`.`safety`.`adverse_event`(`adverse_event_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`escalation_record` ADD CONSTRAINT `fk_monitoring_escalation_record_susar_id` FOREIGN KEY (`susar_id`) REFERENCES `clinical_trials_ecm`.`safety`.`susar`(`susar_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`central_monitoring_alert` ADD CONSTRAINT `fk_monitoring_central_monitoring_alert_signal_id` FOREIGN KEY (`signal_id`) REFERENCES `clinical_trials_ecm`.`safety`.`signal`(`signal_id`);

-- ========= monitoring --> site (15 constraint(s)) =========
-- Requires: monitoring schema, site schema
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_visit` ADD CONSTRAINT `fk_monitoring_monitoring_visit_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_report` ADD CONSTRAINT `fk_monitoring_visit_report_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_deviation_finding` ADD CONSTRAINT `fk_monitoring_visit_deviation_finding_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_action_item` ADD CONSTRAINT `fk_monitoring_monitoring_action_item_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`risk_indicator` ADD CONSTRAINT `fk_monitoring_risk_indicator_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`site_risk_assessment` ADD CONSTRAINT `fk_monitoring_site_risk_assessment_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`site_risk_assessment` ADD CONSTRAINT `fk_monitoring_site_risk_assessment_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_cra_assignment` ADD CONSTRAINT `fk_monitoring_monitoring_cra_assignment_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_visit_schedule` ADD CONSTRAINT `fk_monitoring_monitoring_visit_schedule_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`ip_accountability_log` ADD CONSTRAINT `fk_monitoring_ip_accountability_log_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`escalation_record` ADD CONSTRAINT `fk_monitoring_escalation_record_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_checklist` ADD CONSTRAINT `fk_monitoring_visit_checklist_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`central_monitoring_alert` ADD CONSTRAINT `fk_monitoring_central_monitoring_alert_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);

-- ========= monitoring --> sponsor (9 constraint(s)) =========
-- Requires: monitoring schema, sponsor schema
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_plan` ADD CONSTRAINT `fk_monitoring_monitoring_plan_delivery_preference_id` FOREIGN KEY (`delivery_preference_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`delivery_preference`(`delivery_preference_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_plan` ADD CONSTRAINT `fk_monitoring_monitoring_plan_master_agreement_id` FOREIGN KEY (`master_agreement_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`master_agreement`(`master_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_plan` ADD CONSTRAINT `fk_monitoring_monitoring_plan_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_plan` ADD CONSTRAINT `fk_monitoring_monitoring_plan_sponsor_contact_id` FOREIGN KEY (`sponsor_contact_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`sponsor_contact`(`sponsor_contact_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_plan` ADD CONSTRAINT `fk_monitoring_monitoring_plan_regulatory_strategy_id` FOREIGN KEY (`regulatory_strategy_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`regulatory_strategy`(`regulatory_strategy_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_plan` ADD CONSTRAINT `fk_monitoring_monitoring_plan_study_portfolio_id` FOREIGN KEY (`study_portfolio_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`study_portfolio`(`study_portfolio_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`escalation_record` ADD CONSTRAINT `fk_monitoring_escalation_record_sponsor_contact_id` FOREIGN KEY (`sponsor_contact_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`sponsor_contact`(`sponsor_contact_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`escalation_record` ADD CONSTRAINT `fk_monitoring_escalation_record_escalation_id` FOREIGN KEY (`escalation_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`escalation`(`escalation_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`central_monitoring_alert` ADD CONSTRAINT `fk_monitoring_central_monitoring_alert_sponsor_contact_id` FOREIGN KEY (`sponsor_contact_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`sponsor_contact`(`sponsor_contact_id`);

-- ========= monitoring --> study (20 constraint(s)) =========
-- Requires: monitoring schema, study schema
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_visit` ADD CONSTRAINT `fk_monitoring_monitoring_visit_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_report` ADD CONSTRAINT `fk_monitoring_visit_report_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_study_visit_schedule_id` FOREIGN KEY (`study_visit_schedule_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_visit_schedule`(`study_visit_schedule_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_visit_procedure_id` FOREIGN KEY (`visit_procedure_id`) REFERENCES `clinical_trials_ecm`.`study`.`visit_procedure`(`visit_procedure_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_deviation_finding` ADD CONSTRAINT `fk_monitoring_visit_deviation_finding_eligibility_criterion_id` FOREIGN KEY (`eligibility_criterion_id`) REFERENCES `clinical_trials_ecm`.`study`.`eligibility_criterion`(`eligibility_criterion_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_eligibility_criterion_id` FOREIGN KEY (`eligibility_criterion_id`) REFERENCES `clinical_trials_ecm`.`study`.`eligibility_criterion`(`eligibility_criterion_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_action_item` ADD CONSTRAINT `fk_monitoring_monitoring_action_item_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`risk_indicator` ADD CONSTRAINT `fk_monitoring_risk_indicator_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`site_risk_assessment` ADD CONSTRAINT `fk_monitoring_site_risk_assessment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_cra_assignment` ADD CONSTRAINT `fk_monitoring_monitoring_cra_assignment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_visit_schedule` ADD CONSTRAINT `fk_monitoring_monitoring_visit_schedule_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_visit_schedule` ADD CONSTRAINT `fk_monitoring_monitoring_visit_schedule_study_milestone_id` FOREIGN KEY (`study_milestone_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_milestone`(`study_milestone_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`ip_accountability_log` ADD CONSTRAINT `fk_monitoring_ip_accountability_log_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `clinical_trials_ecm`.`study`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`ip_accountability_log` ADD CONSTRAINT `fk_monitoring_ip_accountability_log_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`escalation_record` ADD CONSTRAINT `fk_monitoring_escalation_record_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_checklist` ADD CONSTRAINT `fk_monitoring_visit_checklist_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_checklist` ADD CONSTRAINT `fk_monitoring_visit_checklist_study_visit_schedule_id` FOREIGN KEY (`study_visit_schedule_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_visit_schedule`(`study_visit_schedule_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`central_monitoring_alert` ADD CONSTRAINT `fk_monitoring_central_monitoring_alert_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);

-- ========= monitoring --> subject (9 constraint(s)) =========
-- Requires: monitoring schema, subject schema
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_deviation_finding` ADD CONSTRAINT `fk_monitoring_visit_deviation_finding_subject_deviation_id` FOREIGN KEY (`subject_deviation_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_deviation`(`subject_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_deviation_finding` ADD CONSTRAINT `fk_monitoring_visit_deviation_finding_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_deviation_finding` ADD CONSTRAINT `fk_monitoring_visit_deviation_finding_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_subject_deviation_id` FOREIGN KEY (`subject_deviation_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_deviation`(`subject_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_action_item` ADD CONSTRAINT `fk_monitoring_monitoring_action_item_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`escalation_record` ADD CONSTRAINT `fk_monitoring_escalation_record_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);

-- ========= monitoring --> supply (4 constraint(s)) =========
-- Requires: monitoring schema, supply schema
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_temperature_excursion_id` FOREIGN KEY (`temperature_excursion_id`) REFERENCES `clinical_trials_ecm`.`supply`.`temperature_excursion`(`temperature_excursion_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`ip_accountability_log` ADD CONSTRAINT `fk_monitoring_ip_accountability_log_accountability_reconciliation_id` FOREIGN KEY (`accountability_reconciliation_id`) REFERENCES `clinical_trials_ecm`.`supply`.`accountability_reconciliation`(`accountability_reconciliation_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`ip_accountability_log` ADD CONSTRAINT `fk_monitoring_ip_accountability_log_destruction_record_id` FOREIGN KEY (`destruction_record_id`) REFERENCES `clinical_trials_ecm`.`supply`.`destruction_record`(`destruction_record_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`ip_accountability_log` ADD CONSTRAINT `fk_monitoring_ip_accountability_log_kit_inventory_id` FOREIGN KEY (`kit_inventory_id`) REFERENCES `clinical_trials_ecm`.`supply`.`kit_inventory`(`kit_inventory_id`);

-- ========= monitoring --> workforce (20 constraint(s)) =========
-- Requires: monitoring schema, workforce schema
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_plan` ADD CONSTRAINT `fk_monitoring_monitoring_plan_training_curriculum_id` FOREIGN KEY (`training_curriculum_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`training_curriculum`(`training_curriculum_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_visit` ADD CONSTRAINT `fk_monitoring_monitoring_visit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_report` ADD CONSTRAINT `fk_monitoring_visit_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`sdv_record` ADD CONSTRAINT `fk_monitoring_sdv_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_deviation_finding` ADD CONSTRAINT `fk_monitoring_visit_deviation_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_finding` ADD CONSTRAINT `fk_monitoring_visit_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_action_item` ADD CONSTRAINT `fk_monitoring_monitoring_action_item_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_action_item` ADD CONSTRAINT `fk_monitoring_monitoring_action_item_quaternary_monitoring_escalated_to_user_employee_id` FOREIGN KEY (`quaternary_monitoring_escalated_to_user_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_action_item` ADD CONSTRAINT `fk_monitoring_monitoring_action_item_tertiary_monitoring_closure_confirmed_by_user_employee_id` FOREIGN KEY (`tertiary_monitoring_closure_confirmed_by_user_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`site_risk_assessment` ADD CONSTRAINT `fk_monitoring_site_risk_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`site_risk_assessment` ADD CONSTRAINT `fk_monitoring_site_risk_assessment_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_cra_assignment` ADD CONSTRAINT `fk_monitoring_monitoring_cra_assignment_cra_qualification_id` FOREIGN KEY (`cra_qualification_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`cra_qualification`(`cra_qualification_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_cra_assignment` ADD CONSTRAINT `fk_monitoring_monitoring_cra_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_cra_assignment` ADD CONSTRAINT `fk_monitoring_monitoring_cra_assignment_protocol_training_record_id` FOREIGN KEY (`protocol_training_record_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`protocol_training_record`(`protocol_training_record_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_cra_assignment` ADD CONSTRAINT `fk_monitoring_monitoring_cra_assignment_study_assignment_id` FOREIGN KEY (`study_assignment_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`study_assignment`(`study_assignment_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`monitoring_visit_schedule` ADD CONSTRAINT `fk_monitoring_monitoring_visit_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`ip_accountability_log` ADD CONSTRAINT `fk_monitoring_ip_accountability_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`escalation_record` ADD CONSTRAINT `fk_monitoring_escalation_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`visit_checklist` ADD CONSTRAINT `fk_monitoring_visit_checklist_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`monitoring`.`central_monitoring_alert` ADD CONSTRAINT `fk_monitoring_central_monitoring_alert_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= program --> agreement (1 constraint(s)) =========
-- Requires: program schema, agreement schema
ALTER TABLE `clinical_trials_ecm`.`program`.`governance` ADD CONSTRAINT `fk_program_governance_preferred_provider_agreement_id` FOREIGN KEY (`preferred_provider_agreement_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`preferred_provider_agreement`(`preferred_provider_agreement_id`);

-- ========= program --> biostatistics (3 constraint(s)) =========
-- Requires: program schema, biostatistics schema
ALTER TABLE `clinical_trials_ecm`.`program`.`decision` ADD CONSTRAINT `fk_program_decision_dsmb_meeting_id` FOREIGN KEY (`dsmb_meeting_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`dsmb_meeting`(`dsmb_meeting_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`decision` ADD CONSTRAINT `fk_program_decision_interim_analysis_id` FOREIGN KEY (`interim_analysis_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`interim_analysis`(`interim_analysis_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`timeline_event` ADD CONSTRAINT `fk_program_timeline_event_interim_analysis_id` FOREIGN KEY (`interim_analysis_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`interim_analysis`(`interim_analysis_id`);

-- ========= program --> compliance (5 constraint(s)) =========
-- Requires: program schema, compliance schema
ALTER TABLE `clinical_trials_ecm`.`program`.`decision` ADD CONSTRAINT `fk_program_decision_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`risk_mitigation` ADD CONSTRAINT `fk_program_risk_mitigation_compliance_capa_id` FOREIGN KEY (`compliance_capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_capa`(`compliance_capa_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`risk_mitigation` ADD CONSTRAINT `fk_program_risk_mitigation_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`program_status_history` ADD CONSTRAINT `fk_program_program_status_history_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`kri` ADD CONSTRAINT `fk_program_kri_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`obligation`(`obligation_id`);

-- ========= program --> document (4 constraint(s)) =========
-- Requires: program schema, document schema
ALTER TABLE `clinical_trials_ecm`.`program`.`amendment` ADD CONSTRAINT `fk_program_amendment_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`governance_meeting` ADD CONSTRAINT `fk_program_governance_meeting_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`decision` ADD CONSTRAINT `fk_program_decision_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`program_communication` ADD CONSTRAINT `fk_program_program_communication_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);

-- ========= program --> finance (5 constraint(s)) =========
-- Requires: program schema, finance schema
ALTER TABLE `clinical_trials_ecm`.`program`.`decision` ADD CONSTRAINT `fk_program_decision_study_budget_id` FOREIGN KEY (`study_budget_id`) REFERENCES `clinical_trials_ecm`.`finance`.`study_budget`(`study_budget_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`program_resource_plan` ADD CONSTRAINT `fk_program_program_resource_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `clinical_trials_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`budget` ADD CONSTRAINT `fk_program_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `clinical_trials_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`budget` ADD CONSTRAINT `fk_program_budget_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `clinical_trials_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`team_member` ADD CONSTRAINT `fk_program_team_member_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `clinical_trials_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= program --> regulatory (1 constraint(s)) =========
-- Requires: program schema, regulatory schema
ALTER TABLE `clinical_trials_ecm`.`program`.`decision` ADD CONSTRAINT `fk_program_decision_application_id` FOREIGN KEY (`application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`application`(`application_id`);

-- ========= program --> safety (3 constraint(s)) =========
-- Requires: program schema, safety schema
ALTER TABLE `clinical_trials_ecm`.`program`.`decision` ADD CONSTRAINT `fk_program_decision_signal_id` FOREIGN KEY (`signal_id`) REFERENCES `clinical_trials_ecm`.`safety`.`signal`(`signal_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`program_status_history` ADD CONSTRAINT `fk_program_program_status_history_signal_id` FOREIGN KEY (`signal_id`) REFERENCES `clinical_trials_ecm`.`safety`.`signal`(`signal_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`program_communication` ADD CONSTRAINT `fk_program_program_communication_signal_id` FOREIGN KEY (`signal_id`) REFERENCES `clinical_trials_ecm`.`safety`.`signal`(`signal_id`);

-- ========= program --> sponsor (18 constraint(s)) =========
-- Requires: program schema, sponsor schema
ALTER TABLE `clinical_trials_ecm`.`program`.`clinical_program` ADD CONSTRAINT `fk_program_clinical_program_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`clinical_program` ADD CONSTRAINT `fk_program_clinical_program_pipeline_asset_id` FOREIGN KEY (`pipeline_asset_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`pipeline_asset`(`pipeline_asset_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`program_plan` ADD CONSTRAINT `fk_program_program_plan_master_agreement_id` FOREIGN KEY (`master_agreement_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`master_agreement`(`master_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`program_plan` ADD CONSTRAINT `fk_program_program_plan_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`amendment` ADD CONSTRAINT `fk_program_amendment_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`governance` ADD CONSTRAINT `fk_program_governance_master_agreement_id` FOREIGN KEY (`master_agreement_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`master_agreement`(`master_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`governance` ADD CONSTRAINT `fk_program_governance_sponsor_engagement_id` FOREIGN KEY (`sponsor_engagement_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`sponsor_engagement`(`sponsor_engagement_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`governance_meeting` ADD CONSTRAINT `fk_program_governance_meeting_sponsor_contact_id` FOREIGN KEY (`sponsor_contact_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`sponsor_contact`(`sponsor_contact_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`decision` ADD CONSTRAINT `fk_program_decision_sponsor_contact_id` FOREIGN KEY (`sponsor_contact_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`sponsor_contact`(`sponsor_contact_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`timeline` ADD CONSTRAINT `fk_program_timeline_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`program_resource_plan` ADD CONSTRAINT `fk_program_program_resource_plan_cro_organization_id` FOREIGN KEY (`cro_organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`program_resource_plan` ADD CONSTRAINT `fk_program_program_resource_plan_master_agreement_id` FOREIGN KEY (`master_agreement_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`master_agreement`(`master_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`program_resource_plan` ADD CONSTRAINT `fk_program_program_resource_plan_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`budget` ADD CONSTRAINT `fk_program_budget_master_agreement_id` FOREIGN KEY (`master_agreement_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`master_agreement`(`master_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`budget` ADD CONSTRAINT `fk_program_budget_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`program_communication` ADD CONSTRAINT `fk_program_program_communication_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`program_communication` ADD CONSTRAINT `fk_program_program_communication_sponsor_contact_id` FOREIGN KEY (`sponsor_contact_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`sponsor_contact`(`sponsor_contact_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`competitive_intelligence` ADD CONSTRAINT `fk_program_competitive_intelligence_pipeline_asset_id` FOREIGN KEY (`pipeline_asset_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`pipeline_asset`(`pipeline_asset_id`);

-- ========= program --> study (3 constraint(s)) =========
-- Requires: program schema, study schema
ALTER TABLE `clinical_trials_ecm`.`program`.`program_study` ADD CONSTRAINT `fk_program_program_study_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`timeline_event` ADD CONSTRAINT `fk_program_timeline_event_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`cross_study_dependency` ADD CONSTRAINT `fk_program_cross_study_dependency_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);

-- ========= program --> workforce (31 constraint(s)) =========
-- Requires: program schema, workforce schema
ALTER TABLE `clinical_trials_ecm`.`program`.`clinical_program` ADD CONSTRAINT `fk_program_clinical_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`program_milestone` ADD CONSTRAINT `fk_program_program_milestone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`program_plan` ADD CONSTRAINT `fk_program_program_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`amendment` ADD CONSTRAINT `fk_program_amendment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`governance` ADD CONSTRAINT `fk_program_governance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`governance_meeting` ADD CONSTRAINT `fk_program_governance_meeting_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`decision` ADD CONSTRAINT `fk_program_decision_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`timeline` ADD CONSTRAINT `fk_program_timeline_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`timeline` ADD CONSTRAINT `fk_program_timeline_timeline_employee_id` FOREIGN KEY (`timeline_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`risk` ADD CONSTRAINT `fk_program_risk_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`risk` ADD CONSTRAINT `fk_program_risk_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`risk` ADD CONSTRAINT `fk_program_risk_risk_employee_id` FOREIGN KEY (`risk_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`risk_mitigation` ADD CONSTRAINT `fk_program_risk_mitigation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`risk_mitigation` ADD CONSTRAINT `fk_program_risk_mitigation_quaternary_risk_action_owner_employee_id` FOREIGN KEY (`quaternary_risk_action_owner_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`risk_mitigation` ADD CONSTRAINT `fk_program_risk_mitigation_tertiary_risk_effectiveness_reviewer_employee_id` FOREIGN KEY (`tertiary_risk_effectiveness_reviewer_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`assumption` ADD CONSTRAINT `fk_program_assumption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`assumption` ADD CONSTRAINT `fk_program_assumption_assumption_validated_by_employee_id` FOREIGN KEY (`assumption_validated_by_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`assumption` ADD CONSTRAINT `fk_program_assumption_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`assumption` ADD CONSTRAINT `fk_program_assumption_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`program_resource_plan` ADD CONSTRAINT `fk_program_program_resource_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`program_resource_plan` ADD CONSTRAINT `fk_program_program_resource_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`budget` ADD CONSTRAINT `fk_program_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`budget` ADD CONSTRAINT `fk_program_budget_budget_employee_id` FOREIGN KEY (`budget_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`program_status_history` ADD CONSTRAINT `fk_program_program_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`team_member` ADD CONSTRAINT `fk_program_team_member_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`team_member` ADD CONSTRAINT `fk_program_team_member_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`team_member` ADD CONSTRAINT `fk_program_team_member_training_curriculum_id` FOREIGN KEY (`training_curriculum_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`training_curriculum`(`training_curriculum_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`program_communication` ADD CONSTRAINT `fk_program_program_communication_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`competitive_intelligence` ADD CONSTRAINT `fk_program_competitive_intelligence_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`kri` ADD CONSTRAINT `fk_program_kri_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`program`.`kri_reading` ADD CONSTRAINT `fk_program_kri_reading_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= randomization --> agreement (7 constraint(s)) =========
-- Requires: randomization schema, agreement schema
ALTER TABLE `clinical_trials_ecm`.`randomization`.`subject_randomization` ADD CONSTRAINT `fk_randomization_subject_randomization_agreement_billing_milestone_id` FOREIGN KEY (`agreement_billing_milestone_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`agreement_billing_milestone`(`agreement_billing_milestone_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_request` ADD CONSTRAINT `fk_randomization_unblinding_request_contract_obligation_id` FOREIGN KEY (`contract_obligation_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`contract_obligation`(`contract_obligation_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_validation_run` ADD CONSTRAINT `fk_randomization_rand_validation_run_agreement_billing_milestone_id` FOREIGN KEY (`agreement_billing_milestone_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`agreement_billing_milestone`(`agreement_billing_milestone_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_validation_run` ADD CONSTRAINT `fk_randomization_rand_validation_run_contract_obligation_id` FOREIGN KEY (`contract_obligation_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`contract_obligation`(`contract_obligation_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_validation_run` ADD CONSTRAINT `fk_randomization_rand_validation_run_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`deliverable`(`deliverable_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_validation_run` ADD CONSTRAINT `fk_randomization_rand_validation_run_scope_of_work_id` FOREIGN KEY (`scope_of_work_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`scope_of_work`(`scope_of_work_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`dsmb_unblind_package` ADD CONSTRAINT `fk_randomization_dsmb_unblind_package_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`deliverable`(`deliverable_id`);

-- ========= randomization --> biostatistics (1 constraint(s)) =========
-- Requires: randomization schema, biostatistics schema
ALTER TABLE `clinical_trials_ecm`.`randomization`.`dsmb_unblind_package` ADD CONSTRAINT `fk_randomization_dsmb_unblind_package_dsmb_meeting_id` FOREIGN KEY (`dsmb_meeting_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`dsmb_meeting`(`dsmb_meeting_id`);

-- ========= randomization --> compliance (6 constraint(s)) =========
-- Requires: randomization schema, compliance schema
ALTER TABLE `clinical_trials_ecm`.`randomization`.`subject_randomization` ADD CONSTRAINT `fk_randomization_subject_randomization_ethics_approval_id` FOREIGN KEY (`ethics_approval_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_approval`(`ethics_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`kit_assignment` ADD CONSTRAINT `fk_randomization_kit_assignment_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_validation_run` ADD CONSTRAINT `fk_randomization_rand_validation_run_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_deviation` ADD CONSTRAINT `fk_randomization_rand_deviation_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_deviation` ADD CONSTRAINT `fk_randomization_rand_deviation_inspection_finding_id` FOREIGN KEY (`inspection_finding_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`inspection_finding`(`inspection_finding_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_deviation` ADD CONSTRAINT `fk_randomization_rand_deviation_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);

-- ========= randomization --> consent (3 constraint(s)) =========
-- Requires: randomization schema, consent schema
ALTER TABLE `clinical_trials_ecm`.`randomization`.`subject_randomization` ADD CONSTRAINT `fk_randomization_subject_randomization_consent_icf_version_id` FOREIGN KEY (`consent_icf_version_id`) REFERENCES `clinical_trials_ecm`.`consent`.`consent_icf_version`(`consent_icf_version_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`subject_randomization` ADD CONSTRAINT `fk_randomization_subject_randomization_subject_consent_id` FOREIGN KEY (`subject_consent_id`) REFERENCES `clinical_trials_ecm`.`consent`.`subject_consent`(`subject_consent_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_deviation` ADD CONSTRAINT `fk_randomization_rand_deviation_subject_consent_id` FOREIGN KEY (`subject_consent_id`) REFERENCES `clinical_trials_ecm`.`consent`.`subject_consent`(`subject_consent_id`);

-- ========= randomization --> document (11 constraint(s)) =========
-- Requires: randomization schema, document schema
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_scheme` ADD CONSTRAINT `fk_randomization_rand_scheme_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`blinding_config` ADD CONSTRAINT `fk_randomization_blinding_config_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_request` ADD CONSTRAINT `fk_randomization_unblinding_request_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_request` ADD CONSTRAINT `fk_randomization_unblinding_request_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_approval` ADD CONSTRAINT `fk_randomization_unblinding_approval_signature_id` FOREIGN KEY (`signature_id`) REFERENCES `clinical_trials_ecm`.`document`.`signature`(`signature_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_approval` ADD CONSTRAINT `fk_randomization_unblinding_approval_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_validation_run` ADD CONSTRAINT `fk_randomization_rand_validation_run_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_validation_run` ADD CONSTRAINT `fk_randomization_rand_validation_run_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`dsmb_unblind_package` ADD CONSTRAINT `fk_randomization_dsmb_unblind_package_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`dsmb_unblind_package` ADD CONSTRAINT `fk_randomization_dsmb_unblind_package_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_deviation` ADD CONSTRAINT `fk_randomization_rand_deviation_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);

-- ========= randomization --> laboratory (1 constraint(s)) =========
-- Requires: randomization schema, laboratory schema
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_request` ADD CONSTRAINT `fk_randomization_unblinding_request_lab_result_id` FOREIGN KEY (`lab_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_result`(`lab_result_id`);

-- ========= randomization --> program (4 constraint(s)) =========
-- Requires: randomization schema, program schema
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_validation_run` ADD CONSTRAINT `fk_randomization_rand_validation_run_program_milestone_id` FOREIGN KEY (`program_milestone_id`) REFERENCES `clinical_trials_ecm`.`program`.`program_milestone`(`program_milestone_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`dsmb_unblind_package` ADD CONSTRAINT `fk_randomization_dsmb_unblind_package_decision_id` FOREIGN KEY (`decision_id`) REFERENCES `clinical_trials_ecm`.`program`.`decision`(`decision_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`dsmb_unblind_package` ADD CONSTRAINT `fk_randomization_dsmb_unblind_package_program_milestone_id` FOREIGN KEY (`program_milestone_id`) REFERENCES `clinical_trials_ecm`.`program`.`program_milestone`(`program_milestone_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_deviation` ADD CONSTRAINT `fk_randomization_rand_deviation_risk_id` FOREIGN KEY (`risk_id`) REFERENCES `clinical_trials_ecm`.`program`.`risk`(`risk_id`);

-- ========= randomization --> regulatory (9 constraint(s)) =========
-- Requires: randomization schema, regulatory schema
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_list` ADD CONSTRAINT `fk_randomization_rand_list_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`treatment_arm` ADD CONSTRAINT `fk_randomization_treatment_arm_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`stratification_factor` ADD CONSTRAINT `fk_randomization_stratification_factor_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`stratification_cell` ADD CONSTRAINT `fk_randomization_stratification_cell_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`subject_randomization` ADD CONSTRAINT `fk_randomization_subject_randomization_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`subject_randomization` ADD CONSTRAINT `fk_randomization_subject_randomization_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_validation_run` ADD CONSTRAINT `fk_randomization_rand_validation_run_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_validation_run` ADD CONSTRAINT `fk_randomization_rand_validation_run_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_deviation` ADD CONSTRAINT `fk_randomization_rand_deviation_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);

-- ========= randomization --> safety (3 constraint(s)) =========
-- Requires: randomization schema, safety schema
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_request` ADD CONSTRAINT `fk_randomization_unblinding_request_serious_adverse_event_id` FOREIGN KEY (`serious_adverse_event_id`) REFERENCES `clinical_trials_ecm`.`safety`.`serious_adverse_event`(`serious_adverse_event_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_approval` ADD CONSTRAINT `fk_randomization_unblinding_approval_serious_adverse_event_id` FOREIGN KEY (`serious_adverse_event_id`) REFERENCES `clinical_trials_ecm`.`safety`.`serious_adverse_event`(`serious_adverse_event_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`dsmb_unblind_package` ADD CONSTRAINT `fk_randomization_dsmb_unblind_package_dsmb_review_id` FOREIGN KEY (`dsmb_review_id`) REFERENCES `clinical_trials_ecm`.`safety`.`dsmb_review`(`dsmb_review_id`);

-- ========= randomization --> site (7 constraint(s)) =========
-- Requires: randomization schema, site schema
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_code` ADD CONSTRAINT `fk_randomization_rand_code_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`subject_randomization` ADD CONSTRAINT `fk_randomization_subject_randomization_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`irt_transaction` ADD CONSTRAINT `fk_randomization_irt_transaction_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`kit_assignment` ADD CONSTRAINT `fk_randomization_kit_assignment_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_request` ADD CONSTRAINT `fk_randomization_unblinding_request_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_approval` ADD CONSTRAINT `fk_randomization_unblinding_approval_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_deviation` ADD CONSTRAINT `fk_randomization_rand_deviation_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);

-- ========= randomization --> sponsor (10 constraint(s)) =========
-- Requires: randomization schema, sponsor schema
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_scheme` ADD CONSTRAINT `fk_randomization_rand_scheme_delivery_preference_id` FOREIGN KEY (`delivery_preference_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`delivery_preference`(`delivery_preference_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_scheme` ADD CONSTRAINT `fk_randomization_rand_scheme_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_scheme` ADD CONSTRAINT `fk_randomization_rand_scheme_regulatory_strategy_id` FOREIGN KEY (`regulatory_strategy_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`regulatory_strategy`(`regulatory_strategy_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`blinding_config` ADD CONSTRAINT `fk_randomization_blinding_config_delivery_preference_id` FOREIGN KEY (`delivery_preference_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`delivery_preference`(`delivery_preference_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_request` ADD CONSTRAINT `fk_randomization_unblinding_request_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_validation_run` ADD CONSTRAINT `fk_randomization_rand_validation_run_delivery_preference_id` FOREIGN KEY (`delivery_preference_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`delivery_preference`(`delivery_preference_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_validation_run` ADD CONSTRAINT `fk_randomization_rand_validation_run_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_validation_run` ADD CONSTRAINT `fk_randomization_rand_validation_run_sponsor_contact_id` FOREIGN KEY (`sponsor_contact_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`sponsor_contact`(`sponsor_contact_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`dsmb_unblind_package` ADD CONSTRAINT `fk_randomization_dsmb_unblind_package_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_deviation` ADD CONSTRAINT `fk_randomization_rand_deviation_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);

-- ========= randomization --> study (25 constraint(s)) =========
-- Requires: randomization schema, study schema
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_scheme` ADD CONSTRAINT `fk_randomization_rand_scheme_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_scheme` ADD CONSTRAINT `fk_randomization_rand_scheme_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_list` ADD CONSTRAINT `fk_randomization_rand_list_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_list` ADD CONSTRAINT `fk_randomization_rand_list_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_list` ADD CONSTRAINT `fk_randomization_rand_list_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_code` ADD CONSTRAINT `fk_randomization_rand_code_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`treatment_arm` ADD CONSTRAINT `fk_randomization_treatment_arm_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`treatment_arm` ADD CONSTRAINT `fk_randomization_treatment_arm_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `clinical_trials_ecm`.`study`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`treatment_arm` ADD CONSTRAINT `fk_randomization_treatment_arm_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`stratification_factor` ADD CONSTRAINT `fk_randomization_stratification_factor_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`stratification_cell` ADD CONSTRAINT `fk_randomization_stratification_cell_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`subject_randomization` ADD CONSTRAINT `fk_randomization_subject_randomization_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`subject_randomization` ADD CONSTRAINT `fk_randomization_subject_randomization_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`subject_randomization` ADD CONSTRAINT `fk_randomization_subject_randomization_study_visit_schedule_id` FOREIGN KEY (`study_visit_schedule_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_visit_schedule`(`study_visit_schedule_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`irt_transaction` ADD CONSTRAINT `fk_randomization_irt_transaction_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`irt_transaction` ADD CONSTRAINT `fk_randomization_irt_transaction_study_visit_schedule_id` FOREIGN KEY (`study_visit_schedule_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_visit_schedule`(`study_visit_schedule_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`kit_assignment` ADD CONSTRAINT `fk_randomization_kit_assignment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`kit_assignment` ADD CONSTRAINT `fk_randomization_kit_assignment_study_visit_schedule_id` FOREIGN KEY (`study_visit_schedule_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_visit_schedule`(`study_visit_schedule_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_request` ADD CONSTRAINT `fk_randomization_unblinding_request_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_approval` ADD CONSTRAINT `fk_randomization_unblinding_approval_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_validation_run` ADD CONSTRAINT `fk_randomization_rand_validation_run_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_validation_run` ADD CONSTRAINT `fk_randomization_rand_validation_run_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`dsmb_unblind_package` ADD CONSTRAINT `fk_randomization_dsmb_unblind_package_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_deviation` ADD CONSTRAINT `fk_randomization_rand_deviation_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_deviation` ADD CONSTRAINT `fk_randomization_rand_deviation_study_visit_schedule_id` FOREIGN KEY (`study_visit_schedule_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_visit_schedule`(`study_visit_schedule_id`);

-- ========= randomization --> subject (7 constraint(s)) =========
-- Requires: randomization schema, subject schema
ALTER TABLE `clinical_trials_ecm`.`randomization`.`subject_randomization` ADD CONSTRAINT `fk_randomization_subject_randomization_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`irt_transaction` ADD CONSTRAINT `fk_randomization_irt_transaction_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`kit_assignment` ADD CONSTRAINT `fk_randomization_kit_assignment_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`kit_assignment` ADD CONSTRAINT `fk_randomization_kit_assignment_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_request` ADD CONSTRAINT `fk_randomization_unblinding_request_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_approval` ADD CONSTRAINT `fk_randomization_unblinding_approval_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_deviation` ADD CONSTRAINT `fk_randomization_rand_deviation_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);

-- ========= randomization --> supply (3 constraint(s)) =========
-- Requires: randomization schema, supply schema
ALTER TABLE `clinical_trials_ecm`.`randomization`.`irt_transaction` ADD CONSTRAINT `fk_randomization_irt_transaction_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `clinical_trials_ecm`.`supply`.`depot`(`depot_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`kit_assignment` ADD CONSTRAINT `fk_randomization_kit_assignment_kit_inventory_id` FOREIGN KEY (`kit_inventory_id`) REFERENCES `clinical_trials_ecm`.`supply`.`kit_inventory`(`kit_inventory_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_deviation` ADD CONSTRAINT `fk_randomization_rand_deviation_kit_inventory_id` FOREIGN KEY (`kit_inventory_id`) REFERENCES `clinical_trials_ecm`.`supply`.`kit_inventory`(`kit_inventory_id`);

-- ========= randomization --> workforce (24 constraint(s)) =========
-- Requires: randomization schema, workforce schema
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_scheme` ADD CONSTRAINT `fk_randomization_rand_scheme_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_list` ADD CONSTRAINT `fk_randomization_rand_list_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_code` ADD CONSTRAINT `fk_randomization_rand_code_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`stratification_factor` ADD CONSTRAINT `fk_randomization_stratification_factor_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`subject_randomization` ADD CONSTRAINT `fk_randomization_subject_randomization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`subject_randomization` ADD CONSTRAINT `fk_randomization_subject_randomization_study_assignment_id` FOREIGN KEY (`study_assignment_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`study_assignment`(`study_assignment_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`subject_randomization` ADD CONSTRAINT `fk_randomization_subject_randomization_workforce_delegation_log_id` FOREIGN KEY (`workforce_delegation_log_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`workforce_delegation_log`(`workforce_delegation_log_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`irt_transaction` ADD CONSTRAINT `fk_randomization_irt_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`irt_transaction` ADD CONSTRAINT `fk_randomization_irt_transaction_workforce_delegation_log_id` FOREIGN KEY (`workforce_delegation_log_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`workforce_delegation_log`(`workforce_delegation_log_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`kit_assignment` ADD CONSTRAINT `fk_randomization_kit_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`blinding_config` ADD CONSTRAINT `fk_randomization_blinding_config_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_request` ADD CONSTRAINT `fk_randomization_unblinding_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_request` ADD CONSTRAINT `fk_randomization_unblinding_request_approver_2_employee_id` FOREIGN KEY (`approver_2_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_request` ADD CONSTRAINT `fk_randomization_unblinding_request_primary_unblinding_employee_id` FOREIGN KEY (`primary_unblinding_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_request` ADD CONSTRAINT `fk_randomization_unblinding_request_study_assignment_id` FOREIGN KEY (`study_assignment_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`study_assignment`(`study_assignment_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_approval` ADD CONSTRAINT `fk_randomization_unblinding_approval_study_assignment_id` FOREIGN KEY (`study_assignment_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`study_assignment`(`study_assignment_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`unblinding_approval` ADD CONSTRAINT `fk_randomization_unblinding_approval_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_validation_run` ADD CONSTRAINT `fk_randomization_rand_validation_run_study_assignment_id` FOREIGN KEY (`study_assignment_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`study_assignment`(`study_assignment_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_validation_run` ADD CONSTRAINT `fk_randomization_rand_validation_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`dsmb_unblind_package` ADD CONSTRAINT `fk_randomization_dsmb_unblind_package_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`dsmb_unblind_package` ADD CONSTRAINT `fk_randomization_dsmb_unblind_package_study_assignment_id` FOREIGN KEY (`study_assignment_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`study_assignment`(`study_assignment_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_deviation` ADD CONSTRAINT `fk_randomization_rand_deviation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_deviation` ADD CONSTRAINT `fk_randomization_rand_deviation_workforce_capa_id` FOREIGN KEY (`workforce_capa_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`workforce_capa`(`workforce_capa_id`);
ALTER TABLE `clinical_trials_ecm`.`randomization`.`rand_deviation` ADD CONSTRAINT `fk_randomization_rand_deviation_workforce_delegation_log_id` FOREIGN KEY (`workforce_delegation_log_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`workforce_delegation_log`(`workforce_delegation_log_id`);

-- ========= regulatory --> compliance (37 constraint(s)) =========
-- Requires: regulatory schema, compliance schema
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`submission_sequence` ADD CONSTRAINT `fk_regulatory_submission_sequence_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`correspondence` ADD CONSTRAINT `fk_regulatory_correspondence_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`correspondence` ADD CONSTRAINT `fk_regulatory_correspondence_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`ctd_dossier` ADD CONSTRAINT `fk_regulatory_ctd_dossier_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`nda_bla_application` ADD CONSTRAINT `fk_regulatory_nda_bla_application_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`nda_bla_application` ADD CONSTRAINT `fk_regulatory_nda_bla_application_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_milestone` ADD CONSTRAINT `fk_regulatory_regulatory_milestone_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`labeling_document` ADD CONSTRAINT `fk_regulatory_labeling_document_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`safety_report_submission` ADD CONSTRAINT `fk_regulatory_safety_report_submission_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`safety_report_submission` ADD CONSTRAINT `fk_regulatory_safety_report_submission_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_inspection` ADD CONSTRAINT `fk_regulatory_regulatory_inspection_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_inspection` ADD CONSTRAINT `fk_regulatory_regulatory_inspection_compliance_capa_id` FOREIGN KEY (`compliance_capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_capa`(`compliance_capa_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_inspection` ADD CONSTRAINT `fk_regulatory_regulatory_inspection_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_inspection` ADD CONSTRAINT `fk_regulatory_regulatory_inspection_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`commitment` ADD CONSTRAINT `fk_regulatory_commitment_regulatory_commitment_id` FOREIGN KEY (`regulatory_commitment_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`regulatory_commitment`(`regulatory_commitment_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`commitment` ADD CONSTRAINT `fk_regulatory_commitment_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`commitment` ADD CONSTRAINT `fk_regulatory_commitment_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`special_designation` ADD CONSTRAINT `fk_regulatory_special_designation_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_action_item` ADD CONSTRAINT `fk_regulatory_regulatory_action_item_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_action_item` ADD CONSTRAINT `fk_regulatory_regulatory_action_item_compliance_capa_id` FOREIGN KEY (`compliance_capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_capa`(`compliance_capa_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_action_item` ADD CONSTRAINT `fk_regulatory_regulatory_action_item_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_action_item` ADD CONSTRAINT `fk_regulatory_regulatory_action_item_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_action_item` ADD CONSTRAINT `fk_regulatory_regulatory_action_item_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`country_registration` ADD CONSTRAINT `fk_regulatory_country_registration_ethics_approval_id` FOREIGN KEY (`ethics_approval_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_approval`(`ethics_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`country_registration` ADD CONSTRAINT `fk_regulatory_country_registration_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`procedure` ADD CONSTRAINT `fk_regulatory_procedure_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`procedure` ADD CONSTRAINT `fk_regulatory_procedure_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`rems_program` ADD CONSTRAINT `fk_regulatory_rems_program_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`rems_program` ADD CONSTRAINT `fk_regulatory_rems_program_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`rems_program` ADD CONSTRAINT `fk_regulatory_rems_program_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`intelligence` ADD CONSTRAINT `fk_regulatory_intelligence_compliance_capa_id` FOREIGN KEY (`compliance_capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_capa`(`compliance_capa_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`intelligence` ADD CONSTRAINT `fk_regulatory_intelligence_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`intelligence` ADD CONSTRAINT `fk_regulatory_intelligence_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`intelligence` ADD CONSTRAINT `fk_regulatory_intelligence_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`protocol_ethics_coverage` ADD CONSTRAINT `fk_regulatory_protocol_ethics_coverage_ethics_submission_id` FOREIGN KEY (`ethics_submission_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_submission`(`ethics_submission_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`dossier_ethics_reference` ADD CONSTRAINT `fk_regulatory_dossier_ethics_reference_ethics_approval_id` FOREIGN KEY (`ethics_approval_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_approval`(`ethics_approval_id`);

-- ========= regulatory --> data (2 constraint(s)) =========
-- Requires: regulatory schema, data schema
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`safety_report_submission` ADD CONSTRAINT `fk_regulatory_safety_report_submission_sdtm_dataset_id` FOREIGN KEY (`sdtm_dataset_id`) REFERENCES `clinical_trials_ecm`.`data`.`sdtm_dataset`(`sdtm_dataset_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`submission_content_unit` ADD CONSTRAINT `fk_regulatory_submission_content_unit_sdtm_dataset_id` FOREIGN KEY (`sdtm_dataset_id`) REFERENCES `clinical_trials_ecm`.`data`.`sdtm_dataset`(`sdtm_dataset_id`);

-- ========= regulatory --> document (18 constraint(s)) =========
-- Requires: regulatory schema, document schema
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`submission_sequence` ADD CONSTRAINT `fk_regulatory_submission_sequence_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`correspondence` ADD CONSTRAINT `fk_regulatory_correspondence_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`agency_meeting` ADD CONSTRAINT `fk_regulatory_agency_meeting_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`ctd_dossier` ADD CONSTRAINT `fk_regulatory_ctd_dossier_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`ctd_dossier` ADD CONSTRAINT `fk_regulatory_ctd_dossier_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`nda_bla_application` ADD CONSTRAINT `fk_regulatory_nda_bla_application_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`labeling_document` ADD CONSTRAINT `fk_regulatory_labeling_document_template_id` FOREIGN KEY (`template_id`) REFERENCES `clinical_trials_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`safety_report_submission` ADD CONSTRAINT `fk_regulatory_safety_report_submission_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_inspection` ADD CONSTRAINT `fk_regulatory_regulatory_inspection_site_file_id` FOREIGN KEY (`site_file_id`) REFERENCES `clinical_trials_ecm`.`document`.`site_file`(`site_file_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`commitment` ADD CONSTRAINT `fk_regulatory_commitment_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_action_item` ADD CONSTRAINT `fk_regulatory_regulatory_action_item_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`country_registration` ADD CONSTRAINT `fk_regulatory_country_registration_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`submission_content_unit` ADD CONSTRAINT `fk_regulatory_submission_content_unit_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`submission_content_unit` ADD CONSTRAINT `fk_regulatory_submission_content_unit_veeva_vault_version_id` FOREIGN KEY (`veeva_vault_version_id`) REFERENCES `clinical_trials_ecm`.`document`.`version`(`version_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`submission_content_unit` ADD CONSTRAINT `fk_regulatory_submission_content_unit_version_id` FOREIGN KEY (`version_id`) REFERENCES `clinical_trials_ecm`.`document`.`version`(`version_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`rems_program` ADD CONSTRAINT `fk_regulatory_rems_program_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`binder_document_inclusion` ADD CONSTRAINT `fk_regulatory_binder_document_inclusion_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`binder_content_inclusion` ADD CONSTRAINT `fk_regulatory_binder_content_inclusion_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);

-- ========= regulatory --> finance (1 constraint(s)) =========
-- Requires: regulatory schema, finance schema
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`commitment` ADD CONSTRAINT `fk_regulatory_commitment_study_budget_id` FOREIGN KEY (`study_budget_id`) REFERENCES `clinical_trials_ecm`.`finance`.`study_budget`(`study_budget_id`);

-- ========= regulatory --> laboratory (1 constraint(s)) =========
-- Requires: regulatory schema, laboratory schema
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_inspection` ADD CONSTRAINT `fk_regulatory_regulatory_inspection_lab_facility_id` FOREIGN KEY (`lab_facility_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_facility`(`lab_facility_id`);

-- ========= regulatory --> monitoring (1 constraint(s)) =========
-- Requires: regulatory schema, monitoring schema
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_action_item` ADD CONSTRAINT `fk_regulatory_regulatory_action_item_monitoring_action_item_id` FOREIGN KEY (`monitoring_action_item_id`) REFERENCES `clinical_trials_ecm`.`monitoring`.`monitoring_action_item`(`monitoring_action_item_id`);

-- ========= regulatory --> program (6 constraint(s)) =========
-- Requires: regulatory schema, program schema
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`application` ADD CONSTRAINT `fk_regulatory_application_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `clinical_trials_ecm`.`program`.`indication`(`indication_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_milestone` ADD CONSTRAINT `fk_regulatory_regulatory_milestone_program_milestone_id` FOREIGN KEY (`program_milestone_id`) REFERENCES `clinical_trials_ecm`.`program`.`program_milestone`(`program_milestone_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`strategy` ADD CONSTRAINT `fk_regulatory_strategy_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `clinical_trials_ecm`.`program`.`indication`(`indication_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`strategy` ADD CONSTRAINT `fk_regulatory_strategy_program_plan_id` FOREIGN KEY (`program_plan_id`) REFERENCES `clinical_trials_ecm`.`program`.`program_plan`(`program_plan_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`intelligence` ADD CONSTRAINT `fk_regulatory_intelligence_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_engagement` ADD CONSTRAINT `fk_regulatory_regulatory_engagement_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);

-- ========= regulatory --> safety (1 constraint(s)) =========
-- Requires: regulatory schema, safety schema
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`safety_report_submission` ADD CONSTRAINT `fk_regulatory_safety_report_submission_icsr_id` FOREIGN KEY (`icsr_id`) REFERENCES `clinical_trials_ecm`.`safety`.`icsr`(`icsr_id`);

-- ========= regulatory --> site (1 constraint(s)) =========
-- Requires: regulatory schema, site schema
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_inspection` ADD CONSTRAINT `fk_regulatory_regulatory_inspection_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);

-- ========= regulatory --> sponsor (10 constraint(s)) =========
-- Requires: regulatory schema, sponsor schema
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`application` ADD CONSTRAINT `fk_regulatory_application_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`submission_sequence` ADD CONSTRAINT `fk_regulatory_submission_sequence_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`correspondence` ADD CONSTRAINT `fk_regulatory_correspondence_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`nda_bla_application` ADD CONSTRAINT `fk_regulatory_nda_bla_application_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`safety_report_submission` ADD CONSTRAINT `fk_regulatory_safety_report_submission_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`strategy` ADD CONSTRAINT `fk_regulatory_strategy_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_inspection` ADD CONSTRAINT `fk_regulatory_regulatory_inspection_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`special_designation` ADD CONSTRAINT `fk_regulatory_special_designation_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`rems_program` ADD CONSTRAINT `fk_regulatory_rems_program_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);

-- ========= regulatory --> study (14 constraint(s)) =========
-- Requires: regulatory schema, study schema
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`submission_sequence` ADD CONSTRAINT `fk_regulatory_submission_sequence_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment` ADD CONSTRAINT `fk_regulatory_regulatory_protocol_amendment_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment` ADD CONSTRAINT `fk_regulatory_regulatory_protocol_amendment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`correspondence` ADD CONSTRAINT `fk_regulatory_correspondence_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`agency_meeting` ADD CONSTRAINT `fk_regulatory_agency_meeting_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_milestone` ADD CONSTRAINT `fk_regulatory_regulatory_milestone_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`safety_report_submission` ADD CONSTRAINT `fk_regulatory_safety_report_submission_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_inspection` ADD CONSTRAINT `fk_regulatory_regulatory_inspection_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`commitment` ADD CONSTRAINT `fk_regulatory_commitment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`special_designation` ADD CONSTRAINT `fk_regulatory_special_designation_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_action_item` ADD CONSTRAINT `fk_regulatory_regulatory_action_item_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`submission_content_unit` ADD CONSTRAINT `fk_regulatory_submission_content_unit_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);

-- ========= regulatory --> workforce (20 constraint(s)) =========
-- Requires: regulatory schema, workforce schema
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`application` ADD CONSTRAINT `fk_regulatory_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`submission_sequence` ADD CONSTRAINT `fk_regulatory_submission_sequence_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment` ADD CONSTRAINT `fk_regulatory_regulatory_protocol_amendment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`correspondence` ADD CONSTRAINT `fk_regulatory_correspondence_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`agency_meeting` ADD CONSTRAINT `fk_regulatory_agency_meeting_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`ctd_dossier` ADD CONSTRAINT `fk_regulatory_ctd_dossier_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`ind_application` ADD CONSTRAINT `fk_regulatory_ind_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`nda_bla_application` ADD CONSTRAINT `fk_regulatory_nda_bla_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_milestone` ADD CONSTRAINT `fk_regulatory_regulatory_milestone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`labeling_document` ADD CONSTRAINT `fk_regulatory_labeling_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`safety_report_submission` ADD CONSTRAINT `fk_regulatory_safety_report_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`strategy` ADD CONSTRAINT `fk_regulatory_strategy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`regulatory_inspection` ADD CONSTRAINT `fk_regulatory_regulatory_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`commitment` ADD CONSTRAINT `fk_regulatory_commitment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`special_designation` ADD CONSTRAINT `fk_regulatory_special_designation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`country_registration` ADD CONSTRAINT `fk_regulatory_country_registration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`submission_content_unit` ADD CONSTRAINT `fk_regulatory_submission_content_unit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`rems_program` ADD CONSTRAINT `fk_regulatory_rems_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`regulatory`.`intelligence` ADD CONSTRAINT `fk_regulatory_intelligence_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= safety --> agreement (7 constraint(s)) =========
-- Requires: safety schema, agreement schema
ALTER TABLE `clinical_trials_ecm`.`safety`.`reporting_obligation` ADD CONSTRAINT `fk_safety_reporting_obligation_study_contract_id` FOREIGN KEY (`study_contract_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`study_contract`(`study_contract_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`expedited_report_deadline` ADD CONSTRAINT `fk_safety_expedited_report_deadline_service_level_agreement_id` FOREIGN KEY (`service_level_agreement_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`service_level_agreement`(`service_level_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`deliverable`(`deliverable_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_study_contract_id` FOREIGN KEY (`study_contract_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`study_contract`(`study_contract_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`investigator_brochure_safety` ADD CONSTRAINT `fk_safety_investigator_brochure_safety_study_contract_id` FOREIGN KEY (`study_contract_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`study_contract`(`study_contract_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`safety_communication` ADD CONSTRAINT `fk_safety_safety_communication_study_contract_id` FOREIGN KEY (`study_contract_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`study_contract`(`study_contract_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`benefit_risk_assessment` ADD CONSTRAINT `fk_safety_benefit_risk_assessment_study_contract_id` FOREIGN KEY (`study_contract_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`study_contract`(`study_contract_id`);

-- ========= safety --> biostatistics (10 constraint(s)) =========
-- Requires: safety schema, biostatistics schema
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal_evaluation` ADD CONSTRAINT `fk_safety_signal_evaluation_interim_analysis_id` FOREIGN KEY (`interim_analysis_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`interim_analysis`(`interim_analysis_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_review` ADD CONSTRAINT `fk_safety_dsmb_review_dsmb_charter_id` FOREIGN KEY (`dsmb_charter_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`dsmb_charter`(`dsmb_charter_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_review` ADD CONSTRAINT `fk_safety_dsmb_review_dsmb_meeting_id` FOREIGN KEY (`dsmb_meeting_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`dsmb_meeting`(`dsmb_meeting_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_review` ADD CONSTRAINT `fk_safety_dsmb_review_interim_analysis_id` FOREIGN KEY (`interim_analysis_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`interim_analysis`(`interim_analysis_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_recommendation` ADD CONSTRAINT `fk_safety_dsmb_recommendation_dsmb_charter_id` FOREIGN KEY (`dsmb_charter_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`dsmb_charter`(`dsmb_charter_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_recommendation` ADD CONSTRAINT `fk_safety_dsmb_recommendation_dsmb_meeting_id` FOREIGN KEY (`dsmb_meeting_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`dsmb_meeting`(`dsmb_meeting_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_interim_analysis_id` FOREIGN KEY (`interim_analysis_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`interim_analysis`(`interim_analysis_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_sap_id` FOREIGN KEY (`sap_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sap`(`sap_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`benefit_risk_assessment` ADD CONSTRAINT `fk_safety_benefit_risk_assessment_interim_analysis_id` FOREIGN KEY (`interim_analysis_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`interim_analysis`(`interim_analysis_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`benefit_risk_assessment` ADD CONSTRAINT `fk_safety_benefit_risk_assessment_sap_id` FOREIGN KEY (`sap_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sap`(`sap_id`);

-- ========= safety --> compliance (2 constraint(s)) =========
-- Requires: safety schema, compliance schema
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_recommendation` ADD CONSTRAINT `fk_safety_dsmb_recommendation_compliance_capa_id` FOREIGN KEY (`compliance_capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_capa`(`compliance_capa_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`reporting_obligation` ADD CONSTRAINT `fk_safety_reporting_obligation_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`obligation`(`obligation_id`);

-- ========= safety --> consent (1 constraint(s)) =========
-- Requires: safety schema, consent schema
ALTER TABLE `clinical_trials_ecm`.`safety`.`safety_communication` ADD CONSTRAINT `fk_safety_safety_communication_consent_icf_version_id` FOREIGN KEY (`consent_icf_version_id`) REFERENCES `clinical_trials_ecm`.`consent`.`consent_icf_version`(`consent_icf_version_id`);

-- ========= safety --> data (8 constraint(s)) =========
-- Requires: safety schema, data schema
ALTER TABLE `clinical_trials_ecm`.`safety`.`adverse_event` ADD CONSTRAINT `fk_safety_adverse_event_ecrf_form_id` FOREIGN KEY (`ecrf_form_id`) REFERENCES `clinical_trials_ecm`.`data`.`ecrf_form`(`ecrf_form_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`adverse_event` ADD CONSTRAINT `fk_safety_adverse_event_subject_visit_data_id` FOREIGN KEY (`subject_visit_data_id`) REFERENCES `clinical_trials_ecm`.`data`.`subject_visit_data`(`subject_visit_data_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`serious_adverse_event` ADD CONSTRAINT `fk_safety_serious_adverse_event_ecrf_form_id` FOREIGN KEY (`ecrf_form_id`) REFERENCES `clinical_trials_ecm`.`data`.`ecrf_form`(`ecrf_form_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`ae_meddra_coding` ADD CONSTRAINT `fk_safety_ae_meddra_coding_coding_assignment_id` FOREIGN KEY (`coding_assignment_id`) REFERENCES `clinical_trials_ecm`.`data`.`coding_assignment`(`coding_assignment_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`ae_meddra_coding` ADD CONSTRAINT `fk_safety_ae_meddra_coding_discrepancy_query_id` FOREIGN KEY (`discrepancy_query_id`) REFERENCES `clinical_trials_ecm`.`data`.`discrepancy_query`(`discrepancy_query_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`ae_meddra_coding` ADD CONSTRAINT `fk_safety_ae_meddra_coding_ecrf_field_id` FOREIGN KEY (`ecrf_field_id`) REFERENCES `clinical_trials_ecm`.`data`.`ecrf_field`(`ecrf_field_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`ae_follow_up` ADD CONSTRAINT `fk_safety_ae_follow_up_subject_visit_data_id` FOREIGN KEY (`subject_visit_data_id`) REFERENCES `clinical_trials_ecm`.`data`.`subject_visit_data`(`subject_visit_data_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`assessment_dataset_evidence` ADD CONSTRAINT `fk_safety_assessment_dataset_evidence_sdtm_dataset_id` FOREIGN KEY (`sdtm_dataset_id`) REFERENCES `clinical_trials_ecm`.`data`.`sdtm_dataset`(`sdtm_dataset_id`);

-- ========= safety --> document (16 constraint(s)) =========
-- Requires: safety schema, document schema
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar` ADD CONSTRAINT `fk_safety_susar_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`narrative` ADD CONSTRAINT `fk_safety_narrative_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`icsr` ADD CONSTRAINT `fk_safety_icsr_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`icsr` ADD CONSTRAINT `fk_safety_icsr_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal_evaluation` ADD CONSTRAINT `fk_safety_signal_evaluation_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_review` ADD CONSTRAINT `fk_safety_dsmb_review_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_recommendation` ADD CONSTRAINT `fk_safety_dsmb_recommendation_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`reporting_obligation` ADD CONSTRAINT `fk_safety_reporting_obligation_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`review_committee` ADD CONSTRAINT `fk_safety_review_committee_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`investigator_brochure_safety` ADD CONSTRAINT `fk_safety_investigator_brochure_safety_version_id` FOREIGN KEY (`version_id`) REFERENCES `clinical_trials_ecm`.`document`.`version`(`version_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`investigator_brochure_safety` ADD CONSTRAINT `fk_safety_investigator_brochure_safety_template_id` FOREIGN KEY (`template_id`) REFERENCES `clinical_trials_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`investigator_brochure_safety` ADD CONSTRAINT `fk_safety_investigator_brochure_safety_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`safety_communication` ADD CONSTRAINT `fk_safety_safety_communication_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`benefit_risk_assessment` ADD CONSTRAINT `fk_safety_benefit_risk_assessment_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);

-- ========= safety --> finance (2 constraint(s)) =========
-- Requires: safety schema, finance schema
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_recommendation` ADD CONSTRAINT `fk_safety_dsmb_recommendation_study_budget_id` FOREIGN KEY (`study_budget_id`) REFERENCES `clinical_trials_ecm`.`finance`.`study_budget`(`study_budget_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_study_budget_id` FOREIGN KEY (`study_budget_id`) REFERENCES `clinical_trials_ecm`.`finance`.`study_budget`(`study_budget_id`);

-- ========= safety --> laboratory (2 constraint(s)) =========
-- Requires: safety schema, laboratory schema
ALTER TABLE `clinical_trials_ecm`.`safety`.`causality_assessment` ADD CONSTRAINT `fk_safety_causality_assessment_lab_result_id` FOREIGN KEY (`lab_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_result`(`lab_result_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`ae_follow_up` ADD CONSTRAINT `fk_safety_ae_follow_up_lab_result_id` FOREIGN KEY (`lab_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_result`(`lab_result_id`);

-- ========= safety --> monitoring (1 constraint(s)) =========
-- Requires: safety schema, monitoring schema
ALTER TABLE `clinical_trials_ecm`.`safety`.`ae_follow_up` ADD CONSTRAINT `fk_safety_ae_follow_up_monitoring_visit_id` FOREIGN KEY (`monitoring_visit_id`) REFERENCES `clinical_trials_ecm`.`monitoring`.`monitoring_visit`(`monitoring_visit_id`);

-- ========= safety --> program (10 constraint(s)) =========
-- Requires: safety schema, program schema
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar` ADD CONSTRAINT `fk_safety_susar_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal` ADD CONSTRAINT `fk_safety_signal_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal` ADD CONSTRAINT `fk_safety_signal_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `clinical_trials_ecm`.`program`.`indication`(`indication_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_review` ADD CONSTRAINT `fk_safety_dsmb_review_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_recommendation` ADD CONSTRAINT `fk_safety_dsmb_recommendation_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`reporting_obligation` ADD CONSTRAINT `fk_safety_reporting_obligation_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`investigator_brochure_safety` ADD CONSTRAINT `fk_safety_investigator_brochure_safety_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`safety_communication` ADD CONSTRAINT `fk_safety_safety_communication_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`benefit_risk_assessment` ADD CONSTRAINT `fk_safety_benefit_risk_assessment_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);

-- ========= safety --> randomization (12 constraint(s)) =========
-- Requires: safety schema, randomization schema
ALTER TABLE `clinical_trials_ecm`.`safety`.`adverse_event` ADD CONSTRAINT `fk_safety_adverse_event_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`serious_adverse_event` ADD CONSTRAINT `fk_safety_serious_adverse_event_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar` ADD CONSTRAINT `fk_safety_susar_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`causality_assessment` ADD CONSTRAINT `fk_safety_causality_assessment_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal` ADD CONSTRAINT `fk_safety_signal_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal_evaluation` ADD CONSTRAINT `fk_safety_signal_evaluation_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_review` ADD CONSTRAINT `fk_safety_dsmb_review_blinding_config_id` FOREIGN KEY (`blinding_config_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`blinding_config`(`blinding_config_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_review` ADD CONSTRAINT `fk_safety_dsmb_review_rand_scheme_id` FOREIGN KEY (`rand_scheme_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_scheme`(`rand_scheme_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_recommendation` ADD CONSTRAINT `fk_safety_dsmb_recommendation_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_rand_scheme_id` FOREIGN KEY (`rand_scheme_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_scheme`(`rand_scheme_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`safety_communication` ADD CONSTRAINT `fk_safety_safety_communication_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`benefit_risk_assessment` ADD CONSTRAINT `fk_safety_benefit_risk_assessment_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);

-- ========= safety --> regulatory (34 constraint(s)) =========
-- Requires: safety schema, regulatory schema
ALTER TABLE `clinical_trials_ecm`.`safety`.`serious_adverse_event` ADD CONSTRAINT `fk_safety_serious_adverse_event_safety_report_submission_id` FOREIGN KEY (`safety_report_submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`safety_report_submission`(`safety_report_submission_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar` ADD CONSTRAINT `fk_safety_susar_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`icsr` ADD CONSTRAINT `fk_safety_icsr_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`icsr` ADD CONSTRAINT `fk_safety_icsr_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal_evaluation` ADD CONSTRAINT `fk_safety_signal_evaluation_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal_evaluation` ADD CONSTRAINT `fk_safety_signal_evaluation_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_review` ADD CONSTRAINT `fk_safety_dsmb_review_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_review` ADD CONSTRAINT `fk_safety_dsmb_review_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_recommendation` ADD CONSTRAINT `fk_safety_dsmb_recommendation_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_recommendation` ADD CONSTRAINT `fk_safety_dsmb_recommendation_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`reporting_obligation` ADD CONSTRAINT `fk_safety_reporting_obligation_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`reporting_obligation` ADD CONSTRAINT `fk_safety_reporting_obligation_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`reporting_obligation` ADD CONSTRAINT `fk_safety_reporting_obligation_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`expedited_report_deadline` ADD CONSTRAINT `fk_safety_expedited_report_deadline_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`expedited_report_deadline` ADD CONSTRAINT `fk_safety_expedited_report_deadline_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`expedited_report_deadline` ADD CONSTRAINT `fk_safety_expedited_report_deadline_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_safety_report_submission_id` FOREIGN KEY (`safety_report_submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`safety_report_submission`(`safety_report_submission_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`review_committee` ADD CONSTRAINT `fk_safety_review_committee_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`investigator_brochure_safety` ADD CONSTRAINT `fk_safety_investigator_brochure_safety_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`investigator_brochure_safety` ADD CONSTRAINT `fk_safety_investigator_brochure_safety_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`investigator_brochure_safety` ADD CONSTRAINT `fk_safety_investigator_brochure_safety_labeling_document_id` FOREIGN KEY (`labeling_document_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`labeling_document`(`labeling_document_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`investigator_brochure_safety` ADD CONSTRAINT `fk_safety_investigator_brochure_safety_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`safety_communication` ADD CONSTRAINT `fk_safety_safety_communication_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`safety_communication` ADD CONSTRAINT `fk_safety_safety_communication_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`safety_communication` ADD CONSTRAINT `fk_safety_safety_communication_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`ae_follow_up` ADD CONSTRAINT `fk_safety_ae_follow_up_safety_report_submission_id` FOREIGN KEY (`safety_report_submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`safety_report_submission`(`safety_report_submission_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`benefit_risk_assessment` ADD CONSTRAINT `fk_safety_benefit_risk_assessment_safety_report_submission_id` FOREIGN KEY (`safety_report_submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`safety_report_submission`(`safety_report_submission_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`benefit_risk_assessment` ADD CONSTRAINT `fk_safety_benefit_risk_assessment_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal_notification` ADD CONSTRAINT `fk_safety_signal_notification_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar_submission` ADD CONSTRAINT `fk_safety_susar_submission_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`health_authority`(`health_authority_id`);

-- ========= safety --> site (15 constraint(s)) =========
-- Requires: safety schema, site schema
ALTER TABLE `clinical_trials_ecm`.`safety`.`adverse_event` ADD CONSTRAINT `fk_safety_adverse_event_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`serious_adverse_event` ADD CONSTRAINT `fk_safety_serious_adverse_event_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`serious_adverse_event` ADD CONSTRAINT `fk_safety_serious_adverse_event_irb_iec_approval_id` FOREIGN KEY (`irb_iec_approval_id`) REFERENCES `clinical_trials_ecm`.`site`.`irb_iec_approval`(`irb_iec_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`serious_adverse_event` ADD CONSTRAINT `fk_safety_serious_adverse_event_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar` ADD CONSTRAINT `fk_safety_susar_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar` ADD CONSTRAINT `fk_safety_susar_irb_iec_approval_id` FOREIGN KEY (`irb_iec_approval_id`) REFERENCES `clinical_trials_ecm`.`site`.`irb_iec_approval`(`irb_iec_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar` ADD CONSTRAINT `fk_safety_susar_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`causality_assessment` ADD CONSTRAINT `fk_safety_causality_assessment_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`narrative` ADD CONSTRAINT `fk_safety_narrative_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`icsr` ADD CONSTRAINT `fk_safety_icsr_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`safety_communication` ADD CONSTRAINT `fk_safety_safety_communication_irb_iec_approval_id` FOREIGN KEY (`irb_iec_approval_id`) REFERENCES `clinical_trials_ecm`.`site`.`irb_iec_approval`(`irb_iec_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`safety_communication` ADD CONSTRAINT `fk_safety_safety_communication_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`ae_follow_up` ADD CONSTRAINT `fk_safety_ae_follow_up_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`ae_follow_up` ADD CONSTRAINT `fk_safety_ae_follow_up_irb_iec_approval_id` FOREIGN KEY (`irb_iec_approval_id`) REFERENCES `clinical_trials_ecm`.`site`.`irb_iec_approval`(`irb_iec_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`ae_follow_up` ADD CONSTRAINT `fk_safety_ae_follow_up_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);

-- ========= safety --> sponsor (19 constraint(s)) =========
-- Requires: safety schema, sponsor schema
ALTER TABLE `clinical_trials_ecm`.`safety`.`serious_adverse_event` ADD CONSTRAINT `fk_safety_serious_adverse_event_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar` ADD CONSTRAINT `fk_safety_susar_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar` ADD CONSTRAINT `fk_safety_susar_regulatory_strategy_id` FOREIGN KEY (`regulatory_strategy_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`regulatory_strategy`(`regulatory_strategy_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`icsr` ADD CONSTRAINT `fk_safety_icsr_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`icsr` ADD CONSTRAINT `fk_safety_icsr_regulatory_strategy_id` FOREIGN KEY (`regulatory_strategy_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`regulatory_strategy`(`regulatory_strategy_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal` ADD CONSTRAINT `fk_safety_signal_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal` ADD CONSTRAINT `fk_safety_signal_pipeline_asset_id` FOREIGN KEY (`pipeline_asset_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`pipeline_asset`(`pipeline_asset_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_review` ADD CONSTRAINT `fk_safety_dsmb_review_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`reporting_obligation` ADD CONSTRAINT `fk_safety_reporting_obligation_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`reporting_obligation` ADD CONSTRAINT `fk_safety_reporting_obligation_regulatory_strategy_id` FOREIGN KEY (`regulatory_strategy_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`regulatory_strategy`(`regulatory_strategy_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_pipeline_asset_id` FOREIGN KEY (`pipeline_asset_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`pipeline_asset`(`pipeline_asset_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_regulatory_strategy_id` FOREIGN KEY (`regulatory_strategy_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`regulatory_strategy`(`regulatory_strategy_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`review_committee` ADD CONSTRAINT `fk_safety_review_committee_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`investigator_brochure_safety` ADD CONSTRAINT `fk_safety_investigator_brochure_safety_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`safety_communication` ADD CONSTRAINT `fk_safety_safety_communication_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`benefit_risk_assessment` ADD CONSTRAINT `fk_safety_benefit_risk_assessment_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`benefit_risk_assessment` ADD CONSTRAINT `fk_safety_benefit_risk_assessment_pipeline_asset_id` FOREIGN KEY (`pipeline_asset_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`pipeline_asset`(`pipeline_asset_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`benefit_risk_assessment` ADD CONSTRAINT `fk_safety_benefit_risk_assessment_regulatory_strategy_id` FOREIGN KEY (`regulatory_strategy_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`regulatory_strategy`(`regulatory_strategy_id`);

-- ========= safety --> study (17 constraint(s)) =========
-- Requires: safety schema, study schema
ALTER TABLE `clinical_trials_ecm`.`safety`.`adverse_event` ADD CONSTRAINT `fk_safety_adverse_event_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`serious_adverse_event` ADD CONSTRAINT `fk_safety_serious_adverse_event_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar` ADD CONSTRAINT `fk_safety_susar_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`ae_meddra_coding` ADD CONSTRAINT `fk_safety_ae_meddra_coding_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`causality_assessment` ADD CONSTRAINT `fk_safety_causality_assessment_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `clinical_trials_ecm`.`study`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`causality_assessment` ADD CONSTRAINT `fk_safety_causality_assessment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`narrative` ADD CONSTRAINT `fk_safety_narrative_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`icsr` ADD CONSTRAINT `fk_safety_icsr_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal` ADD CONSTRAINT `fk_safety_signal_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal_evaluation` ADD CONSTRAINT `fk_safety_signal_evaluation_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_review` ADD CONSTRAINT `fk_safety_dsmb_review_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_recommendation` ADD CONSTRAINT `fk_safety_dsmb_recommendation_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`reporting_obligation` ADD CONSTRAINT `fk_safety_reporting_obligation_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`expedited_report_deadline` ADD CONSTRAINT `fk_safety_expedited_report_deadline_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`investigator_brochure_safety` ADD CONSTRAINT `fk_safety_investigator_brochure_safety_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `clinical_trials_ecm`.`study`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`safety_communication` ADD CONSTRAINT `fk_safety_safety_communication_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`ae_follow_up` ADD CONSTRAINT `fk_safety_ae_follow_up_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);

-- ========= safety --> subject (11 constraint(s)) =========
-- Requires: safety schema, subject schema
ALTER TABLE `clinical_trials_ecm`.`safety`.`adverse_event` ADD CONSTRAINT `fk_safety_adverse_event_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`adverse_event` ADD CONSTRAINT `fk_safety_adverse_event_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`serious_adverse_event` ADD CONSTRAINT `fk_safety_serious_adverse_event_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar` ADD CONSTRAINT `fk_safety_susar_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`ae_meddra_coding` ADD CONSTRAINT `fk_safety_ae_meddra_coding_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`causality_assessment` ADD CONSTRAINT `fk_safety_causality_assessment_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`causality_assessment` ADD CONSTRAINT `fk_safety_causality_assessment_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`narrative` ADD CONSTRAINT `fk_safety_narrative_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`icsr` ADD CONSTRAINT `fk_safety_icsr_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`expedited_report_deadline` ADD CONSTRAINT `fk_safety_expedited_report_deadline_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`ae_follow_up` ADD CONSTRAINT `fk_safety_ae_follow_up_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);

-- ========= safety --> supply (11 constraint(s)) =========
-- Requires: safety schema, supply schema
ALTER TABLE `clinical_trials_ecm`.`safety`.`adverse_event` ADD CONSTRAINT `fk_safety_adverse_event_imp_master_id` FOREIGN KEY (`imp_master_id`) REFERENCES `clinical_trials_ecm`.`supply`.`imp_master`(`imp_master_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`adverse_event` ADD CONSTRAINT `fk_safety_adverse_event_manufacture_batch_id` FOREIGN KEY (`manufacture_batch_id`) REFERENCES `clinical_trials_ecm`.`supply`.`manufacture_batch`(`manufacture_batch_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`serious_adverse_event` ADD CONSTRAINT `fk_safety_serious_adverse_event_imp_master_id` FOREIGN KEY (`imp_master_id`) REFERENCES `clinical_trials_ecm`.`supply`.`imp_master`(`imp_master_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`susar` ADD CONSTRAINT `fk_safety_susar_imp_master_id` FOREIGN KEY (`imp_master_id`) REFERENCES `clinical_trials_ecm`.`supply`.`imp_master`(`imp_master_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`causality_assessment` ADD CONSTRAINT `fk_safety_causality_assessment_dispensing_record_id` FOREIGN KEY (`dispensing_record_id`) REFERENCES `clinical_trials_ecm`.`supply`.`dispensing_record`(`dispensing_record_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`icsr` ADD CONSTRAINT `fk_safety_icsr_imp_master_id` FOREIGN KEY (`imp_master_id`) REFERENCES `clinical_trials_ecm`.`supply`.`imp_master`(`imp_master_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal` ADD CONSTRAINT `fk_safety_signal_imp_master_id` FOREIGN KEY (`imp_master_id`) REFERENCES `clinical_trials_ecm`.`supply`.`imp_master`(`imp_master_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`reporting_obligation` ADD CONSTRAINT `fk_safety_reporting_obligation_imp_master_id` FOREIGN KEY (`imp_master_id`) REFERENCES `clinical_trials_ecm`.`supply`.`imp_master`(`imp_master_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_imp_master_id` FOREIGN KEY (`imp_master_id`) REFERENCES `clinical_trials_ecm`.`supply`.`imp_master`(`imp_master_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`safety_communication` ADD CONSTRAINT `fk_safety_safety_communication_imp_master_id` FOREIGN KEY (`imp_master_id`) REFERENCES `clinical_trials_ecm`.`supply`.`imp_master`(`imp_master_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`benefit_risk_assessment` ADD CONSTRAINT `fk_safety_benefit_risk_assessment_imp_master_id` FOREIGN KEY (`imp_master_id`) REFERENCES `clinical_trials_ecm`.`supply`.`imp_master`(`imp_master_id`);

-- ========= safety --> workforce (13 constraint(s)) =========
-- Requires: safety schema, workforce schema
ALTER TABLE `clinical_trials_ecm`.`safety`.`ae_meddra_coding` ADD CONSTRAINT `fk_safety_ae_meddra_coding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`ae_meddra_coding` ADD CONSTRAINT `fk_safety_ae_meddra_coding_tertiary_ae_coder_employee_id` FOREIGN KEY (`tertiary_ae_coder_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`causality_assessment` ADD CONSTRAINT `fk_safety_causality_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`narrative` ADD CONSTRAINT `fk_safety_narrative_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal` ADD CONSTRAINT `fk_safety_signal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`signal_evaluation` ADD CONSTRAINT `fk_safety_signal_evaluation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsmb_recommendation` ADD CONSTRAINT `fk_safety_dsmb_recommendation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`reporting_obligation` ADD CONSTRAINT `fk_safety_reporting_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`dsur` ADD CONSTRAINT `fk_safety_dsur_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`investigator_brochure_safety` ADD CONSTRAINT `fk_safety_investigator_brochure_safety_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`safety_communication` ADD CONSTRAINT `fk_safety_safety_communication_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`benefit_risk_assessment` ADD CONSTRAINT `fk_safety_benefit_risk_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`safety`.`committee_membership` ADD CONSTRAINT `fk_safety_committee_membership_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= site --> agreement (5 constraint(s)) =========
-- Requires: site schema, agreement schema
ALTER TABLE `clinical_trials_ecm`.`site`.`feasibility_assessment` ADD CONSTRAINT `fk_site_feasibility_assessment_confidentiality_agreement_id` FOREIGN KEY (`confidentiality_agreement_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`confidentiality_agreement`(`confidentiality_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`enrollment_performance` ADD CONSTRAINT `fk_site_enrollment_performance_investigator_grant_id` FOREIGN KEY (`investigator_grant_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`investigator_grant`(`investigator_grant_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`site_agreement` ADD CONSTRAINT `fk_site_site_agreement_confidentiality_agreement_id` FOREIGN KEY (`confidentiality_agreement_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`confidentiality_agreement`(`confidentiality_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`site_agreement` ADD CONSTRAINT `fk_site_site_agreement_study_contract_id` FOREIGN KEY (`study_contract_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`study_contract`(`study_contract_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_investigator_grant_id` FOREIGN KEY (`investigator_grant_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`investigator_grant`(`investigator_grant_id`);

-- ========= site --> biostatistics (6 constraint(s)) =========
-- Requires: site schema, biostatistics schema
ALTER TABLE `clinical_trials_ecm`.`site`.`feasibility_assessment` ADD CONSTRAINT `fk_site_feasibility_assessment_sample_size_calc_id` FOREIGN KEY (`sample_size_calc_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sample_size_calc`(`sample_size_calc_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`selection` ADD CONSTRAINT `fk_site_selection_sample_size_calc_id` FOREIGN KEY (`sample_size_calc_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sample_size_calc`(`sample_size_calc_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`enrollment_performance` ADD CONSTRAINT `fk_site_enrollment_performance_database_lock_event_id` FOREIGN KEY (`database_lock_event_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`database_lock_event`(`database_lock_event_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`enrollment_performance` ADD CONSTRAINT `fk_site_enrollment_performance_interim_analysis_id` FOREIGN KEY (`interim_analysis_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`interim_analysis`(`interim_analysis_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`capacity` ADD CONSTRAINT `fk_site_capacity_sample_size_calc_id` FOREIGN KEY (`sample_size_calc_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sample_size_calc`(`sample_size_calc_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_database_lock_event_id` FOREIGN KEY (`database_lock_event_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`database_lock_event`(`database_lock_event_id`);

-- ========= site --> compliance (15 constraint(s)) =========
-- Requires: site schema, compliance schema
ALTER TABLE `clinical_trials_ecm`.`site`.`activation` ADD CONSTRAINT `fk_site_activation_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`activation` ADD CONSTRAINT `fk_site_activation_ethics_approval_id` FOREIGN KEY (`ethics_approval_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_approval`(`ethics_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`irb_iec_approval` ADD CONSTRAINT `fk_site_irb_iec_approval_ethics_approval_id` FOREIGN KEY (`ethics_approval_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_approval`(`ethics_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`irb_iec_approval` ADD CONSTRAINT `fk_site_irb_iec_approval_ethics_committee_id` FOREIGN KEY (`ethics_committee_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_committee`(`ethics_committee_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`irb_iec_approval` ADD CONSTRAINT `fk_site_irb_iec_approval_ethics_submission_id` FOREIGN KEY (`ethics_submission_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_submission`(`ethics_submission_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`regulatory_submission_site` ADD CONSTRAINT `fk_site_regulatory_submission_site_ethics_committee_id` FOREIGN KEY (`ethics_committee_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_committee`(`ethics_committee_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`regulatory_submission_site` ADD CONSTRAINT `fk_site_regulatory_submission_site_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`initiation_visit` ADD CONSTRAINT `fk_site_initiation_visit_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`initiation_visit` ADD CONSTRAINT `fk_site_initiation_visit_ethics_approval_id` FOREIGN KEY (`ethics_approval_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_approval`(`ethics_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`enrollment_performance` ADD CONSTRAINT `fk_site_enrollment_performance_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`site_agreement` ADD CONSTRAINT `fk_site_site_agreement_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`site_cra_assignment` ADD CONSTRAINT `fk_site_site_cra_assignment_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_compliance_capa_id` FOREIGN KEY (`compliance_capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_capa`(`compliance_capa_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`site_selection_committee` ADD CONSTRAINT `fk_site_site_selection_committee_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);

-- ========= site --> data (3 constraint(s)) =========
-- Requires: site schema, data schema
ALTER TABLE `clinical_trials_ecm`.`site`.`activation` ADD CONSTRAINT `fk_site_activation_edc_study_build_id` FOREIGN KEY (`edc_study_build_id`) REFERENCES `clinical_trials_ecm`.`data`.`edc_study_build`(`edc_study_build_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`initiation_visit` ADD CONSTRAINT `fk_site_initiation_visit_edc_study_build_id` FOREIGN KEY (`edc_study_build_id`) REFERENCES `clinical_trials_ecm`.`data`.`edc_study_build`(`edc_study_build_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_reconciliation_id` FOREIGN KEY (`reconciliation_id`) REFERENCES `clinical_trials_ecm`.`data`.`reconciliation`(`reconciliation_id`);

-- ========= site --> document (8 constraint(s)) =========
-- Requires: site schema, document schema
ALTER TABLE `clinical_trials_ecm`.`site`.`feasibility_assessment` ADD CONSTRAINT `fk_site_feasibility_assessment_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`selection` ADD CONSTRAINT `fk_site_selection_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`activation` ADD CONSTRAINT `fk_site_activation_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`regulatory_submission_site` ADD CONSTRAINT `fk_site_regulatory_submission_site_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`regulatory_submission_site` ADD CONSTRAINT `fk_site_regulatory_submission_site_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`initiation_visit` ADD CONSTRAINT `fk_site_initiation_visit_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`site_agreement` ADD CONSTRAINT `fk_site_site_agreement_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);

-- ========= site --> finance (9 constraint(s)) =========
-- Requires: site schema, finance schema
ALTER TABLE `clinical_trials_ecm`.`site`.`activation` ADD CONSTRAINT `fk_site_activation_study_budget_id` FOREIGN KEY (`study_budget_id`) REFERENCES `clinical_trials_ecm`.`finance`.`study_budget`(`study_budget_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`regulatory_submission_site` ADD CONSTRAINT `fk_site_regulatory_submission_site_finance_billing_milestone_id` FOREIGN KEY (`finance_billing_milestone_id`) REFERENCES `clinical_trials_ecm`.`finance`.`finance_billing_milestone`(`finance_billing_milestone_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`initiation_visit` ADD CONSTRAINT `fk_site_initiation_visit_finance_billing_milestone_id` FOREIGN KEY (`finance_billing_milestone_id`) REFERENCES `clinical_trials_ecm`.`finance`.`finance_billing_milestone`(`finance_billing_milestone_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`enrollment_performance` ADD CONSTRAINT `fk_site_enrollment_performance_finance_billing_milestone_id` FOREIGN KEY (`finance_billing_milestone_id`) REFERENCES `clinical_trials_ecm`.`finance`.`finance_billing_milestone`(`finance_billing_milestone_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`site_agreement` ADD CONSTRAINT `fk_site_site_agreement_finance_billing_milestone_id` FOREIGN KEY (`finance_billing_milestone_id`) REFERENCES `clinical_trials_ecm`.`finance`.`finance_billing_milestone`(`finance_billing_milestone_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`site_agreement` ADD CONSTRAINT `fk_site_site_agreement_study_budget_id` FOREIGN KEY (`study_budget_id`) REFERENCES `clinical_trials_ecm`.`finance`.`study_budget`(`study_budget_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`site_cra_assignment` ADD CONSTRAINT `fk_site_site_cra_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `clinical_trials_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_site_payment_id` FOREIGN KEY (`site_payment_id`) REFERENCES `clinical_trials_ecm`.`finance`.`site_payment`(`site_payment_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_finance_billing_milestone_id` FOREIGN KEY (`finance_billing_milestone_id`) REFERENCES `clinical_trials_ecm`.`finance`.`finance_billing_milestone`(`finance_billing_milestone_id`);

-- ========= site --> laboratory (5 constraint(s)) =========
-- Requires: site schema, laboratory schema
ALTER TABLE `clinical_trials_ecm`.`site`.`investigational_site` ADD CONSTRAINT `fk_site_investigational_site_lab_facility_id` FOREIGN KEY (`lab_facility_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_facility`(`lab_facility_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`feasibility_assessment` ADD CONSTRAINT `fk_site_feasibility_assessment_lab_facility_id` FOREIGN KEY (`lab_facility_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_facility`(`lab_facility_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`study_site` ADD CONSTRAINT `fk_site_study_site_lab_facility_id` FOREIGN KEY (`lab_facility_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_facility`(`lab_facility_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`activation` ADD CONSTRAINT `fk_site_activation_lab_facility_id` FOREIGN KEY (`lab_facility_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_facility`(`lab_facility_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`initiation_visit` ADD CONSTRAINT `fk_site_initiation_visit_lab_facility_id` FOREIGN KEY (`lab_facility_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_facility`(`lab_facility_id`);

-- ========= site --> monitoring (4 constraint(s)) =========
-- Requires: site schema, monitoring schema
ALTER TABLE `clinical_trials_ecm`.`site`.`site_cra_assignment` ADD CONSTRAINT `fk_site_site_cra_assignment_monitoring_plan_id` FOREIGN KEY (`monitoring_plan_id`) REFERENCES `clinical_trials_ecm`.`monitoring`.`monitoring_plan`(`monitoring_plan_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_ip_accountability_log_id` FOREIGN KEY (`ip_accountability_log_id`) REFERENCES `clinical_trials_ecm`.`monitoring`.`ip_accountability_log`(`ip_accountability_log_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_monitoring_visit_id` FOREIGN KEY (`monitoring_visit_id`) REFERENCES `clinical_trials_ecm`.`monitoring`.`monitoring_visit`(`monitoring_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_visit_report_id` FOREIGN KEY (`visit_report_id`) REFERENCES `clinical_trials_ecm`.`monitoring`.`visit_report`(`visit_report_id`);

-- ========= site --> program (7 constraint(s)) =========
-- Requires: site schema, program schema
ALTER TABLE `clinical_trials_ecm`.`site`.`principal_investigator` ADD CONSTRAINT `fk_site_principal_investigator_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `clinical_trials_ecm`.`program`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`feasibility_assessment` ADD CONSTRAINT `fk_site_feasibility_assessment_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`feasibility_assessment` ADD CONSTRAINT `fk_site_feasibility_assessment_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `clinical_trials_ecm`.`program`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`capacity` ADD CONSTRAINT `fk_site_capacity_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `clinical_trials_ecm`.`program`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`site_agreement` ADD CONSTRAINT `fk_site_site_agreement_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`specialization` ADD CONSTRAINT `fk_site_specialization_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `clinical_trials_ecm`.`program`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`program_site_participation` ADD CONSTRAINT `fk_site_program_site_participation_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);

-- ========= site --> randomization (3 constraint(s)) =========
-- Requires: site schema, randomization schema
ALTER TABLE `clinical_trials_ecm`.`site`.`study_site` ADD CONSTRAINT `fk_site_study_site_rand_list_id` FOREIGN KEY (`rand_list_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_list`(`rand_list_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`activation` ADD CONSTRAINT `fk_site_activation_blinding_config_id` FOREIGN KEY (`blinding_config_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`blinding_config`(`blinding_config_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`activation` ADD CONSTRAINT `fk_site_activation_rand_scheme_id` FOREIGN KEY (`rand_scheme_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_scheme`(`rand_scheme_id`);

-- ========= site --> regulatory (10 constraint(s)) =========
-- Requires: site schema, regulatory schema
ALTER TABLE `clinical_trials_ecm`.`site`.`study_site` ADD CONSTRAINT `fk_site_study_site_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`activation` ADD CONSTRAINT `fk_site_activation_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`activation` ADD CONSTRAINT `fk_site_activation_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`irb_iec_approval` ADD CONSTRAINT `fk_site_irb_iec_approval_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`irb_iec_approval` ADD CONSTRAINT `fk_site_irb_iec_approval_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`regulatory_submission_site` ADD CONSTRAINT `fk_site_regulatory_submission_site_application_id` FOREIGN KEY (`application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`application`(`application_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`regulatory_submission_site` ADD CONSTRAINT `fk_site_regulatory_submission_site_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`initiation_visit` ADD CONSTRAINT `fk_site_initiation_visit_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`authorization` ADD CONSTRAINT `fk_site_authorization_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);

-- ========= site --> safety (5 constraint(s)) =========
-- Requires: site schema, safety schema
ALTER TABLE `clinical_trials_ecm`.`site`.`activation` ADD CONSTRAINT `fk_site_activation_investigator_brochure_safety_id` FOREIGN KEY (`investigator_brochure_safety_id`) REFERENCES `clinical_trials_ecm`.`safety`.`investigator_brochure_safety`(`investigator_brochure_safety_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`irb_iec_approval` ADD CONSTRAINT `fk_site_irb_iec_approval_investigator_brochure_safety_id` FOREIGN KEY (`investigator_brochure_safety_id`) REFERENCES `clinical_trials_ecm`.`safety`.`investigator_brochure_safety`(`investigator_brochure_safety_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`initiation_visit` ADD CONSTRAINT `fk_site_initiation_visit_investigator_brochure_safety_id` FOREIGN KEY (`investigator_brochure_safety_id`) REFERENCES `clinical_trials_ecm`.`safety`.`investigator_brochure_safety`(`investigator_brochure_safety_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`ib_site_distribution` ADD CONSTRAINT `fk_site_ib_site_distribution_investigator_brochure_safety_id` FOREIGN KEY (`investigator_brochure_safety_id`) REFERENCES `clinical_trials_ecm`.`safety`.`investigator_brochure_safety`(`investigator_brochure_safety_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`signal_review` ADD CONSTRAINT `fk_site_signal_review_signal_id` FOREIGN KEY (`signal_id`) REFERENCES `clinical_trials_ecm`.`safety`.`signal`(`signal_id`);

-- ========= site --> sponsor (11 constraint(s)) =========
-- Requires: site schema, sponsor schema
ALTER TABLE `clinical_trials_ecm`.`site`.`feasibility_assessment` ADD CONSTRAINT `fk_site_feasibility_assessment_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`feasibility_assessment` ADD CONSTRAINT `fk_site_feasibility_assessment_pipeline_asset_id` FOREIGN KEY (`pipeline_asset_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`pipeline_asset`(`pipeline_asset_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`activation` ADD CONSTRAINT `fk_site_activation_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`site_agreement` ADD CONSTRAINT `fk_site_site_agreement_master_agreement_id` FOREIGN KEY (`master_agreement_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`master_agreement`(`master_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`site_agreement` ADD CONSTRAINT `fk_site_site_agreement_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`site_cra_assignment` ADD CONSTRAINT `fk_site_site_cra_assignment_delivery_preference_id` FOREIGN KEY (`delivery_preference_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`delivery_preference`(`delivery_preference_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`site_cra_assignment` ADD CONSTRAINT `fk_site_site_cra_assignment_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`sponsor_site_qualification` ADD CONSTRAINT `fk_site_sponsor_site_qualification_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`pi_qualification` ADD CONSTRAINT `fk_site_pi_qualification_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`site_selection_committee` ADD CONSTRAINT `fk_site_site_selection_committee_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);

-- ========= site --> study (22 constraint(s)) =========
-- Requires: site schema, study schema
ALTER TABLE `clinical_trials_ecm`.`site`.`feasibility_assessment` ADD CONSTRAINT `fk_site_feasibility_assessment_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`feasibility_assessment` ADD CONSTRAINT `fk_site_feasibility_assessment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`selection` ADD CONSTRAINT `fk_site_selection_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`selection` ADD CONSTRAINT `fk_site_selection_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`study_site` ADD CONSTRAINT `fk_site_study_site_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`activation` ADD CONSTRAINT `fk_site_activation_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`activation` ADD CONSTRAINT `fk_site_activation_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`irb_iec_approval` ADD CONSTRAINT `fk_site_irb_iec_approval_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`irb_iec_approval` ADD CONSTRAINT `fk_site_irb_iec_approval_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`irb_iec_approval` ADD CONSTRAINT `fk_site_irb_iec_approval_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`regulatory_submission_site` ADD CONSTRAINT `fk_site_regulatory_submission_site_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`regulatory_submission_site` ADD CONSTRAINT `fk_site_regulatory_submission_site_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`regulatory_submission_site` ADD CONSTRAINT `fk_site_regulatory_submission_site_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`initiation_visit` ADD CONSTRAINT `fk_site_initiation_visit_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`initiation_visit` ADD CONSTRAINT `fk_site_initiation_visit_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`initiation_visit` ADD CONSTRAINT `fk_site_initiation_visit_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`enrollment_performance` ADD CONSTRAINT `fk_site_enrollment_performance_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`enrollment_performance` ADD CONSTRAINT `fk_site_enrollment_performance_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`site_agreement` ADD CONSTRAINT `fk_site_site_agreement_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`site_agreement` ADD CONSTRAINT `fk_site_site_agreement_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`site_cra_assignment` ADD CONSTRAINT `fk_site_site_cra_assignment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);

-- ========= site --> supply (1 constraint(s)) =========
-- Requires: site schema, supply schema
ALTER TABLE `clinical_trials_ecm`.`site`.`depot_assignment` ADD CONSTRAINT `fk_site_depot_assignment_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `clinical_trials_ecm`.`supply`.`depot`(`depot_id`);

-- ========= site --> workforce (15 constraint(s)) =========
-- Requires: site schema, workforce schema
ALTER TABLE `clinical_trials_ecm`.`site`.`feasibility_assessment` ADD CONSTRAINT `fk_site_feasibility_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`selection` ADD CONSTRAINT `fk_site_selection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`study_site` ADD CONSTRAINT `fk_site_study_site_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`activation` ADD CONSTRAINT `fk_site_activation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`regulatory_submission_site` ADD CONSTRAINT `fk_site_regulatory_submission_site_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`initiation_visit` ADD CONSTRAINT `fk_site_initiation_visit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`capacity` ADD CONSTRAINT `fk_site_capacity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`site_agreement` ADD CONSTRAINT `fk_site_site_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`site_cra_assignment` ADD CONSTRAINT `fk_site_site_cra_assignment_cra_qualification_id` FOREIGN KEY (`cra_qualification_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`cra_qualification`(`cra_qualification_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`site_cra_assignment` ADD CONSTRAINT `fk_site_site_cra_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`site_cra_assignment` ADD CONSTRAINT `fk_site_site_cra_assignment_quaternary_site_approved_by_workforce_employee_id` FOREIGN KEY (`quaternary_site_approved_by_workforce_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`site_cra_assignment` ADD CONSTRAINT `fk_site_site_cra_assignment_study_assignment_id` FOREIGN KEY (`study_assignment_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`study_assignment`(`study_assignment_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`site_cra_assignment` ADD CONSTRAINT `fk_site_site_cra_assignment_tertiary_site_cro_oversight_manager_employee_id` FOREIGN KEY (`tertiary_site_cro_oversight_manager_employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`closeout` ADD CONSTRAINT `fk_site_closeout_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`site`.`staff_roster` ADD CONSTRAINT `fk_site_staff_roster_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= sponsor --> agreement (18 constraint(s)) =========
-- Requires: sponsor schema, agreement schema
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`sponsor_engagement` ADD CONSTRAINT `fk_sponsor_sponsor_engagement_master_service_agreement_id` FOREIGN KEY (`master_service_agreement_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`master_service_agreement`(`master_service_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`sponsor_engagement` ADD CONSTRAINT `fk_sponsor_sponsor_engagement_preferred_provider_agreement_id` FOREIGN KEY (`preferred_provider_agreement_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`preferred_provider_agreement`(`preferred_provider_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`master_agreement` ADD CONSTRAINT `fk_sponsor_master_agreement_master_service_agreement_id` FOREIGN KEY (`master_service_agreement_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`master_service_agreement`(`master_service_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`master_agreement` ADD CONSTRAINT `fk_sponsor_master_agreement_preferred_provider_agreement_id` FOREIGN KEY (`preferred_provider_agreement_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`preferred_provider_agreement`(`preferred_provider_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`delivery_preference` ADD CONSTRAINT `fk_sponsor_delivery_preference_preferred_provider_agreement_id` FOREIGN KEY (`preferred_provider_agreement_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`preferred_provider_agreement`(`preferred_provider_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`interaction` ADD CONSTRAINT `fk_sponsor_interaction_study_contract_id` FOREIGN KEY (`study_contract_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`study_contract`(`study_contract_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`review_meeting` ADD CONSTRAINT `fk_sponsor_review_meeting_preferred_provider_agreement_id` FOREIGN KEY (`preferred_provider_agreement_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`preferred_provider_agreement`(`preferred_provider_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`review_meeting` ADD CONSTRAINT `fk_sponsor_review_meeting_study_contract_id` FOREIGN KEY (`study_contract_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`study_contract`(`study_contract_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`bid_request` ADD CONSTRAINT `fk_sponsor_bid_request_confidentiality_agreement_id` FOREIGN KEY (`confidentiality_agreement_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`confidentiality_agreement`(`confidentiality_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`bid_request` ADD CONSTRAINT `fk_sponsor_bid_request_master_service_agreement_id` FOREIGN KEY (`master_service_agreement_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`master_service_agreement`(`master_service_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`proposal` ADD CONSTRAINT `fk_sponsor_proposal_study_contract_id` FOREIGN KEY (`study_contract_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`study_contract`(`study_contract_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`proposal` ADD CONSTRAINT `fk_sponsor_proposal_master_service_agreement_id` FOREIGN KEY (`master_service_agreement_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`master_service_agreement`(`master_service_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`proposal` ADD CONSTRAINT `fk_sponsor_proposal_preferred_provider_agreement_id` FOREIGN KEY (`preferred_provider_agreement_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`preferred_provider_agreement`(`preferred_provider_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`proposal_line` ADD CONSTRAINT `fk_sponsor_proposal_line_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`rate_card`(`rate_card_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`escalation` ADD CONSTRAINT `fk_sponsor_escalation_service_level_agreement_id` FOREIGN KEY (`service_level_agreement_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`service_level_agreement`(`service_level_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`escalation` ADD CONSTRAINT `fk_sponsor_escalation_study_contract_id` FOREIGN KEY (`study_contract_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`study_contract`(`study_contract_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`account_plan` ADD CONSTRAINT `fk_sponsor_account_plan_master_service_agreement_id` FOREIGN KEY (`master_service_agreement_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`master_service_agreement`(`master_service_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`account_plan` ADD CONSTRAINT `fk_sponsor_account_plan_preferred_provider_agreement_id` FOREIGN KEY (`preferred_provider_agreement_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`preferred_provider_agreement`(`preferred_provider_agreement_id`);

-- ========= sponsor --> document (8 constraint(s)) =========
-- Requires: sponsor schema, document schema
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`master_agreement` ADD CONSTRAINT `fk_sponsor_master_agreement_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`delivery_preference` ADD CONSTRAINT `fk_sponsor_delivery_preference_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`delivery_preference` ADD CONSTRAINT `fk_sponsor_delivery_preference_template_id` FOREIGN KEY (`template_id`) REFERENCES `clinical_trials_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`interaction` ADD CONSTRAINT `fk_sponsor_interaction_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`review_meeting` ADD CONSTRAINT `fk_sponsor_review_meeting_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`bid_request` ADD CONSTRAINT `fk_sponsor_bid_request_template_id` FOREIGN KEY (`template_id`) REFERENCES `clinical_trials_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`proposal` ADD CONSTRAINT `fk_sponsor_proposal_template_id` FOREIGN KEY (`template_id`) REFERENCES `clinical_trials_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`escalation` ADD CONSTRAINT `fk_sponsor_escalation_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);

-- ========= sponsor --> program (23 constraint(s)) =========
-- Requires: sponsor schema, program schema
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`organization` ADD CONSTRAINT `fk_sponsor_organization_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `clinical_trials_ecm`.`program`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`pipeline_asset` ADD CONSTRAINT `fk_sponsor_pipeline_asset_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `clinical_trials_ecm`.`program`.`indication`(`indication_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`pipeline_asset` ADD CONSTRAINT `fk_sponsor_pipeline_asset_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `clinical_trials_ecm`.`program`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`pipeline_asset_phase` ADD CONSTRAINT `fk_sponsor_pipeline_asset_phase_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `clinical_trials_ecm`.`program`.`indication`(`indication_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`pipeline_asset_phase` ADD CONSTRAINT `fk_sponsor_pipeline_asset_phase_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `clinical_trials_ecm`.`program`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`study_portfolio` ADD CONSTRAINT `fk_sponsor_study_portfolio_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `clinical_trials_ecm`.`program`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`sponsor_engagement` ADD CONSTRAINT `fk_sponsor_sponsor_engagement_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`sponsor_engagement` ADD CONSTRAINT `fk_sponsor_sponsor_engagement_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `clinical_trials_ecm`.`program`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`master_agreement` ADD CONSTRAINT `fk_sponsor_master_agreement_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `clinical_trials_ecm`.`program`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`regulatory_strategy` ADD CONSTRAINT `fk_sponsor_regulatory_strategy_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`regulatory_strategy` ADD CONSTRAINT `fk_sponsor_regulatory_strategy_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `clinical_trials_ecm`.`program`.`indication`(`indication_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`regulatory_strategy` ADD CONSTRAINT `fk_sponsor_regulatory_strategy_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `clinical_trials_ecm`.`program`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`interaction` ADD CONSTRAINT `fk_sponsor_interaction_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`review_meeting` ADD CONSTRAINT `fk_sponsor_review_meeting_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`bid_request` ADD CONSTRAINT `fk_sponsor_bid_request_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`bid_request` ADD CONSTRAINT `fk_sponsor_bid_request_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `clinical_trials_ecm`.`program`.`indication`(`indication_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`bid_request` ADD CONSTRAINT `fk_sponsor_bid_request_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `clinical_trials_ecm`.`program`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`proposal` ADD CONSTRAINT `fk_sponsor_proposal_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`proposal` ADD CONSTRAINT `fk_sponsor_proposal_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `clinical_trials_ecm`.`program`.`indication`(`indication_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`proposal` ADD CONSTRAINT `fk_sponsor_proposal_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `clinical_trials_ecm`.`program`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`escalation` ADD CONSTRAINT `fk_sponsor_escalation_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`account_plan` ADD CONSTRAINT `fk_sponsor_account_plan_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`account_plan` ADD CONSTRAINT `fk_sponsor_account_plan_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `clinical_trials_ecm`.`program`.`therapeutic_area`(`therapeutic_area_id`);

-- ========= sponsor --> regulatory (18 constraint(s)) =========
-- Requires: sponsor schema, regulatory schema
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`pipeline_asset` ADD CONSTRAINT `fk_sponsor_pipeline_asset_application_id` FOREIGN KEY (`application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`application`(`application_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`pipeline_asset` ADD CONSTRAINT `fk_sponsor_pipeline_asset_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`pipeline_asset_phase` ADD CONSTRAINT `fk_sponsor_pipeline_asset_phase_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`pipeline_asset_phase` ADD CONSTRAINT `fk_sponsor_pipeline_asset_phase_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`pipeline_asset_phase` ADD CONSTRAINT `fk_sponsor_pipeline_asset_phase_regulatory_milestone_id` FOREIGN KEY (`regulatory_milestone_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_milestone`(`regulatory_milestone_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`regulatory_strategy` ADD CONSTRAINT `fk_sponsor_regulatory_strategy_application_id` FOREIGN KEY (`application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`application`(`application_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`regulatory_strategy` ADD CONSTRAINT `fk_sponsor_regulatory_strategy_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`regulatory_strategy` ADD CONSTRAINT `fk_sponsor_regulatory_strategy_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`regulatory_strategy` ADD CONSTRAINT `fk_sponsor_regulatory_strategy_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`strategy`(`strategy_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`interaction` ADD CONSTRAINT `fk_sponsor_interaction_agency_meeting_id` FOREIGN KEY (`agency_meeting_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`agency_meeting`(`agency_meeting_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`interaction` ADD CONSTRAINT `fk_sponsor_interaction_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`review_meeting` ADD CONSTRAINT `fk_sponsor_review_meeting_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`bid_request` ADD CONSTRAINT `fk_sponsor_bid_request_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`bid_request` ADD CONSTRAINT `fk_sponsor_bid_request_procedure_id` FOREIGN KEY (`procedure_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`procedure`(`procedure_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`proposal_line` ADD CONSTRAINT `fk_sponsor_proposal_line_procedure_id` FOREIGN KEY (`procedure_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`procedure`(`procedure_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`escalation` ADD CONSTRAINT `fk_sponsor_escalation_correspondence_id` FOREIGN KEY (`correspondence_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`correspondence`(`correspondence_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`escalation` ADD CONSTRAINT `fk_sponsor_escalation_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`engagement_scope` ADD CONSTRAINT `fk_sponsor_engagement_scope_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`health_authority`(`health_authority_id`);

-- ========= sponsor --> site (1 constraint(s)) =========
-- Requires: sponsor schema, site schema
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`escalation` ADD CONSTRAINT `fk_sponsor_escalation_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);

-- ========= sponsor --> study (3 constraint(s)) =========
-- Requires: sponsor schema, study schema
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`interaction` ADD CONSTRAINT `fk_sponsor_interaction_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`review_meeting` ADD CONSTRAINT `fk_sponsor_review_meeting_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`escalation` ADD CONSTRAINT `fk_sponsor_escalation_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);

-- ========= sponsor --> subject (3 constraint(s)) =========
-- Requires: sponsor schema, subject schema
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`escalation` ADD CONSTRAINT `fk_sponsor_escalation_disposition_id` FOREIGN KEY (`disposition_id`) REFERENCES `clinical_trials_ecm`.`subject`.`disposition`(`disposition_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`escalation` ADD CONSTRAINT `fk_sponsor_escalation_subject_deviation_id` FOREIGN KEY (`subject_deviation_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_deviation`(`subject_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`escalation` ADD CONSTRAINT `fk_sponsor_escalation_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);

-- ========= sponsor --> workforce (10 constraint(s)) =========
-- Requires: sponsor schema, workforce schema
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`study_portfolio` ADD CONSTRAINT `fk_sponsor_study_portfolio_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`sponsor_engagement` ADD CONSTRAINT `fk_sponsor_sponsor_engagement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`master_agreement` ADD CONSTRAINT `fk_sponsor_master_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`regulatory_strategy` ADD CONSTRAINT `fk_sponsor_regulatory_strategy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`interaction` ADD CONSTRAINT `fk_sponsor_interaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`review_meeting` ADD CONSTRAINT `fk_sponsor_review_meeting_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`bid_request` ADD CONSTRAINT `fk_sponsor_bid_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`proposal` ADD CONSTRAINT `fk_sponsor_proposal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`escalation` ADD CONSTRAINT `fk_sponsor_escalation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`sponsor`.`account_plan` ADD CONSTRAINT `fk_sponsor_account_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= study --> agreement (1 constraint(s)) =========
-- Requires: study schema, agreement schema
ALTER TABLE `clinical_trials_ecm`.`study`.`study_milestone` ADD CONSTRAINT `fk_study_study_milestone_agreement_billing_milestone_id` FOREIGN KEY (`agreement_billing_milestone_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`agreement_billing_milestone`(`agreement_billing_milestone_id`);

-- ========= study --> data (1 constraint(s)) =========
-- Requires: study schema, data schema
ALTER TABLE `clinical_trials_ecm`.`study`.`visit_procedure` ADD CONSTRAINT `fk_study_visit_procedure_ecrf_form_id` FOREIGN KEY (`ecrf_form_id`) REFERENCES `clinical_trials_ecm`.`data`.`ecrf_form`(`ecrf_form_id`);

-- ========= study --> document (7 constraint(s)) =========
-- Requires: study schema, document schema
ALTER TABLE `clinical_trials_ecm`.`study`.`study_protocol_amendment` ADD CONSTRAINT `fk_study_study_protocol_amendment_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`study_protocol_amendment` ADD CONSTRAINT `fk_study_study_protocol_amendment_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`study_protocol_amendment` ADD CONSTRAINT `fk_study_study_protocol_amendment_document_icf_version_id` FOREIGN KEY (`document_icf_version_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_icf_version`(`document_icf_version_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`country` ADD CONSTRAINT `fk_study_country_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`country` ADD CONSTRAINT `fk_study_country_document_icf_version_id` FOREIGN KEY (`document_icf_version_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_icf_version`(`document_icf_version_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`investigational_product` ADD CONSTRAINT `fk_study_investigational_product_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`investigational_product` ADD CONSTRAINT `fk_study_investigational_product_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);

-- ========= study --> laboratory (2 constraint(s)) =========
-- Requires: study schema, laboratory schema
ALTER TABLE `clinical_trials_ecm`.`study`.`visit_procedure` ADD CONSTRAINT `fk_study_visit_procedure_lab_panel_id` FOREIGN KEY (`lab_panel_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_panel`(`lab_panel_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`pk_sampling_schedule` ADD CONSTRAINT `fk_study_pk_sampling_schedule_bioanalytical_assay_id` FOREIGN KEY (`bioanalytical_assay_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`bioanalytical_assay`(`bioanalytical_assay_id`);

-- ========= study --> program (7 constraint(s)) =========
-- Requires: study schema, program schema
ALTER TABLE `clinical_trials_ecm`.`study`.`protocol` ADD CONSTRAINT `fk_study_protocol_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `clinical_trials_ecm`.`program`.`indication`(`indication_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`protocol` ADD CONSTRAINT `fk_study_protocol_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `clinical_trials_ecm`.`program`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`study_protocol_amendment` ADD CONSTRAINT `fk_study_study_protocol_amendment_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `clinical_trials_ecm`.`program`.`amendment`(`amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`study_study` ADD CONSTRAINT `fk_study_study_study_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `clinical_trials_ecm`.`program`.`indication`(`indication_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`study_study` ADD CONSTRAINT `fk_study_study_study_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `clinical_trials_ecm`.`program`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`study_milestone` ADD CONSTRAINT `fk_study_study_milestone_program_milestone_id` FOREIGN KEY (`program_milestone_id`) REFERENCES `clinical_trials_ecm`.`program`.`program_milestone`(`program_milestone_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`investigational_product` ADD CONSTRAINT `fk_study_investigational_product_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);

-- ========= study --> regulatory (9 constraint(s)) =========
-- Requires: study schema, regulatory schema
ALTER TABLE `clinical_trials_ecm`.`study`.`protocol` ADD CONSTRAINT `fk_study_protocol_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`study_protocol_amendment` ADD CONSTRAINT `fk_study_study_protocol_amendment_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`study_study` ADD CONSTRAINT `fk_study_study_study_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`country` ADD CONSTRAINT `fk_study_country_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`country` ADD CONSTRAINT `fk_study_country_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`investigational_product` ADD CONSTRAINT `fk_study_investigational_product_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`investigational_product` ADD CONSTRAINT `fk_study_investigational_product_nda_bla_application_id` FOREIGN KEY (`nda_bla_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`nda_bla_application`(`nda_bla_application_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`country_submission` ADD CONSTRAINT `fk_study_country_submission_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`product_designation` ADD CONSTRAINT `fk_study_product_designation_special_designation_id` FOREIGN KEY (`special_designation_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`special_designation`(`special_designation_id`);

-- ========= study --> safety (4 constraint(s)) =========
-- Requires: study schema, safety schema
ALTER TABLE `clinical_trials_ecm`.`study`.`endpoint` ADD CONSTRAINT `fk_study_endpoint_ctcae_grade_id` FOREIGN KEY (`ctcae_grade_id`) REFERENCES `clinical_trials_ecm`.`safety`.`ctcae_grade`(`ctcae_grade_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`endpoint` ADD CONSTRAINT `fk_study_endpoint_meddra_term_id` FOREIGN KEY (`meddra_term_id`) REFERENCES `clinical_trials_ecm`.`safety`.`meddra_term`(`meddra_term_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`eligibility_criterion` ADD CONSTRAINT `fk_study_eligibility_criterion_meddra_term_id` FOREIGN KEY (`meddra_term_id`) REFERENCES `clinical_trials_ecm`.`safety`.`meddra_term`(`meddra_term_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`visit_procedure` ADD CONSTRAINT `fk_study_visit_procedure_ctcae_grade_id` FOREIGN KEY (`ctcae_grade_id`) REFERENCES `clinical_trials_ecm`.`safety`.`ctcae_grade`(`ctcae_grade_id`);

-- ========= study --> site (3 constraint(s)) =========
-- Requires: study schema, site schema
ALTER TABLE `clinical_trials_ecm`.`study`.`study_milestone` ADD CONSTRAINT `fk_study_study_milestone_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`amendment_site_implementation` ADD CONSTRAINT `fk_study_amendment_site_implementation_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`ip_site_accountability` ADD CONSTRAINT `fk_study_ip_site_accountability_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);

-- ========= study --> sponsor (14 constraint(s)) =========
-- Requires: study schema, sponsor schema
ALTER TABLE `clinical_trials_ecm`.`study`.`protocol` ADD CONSTRAINT `fk_study_protocol_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`protocol` ADD CONSTRAINT `fk_study_protocol_regulatory_strategy_id` FOREIGN KEY (`regulatory_strategy_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`regulatory_strategy`(`regulatory_strategy_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`study_protocol_amendment` ADD CONSTRAINT `fk_study_study_protocol_amendment_sponsor_contact_id` FOREIGN KEY (`sponsor_contact_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`sponsor_contact`(`sponsor_contact_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`study_study` ADD CONSTRAINT `fk_study_study_study_delivery_preference_id` FOREIGN KEY (`delivery_preference_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`delivery_preference`(`delivery_preference_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`study_study` ADD CONSTRAINT `fk_study_study_study_master_agreement_id` FOREIGN KEY (`master_agreement_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`master_agreement`(`master_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`study_study` ADD CONSTRAINT `fk_study_study_study_sponsor_contact_id` FOREIGN KEY (`sponsor_contact_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`sponsor_contact`(`sponsor_contact_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`study_study` ADD CONSTRAINT `fk_study_study_study_sponsor_engagement_id` FOREIGN KEY (`sponsor_engagement_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`sponsor_engagement`(`sponsor_engagement_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`study_study` ADD CONSTRAINT `fk_study_study_study_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`study_study` ADD CONSTRAINT `fk_study_study_study_study_organization_id` FOREIGN KEY (`study_organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`study_study` ADD CONSTRAINT `fk_study_study_study_study_portfolio_id` FOREIGN KEY (`study_portfolio_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`study_portfolio`(`study_portfolio_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`study_milestone` ADD CONSTRAINT `fk_study_study_milestone_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`study_milestone` ADD CONSTRAINT `fk_study_study_milestone_sponsor_contact_id` FOREIGN KEY (`sponsor_contact_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`sponsor_contact`(`sponsor_contact_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`study_milestone` ADD CONSTRAINT `fk_study_study_milestone_sponsor_engagement_id` FOREIGN KEY (`sponsor_engagement_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`sponsor_engagement`(`sponsor_engagement_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`country` ADD CONSTRAINT `fk_study_country_regulatory_strategy_id` FOREIGN KEY (`regulatory_strategy_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`regulatory_strategy`(`regulatory_strategy_id`);

-- ========= study --> workforce (3 constraint(s)) =========
-- Requires: study schema, workforce schema
ALTER TABLE `clinical_trials_ecm`.`study`.`study_protocol_amendment` ADD CONSTRAINT `fk_study_study_protocol_amendment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`study_milestone` ADD CONSTRAINT `fk_study_study_milestone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`study`.`country` ADD CONSTRAINT `fk_study_country_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= subject --> agreement (3 constraint(s)) =========
-- Requires: subject schema, agreement schema
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_visit` ADD CONSTRAINT `fk_subject_subject_visit_agreement_billing_milestone_id` FOREIGN KEY (`agreement_billing_milestone_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`agreement_billing_milestone`(`agreement_billing_milestone_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`stipend_payment` ADD CONSTRAINT `fk_subject_stipend_payment_investigator_grant_id` FOREIGN KEY (`investigator_grant_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`investigator_grant`(`investigator_grant_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`stipend_payment` ADD CONSTRAINT `fk_subject_stipend_payment_change_order_id` FOREIGN KEY (`change_order_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`change_order`(`change_order_id`);

-- ========= subject --> biostatistics (7 constraint(s)) =========
-- Requires: subject schema, biostatistics schema
ALTER TABLE `clinical_trials_ecm`.`subject`.`randomization_assignment` ADD CONSTRAINT `fk_subject_randomization_assignment_sap_id` FOREIGN KEY (`sap_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sap`(`sap_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_deviation` ADD CONSTRAINT `fk_subject_subject_deviation_analysis_population_id` FOREIGN KEY (`analysis_population_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`analysis_population`(`analysis_population_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`disposition` ADD CONSTRAINT `fk_subject_disposition_estimand_id` FOREIGN KEY (`estimand_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`estimand`(`estimand_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`population_assignment` ADD CONSTRAINT `fk_subject_population_assignment_analysis_population_id` FOREIGN KEY (`analysis_population_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`analysis_population`(`analysis_population_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`population_assignment` ADD CONSTRAINT `fk_subject_population_assignment_database_lock_event_id` FOREIGN KEY (`database_lock_event_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`database_lock_event`(`database_lock_event_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`population_assignment` ADD CONSTRAINT `fk_subject_population_assignment_estimand_id` FOREIGN KEY (`estimand_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`estimand`(`estimand_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`population_assignment` ADD CONSTRAINT `fk_subject_population_assignment_sap_id` FOREIGN KEY (`sap_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sap`(`sap_id`);

-- ========= subject --> compliance (7 constraint(s)) =========
-- Requires: subject schema, compliance schema
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_deviation` ADD CONSTRAINT `fk_subject_subject_deviation_compliance_capa_id` FOREIGN KEY (`compliance_capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_capa`(`compliance_capa_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_deviation` ADD CONSTRAINT `fk_subject_subject_deviation_deviation_classification_id` FOREIGN KEY (`deviation_classification_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`deviation_classification`(`deviation_classification_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_deviation` ADD CONSTRAINT `fk_subject_subject_deviation_ethics_submission_id` FOREIGN KEY (`ethics_submission_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_submission`(`ethics_submission_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`disposition` ADD CONSTRAINT `fk_subject_disposition_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`eligibility_assessment` ADD CONSTRAINT `fk_subject_eligibility_assessment_ethics_approval_id` FOREIGN KEY (`ethics_approval_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_approval`(`ethics_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_status_history` ADD CONSTRAINT `fk_subject_subject_status_history_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`stipend_payment` ADD CONSTRAINT `fk_subject_stipend_payment_ethics_approval_id` FOREIGN KEY (`ethics_approval_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`ethics_approval`(`ethics_approval_id`);

-- ========= subject --> consent (10 constraint(s)) =========
-- Requires: subject schema, consent schema
ALTER TABLE `clinical_trials_ecm`.`subject`.`enrollment` ADD CONSTRAINT `fk_subject_enrollment_subject_consent_id` FOREIGN KEY (`subject_consent_id`) REFERENCES `clinical_trials_ecm`.`consent`.`subject_consent`(`subject_consent_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`randomization_assignment` ADD CONSTRAINT `fk_subject_randomization_assignment_subject_consent_id` FOREIGN KEY (`subject_consent_id`) REFERENCES `clinical_trials_ecm`.`consent`.`subject_consent`(`subject_consent_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_visit` ADD CONSTRAINT `fk_subject_subject_visit_subject_consent_id` FOREIGN KEY (`subject_consent_id`) REFERENCES `clinical_trials_ecm`.`consent`.`subject_consent`(`subject_consent_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`disposition` ADD CONSTRAINT `fk_subject_disposition_withdrawal_id` FOREIGN KEY (`withdrawal_id`) REFERENCES `clinical_trials_ecm`.`consent`.`withdrawal`(`withdrawal_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`eligibility_assessment` ADD CONSTRAINT `fk_subject_eligibility_assessment_consent_icf_version_id` FOREIGN KEY (`consent_icf_version_id`) REFERENCES `clinical_trials_ecm`.`consent`.`consent_icf_version`(`consent_icf_version_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`eligibility_assessment` ADD CONSTRAINT `fk_subject_eligibility_assessment_subject_consent_id` FOREIGN KEY (`subject_consent_id`) REFERENCES `clinical_trials_ecm`.`consent`.`subject_consent`(`subject_consent_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_status_history` ADD CONSTRAINT `fk_subject_subject_status_history_subject_consent_id` FOREIGN KEY (`subject_consent_id`) REFERENCES `clinical_trials_ecm`.`consent`.`subject_consent`(`subject_consent_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_contact` ADD CONSTRAINT `fk_subject_subject_contact_consent_icf_version_id` FOREIGN KEY (`consent_icf_version_id`) REFERENCES `clinical_trials_ecm`.`consent`.`consent_icf_version`(`consent_icf_version_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`stipend_payment` ADD CONSTRAINT `fk_subject_stipend_payment_subject_consent_id` FOREIGN KEY (`subject_consent_id`) REFERENCES `clinical_trials_ecm`.`consent`.`subject_consent`(`subject_consent_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`demographic` ADD CONSTRAINT `fk_subject_demographic_subject_consent_id` FOREIGN KEY (`subject_consent_id`) REFERENCES `clinical_trials_ecm`.`consent`.`subject_consent`(`subject_consent_id`);

-- ========= subject --> data (9 constraint(s)) =========
-- Requires: subject schema, data schema
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_visit` ADD CONSTRAINT `fk_subject_subject_visit_ecrf_form_id` FOREIGN KEY (`ecrf_form_id`) REFERENCES `clinical_trials_ecm`.`data`.`ecrf_form`(`ecrf_form_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`disposition` ADD CONSTRAINT `fk_subject_disposition_ecrf_form_id` FOREIGN KEY (`ecrf_form_id`) REFERENCES `clinical_trials_ecm`.`data`.`ecrf_form`(`ecrf_form_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`eligibility_assessment` ADD CONSTRAINT `fk_subject_eligibility_assessment_ecrf_form_id` FOREIGN KEY (`ecrf_form_id`) REFERENCES `clinical_trials_ecm`.`data`.`ecrf_form`(`ecrf_form_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`eligibility_assessment` ADD CONSTRAINT `fk_subject_eligibility_assessment_validation_rule_id` FOREIGN KEY (`validation_rule_id`) REFERENCES `clinical_trials_ecm`.`data`.`validation_rule`(`validation_rule_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`demographic` ADD CONSTRAINT `fk_subject_demographic_ecrf_form_id` FOREIGN KEY (`ecrf_form_id`) REFERENCES `clinical_trials_ecm`.`data`.`ecrf_form`(`ecrf_form_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`medical_history` ADD CONSTRAINT `fk_subject_medical_history_coding_assignment_id` FOREIGN KEY (`coding_assignment_id`) REFERENCES `clinical_trials_ecm`.`data`.`coding_assignment`(`coding_assignment_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`medical_history` ADD CONSTRAINT `fk_subject_medical_history_ecrf_form_id` FOREIGN KEY (`ecrf_form_id`) REFERENCES `clinical_trials_ecm`.`data`.`ecrf_form`(`ecrf_form_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`concomitant_medication` ADD CONSTRAINT `fk_subject_concomitant_medication_coding_assignment_id` FOREIGN KEY (`coding_assignment_id`) REFERENCES `clinical_trials_ecm`.`data`.`coding_assignment`(`coding_assignment_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`concomitant_medication` ADD CONSTRAINT `fk_subject_concomitant_medication_ecrf_form_id` FOREIGN KEY (`ecrf_form_id`) REFERENCES `clinical_trials_ecm`.`data`.`ecrf_form`(`ecrf_form_id`);

-- ========= subject --> document (6 constraint(s)) =========
-- Requires: subject schema, document schema
ALTER TABLE `clinical_trials_ecm`.`subject`.`enrollment` ADD CONSTRAINT `fk_subject_enrollment_document_icf_version_id` FOREIGN KEY (`document_icf_version_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_icf_version`(`document_icf_version_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_deviation` ADD CONSTRAINT `fk_subject_subject_deviation_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_deviation` ADD CONSTRAINT `fk_subject_subject_deviation_site_file_document_id` FOREIGN KEY (`site_file_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`site_file_document`(`site_file_document_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_status_history` ADD CONSTRAINT `fk_subject_subject_status_history_document_icf_version_id` FOREIGN KEY (`document_icf_version_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_icf_version`(`document_icf_version_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`stipend_payment` ADD CONSTRAINT `fk_subject_stipend_payment_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_subject_consent` ADD CONSTRAINT `fk_subject_subject_subject_consent_document_icf_version_id` FOREIGN KEY (`document_icf_version_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_icf_version`(`document_icf_version_id`);

-- ========= subject --> finance (2 constraint(s)) =========
-- Requires: subject schema, finance schema
ALTER TABLE `clinical_trials_ecm`.`subject`.`stipend_payment` ADD CONSTRAINT `fk_subject_stipend_payment_patient_stipend_id` FOREIGN KEY (`patient_stipend_id`) REFERENCES `clinical_trials_ecm`.`finance`.`patient_stipend`(`patient_stipend_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`visit_billing_reconciliation` ADD CONSTRAINT `fk_subject_visit_billing_reconciliation_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `clinical_trials_ecm`.`finance`.`invoice_line`(`invoice_line_id`);

-- ========= subject --> laboratory (3 constraint(s)) =========
-- Requires: subject schema, laboratory schema
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_deviation` ADD CONSTRAINT `fk_subject_subject_deviation_lab_result_id` FOREIGN KEY (`lab_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_result`(`lab_result_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`eligibility_assessment` ADD CONSTRAINT `fk_subject_eligibility_assessment_lab_result_id` FOREIGN KEY (`lab_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_result`(`lab_result_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`drug_lab_interaction` ADD CONSTRAINT `fk_subject_drug_lab_interaction_lab_result_id` FOREIGN KEY (`lab_result_id`) REFERENCES `clinical_trials_ecm`.`laboratory`.`lab_result`(`lab_result_id`);

-- ========= subject --> program (5 constraint(s)) =========
-- Requires: subject schema, program schema
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_deviation` ADD CONSTRAINT `fk_subject_subject_deviation_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `clinical_trials_ecm`.`program`.`amendment`(`amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`disposition` ADD CONSTRAINT `fk_subject_disposition_decision_id` FOREIGN KEY (`decision_id`) REFERENCES `clinical_trials_ecm`.`program`.`decision`(`decision_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_status_history` ADD CONSTRAINT `fk_subject_subject_status_history_decision_id` FOREIGN KEY (`decision_id`) REFERENCES `clinical_trials_ecm`.`program`.`decision`(`decision_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`population_assignment` ADD CONSTRAINT `fk_subject_population_assignment_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `clinical_trials_ecm`.`program`.`amendment`(`amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`population_assignment` ADD CONSTRAINT `fk_subject_population_assignment_decision_id` FOREIGN KEY (`decision_id`) REFERENCES `clinical_trials_ecm`.`program`.`decision`(`decision_id`);

-- ========= subject --> randomization (14 constraint(s)) =========
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
ALTER TABLE `clinical_trials_ecm`.`subject`.`disposition` ADD CONSTRAINT `fk_subject_disposition_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_status_history` ADD CONSTRAINT `fk_subject_subject_status_history_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`population_assignment` ADD CONSTRAINT `fk_subject_population_assignment_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`demographic` ADD CONSTRAINT `fk_subject_demographic_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);

-- ========= subject --> regulatory (6 constraint(s)) =========
-- Requires: subject schema, regulatory schema
ALTER TABLE `clinical_trials_ecm`.`subject`.`trial_subject` ADD CONSTRAINT `fk_subject_trial_subject_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`enrollment` ADD CONSTRAINT `fk_subject_enrollment_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`enrollment` ADD CONSTRAINT `fk_subject_enrollment_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_deviation` ADD CONSTRAINT `fk_subject_subject_deviation_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`eligibility_assessment` ADD CONSTRAINT `fk_subject_eligibility_assessment_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_status_history` ADD CONSTRAINT `fk_subject_subject_status_history_regulatory_protocol_amendment_id` FOREIGN KEY (`regulatory_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`regulatory_protocol_amendment`(`regulatory_protocol_amendment_id`);

-- ========= subject --> safety (4 constraint(s)) =========
-- Requires: subject schema, safety schema
ALTER TABLE `clinical_trials_ecm`.`subject`.`disposition` ADD CONSTRAINT `fk_subject_disposition_adverse_event_id` FOREIGN KEY (`adverse_event_id`) REFERENCES `clinical_trials_ecm`.`safety`.`adverse_event`(`adverse_event_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_status_history` ADD CONSTRAINT `fk_subject_subject_status_history_adverse_event_id` FOREIGN KEY (`adverse_event_id`) REFERENCES `clinical_trials_ecm`.`safety`.`adverse_event`(`adverse_event_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`medical_history` ADD CONSTRAINT `fk_subject_medical_history_adverse_event_id` FOREIGN KEY (`adverse_event_id`) REFERENCES `clinical_trials_ecm`.`safety`.`adverse_event`(`adverse_event_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`concomitant_medication` ADD CONSTRAINT `fk_subject_concomitant_medication_adverse_event_id` FOREIGN KEY (`adverse_event_id`) REFERENCES `clinical_trials_ecm`.`safety`.`adverse_event`(`adverse_event_id`);

-- ========= subject --> site (20 constraint(s)) =========
-- Requires: subject schema, site schema
ALTER TABLE `clinical_trials_ecm`.`subject`.`trial_subject` ADD CONSTRAINT `fk_subject_trial_subject_irb_iec_approval_id` FOREIGN KEY (`irb_iec_approval_id`) REFERENCES `clinical_trials_ecm`.`site`.`irb_iec_approval`(`irb_iec_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`trial_subject` ADD CONSTRAINT `fk_subject_trial_subject_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`enrollment` ADD CONSTRAINT `fk_subject_enrollment_irb_iec_approval_id` FOREIGN KEY (`irb_iec_approval_id`) REFERENCES `clinical_trials_ecm`.`site`.`irb_iec_approval`(`irb_iec_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`enrollment` ADD CONSTRAINT `fk_subject_enrollment_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `clinical_trials_ecm`.`site`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`enrollment` ADD CONSTRAINT `fk_subject_enrollment_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`randomization_assignment` ADD CONSTRAINT `fk_subject_randomization_assignment_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_visit` ADD CONSTRAINT `fk_subject_subject_visit_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `clinical_trials_ecm`.`site`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_visit` ADD CONSTRAINT `fk_subject_subject_visit_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_deviation` ADD CONSTRAINT `fk_subject_subject_deviation_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`disposition` ADD CONSTRAINT `fk_subject_disposition_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`eligibility_assessment` ADD CONSTRAINT `fk_subject_eligibility_assessment_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_status_history` ADD CONSTRAINT `fk_subject_subject_status_history_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_contact` ADD CONSTRAINT `fk_subject_subject_contact_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`stipend_payment` ADD CONSTRAINT `fk_subject_stipend_payment_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`stipend_payment` ADD CONSTRAINT `fk_subject_stipend_payment_irb_iec_approval_id` FOREIGN KEY (`irb_iec_approval_id`) REFERENCES `clinical_trials_ecm`.`site`.`irb_iec_approval`(`irb_iec_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`stipend_payment` ADD CONSTRAINT `fk_subject_stipend_payment_site_agreement_id` FOREIGN KEY (`site_agreement_id`) REFERENCES `clinical_trials_ecm`.`site`.`site_agreement`(`site_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`population_assignment` ADD CONSTRAINT `fk_subject_population_assignment_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`demographic` ADD CONSTRAINT `fk_subject_demographic_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`medical_history` ADD CONSTRAINT `fk_subject_medical_history_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`concomitant_medication` ADD CONSTRAINT `fk_subject_concomitant_medication_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);

-- ========= subject --> study (29 constraint(s)) =========
-- Requires: subject schema, study schema
ALTER TABLE `clinical_trials_ecm`.`subject`.`trial_subject` ADD CONSTRAINT `fk_subject_trial_subject_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`trial_subject` ADD CONSTRAINT `fk_subject_trial_subject_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`enrollment` ADD CONSTRAINT `fk_subject_enrollment_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`enrollment` ADD CONSTRAINT `fk_subject_enrollment_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`enrollment` ADD CONSTRAINT `fk_subject_enrollment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`randomization_assignment` ADD CONSTRAINT `fk_subject_randomization_assignment_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`randomization_assignment` ADD CONSTRAINT `fk_subject_randomization_assignment_dosing_regimen_id` FOREIGN KEY (`dosing_regimen_id`) REFERENCES `clinical_trials_ecm`.`study`.`dosing_regimen`(`dosing_regimen_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`randomization_assignment` ADD CONSTRAINT `fk_subject_randomization_assignment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_visit` ADD CONSTRAINT `fk_subject_subject_visit_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_visit` ADD CONSTRAINT `fk_subject_subject_visit_study_visit_schedule_id` FOREIGN KEY (`study_visit_schedule_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_visit_schedule`(`study_visit_schedule_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_deviation` ADD CONSTRAINT `fk_subject_subject_deviation_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_deviation` ADD CONSTRAINT `fk_subject_subject_deviation_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`disposition` ADD CONSTRAINT `fk_subject_disposition_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`disposition` ADD CONSTRAINT `fk_subject_disposition_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`eligibility_assessment` ADD CONSTRAINT `fk_subject_eligibility_assessment_eligibility_criterion_id` FOREIGN KEY (`eligibility_criterion_id`) REFERENCES `clinical_trials_ecm`.`study`.`eligibility_criterion`(`eligibility_criterion_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`eligibility_assessment` ADD CONSTRAINT `fk_subject_eligibility_assessment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`eligibility_assessment` ADD CONSTRAINT `fk_subject_eligibility_assessment_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_status_history` ADD CONSTRAINT `fk_subject_subject_status_history_epoch_id` FOREIGN KEY (`epoch_id`) REFERENCES `clinical_trials_ecm`.`study`.`epoch`(`epoch_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_status_history` ADD CONSTRAINT `fk_subject_subject_status_history_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_contact` ADD CONSTRAINT `fk_subject_subject_contact_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`stipend_payment` ADD CONSTRAINT `fk_subject_stipend_payment_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`stipend_payment` ADD CONSTRAINT `fk_subject_stipend_payment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`population_assignment` ADD CONSTRAINT `fk_subject_population_assignment_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`population_assignment` ADD CONSTRAINT `fk_subject_population_assignment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`population_assignment` ADD CONSTRAINT `fk_subject_population_assignment_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`demographic` ADD CONSTRAINT `fk_subject_demographic_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`demographic` ADD CONSTRAINT `fk_subject_demographic_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`medical_history` ADD CONSTRAINT `fk_subject_medical_history_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`concomitant_medication` ADD CONSTRAINT `fk_subject_concomitant_medication_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);

-- ========= subject --> workforce (12 constraint(s)) =========
-- Requires: subject schema, workforce schema
ALTER TABLE `clinical_trials_ecm`.`subject`.`enrollment` ADD CONSTRAINT `fk_subject_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`randomization_assignment` ADD CONSTRAINT `fk_subject_randomization_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_visit` ADD CONSTRAINT `fk_subject_subject_visit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_deviation` ADD CONSTRAINT `fk_subject_subject_deviation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`disposition` ADD CONSTRAINT `fk_subject_disposition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`eligibility_assessment` ADD CONSTRAINT `fk_subject_eligibility_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_status_history` ADD CONSTRAINT `fk_subject_subject_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`stipend_payment` ADD CONSTRAINT `fk_subject_stipend_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`population_assignment` ADD CONSTRAINT `fk_subject_population_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`medical_history` ADD CONSTRAINT `fk_subject_medical_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`subject_subject_consent` ADD CONSTRAINT `fk_subject_subject_subject_consent_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`subject`.`drug_lab_interaction` ADD CONSTRAINT `fk_subject_drug_lab_interaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= supply --> agreement (16 constraint(s)) =========
-- Requires: supply schema, agreement schema
ALTER TABLE `clinical_trials_ecm`.`supply`.`depot` ADD CONSTRAINT `fk_supply_depot_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`subcontract`(`subcontract_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_change_order_id` FOREIGN KEY (`change_order_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`change_order`(`change_order_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_scope_of_work_id` FOREIGN KEY (`scope_of_work_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`scope_of_work`(`scope_of_work_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_study_contract_id` FOREIGN KEY (`study_contract_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`study_contract`(`study_contract_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_agreement_billing_milestone_id` FOREIGN KEY (`agreement_billing_milestone_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`agreement_billing_milestone`(`agreement_billing_milestone_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`subcontract`(`subcontract_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`destruction_record` ADD CONSTRAINT `fk_supply_destruction_record_study_contract_id` FOREIGN KEY (`study_contract_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`study_contract`(`study_contract_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`temperature_excursion` ADD CONSTRAINT `fk_supply_temperature_excursion_service_level_agreement_id` FOREIGN KEY (`service_level_agreement_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`service_level_agreement`(`service_level_agreement_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_deliverable_id` FOREIGN KEY (`deliverable_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`deliverable`(`deliverable_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_study_contract_id` FOREIGN KEY (`study_contract_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`study_contract`(`study_contract_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`resupply_order` ADD CONSTRAINT `fk_supply_resupply_order_study_contract_id` FOREIGN KEY (`study_contract_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`study_contract`(`study_contract_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`import_permit` ADD CONSTRAINT `fk_supply_import_permit_study_contract_id` FOREIGN KEY (`study_contract_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`study_contract`(`study_contract_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`comparator_drug` ADD CONSTRAINT `fk_supply_comparator_drug_study_contract_id` FOREIGN KEY (`study_contract_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`study_contract`(`study_contract_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`ancillary_supply` ADD CONSTRAINT `fk_supply_ancillary_supply_scope_of_work_id` FOREIGN KEY (`scope_of_work_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`scope_of_work`(`scope_of_work_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`contracted_supply_item` ADD CONSTRAINT `fk_supply_contracted_supply_item_study_contract_id` FOREIGN KEY (`study_contract_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`study_contract`(`study_contract_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`depot_sla_coverage` ADD CONSTRAINT `fk_supply_depot_sla_coverage_service_level_agreement_id` FOREIGN KEY (`service_level_agreement_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`service_level_agreement`(`service_level_agreement_id`);

-- ========= supply --> biostatistics (4 constraint(s)) =========
-- Requires: supply schema, biostatistics schema
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_sample_size_calc_id` FOREIGN KEY (`sample_size_calc_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`sample_size_calc`(`sample_size_calc_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_database_lock_event_id` FOREIGN KEY (`database_lock_event_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`database_lock_event`(`database_lock_event_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_interim_analysis_id` FOREIGN KEY (`interim_analysis_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`interim_analysis`(`interim_analysis_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`resupply_order` ADD CONSTRAINT `fk_supply_resupply_order_interim_analysis_id` FOREIGN KEY (`interim_analysis_id`) REFERENCES `clinical_trials_ecm`.`biostatistics`.`interim_analysis`(`interim_analysis_id`);

-- ========= supply --> compliance (11 constraint(s)) =========
-- Requires: supply schema, compliance schema
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`return_record` ADD CONSTRAINT `fk_supply_return_record_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`destruction_record` ADD CONSTRAINT `fk_supply_destruction_record_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`temperature_excursion` ADD CONSTRAINT `fk_supply_temperature_excursion_compliance_capa_id` FOREIGN KEY (`compliance_capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_capa`(`compliance_capa_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`temperature_excursion` ADD CONSTRAINT `fk_supply_temperature_excursion_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`temperature_excursion` ADD CONSTRAINT `fk_supply_temperature_excursion_deviation_classification_id` FOREIGN KEY (`deviation_classification_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`deviation_classification`(`deviation_classification_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_inspection_finding_id` FOREIGN KEY (`inspection_finding_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`inspection_finding`(`inspection_finding_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`import_permit` ADD CONSTRAINT `fk_supply_import_permit_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`imp_sop_applicability` ADD CONSTRAINT `fk_supply_imp_sop_applicability_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);

-- ========= supply --> consent (3 constraint(s)) =========
-- Requires: supply schema, consent schema
ALTER TABLE `clinical_trials_ecm`.`supply`.`dispensing_record` ADD CONSTRAINT `fk_supply_dispensing_record_subject_consent_id` FOREIGN KEY (`subject_consent_id`) REFERENCES `clinical_trials_ecm`.`consent`.`subject_consent`(`subject_consent_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`return_record` ADD CONSTRAINT `fk_supply_return_record_withdrawal_id` FOREIGN KEY (`withdrawal_id`) REFERENCES `clinical_trials_ecm`.`consent`.`withdrawal`(`withdrawal_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`destruction_record` ADD CONSTRAINT `fk_supply_destruction_record_withdrawal_id` FOREIGN KEY (`withdrawal_id`) REFERENCES `clinical_trials_ecm`.`consent`.`withdrawal`(`withdrawal_id`);

-- ========= supply --> data (2 constraint(s)) =========
-- Requires: supply schema, data schema
ALTER TABLE `clinical_trials_ecm`.`supply`.`dispensing_record` ADD CONSTRAINT `fk_supply_dispensing_record_subject_visit_data_id` FOREIGN KEY (`subject_visit_data_id`) REFERENCES `clinical_trials_ecm`.`data`.`subject_visit_data`(`subject_visit_data_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_subject_visit_data_id` FOREIGN KEY (`subject_visit_data_id`) REFERENCES `clinical_trials_ecm`.`data`.`subject_visit_data`(`subject_visit_data_id`);

-- ========= supply --> document (14 constraint(s)) =========
-- Requires: supply schema, document schema
ALTER TABLE `clinical_trials_ecm`.`supply`.`imp_master` ADD CONSTRAINT `fk_supply_imp_master_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`imp_master` ADD CONSTRAINT `fk_supply_imp_master_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`kit_definition` ADD CONSTRAINT `fk_supply_kit_definition_template_id` FOREIGN KEY (`template_id`) REFERENCES `clinical_trials_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`depot` ADD CONSTRAINT `fk_supply_depot_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`manufacture_batch` ADD CONSTRAINT `fk_supply_manufacture_batch_regulatory_binder_id` FOREIGN KEY (`regulatory_binder_id`) REFERENCES `clinical_trials_ecm`.`document`.`regulatory_binder`(`regulatory_binder_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`dispensing_record` ADD CONSTRAINT `fk_supply_dispensing_record_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`destruction_record` ADD CONSTRAINT `fk_supply_destruction_record_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`destruction_record` ADD CONSTRAINT `fk_supply_destruction_record_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`temperature_excursion` ADD CONSTRAINT `fk_supply_temperature_excursion_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_document_sop_id` FOREIGN KEY (`document_sop_id`) REFERENCES `clinical_trials_ecm`.`document`.`document_sop`(`document_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`import_permit` ADD CONSTRAINT `fk_supply_import_permit_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`comparator_drug` ADD CONSTRAINT `fk_supply_comparator_drug_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`ancillary_supply` ADD CONSTRAINT `fk_supply_ancillary_supply_version_id` FOREIGN KEY (`version_id`) REFERENCES `clinical_trials_ecm`.`document`.`version`(`version_id`);

-- ========= supply --> finance (7 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_study_budget_id` FOREIGN KEY (`study_budget_id`) REFERENCES `clinical_trials_ecm`.`finance`.`study_budget`(`study_budget_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `clinical_trials_ecm`.`finance`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`destruction_record` ADD CONSTRAINT `fk_supply_destruction_record_vendor_invoice_id` FOREIGN KEY (`vendor_invoice_id`) REFERENCES `clinical_trials_ecm`.`finance`.`vendor_invoice`(`vendor_invoice_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`resupply_order` ADD CONSTRAINT `fk_supply_resupply_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `clinical_trials_ecm`.`finance`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`comparator_drug` ADD CONSTRAINT `fk_supply_comparator_drug_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `clinical_trials_ecm`.`finance`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`ancillary_supply` ADD CONSTRAINT `fk_supply_ancillary_supply_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `clinical_trials_ecm`.`finance`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`budget_allocation` ADD CONSTRAINT `fk_supply_budget_allocation_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `clinical_trials_ecm`.`finance`.`budget_line`(`budget_line_id`);

-- ========= supply --> monitoring (3 constraint(s)) =========
-- Requires: supply schema, monitoring schema
ALTER TABLE `clinical_trials_ecm`.`supply`.`destruction_record` ADD CONSTRAINT `fk_supply_destruction_record_monitoring_visit_id` FOREIGN KEY (`monitoring_visit_id`) REFERENCES `clinical_trials_ecm`.`monitoring`.`monitoring_visit`(`monitoring_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`temperature_excursion` ADD CONSTRAINT `fk_supply_temperature_excursion_monitoring_visit_id` FOREIGN KEY (`monitoring_visit_id`) REFERENCES `clinical_trials_ecm`.`monitoring`.`monitoring_visit`(`monitoring_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_monitoring_visit_id` FOREIGN KEY (`monitoring_visit_id`) REFERENCES `clinical_trials_ecm`.`monitoring`.`monitoring_visit`(`monitoring_visit_id`);

-- ========= supply --> program (9 constraint(s)) =========
-- Requires: supply schema, program schema
ALTER TABLE `clinical_trials_ecm`.`supply`.`imp_master` ADD CONSTRAINT `fk_supply_imp_master_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`imp_master` ADD CONSTRAINT `fk_supply_imp_master_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `clinical_trials_ecm`.`program`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `clinical_trials_ecm`.`program`.`budget`(`budget_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_program_plan_id` FOREIGN KEY (`program_plan_id`) REFERENCES `clinical_trials_ecm`.`program`.`program_plan`(`program_plan_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`manufacture_batch` ADD CONSTRAINT `fk_supply_manufacture_batch_program_milestone_id` FOREIGN KEY (`program_milestone_id`) REFERENCES `clinical_trials_ecm`.`program`.`program_milestone`(`program_milestone_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`comparator_drug` ADD CONSTRAINT `fk_supply_comparator_drug_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`comparator_drug` ADD CONSTRAINT `fk_supply_comparator_drug_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `clinical_trials_ecm`.`program`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`imp_indication_track` ADD CONSTRAINT `fk_supply_imp_indication_track_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `clinical_trials_ecm`.`program`.`indication`(`indication_id`);

-- ========= supply --> randomization (8 constraint(s)) =========
-- Requires: supply schema, randomization schema
ALTER TABLE `clinical_trials_ecm`.`supply`.`kit_definition` ADD CONSTRAINT `fk_supply_kit_definition_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`kit_inventory` ADD CONSTRAINT `fk_supply_kit_inventory_rand_code_id` FOREIGN KEY (`rand_code_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_code`(`rand_code_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`kit_inventory` ADD CONSTRAINT `fk_supply_kit_inventory_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_rand_scheme_id` FOREIGN KEY (`rand_scheme_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`rand_scheme`(`rand_scheme_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`return_record` ADD CONSTRAINT `fk_supply_return_record_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`temperature_excursion` ADD CONSTRAINT `fk_supply_temperature_excursion_kit_assignment_id` FOREIGN KEY (`kit_assignment_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`kit_assignment`(`kit_assignment_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_subject_randomization_id` FOREIGN KEY (`subject_randomization_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`subject_randomization`(`subject_randomization_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`resupply_order` ADD CONSTRAINT `fk_supply_resupply_order_treatment_arm_id` FOREIGN KEY (`treatment_arm_id`) REFERENCES `clinical_trials_ecm`.`randomization`.`treatment_arm`(`treatment_arm_id`);

-- ========= supply --> regulatory (14 constraint(s)) =========
-- Requires: supply schema, regulatory schema
ALTER TABLE `clinical_trials_ecm`.`supply`.`imp_master` ADD CONSTRAINT `fk_supply_imp_master_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`imp_master` ADD CONSTRAINT `fk_supply_imp_master_labeling_document_id` FOREIGN KEY (`labeling_document_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`labeling_document`(`labeling_document_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`imp_master` ADD CONSTRAINT `fk_supply_imp_master_special_designation_id` FOREIGN KEY (`special_designation_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`special_designation`(`special_designation_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`strategy`(`strategy_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`dispensing_record` ADD CONSTRAINT `fk_supply_dispensing_record_rems_program_id` FOREIGN KEY (`rems_program_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`rems_program`(`rems_program_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`destruction_record` ADD CONSTRAINT `fk_supply_destruction_record_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`resupply_order` ADD CONSTRAINT `fk_supply_resupply_order_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`import_permit` ADD CONSTRAINT `fk_supply_import_permit_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`import_permit` ADD CONSTRAINT `fk_supply_import_permit_ind_application_id` FOREIGN KEY (`ind_application_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`ind_application`(`ind_application_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`comparator_drug` ADD CONSTRAINT `fk_supply_comparator_drug_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`imp_authorization` ADD CONSTRAINT `fk_supply_imp_authorization_clinical_trial_authorization_id` FOREIGN KEY (`clinical_trial_authorization_id`) REFERENCES `clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`(`clinical_trial_authorization_id`);

-- ========= supply --> safety (1 constraint(s)) =========
-- Requires: supply schema, safety schema
ALTER TABLE `clinical_trials_ecm`.`supply`.`temperature_excursion` ADD CONSTRAINT `fk_supply_temperature_excursion_adverse_event_id` FOREIGN KEY (`adverse_event_id`) REFERENCES `clinical_trials_ecm`.`safety`.`adverse_event`(`adverse_event_id`);

-- ========= supply --> site (12 constraint(s)) =========
-- Requires: supply schema, site schema
ALTER TABLE `clinical_trials_ecm`.`supply`.`kit_inventory` ADD CONSTRAINT `fk_supply_kit_inventory_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`site_inventory` ADD CONSTRAINT `fk_supply_site_inventory_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_irb_iec_approval_id` FOREIGN KEY (`irb_iec_approval_id`) REFERENCES `clinical_trials_ecm`.`site`.`irb_iec_approval`(`irb_iec_approval_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`return_record` ADD CONSTRAINT `fk_supply_return_record_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`destruction_record` ADD CONSTRAINT `fk_supply_destruction_record_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`temperature_excursion` ADD CONSTRAINT `fk_supply_temperature_excursion_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_site_cra_assignment_id` FOREIGN KEY (`site_cra_assignment_id`) REFERENCES `clinical_trials_ecm`.`site`.`site_cra_assignment`(`site_cra_assignment_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`resupply_order` ADD CONSTRAINT `fk_supply_resupply_order_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`ancillary_supply` ADD CONSTRAINT `fk_supply_ancillary_supply_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);

-- ========= supply --> sponsor (7 constraint(s)) =========
-- Requires: supply schema, sponsor schema
ALTER TABLE `clinical_trials_ecm`.`supply`.`imp_master` ADD CONSTRAINT `fk_supply_imp_master_pipeline_asset_id` FOREIGN KEY (`pipeline_asset_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`pipeline_asset`(`pipeline_asset_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_delivery_preference_id` FOREIGN KEY (`delivery_preference_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`delivery_preference`(`delivery_preference_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_pipeline_asset_id` FOREIGN KEY (`pipeline_asset_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`pipeline_asset`(`pipeline_asset_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`import_permit` ADD CONSTRAINT `fk_supply_import_permit_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`import_permit` ADD CONSTRAINT `fk_supply_import_permit_regulatory_strategy_id` FOREIGN KEY (`regulatory_strategy_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`regulatory_strategy`(`regulatory_strategy_id`);

-- ========= supply --> study (23 constraint(s)) =========
-- Requires: supply schema, study schema
ALTER TABLE `clinical_trials_ecm`.`supply`.`kit_definition` ADD CONSTRAINT `fk_supply_kit_definition_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `clinical_trials_ecm`.`study`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`kit_inventory` ADD CONSTRAINT `fk_supply_kit_inventory_arm_id` FOREIGN KEY (`arm_id`) REFERENCES `clinical_trials_ecm`.`study`.`arm`(`arm_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`kit_inventory` ADD CONSTRAINT `fk_supply_kit_inventory_dosing_regimen_id` FOREIGN KEY (`dosing_regimen_id`) REFERENCES `clinical_trials_ecm`.`study`.`dosing_regimen`(`dosing_regimen_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`site_inventory` ADD CONSTRAINT `fk_supply_site_inventory_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_dosing_regimen_id` FOREIGN KEY (`dosing_regimen_id`) REFERENCES `clinical_trials_ecm`.`study`.`dosing_regimen`(`dosing_regimen_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `clinical_trials_ecm`.`study`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_country_id` FOREIGN KEY (`country_id`) REFERENCES `clinical_trials_ecm`.`study`.`country`(`country_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`dispensing_record` ADD CONSTRAINT `fk_supply_dispensing_record_study_visit_schedule_id` FOREIGN KEY (`study_visit_schedule_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_visit_schedule`(`study_visit_schedule_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`return_record` ADD CONSTRAINT `fk_supply_return_record_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`destruction_record` ADD CONSTRAINT `fk_supply_destruction_record_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`temperature_excursion` ADD CONSTRAINT `fk_supply_temperature_excursion_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`resupply_order` ADD CONSTRAINT `fk_supply_resupply_order_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`resupply_order` ADD CONSTRAINT `fk_supply_resupply_order_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`import_permit` ADD CONSTRAINT `fk_supply_import_permit_country_id` FOREIGN KEY (`country_id`) REFERENCES `clinical_trials_ecm`.`study`.`country`(`country_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`import_permit` ADD CONSTRAINT `fk_supply_import_permit_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`import_permit` ADD CONSTRAINT `fk_supply_import_permit_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`ancillary_supply` ADD CONSTRAINT `fk_supply_ancillary_supply_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`ancillary_supply` ADD CONSTRAINT `fk_supply_ancillary_supply_study_visit_schedule_id` FOREIGN KEY (`study_visit_schedule_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_visit_schedule`(`study_visit_schedule_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`depot_inventory` ADD CONSTRAINT `fk_supply_depot_inventory_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);

-- ========= supply --> subject (9 constraint(s)) =========
-- Requires: supply schema, subject schema
ALTER TABLE `clinical_trials_ecm`.`supply`.`kit_inventory` ADD CONSTRAINT `fk_supply_kit_inventory_enrollment_id` FOREIGN KEY (`enrollment_id`) REFERENCES `clinical_trials_ecm`.`subject`.`enrollment`(`enrollment_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`kit_inventory` ADD CONSTRAINT `fk_supply_kit_inventory_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`dispensing_record` ADD CONSTRAINT `fk_supply_dispensing_record_enrollment_id` FOREIGN KEY (`enrollment_id`) REFERENCES `clinical_trials_ecm`.`subject`.`enrollment`(`enrollment_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`dispensing_record` ADD CONSTRAINT `fk_supply_dispensing_record_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`dispensing_record` ADD CONSTRAINT `fk_supply_dispensing_record_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`return_record` ADD CONSTRAINT `fk_supply_return_record_enrollment_id` FOREIGN KEY (`enrollment_id`) REFERENCES `clinical_trials_ecm`.`subject`.`enrollment`(`enrollment_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`return_record` ADD CONSTRAINT `fk_supply_return_record_subject_deviation_id` FOREIGN KEY (`subject_deviation_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_deviation`(`subject_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`return_record` ADD CONSTRAINT `fk_supply_return_record_subject_visit_id` FOREIGN KEY (`subject_visit_id`) REFERENCES `clinical_trials_ecm`.`subject`.`subject_visit`(`subject_visit_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`return_record` ADD CONSTRAINT `fk_supply_return_record_trial_subject_id` FOREIGN KEY (`trial_subject_id`) REFERENCES `clinical_trials_ecm`.`subject`.`trial_subject`(`trial_subject_id`);

-- ========= supply --> workforce (14 constraint(s)) =========
-- Requires: supply schema, workforce schema
ALTER TABLE `clinical_trials_ecm`.`supply`.`imp_master` ADD CONSTRAINT `fk_supply_imp_master_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`kit_definition` ADD CONSTRAINT `fk_supply_kit_definition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`depot` ADD CONSTRAINT `fk_supply_depot_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`supply_plan` ADD CONSTRAINT `fk_supply_supply_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`manufacture_batch` ADD CONSTRAINT `fk_supply_manufacture_batch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`dispensing_record` ADD CONSTRAINT `fk_supply_dispensing_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`return_record` ADD CONSTRAINT `fk_supply_return_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`destruction_record` ADD CONSTRAINT `fk_supply_destruction_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`temperature_excursion` ADD CONSTRAINT `fk_supply_temperature_excursion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`accountability_reconciliation` ADD CONSTRAINT `fk_supply_accountability_reconciliation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`resupply_order` ADD CONSTRAINT `fk_supply_resupply_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`import_permit` ADD CONSTRAINT `fk_supply_import_permit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `clinical_trials_ecm`.`supply`.`comparator_drug` ADD CONSTRAINT `fk_supply_comparator_drug_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `clinical_trials_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= workforce --> agreement (1 constraint(s)) =========
-- Requires: workforce schema, agreement schema
ALTER TABLE `clinical_trials_ecm`.`workforce`.`workforce_resource_plan` ADD CONSTRAINT `fk_workforce_workforce_resource_plan_scope_of_work_id` FOREIGN KEY (`scope_of_work_id`) REFERENCES `clinical_trials_ecm`.`agreement`.`scope_of_work`(`scope_of_work_id`);

-- ========= workforce --> compliance (8 constraint(s)) =========
-- Requires: workforce schema, compliance schema
ALTER TABLE `clinical_trials_ecm`.`workforce`.`workforce_delegation_log` ADD CONSTRAINT `fk_workforce_workforce_delegation_log_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`training_record` ADD CONSTRAINT `fk_workforce_training_record_compliance_capa_id` FOREIGN KEY (`compliance_capa_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_capa`(`compliance_capa_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`training_record` ADD CONSTRAINT `fk_workforce_training_record_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`training_record` ADD CONSTRAINT `fk_workforce_training_record_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`protocol_deviation`(`protocol_deviation_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`training_curriculum` ADD CONSTRAINT `fk_workforce_training_curriculum_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`workforce_capa` ADD CONSTRAINT `fk_workforce_workforce_capa_compliance_sop_id` FOREIGN KEY (`compliance_sop_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`compliance_sop`(`compliance_sop_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`workforce_capa` ADD CONSTRAINT `fk_workforce_workforce_capa_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`workforce_capa` ADD CONSTRAINT `fk_workforce_workforce_capa_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `clinical_trials_ecm`.`compliance`.`obligation`(`obligation_id`);

-- ========= workforce --> document (7 constraint(s)) =========
-- Requires: workforce schema, document schema
ALTER TABLE `clinical_trials_ecm`.`workforce`.`gcp_training_record` ADD CONSTRAINT `fk_workforce_gcp_training_record_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`gcp_training_record` ADD CONSTRAINT `fk_workforce_gcp_training_record_signature_id` FOREIGN KEY (`signature_id`) REFERENCES `clinical_trials_ecm`.`document`.`signature`(`signature_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`workforce_delegation_log` ADD CONSTRAINT `fk_workforce_workforce_delegation_log_tmf_artifact_id` FOREIGN KEY (`tmf_artifact_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_artifact`(`tmf_artifact_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`training_record` ADD CONSTRAINT `fk_workforce_training_record_signature_id` FOREIGN KEY (`signature_id`) REFERENCES `clinical_trials_ecm`.`document`.`signature`(`signature_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`protocol_training_record` ADD CONSTRAINT `fk_workforce_protocol_training_record_tmf_artifact_id` FOREIGN KEY (`tmf_artifact_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_artifact`(`tmf_artifact_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`protocol_training_record` ADD CONSTRAINT `fk_workforce_protocol_training_record_tmf_document_id` FOREIGN KEY (`tmf_document_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_document`(`tmf_document_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`workforce_capa` ADD CONSTRAINT `fk_workforce_workforce_capa_tmf_artifact_id` FOREIGN KEY (`tmf_artifact_id`) REFERENCES `clinical_trials_ecm`.`document`.`tmf_artifact`(`tmf_artifact_id`);

-- ========= workforce --> finance (10 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `clinical_trials_ecm`.`workforce`.`study_assignment` ADD CONSTRAINT `fk_workforce_study_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `clinical_trials_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`study_assignment` ADD CONSTRAINT `fk_workforce_study_assignment_study_budget_id` FOREIGN KEY (`study_budget_id`) REFERENCES `clinical_trials_ecm`.`finance`.`study_budget`(`study_budget_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`workforce_resource_plan` ADD CONSTRAINT `fk_workforce_workforce_resource_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `clinical_trials_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`workforce_resource_plan` ADD CONSTRAINT `fk_workforce_workforce_resource_plan_study_budget_id` FOREIGN KEY (`study_budget_id`) REFERENCES `clinical_trials_ecm`.`finance`.`study_budget`(`study_budget_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `clinical_trials_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `clinical_trials_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_study_budget_id` FOREIGN KEY (`study_budget_id`) REFERENCES `clinical_trials_ecm`.`finance`.`study_budget`(`study_budget_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `clinical_trials_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `clinical_trials_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `clinical_trials_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= workforce --> program (5 constraint(s)) =========
-- Requires: workforce schema, program schema
ALTER TABLE `clinical_trials_ecm`.`workforce`.`workforce_resource_plan` ADD CONSTRAINT `fk_workforce_workforce_resource_plan_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`workforce_resource_plan` ADD CONSTRAINT `fk_workforce_workforce_resource_plan_program_plan_id` FOREIGN KEY (`program_plan_id`) REFERENCES `clinical_trials_ecm`.`program`.`program_plan`(`program_plan_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`workforce_resource_plan` ADD CONSTRAINT `fk_workforce_workforce_resource_plan_timeline_id` FOREIGN KEY (`timeline_id`) REFERENCES `clinical_trials_ecm`.`program`.`timeline`(`timeline_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`cra_qualification` ADD CONSTRAINT `fk_workforce_cra_qualification_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `clinical_trials_ecm`.`program`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`program_team_member` ADD CONSTRAINT `fk_workforce_program_team_member_clinical_program_id` FOREIGN KEY (`clinical_program_id`) REFERENCES `clinical_trials_ecm`.`program`.`clinical_program`(`clinical_program_id`);

-- ========= workforce --> site (4 constraint(s)) =========
-- Requires: workforce schema, site schema
ALTER TABLE `clinical_trials_ecm`.`workforce`.`gcp_training_record` ADD CONSTRAINT `fk_workforce_gcp_training_record_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`study_assignment` ADD CONSTRAINT `fk_workforce_study_assignment_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`workforce_delegation_log` ADD CONSTRAINT `fk_workforce_workforce_delegation_log_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`study_site`(`study_site_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`protocol_training_record` ADD CONSTRAINT `fk_workforce_protocol_training_record_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `clinical_trials_ecm`.`site`.`investigational_site`(`investigational_site_id`);

-- ========= workforce --> sponsor (4 constraint(s)) =========
-- Requires: workforce schema, sponsor schema
ALTER TABLE `clinical_trials_ecm`.`workforce`.`study_assignment` ADD CONSTRAINT `fk_workforce_study_assignment_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`training_curriculum` ADD CONSTRAINT `fk_workforce_training_curriculum_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`cra_qualification` ADD CONSTRAINT `fk_workforce_cra_qualification_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `clinical_trials_ecm`.`sponsor`.`organization`(`organization_id`);

-- ========= workforce --> study (10 constraint(s)) =========
-- Requires: workforce schema, study schema
ALTER TABLE `clinical_trials_ecm`.`workforce`.`gcp_training_record` ADD CONSTRAINT `fk_workforce_gcp_training_record_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`study_assignment` ADD CONSTRAINT `fk_workforce_study_assignment_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`workforce_delegation_log` ADD CONSTRAINT `fk_workforce_workforce_delegation_log_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`workforce_delegation_log` ADD CONSTRAINT `fk_workforce_workforce_delegation_log_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`workforce_resource_plan` ADD CONSTRAINT `fk_workforce_workforce_resource_plan_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`training_record` ADD CONSTRAINT `fk_workforce_training_record_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`protocol_training_record` ADD CONSTRAINT `fk_workforce_protocol_training_record_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `clinical_trials_ecm`.`study`.`protocol`(`protocol_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`protocol_training_record` ADD CONSTRAINT `fk_workforce_protocol_training_record_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`protocol_training_record` ADD CONSTRAINT `fk_workforce_protocol_training_record_study_protocol_amendment_id` FOREIGN KEY (`study_protocol_amendment_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_protocol_amendment`(`study_protocol_amendment_id`);
ALTER TABLE `clinical_trials_ecm`.`workforce`.`workforce_capa` ADD CONSTRAINT `fk_workforce_workforce_capa_study_id` FOREIGN KEY (`study_id`) REFERENCES `clinical_trials_ecm`.`study`.`study_study`(`study_id`);

