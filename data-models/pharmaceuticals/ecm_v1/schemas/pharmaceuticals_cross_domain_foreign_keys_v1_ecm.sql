-- Cross-Domain Foreign Keys for Business: Pharmaceuticals | Version: v1_ecm
-- Generated on: 2026-05-05 17:50:38
-- Total cross-domain FK constraints: 2013
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: clinical, commercial, compliance, discovery, finance, hcp, intellectual, manufacturing, market, masterdata, medical, patient, pharmacovigilance, procurement, product, quality, regulatory, supply, workforce

-- ========= clinical --> commercial (4 constraint(s)) =========
-- Requires: clinical schema, commercial schema
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`protocol` ADD CONSTRAINT `fk_clinical_protocol_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_adverse_event` ADD CONSTRAINT `fk_clinical_trial_adverse_event_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);

-- ========= clinical --> compliance (10 constraint(s)) =========
-- Requires: clinical schema, compliance schema
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_gxp_obligation_id` FOREIGN KEY (`gxp_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`gxp_obligation`(`gxp_obligation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`protocol` ADD CONSTRAINT `fk_clinical_protocol_gxp_obligation_id` FOREIGN KEY (`gxp_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`gxp_obligation`(`gxp_obligation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_site` ADD CONSTRAINT `fk_clinical_investigational_site_inspection_readiness_id` FOREIGN KEY (`inspection_readiness_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`inspection_readiness`(`inspection_readiness_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_site` ADD CONSTRAINT `fk_clinical_investigational_site_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_adverse_event` ADD CONSTRAINT `fk_clinical_trial_adverse_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_consent` ADD CONSTRAINT `fk_clinical_trial_consent_privacy_obligation_id` FOREIGN KEY (`privacy_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`privacy_obligation`(`privacy_obligation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_inspection_readiness_id` FOREIGN KEY (`inspection_readiness_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`inspection_readiness`(`inspection_readiness_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`biospecimen` ADD CONSTRAINT `fk_clinical_biospecimen_privacy_impact_assessment_id` FOREIGN KEY (`privacy_impact_assessment_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment`(`privacy_impact_assessment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`data_management_plan` ADD CONSTRAINT `fk_clinical_data_management_plan_part11_system_id` FOREIGN KEY (`part11_system_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`part11_system`(`part11_system_id`);

-- ========= clinical --> discovery (3 constraint(s)) =========
-- Requires: clinical schema, discovery schema
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_molecular_target_id` FOREIGN KEY (`molecular_target_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`molecular_target`(`molecular_target_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);

-- ========= clinical --> finance (8 constraint(s)) =========
-- Requires: clinical schema, finance schema
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`protocol` ADD CONSTRAINT `fk_clinical_protocol_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_site` ADD CONSTRAINT `fk_clinical_investigational_site_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_adverse_event` ADD CONSTRAINT `fk_clinical_trial_adverse_event_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_cogs_entry_id` FOREIGN KEY (`cogs_entry_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`cogs_entry`(`cogs_entry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_milestone` ADD CONSTRAINT `fk_clinical_trial_milestone_milestone_payment_id` FOREIGN KEY (`milestone_payment_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`milestone_payment`(`milestone_payment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`biospecimen` ADD CONSTRAINT `fk_clinical_biospecimen_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`monitoring_visit` ADD CONSTRAINT `fk_clinical_monitoring_visit_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);

-- ========= clinical --> hcp (8 constraint(s)) =========
-- Requires: clinical schema, hcp schema
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`principal_investigator` ADD CONSTRAINT `fk_clinical_principal_investigator_investigator_id` FOREIGN KEY (`investigator_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`investigator`(`investigator_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`principal_investigator` ADD CONSTRAINT `fk_clinical_principal_investigator_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`visit` ADD CONSTRAINT `fk_clinical_visit_investigator_id` FOREIGN KEY (`investigator_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`investigator`(`investigator_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_adverse_event` ADD CONSTRAINT `fk_clinical_trial_adverse_event_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_consent` ADD CONSTRAINT `fk_clinical_trial_consent_investigator_id` FOREIGN KEY (`investigator_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`investigator`(`investigator_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`imp_administration` ADD CONSTRAINT `fk_clinical_imp_administration_investigator_id` FOREIGN KEY (`investigator_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`investigator`(`investigator_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`site_affiliation` ADD CONSTRAINT `fk_clinical_site_affiliation_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_investigator` ADD CONSTRAINT `fk_clinical_trial_investigator_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);

-- ========= clinical --> intellectual (5 constraint(s)) =========
-- Requires: clinical schema, intellectual schema
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`protocol` ADD CONSTRAINT `fk_clinical_protocol_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);

-- ========= clinical --> manufacturing (5 constraint(s)) =========
-- Requires: clinical schema, manufacturing schema
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_milestone` ADD CONSTRAINT `fk_clinical_trial_milestone_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`data_management_plan` ADD CONSTRAINT `fk_clinical_data_management_plan_master_batch_record_id` FOREIGN KEY (`master_batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record`(`master_batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`imp_accountability` ADD CONSTRAINT `fk_clinical_imp_accountability_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`biobank` ADD CONSTRAINT `fk_clinical_biobank_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);

-- ========= clinical --> market (6 constraint(s)) =========
-- Requires: clinical schema, market schema
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`protocol` ADD CONSTRAINT `fk_clinical_protocol_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_adverse_event` ADD CONSTRAINT `fk_clinical_trial_adverse_event_hta_submission_id` FOREIGN KEY (`hta_submission_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`hta_submission`(`hta_submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_endpoint` ADD CONSTRAINT `fk_clinical_trial_endpoint_market_heor_study_id` FOREIGN KEY (`market_heor_study_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`market_heor_study`(`market_heor_study_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`biospecimen` ADD CONSTRAINT `fk_clinical_biospecimen_rwe_dataset_id` FOREIGN KEY (`rwe_dataset_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`rwe_dataset`(`rwe_dataset_id`);

-- ========= clinical --> masterdata (17 constraint(s)) =========
-- Requires: clinical schema, masterdata schema
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_site` ADD CONSTRAINT `fk_clinical_investigational_site_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_site` ADD CONSTRAINT `fk_clinical_investigational_site_address_id` FOREIGN KEY (`address_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`address`(`address_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_site` ADD CONSTRAINT `fk_clinical_investigational_site_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`principal_investigator` ADD CONSTRAINT `fk_clinical_principal_investigator_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`storage_location`(`storage_location_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`lab_result` ADD CONSTRAINT `fk_clinical_lab_result_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_milestone` ADD CONSTRAINT `fk_clinical_trial_milestone_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`biospecimen` ADD CONSTRAINT `fk_clinical_biospecimen_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`storage_location`(`storage_location_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`biospecimen` ADD CONSTRAINT `fk_clinical_biospecimen_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`monitoring_visit` ADD CONSTRAINT `fk_clinical_monitoring_visit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`data_management_plan` ADD CONSTRAINT `fk_clinical_data_management_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`biobank` ADD CONSTRAINT `fk_clinical_biobank_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);

-- ========= clinical --> medical (7 constraint(s)) =========
-- Requires: clinical schema, medical schema
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_affairs_plan_id` FOREIGN KEY (`affairs_plan_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`affairs_plan`(`affairs_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`protocol` ADD CONSTRAINT `fk_clinical_protocol_medical_publication_id` FOREIGN KEY (`medical_publication_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`medical_publication`(`medical_publication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_site` ADD CONSTRAINT `fk_clinical_investigational_site_msl_profile_id` FOREIGN KEY (`msl_profile_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`msl_profile`(`msl_profile_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`principal_investigator` ADD CONSTRAINT `fk_clinical_principal_investigator_medical_kol_profile_id` FOREIGN KEY (`medical_kol_profile_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`medical_kol_profile`(`medical_kol_profile_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_content_id` FOREIGN KEY (`content_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`content`(`content_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_endpoint` ADD CONSTRAINT `fk_clinical_trial_endpoint_evidence_gap_id` FOREIGN KEY (`evidence_gap_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`evidence_gap`(`evidence_gap_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`clinical_advisory_board_membership` ADD CONSTRAINT `fk_clinical_clinical_advisory_board_membership_medical_advisory_board_id` FOREIGN KEY (`medical_advisory_board_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`medical_advisory_board`(`medical_advisory_board_id`);

-- ========= clinical --> patient (8 constraint(s)) =========
-- Requires: clinical schema, patient schema
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`clinical_enrollment` ADD CONSTRAINT `fk_clinical_clinical_enrollment_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`visit` ADD CONSTRAINT `fk_clinical_visit_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`subject_observation` ADD CONSTRAINT `fk_clinical_subject_observation_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_adverse_event` ADD CONSTRAINT `fk_clinical_trial_adverse_event_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_consent` ADD CONSTRAINT `fk_clinical_trial_consent_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_endpoint` ADD CONSTRAINT `fk_clinical_trial_endpoint_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`lab_result` ADD CONSTRAINT `fk_clinical_lab_result_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`biospecimen` ADD CONSTRAINT `fk_clinical_biospecimen_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);

-- ========= clinical --> pharmacovigilance (3 constraint(s)) =========
-- Requires: clinical schema, pharmacovigilance schema
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`protocol` ADD CONSTRAINT `fk_clinical_protocol_rsi_id` FOREIGN KEY (`rsi_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`rsi`(`rsi_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`principal_investigator` ADD CONSTRAINT `fk_clinical_principal_investigator_reporter_id` FOREIGN KEY (`reporter_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`reporter`(`reporter_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_pv_product_id` FOREIGN KEY (`pv_product_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product`(`pv_product_id`);

-- ========= clinical --> procurement (7 constraint(s)) =========
-- Requires: clinical schema, procurement schema
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_supply_contract_id` FOREIGN KEY (`supply_contract_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`supply_contract`(`supply_contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_site` ADD CONSTRAINT `fk_clinical_investigational_site_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_vendor_site_id` FOREIGN KEY (`vendor_site_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor_site`(`vendor_site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`biospecimen` ADD CONSTRAINT `fk_clinical_biospecimen_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_vendor_engagement` ADD CONSTRAINT `fk_clinical_trial_vendor_engagement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= clinical --> product (9 constraint(s)) =========
-- Requires: clinical schema, product schema
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`protocol` ADD CONSTRAINT `fk_clinical_protocol_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`clinical_enrollment` ADD CONSTRAINT `fk_clinical_clinical_enrollment_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_adverse_event` ADD CONSTRAINT `fk_clinical_trial_adverse_event_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_endpoint` ADD CONSTRAINT `fk_clinical_trial_endpoint_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`lab_result` ADD CONSTRAINT `fk_clinical_lab_result_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`biospecimen` ADD CONSTRAINT `fk_clinical_biospecimen_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);

-- ========= clinical --> quality (8 constraint(s)) =========
-- Requires: clinical schema, quality schema
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_adverse_event` ADD CONSTRAINT `fk_clinical_trial_adverse_event_complaint_id` FOREIGN KEY (`complaint_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`complaint`(`complaint_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_adverse_event` ADD CONSTRAINT `fk_clinical_trial_adverse_event_quality_capa_id` FOREIGN KEY (`quality_capa_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_capa`(`quality_capa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_coa_id` FOREIGN KEY (`coa_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`coa`(`coa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_batch_disposition_id` FOREIGN KEY (`batch_disposition_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`batch_disposition`(`batch_disposition_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_stability_study_id` FOREIGN KEY (`stability_study_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`stability_study`(`stability_study_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`lab_result` ADD CONSTRAINT `fk_clinical_lab_result_lab_test_result_id` FOREIGN KEY (`lab_test_result_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`lab_test_result`(`lab_test_result_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`monitoring_visit` ADD CONSTRAINT `fk_clinical_monitoring_visit_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`audit`(`audit_id`);

-- ========= clinical --> regulatory (10 constraint(s)) =========
-- Requires: clinical schema, regulatory schema
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_application_id` FOREIGN KEY (`application_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`application`(`application_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`protocol` ADD CONSTRAINT `fk_clinical_protocol_application_id` FOREIGN KEY (`application_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`application`(`application_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_site` ADD CONSTRAINT `fk_clinical_investigational_site_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_adverse_event` ADD CONSTRAINT `fk_clinical_trial_adverse_event_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_dmf_id` FOREIGN KEY (`dmf_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`dmf`(`dmf_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_milestone` ADD CONSTRAINT `fk_clinical_trial_milestone_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`milestone`(`milestone_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_milestone` ADD CONSTRAINT `fk_clinical_trial_milestone_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`biospecimen` ADD CONSTRAINT `fk_clinical_biospecimen_dmf_id` FOREIGN KEY (`dmf_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`dmf`(`dmf_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`data_management_plan` ADD CONSTRAINT `fk_clinical_data_management_plan_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`cdisc_domain_map` ADD CONSTRAINT `fk_clinical_cdisc_domain_map_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);

-- ========= clinical --> supply (8 constraint(s)) =========
-- Requires: clinical schema, supply schema
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_demand_plan_id` FOREIGN KEY (`demand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`demand_plan`(`demand_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_site` ADD CONSTRAINT `fk_clinical_investigational_site_distribution_network_id` FOREIGN KEY (`distribution_network_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`distribution_network`(`distribution_network_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_adverse_event` ADD CONSTRAINT `fk_clinical_trial_adverse_event_product_recall_id` FOREIGN KEY (`product_recall_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`product_recall`(`product_recall_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`plan`(`plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`biospecimen` ADD CONSTRAINT `fk_clinical_biospecimen_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`site_imp_accountability` ADD CONSTRAINT `fk_clinical_site_imp_accountability_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`imp_accountability` ADD CONSTRAINT `fk_clinical_imp_accountability_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);

-- ========= clinical --> workforce (13 constraint(s)) =========
-- Requires: clinical schema, workforce schema
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_department_id` FOREIGN KEY (`department_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`department`(`department_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`protocol` ADD CONSTRAINT `fk_clinical_protocol_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_site` ADD CONSTRAINT `fk_clinical_investigational_site_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`crf_form` ADD CONSTRAINT `fk_clinical_crf_form_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`subject_observation` ADD CONSTRAINT `fk_clinical_subject_observation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_consent` ADD CONSTRAINT `fk_clinical_trial_consent_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_milestone` ADD CONSTRAINT `fk_clinical_trial_milestone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`biospecimen` ADD CONSTRAINT `fk_clinical_biospecimen_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`monitoring_visit` ADD CONSTRAINT `fk_clinical_monitoring_visit_position_id` FOREIGN KEY (`position_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`monitoring_visit` ADD CONSTRAINT `fk_clinical_monitoring_visit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`data_management_plan` ADD CONSTRAINT `fk_clinical_data_management_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`randomization_schedule` ADD CONSTRAINT `fk_clinical_randomization_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`cdisc_domain_map` ADD CONSTRAINT `fk_clinical_cdisc_domain_map_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= commercial --> clinical (5 constraint(s)) =========
-- Requires: commercial schema, clinical schema
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ADD CONSTRAINT `fk_commercial_hcp_target_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ADD CONSTRAINT `fk_commercial_call_activity_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ADD CONSTRAINT `fk_commercial_commercial_speaker_program_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ADD CONSTRAINT `fk_commercial_sunshine_disclosure_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`principal_investigator`(`principal_investigator_id`);

-- ========= commercial --> compliance (17 constraint(s)) =========
-- Requires: commercial schema, compliance schema
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ADD CONSTRAINT `fk_commercial_call_activity_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ADD CONSTRAINT `fk_commercial_promo_material_policy_document_id` FOREIGN KEY (`policy_document_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`policy_document`(`policy_document_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ADD CONSTRAINT `fk_commercial_promo_material_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ADD CONSTRAINT `fk_commercial_mlr_review_gxp_obligation_id` FOREIGN KEY (`gxp_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`gxp_obligation`(`gxp_obligation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ADD CONSTRAINT `fk_commercial_mlr_review_internal_control_id` FOREIGN KEY (`internal_control_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`internal_control`(`internal_control_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ADD CONSTRAINT `fk_commercial_commercial_speaker_program_fmv_assessment_id` FOREIGN KEY (`fmv_assessment_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`fmv_assessment`(`fmv_assessment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ADD CONSTRAINT `fk_commercial_commercial_speaker_program_monitoring_activity_id` FOREIGN KEY (`monitoring_activity_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`monitoring_activity`(`monitoring_activity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ADD CONSTRAINT `fk_commercial_commercial_speaker_program_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ADD CONSTRAINT `fk_commercial_speaker_engagement_conflict_of_interest_id` FOREIGN KEY (`conflict_of_interest_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest`(`conflict_of_interest_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ADD CONSTRAINT `fk_commercial_sunshine_disclosure_disclosure_id` FOREIGN KEY (`disclosure_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`disclosure`(`disclosure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ADD CONSTRAINT `fk_commercial_sunshine_disclosure_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_conflict_of_interest_id` FOREIGN KEY (`conflict_of_interest_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest`(`conflict_of_interest_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ADD CONSTRAINT `fk_commercial_patient_support_program_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ADD CONSTRAINT `fk_commercial_copay_program_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);

-- ========= commercial --> discovery (7 constraint(s)) =========
-- Requires: commercial schema, discovery schema
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_molecular_target_id` FOREIGN KEY (`molecular_target_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`molecular_target`(`molecular_target_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ADD CONSTRAINT `fk_commercial_call_activity_molecular_target_id` FOREIGN KEY (`molecular_target_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`molecular_target`(`molecular_target_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ADD CONSTRAINT `fk_commercial_promo_material_molecular_target_id` FOREIGN KEY (`molecular_target_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`molecular_target`(`molecular_target_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ADD CONSTRAINT `fk_commercial_commercial_speaker_program_molecular_target_id` FOREIGN KEY (`molecular_target_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`molecular_target`(`molecular_target_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);

-- ========= commercial --> finance (22 constraint(s)) =========
-- Requires: commercial schema, finance schema
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_royalty_agreement_id` FOREIGN KEY (`royalty_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`royalty_agreement`(`royalty_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ADD CONSTRAINT `fk_commercial_territory_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ADD CONSTRAINT `fk_commercial_sales_rep_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ADD CONSTRAINT `fk_commercial_sample_management_cogs_entry_id` FOREIGN KEY (`cogs_entry_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`cogs_entry`(`cogs_entry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ADD CONSTRAINT `fk_commercial_mlr_review_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ADD CONSTRAINT `fk_commercial_commercial_speaker_program_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ADD CONSTRAINT `fk_commercial_commercial_speaker_program_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ADD CONSTRAINT `fk_commercial_speaker_engagement_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ADD CONSTRAINT `fk_commercial_sunshine_disclosure_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_rd_capitalization_id` FOREIGN KEY (`rd_capitalization_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`rd_capitalization`(`rd_capitalization_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ADD CONSTRAINT `fk_commercial_patient_support_program_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ADD CONSTRAINT `fk_commercial_psp_enrollment_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ADD CONSTRAINT `fk_commercial_sales_performance_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ADD CONSTRAINT `fk_commercial_copay_program_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ADD CONSTRAINT `fk_commercial_copay_program_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ADD CONSTRAINT `fk_commercial_copay_redemption_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ADD CONSTRAINT `fk_commercial_copay_redemption_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ADD CONSTRAINT `fk_commercial_copay_redemption_cogs_entry_id` FOREIGN KEY (`cogs_entry_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`cogs_entry`(`cogs_entry_id`);

-- ========= commercial --> hcp (11 constraint(s)) =========
-- Requires: commercial schema, hcp schema
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ADD CONSTRAINT `fk_commercial_hcp_target_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ADD CONSTRAINT `fk_commercial_call_activity_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ADD CONSTRAINT `fk_commercial_call_activity_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ADD CONSTRAINT `fk_commercial_sample_management_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ADD CONSTRAINT `fk_commercial_commercial_speaker_program_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ADD CONSTRAINT `fk_commercial_speaker_engagement_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ADD CONSTRAINT `fk_commercial_speaker_engagement_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`contract`(`contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`contract`(`contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ADD CONSTRAINT `fk_commercial_psp_enrollment_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);

-- ========= commercial --> intellectual (16 constraint(s)) =========
-- Requires: commercial schema, intellectual schema
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_family`(`patent_family_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_trademark_id` FOREIGN KEY (`trademark_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`trademark`(`trademark_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ADD CONSTRAINT `fk_commercial_territory_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ADD CONSTRAINT `fk_commercial_promo_material_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ADD CONSTRAINT `fk_commercial_commercial_speaker_program_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ADD CONSTRAINT `fk_commercial_speaker_engagement_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ADD CONSTRAINT `fk_commercial_sunshine_disclosure_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ADD CONSTRAINT `fk_commercial_patient_support_program_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ADD CONSTRAINT `fk_commercial_psp_enrollment_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ADD CONSTRAINT `fk_commercial_contract_account_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ADD CONSTRAINT `fk_commercial_copay_program_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);

-- ========= commercial --> market (14 constraint(s)) =========
-- Requires: commercial schema, market schema
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_hta_submission_id` FOREIGN KEY (`hta_submission_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`hta_submission`(`hta_submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_pricing_decision_id` FOREIGN KEY (`pricing_decision_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`pricing_decision`(`pricing_decision_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ADD CONSTRAINT `fk_commercial_hcp_target_market_formulary_position_id` FOREIGN KEY (`market_formulary_position_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`market_formulary_position`(`market_formulary_position_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ADD CONSTRAINT `fk_commercial_call_activity_market_formulary_position_id` FOREIGN KEY (`market_formulary_position_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`market_formulary_position`(`market_formulary_position_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ADD CONSTRAINT `fk_commercial_sample_management_market_formulary_position_id` FOREIGN KEY (`market_formulary_position_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`market_formulary_position`(`market_formulary_position_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_payer_engagement_id` FOREIGN KEY (`payer_engagement_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`payer_engagement`(`payer_engagement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ADD CONSTRAINT `fk_commercial_patient_support_program_patient_access_program_id` FOREIGN KEY (`patient_access_program_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`patient_access_program`(`patient_access_program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ADD CONSTRAINT `fk_commercial_contract_account_payer_account_id` FOREIGN KEY (`payer_account_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`payer_account`(`payer_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ADD CONSTRAINT `fk_commercial_sales_performance_payer_account_id` FOREIGN KEY (`payer_account_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`payer_account`(`payer_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ADD CONSTRAINT `fk_commercial_copay_program_patient_access_program_id` FOREIGN KEY (`patient_access_program_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`patient_access_program`(`patient_access_program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ADD CONSTRAINT `fk_commercial_copay_redemption_gross_to_net_adjustment_id` FOREIGN KEY (`gross_to_net_adjustment_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment`(`gross_to_net_adjustment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_formulary_position` ADD CONSTRAINT `fk_commercial_commercial_formulary_position_payer_account_id` FOREIGN KEY (`payer_account_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`payer_account`(`payer_account_id`);

-- ========= commercial --> masterdata (31 constraint(s)) =========
-- Requires: commercial schema, masterdata schema
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_masterdata_ndc_code_id` FOREIGN KEY (`masterdata_ndc_code_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code`(`masterdata_ndc_code_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ADD CONSTRAINT `fk_commercial_territory_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ADD CONSTRAINT `fk_commercial_territory_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ADD CONSTRAINT `fk_commercial_sales_rep_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ADD CONSTRAINT `fk_commercial_sample_management_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ADD CONSTRAINT `fk_commercial_sample_management_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`storage_location`(`storage_location_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ADD CONSTRAINT `fk_commercial_promo_material_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ADD CONSTRAINT `fk_commercial_mlr_review_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ADD CONSTRAINT `fk_commercial_commercial_speaker_program_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ADD CONSTRAINT `fk_commercial_commercial_speaker_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ADD CONSTRAINT `fk_commercial_speaker_engagement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ADD CONSTRAINT `fk_commercial_sunshine_disclosure_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ADD CONSTRAINT `fk_commercial_patient_support_program_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ADD CONSTRAINT `fk_commercial_patient_support_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ADD CONSTRAINT `fk_commercial_psp_enrollment_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ADD CONSTRAINT `fk_commercial_contract_account_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ADD CONSTRAINT `fk_commercial_contract_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ADD CONSTRAINT `fk_commercial_sales_performance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ADD CONSTRAINT `fk_commercial_sales_performance_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ADD CONSTRAINT `fk_commercial_incentive_compensation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ADD CONSTRAINT `fk_commercial_copay_program_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ADD CONSTRAINT `fk_commercial_copay_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ADD CONSTRAINT `fk_commercial_copay_redemption_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`address`(`address_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_ship_to_address_id` FOREIGN KEY (`ship_to_address_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`address`(`address_id`);

-- ========= commercial --> medical (10 constraint(s)) =========
-- Requires: commercial schema, medical schema
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_affairs_plan_id` FOREIGN KEY (`affairs_plan_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`affairs_plan`(`affairs_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ADD CONSTRAINT `fk_commercial_hcp_target_msl_engagement_id` FOREIGN KEY (`msl_engagement_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`msl_engagement`(`msl_engagement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ADD CONSTRAINT `fk_commercial_call_activity_inquiry_id` FOREIGN KEY (`inquiry_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`inquiry`(`inquiry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ADD CONSTRAINT `fk_commercial_commercial_speaker_program_msl_profile_id` FOREIGN KEY (`msl_profile_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`msl_profile`(`msl_profile_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ADD CONSTRAINT `fk_commercial_sunshine_disclosure_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`grant`(`grant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_congress_event_id` FOREIGN KEY (`congress_event_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`congress_event`(`congress_event_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_medical_kol_profile_id` FOREIGN KEY (`medical_kol_profile_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`medical_kol_profile`(`medical_kol_profile_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ADD CONSTRAINT `fk_commercial_psp_enrollment_named_patient_request_id` FOREIGN KEY (`named_patient_request_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`named_patient_request`(`named_patient_request_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ADD CONSTRAINT `fk_commercial_sales_performance_affairs_plan_id` FOREIGN KEY (`affairs_plan_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`affairs_plan`(`affairs_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ADD CONSTRAINT `fk_commercial_copay_program_medical_heor_study_id` FOREIGN KEY (`medical_heor_study_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`medical_heor_study`(`medical_heor_study_id`);

-- ========= commercial --> patient (2 constraint(s)) =========
-- Requires: commercial schema, patient schema
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ADD CONSTRAINT `fk_commercial_psp_enrollment_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ADD CONSTRAINT `fk_commercial_copay_redemption_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);

-- ========= commercial --> procurement (8 constraint(s)) =========
-- Requires: commercial schema, procurement schema
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_sourcing_material_id` FOREIGN KEY (`sourcing_material_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`sourcing_material`(`sourcing_material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ADD CONSTRAINT `fk_commercial_promo_material_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ADD CONSTRAINT `fk_commercial_commercial_speaker_program_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ADD CONSTRAINT `fk_commercial_patient_support_program_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ADD CONSTRAINT `fk_commercial_patient_support_program_supply_contract_id` FOREIGN KEY (`supply_contract_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`supply_contract`(`supply_contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ADD CONSTRAINT `fk_commercial_copay_program_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ADD CONSTRAINT `fk_commercial_copay_redemption_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_supply_agreement` ADD CONSTRAINT `fk_commercial_brand_supply_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= commercial --> product (23 constraint(s)) =========
-- Requires: commercial schema, product schema
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ADD CONSTRAINT `fk_commercial_hcp_target_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ADD CONSTRAINT `fk_commercial_call_activity_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ADD CONSTRAINT `fk_commercial_call_activity_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ADD CONSTRAINT `fk_commercial_sample_management_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ADD CONSTRAINT `fk_commercial_sample_management_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ADD CONSTRAINT `fk_commercial_promo_material_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ADD CONSTRAINT `fk_commercial_mlr_review_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ADD CONSTRAINT `fk_commercial_mlr_review_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ADD CONSTRAINT `fk_commercial_commercial_speaker_program_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ADD CONSTRAINT `fk_commercial_speaker_engagement_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ADD CONSTRAINT `fk_commercial_speaker_engagement_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ADD CONSTRAINT `fk_commercial_sunshine_disclosure_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ADD CONSTRAINT `fk_commercial_patient_support_program_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ADD CONSTRAINT `fk_commercial_patient_support_program_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ADD CONSTRAINT `fk_commercial_psp_enrollment_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ADD CONSTRAINT `fk_commercial_sales_performance_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ADD CONSTRAINT `fk_commercial_copay_program_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ADD CONSTRAINT `fk_commercial_copay_program_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ADD CONSTRAINT `fk_commercial_copay_redemption_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);

-- ========= commercial --> quality (2 constraint(s)) =========
-- Requires: commercial schema, quality schema
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ADD CONSTRAINT `fk_commercial_promo_material_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ADD CONSTRAINT `fk_commercial_commercial_speaker_program_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`audit`(`audit_id`);

-- ========= commercial --> regulatory (1 constraint(s)) =========
-- Requires: commercial schema, regulatory schema
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ADD CONSTRAINT `fk_commercial_commercial_speaker_program_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);

-- ========= commercial --> supply (2 constraint(s)) =========
-- Requires: commercial schema, supply schema
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ADD CONSTRAINT `fk_commercial_hcp_target_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`plan`(`plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`performance_period` ADD CONSTRAINT `fk_commercial_performance_period_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`plan`(`plan_id`);

-- ========= commercial --> workforce (16 constraint(s)) =========
-- Requires: commercial schema, workforce schema
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ADD CONSTRAINT `fk_commercial_sales_rep_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ADD CONSTRAINT `fk_commercial_mlr_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ADD CONSTRAINT `fk_commercial_mlr_review_quaternary_mlr_submitter_employee_id` FOREIGN KEY (`quaternary_mlr_submitter_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ADD CONSTRAINT `fk_commercial_mlr_review_tertiary_mlr_regulatory_reviewer_employee_id` FOREIGN KEY (`tertiary_mlr_regulatory_reviewer_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ADD CONSTRAINT `fk_commercial_commercial_speaker_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ADD CONSTRAINT `fk_commercial_sunshine_disclosure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ADD CONSTRAINT `fk_commercial_patient_support_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ADD CONSTRAINT `fk_commercial_psp_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ADD CONSTRAINT `fk_commercial_contract_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ADD CONSTRAINT `fk_commercial_sales_performance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ADD CONSTRAINT `fk_commercial_incentive_compensation_compensation_plan_id` FOREIGN KEY (`compensation_plan_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`compensation_plan`(`compensation_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ADD CONSTRAINT `fk_commercial_incentive_compensation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_formulary_position` ADD CONSTRAINT `fk_commercial_commercial_formulary_position_position_id` FOREIGN KEY (`position_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`district` ADD CONSTRAINT `fk_commercial_district_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= compliance --> clinical (3 constraint(s)) =========
-- Requires: compliance schema, clinical schema
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ADD CONSTRAINT `fk_compliance_conflict_of_interest_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ADD CONSTRAINT `fk_compliance_debarment_check_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`investigational_site`(`investigational_site_id`);

-- ========= compliance --> finance (7 constraint(s)) =========
-- Requires: compliance schema, finance schema
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ADD CONSTRAINT `fk_compliance_inspection_readiness_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ADD CONSTRAINT `fk_compliance_inspection_response_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ADD CONSTRAINT `fk_compliance_compliance_capa_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ADD CONSTRAINT `fk_compliance_compliance_capa_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ADD CONSTRAINT `fk_compliance_warning_letter_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);

-- ========= compliance --> hcp (2 constraint(s)) =========
-- Requires: compliance schema, hcp schema
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ADD CONSTRAINT `fk_compliance_conflict_of_interest_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`fmv_assessment` ADD CONSTRAINT `fk_compliance_fmv_assessment_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);

-- ========= compliance --> manufacturing (7 constraint(s)) =========
-- Requires: compliance schema, manufacturing schema
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ADD CONSTRAINT `fk_compliance_inspection_readiness_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ADD CONSTRAINT `fk_compliance_inspection_observation_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ADD CONSTRAINT `fk_compliance_inspection_response_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ADD CONSTRAINT `fk_compliance_warning_letter_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);

-- ========= compliance --> masterdata (20 constraint(s)) =========
-- Requires: compliance schema, masterdata schema
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ADD CONSTRAINT `fk_compliance_gxp_obligation_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ADD CONSTRAINT `fk_compliance_gxp_obligation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ADD CONSTRAINT `fk_compliance_gxp_obligation_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`gxp_obligation` ADD CONSTRAINT `fk_compliance_gxp_obligation_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ADD CONSTRAINT `fk_compliance_program_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ADD CONSTRAINT `fk_compliance_program_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`internal_control` ADD CONSTRAINT `fk_compliance_internal_control_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ADD CONSTRAINT `fk_compliance_inspection_readiness_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ADD CONSTRAINT `fk_compliance_privacy_obligation_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ADD CONSTRAINT `fk_compliance_compliance_capa_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ADD CONSTRAINT `fk_compliance_disclosure_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ADD CONSTRAINT `fk_compliance_disclosure_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ADD CONSTRAINT `fk_compliance_third_party_due_diligence_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ADD CONSTRAINT `fk_compliance_third_party_due_diligence_third_party_business_partner_id` FOREIGN KEY (`third_party_business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ADD CONSTRAINT `fk_compliance_debarment_check_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ADD CONSTRAINT `fk_compliance_warning_letter_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ADD CONSTRAINT `fk_compliance_warning_letter_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);

-- ========= compliance --> procurement (1 constraint(s)) =========
-- Requires: compliance schema, procurement schema
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`fmv_assessment` ADD CONSTRAINT `fk_compliance_fmv_assessment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= compliance --> product (5 constraint(s)) =========
-- Requires: compliance schema, product schema
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ADD CONSTRAINT `fk_compliance_inspection_readiness_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ADD CONSTRAINT `fk_compliance_inspection_observation_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ADD CONSTRAINT `fk_compliance_conflict_of_interest_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);

-- ========= compliance --> quality (6 constraint(s)) =========
-- Requires: compliance schema, quality schema
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ADD CONSTRAINT `fk_compliance_control_assessment_quality_capa_id` FOREIGN KEY (`quality_capa_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_capa`(`quality_capa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ADD CONSTRAINT `fk_compliance_inspection_observation_quality_capa_id` FOREIGN KEY (`quality_capa_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_capa`(`quality_capa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ADD CONSTRAINT `fk_compliance_inspection_observation_root_cause_analysis_id` FOREIGN KEY (`root_cause_analysis_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`root_cause_analysis`(`root_cause_analysis_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ADD CONSTRAINT `fk_compliance_monitoring_activity_quality_capa_id` FOREIGN KEY (`quality_capa_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_capa`(`quality_capa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_quality_capa_id` FOREIGN KEY (`quality_capa_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_capa`(`quality_capa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ADD CONSTRAINT `fk_compliance_warning_letter_quality_capa_id` FOREIGN KEY (`quality_capa_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_capa`(`quality_capa_id`);

-- ========= compliance --> regulatory (7 constraint(s)) =========
-- Requires: compliance schema, regulatory schema
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ADD CONSTRAINT `fk_compliance_inspection_readiness_application_id` FOREIGN KEY (`application_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`application`(`application_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ADD CONSTRAINT `fk_compliance_inspection_readiness_designation_id` FOREIGN KEY (`designation_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`designation`(`designation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ADD CONSTRAINT `fk_compliance_inspection_readiness_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_dmf_id` FOREIGN KEY (`dmf_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`dmf`(`dmf_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ADD CONSTRAINT `fk_compliance_inspection_observation_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ADD CONSTRAINT `fk_compliance_inspection_response_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`health_authority`(`health_authority_id`);

-- ========= compliance --> workforce (51 constraint(s)) =========
-- Requires: compliance schema, workforce schema
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ADD CONSTRAINT `fk_compliance_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`program` ADD CONSTRAINT `fk_compliance_program_program_employee_id` FOREIGN KEY (`program_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ADD CONSTRAINT `fk_compliance_control_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`control_assessment` ADD CONSTRAINT `fk_compliance_control_assessment_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ADD CONSTRAINT `fk_compliance_inspection_readiness_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ADD CONSTRAINT `fk_compliance_inspection_readiness_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_readiness` ADD CONSTRAINT `fk_compliance_inspection_readiness_primary_inspection_employee_id` FOREIGN KEY (`primary_inspection_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_observation` ADD CONSTRAINT `fk_compliance_inspection_observation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ADD CONSTRAINT `fk_compliance_inspection_response_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ADD CONSTRAINT `fk_compliance_inspection_response_quaternary_inspection_legal_reviewer_employee_id` FOREIGN KEY (`quaternary_inspection_legal_reviewer_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ADD CONSTRAINT `fk_compliance_inspection_response_quinary_inspection_last_modified_by_user_employee_id` FOREIGN KEY (`quinary_inspection_last_modified_by_user_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`inspection_response` ADD CONSTRAINT `fk_compliance_inspection_response_tertiary_inspection_quality_head_approver_employee_id` FOREIGN KEY (`tertiary_inspection_quality_head_approver_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_event` ADD CONSTRAINT `fk_compliance_esignature_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ADD CONSTRAINT `fk_compliance_privacy_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`privacy_obligation` ADD CONSTRAINT `fk_compliance_privacy_obligation_primary_privacy_employee_id` FOREIGN KEY (`primary_privacy_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_incident_employee_id` FOREIGN KEY (`incident_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`incident` ADD CONSTRAINT `fk_compliance_incident_incident_reported_by_employee_id` FOREIGN KEY (`incident_reported_by_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`compliance_capa` ADD CONSTRAINT `fk_compliance_compliance_capa_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ADD CONSTRAINT `fk_compliance_sox_control_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`sox_control_test` ADD CONSTRAINT `fk_compliance_sox_control_test_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ADD CONSTRAINT `fk_compliance_monitoring_activity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`monitoring_activity` ADD CONSTRAINT `fk_compliance_monitoring_activity_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ADD CONSTRAINT `fk_compliance_risk_register_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ADD CONSTRAINT `fk_compliance_risk_register_quaternary_risk_last_modified_by_employee_id` FOREIGN KEY (`quaternary_risk_last_modified_by_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`risk_register` ADD CONSTRAINT `fk_compliance_risk_register_tertiary_risk_created_by_employee_id` FOREIGN KEY (`tertiary_risk_created_by_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ADD CONSTRAINT `fk_compliance_policy_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ADD CONSTRAINT `fk_compliance_policy_document_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ADD CONSTRAINT `fk_compliance_policy_document_policy_employee_id` FOREIGN KEY (`policy_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`policy_document` ADD CONSTRAINT `fk_compliance_policy_document_primary_policy_employee_id` FOREIGN KEY (`primary_policy_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ADD CONSTRAINT `fk_compliance_disclosure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ADD CONSTRAINT `fk_compliance_disclosure_disclosure_preparer_employee_id` FOREIGN KEY (`disclosure_preparer_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`disclosure` ADD CONSTRAINT `fk_compliance_disclosure_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ADD CONSTRAINT `fk_compliance_conflict_of_interest_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest` ADD CONSTRAINT `fk_compliance_conflict_of_interest_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ADD CONSTRAINT `fk_compliance_third_party_due_diligence_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ADD CONSTRAINT `fk_compliance_third_party_due_diligence_primary_third_assessor_employee_id` FOREIGN KEY (`primary_third_assessor_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence` ADD CONSTRAINT `fk_compliance_third_party_due_diligence_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ADD CONSTRAINT `fk_compliance_debarment_check_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`debarment_check` ADD CONSTRAINT `fk_compliance_debarment_check_primary_debarment_adjudicator_employee_id` FOREIGN KEY (`primary_debarment_adjudicator_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_attestation_employee_id` FOREIGN KEY (`attestation_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ADD CONSTRAINT `fk_compliance_warning_letter_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ADD CONSTRAINT `fk_compliance_warning_letter_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`warning_letter` ADD CONSTRAINT `fk_compliance_warning_letter_primary_warning_employee_id` FOREIGN KEY (`primary_warning_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`triggering_event` ADD CONSTRAINT `fk_compliance_triggering_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`triggering_event` ADD CONSTRAINT `fk_compliance_triggering_event_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_session` ADD CONSTRAINT `fk_compliance_esignature_session_delegated_from_user_employee_id` FOREIGN KEY (`delegated_from_user_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_session` ADD CONSTRAINT `fk_compliance_esignature_session_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`compliance`.`esignature_session` ADD CONSTRAINT `fk_compliance_esignature_session_witness_user_employee_id` FOREIGN KEY (`witness_user_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= discovery --> clinical (3 constraint(s)) =========
-- Requires: discovery schema, clinical schema
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`in_vitro_study` ADD CONSTRAINT `fk_discovery_in_vitro_study_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`protocol`(`protocol_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound_exposure` ADD CONSTRAINT `fk_discovery_compound_exposure_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound_exposure` ADD CONSTRAINT `fk_discovery_compound_exposure_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);

-- ========= discovery --> compliance (8 constraint(s)) =========
-- Requires: discovery schema, compliance schema
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`molecular_target` ADD CONSTRAINT `fk_discovery_molecular_target_gxp_obligation_id` FOREIGN KEY (`gxp_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`gxp_obligation`(`gxp_obligation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound` ADD CONSTRAINT `fk_discovery_compound_part11_system_id` FOREIGN KEY (`part11_system_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`part11_system`(`part11_system_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`assay` ADD CONSTRAINT `fk_discovery_assay_gxp_obligation_id` FOREIGN KEY (`gxp_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`gxp_obligation`(`gxp_obligation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`hts_campaign` ADD CONSTRAINT `fk_discovery_hts_campaign_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`project` ADD CONSTRAINT `fk_discovery_project_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`in_vitro_study` ADD CONSTRAINT `fk_discovery_in_vitro_study_gxp_obligation_id` FOREIGN KEY (`gxp_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`gxp_obligation`(`gxp_obligation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`in_vivo_study` ADD CONSTRAINT `fk_discovery_in_vivo_study_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`candidate_nomination` ADD CONSTRAINT `fk_discovery_candidate_nomination_inspection_readiness_id` FOREIGN KEY (`inspection_readiness_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`inspection_readiness`(`inspection_readiness_id`);

-- ========= discovery --> finance (6 constraint(s)) =========
-- Requires: discovery schema, finance schema
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`hts_campaign` ADD CONSTRAINT `fk_discovery_hts_campaign_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`sar_study` ADD CONSTRAINT `fk_discovery_sar_study_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound_synthesis` ADD CONSTRAINT `fk_discovery_compound_synthesis_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`target_validation_study` ADD CONSTRAINT `fk_discovery_target_validation_study_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`in_vivo_study` ADD CONSTRAINT `fk_discovery_in_vivo_study_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`candidate_nomination` ADD CONSTRAINT `fk_discovery_candidate_nomination_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);

-- ========= discovery --> intellectual (18 constraint(s)) =========
-- Requires: discovery schema, intellectual schema
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`molecular_target` ADD CONSTRAINT `fk_discovery_molecular_target_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`molecular_target` ADD CONSTRAINT `fk_discovery_molecular_target_patent_claim_id` FOREIGN KEY (`patent_claim_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_claim`(`patent_claim_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound` ADD CONSTRAINT `fk_discovery_compound_drug_master_file_id` FOREIGN KEY (`drug_master_file_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`drug_master_file`(`drug_master_file_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound` ADD CONSTRAINT `fk_discovery_compound_patent_claim_id` FOREIGN KEY (`patent_claim_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_claim`(`patent_claim_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound` ADD CONSTRAINT `fk_discovery_compound_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_family`(`patent_family_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound` ADD CONSTRAINT `fk_discovery_compound_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound` ADD CONSTRAINT `fk_discovery_compound_trademark_id` FOREIGN KEY (`trademark_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`trademark`(`trademark_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`hts_campaign` ADD CONSTRAINT `fk_discovery_hts_campaign_invention_disclosure_id` FOREIGN KEY (`invention_disclosure_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`invention_disclosure`(`invention_disclosure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`sar_study` ADD CONSTRAINT `fk_discovery_sar_study_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`lead_series` ADD CONSTRAINT `fk_discovery_lead_series_invention_disclosure_id` FOREIGN KEY (`invention_disclosure_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`invention_disclosure`(`invention_disclosure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`lead_series` ADD CONSTRAINT `fk_discovery_lead_series_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`lead_series` ADD CONSTRAINT `fk_discovery_lead_series_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_family`(`patent_family_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound_synthesis` ADD CONSTRAINT `fk_discovery_compound_synthesis_invention_disclosure_id` FOREIGN KEY (`invention_disclosure_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`invention_disclosure`(`invention_disclosure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`project` ADD CONSTRAINT `fk_discovery_project_fto_analysis_id` FOREIGN KEY (`fto_analysis_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`fto_analysis`(`fto_analysis_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`project` ADD CONSTRAINT `fk_discovery_project_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`project` ADD CONSTRAINT `fk_discovery_project_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_family`(`patent_family_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`project` ADD CONSTRAINT `fk_discovery_project_trademark_id` FOREIGN KEY (`trademark_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`trademark`(`trademark_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`candidate_nomination` ADD CONSTRAINT `fk_discovery_candidate_nomination_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_family`(`patent_family_id`);

-- ========= discovery --> masterdata (6 constraint(s)) =========
-- Requires: discovery schema, masterdata schema
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound` ADD CONSTRAINT `fk_discovery_compound_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`hts_campaign` ADD CONSTRAINT `fk_discovery_hts_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound_synthesis` ADD CONSTRAINT `fk_discovery_compound_synthesis_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`project` ADD CONSTRAINT `fk_discovery_project_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`in_vivo_study` ADD CONSTRAINT `fk_discovery_in_vivo_study_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`candidate_nomination` ADD CONSTRAINT `fk_discovery_candidate_nomination_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);

-- ========= discovery --> patient (1 constraint(s)) =========
-- Requires: discovery schema, patient schema
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound_exposure` ADD CONSTRAINT `fk_discovery_compound_exposure_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);

-- ========= discovery --> procurement (6 constraint(s)) =========
-- Requires: discovery schema, procurement schema
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`sar_study` ADD CONSTRAINT `fk_discovery_sar_study_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound_synthesis` ADD CONSTRAINT `fk_discovery_compound_synthesis_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`adme_profile` ADD CONSTRAINT `fk_discovery_adme_profile_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`target_validation_study` ADD CONSTRAINT `fk_discovery_target_validation_study_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`in_vitro_study` ADD CONSTRAINT `fk_discovery_in_vitro_study_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound_supply_agreement` ADD CONSTRAINT `fk_discovery_compound_supply_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= discovery --> product (7 constraint(s)) =========
-- Requires: discovery schema, product schema
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`molecular_target` ADD CONSTRAINT `fk_discovery_molecular_target_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound` ADD CONSTRAINT `fk_discovery_compound_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound` ADD CONSTRAINT `fk_discovery_compound_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`lead_series` ADD CONSTRAINT `fk_discovery_lead_series_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`project` ADD CONSTRAINT `fk_discovery_project_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`target_validation_study` ADD CONSTRAINT `fk_discovery_target_validation_study_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`candidate_nomination` ADD CONSTRAINT `fk_discovery_candidate_nomination_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);

-- ========= discovery --> quality (3 constraint(s)) =========
-- Requires: discovery schema, quality schema
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`candidate_nomination` ADD CONSTRAINT `fk_discovery_candidate_nomination_method_validation_id` FOREIGN KEY (`method_validation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`method_validation`(`method_validation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`candidate_nomination` ADD CONSTRAINT `fk_discovery_candidate_nomination_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`candidate_nomination` ADD CONSTRAINT `fk_discovery_candidate_nomination_stability_study_id` FOREIGN KEY (`stability_study_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`stability_study`(`stability_study_id`);

-- ========= discovery --> regulatory (5 constraint(s)) =========
-- Requires: discovery schema, regulatory schema
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`sar_study` ADD CONSTRAINT `fk_discovery_sar_study_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound_synthesis` ADD CONSTRAINT `fk_discovery_compound_synthesis_dmf_id` FOREIGN KEY (`dmf_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`dmf`(`dmf_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`adme_profile` ADD CONSTRAINT `fk_discovery_adme_profile_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`in_vitro_study` ADD CONSTRAINT `fk_discovery_in_vitro_study_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`computational_model` ADD CONSTRAINT `fk_discovery_computational_model_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);

-- ========= discovery --> supply (1 constraint(s)) =========
-- Requires: discovery schema, supply schema
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`candidate_nomination` ADD CONSTRAINT `fk_discovery_candidate_nomination_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`plan`(`plan_id`);

-- ========= discovery --> workforce (17 constraint(s)) =========
-- Requires: discovery schema, workforce schema
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`assay` ADD CONSTRAINT `fk_discovery_assay_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`hts_campaign` ADD CONSTRAINT `fk_discovery_hts_campaign_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`hts_campaign` ADD CONSTRAINT `fk_discovery_hts_campaign_primary_hts_employee_id` FOREIGN KEY (`primary_hts_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`screening_result` ADD CONSTRAINT `fk_discovery_screening_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`sar_study` ADD CONSTRAINT `fk_discovery_sar_study_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`sar_study` ADD CONSTRAINT `fk_discovery_sar_study_sar_director_employee_id` FOREIGN KEY (`sar_director_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`lead_series` ADD CONSTRAINT `fk_discovery_lead_series_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound_synthesis` ADD CONSTRAINT `fk_discovery_compound_synthesis_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`adme_profile` ADD CONSTRAINT `fk_discovery_adme_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`project` ADD CONSTRAINT `fk_discovery_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`target_validation_study` ADD CONSTRAINT `fk_discovery_target_validation_study_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`target_validation_study` ADD CONSTRAINT `fk_discovery_target_validation_study_target_study_director_employee_id` FOREIGN KEY (`target_study_director_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`in_vitro_study` ADD CONSTRAINT `fk_discovery_in_vitro_study_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`in_vivo_study` ADD CONSTRAINT `fk_discovery_in_vivo_study_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`candidate_nomination` ADD CONSTRAINT `fk_discovery_candidate_nomination_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`computational_model` ADD CONSTRAINT `fk_discovery_computational_model_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound_library` ADD CONSTRAINT `fk_discovery_compound_library_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= finance --> commercial (1 constraint(s)) =========
-- Requires: finance schema, commercial schema
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`sales_order`(`sales_order_id`);

-- ========= finance --> compliance (1 constraint(s)) =========
-- Requires: finance schema, compliance schema
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);

-- ========= finance --> discovery (5 constraint(s)) =========
-- Requires: finance schema, discovery schema
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ADD CONSTRAINT `fk_finance_rd_capitalization_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ADD CONSTRAINT `fk_finance_rd_capitalization_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ADD CONSTRAINT `fk_finance_royalty_agreement_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ADD CONSTRAINT `fk_finance_milestone_payment_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);

-- ========= finance --> hcp (1 constraint(s)) =========
-- Requires: finance schema, hcp schema
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`contract`(`contract_id`);

-- ========= finance --> intellectual (2 constraint(s)) =========
-- Requires: finance schema, intellectual schema
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ADD CONSTRAINT `fk_finance_royalty_agreement_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ADD CONSTRAINT `fk_finance_milestone_payment_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);

-- ========= finance --> manufacturing (1 constraint(s)) =========
-- Requires: finance schema, manufacturing schema
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);

-- ========= finance --> masterdata (42 constraint(s)) =========
-- Requires: finance schema, masterdata schema
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ADD CONSTRAINT `fk_finance_royalty_agreement_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_receiving_entity_legal_entity_id` FOREIGN KEY (`receiving_entity_legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ADD CONSTRAINT `fk_finance_milestone_payment_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ADD CONSTRAINT `fk_finance_milestone_payment_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ADD CONSTRAINT `fk_finance_milestone_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ADD CONSTRAINT `fk_finance_milestone_payment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ADD CONSTRAINT `fk_finance_transfer_price_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ADD CONSTRAINT `fk_finance_transfer_price_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ADD CONSTRAINT `fk_finance_transfer_price_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_address_id` FOREIGN KEY (`address_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`address`(`address_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_ship_to_address_id` FOREIGN KEY (`ship_to_address_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`address`(`address_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`ledger` ADD CONSTRAINT `fk_finance_ledger_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_agreement` ADD CONSTRAINT `fk_finance_intercompany_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_agreement` ADD CONSTRAINT `fk_finance_intercompany_agreement_originating_entity_id` FOREIGN KEY (`originating_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_business_area_id` FOREIGN KEY (`business_area_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_area`(`business_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_functional_area_id` FOREIGN KEY (`functional_area_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`functional_area`(`functional_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);

-- ========= finance --> procurement (17 constraint(s)) =========
-- Requires: finance schema, procurement schema
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_vendor_invoice_id` FOREIGN KEY (`vendor_invoice_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor_invoice`(`vendor_invoice_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_supply_contract_id` FOREIGN KEY (`supply_contract_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`supply_contract`(`supply_contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_supply_contract_id` FOREIGN KEY (`supply_contract_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`supply_contract`(`supply_contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_vendor_site_id` FOREIGN KEY (`vendor_site_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor_site`(`vendor_site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_supply_contract_id` FOREIGN KEY (`supply_contract_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`supply_contract`(`supply_contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ADD CONSTRAINT `fk_finance_rd_capitalization_supply_contract_id` FOREIGN KEY (`supply_contract_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`supply_contract`(`supply_contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ADD CONSTRAINT `fk_finance_royalty_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ADD CONSTRAINT `fk_finance_milestone_payment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ADD CONSTRAINT `fk_finance_transfer_price_supply_contract_id` FOREIGN KEY (`supply_contract_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`supply_contract`(`supply_contract_id`);

-- ========= finance --> product (9 constraint(s)) =========
-- Requires: finance schema, product schema
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ADD CONSTRAINT `fk_finance_rd_capitalization_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ADD CONSTRAINT `fk_finance_rd_capitalization_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ADD CONSTRAINT `fk_finance_transfer_price_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);

-- ========= finance --> supply (6 constraint(s)) =========
-- Requires: finance schema, supply schema
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_warehouse_receipt_id` FOREIGN KEY (`warehouse_receipt_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`warehouse_receipt`(`warehouse_receipt_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_goods_issue_id` FOREIGN KEY (`goods_issue_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`goods_issue`(`goods_issue_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`cogs_entry` ADD CONSTRAINT `fk_finance_cogs_entry_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_stock_transfer_order_id` FOREIGN KEY (`stock_transfer_order_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`stock_transfer_order`(`stock_transfer_order_id`);

-- ========= finance --> workforce (16 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`rd_capitalization` ADD CONSTRAINT `fk_finance_rd_capitalization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ADD CONSTRAINT `fk_finance_royalty_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ADD CONSTRAINT `fk_finance_milestone_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ADD CONSTRAINT `fk_finance_transfer_price_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_project_manager_employee_id` FOREIGN KEY (`project_manager_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= hcp --> clinical (4 constraint(s)) =========
-- Requires: hcp schema, clinical schema
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ADD CONSTRAINT `fk_hcp_affiliation_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ADD CONSTRAINT `fk_hcp_hcp_advisory_board_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ADD CONSTRAINT `fk_hcp_med_info_request_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ADD CONSTRAINT `fk_hcp_hcp_publication_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);

-- ========= hcp --> commercial (8 constraint(s)) =========
-- Requires: hcp schema, commercial schema
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ADD CONSTRAINT `fk_hcp_hcp_engagement_sales_rep_id` FOREIGN KEY (`sales_rep_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`sales_rep`(`sales_rep_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ADD CONSTRAINT `fk_hcp_hcp_engagement_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ADD CONSTRAINT `fk_hcp_sample_request_sales_rep_id` FOREIGN KEY (`sales_rep_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`sales_rep`(`sales_rep_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ADD CONSTRAINT `fk_hcp_prescribing_pattern_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ADD CONSTRAINT `fk_hcp_prescribing_pattern_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ADD CONSTRAINT `fk_hcp_hcp_advisory_board_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ADD CONSTRAINT `fk_hcp_contract_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ADD CONSTRAINT `fk_hcp_hcp_publication_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);

-- ========= hcp --> compliance (9 constraint(s)) =========
-- Requires: hcp schema, compliance schema
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ADD CONSTRAINT `fk_hcp_affiliation_conflict_of_interest_id` FOREIGN KEY (`conflict_of_interest_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest`(`conflict_of_interest_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ADD CONSTRAINT `fk_hcp_hcp_engagement_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ADD CONSTRAINT `fk_hcp_sample_request_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ADD CONSTRAINT `fk_hcp_consent_record_privacy_obligation_id` FOREIGN KEY (`privacy_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`privacy_obligation`(`privacy_obligation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ADD CONSTRAINT `fk_hcp_sunshine_transfer_disclosure_id` FOREIGN KEY (`disclosure_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`disclosure`(`disclosure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ADD CONSTRAINT `fk_hcp_hcp_speaker_program_inspection_readiness_id` FOREIGN KEY (`inspection_readiness_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`inspection_readiness`(`inspection_readiness_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ADD CONSTRAINT `fk_hcp_hcp_advisory_board_inspection_readiness_id` FOREIGN KEY (`inspection_readiness_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`inspection_readiness`(`inspection_readiness_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ADD CONSTRAINT `fk_hcp_contract_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ADD CONSTRAINT `fk_hcp_investigator_debarment_check_id` FOREIGN KEY (`debarment_check_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`debarment_check`(`debarment_check_id`);

-- ========= hcp --> discovery (8 constraint(s)) =========
-- Requires: hcp schema, discovery schema
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ADD CONSTRAINT `fk_hcp_hcp_kol_profile_molecular_target_id` FOREIGN KEY (`molecular_target_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`molecular_target`(`molecular_target_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ADD CONSTRAINT `fk_hcp_hcp_engagement_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ADD CONSTRAINT `fk_hcp_hcp_speaker_program_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ADD CONSTRAINT `fk_hcp_hcp_advisory_board_molecular_target_id` FOREIGN KEY (`molecular_target_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`molecular_target`(`molecular_target_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ADD CONSTRAINT `fk_hcp_hcp_advisory_board_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ADD CONSTRAINT `fk_hcp_med_info_request_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ADD CONSTRAINT `fk_hcp_hcp_publication_molecular_target_id` FOREIGN KEY (`molecular_target_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`molecular_target`(`molecular_target_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ADD CONSTRAINT `fk_hcp_investigator_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);

-- ========= hcp --> finance (11 constraint(s)) =========
-- Requires: hcp schema, finance schema
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ADD CONSTRAINT `fk_hcp_hcp_engagement_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ADD CONSTRAINT `fk_hcp_sample_request_cogs_entry_id` FOREIGN KEY (`cogs_entry_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`cogs_entry`(`cogs_entry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ADD CONSTRAINT `fk_hcp_sunshine_transfer_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ADD CONSTRAINT `fk_hcp_hcp_speaker_program_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ADD CONSTRAINT `fk_hcp_hcp_speaker_program_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ADD CONSTRAINT `fk_hcp_hcp_advisory_board_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ADD CONSTRAINT `fk_hcp_hcp_advisory_board_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ADD CONSTRAINT `fk_hcp_contract_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ADD CONSTRAINT `fk_hcp_contract_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ADD CONSTRAINT `fk_hcp_contract_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ADD CONSTRAINT `fk_hcp_investigator_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);

-- ========= hcp --> intellectual (7 constraint(s)) =========
-- Requires: hcp schema, intellectual schema
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ADD CONSTRAINT `fk_hcp_hcp_kol_profile_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ADD CONSTRAINT `fk_hcp_sunshine_transfer_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ADD CONSTRAINT `fk_hcp_sunshine_transfer_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ADD CONSTRAINT `fk_hcp_hcp_speaker_program_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ADD CONSTRAINT `fk_hcp_contract_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ADD CONSTRAINT `fk_hcp_hcp_publication_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ADD CONSTRAINT `fk_hcp_investigator_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);

-- ========= hcp --> market (6 constraint(s)) =========
-- Requires: hcp schema, market schema
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ADD CONSTRAINT `fk_hcp_hcp_engagement_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ADD CONSTRAINT `fk_hcp_prescribing_pattern_coverage_decision_id` FOREIGN KEY (`coverage_decision_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`coverage_decision`(`coverage_decision_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ADD CONSTRAINT `fk_hcp_prescribing_pattern_market_formulary_position_id` FOREIGN KEY (`market_formulary_position_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`market_formulary_position`(`market_formulary_position_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ADD CONSTRAINT `fk_hcp_prescribing_pattern_payer_account_id` FOREIGN KEY (`payer_account_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`payer_account`(`payer_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ADD CONSTRAINT `fk_hcp_hcp_speaker_program_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ADD CONSTRAINT `fk_hcp_hcp_advisory_board_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);

-- ========= hcp --> masterdata (12 constraint(s)) =========
-- Requires: hcp schema, masterdata schema
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ADD CONSTRAINT `fk_hcp_master_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ADD CONSTRAINT `fk_hcp_hco_master_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ADD CONSTRAINT `fk_hcp_affiliation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ADD CONSTRAINT `fk_hcp_hcp_engagement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ADD CONSTRAINT `fk_hcp_sample_request_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ADD CONSTRAINT `fk_hcp_sample_request_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`storage_location`(`storage_location_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ADD CONSTRAINT `fk_hcp_sunshine_transfer_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ADD CONSTRAINT `fk_hcp_hcp_speaker_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ADD CONSTRAINT `fk_hcp_hcp_advisory_board_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ADD CONSTRAINT `fk_hcp_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ADD CONSTRAINT `fk_hcp_contract_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ADD CONSTRAINT `fk_hcp_investigator_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);

-- ========= hcp --> pharmacovigilance (1 constraint(s)) =========
-- Requires: hcp schema, pharmacovigilance schema
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ADD CONSTRAINT `fk_hcp_med_info_request_icsr_id` FOREIGN KEY (`icsr_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr`(`icsr_id`);

-- ========= hcp --> procurement (1 constraint(s)) =========
-- Requires: hcp schema, procurement schema
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ADD CONSTRAINT `fk_hcp_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= hcp --> product (13 constraint(s)) =========
-- Requires: hcp schema, product schema
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ADD CONSTRAINT `fk_hcp_hcp_kol_profile_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ADD CONSTRAINT `fk_hcp_hcp_engagement_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ADD CONSTRAINT `fk_hcp_sample_request_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ADD CONSTRAINT `fk_hcp_sunshine_transfer_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`prescribing_pattern` ADD CONSTRAINT `fk_hcp_prescribing_pattern_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ADD CONSTRAINT `fk_hcp_hcp_speaker_program_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ADD CONSTRAINT `fk_hcp_hcp_advisory_board_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ADD CONSTRAINT `fk_hcp_med_info_request_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ADD CONSTRAINT `fk_hcp_med_info_request_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ADD CONSTRAINT `fk_hcp_contract_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ADD CONSTRAINT `fk_hcp_hcp_publication_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ADD CONSTRAINT `fk_hcp_investigator_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program_presentation` ADD CONSTRAINT `fk_hcp_speaker_program_presentation_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);

-- ========= hcp --> regulatory (1 constraint(s)) =========
-- Requires: hcp schema, regulatory schema
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ADD CONSTRAINT `fk_hcp_sunshine_transfer_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);

-- ========= hcp --> workforce (11 constraint(s)) =========
-- Requires: hcp schema, workforce schema
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ADD CONSTRAINT `fk_hcp_affiliation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile` ADD CONSTRAINT `fk_hcp_hcp_kol_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_engagement` ADD CONSTRAINT `fk_hcp_hcp_engagement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_speaker_program` ADD CONSTRAINT `fk_hcp_hcp_speaker_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_advisory_board` ADD CONSTRAINT `fk_hcp_hcp_advisory_board_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`med_info_request` ADD CONSTRAINT `fk_hcp_med_info_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ADD CONSTRAINT `fk_hcp_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ADD CONSTRAINT `fk_hcp_contract_contract_legal_reviewer_employee_id` FOREIGN KEY (`contract_legal_reviewer_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ADD CONSTRAINT `fk_hcp_contract_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hcp_publication` ADD CONSTRAINT `fk_hcp_hcp_publication_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ADD CONSTRAINT `fk_hcp_investigator_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= intellectual --> compliance (13 constraint(s)) =========
-- Requires: intellectual schema, compliance schema
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_family` ADD CONSTRAINT `fk_intellectual_patent_family_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`trademark` ADD CONSTRAINT `fk_intellectual_trademark_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`drug_master_file` ADD CONSTRAINT `fk_intellectual_drug_master_file_gxp_obligation_id` FOREIGN KEY (`gxp_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`gxp_obligation`(`gxp_obligation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement` ADD CONSTRAINT `fk_intellectual_licensing_agreement_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`fto_analysis` ADD CONSTRAINT `fk_intellectual_fto_analysis_risk_register_id` FOREIGN KEY (`risk_register_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`risk_register`(`risk_register_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_litigation` ADD CONSTRAINT `fk_intellectual_patent_litigation_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_litigation` ADD CONSTRAINT `fk_intellectual_patent_litigation_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_litigation` ADD CONSTRAINT `fk_intellectual_patent_litigation_warning_letter_id` FOREIGN KEY (`warning_letter_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`warning_letter`(`warning_letter_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_prosecution` ADD CONSTRAINT `fk_intellectual_patent_prosecution_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`spc_filing` ADD CONSTRAINT `fk_intellectual_spc_filing_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_term_extension` ADD CONSTRAINT `fk_intellectual_patent_term_extension_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`ip_watch` ADD CONSTRAINT `fk_intellectual_ip_watch_risk_register_id` FOREIGN KEY (`risk_register_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`risk_register`(`risk_register_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`invention_disclosure` ADD CONSTRAINT `fk_intellectual_invention_disclosure_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);

-- ========= intellectual --> finance (6 constraint(s)) =========
-- Requires: intellectual schema, finance schema
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`royalty_payment` ADD CONSTRAINT `fk_intellectual_royalty_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_litigation` ADD CONSTRAINT `fk_intellectual_patent_litigation_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`ip_valuation` ADD CONSTRAINT `fk_intellectual_ip_valuation_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`ip_valuation` ADD CONSTRAINT `fk_intellectual_ip_valuation_rd_capitalization_id` FOREIGN KEY (`rd_capitalization_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`rd_capitalization`(`rd_capitalization_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`annuity_fee` ADD CONSTRAINT `fk_intellectual_annuity_fee_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`ip_agreement_milestone` ADD CONSTRAINT `fk_intellectual_ip_agreement_milestone_milestone_payment_id` FOREIGN KEY (`milestone_payment_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`milestone_payment`(`milestone_payment_id`);

-- ========= intellectual --> masterdata (41 constraint(s)) =========
-- Requires: intellectual schema, masterdata schema
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent` ADD CONSTRAINT `fk_intellectual_patent_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent` ADD CONSTRAINT `fk_intellectual_patent_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent` ADD CONSTRAINT `fk_intellectual_patent_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent` ADD CONSTRAINT `fk_intellectual_patent_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent` ADD CONSTRAINT `fk_intellectual_patent_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent` ADD CONSTRAINT `fk_intellectual_patent_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent` ADD CONSTRAINT `fk_intellectual_patent_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent` ADD CONSTRAINT `fk_intellectual_patent_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_claim` ADD CONSTRAINT `fk_intellectual_patent_claim_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_family` ADD CONSTRAINT `fk_intellectual_patent_family_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_family` ADD CONSTRAINT `fk_intellectual_patent_family_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_family` ADD CONSTRAINT `fk_intellectual_patent_family_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_family` ADD CONSTRAINT `fk_intellectual_patent_family_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_family` ADD CONSTRAINT `fk_intellectual_patent_family_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_family` ADD CONSTRAINT `fk_intellectual_patent_family_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period` ADD CONSTRAINT `fk_intellectual_exclusivity_period_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period` ADD CONSTRAINT `fk_intellectual_exclusivity_period_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period` ADD CONSTRAINT `fk_intellectual_exclusivity_period_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period` ADD CONSTRAINT `fk_intellectual_exclusivity_period_masterdata_ndc_code_id` FOREIGN KEY (`masterdata_ndc_code_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code`(`masterdata_ndc_code_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period` ADD CONSTRAINT `fk_intellectual_exclusivity_period_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`trademark` ADD CONSTRAINT `fk_intellectual_trademark_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`trademark` ADD CONSTRAINT `fk_intellectual_trademark_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`trademark` ADD CONSTRAINT `fk_intellectual_trademark_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`drug_master_file` ADD CONSTRAINT `fk_intellectual_drug_master_file_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`drug_master_file` ADD CONSTRAINT `fk_intellectual_drug_master_file_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`drug_master_file` ADD CONSTRAINT `fk_intellectual_drug_master_file_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`drug_master_file` ADD CONSTRAINT `fk_intellectual_drug_master_file_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`drug_master_file` ADD CONSTRAINT `fk_intellectual_drug_master_file_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement` ADD CONSTRAINT `fk_intellectual_licensing_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement` ADD CONSTRAINT `fk_intellectual_licensing_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement` ADD CONSTRAINT `fk_intellectual_licensing_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement` ADD CONSTRAINT `fk_intellectual_licensing_agreement_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`royalty_payment` ADD CONSTRAINT `fk_intellectual_royalty_payment_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`fto_analysis` ADD CONSTRAINT `fk_intellectual_fto_analysis_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`fto_analysis` ADD CONSTRAINT `fk_intellectual_fto_analysis_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_litigation` ADD CONSTRAINT `fk_intellectual_patent_litigation_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_litigation` ADD CONSTRAINT `fk_intellectual_patent_litigation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`spc_filing` ADD CONSTRAINT `fk_intellectual_spc_filing_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_term_extension` ADD CONSTRAINT `fk_intellectual_patent_term_extension_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`ip_watch` ADD CONSTRAINT `fk_intellectual_ip_watch_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`orange_book_listing` ADD CONSTRAINT `fk_intellectual_orange_book_listing_masterdata_ndc_code_id` FOREIGN KEY (`masterdata_ndc_code_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code`(`masterdata_ndc_code_id`);

-- ========= intellectual --> procurement (3 constraint(s)) =========
-- Requires: intellectual schema, procurement schema
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`drug_master_file` ADD CONSTRAINT `fk_intellectual_drug_master_file_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement` ADD CONSTRAINT `fk_intellectual_licensing_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_litigation` ADD CONSTRAINT `fk_intellectual_patent_litigation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= intellectual --> product (11 constraint(s)) =========
-- Requires: intellectual schema, product schema
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_claim` ADD CONSTRAINT `fk_intellectual_patent_claim_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period` ADD CONSTRAINT `fk_intellectual_exclusivity_period_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`royalty_payment` ADD CONSTRAINT `fk_intellectual_royalty_payment_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`fto_analysis` ADD CONSTRAINT `fk_intellectual_fto_analysis_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_litigation` ADD CONSTRAINT `fk_intellectual_patent_litigation_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`spc_filing` ADD CONSTRAINT `fk_intellectual_spc_filing_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_term_extension` ADD CONSTRAINT `fk_intellectual_patent_term_extension_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_term_extension` ADD CONSTRAINT `fk_intellectual_patent_term_extension_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`ip_valuation` ADD CONSTRAINT `fk_intellectual_ip_valuation_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`invention_disclosure` ADD CONSTRAINT `fk_intellectual_invention_disclosure_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`orange_book_listing` ADD CONSTRAINT `fk_intellectual_orange_book_listing_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);

-- ========= intellectual --> regulatory (1 constraint(s)) =========
-- Requires: intellectual schema, regulatory schema
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_term_extension` ADD CONSTRAINT `fk_intellectual_patent_term_extension_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`approval`(`approval_id`);

-- ========= intellectual --> workforce (19 constraint(s)) =========
-- Requires: intellectual schema, workforce schema
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent` ADD CONSTRAINT `fk_intellectual_patent_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_claim` ADD CONSTRAINT `fk_intellectual_patent_claim_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_family` ADD CONSTRAINT `fk_intellectual_patent_family_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period` ADD CONSTRAINT `fk_intellectual_exclusivity_period_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`trademark` ADD CONSTRAINT `fk_intellectual_trademark_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`drug_master_file` ADD CONSTRAINT `fk_intellectual_drug_master_file_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement` ADD CONSTRAINT `fk_intellectual_licensing_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`royalty_payment` ADD CONSTRAINT `fk_intellectual_royalty_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`fto_analysis` ADD CONSTRAINT `fk_intellectual_fto_analysis_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_litigation` ADD CONSTRAINT `fk_intellectual_patent_litigation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_prosecution` ADD CONSTRAINT `fk_intellectual_patent_prosecution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`spc_filing` ADD CONSTRAINT `fk_intellectual_spc_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_term_extension` ADD CONSTRAINT `fk_intellectual_patent_term_extension_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`ip_watch` ADD CONSTRAINT `fk_intellectual_ip_watch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`ip_valuation` ADD CONSTRAINT `fk_intellectual_ip_valuation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`invention_disclosure` ADD CONSTRAINT `fk_intellectual_invention_disclosure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`orange_book_listing` ADD CONSTRAINT `fk_intellectual_orange_book_listing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`annuity_fee` ADD CONSTRAINT `fk_intellectual_annuity_fee_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`ip_agreement_milestone` ADD CONSTRAINT `fk_intellectual_ip_agreement_milestone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= manufacturing --> commercial (6 constraint(s)) =========
-- Requires: manufacturing schema, commercial schema
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ADD CONSTRAINT `fk_manufacturing_master_batch_record_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ADD CONSTRAINT `fk_manufacturing_bill_of_materials_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ADD CONSTRAINT `fk_manufacturing_technology_transfer_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);

-- ========= manufacturing --> compliance (10 constraint(s)) =========
-- Requires: manufacturing schema, compliance schema
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_gxp_obligation_id` FOREIGN KEY (`gxp_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`gxp_obligation`(`gxp_obligation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ADD CONSTRAINT `fk_manufacturing_master_batch_record_gxp_obligation_id` FOREIGN KEY (`gxp_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`gxp_obligation`(`gxp_obligation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ADD CONSTRAINT `fk_manufacturing_equipment_qualification_gxp_obligation_id` FOREIGN KEY (`gxp_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`gxp_obligation`(`gxp_obligation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ADD CONSTRAINT `fk_manufacturing_manufacturing_deviation_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ADD CONSTRAINT `fk_manufacturing_manufacturing_deviation_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ADD CONSTRAINT `fk_manufacturing_bill_of_materials_gxp_obligation_id` FOREIGN KEY (`gxp_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`gxp_obligation`(`gxp_obligation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_gxp_obligation_id` FOREIGN KEY (`gxp_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`gxp_obligation`(`gxp_obligation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ADD CONSTRAINT `fk_manufacturing_environmental_monitoring_gxp_obligation_id` FOREIGN KEY (`gxp_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`gxp_obligation`(`gxp_obligation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ADD CONSTRAINT `fk_manufacturing_cmo_oversight_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ADD CONSTRAINT `fk_manufacturing_technology_transfer_gxp_obligation_id` FOREIGN KEY (`gxp_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`gxp_obligation`(`gxp_obligation_id`);

-- ========= manufacturing --> finance (11 constraint(s)) =========
-- Requires: manufacturing schema, finance schema
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ADD CONSTRAINT `fk_manufacturing_site_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ADD CONSTRAINT `fk_manufacturing_site_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ADD CONSTRAINT `fk_manufacturing_line_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ADD CONSTRAINT `fk_manufacturing_equipment_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ADD CONSTRAINT `fk_manufacturing_equipment_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ADD CONSTRAINT `fk_manufacturing_manufacturing_deviation_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_rd_capitalization_id` FOREIGN KEY (`rd_capitalization_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`rd_capitalization`(`rd_capitalization_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ADD CONSTRAINT `fk_manufacturing_cmo_oversight_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ADD CONSTRAINT `fk_manufacturing_technology_transfer_rd_capitalization_id` FOREIGN KEY (`rd_capitalization_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`rd_capitalization`(`rd_capitalization_id`);

-- ========= manufacturing --> hcp (1 constraint(s)) =========
-- Requires: manufacturing schema, hcp schema
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`investigational_product_supply` ADD CONSTRAINT `fk_manufacturing_investigational_product_supply_investigator_id` FOREIGN KEY (`investigator_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`investigator`(`investigator_id`);

-- ========= manufacturing --> intellectual (14 constraint(s)) =========
-- Requires: manufacturing schema, intellectual schema
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_trademark_id` FOREIGN KEY (`trademark_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`trademark`(`trademark_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_drug_master_file_id` FOREIGN KEY (`drug_master_file_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`drug_master_file`(`drug_master_file_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ADD CONSTRAINT `fk_manufacturing_master_batch_record_drug_master_file_id` FOREIGN KEY (`drug_master_file_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`drug_master_file`(`drug_master_file_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ADD CONSTRAINT `fk_manufacturing_master_batch_record_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ADD CONSTRAINT `fk_manufacturing_manufacturing_deviation_patent_litigation_id` FOREIGN KEY (`patent_litigation_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_litigation`(`patent_litigation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ADD CONSTRAINT `fk_manufacturing_bill_of_materials_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ADD CONSTRAINT `fk_manufacturing_cmo_oversight_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ADD CONSTRAINT `fk_manufacturing_technology_transfer_drug_master_file_id` FOREIGN KEY (`drug_master_file_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`drug_master_file`(`drug_master_file_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ADD CONSTRAINT `fk_manufacturing_technology_transfer_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ADD CONSTRAINT `fk_manufacturing_technology_transfer_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);

-- ========= manufacturing --> market (2 constraint(s)) =========
-- Requires: manufacturing schema, market schema
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ADD CONSTRAINT `fk_manufacturing_technology_transfer_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);

-- ========= manufacturing --> masterdata (1 constraint(s)) =========
-- Requires: manufacturing schema, masterdata schema
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`sample` ADD CONSTRAINT `fk_manufacturing_sample_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);

-- ========= manufacturing --> pharmacovigilance (4 constraint(s)) =========
-- Requires: manufacturing schema, pharmacovigilance schema
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ADD CONSTRAINT `fk_manufacturing_manufacturing_deviation_icsr_id` FOREIGN KEY (`icsr_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr`(`icsr_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_pv_product_id` FOREIGN KEY (`pv_product_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product`(`pv_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ADD CONSTRAINT `fk_manufacturing_cmo_oversight_pv_product_id` FOREIGN KEY (`pv_product_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product`(`pv_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ADD CONSTRAINT `fk_manufacturing_technology_transfer_pv_product_id` FOREIGN KEY (`pv_product_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product`(`pv_product_id`);

-- ========= manufacturing --> procurement (7 constraint(s)) =========
-- Requires: manufacturing schema, procurement schema
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ADD CONSTRAINT `fk_manufacturing_site_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ADD CONSTRAINT `fk_manufacturing_equipment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ADD CONSTRAINT `fk_manufacturing_equipment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ADD CONSTRAINT `fk_manufacturing_cmo_oversight_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ADD CONSTRAINT `fk_manufacturing_technology_transfer_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`campaign` ADD CONSTRAINT `fk_manufacturing_campaign_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= manufacturing --> product (13 constraint(s)) =========
-- Requires: manufacturing schema, product schema
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ADD CONSTRAINT `fk_manufacturing_master_batch_record_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ADD CONSTRAINT `fk_manufacturing_master_batch_record_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ADD CONSTRAINT `fk_manufacturing_manufacturing_deviation_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ADD CONSTRAINT `fk_manufacturing_bill_of_materials_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ADD CONSTRAINT `fk_manufacturing_bill_of_materials_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ADD CONSTRAINT `fk_manufacturing_bill_of_materials_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer` ADD CONSTRAINT `fk_manufacturing_technology_transfer_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`campaign` ADD CONSTRAINT `fk_manufacturing_campaign_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);

-- ========= manufacturing --> quality (3 constraint(s)) =========
-- Requires: manufacturing schema, quality schema
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ADD CONSTRAINT `fk_manufacturing_manufacturing_deviation_quality_capa_id` FOREIGN KEY (`quality_capa_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_capa`(`quality_capa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ADD CONSTRAINT `fk_manufacturing_environmental_monitoring_quality_capa_id` FOREIGN KEY (`quality_capa_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_capa`(`quality_capa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`sample` ADD CONSTRAINT `fk_manufacturing_sample_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`specification`(`specification_id`);

-- ========= manufacturing --> supply (6 constraint(s)) =========
-- Requires: manufacturing schema, supply schema
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`plan`(`plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_warehouse_receipt_id` FOREIGN KEY (`warehouse_receipt_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`warehouse_receipt`(`warehouse_receipt_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_campaign_plan_id` FOREIGN KEY (`campaign_plan_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`plan`(`plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`plan`(`plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`cmo_oversight` ADD CONSTRAINT `fk_manufacturing_cmo_oversight_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`service_agreement`(`service_agreement_id`);

-- ========= manufacturing --> workforce (24 constraint(s)) =========
-- Requires: manufacturing schema, workforce schema
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ADD CONSTRAINT `fk_manufacturing_master_batch_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ADD CONSTRAINT `fk_manufacturing_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ADD CONSTRAINT `fk_manufacturing_equipment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ADD CONSTRAINT `fk_manufacturing_process_parameter_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ADD CONSTRAINT `fk_manufacturing_process_parameter_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ADD CONSTRAINT `fk_manufacturing_manufacturing_deviation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ADD CONSTRAINT `fk_manufacturing_manufacturing_deviation_tertiary_manufacturing_approved_by_user_employee_id` FOREIGN KEY (`tertiary_manufacturing_approved_by_user_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ADD CONSTRAINT `fk_manufacturing_environmental_monitoring_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`campaign` ADD CONSTRAINT `fk_manufacturing_campaign_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`campaign` ADD CONSTRAINT `fk_manufacturing_campaign_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`campaign` ADD CONSTRAINT `fk_manufacturing_campaign_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`campaign` ADD CONSTRAINT `fk_manufacturing_campaign_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`sample` ADD CONSTRAINT `fk_manufacturing_sample_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`sample` ADD CONSTRAINT `fk_manufacturing_sample_disposition_by_user_employee_id` FOREIGN KEY (`disposition_by_user_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`sample` ADD CONSTRAINT `fk_manufacturing_sample_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`sample` ADD CONSTRAINT `fk_manufacturing_sample_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`sample` ADD CONSTRAINT `fk_manufacturing_sample_received_by_user_employee_id` FOREIGN KEY (`received_by_user_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`sample` ADD CONSTRAINT `fk_manufacturing_sample_tested_by_user_employee_id` FOREIGN KEY (`tested_by_user_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= market --> commercial (3 constraint(s)) =========
-- Requires: market schema, commercial schema
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ADD CONSTRAINT `fk_market_rebate_claim_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ADD CONSTRAINT `fk_market_gross_to_net_adjustment_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ADD CONSTRAINT `fk_market_tender_submission_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);

-- ========= market --> compliance (10 constraint(s)) =========
-- Requires: market schema, compliance schema
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ADD CONSTRAINT `fk_market_access_strategy_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ADD CONSTRAINT `fk_market_payer_account_third_party_due_diligence_id` FOREIGN KEY (`third_party_due_diligence_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence`(`third_party_due_diligence_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ADD CONSTRAINT `fk_market_market_payer_contract_disclosure_id` FOREIGN KEY (`disclosure_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`disclosure`(`disclosure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ADD CONSTRAINT `fk_market_market_payer_contract_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ADD CONSTRAINT `fk_market_patient_access_program_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ADD CONSTRAINT `fk_market_rwe_dataset_privacy_impact_assessment_id` FOREIGN KEY (`privacy_impact_assessment_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment`(`privacy_impact_assessment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ADD CONSTRAINT `fk_market_rwe_dataset_privacy_obligation_id` FOREIGN KEY (`privacy_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`privacy_obligation`(`privacy_obligation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ADD CONSTRAINT `fk_market_payer_engagement_disclosure_id` FOREIGN KEY (`disclosure_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`disclosure`(`disclosure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ADD CONSTRAINT `fk_market_tender_submission_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ADD CONSTRAINT `fk_market_outcomes_based_contract_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);

-- ========= market --> finance (10 constraint(s)) =========
-- Requires: market schema, finance schema
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ADD CONSTRAINT `fk_market_access_strategy_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ADD CONSTRAINT `fk_market_hta_submission_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ADD CONSTRAINT `fk_market_market_payer_contract_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ADD CONSTRAINT `fk_market_rebate_claim_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ADD CONSTRAINT `fk_market_gross_to_net_adjustment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ADD CONSTRAINT `fk_market_patient_access_program_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ADD CONSTRAINT `fk_market_pricing_decision_transfer_price_id` FOREIGN KEY (`transfer_price_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`transfer_price`(`transfer_price_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ADD CONSTRAINT `fk_market_market_heor_study_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ADD CONSTRAINT `fk_market_tender_submission_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ADD CONSTRAINT `fk_market_outcomes_based_contract_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);

-- ========= market --> hcp (3 constraint(s)) =========
-- Requires: market schema, hcp schema
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ADD CONSTRAINT `fk_market_access_strategy_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ADD CONSTRAINT `fk_market_patient_access_program_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`kol_engagement_plan` ADD CONSTRAINT `fk_market_kol_engagement_plan_hcp_kol_profile_id` FOREIGN KEY (`hcp_kol_profile_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hcp_kol_profile`(`hcp_kol_profile_id`);

-- ========= market --> intellectual (13 constraint(s)) =========
-- Requires: market schema, intellectual schema
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ADD CONSTRAINT `fk_market_access_strategy_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ADD CONSTRAINT `fk_market_access_strategy_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ADD CONSTRAINT `fk_market_hta_submission_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ADD CONSTRAINT `fk_market_hta_submission_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ADD CONSTRAINT `fk_market_value_dossier_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ADD CONSTRAINT `fk_market_market_payer_contract_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ADD CONSTRAINT `fk_market_market_payer_contract_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ADD CONSTRAINT `fk_market_coverage_decision_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ADD CONSTRAINT `fk_market_coverage_decision_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ADD CONSTRAINT `fk_market_pricing_decision_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ADD CONSTRAINT `fk_market_pricing_decision_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ADD CONSTRAINT `fk_market_tender_submission_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ADD CONSTRAINT `fk_market_tender_submission_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);

-- ========= market --> masterdata (15 constraint(s)) =========
-- Requires: market schema, masterdata schema
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ADD CONSTRAINT `fk_market_access_strategy_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ADD CONSTRAINT `fk_market_hta_submission_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ADD CONSTRAINT `fk_market_value_dossier_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ADD CONSTRAINT `fk_market_market_payer_contract_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ADD CONSTRAINT `fk_market_coverage_decision_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ADD CONSTRAINT `fk_market_patient_access_program_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ADD CONSTRAINT `fk_market_pricing_decision_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ADD CONSTRAINT `fk_market_pricing_decision_market_country_id` FOREIGN KEY (`market_country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ADD CONSTRAINT `fk_market_market_heor_study_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ADD CONSTRAINT `fk_market_rwe_dataset_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ADD CONSTRAINT `fk_market_payer_engagement_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ADD CONSTRAINT `fk_market_reimbursement_policy_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ADD CONSTRAINT `fk_market_tender_submission_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ADD CONSTRAINT `fk_market_outcomes_based_contract_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pharmacy` ADD CONSTRAINT `fk_market_pharmacy_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);

-- ========= market --> pharmacovigilance (2 constraint(s)) =========
-- Requires: market schema, pharmacovigilance schema
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ADD CONSTRAINT `fk_market_rwe_dataset_pass_study_id` FOREIGN KEY (`pass_study_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`pass_study`(`pass_study_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ADD CONSTRAINT `fk_market_rwe_dataset_safety_signal_id` FOREIGN KEY (`safety_signal_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`safety_signal`(`safety_signal_id`);

-- ========= market --> procurement (1 constraint(s)) =========
-- Requires: market schema, procurement schema
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ADD CONSTRAINT `fk_market_rwe_dataset_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= market --> product (16 constraint(s)) =========
-- Requires: market schema, product schema
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ADD CONSTRAINT `fk_market_access_strategy_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ADD CONSTRAINT `fk_market_access_strategy_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ADD CONSTRAINT `fk_market_market_formulary_position_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ADD CONSTRAINT `fk_market_market_formulary_position_formulary_listing_id` FOREIGN KEY (`formulary_listing_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`formulary_listing`(`formulary_listing_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ADD CONSTRAINT `fk_market_hta_submission_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ADD CONSTRAINT `fk_market_hta_submission_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ADD CONSTRAINT `fk_market_market_payer_contract_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ADD CONSTRAINT `fk_market_rebate_claim_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ADD CONSTRAINT `fk_market_gross_to_net_adjustment_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ADD CONSTRAINT `fk_market_coverage_decision_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ADD CONSTRAINT `fk_market_patient_access_program_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ADD CONSTRAINT `fk_market_pricing_decision_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ADD CONSTRAINT `fk_market_payer_engagement_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ADD CONSTRAINT `fk_market_reimbursement_policy_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ADD CONSTRAINT `fk_market_tender_submission_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ADD CONSTRAINT `fk_market_outcomes_based_contract_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);

-- ========= market --> supply (2 constraint(s)) =========
-- Requires: market schema, supply schema
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ADD CONSTRAINT `fk_market_rebate_claim_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ADD CONSTRAINT `fk_market_gross_to_net_adjustment_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);

-- ========= market --> workforce (6 constraint(s)) =========
-- Requires: market schema, workforce schema
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ADD CONSTRAINT `fk_market_payer_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ADD CONSTRAINT `fk_market_rwe_dataset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ADD CONSTRAINT `fk_market_payer_engagement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`kol_engagement_plan` ADD CONSTRAINT `fk_market_kol_engagement_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`study_data_sourcing` ADD CONSTRAINT `fk_market_study_data_sourcing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`study_data_sourcing` ADD CONSTRAINT `fk_market_study_data_sourcing_last_modified_by_employee_id` FOREIGN KEY (`last_modified_by_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= masterdata --> workforce (4 constraint(s)) =========
-- Requires: masterdata schema, workforce schema
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ADD CONSTRAINT `fk_masterdata_cost_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ADD CONSTRAINT `fk_masterdata_inn_registry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`system_crosswalk` ADD CONSTRAINT `fk_masterdata_system_crosswalk_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ADD CONSTRAINT `fk_masterdata_address_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= medical --> clinical (1 constraint(s)) =========
-- Requires: medical schema, clinical schema
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_publication` ADD CONSTRAINT `fk_medical_medical_publication_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);

-- ========= medical --> commercial (1 constraint(s)) =========
-- Requires: medical schema, commercial schema
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`msl_engagement` ADD CONSTRAINT `fk_medical_msl_engagement_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);

-- ========= medical --> compliance (10 constraint(s)) =========
-- Requires: medical schema, compliance schema
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`msl_engagement` ADD CONSTRAINT `fk_medical_msl_engagement_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_kol_profile` ADD CONSTRAINT `fk_medical_medical_kol_profile_conflict_of_interest_id` FOREIGN KEY (`conflict_of_interest_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest`(`conflict_of_interest_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`inquiry` ADD CONSTRAINT `fk_medical_inquiry_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_heor_study` ADD CONSTRAINT `fk_medical_medical_heor_study_privacy_impact_assessment_id` FOREIGN KEY (`privacy_impact_assessment_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`privacy_impact_assessment`(`privacy_impact_assessment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`med_education_program` ADD CONSTRAINT `fk_medical_med_education_program_disclosure_id` FOREIGN KEY (`disclosure_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`disclosure`(`disclosure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_advisory_board` ADD CONSTRAINT `fk_medical_medical_advisory_board_conflict_of_interest_id` FOREIGN KEY (`conflict_of_interest_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`conflict_of_interest`(`conflict_of_interest_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_advisory_board` ADD CONSTRAINT `fk_medical_medical_advisory_board_disclosure_id` FOREIGN KEY (`disclosure_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`disclosure`(`disclosure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`affairs_plan` ADD CONSTRAINT `fk_medical_affairs_plan_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`named_patient_request` ADD CONSTRAINT `fk_medical_named_patient_request_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`grant` ADD CONSTRAINT `fk_medical_grant_disclosure_id` FOREIGN KEY (`disclosure_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`disclosure`(`disclosure_id`);

-- ========= medical --> discovery (14 constraint(s)) =========
-- Requires: medical schema, discovery schema
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`iit_submission` ADD CONSTRAINT `fk_medical_iit_submission_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`iit_submission` ADD CONSTRAINT `fk_medical_iit_submission_molecular_target_id` FOREIGN KEY (`molecular_target_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`molecular_target`(`molecular_target_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_publication` ADD CONSTRAINT `fk_medical_medical_publication_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_publication` ADD CONSTRAINT `fk_medical_medical_publication_molecular_target_id` FOREIGN KEY (`molecular_target_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`molecular_target`(`molecular_target_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_publication` ADD CONSTRAINT `fk_medical_medical_publication_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_heor_study` ADD CONSTRAINT `fk_medical_medical_heor_study_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_advisory_board` ADD CONSTRAINT `fk_medical_medical_advisory_board_molecular_target_id` FOREIGN KEY (`molecular_target_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`molecular_target`(`molecular_target_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`content` ADD CONSTRAINT `fk_medical_content_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`content` ADD CONSTRAINT `fk_medical_content_molecular_target_id` FOREIGN KEY (`molecular_target_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`molecular_target`(`molecular_target_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`congress_event` ADD CONSTRAINT `fk_medical_congress_event_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`affairs_plan` ADD CONSTRAINT `fk_medical_affairs_plan_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`named_patient_request` ADD CONSTRAINT `fk_medical_named_patient_request_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`evidence_gap` ADD CONSTRAINT `fk_medical_evidence_gap_molecular_target_id` FOREIGN KEY (`molecular_target_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`molecular_target`(`molecular_target_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`evidence_gap` ADD CONSTRAINT `fk_medical_evidence_gap_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);

-- ========= medical --> finance (13 constraint(s)) =========
-- Requires: medical schema, finance schema
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`msl_engagement` ADD CONSTRAINT `fk_medical_msl_engagement_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_kol_profile` ADD CONSTRAINT `fk_medical_medical_kol_profile_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`iit_submission` ADD CONSTRAINT `fk_medical_iit_submission_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`iit_submission` ADD CONSTRAINT `fk_medical_iit_submission_rd_capitalization_id` FOREIGN KEY (`rd_capitalization_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`rd_capitalization`(`rd_capitalization_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`iit_submission` ADD CONSTRAINT `fk_medical_iit_submission_royalty_agreement_id` FOREIGN KEY (`royalty_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`royalty_agreement`(`royalty_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_publication` ADD CONSTRAINT `fk_medical_medical_publication_royalty_agreement_id` FOREIGN KEY (`royalty_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`royalty_agreement`(`royalty_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_heor_study` ADD CONSTRAINT `fk_medical_medical_heor_study_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_heor_study` ADD CONSTRAINT `fk_medical_medical_heor_study_rd_capitalization_id` FOREIGN KEY (`rd_capitalization_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`rd_capitalization`(`rd_capitalization_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`med_education_program` ADD CONSTRAINT `fk_medical_med_education_program_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`content` ADD CONSTRAINT `fk_medical_content_rd_capitalization_id` FOREIGN KEY (`rd_capitalization_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`rd_capitalization`(`rd_capitalization_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`congress_event` ADD CONSTRAINT `fk_medical_congress_event_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`affairs_plan` ADD CONSTRAINT `fk_medical_affairs_plan_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`grant` ADD CONSTRAINT `fk_medical_grant_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);

-- ========= medical --> hcp (9 constraint(s)) =========
-- Requires: medical schema, hcp schema
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`msl_engagement` ADD CONSTRAINT `fk_medical_msl_engagement_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`inquiry` ADD CONSTRAINT `fk_medical_inquiry_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`inquiry` ADD CONSTRAINT `fk_medical_inquiry_requester_master_id` FOREIGN KEY (`requester_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`iit_submission` ADD CONSTRAINT `fk_medical_iit_submission_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`iit_submission` ADD CONSTRAINT `fk_medical_iit_submission_investigator_id` FOREIGN KEY (`investigator_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`investigator`(`investigator_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_advisory_board` ADD CONSTRAINT `fk_medical_medical_advisory_board_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_advisory_board` ADD CONSTRAINT `fk_medical_medical_advisory_board_primary_medical_chairperson_hcp_physician_master_id` FOREIGN KEY (`primary_medical_chairperson_hcp_physician_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`named_patient_request` ADD CONSTRAINT `fk_medical_named_patient_request_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_advisory_board_membership` ADD CONSTRAINT `fk_medical_medical_advisory_board_membership_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`contract`(`contract_id`);

-- ========= medical --> intellectual (15 constraint(s)) =========
-- Requires: medical schema, intellectual schema
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_kol_profile` ADD CONSTRAINT `fk_medical_medical_kol_profile_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`iit_submission` ADD CONSTRAINT `fk_medical_iit_submission_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`iit_submission` ADD CONSTRAINT `fk_medical_iit_submission_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_publication` ADD CONSTRAINT `fk_medical_medical_publication_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_publication` ADD CONSTRAINT `fk_medical_medical_publication_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_publication` ADD CONSTRAINT `fk_medical_medical_publication_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_family`(`patent_family_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_publication` ADD CONSTRAINT `fk_medical_medical_publication_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_heor_study` ADD CONSTRAINT `fk_medical_medical_heor_study_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`med_education_program` ADD CONSTRAINT `fk_medical_med_education_program_trademark_id` FOREIGN KEY (`trademark_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`trademark`(`trademark_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_advisory_board` ADD CONSTRAINT `fk_medical_medical_advisory_board_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_family`(`patent_family_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`content` ADD CONSTRAINT `fk_medical_content_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`content` ADD CONSTRAINT `fk_medical_content_trademark_id` FOREIGN KEY (`trademark_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`trademark`(`trademark_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`affairs_plan` ADD CONSTRAINT `fk_medical_affairs_plan_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_family`(`patent_family_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`named_patient_request` ADD CONSTRAINT `fk_medical_named_patient_request_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`evidence_gap` ADD CONSTRAINT `fk_medical_evidence_gap_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_family`(`patent_family_id`);

-- ========= medical --> manufacturing (2 constraint(s)) =========
-- Requires: medical schema, manufacturing schema
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`iit_submission` ADD CONSTRAINT `fk_medical_iit_submission_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`named_patient_request` ADD CONSTRAINT `fk_medical_named_patient_request_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);

-- ========= medical --> market (7 constraint(s)) =========
-- Requires: medical schema, market schema
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_kol_profile` ADD CONSTRAINT `fk_medical_medical_kol_profile_payer_engagement_id` FOREIGN KEY (`payer_engagement_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`payer_engagement`(`payer_engagement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`iit_submission` ADD CONSTRAINT `fk_medical_iit_submission_market_heor_study_id` FOREIGN KEY (`market_heor_study_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`market_heor_study`(`market_heor_study_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_publication` ADD CONSTRAINT `fk_medical_medical_publication_hta_submission_id` FOREIGN KEY (`hta_submission_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`hta_submission`(`hta_submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_heor_study` ADD CONSTRAINT `fk_medical_medical_heor_study_market_heor_study_id` FOREIGN KEY (`market_heor_study_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`market_heor_study`(`market_heor_study_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`content` ADD CONSTRAINT `fk_medical_content_value_dossier_id` FOREIGN KEY (`value_dossier_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`value_dossier`(`value_dossier_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`affairs_plan` ADD CONSTRAINT `fk_medical_affairs_plan_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`evidence_gap` ADD CONSTRAINT `fk_medical_evidence_gap_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);

-- ========= medical --> masterdata (21 constraint(s)) =========
-- Requires: medical schema, masterdata schema
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`msl_profile` ADD CONSTRAINT `fk_medical_msl_profile_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`msl_profile` ADD CONSTRAINT `fk_medical_msl_profile_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`msl_engagement` ADD CONSTRAINT `fk_medical_msl_engagement_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_kol_profile` ADD CONSTRAINT `fk_medical_medical_kol_profile_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`inquiry` ADD CONSTRAINT `fk_medical_inquiry_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`inquiry` ADD CONSTRAINT `fk_medical_inquiry_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`iit_submission` ADD CONSTRAINT `fk_medical_iit_submission_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_publication` ADD CONSTRAINT `fk_medical_medical_publication_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_heor_study` ADD CONSTRAINT `fk_medical_medical_heor_study_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`med_education_program` ADD CONSTRAINT `fk_medical_med_education_program_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`med_education_program` ADD CONSTRAINT `fk_medical_med_education_program_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_advisory_board` ADD CONSTRAINT `fk_medical_medical_advisory_board_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_advisory_board` ADD CONSTRAINT `fk_medical_medical_advisory_board_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`content` ADD CONSTRAINT `fk_medical_content_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`content` ADD CONSTRAINT `fk_medical_content_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`content` ADD CONSTRAINT `fk_medical_content_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`congress_event` ADD CONSTRAINT `fk_medical_congress_event_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`affairs_plan` ADD CONSTRAINT `fk_medical_affairs_plan_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`named_patient_request` ADD CONSTRAINT `fk_medical_named_patient_request_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`named_patient_request` ADD CONSTRAINT `fk_medical_named_patient_request_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`grant` ADD CONSTRAINT `fk_medical_grant_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);

-- ========= medical --> procurement (2 constraint(s)) =========
-- Requires: medical schema, procurement schema
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`grant` ADD CONSTRAINT `fk_medical_grant_cro_cmo_engagement_id` FOREIGN KEY (`cro_cmo_engagement_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement`(`cro_cmo_engagement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`grant` ADD CONSTRAINT `fk_medical_grant_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= medical --> product (15 constraint(s)) =========
-- Requires: medical schema, product schema
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`msl_engagement` ADD CONSTRAINT `fk_medical_msl_engagement_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`msl_engagement` ADD CONSTRAINT `fk_medical_msl_engagement_product_asset_medicinal_product_id` FOREIGN KEY (`product_asset_medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`msl_engagement` ADD CONSTRAINT `fk_medical_msl_engagement_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`inquiry` ADD CONSTRAINT `fk_medical_inquiry_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`iit_submission` ADD CONSTRAINT `fk_medical_iit_submission_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`iit_submission` ADD CONSTRAINT `fk_medical_iit_submission_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_publication` ADD CONSTRAINT `fk_medical_medical_publication_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_publication` ADD CONSTRAINT `fk_medical_medical_publication_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_heor_study` ADD CONSTRAINT `fk_medical_medical_heor_study_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`med_education_program` ADD CONSTRAINT `fk_medical_med_education_program_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_advisory_board` ADD CONSTRAINT `fk_medical_medical_advisory_board_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`content` ADD CONSTRAINT `fk_medical_content_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`named_patient_request` ADD CONSTRAINT `fk_medical_named_patient_request_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`grant` ADD CONSTRAINT `fk_medical_grant_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`evidence_gap` ADD CONSTRAINT `fk_medical_evidence_gap_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);

-- ========= medical --> supply (1 constraint(s)) =========
-- Requires: medical schema, supply schema
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_publication` ADD CONSTRAINT `fk_medical_medical_publication_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`plan`(`plan_id`);

-- ========= medical --> workforce (12 constraint(s)) =========
-- Requires: medical schema, workforce schema
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`msl_profile` ADD CONSTRAINT `fk_medical_msl_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`inquiry` ADD CONSTRAINT `fk_medical_inquiry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_publication` ADD CONSTRAINT `fk_medical_medical_publication_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_heor_study` ADD CONSTRAINT `fk_medical_medical_heor_study_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`med_education_program` ADD CONSTRAINT `fk_medical_med_education_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`medical_advisory_board` ADD CONSTRAINT `fk_medical_medical_advisory_board_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`content` ADD CONSTRAINT `fk_medical_content_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`congress_event` ADD CONSTRAINT `fk_medical_congress_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`affairs_plan` ADD CONSTRAINT `fk_medical_affairs_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`affairs_plan` ADD CONSTRAINT `fk_medical_affairs_plan_tertiary_affairs_approved_by_employee_id` FOREIGN KEY (`tertiary_affairs_approved_by_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`named_patient_request` ADD CONSTRAINT `fk_medical_named_patient_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`medical`.`evidence_gap` ADD CONSTRAINT `fk_medical_evidence_gap_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= patient --> clinical (30 constraint(s)) =========
-- Requires: patient schema, clinical schema
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_clinical_enrollment_id` FOREIGN KEY (`clinical_enrollment_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`clinical_enrollment`(`clinical_enrollment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ADD CONSTRAINT `fk_patient_informed_consent_econsent_document_id` FOREIGN KEY (`econsent_document_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`econsent_document`(`econsent_document_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ADD CONSTRAINT `fk_patient_informed_consent_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ADD CONSTRAINT `fk_patient_informed_consent_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ADD CONSTRAINT `fk_patient_concomitant_medication_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ADD CONSTRAINT `fk_patient_concomitant_medication_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`visit`(`visit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ADD CONSTRAINT `fk_patient_adverse_event_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ADD CONSTRAINT `fk_patient_adverse_event_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ADD CONSTRAINT `fk_patient_treatment_exposure_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ADD CONSTRAINT `fk_patient_treatment_exposure_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ADD CONSTRAINT `fk_patient_treatment_exposure_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`visit`(`visit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ADD CONSTRAINT `fk_patient_clinical_observation_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ADD CONSTRAINT `fk_patient_clinical_observation_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`visit`(`visit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ADD CONSTRAINT `fk_patient_reported_outcome_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ADD CONSTRAINT `fk_patient_reported_outcome_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ADD CONSTRAINT `fk_patient_reported_outcome_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`visit`(`visit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ADD CONSTRAINT `fk_patient_protocol_deviation_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ADD CONSTRAINT `fk_patient_protocol_deviation_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`protocol`(`protocol_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ADD CONSTRAINT `fk_patient_protocol_deviation_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ADD CONSTRAINT `fk_patient_biomarker_result_biospecimen_id` FOREIGN KEY (`biospecimen_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`biospecimen`(`biospecimen_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ADD CONSTRAINT `fk_patient_biomarker_result_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ADD CONSTRAINT `fk_patient_biomarker_result_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`visit`(`visit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ADD CONSTRAINT `fk_patient_diagnosis_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ADD CONSTRAINT `fk_patient_diagnosis_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`visit`(`visit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ADD CONSTRAINT `fk_patient_endpoint_assessment_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ADD CONSTRAINT `fk_patient_endpoint_assessment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`visit`(`visit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ADD CONSTRAINT `fk_patient_caregiver_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);

-- ========= patient --> commercial (8 constraint(s)) =========
-- Requires: patient schema, commercial schema
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ADD CONSTRAINT `fk_patient_adverse_event_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ADD CONSTRAINT `fk_patient_treatment_exposure_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ADD CONSTRAINT `fk_patient_clinical_observation_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ADD CONSTRAINT `fk_patient_reported_outcome_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ADD CONSTRAINT `fk_patient_support_program_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ADD CONSTRAINT `fk_patient_support_program_patient_support_program_id` FOREIGN KEY (`patient_support_program_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`patient_support_program`(`patient_support_program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ADD CONSTRAINT `fk_patient_biomarker_result_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);

-- ========= patient --> compliance (9 constraint(s)) =========
-- Requires: patient schema, compliance schema
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ADD CONSTRAINT `fk_patient_informed_consent_privacy_obligation_id` FOREIGN KEY (`privacy_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`privacy_obligation`(`privacy_obligation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ADD CONSTRAINT `fk_patient_informed_consent_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ADD CONSTRAINT `fk_patient_adverse_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ADD CONSTRAINT `fk_patient_adverse_event_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ADD CONSTRAINT `fk_patient_protocol_deviation_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ADD CONSTRAINT `fk_patient_protocol_deviation_inspection_observation_id` FOREIGN KEY (`inspection_observation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`inspection_observation`(`inspection_observation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ADD CONSTRAINT `fk_patient_protocol_deviation_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);

-- ========= patient --> discovery (11 constraint(s)) =========
-- Requires: patient schema, discovery schema
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_lead_series_id` FOREIGN KEY (`lead_series_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`lead_series`(`lead_series_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ADD CONSTRAINT `fk_patient_concomitant_medication_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ADD CONSTRAINT `fk_patient_adverse_event_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ADD CONSTRAINT `fk_patient_treatment_exposure_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ADD CONSTRAINT `fk_patient_clinical_observation_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ADD CONSTRAINT `fk_patient_biomarker_result_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ADD CONSTRAINT `fk_patient_biomarker_result_molecular_target_id` FOREIGN KEY (`molecular_target_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`molecular_target`(`molecular_target_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ADD CONSTRAINT `fk_patient_diagnosis_molecular_target_id` FOREIGN KEY (`molecular_target_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`molecular_target`(`molecular_target_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ADD CONSTRAINT `fk_patient_endpoint_assessment_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);

-- ========= patient --> finance (7 constraint(s)) =========
-- Requires: patient schema, finance schema
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ADD CONSTRAINT `fk_patient_adverse_event_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ADD CONSTRAINT `fk_patient_treatment_exposure_cogs_entry_id` FOREIGN KEY (`cogs_entry_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`cogs_entry`(`cogs_entry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ADD CONSTRAINT `fk_patient_registry_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ADD CONSTRAINT `fk_patient_support_program_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ADD CONSTRAINT `fk_patient_support_program_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);

-- ========= patient --> hcp (6 constraint(s)) =========
-- Requires: patient schema, hcp schema
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ADD CONSTRAINT `fk_patient_informed_consent_investigator_id` FOREIGN KEY (`investigator_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`investigator`(`investigator_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ADD CONSTRAINT `fk_patient_treatment_exposure_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ADD CONSTRAINT `fk_patient_clinical_observation_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ADD CONSTRAINT `fk_patient_support_program_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ADD CONSTRAINT `fk_patient_biomarker_result_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ADD CONSTRAINT `fk_patient_diagnosis_investigator_id` FOREIGN KEY (`investigator_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`investigator`(`investigator_id`);

-- ========= patient --> manufacturing (2 constraint(s)) =========
-- Requires: patient schema, manufacturing schema
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ADD CONSTRAINT `fk_patient_adverse_event_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ADD CONSTRAINT `fk_patient_treatment_exposure_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);

-- ========= patient --> market (1 constraint(s)) =========
-- Requires: patient schema, market schema
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ADD CONSTRAINT `fk_patient_support_program_patient_access_program_id` FOREIGN KEY (`patient_access_program_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`patient_access_program`(`patient_access_program_id`);

-- ========= patient --> masterdata (16 constraint(s)) =========
-- Requires: patient schema, masterdata schema
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ADD CONSTRAINT `fk_patient_patient_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ADD CONSTRAINT `fk_patient_informed_consent_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ADD CONSTRAINT `fk_patient_concomitant_medication_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ADD CONSTRAINT `fk_patient_treatment_exposure_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ADD CONSTRAINT `fk_patient_treatment_exposure_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ADD CONSTRAINT `fk_patient_treatment_exposure_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`storage_location`(`storage_location_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ADD CONSTRAINT `fk_patient_clinical_observation_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ADD CONSTRAINT `fk_patient_reported_outcome_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ADD CONSTRAINT `fk_patient_registry_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ADD CONSTRAINT `fk_patient_support_program_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ADD CONSTRAINT `fk_patient_protocol_deviation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ADD CONSTRAINT `fk_patient_biomarker_result_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ADD CONSTRAINT `fk_patient_diagnosis_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ADD CONSTRAINT `fk_patient_endpoint_assessment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`caregiver` ADD CONSTRAINT `fk_patient_caregiver_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);

-- ========= patient --> medical (7 constraint(s)) =========
-- Requires: patient schema, medical schema
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_affairs_plan_id` FOREIGN KEY (`affairs_plan_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`affairs_plan`(`affairs_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ADD CONSTRAINT `fk_patient_informed_consent_iit_submission_id` FOREIGN KEY (`iit_submission_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`iit_submission`(`iit_submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ADD CONSTRAINT `fk_patient_adverse_event_inquiry_id` FOREIGN KEY (`inquiry_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`inquiry`(`inquiry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ADD CONSTRAINT `fk_patient_treatment_exposure_named_patient_request_id` FOREIGN KEY (`named_patient_request_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`named_patient_request`(`named_patient_request_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ADD CONSTRAINT `fk_patient_protocol_deviation_affairs_plan_id` FOREIGN KEY (`affairs_plan_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`affairs_plan`(`affairs_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`diagnosis` ADD CONSTRAINT `fk_patient_diagnosis_medical_heor_study_id` FOREIGN KEY (`medical_heor_study_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`medical_heor_study`(`medical_heor_study_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ADD CONSTRAINT `fk_patient_endpoint_assessment_iit_submission_id` FOREIGN KEY (`iit_submission_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`iit_submission`(`iit_submission_id`);

-- ========= patient --> product (7 constraint(s)) =========
-- Requires: patient schema, product schema
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ADD CONSTRAINT `fk_patient_concomitant_medication_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ADD CONSTRAINT `fk_patient_adverse_event_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ADD CONSTRAINT `fk_patient_treatment_exposure_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ADD CONSTRAINT `fk_patient_registry_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ADD CONSTRAINT `fk_patient_biomarker_result_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry_enrollment` ADD CONSTRAINT `fk_patient_registry_enrollment_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);

-- ========= patient --> regulatory (9 constraint(s)) =========
-- Requires: patient schema, regulatory schema
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_designation_id` FOREIGN KEY (`designation_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`designation`(`designation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_application_id` FOREIGN KEY (`application_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`application`(`application_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ADD CONSTRAINT `fk_patient_informed_consent_application_id` FOREIGN KEY (`application_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`application`(`application_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ADD CONSTRAINT `fk_patient_adverse_event_application_id` FOREIGN KEY (`application_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`application`(`application_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ADD CONSTRAINT `fk_patient_adverse_event_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ADD CONSTRAINT `fk_patient_support_program_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ADD CONSTRAINT `fk_patient_protocol_deviation_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ADD CONSTRAINT `fk_patient_biomarker_result_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry_enrollment` ADD CONSTRAINT `fk_patient_registry_enrollment_post_approval_commitment_id` FOREIGN KEY (`post_approval_commitment_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment`(`post_approval_commitment_id`);

-- ========= patient --> workforce (2 constraint(s)) =========
-- Requires: patient schema, workforce schema
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ADD CONSTRAINT `fk_patient_support_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`endpoint_assessment` ADD CONSTRAINT `fk_patient_endpoint_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= pharmacovigilance --> clinical (3 constraint(s)) =========
-- Requires: pharmacovigilance schema, clinical schema
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`susar` ADD CONSTRAINT `fk_pharmacovigilance_susar_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`sae_report` ADD CONSTRAINT `fk_pharmacovigilance_sae_report_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);

-- ========= pharmacovigilance --> commercial (14 constraint(s)) =========
-- Requires: pharmacovigilance schema, commercial schema
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_adverse_reaction` ADD CONSTRAINT `fk_pharmacovigilance_pv_adverse_reaction_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`susar` ADD CONSTRAINT `fk_pharmacovigilance_susar_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`sae_report` ADD CONSTRAINT `fk_pharmacovigilance_sae_report_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_submission` ADD CONSTRAINT `fk_pharmacovigilance_pv_submission_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`psur` ADD CONSTRAINT `fk_pharmacovigilance_psur_brand_plan_id` FOREIGN KEY (`brand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand_plan`(`brand_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`rmp` ADD CONSTRAINT `fk_pharmacovigilance_rmp_brand_plan_id` FOREIGN KEY (`brand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand_plan`(`brand_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`rmp` ADD CONSTRAINT `fk_pharmacovigilance_rmp_patient_support_program_id` FOREIGN KEY (`patient_support_program_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`patient_support_program`(`patient_support_program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`rmp` ADD CONSTRAINT `fk_pharmacovigilance_rmp_promo_material_id` FOREIGN KEY (`promo_material_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`promo_material`(`promo_material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_mlr_review_id` FOREIGN KEY (`mlr_review_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`mlr_review`(`mlr_review_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_patient_support_program_id` FOREIGN KEY (`patient_support_program_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`patient_support_program`(`patient_support_program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_promo_material_id` FOREIGN KEY (`promo_material_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`promo_material`(`promo_material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`suspect_drug` ADD CONSTRAINT `fk_pharmacovigilance_suspect_drug_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);

-- ========= pharmacovigilance --> compliance (9 constraint(s)) =========
-- Requires: pharmacovigilance schema, compliance schema
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_submission` ADD CONSTRAINT `fk_pharmacovigilance_pv_submission_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`rmp` ADD CONSTRAINT `fk_pharmacovigilance_rmp_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`safety_signal` ADD CONSTRAINT `fk_pharmacovigilance_safety_signal_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`reporter` ADD CONSTRAINT `fk_pharmacovigilance_reporter_debarment_check_id` FOREIGN KEY (`debarment_check_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`debarment_check`(`debarment_check_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_action` ADD CONSTRAINT `fk_pharmacovigilance_pv_action_compliance_capa_id` FOREIGN KEY (`compliance_capa_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`compliance_capa`(`compliance_capa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_action` ADD CONSTRAINT `fk_pharmacovigilance_pv_action_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_agreement` ADD CONSTRAINT `fk_pharmacovigilance_pv_agreement_third_party_due_diligence_id` FOREIGN KEY (`third_party_due_diligence_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence`(`third_party_due_diligence_id`);

-- ========= pharmacovigilance --> discovery (7 constraint(s)) =========
-- Requires: pharmacovigilance schema, discovery schema
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_in_vivo_study_id` FOREIGN KEY (`in_vivo_study_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`in_vivo_study`(`in_vivo_study_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`safety_signal` ADD CONSTRAINT `fk_pharmacovigilance_safety_signal_molecular_target_id` FOREIGN KEY (`molecular_target_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`molecular_target`(`molecular_target_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_candidate_nomination_id` FOREIGN KEY (`candidate_nomination_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`candidate_nomination`(`candidate_nomination_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_molecular_target_id` FOREIGN KEY (`molecular_target_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`molecular_target`(`molecular_target_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);

-- ========= pharmacovigilance --> finance (8 constraint(s)) =========
-- Requires: pharmacovigilance schema, finance schema
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`susar` ADD CONSTRAINT `fk_pharmacovigilance_susar_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`sae_report` ADD CONSTRAINT `fk_pharmacovigilance_sae_report_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_rd_capitalization_id` FOREIGN KEY (`rd_capitalization_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`rd_capitalization`(`rd_capitalization_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_action` ADD CONSTRAINT `fk_pharmacovigilance_pv_action_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_agreement` ADD CONSTRAINT `fk_pharmacovigilance_pv_agreement_royalty_agreement_id` FOREIGN KEY (`royalty_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`royalty_agreement`(`royalty_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pass_study` ADD CONSTRAINT `fk_pharmacovigilance_pass_study_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pass_study` ADD CONSTRAINT `fk_pharmacovigilance_pass_study_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);

-- ========= pharmacovigilance --> hcp (7 constraint(s)) =========
-- Requires: pharmacovigilance schema, hcp schema
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`sae_report` ADD CONSTRAINT `fk_pharmacovigilance_sae_report_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`suspect_drug` ADD CONSTRAINT `fk_pharmacovigilance_suspect_drug_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`reporter` ADD CONSTRAINT `fk_pharmacovigilance_reporter_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_action` ADD CONSTRAINT `fk_pharmacovigilance_pv_action_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`rmp_review` ADD CONSTRAINT `fk_pharmacovigilance_rmp_review_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`signal_expert_consultation` ADD CONSTRAINT `fk_pharmacovigilance_signal_expert_consultation_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);

-- ========= pharmacovigilance --> intellectual (4 constraint(s)) =========
-- Requires: pharmacovigilance schema, intellectual schema
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`psur` ADD CONSTRAINT `fk_pharmacovigilance_psur_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);

-- ========= pharmacovigilance --> manufacturing (1 constraint(s)) =========
-- Requires: pharmacovigilance schema, manufacturing schema
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);

-- ========= pharmacovigilance --> masterdata (18 constraint(s)) =========
-- Requires: pharmacovigilance schema, masterdata schema
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_adverse_reaction` ADD CONSTRAINT `fk_pharmacovigilance_pv_adverse_reaction_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_submission` ADD CONSTRAINT `fk_pharmacovigilance_pv_submission_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`psur` ADD CONSTRAINT `fk_pharmacovigilance_psur_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`rmp` ADD CONSTRAINT `fk_pharmacovigilance_rmp_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`safety_signal` ADD CONSTRAINT `fk_pharmacovigilance_safety_signal_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_masterdata_ndc_code_id` FOREIGN KEY (`masterdata_ndc_code_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code`(`masterdata_ndc_code_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`suspect_drug` ADD CONSTRAINT `fk_pharmacovigilance_suspect_drug_masterdata_ndc_code_id` FOREIGN KEY (`masterdata_ndc_code_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code`(`masterdata_ndc_code_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`suspect_drug` ADD CONSTRAINT `fk_pharmacovigilance_suspect_drug_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`reporter` ADD CONSTRAINT `fk_pharmacovigilance_reporter_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`reporter` ADD CONSTRAINT `fk_pharmacovigilance_reporter_address_id` FOREIGN KEY (`address_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`address`(`address_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_agreement` ADD CONSTRAINT `fk_pharmacovigilance_pv_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pass_study` ADD CONSTRAINT `fk_pharmacovigilance_pass_study_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);

-- ========= pharmacovigilance --> medical (7 constraint(s)) =========
-- Requires: pharmacovigilance schema, medical schema
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`psur` ADD CONSTRAINT `fk_pharmacovigilance_psur_medical_publication_id` FOREIGN KEY (`medical_publication_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`medical_publication`(`medical_publication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`rmp` ADD CONSTRAINT `fk_pharmacovigilance_rmp_medical_heor_study_id` FOREIGN KEY (`medical_heor_study_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`medical_heor_study`(`medical_heor_study_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`rmp` ADD CONSTRAINT `fk_pharmacovigilance_rmp_medical_publication_id` FOREIGN KEY (`medical_publication_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`medical_publication`(`medical_publication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`safety_signal` ADD CONSTRAINT `fk_pharmacovigilance_safety_signal_affairs_plan_id` FOREIGN KEY (`affairs_plan_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`affairs_plan`(`affairs_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_affairs_plan_id` FOREIGN KEY (`affairs_plan_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`affairs_plan`(`affairs_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_action` ADD CONSTRAINT `fk_pharmacovigilance_pv_action_content_id` FOREIGN KEY (`content_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`content`(`content_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pass_study` ADD CONSTRAINT `fk_pharmacovigilance_pass_study_medical_heor_study_id` FOREIGN KEY (`medical_heor_study_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`medical_heor_study`(`medical_heor_study_id`);

-- ========= pharmacovigilance --> patient (3 constraint(s)) =========
-- Requires: pharmacovigilance schema, patient schema
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`susar` ADD CONSTRAINT `fk_pharmacovigilance_susar_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`sae_report` ADD CONSTRAINT `fk_pharmacovigilance_sae_report_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);

-- ========= pharmacovigilance --> procurement (7 constraint(s)) =========
-- Requires: pharmacovigilance schema, procurement schema
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_approved_vendor_list_id` FOREIGN KEY (`approved_vendor_list_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list`(`approved_vendor_list_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_cro_cmo_engagement_id` FOREIGN KEY (`cro_cmo_engagement_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement`(`cro_cmo_engagement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_supplier_quality_agreement_id` FOREIGN KEY (`supplier_quality_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement`(`supplier_quality_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`suspect_drug` ADD CONSTRAINT `fk_pharmacovigilance_suspect_drug_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`suspect_drug` ADD CONSTRAINT `fk_pharmacovigilance_suspect_drug_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pass_study` ADD CONSTRAINT `fk_pharmacovigilance_pass_study_cro_cmo_engagement_id` FOREIGN KEY (`cro_cmo_engagement_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement`(`cro_cmo_engagement_id`);

-- ========= pharmacovigilance --> product (3 constraint(s)) =========
-- Requires: pharmacovigilance schema, product schema
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`product_listedness` ADD CONSTRAINT `fk_pharmacovigilance_product_listedness_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`signal_indication_assessment` ADD CONSTRAINT `fk_pharmacovigilance_signal_indication_assessment_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);

-- ========= pharmacovigilance --> regulatory (6 constraint(s)) =========
-- Requires: pharmacovigilance schema, regulatory schema
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_submission` ADD CONSTRAINT `fk_pharmacovigilance_pv_submission_application_id` FOREIGN KEY (`application_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`application`(`application_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`psur` ADD CONSTRAINT `fk_pharmacovigilance_psur_application_id` FOREIGN KEY (`application_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`application`(`application_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`psur` ADD CONSTRAINT `fk_pharmacovigilance_psur_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`rmp` ADD CONSTRAINT `fk_pharmacovigilance_rmp_application_id` FOREIGN KEY (`application_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`application`(`application_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`rmp` ADD CONSTRAINT `fk_pharmacovigilance_rmp_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pass_study` ADD CONSTRAINT `fk_pharmacovigilance_pass_study_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`approval`(`approval_id`);

-- ========= pharmacovigilance --> workforce (8 constraint(s)) =========
-- Requires: pharmacovigilance schema, workforce schema
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`susar` ADD CONSTRAINT `fk_pharmacovigilance_susar_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`sae_report` ADD CONSTRAINT `fk_pharmacovigilance_sae_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`psur` ADD CONSTRAINT `fk_pharmacovigilance_psur_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`psur` ADD CONSTRAINT `fk_pharmacovigilance_psur_psur_medical_reviewer_employee_id` FOREIGN KEY (`psur_medical_reviewer_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`psur` ADD CONSTRAINT `fk_pharmacovigilance_psur_psur_qppv_employee_id` FOREIGN KEY (`psur_qppv_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`safety_signal` ADD CONSTRAINT `fk_pharmacovigilance_safety_signal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_action` ADD CONSTRAINT `fk_pharmacovigilance_pv_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= procurement --> compliance (9 constraint(s)) =========
-- Requires: procurement schema, compliance schema
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ADD CONSTRAINT `fk_procurement_vendor_qualification_gxp_obligation_id` FOREIGN KEY (`gxp_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`gxp_obligation`(`gxp_obligation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ADD CONSTRAINT `fk_procurement_supplier_audit_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`audit_finding` ADD CONSTRAINT `fk_procurement_audit_finding_compliance_capa_id` FOREIGN KEY (`compliance_capa_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`compliance_capa`(`compliance_capa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement` ADD CONSTRAINT `fk_procurement_supplier_quality_agreement_gxp_obligation_id` FOREIGN KEY (`gxp_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`gxp_obligation`(`gxp_obligation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ADD CONSTRAINT `fk_procurement_incoming_inspection_internal_control_id` FOREIGN KEY (`internal_control_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`internal_control`(`internal_control_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_performance` ADD CONSTRAINT `fk_procurement_vendor_performance_monitoring_activity_id` FOREIGN KEY (`monitoring_activity_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`monitoring_activity`(`monitoring_activity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ADD CONSTRAINT `fk_procurement_vendor_complaint_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ADD CONSTRAINT `fk_procurement_cro_cmo_engagement_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_gxp_qualification` ADD CONSTRAINT `fk_procurement_vendor_gxp_qualification_gxp_obligation_id` FOREIGN KEY (`gxp_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`gxp_obligation`(`gxp_obligation_id`);

-- ========= procurement --> manufacturing (4 constraint(s)) =========
-- Requires: procurement schema, manufacturing schema
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ADD CONSTRAINT `fk_procurement_vendor_complaint_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ADD CONSTRAINT `fk_procurement_approved_vendor_list_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);

-- ========= procurement --> masterdata (38 constraint(s)) =========
-- Requires: procurement schema, masterdata schema
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ADD CONSTRAINT `fk_procurement_vendor_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ADD CONSTRAINT `fk_procurement_vendor_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor` ADD CONSTRAINT `fk_procurement_vendor_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ADD CONSTRAINT `fk_procurement_vendor_site_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ADD CONSTRAINT `fk_procurement_vendor_site_address_id` FOREIGN KEY (`address_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`address`(`address_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_site` ADD CONSTRAINT `fk_procurement_vendor_site_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`contract_price_schedule` ADD CONSTRAINT `fk_procurement_contract_price_schedule_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`storage_location`(`storage_location_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`storage_location`(`storage_location_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ADD CONSTRAINT `fk_procurement_incoming_inspection_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ADD CONSTRAINT `fk_procurement_incoming_inspection_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`storage_location`(`storage_location_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ADD CONSTRAINT `fk_procurement_invoice_line_item_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ADD CONSTRAINT `fk_procurement_invoice_line_item_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ADD CONSTRAINT `fk_procurement_invoice_line_item_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ADD CONSTRAINT `fk_procurement_invoice_line_item_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ADD CONSTRAINT `fk_procurement_invoice_line_item_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`storage_location`(`storage_location_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`invoice_line_item` ADD CONSTRAINT `fk_procurement_invoice_line_item_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ADD CONSTRAINT `fk_procurement_sourcing_material_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ADD CONSTRAINT `fk_procurement_sourcing_material_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`storage_location`(`storage_location_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_supply_agreement_id` FOREIGN KEY (`supply_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`supply_agreement`(`supply_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_material` ADD CONSTRAINT `fk_procurement_approved_vendor_material_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);

-- ========= procurement --> medical (1 constraint(s)) =========
-- Requires: procurement schema, medical schema
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ADD CONSTRAINT `fk_procurement_cro_cmo_engagement_affairs_plan_id` FOREIGN KEY (`affairs_plan_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`affairs_plan`(`affairs_plan_id`);

-- ========= procurement --> product (6 constraint(s)) =========
-- Requires: procurement schema, product schema
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ADD CONSTRAINT `fk_procurement_supply_contract_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supply_contract` ADD CONSTRAINT `fk_procurement_supply_contract_excipient_id` FOREIGN KEY (`excipient_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`excipient`(`excipient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`approved_vendor_list` ADD CONSTRAINT `fk_procurement_approved_vendor_list_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ADD CONSTRAINT `fk_procurement_cro_cmo_engagement_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ADD CONSTRAINT `fk_procurement_sourcing_material_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`sourcing_material` ADD CONSTRAINT `fk_procurement_sourcing_material_excipient_id` FOREIGN KEY (`excipient_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`excipient`(`excipient_id`);

-- ========= procurement --> quality (1 constraint(s)) =========
-- Requires: procurement schema, quality schema
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ADD CONSTRAINT `fk_procurement_vendor_qualification_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`audit`(`audit_id`);

-- ========= procurement --> regulatory (4 constraint(s)) =========
-- Requires: procurement schema, regulatory schema
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ADD CONSTRAINT `fk_procurement_vendor_qualification_dmf_id` FOREIGN KEY (`dmf_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`dmf`(`dmf_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ADD CONSTRAINT `fk_procurement_supplier_audit_pai_id` FOREIGN KEY (`pai_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`pai`(`pai_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ADD CONSTRAINT `fk_procurement_cro_cmo_engagement_application_id` FOREIGN KEY (`application_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`application`(`application_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement` ADD CONSTRAINT `fk_procurement_cro_cmo_engagement_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);

-- ========= procurement --> supply (4 constraint(s)) =========
-- Requires: procurement schema, supply schema
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ADD CONSTRAINT `fk_procurement_incoming_inspection_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_complaint` ADD CONSTRAINT `fk_procurement_vendor_complaint_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`shipment`(`shipment_id`);

-- ========= procurement --> workforce (11 constraint(s)) =========
-- Requires: procurement schema, workforce schema
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ADD CONSTRAINT `fk_procurement_vendor_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_qualification` ADD CONSTRAINT `fk_procurement_vendor_qualification_tertiary_vendor_modified_by_employee_id` FOREIGN KEY (`tertiary_vendor_modified_by_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`supplier_audit` ADD CONSTRAINT `fk_procurement_supplier_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_requester_employee_id` FOREIGN KEY (`requester_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`incoming_inspection` ADD CONSTRAINT `fk_procurement_incoming_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= product --> clinical (1 constraint(s)) =========
-- Requires: product schema, clinical schema
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ADD CONSTRAINT `fk_product_product_change_control_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`protocol`(`protocol_id`);

-- ========= product --> commercial (1 constraint(s)) =========
-- Requires: product schema, commercial schema
ALTER TABLE `pharmaceuticals_ecm`.`product`.`contract_pricing` ADD CONSTRAINT `fk_product_contract_pricing_contract_account_id` FOREIGN KEY (`contract_account_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`contract_account`(`contract_account_id`);

-- ========= product --> compliance (9 constraint(s)) =========
-- Requires: product schema, compliance schema
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ADD CONSTRAINT `fk_product_lifecycle_risk_register_id` FOREIGN KEY (`risk_register_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`risk_register`(`risk_register_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ADD CONSTRAINT `fk_product_labeling_compliance_capa_id` FOREIGN KEY (`compliance_capa_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`compliance_capa`(`compliance_capa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ADD CONSTRAINT `fk_product_labeling_inspection_observation_id` FOREIGN KEY (`inspection_observation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`inspection_observation`(`inspection_observation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ADD CONSTRAINT `fk_product_labeling_policy_document_id` FOREIGN KEY (`policy_document_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`policy_document`(`policy_document_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ADD CONSTRAINT `fk_product_product_change_control_compliance_capa_id` FOREIGN KEY (`compliance_capa_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`compliance_capa`(`compliance_capa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ADD CONSTRAINT `fk_product_product_change_control_inspection_response_id` FOREIGN KEY (`inspection_response_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`inspection_response`(`inspection_response_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ADD CONSTRAINT `fk_product_therapeutic_area_gxp_obligation_id` FOREIGN KEY (`gxp_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`gxp_obligation`(`gxp_obligation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ADD CONSTRAINT `fk_product_device_component_part11_system_id` FOREIGN KEY (`part11_system_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`part11_system`(`part11_system_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ADD CONSTRAINT `fk_product_bioequivalence_study_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);

-- ========= product --> discovery (1 constraint(s)) =========
-- Requires: product schema, discovery schema
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product_assay_specification` ADD CONSTRAINT `fk_product_drug_product_assay_specification_assay_id` FOREIGN KEY (`assay_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`assay`(`assay_id`);

-- ========= product --> finance (3 constraint(s)) =========
-- Requires: product schema, finance schema
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ADD CONSTRAINT `fk_product_formulation_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ADD CONSTRAINT `fk_product_lifecycle_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ADD CONSTRAINT `fk_product_bioequivalence_study_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);

-- ========= product --> hcp (2 constraint(s)) =========
-- Requires: product schema, hcp schema
ALTER TABLE `pharmaceuticals_ecm`.`product`.`prescription` ADD CONSTRAINT `fk_product_prescription_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` ADD CONSTRAINT `fk_product_product_payer_contract_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`contract`(`contract_id`);

-- ========= product --> intellectual (13 constraint(s)) =========
-- Requires: product schema, intellectual schema
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ADD CONSTRAINT `fk_product_medicinal_product_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_family`(`patent_family_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ADD CONSTRAINT `fk_product_medicinal_product_trademark_id` FOREIGN KEY (`trademark_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`trademark`(`trademark_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ADD CONSTRAINT `fk_product_drug_substance_drug_master_file_id` FOREIGN KEY (`drug_master_file_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`drug_master_file`(`drug_master_file_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ADD CONSTRAINT `fk_product_drug_substance_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ADD CONSTRAINT `fk_product_drug_product_drug_master_file_id` FOREIGN KEY (`drug_master_file_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`drug_master_file`(`drug_master_file_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ADD CONSTRAINT `fk_product_drug_product_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ADD CONSTRAINT `fk_product_formulation_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ADD CONSTRAINT `fk_product_formulation_ingredient_drug_master_file_id` FOREIGN KEY (`drug_master_file_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`drug_master_file`(`drug_master_file_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ADD CONSTRAINT `fk_product_packaging_configuration_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_trademark_id` FOREIGN KEY (`trademark_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`trademark`(`trademark_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ADD CONSTRAINT `fk_product_labeling_orange_book_listing_id` FOREIGN KEY (`orange_book_listing_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`orange_book_listing`(`orange_book_listing_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ADD CONSTRAINT `fk_product_combination_product_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_family`(`patent_family_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ADD CONSTRAINT `fk_product_bioequivalence_study_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);

-- ========= product --> manufacturing (6 constraint(s)) =========
-- Requires: product schema, manufacturing schema
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ADD CONSTRAINT `fk_product_product_change_control_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ADD CONSTRAINT `fk_product_combination_product_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ADD CONSTRAINT `fk_product_device_component_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ADD CONSTRAINT `fk_product_pharmaceutical_product_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product_assay_specification` ADD CONSTRAINT `fk_product_drug_product_assay_specification_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);

-- ========= product --> market (2 constraint(s)) =========
-- Requires: product schema, market schema
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulary_listing` ADD CONSTRAINT `fk_product_formulary_listing_payer_account_id` FOREIGN KEY (`payer_account_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`payer_account`(`payer_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` ADD CONSTRAINT `fk_product_product_payer_contract_payer_account_id` FOREIGN KEY (`payer_account_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`payer_account`(`payer_account_id`);

-- ========= product --> masterdata (53 constraint(s)) =========
-- Requires: product schema, masterdata schema
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ADD CONSTRAINT `fk_product_medicinal_product_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ADD CONSTRAINT `fk_product_medicinal_product_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ADD CONSTRAINT `fk_product_medicinal_product_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ADD CONSTRAINT `fk_product_medicinal_product_masterdata_ndc_code_id` FOREIGN KEY (`masterdata_ndc_code_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code`(`masterdata_ndc_code_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ADD CONSTRAINT `fk_product_medicinal_product_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ADD CONSTRAINT `fk_product_medicinal_product_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ADD CONSTRAINT `fk_product_drug_substance_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ADD CONSTRAINT `fk_product_drug_substance_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ADD CONSTRAINT `fk_product_drug_substance_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ADD CONSTRAINT `fk_product_drug_substance_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ADD CONSTRAINT `fk_product_drug_product_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ADD CONSTRAINT `fk_product_drug_product_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ADD CONSTRAINT `fk_product_drug_product_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ADD CONSTRAINT `fk_product_drug_product_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ADD CONSTRAINT `fk_product_drug_product_masterdata_ndc_code_id` FOREIGN KEY (`masterdata_ndc_code_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code`(`masterdata_ndc_code_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ADD CONSTRAINT `fk_product_drug_product_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ADD CONSTRAINT `fk_product_drug_product_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ADD CONSTRAINT `fk_product_formulation_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ADD CONSTRAINT `fk_product_formulation_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ADD CONSTRAINT `fk_product_formulation_ingredient_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ADD CONSTRAINT `fk_product_formulation_ingredient_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ADD CONSTRAINT `fk_product_formulation_ingredient_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ADD CONSTRAINT `fk_product_packaging_configuration_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ADD CONSTRAINT `fk_product_packaging_configuration_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_masterdata_ndc_code_id` FOREIGN KEY (`masterdata_ndc_code_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code`(`masterdata_ndc_code_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ADD CONSTRAINT `fk_product_product_ndc_code_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ADD CONSTRAINT `fk_product_product_ndc_code_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ADD CONSTRAINT `fk_product_regulatory_identifier_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ADD CONSTRAINT `fk_product_regulatory_identifier_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ADD CONSTRAINT `fk_product_regulatory_identifier_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ADD CONSTRAINT `fk_product_indication_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ADD CONSTRAINT `fk_product_indication_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ADD CONSTRAINT `fk_product_labeling_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ADD CONSTRAINT `fk_product_labeling_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ADD CONSTRAINT `fk_product_combination_product_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ADD CONSTRAINT `fk_product_combination_product_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ADD CONSTRAINT `fk_product_combination_product_masterdata_ndc_code_id` FOREIGN KEY (`masterdata_ndc_code_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code`(`masterdata_ndc_code_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ADD CONSTRAINT `fk_product_therapeutic_area_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ADD CONSTRAINT `fk_product_therapeutic_area_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ADD CONSTRAINT `fk_product_therapeutic_area_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ADD CONSTRAINT `fk_product_device_component_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ADD CONSTRAINT `fk_product_excipient_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ADD CONSTRAINT `fk_product_excipient_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ADD CONSTRAINT `fk_product_bioequivalence_study_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ADD CONSTRAINT `fk_product_bioequivalence_study_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ADD CONSTRAINT `fk_product_bioequivalence_study_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ADD CONSTRAINT `fk_product_pharmaceutical_product_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ADD CONSTRAINT `fk_product_pharmaceutical_product_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ADD CONSTRAINT `fk_product_pharmaceutical_product_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ADD CONSTRAINT `fk_product_specified_substance_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`supply_allocation` ADD CONSTRAINT `fk_product_supply_allocation_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);

-- ========= product --> medical (1 constraint(s)) =========
-- Requires: product schema, medical schema
ALTER TABLE `pharmaceuticals_ecm`.`product`.`kol_product_engagement` ADD CONSTRAINT `fk_product_kol_product_engagement_medical_kol_profile_id` FOREIGN KEY (`medical_kol_profile_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`medical_kol_profile`(`medical_kol_profile_id`);

-- ========= product --> patient (1 constraint(s)) =========
-- Requires: product schema, patient schema
ALTER TABLE `pharmaceuticals_ecm`.`product`.`prescription` ADD CONSTRAINT `fk_product_prescription_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);

-- ========= product --> procurement (6 constraint(s)) =========
-- Requires: product schema, procurement schema
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ADD CONSTRAINT `fk_product_drug_substance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ADD CONSTRAINT `fk_product_formulation_ingredient_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ADD CONSTRAINT `fk_product_packaging_configuration_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ADD CONSTRAINT `fk_product_device_component_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ADD CONSTRAINT `fk_product_bioequivalence_study_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`approved_vendor` ADD CONSTRAINT `fk_product_approved_vendor_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= product --> regulatory (2 constraint(s)) =========
-- Requires: product schema, regulatory schema
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ADD CONSTRAINT `fk_product_labeling_label_id` FOREIGN KEY (`label_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`label`(`label_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ADD CONSTRAINT `fk_product_bioequivalence_study_dossier_document_id` FOREIGN KEY (`dossier_document_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`dossier_document`(`dossier_document_id`);

-- ========= product --> workforce (8 constraint(s)) =========
-- Requires: product schema, workforce schema
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ADD CONSTRAINT `fk_product_medicinal_product_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ADD CONSTRAINT `fk_product_drug_substance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ADD CONSTRAINT `fk_product_drug_product_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ADD CONSTRAINT `fk_product_formulation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ADD CONSTRAINT `fk_product_lifecycle_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ADD CONSTRAINT `fk_product_therapeutic_area_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ADD CONSTRAINT `fk_product_bioequivalence_study_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` ADD CONSTRAINT `fk_product_product_payer_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= quality --> commercial (6 constraint(s)) =========
-- Requires: quality schema, commercial schema
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_sales_rep_id` FOREIGN KEY (`sales_rep_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`sales_rep`(`sales_rep_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ADD CONSTRAINT `fk_quality_coa_contract_account_id` FOREIGN KEY (`contract_account_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`contract_account`(`contract_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_call_activity_id` FOREIGN KEY (`call_activity_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`call_activity`(`call_activity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_sales_rep_id` FOREIGN KEY (`sales_rep_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`sales_rep`(`sales_rep_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);

-- ========= quality --> compliance (10 constraint(s)) =========
-- Requires: quality schema, compliance schema
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ADD CONSTRAINT `fk_quality_quality_change_control_internal_control_id` FOREIGN KEY (`internal_control_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`internal_control`(`internal_control_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_gxp_obligation_id` FOREIGN KEY (`gxp_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`gxp_obligation`(`gxp_obligation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ADD CONSTRAINT `fk_quality_validation_internal_control_id` FOREIGN KEY (`internal_control_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`internal_control`(`internal_control_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_gxp_obligation_id` FOREIGN KEY (`gxp_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`gxp_obligation`(`gxp_obligation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ADD CONSTRAINT `fk_quality_supplier_qualification_third_party_due_diligence_id` FOREIGN KEY (`third_party_due_diligence_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence`(`third_party_due_diligence_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ADD CONSTRAINT `fk_quality_product_quality_review_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);

-- ========= quality --> finance (14 constraint(s)) =========
-- Requires: quality schema, finance schema
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ADD CONSTRAINT `fk_quality_quality_capa_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ADD CONSTRAINT `fk_quality_quality_capa_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ADD CONSTRAINT `fk_quality_quality_change_control_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ADD CONSTRAINT `fk_quality_quality_change_control_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ADD CONSTRAINT `fk_quality_lab_test_result_cogs_entry_id` FOREIGN KEY (`cogs_entry_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`cogs_entry`(`cogs_entry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_cogs_entry_id` FOREIGN KEY (`cogs_entry_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`cogs_entry`(`cogs_entry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ADD CONSTRAINT `fk_quality_method_validation_rd_capitalization_id` FOREIGN KEY (`rd_capitalization_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`rd_capitalization`(`rd_capitalization_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ADD CONSTRAINT `fk_quality_coa_cogs_entry_id` FOREIGN KEY (`cogs_entry_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`cogs_entry`(`cogs_entry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ADD CONSTRAINT `fk_quality_batch_disposition_cogs_entry_id` FOREIGN KEY (`cogs_entry_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`cogs_entry`(`cogs_entry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ADD CONSTRAINT `fk_quality_validation_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ADD CONSTRAINT `fk_quality_supplier_qualification_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ADD CONSTRAINT `fk_quality_product_quality_review_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);

-- ========= quality --> hcp (6 constraint(s)) =========
-- Requires: quality schema, hcp schema
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ADD CONSTRAINT `fk_quality_quality_capa_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_investigator_id` FOREIGN KEY (`investigator_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`investigator`(`investigator_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ADD CONSTRAINT `fk_quality_coa_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);

-- ========= quality --> intellectual (11 constraint(s)) =========
-- Requires: quality schema, intellectual schema
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ADD CONSTRAINT `fk_quality_quality_capa_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ADD CONSTRAINT `fk_quality_quality_change_control_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ADD CONSTRAINT `fk_quality_quality_change_control_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ADD CONSTRAINT `fk_quality_method_validation_drug_master_file_id` FOREIGN KEY (`drug_master_file_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`drug_master_file`(`drug_master_file_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ADD CONSTRAINT `fk_quality_method_validation_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ADD CONSTRAINT `fk_quality_validation_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_drug_master_file_id` FOREIGN KEY (`drug_master_file_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`drug_master_file`(`drug_master_file_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ADD CONSTRAINT `fk_quality_supplier_qualification_drug_master_file_id` FOREIGN KEY (`drug_master_file_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`drug_master_file`(`drug_master_file_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ADD CONSTRAINT `fk_quality_supplier_qualification_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);

-- ========= quality --> manufacturing (27 constraint(s)) =========
-- Requires: quality schema, manufacturing schema
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ADD CONSTRAINT `fk_quality_quality_capa_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ADD CONSTRAINT `fk_quality_quality_capa_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`equipment`(`equipment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ADD CONSTRAINT `fk_quality_quality_change_control_master_batch_record_id` FOREIGN KEY (`master_batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record`(`master_batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ADD CONSTRAINT `fk_quality_lab_test_result_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ADD CONSTRAINT `fk_quality_lab_test_result_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`equipment`(`equipment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ADD CONSTRAINT `fk_quality_lab_test_result_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ADD CONSTRAINT `fk_quality_method_validation_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ADD CONSTRAINT `fk_quality_coa_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ADD CONSTRAINT `fk_quality_coa_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ADD CONSTRAINT `fk_quality_batch_disposition_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ADD CONSTRAINT `fk_quality_batch_disposition_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ADD CONSTRAINT `fk_quality_validation_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ADD CONSTRAINT `fk_quality_validation_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`equipment`(`equipment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ADD CONSTRAINT `fk_quality_validation_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ADD CONSTRAINT `fk_quality_supplier_qualification_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ADD CONSTRAINT `fk_quality_product_quality_review_master_batch_record_id` FOREIGN KEY (`master_batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record`(`master_batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ADD CONSTRAINT `fk_quality_product_quality_review_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`root_cause_analysis` ADD CONSTRAINT `fk_quality_root_cause_analysis_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_event` ADD CONSTRAINT `fk_quality_quality_event_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);

-- ========= quality --> market (6 constraint(s)) =========
-- Requires: quality schema, market schema
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_payer_account_id` FOREIGN KEY (`payer_account_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`payer_account`(`payer_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ADD CONSTRAINT `fk_quality_coa_market_payer_contract_id` FOREIGN KEY (`market_payer_contract_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`market_payer_contract`(`market_payer_contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ADD CONSTRAINT `fk_quality_batch_disposition_market_payer_contract_id` FOREIGN KEY (`market_payer_contract_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`market_payer_contract`(`market_payer_contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_payer_account_id` FOREIGN KEY (`payer_account_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`payer_account`(`payer_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ADD CONSTRAINT `fk_quality_product_quality_review_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);

-- ========= quality --> masterdata (3 constraint(s)) =========
-- Requires: quality schema, masterdata schema
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ADD CONSTRAINT `fk_quality_coa_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);

-- ========= quality --> medical (5 constraint(s)) =========
-- Requires: quality schema, medical schema
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ADD CONSTRAINT `fk_quality_quality_capa_inquiry_id` FOREIGN KEY (`inquiry_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`inquiry`(`inquiry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ADD CONSTRAINT `fk_quality_coa_named_patient_request_id` FOREIGN KEY (`named_patient_request_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`named_patient_request`(`named_patient_request_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ADD CONSTRAINT `fk_quality_batch_disposition_named_patient_request_id` FOREIGN KEY (`named_patient_request_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`named_patient_request`(`named_patient_request_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_inquiry_id` FOREIGN KEY (`inquiry_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`inquiry`(`inquiry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ADD CONSTRAINT `fk_quality_supplier_qualification_iit_submission_id` FOREIGN KEY (`iit_submission_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`iit_submission`(`iit_submission_id`);

-- ========= quality --> patient (2 constraint(s)) =========
-- Requires: quality schema, patient schema
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_adverse_event_id` FOREIGN KEY (`adverse_event_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`adverse_event`(`adverse_event_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);

-- ========= quality --> pharmacovigilance (3 constraint(s)) =========
-- Requires: quality schema, pharmacovigilance schema
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ADD CONSTRAINT `fk_quality_batch_disposition_icsr_id` FOREIGN KEY (`icsr_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr`(`icsr_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_icsr_id` FOREIGN KEY (`icsr_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr`(`icsr_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ADD CONSTRAINT `fk_quality_product_quality_review_safety_signal_id` FOREIGN KEY (`safety_signal_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`safety_signal`(`safety_signal_id`);

-- ========= quality --> procurement (20 constraint(s)) =========
-- Requires: quality schema, procurement schema
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ADD CONSTRAINT `fk_quality_quality_change_control_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ADD CONSTRAINT `fk_quality_lab_test_result_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ADD CONSTRAINT `fk_quality_lab_test_result_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ADD CONSTRAINT `fk_quality_coa_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ADD CONSTRAINT `fk_quality_coa_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ADD CONSTRAINT `fk_quality_batch_disposition_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ADD CONSTRAINT `fk_quality_validation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ADD CONSTRAINT `fk_quality_supplier_qualification_supplier_quality_agreement_id` FOREIGN KEY (`supplier_quality_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`supplier_quality_agreement`(`supplier_quality_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ADD CONSTRAINT `fk_quality_supplier_qualification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ADD CONSTRAINT `fk_quality_product_quality_review_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit_site_inspection` ADD CONSTRAINT `fk_quality_audit_site_inspection_vendor_site_id` FOREIGN KEY (`vendor_site_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor_site`(`vendor_site_id`);

-- ========= quality --> product (27 constraint(s)) =========
-- Requires: quality schema, product schema
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ADD CONSTRAINT `fk_quality_quality_capa_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ADD CONSTRAINT `fk_quality_lab_test_result_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_packaging_configuration_id` FOREIGN KEY (`packaging_configuration_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`packaging_configuration`(`packaging_configuration_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ADD CONSTRAINT `fk_quality_method_validation_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ADD CONSTRAINT `fk_quality_method_validation_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ADD CONSTRAINT `fk_quality_coa_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ADD CONSTRAINT `fk_quality_coa_packaging_configuration_id` FOREIGN KEY (`packaging_configuration_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`packaging_configuration`(`packaging_configuration_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ADD CONSTRAINT `fk_quality_batch_disposition_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ADD CONSTRAINT `fk_quality_batch_disposition_packaging_configuration_id` FOREIGN KEY (`packaging_configuration_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`packaging_configuration`(`packaging_configuration_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_packaging_configuration_id` FOREIGN KEY (`packaging_configuration_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`packaging_configuration`(`packaging_configuration_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ADD CONSTRAINT `fk_quality_validation_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ADD CONSTRAINT `fk_quality_validation_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_excipient_id` FOREIGN KEY (`excipient_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`excipient`(`excipient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ADD CONSTRAINT `fk_quality_supplier_qualification_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ADD CONSTRAINT `fk_quality_supplier_qualification_excipient_id` FOREIGN KEY (`excipient_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`excipient`(`excipient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ADD CONSTRAINT `fk_quality_product_quality_review_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ADD CONSTRAINT `fk_quality_product_quality_review_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`root_cause_analysis` ADD CONSTRAINT `fk_quality_root_cause_analysis_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`analytical_method` ADD CONSTRAINT `fk_quality_analytical_method_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_event` ADD CONSTRAINT `fk_quality_quality_event_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);

-- ========= quality --> regulatory (1 constraint(s)) =========
-- Requires: quality schema, regulatory schema
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`approval`(`approval_id`);

-- ========= quality --> supply (11 constraint(s)) =========
-- Requires: quality schema, supply schema
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_warehouse_receipt_id` FOREIGN KEY (`warehouse_receipt_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`warehouse_receipt`(`warehouse_receipt_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ADD CONSTRAINT `fk_quality_lab_test_result_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ADD CONSTRAINT `fk_quality_coa_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ADD CONSTRAINT `fk_quality_batch_disposition_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ADD CONSTRAINT `fk_quality_validation_distribution_network_id` FOREIGN KEY (`distribution_network_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`distribution_network`(`distribution_network_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ADD CONSTRAINT `fk_quality_supplier_qualification_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ADD CONSTRAINT `fk_quality_product_quality_review_demand_plan_id` FOREIGN KEY (`demand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`demand_plan`(`demand_plan_id`);

-- ========= quality --> workforce (33 constraint(s)) =========
-- Requires: quality schema, workforce schema
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ADD CONSTRAINT `fk_quality_quality_capa_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ADD CONSTRAINT `fk_quality_quality_capa_primary_quality_employee_id` FOREIGN KEY (`primary_quality_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_capa` ADD CONSTRAINT `fk_quality_quality_capa_tertiary_quality_closed_by_employee_id` FOREIGN KEY (`tertiary_quality_closed_by_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_change_control` ADD CONSTRAINT `fk_quality_quality_change_control_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ADD CONSTRAINT `fk_quality_lab_test_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ADD CONSTRAINT `fk_quality_lab_test_result_tertiary_lab_approved_by_employee_id` FOREIGN KEY (`tertiary_lab_approved_by_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_quaternary_stability_responsible_person_employee_id` FOREIGN KEY (`quaternary_stability_responsible_person_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_tertiary_stability_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_stability_last_modified_by_user_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ADD CONSTRAINT `fk_quality_method_validation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ADD CONSTRAINT `fk_quality_coa_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ADD CONSTRAINT `fk_quality_coa_coa_qa_reviewer_employee_id` FOREIGN KEY (`coa_qa_reviewer_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ADD CONSTRAINT `fk_quality_batch_disposition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_complaint_employee_id` FOREIGN KEY (`complaint_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ADD CONSTRAINT `fk_quality_validation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ADD CONSTRAINT `fk_quality_supplier_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ADD CONSTRAINT `fk_quality_product_quality_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`product_quality_review` ADD CONSTRAINT `fk_quality_product_quality_review_tertiary_product_management_reviewer_employee_id` FOREIGN KEY (`tertiary_product_management_reviewer_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`root_cause_analysis` ADD CONSTRAINT `fk_quality_root_cause_analysis_approver_employee_id` FOREIGN KEY (`approver_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`root_cause_analysis` ADD CONSTRAINT `fk_quality_root_cause_analysis_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`sample` ADD CONSTRAINT `fk_quality_sample_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_event` ADD CONSTRAINT `fk_quality_quality_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_event` ADD CONSTRAINT `fk_quality_quality_event_last_modified_by_employee_id` FOREIGN KEY (`last_modified_by_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_event` ADD CONSTRAINT `fk_quality_quality_event_qa_approved_by_employee_id` FOREIGN KEY (`qa_approved_by_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_event` ADD CONSTRAINT `fk_quality_quality_event_reported_by_employee_id` FOREIGN KEY (`reported_by_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= regulatory --> commercial (23 constraint(s)) =========
-- Requires: regulatory schema, commercial schema
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`application` ADD CONSTRAINT `fk_regulatory_application_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`milestone` ADD CONSTRAINT `fk_regulatory_milestone_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`ha_interaction` ADD CONSTRAINT `fk_regulatory_ha_interaction_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`correspondence` ADD CONSTRAINT `fk_regulatory_correspondence_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`dmf` ADD CONSTRAINT `fk_regulatory_dmf_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label` ADD CONSTRAINT `fk_regulatory_label_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label` ADD CONSTRAINT `fk_regulatory_label_copay_program_id` FOREIGN KEY (`copay_program_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`copay_program`(`copay_program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label` ADD CONSTRAINT `fk_regulatory_label_promo_material_id` FOREIGN KEY (`promo_material_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`promo_material`(`promo_material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label_change` ADD CONSTRAINT `fk_regulatory_label_change_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label_change` ADD CONSTRAINT `fk_regulatory_label_change_promo_material_id` FOREIGN KEY (`promo_material_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`promo_material`(`promo_material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`rems` ADD CONSTRAINT `fk_regulatory_rems_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`rems` ADD CONSTRAINT `fk_regulatory_rems_copay_program_id` FOREIGN KEY (`copay_program_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`copay_program`(`copay_program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`rems` ADD CONSTRAINT `fk_regulatory_rems_patient_support_program_id` FOREIGN KEY (`patient_support_program_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`patient_support_program`(`patient_support_program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`rems` ADD CONSTRAINT `fk_regulatory_rems_sample_management_id` FOREIGN KEY (`sample_management_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`sample_management`(`sample_management_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment` ADD CONSTRAINT `fk_regulatory_post_approval_commitment_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment` ADD CONSTRAINT `fk_regulatory_post_approval_commitment_brand_plan_id` FOREIGN KEY (`brand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand_plan`(`brand_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`designation` ADD CONSTRAINT `fk_regulatory_designation_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`designation` ADD CONSTRAINT `fk_regulatory_designation_patient_support_program_id` FOREIGN KEY (`patient_support_program_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`patient_support_program`(`patient_support_program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`variation` ADD CONSTRAINT `fk_regulatory_variation_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`product_registration` ADD CONSTRAINT `fk_regulatory_product_registration_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`renewal` ADD CONSTRAINT `fk_regulatory_renewal_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);

-- ========= regulatory --> compliance (2 constraint(s)) =========
-- Requires: regulatory schema, compliance schema
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`pai` ADD CONSTRAINT `fk_regulatory_pai_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`designation` ADD CONSTRAINT `fk_regulatory_designation_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);

-- ========= regulatory --> finance (11 constraint(s)) =========
-- Requires: regulatory schema, finance schema
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`application` ADD CONSTRAINT `fk_regulatory_application_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`milestone` ADD CONSTRAINT `fk_regulatory_milestone_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`rems` ADD CONSTRAINT `fk_regulatory_rems_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment` ADD CONSTRAINT `fk_regulatory_post_approval_commitment_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`pai` ADD CONSTRAINT `fk_regulatory_pai_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`strategy` ADD CONSTRAINT `fk_regulatory_strategy_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`dossier_document` ADD CONSTRAINT `fk_regulatory_dossier_document_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`designation` ADD CONSTRAINT `fk_regulatory_designation_milestone_payment_id` FOREIGN KEY (`milestone_payment_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`milestone_payment`(`milestone_payment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`variation` ADD CONSTRAINT `fk_regulatory_variation_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`renewal` ADD CONSTRAINT `fk_regulatory_renewal_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);

-- ========= regulatory --> hcp (3 constraint(s)) =========
-- Requires: regulatory schema, hcp schema
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`application` ADD CONSTRAINT `fk_regulatory_application_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`milestone` ADD CONSTRAINT `fk_regulatory_milestone_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);

-- ========= regulatory --> intellectual (8 constraint(s)) =========
-- Requires: regulatory schema, intellectual schema
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`application` ADD CONSTRAINT `fk_regulatory_application_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label` ADD CONSTRAINT `fk_regulatory_label_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment` ADD CONSTRAINT `fk_regulatory_post_approval_commitment_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`pai` ADD CONSTRAINT `fk_regulatory_pai_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`designation` ADD CONSTRAINT `fk_regulatory_designation_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`variation` ADD CONSTRAINT `fk_regulatory_variation_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`product_registration` ADD CONSTRAINT `fk_regulatory_product_registration_trademark_id` FOREIGN KEY (`trademark_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`trademark`(`trademark_id`);

-- ========= regulatory --> manufacturing (7 constraint(s)) =========
-- Requires: regulatory schema, manufacturing schema
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`application` ADD CONSTRAINT `fk_regulatory_application_master_batch_record_id` FOREIGN KEY (`master_batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record`(`master_batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment` ADD CONSTRAINT `fk_regulatory_post_approval_commitment_process_validation_id` FOREIGN KEY (`process_validation_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`process_validation`(`process_validation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`pai` ADD CONSTRAINT `fk_regulatory_pai_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`strategy` ADD CONSTRAINT `fk_regulatory_strategy_technology_transfer_id` FOREIGN KEY (`technology_transfer_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`technology_transfer`(`technology_transfer_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`dossier_document` ADD CONSTRAINT `fk_regulatory_dossier_document_master_batch_record_id` FOREIGN KEY (`master_batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record`(`master_batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`variation` ADD CONSTRAINT `fk_regulatory_variation_master_batch_record_id` FOREIGN KEY (`master_batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record`(`master_batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`application_site_authorization` ADD CONSTRAINT `fk_regulatory_application_site_authorization_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);

-- ========= regulatory --> market (10 constraint(s)) =========
-- Requires: regulatory schema, market schema
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`application` ADD CONSTRAINT `fk_regulatory_application_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_hta_submission_id` FOREIGN KEY (`hta_submission_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`hta_submission`(`hta_submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label` ADD CONSTRAINT `fk_regulatory_label_coverage_decision_id` FOREIGN KEY (`coverage_decision_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`coverage_decision`(`coverage_decision_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label_change` ADD CONSTRAINT `fk_regulatory_label_change_coverage_decision_id` FOREIGN KEY (`coverage_decision_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`coverage_decision`(`coverage_decision_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`rems` ADD CONSTRAINT `fk_regulatory_rems_market_payer_contract_id` FOREIGN KEY (`market_payer_contract_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`market_payer_contract`(`market_payer_contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`rems` ADD CONSTRAINT `fk_regulatory_rems_patient_access_program_id` FOREIGN KEY (`patient_access_program_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`patient_access_program`(`patient_access_program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment` ADD CONSTRAINT `fk_regulatory_post_approval_commitment_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`designation` ADD CONSTRAINT `fk_regulatory_designation_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`product_registration` ADD CONSTRAINT `fk_regulatory_product_registration_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`reimbursement_policy`(`reimbursement_policy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`payer_coverage` ADD CONSTRAINT `fk_regulatory_payer_coverage_payer_account_id` FOREIGN KEY (`payer_account_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`payer_account`(`payer_account_id`);

-- ========= regulatory --> masterdata (19 constraint(s)) =========
-- Requires: regulatory schema, masterdata schema
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`health_authority` ADD CONSTRAINT `fk_regulatory_health_authority_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`application` ADD CONSTRAINT `fk_regulatory_application_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`application` ADD CONSTRAINT `fk_regulatory_application_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`application` ADD CONSTRAINT `fk_regulatory_application_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_masterdata_ndc_code_id` FOREIGN KEY (`masterdata_ndc_code_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code`(`masterdata_ndc_code_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`dmf` ADD CONSTRAINT `fk_regulatory_dmf_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`dmf` ADD CONSTRAINT `fk_regulatory_dmf_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label` ADD CONSTRAINT `fk_regulatory_label_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`rems` ADD CONSTRAINT `fk_regulatory_rems_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`designation` ADD CONSTRAINT `fk_regulatory_designation_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`variation` ADD CONSTRAINT `fk_regulatory_variation_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`product_registration` ADD CONSTRAINT `fk_regulatory_product_registration_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`product_registration` ADD CONSTRAINT `fk_regulatory_product_registration_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`product_registration` ADD CONSTRAINT `fk_regulatory_product_registration_masterdata_ndc_code_id` FOREIGN KEY (`masterdata_ndc_code_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code`(`masterdata_ndc_code_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`renewal` ADD CONSTRAINT `fk_regulatory_renewal_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);

-- ========= regulatory --> medical (11 constraint(s)) =========
-- Requires: regulatory schema, medical schema
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`application` ADD CONSTRAINT `fk_regulatory_application_affairs_plan_id` FOREIGN KEY (`affairs_plan_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`affairs_plan`(`affairs_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`milestone` ADD CONSTRAINT `fk_regulatory_milestone_affairs_plan_id` FOREIGN KEY (`affairs_plan_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`affairs_plan`(`affairs_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`correspondence` ADD CONSTRAINT `fk_regulatory_correspondence_inquiry_id` FOREIGN KEY (`inquiry_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`inquiry`(`inquiry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label` ADD CONSTRAINT `fk_regulatory_label_content_id` FOREIGN KEY (`content_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`content`(`content_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label_change` ADD CONSTRAINT `fk_regulatory_label_change_content_id` FOREIGN KEY (`content_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`content`(`content_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`rems` ADD CONSTRAINT `fk_regulatory_rems_med_education_program_id` FOREIGN KEY (`med_education_program_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`med_education_program`(`med_education_program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment` ADD CONSTRAINT `fk_regulatory_post_approval_commitment_iit_submission_id` FOREIGN KEY (`iit_submission_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`iit_submission`(`iit_submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment` ADD CONSTRAINT `fk_regulatory_post_approval_commitment_medical_heor_study_id` FOREIGN KEY (`medical_heor_study_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`medical_heor_study`(`medical_heor_study_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`pai` ADD CONSTRAINT `fk_regulatory_pai_iit_submission_id` FOREIGN KEY (`iit_submission_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`iit_submission`(`iit_submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`dossier_document` ADD CONSTRAINT `fk_regulatory_dossier_document_content_id` FOREIGN KEY (`content_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`content`(`content_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`variation` ADD CONSTRAINT `fk_regulatory_variation_content_id` FOREIGN KEY (`content_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`content`(`content_id`);

-- ========= regulatory --> pharmacovigilance (11 constraint(s)) =========
-- Requires: regulatory schema, pharmacovigilance schema
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`milestone` ADD CONSTRAINT `fk_regulatory_milestone_psur_id` FOREIGN KEY (`psur_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`psur`(`psur_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`milestone` ADD CONSTRAINT `fk_regulatory_milestone_rmp_id` FOREIGN KEY (`rmp_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`rmp`(`rmp_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`ha_interaction` ADD CONSTRAINT `fk_regulatory_ha_interaction_safety_signal_id` FOREIGN KEY (`safety_signal_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`safety_signal`(`safety_signal_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`correspondence` ADD CONSTRAINT `fk_regulatory_correspondence_psur_id` FOREIGN KEY (`psur_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`psur`(`psur_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`correspondence` ADD CONSTRAINT `fk_regulatory_correspondence_susar_id` FOREIGN KEY (`susar_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`susar`(`susar_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label` ADD CONSTRAINT `fk_regulatory_label_rmp_id` FOREIGN KEY (`rmp_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`rmp`(`rmp_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label_change` ADD CONSTRAINT `fk_regulatory_label_change_safety_signal_id` FOREIGN KEY (`safety_signal_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`safety_signal`(`safety_signal_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`rems` ADD CONSTRAINT `fk_regulatory_rems_rmp_id` FOREIGN KEY (`rmp_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`rmp`(`rmp_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`dossier_document` ADD CONSTRAINT `fk_regulatory_dossier_document_psur_id` FOREIGN KEY (`psur_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`psur`(`psur_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`dossier_document` ADD CONSTRAINT `fk_regulatory_dossier_document_rmp_id` FOREIGN KEY (`rmp_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`rmp`(`rmp_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`variation` ADD CONSTRAINT `fk_regulatory_variation_safety_signal_id` FOREIGN KEY (`safety_signal_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`safety_signal`(`safety_signal_id`);

-- ========= regulatory --> procurement (5 constraint(s)) =========
-- Requires: regulatory schema, procurement schema
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`dmf` ADD CONSTRAINT `fk_regulatory_dmf_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment` ADD CONSTRAINT `fk_regulatory_post_approval_commitment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`dossier_document` ADD CONSTRAINT `fk_regulatory_dossier_document_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`service_engagement` ADD CONSTRAINT `fk_regulatory_service_engagement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= regulatory --> product (16 constraint(s)) =========
-- Requires: regulatory schema, product schema
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`application` ADD CONSTRAINT `fk_regulatory_application_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`milestone` ADD CONSTRAINT `fk_regulatory_milestone_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`correspondence` ADD CONSTRAINT `fk_regulatory_correspondence_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`dmf` ADD CONSTRAINT `fk_regulatory_dmf_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label` ADD CONSTRAINT `fk_regulatory_label_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label_change` ADD CONSTRAINT `fk_regulatory_label_change_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment` ADD CONSTRAINT `fk_regulatory_post_approval_commitment_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`strategy` ADD CONSTRAINT `fk_regulatory_strategy_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`dossier_document` ADD CONSTRAINT `fk_regulatory_dossier_document_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`designation` ADD CONSTRAINT `fk_regulatory_designation_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`variation` ADD CONSTRAINT `fk_regulatory_variation_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`product_registration` ADD CONSTRAINT `fk_regulatory_product_registration_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`renewal` ADD CONSTRAINT `fk_regulatory_renewal_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`application_indication` ADD CONSTRAINT `fk_regulatory_application_indication_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);

-- ========= regulatory --> quality (9 constraint(s)) =========
-- Requires: regulatory schema, quality schema
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`milestone` ADD CONSTRAINT `fk_regulatory_milestone_validation_id` FOREIGN KEY (`validation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`validation`(`validation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`correspondence` ADD CONSTRAINT `fk_regulatory_correspondence_quality_capa_id` FOREIGN KEY (`quality_capa_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_capa`(`quality_capa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label` ADD CONSTRAINT `fk_regulatory_label_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label_change` ADD CONSTRAINT `fk_regulatory_label_change_quality_capa_id` FOREIGN KEY (`quality_capa_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_capa`(`quality_capa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment` ADD CONSTRAINT `fk_regulatory_post_approval_commitment_quality_capa_id` FOREIGN KEY (`quality_capa_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_capa`(`quality_capa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`pai` ADD CONSTRAINT `fk_regulatory_pai_quality_capa_id` FOREIGN KEY (`quality_capa_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_capa`(`quality_capa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`dossier_document` ADD CONSTRAINT `fk_regulatory_dossier_document_method_validation_id` FOREIGN KEY (`method_validation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`method_validation`(`method_validation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`variation` ADD CONSTRAINT `fk_regulatory_variation_quality_change_control_id` FOREIGN KEY (`quality_change_control_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_change_control`(`quality_change_control_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`product_registration` ADD CONSTRAINT `fk_regulatory_product_registration_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`specification`(`specification_id`);

-- ========= regulatory --> supply (7 constraint(s)) =========
-- Requires: regulatory schema, supply schema
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label_change` ADD CONSTRAINT `fk_regulatory_label_change_product_recall_id` FOREIGN KEY (`product_recall_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`product_recall`(`product_recall_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`rems` ADD CONSTRAINT `fk_regulatory_rems_clinical_supply_order_id` FOREIGN KEY (`clinical_supply_order_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`clinical_supply_order`(`clinical_supply_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment` ADD CONSTRAINT `fk_regulatory_post_approval_commitment_clinical_supply_order_id` FOREIGN KEY (`clinical_supply_order_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`clinical_supply_order`(`clinical_supply_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`pai` ADD CONSTRAINT `fk_regulatory_pai_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`dossier_document` ADD CONSTRAINT `fk_regulatory_dossier_document_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`variation` ADD CONSTRAINT `fk_regulatory_variation_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);

-- ========= regulatory --> workforce (18 constraint(s)) =========
-- Requires: regulatory schema, workforce schema
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`application` ADD CONSTRAINT `fk_regulatory_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`submission_sequence` ADD CONSTRAINT `fk_regulatory_submission_sequence_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`milestone` ADD CONSTRAINT `fk_regulatory_milestone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`ha_interaction` ADD CONSTRAINT `fk_regulatory_ha_interaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`correspondence` ADD CONSTRAINT `fk_regulatory_correspondence_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label_change` ADD CONSTRAINT `fk_regulatory_label_change_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`rems` ADD CONSTRAINT `fk_regulatory_rems_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment` ADD CONSTRAINT `fk_regulatory_post_approval_commitment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`pai` ADD CONSTRAINT `fk_regulatory_pai_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`strategy` ADD CONSTRAINT `fk_regulatory_strategy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`dossier_document` ADD CONSTRAINT `fk_regulatory_dossier_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`designation` ADD CONSTRAINT `fk_regulatory_designation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`variation` ADD CONSTRAINT `fk_regulatory_variation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`product_registration` ADD CONSTRAINT `fk_regulatory_product_registration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`renewal` ADD CONSTRAINT `fk_regulatory_renewal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`commitment_action` ADD CONSTRAINT `fk_regulatory_commitment_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`payer_coverage` ADD CONSTRAINT `fk_regulatory_payer_coverage_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= supply --> clinical (2 constraint(s)) =========
-- Requires: supply schema, clinical schema
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`clinical_supply_order` ADD CONSTRAINT `fk_supply_clinical_supply_order_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`clinical_supply_order` ADD CONSTRAINT `fk_supply_clinical_supply_order_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`investigational_site`(`investigational_site_id`);

-- ========= supply --> commercial (8 constraint(s)) =========
-- Requires: supply schema, commercial schema
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`inventory_lot` ADD CONSTRAINT `fk_supply_inventory_lot_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`delivery_order` ADD CONSTRAINT `fk_supply_delivery_order_contract_account_id` FOREIGN KEY (`contract_account_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`contract_account`(`contract_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`delivery_order` ADD CONSTRAINT `fk_supply_delivery_order_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`clinical_supply_order` ADD CONSTRAINT `fk_supply_clinical_supply_order_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`serialization_record` ADD CONSTRAINT `fk_supply_serialization_record_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`allocation` ADD CONSTRAINT `fk_supply_allocation_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);

-- ========= supply --> compliance (8 constraint(s)) =========
-- Requires: supply schema, compliance schema
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_gxp_obligation_id` FOREIGN KEY (`gxp_obligation_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`gxp_obligation`(`gxp_obligation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`warehouse_receipt` ADD CONSTRAINT `fk_supply_warehouse_receipt_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`clinical_supply_order` ADD CONSTRAINT `fk_supply_clinical_supply_order_debarment_check_id` FOREIGN KEY (`debarment_check_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`debarment_check`(`debarment_check_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_compliance_capa_id` FOREIGN KEY (`compliance_capa_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`compliance_capa`(`compliance_capa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`serialization_record` ADD CONSTRAINT `fk_supply_serialization_record_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`incident`(`incident_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`service_agreement` ADD CONSTRAINT `fk_supply_service_agreement_program_id` FOREIGN KEY (`program_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`cold_chain_record` ADD CONSTRAINT `fk_supply_cold_chain_record_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`incident`(`incident_id`);

-- ========= supply --> discovery (5 constraint(s)) =========
-- Requires: supply schema, discovery schema
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_molecular_target_id` FOREIGN KEY (`molecular_target_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`molecular_target`(`molecular_target_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`inventory_lot` ADD CONSTRAINT `fk_supply_inventory_lot_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`clinical_supply_order` ADD CONSTRAINT `fk_supply_clinical_supply_order_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);

-- ========= supply --> finance (1 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`clinical_supply_order` ADD CONSTRAINT `fk_supply_clinical_supply_order_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);

-- ========= supply --> intellectual (10 constraint(s)) =========
-- Requires: supply schema, intellectual schema
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`inventory_lot` ADD CONSTRAINT `fk_supply_inventory_lot_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`inventory_lot` ADD CONSTRAINT `fk_supply_inventory_lot_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`clinical_supply_order` ADD CONSTRAINT `fk_supply_clinical_supply_order_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_family`(`patent_family_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`serialization_record` ADD CONSTRAINT `fk_supply_serialization_record_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);

-- ========= supply --> manufacturing (9 constraint(s)) =========
-- Requires: supply schema, manufacturing schema
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_source_site_id` FOREIGN KEY (`source_site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`serialization_record` ADD CONSTRAINT `fk_supply_serialization_record_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`serialization_record` ADD CONSTRAINT `fk_supply_serialization_record_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`service_agreement` ADD CONSTRAINT `fk_supply_service_agreement_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`lot_traceability` ADD CONSTRAINT `fk_supply_lot_traceability_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`lot_traceability` ADD CONSTRAINT `fk_supply_lot_traceability_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`allocation` ADD CONSTRAINT `fk_supply_allocation_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);

-- ========= supply --> market (4 constraint(s)) =========
-- Requires: supply schema, market schema
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_payer_account_id` FOREIGN KEY (`payer_account_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`payer_account`(`payer_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`allocation` ADD CONSTRAINT `fk_supply_allocation_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`distribution_service_agreement` ADD CONSTRAINT `fk_supply_distribution_service_agreement_payer_account_id` FOREIGN KEY (`payer_account_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`payer_account`(`payer_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`contract_fulfillment_allocation` ADD CONSTRAINT `fk_supply_contract_fulfillment_allocation_market_payer_contract_id` FOREIGN KEY (`market_payer_contract_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`market_payer_contract`(`market_payer_contract_id`);

-- ========= supply --> masterdata (26 constraint(s)) =========
-- Requires: supply schema, masterdata schema
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`storage_location`(`storage_location_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`inventory_lot` ADD CONSTRAINT `fk_supply_inventory_lot_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`inventory_lot` ADD CONSTRAINT `fk_supply_inventory_lot_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`inventory_lot` ADD CONSTRAINT `fk_supply_inventory_lot_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`storage_location`(`storage_location_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`warehouse_receipt` ADD CONSTRAINT `fk_supply_warehouse_receipt_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`warehouse_receipt` ADD CONSTRAINT `fk_supply_warehouse_receipt_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`goods_issue` ADD CONSTRAINT `fk_supply_goods_issue_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`goods_issue` ADD CONSTRAINT `fk_supply_goods_issue_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`stock_transfer_order` ADD CONSTRAINT `fk_supply_stock_transfer_order_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`stock_transfer_order` ADD CONSTRAINT `fk_supply_stock_transfer_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`delivery_order` ADD CONSTRAINT `fk_supply_delivery_order_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`delivery_order` ADD CONSTRAINT `fk_supply_delivery_order_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`delivery_order` ADD CONSTRAINT `fk_supply_delivery_order_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`storage_location`(`storage_location_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`serialization_record` ADD CONSTRAINT `fk_supply_serialization_record_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`serialization_record` ADD CONSTRAINT `fk_supply_serialization_record_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`serialization_record` ADD CONSTRAINT `fk_supply_serialization_record_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`storage_location`(`storage_location_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`service_agreement` ADD CONSTRAINT `fk_supply_service_agreement_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`lot_traceability` ADD CONSTRAINT `fk_supply_lot_traceability_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`fulfillment_event` ADD CONSTRAINT `fk_supply_fulfillment_event_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`storage_location`(`storage_location_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`allocation` ADD CONSTRAINT `fk_supply_allocation_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`cold_chain_record` ADD CONSTRAINT `fk_supply_cold_chain_record_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);

-- ========= supply --> medical (7 constraint(s)) =========
-- Requires: supply schema, medical schema
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_affairs_plan_id` FOREIGN KEY (`affairs_plan_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`affairs_plan`(`affairs_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`clinical_supply_order` ADD CONSTRAINT `fk_supply_clinical_supply_order_msl_profile_id` FOREIGN KEY (`msl_profile_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`msl_profile`(`msl_profile_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`clinical_supply_order` ADD CONSTRAINT `fk_supply_clinical_supply_order_named_patient_request_id` FOREIGN KEY (`named_patient_request_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`named_patient_request`(`named_patient_request_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_medical_advisory_board_id` FOREIGN KEY (`medical_advisory_board_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`medical_advisory_board`(`medical_advisory_board_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_medical_publication_id` FOREIGN KEY (`medical_publication_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`medical_publication`(`medical_publication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`serialization_record` ADD CONSTRAINT `fk_supply_serialization_record_named_patient_request_id` FOREIGN KEY (`named_patient_request_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`named_patient_request`(`named_patient_request_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`allocation` ADD CONSTRAINT `fk_supply_allocation_affairs_plan_id` FOREIGN KEY (`affairs_plan_id`) REFERENCES `pharmaceuticals_ecm`.`medical`.`affairs_plan`(`affairs_plan_id`);

-- ========= supply --> patient (6 constraint(s)) =========
-- Requires: supply schema, patient schema
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`clinical_supply_order` ADD CONSTRAINT `fk_supply_clinical_supply_order_patient_enrollment_id` FOREIGN KEY (`patient_enrollment_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient_enrollment`(`patient_enrollment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`serialization_record` ADD CONSTRAINT `fk_supply_serialization_record_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`serialization_record` ADD CONSTRAINT `fk_supply_serialization_record_treatment_exposure_id` FOREIGN KEY (`treatment_exposure_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`treatment_exposure`(`treatment_exposure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`drug_dispensation` ADD CONSTRAINT `fk_supply_drug_dispensation_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);

-- ========= supply --> pharmacovigilance (2 constraint(s)) =========
-- Requires: supply schema, pharmacovigilance schema
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_pv_product_id` FOREIGN KEY (`pv_product_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product`(`pv_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`lot_traceability` ADD CONSTRAINT `fk_supply_lot_traceability_pv_product_id` FOREIGN KEY (`pv_product_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product`(`pv_product_id`);

-- ========= supply --> procurement (6 constraint(s)) =========
-- Requires: supply schema, procurement schema
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_cro_cmo_engagement_id` FOREIGN KEY (`cro_cmo_engagement_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`cro_cmo_engagement`(`cro_cmo_engagement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_supply_contract_id` FOREIGN KEY (`supply_contract_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`supply_contract`(`supply_contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`inventory_lot` ADD CONSTRAINT `fk_supply_inventory_lot_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`warehouse_receipt` ADD CONSTRAINT `fk_supply_warehouse_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`delivery_order` ADD CONSTRAINT `fk_supply_delivery_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `pharmaceuticals_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= supply --> product (13 constraint(s)) =========
-- Requires: supply schema, product schema
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`inventory_lot` ADD CONSTRAINT `fk_supply_inventory_lot_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`inventory_lot` ADD CONSTRAINT `fk_supply_inventory_lot_packaging_configuration_id` FOREIGN KEY (`packaging_configuration_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`packaging_configuration`(`packaging_configuration_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`stock_transfer_order` ADD CONSTRAINT `fk_supply_stock_transfer_order_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`serialization_record` ADD CONSTRAINT `fk_supply_serialization_record_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`serialization_record` ADD CONSTRAINT `fk_supply_serialization_record_packaging_configuration_id` FOREIGN KEY (`packaging_configuration_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`packaging_configuration`(`packaging_configuration_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`lot_traceability` ADD CONSTRAINT `fk_supply_lot_traceability_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`allocation` ADD CONSTRAINT `fk_supply_allocation_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`allocation` ADD CONSTRAINT `fk_supply_allocation_packaging_configuration_id` FOREIGN KEY (`packaging_configuration_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`packaging_configuration`(`packaging_configuration_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`cold_chain_record` ADD CONSTRAINT `fk_supply_cold_chain_record_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);

-- ========= supply --> workforce (21 constraint(s)) =========
-- Requires: supply schema, workforce schema
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_department_id` FOREIGN KEY (`department_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`department`(`department_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_department_id` FOREIGN KEY (`department_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`department`(`department_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`inventory_lot` ADD CONSTRAINT `fk_supply_inventory_lot_position_id` FOREIGN KEY (`position_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`warehouse_receipt` ADD CONSTRAINT `fk_supply_warehouse_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`goods_issue` ADD CONSTRAINT `fk_supply_goods_issue_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`stock_transfer_order` ADD CONSTRAINT `fk_supply_stock_transfer_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`delivery_order` ADD CONSTRAINT `fk_supply_delivery_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`distribution_network` ADD CONSTRAINT `fk_supply_distribution_network_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`clinical_supply_order` ADD CONSTRAINT `fk_supply_clinical_supply_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_department_id` FOREIGN KEY (`department_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`department`(`department_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`serialization_record` ADD CONSTRAINT `fk_supply_serialization_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`service_agreement` ADD CONSTRAINT `fk_supply_service_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`lot_traceability` ADD CONSTRAINT `fk_supply_lot_traceability_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`fulfillment_event` ADD CONSTRAINT `fk_supply_fulfillment_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`allocation` ADD CONSTRAINT `fk_supply_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`cold_chain_record` ADD CONSTRAINT `fk_supply_cold_chain_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`drug_dispensation` ADD CONSTRAINT `fk_supply_drug_dispensation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= workforce --> compliance (1 constraint(s)) =========
-- Requires: workforce schema, compliance schema
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ADD CONSTRAINT `fk_workforce_system_access_part11_system_id` FOREIGN KEY (`part11_system_id`) REFERENCES `pharmaceuticals_ecm`.`compliance`.`part11_system`(`part11_system_id`);

-- ========= workforce --> finance (1 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ADD CONSTRAINT `fk_workforce_payslip_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= workforce --> manufacturing (5 constraint(s)) =========
-- Requires: workforce schema, manufacturing schema
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ADD CONSTRAINT `fk_workforce_training_assignment_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ADD CONSTRAINT `fk_workforce_employee_movement_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);

-- ========= workforce --> masterdata (10 constraint(s)) =========
-- Requires: workforce schema, masterdata schema
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ADD CONSTRAINT `fk_workforce_department_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ADD CONSTRAINT `fk_workforce_employee_movement_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);

-- ========= workforce --> quality (2 constraint(s)) =========
-- Requires: workforce schema, quality schema
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ADD CONSTRAINT `fk_workforce_gxp_training_record_sop_id` FOREIGN KEY (`sop_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`sop`(`sop_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ADD CONSTRAINT `fk_workforce_training_assignment_sop_id` FOREIGN KEY (`sop_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`sop`(`sop_id`);

-- ========= workforce --> supply (1 constraint(s)) =========
-- Requires: workforce schema, supply schema
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`plan`(`plan_id`);

