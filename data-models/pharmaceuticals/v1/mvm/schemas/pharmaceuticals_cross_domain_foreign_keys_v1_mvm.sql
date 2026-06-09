-- Cross-Domain Foreign Keys for Business: Pharmaceuticals | Version: v1_mvm
-- Generated on: 2026-05-05 21:11:02
-- Total cross-domain FK constraints: 1865
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: clinical, commercial, discovery, finance, hcp, intellectual, manufacturing, market, masterdata, patient, pharmacovigilance, product, quality, regulatory, supply

-- ========= clinical --> commercial (3 constraint(s)) =========
-- Requires: clinical schema, commercial schema
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`protocol` ADD CONSTRAINT `fk_clinical_protocol_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_adverse_event` ADD CONSTRAINT `fk_clinical_trial_adverse_event_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);

-- ========= clinical --> discovery (6 constraint(s)) =========
-- Requires: clinical schema, discovery schema
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_molecular_target_id` FOREIGN KEY (`molecular_target_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`molecular_target`(`molecular_target_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`protocol` ADD CONSTRAINT `fk_clinical_protocol_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_adme_profile_id` FOREIGN KEY (`adme_profile_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`adme_profile`(`adme_profile_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`biospecimen` ADD CONSTRAINT `fk_clinical_biospecimen_assay_id` FOREIGN KEY (`assay_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`assay`(`assay_id`);

-- ========= clinical --> finance (9 constraint(s)) =========
-- Requires: clinical schema, finance schema
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_royalty_agreement_id` FOREIGN KEY (`royalty_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`royalty_agreement`(`royalty_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`protocol` ADD CONSTRAINT `fk_clinical_protocol_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_site` ADD CONSTRAINT `fk_clinical_investigational_site_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_adverse_event` ADD CONSTRAINT `fk_clinical_trial_adverse_event_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_transfer_price_id` FOREIGN KEY (`transfer_price_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`transfer_price`(`transfer_price_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`biospecimen` ADD CONSTRAINT `fk_clinical_biospecimen_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);

-- ========= clinical --> hcp (8 constraint(s)) =========
-- Requires: clinical schema, hcp schema
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_site` ADD CONSTRAINT `fk_clinical_investigational_site_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`principal_investigator` ADD CONSTRAINT `fk_clinical_principal_investigator_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`contract`(`contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`principal_investigator` ADD CONSTRAINT `fk_clinical_principal_investigator_investigator_id` FOREIGN KEY (`investigator_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`investigator`(`investigator_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`principal_investigator` ADD CONSTRAINT `fk_clinical_principal_investigator_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`visit` ADD CONSTRAINT `fk_clinical_visit_investigator_id` FOREIGN KEY (`investigator_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`investigator`(`investigator_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_adverse_event` ADD CONSTRAINT `fk_clinical_trial_adverse_event_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_adverse_event` ADD CONSTRAINT `fk_clinical_trial_adverse_event_investigator_id` FOREIGN KEY (`investigator_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`investigator`(`investigator_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_consent` ADD CONSTRAINT `fk_clinical_trial_consent_investigator_id` FOREIGN KEY (`investigator_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`investigator`(`investigator_id`);

-- ========= clinical --> intellectual (10 constraint(s)) =========
-- Requires: clinical schema, intellectual schema
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_family`(`patent_family_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`protocol` ADD CONSTRAINT `fk_clinical_protocol_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`protocol` ADD CONSTRAINT `fk_clinical_protocol_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_family`(`patent_family_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_milestone` ADD CONSTRAINT `fk_clinical_trial_milestone_patent_term_extension_id` FOREIGN KEY (`patent_term_extension_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_term_extension`(`patent_term_extension_id`);

-- ========= clinical --> manufacturing (7 constraint(s)) =========
-- Requires: clinical schema, manufacturing schema
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_bill_of_materials_id` FOREIGN KEY (`bill_of_materials_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials`(`bill_of_materials_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_master_batch_record_id` FOREIGN KEY (`master_batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record`(`master_batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_process_validation_id` FOREIGN KEY (`process_validation_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`process_validation`(`process_validation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_milestone` ADD CONSTRAINT `fk_clinical_trial_milestone_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`production_order`(`production_order_id`);

-- ========= clinical --> market (4 constraint(s)) =========
-- Requires: clinical schema, market schema
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_hta_submission_id` FOREIGN KEY (`hta_submission_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`hta_submission`(`hta_submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_endpoint` ADD CONSTRAINT `fk_clinical_trial_endpoint_hta_submission_id` FOREIGN KEY (`hta_submission_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`hta_submission`(`hta_submission_id`);

-- ========= clinical --> masterdata (25 constraint(s)) =========
-- Requires: clinical schema, masterdata schema
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_site` ADD CONSTRAINT `fk_clinical_investigational_site_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_site` ADD CONSTRAINT `fk_clinical_investigational_site_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_site` ADD CONSTRAINT `fk_clinical_investigational_site_address_id` FOREIGN KEY (`address_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`address`(`address_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_site` ADD CONSTRAINT `fk_clinical_investigational_site_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_site` ADD CONSTRAINT `fk_clinical_investigational_site_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`principal_investigator` ADD CONSTRAINT `fk_clinical_principal_investigator_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`principal_investigator` ADD CONSTRAINT `fk_clinical_principal_investigator_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`subject_observation` ADD CONSTRAINT `fk_clinical_subject_observation_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`storage_location`(`storage_location_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_endpoint` ADD CONSTRAINT `fk_clinical_trial_endpoint_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`lab_result` ADD CONSTRAINT `fk_clinical_lab_result_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`lab_result` ADD CONSTRAINT `fk_clinical_lab_result_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_milestone` ADD CONSTRAINT `fk_clinical_trial_milestone_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_milestone` ADD CONSTRAINT `fk_clinical_trial_milestone_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`biospecimen` ADD CONSTRAINT `fk_clinical_biospecimen_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`storage_location`(`storage_location_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`biospecimen` ADD CONSTRAINT `fk_clinical_biospecimen_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);

-- ========= clinical --> patient (10 constraint(s)) =========
-- Requires: clinical schema, patient schema
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`clinical_enrollment` ADD CONSTRAINT `fk_clinical_clinical_enrollment_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`visit` ADD CONSTRAINT `fk_clinical_visit_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`subject_observation` ADD CONSTRAINT `fk_clinical_subject_observation_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_adverse_event` ADD CONSTRAINT `fk_clinical_trial_adverse_event_adverse_event_id` FOREIGN KEY (`adverse_event_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`adverse_event`(`adverse_event_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_adverse_event` ADD CONSTRAINT `fk_clinical_trial_adverse_event_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_consent` ADD CONSTRAINT `fk_clinical_trial_consent_informed_consent_id` FOREIGN KEY (`informed_consent_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`informed_consent`(`informed_consent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_consent` ADD CONSTRAINT `fk_clinical_trial_consent_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_endpoint` ADD CONSTRAINT `fk_clinical_trial_endpoint_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`lab_result` ADD CONSTRAINT `fk_clinical_lab_result_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`biospecimen` ADD CONSTRAINT `fk_clinical_biospecimen_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);

-- ========= clinical --> pharmacovigilance (4 constraint(s)) =========
-- Requires: clinical schema, pharmacovigilance schema
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`principal_investigator` ADD CONSTRAINT `fk_clinical_principal_investigator_reporter_id` FOREIGN KEY (`reporter_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`reporter`(`reporter_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_adverse_event` ADD CONSTRAINT `fk_clinical_trial_adverse_event_icsr_id` FOREIGN KEY (`icsr_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr`(`icsr_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_adverse_event` ADD CONSTRAINT `fk_clinical_trial_adverse_event_pv_adverse_reaction_id` FOREIGN KEY (`pv_adverse_reaction_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_adverse_reaction`(`pv_adverse_reaction_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_pv_product_id` FOREIGN KEY (`pv_product_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product`(`pv_product_id`);

-- ========= clinical --> product (20 constraint(s)) =========
-- Requires: clinical schema, product schema
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`protocol` ADD CONSTRAINT `fk_clinical_protocol_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`protocol` ADD CONSTRAINT `fk_clinical_protocol_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`protocol` ADD CONSTRAINT `fk_clinical_protocol_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`principal_investigator` ADD CONSTRAINT `fk_clinical_principal_investigator_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`clinical_enrollment` ADD CONSTRAINT `fk_clinical_clinical_enrollment_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_adverse_event` ADD CONSTRAINT `fk_clinical_trial_adverse_event_labeling_id` FOREIGN KEY (`labeling_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`labeling`(`labeling_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_adverse_event` ADD CONSTRAINT `fk_clinical_trial_adverse_event_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_labeling_id` FOREIGN KEY (`labeling_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`labeling`(`labeling_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_packaging_configuration_id` FOREIGN KEY (`packaging_configuration_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`packaging_configuration`(`packaging_configuration_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_endpoint` ADD CONSTRAINT `fk_clinical_trial_endpoint_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`lab_result` ADD CONSTRAINT `fk_clinical_lab_result_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_milestone` ADD CONSTRAINT `fk_clinical_trial_milestone_lifecycle_id` FOREIGN KEY (`lifecycle_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`lifecycle`(`lifecycle_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`biospecimen` ADD CONSTRAINT `fk_clinical_biospecimen_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);

-- ========= clinical --> quality (7 constraint(s)) =========
-- Requires: clinical schema, quality schema
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`protocol` ADD CONSTRAINT `fk_clinical_protocol_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`subject_observation` ADD CONSTRAINT `fk_clinical_subject_observation_quality_deviation_id` FOREIGN KEY (`quality_deviation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_deviation`(`quality_deviation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_adverse_event` ADD CONSTRAINT `fk_clinical_trial_adverse_event_complaint_id` FOREIGN KEY (`complaint_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`complaint`(`complaint_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_stability_study_id` FOREIGN KEY (`stability_study_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`stability_study`(`stability_study_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`lab_result` ADD CONSTRAINT `fk_clinical_lab_result_method_validation_id` FOREIGN KEY (`method_validation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`method_validation`(`method_validation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_milestone` ADD CONSTRAINT `fk_clinical_trial_milestone_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`capa`(`capa_id`);

-- ========= clinical --> regulatory (19 constraint(s)) =========
-- Requires: clinical schema, regulatory schema
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_designation_id` FOREIGN KEY (`designation_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`designation`(`designation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_post_approval_commitment_id` FOREIGN KEY (`post_approval_commitment_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment`(`post_approval_commitment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_application_id` FOREIGN KEY (`application_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`application`(`application_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`strategy`(`strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`protocol` ADD CONSTRAINT `fk_clinical_protocol_post_approval_commitment_id` FOREIGN KEY (`post_approval_commitment_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment`(`post_approval_commitment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`protocol` ADD CONSTRAINT `fk_clinical_protocol_application_id` FOREIGN KEY (`application_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`application`(`application_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`protocol` ADD CONSTRAINT `fk_clinical_protocol_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_site` ADD CONSTRAINT `fk_clinical_investigational_site_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`principal_investigator` ADD CONSTRAINT `fk_clinical_principal_investigator_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`clinical_enrollment` ADD CONSTRAINT `fk_clinical_clinical_enrollment_rems_id` FOREIGN KEY (`rems_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`rems`(`rems_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_adverse_event` ADD CONSTRAINT `fk_clinical_trial_adverse_event_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_consent` ADD CONSTRAINT `fk_clinical_trial_consent_rems_id` FOREIGN KEY (`rems_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`rems`(`rems_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_dmf_id` FOREIGN KEY (`dmf_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`dmf`(`dmf_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_rems_id` FOREIGN KEY (`rems_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`rems`(`rems_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_milestone` ADD CONSTRAINT `fk_clinical_trial_milestone_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_milestone` ADD CONSTRAINT `fk_clinical_trial_milestone_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`biospecimen` ADD CONSTRAINT `fk_clinical_biospecimen_dmf_id` FOREIGN KEY (`dmf_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`dmf`(`dmf_id`);

-- ========= clinical --> supply (10 constraint(s)) =========
-- Requires: clinical schema, supply schema
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial` ADD CONSTRAINT `fk_clinical_trial_demand_plan_id` FOREIGN KEY (`demand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`demand_plan`(`demand_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_site` ADD CONSTRAINT `fk_clinical_investigational_site_distribution_network_id` FOREIGN KEY (`distribution_network_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`distribution_network`(`distribution_network_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`clinical_enrollment` ADD CONSTRAINT `fk_clinical_clinical_enrollment_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`visit` ADD CONSTRAINT `fk_clinical_visit_clinical_supply_order_id` FOREIGN KEY (`clinical_supply_order_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`clinical_supply_order`(`clinical_supply_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_adverse_event` ADD CONSTRAINT `fk_clinical_trial_adverse_event_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`plan`(`plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`investigational_product` ADD CONSTRAINT `fk_clinical_investigational_product_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`trial_milestone` ADD CONSTRAINT `fk_clinical_trial_milestone_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`plan`(`plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`biospecimen` ADD CONSTRAINT `fk_clinical_biospecimen_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`clinical`.`biospecimen` ADD CONSTRAINT `fk_clinical_biospecimen_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`shipment`(`shipment_id`);

-- ========= commercial --> clinical (9 constraint(s)) =========
-- Requires: commercial schema, clinical schema
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ADD CONSTRAINT `fk_commercial_hcp_target_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ADD CONSTRAINT `fk_commercial_hcp_target_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ADD CONSTRAINT `fk_commercial_call_activity_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ADD CONSTRAINT `fk_commercial_promo_material_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ADD CONSTRAINT `fk_commercial_mlr_review_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ADD CONSTRAINT `fk_commercial_patient_support_program_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ADD CONSTRAINT `fk_commercial_psp_enrollment_clinical_enrollment_id` FOREIGN KEY (`clinical_enrollment_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`clinical_enrollment`(`clinical_enrollment_id`);

-- ========= commercial --> discovery (6 constraint(s)) =========
-- Requires: commercial schema, discovery schema
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_molecular_target_id` FOREIGN KEY (`molecular_target_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`molecular_target`(`molecular_target_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_molecular_target_id` FOREIGN KEY (`molecular_target_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`molecular_target`(`molecular_target_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_candidate_nomination_id` FOREIGN KEY (`candidate_nomination_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`candidate_nomination`(`candidate_nomination_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_molecular_target_id` FOREIGN KEY (`molecular_target_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`molecular_target`(`molecular_target_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);

-- ========= commercial --> finance (28 constraint(s)) =========
-- Requires: commercial schema, finance schema
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_transfer_price_id` FOREIGN KEY (`transfer_price_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`transfer_price`(`transfer_price_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ADD CONSTRAINT `fk_commercial_territory_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ADD CONSTRAINT `fk_commercial_sales_rep_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ADD CONSTRAINT `fk_commercial_sales_rep_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ADD CONSTRAINT `fk_commercial_call_activity_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ADD CONSTRAINT `fk_commercial_sample_management_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ADD CONSTRAINT `fk_commercial_promo_material_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ADD CONSTRAINT `fk_commercial_mlr_review_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_royalty_agreement_id` FOREIGN KEY (`royalty_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`royalty_agreement`(`royalty_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_transfer_price_id` FOREIGN KEY (`transfer_price_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`transfer_price`(`transfer_price_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`invoice`(`invoice_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ADD CONSTRAINT `fk_commercial_patient_support_program_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ADD CONSTRAINT `fk_commercial_patient_support_program_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ADD CONSTRAINT `fk_commercial_psp_enrollment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`invoice`(`invoice_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ADD CONSTRAINT `fk_commercial_contract_account_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ADD CONSTRAINT `fk_commercial_sales_performance_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ADD CONSTRAINT `fk_commercial_sales_performance_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ADD CONSTRAINT `fk_commercial_copay_program_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ADD CONSTRAINT `fk_commercial_copay_program_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ADD CONSTRAINT `fk_commercial_copay_program_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ADD CONSTRAINT `fk_commercial_copay_redemption_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ADD CONSTRAINT `fk_commercial_copay_redemption_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ADD CONSTRAINT `fk_commercial_copay_redemption_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ADD CONSTRAINT `fk_commercial_copay_redemption_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= commercial --> hcp (16 constraint(s)) =========
-- Requires: commercial schema, hcp schema
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ADD CONSTRAINT `fk_commercial_hcp_target_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ADD CONSTRAINT `fk_commercial_call_activity_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`consent_record`(`consent_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ADD CONSTRAINT `fk_commercial_call_activity_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ADD CONSTRAINT `fk_commercial_call_activity_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ADD CONSTRAINT `fk_commercial_sample_management_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`consent_record`(`consent_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ADD CONSTRAINT `fk_commercial_sample_management_license_id` FOREIGN KEY (`license_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`license`(`license_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ADD CONSTRAINT `fk_commercial_sample_management_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`contract`(`contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_kol_profile_id` FOREIGN KEY (`kol_profile_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`kol_profile`(`kol_profile_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ADD CONSTRAINT `fk_commercial_psp_enrollment_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ADD CONSTRAINT `fk_commercial_psp_enrollment_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ADD CONSTRAINT `fk_commercial_contract_account_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ADD CONSTRAINT `fk_commercial_copay_redemption_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);

-- ========= commercial --> intellectual (28 constraint(s)) =========
-- Requires: commercial schema, intellectual schema
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_fto_analysis_id` FOREIGN KEY (`fto_analysis_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`fto_analysis`(`fto_analysis_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_family`(`patent_family_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_trademark_id` FOREIGN KEY (`trademark_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`trademark`(`trademark_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ADD CONSTRAINT `fk_commercial_territory_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ADD CONSTRAINT `fk_commercial_territory_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ADD CONSTRAINT `fk_commercial_promo_material_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ADD CONSTRAINT `fk_commercial_promo_material_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ADD CONSTRAINT `fk_commercial_promo_material_trademark_id` FOREIGN KEY (`trademark_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`trademark`(`trademark_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ADD CONSTRAINT `fk_commercial_mlr_review_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ADD CONSTRAINT `fk_commercial_mlr_review_trademark_id` FOREIGN KEY (`trademark_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`trademark`(`trademark_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_family`(`patent_family_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_trademark_id` FOREIGN KEY (`trademark_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`trademark`(`trademark_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_family`(`patent_family_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ADD CONSTRAINT `fk_commercial_patient_support_program_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ADD CONSTRAINT `fk_commercial_patient_support_program_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ADD CONSTRAINT `fk_commercial_psp_enrollment_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ADD CONSTRAINT `fk_commercial_contract_account_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ADD CONSTRAINT `fk_commercial_contract_account_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ADD CONSTRAINT `fk_commercial_sales_performance_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ADD CONSTRAINT `fk_commercial_sales_performance_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ADD CONSTRAINT `fk_commercial_copay_program_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);

-- ========= commercial --> manufacturing (1 constraint(s)) =========
-- Requires: commercial schema, manufacturing schema
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ADD CONSTRAINT `fk_commercial_sample_management_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);

-- ========= commercial --> market (20 constraint(s)) =========
-- Requires: commercial schema, market schema
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ADD CONSTRAINT `fk_commercial_hcp_target_formulary_position_id` FOREIGN KEY (`formulary_position_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`formulary_position`(`formulary_position_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ADD CONSTRAINT `fk_commercial_sample_management_formulary_position_id` FOREIGN KEY (`formulary_position_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`formulary_position`(`formulary_position_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_pricing_decision_id` FOREIGN KEY (`pricing_decision_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`pricing_decision`(`pricing_decision_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`reimbursement_policy`(`reimbursement_policy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_value_dossier_id` FOREIGN KEY (`value_dossier_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`value_dossier`(`value_dossier_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_payer_engagement_id` FOREIGN KEY (`payer_engagement_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`payer_engagement`(`payer_engagement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ADD CONSTRAINT `fk_commercial_patient_support_program_patient_access_program_id` FOREIGN KEY (`patient_access_program_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`patient_access_program`(`patient_access_program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ADD CONSTRAINT `fk_commercial_patient_support_program_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`reimbursement_policy`(`reimbursement_policy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ADD CONSTRAINT `fk_commercial_psp_enrollment_patient_access_program_id` FOREIGN KEY (`patient_access_program_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`patient_access_program`(`patient_access_program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ADD CONSTRAINT `fk_commercial_contract_account_payer_account_id` FOREIGN KEY (`payer_account_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`payer_account`(`payer_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ADD CONSTRAINT `fk_commercial_contract_account_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ADD CONSTRAINT `fk_commercial_sales_performance_formulary_position_id` FOREIGN KEY (`formulary_position_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`formulary_position`(`formulary_position_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ADD CONSTRAINT `fk_commercial_sales_performance_payer_account_id` FOREIGN KEY (`payer_account_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`payer_account`(`payer_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ADD CONSTRAINT `fk_commercial_sales_performance_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`reimbursement_policy`(`reimbursement_policy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ADD CONSTRAINT `fk_commercial_copay_program_patient_access_program_id` FOREIGN KEY (`patient_access_program_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`patient_access_program`(`patient_access_program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ADD CONSTRAINT `fk_commercial_copay_program_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`reimbursement_policy`(`reimbursement_policy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ADD CONSTRAINT `fk_commercial_copay_redemption_gross_to_net_adjustment_id` FOREIGN KEY (`gross_to_net_adjustment_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment`(`gross_to_net_adjustment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_pricing_decision_id` FOREIGN KEY (`pricing_decision_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`pricing_decision`(`pricing_decision_id`);

-- ========= commercial --> masterdata (54 constraint(s)) =========
-- Requires: commercial schema, masterdata schema
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_masterdata_ndc_code_id` FOREIGN KEY (`masterdata_ndc_code_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code`(`masterdata_ndc_code_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ADD CONSTRAINT `fk_commercial_territory_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ADD CONSTRAINT `fk_commercial_territory_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ADD CONSTRAINT `fk_commercial_territory_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ADD CONSTRAINT `fk_commercial_territory_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ADD CONSTRAINT `fk_commercial_sales_rep_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ADD CONSTRAINT `fk_commercial_sales_rep_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ADD CONSTRAINT `fk_commercial_sales_rep_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ADD CONSTRAINT `fk_commercial_sales_rep_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ADD CONSTRAINT `fk_commercial_sample_management_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ADD CONSTRAINT `fk_commercial_sample_management_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`storage_location`(`storage_location_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ADD CONSTRAINT `fk_commercial_promo_material_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ADD CONSTRAINT `fk_commercial_promo_material_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ADD CONSTRAINT `fk_commercial_mlr_review_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ADD CONSTRAINT `fk_commercial_mlr_review_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ADD CONSTRAINT `fk_commercial_patient_support_program_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ADD CONSTRAINT `fk_commercial_patient_support_program_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ADD CONSTRAINT `fk_commercial_patient_support_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ADD CONSTRAINT `fk_commercial_patient_support_program_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ADD CONSTRAINT `fk_commercial_patient_support_program_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ADD CONSTRAINT `fk_commercial_psp_enrollment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ADD CONSTRAINT `fk_commercial_psp_enrollment_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ADD CONSTRAINT `fk_commercial_psp_enrollment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ADD CONSTRAINT `fk_commercial_contract_account_address_id` FOREIGN KEY (`address_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`address`(`address_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ADD CONSTRAINT `fk_commercial_contract_account_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ADD CONSTRAINT `fk_commercial_contract_account_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ADD CONSTRAINT `fk_commercial_contract_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ADD CONSTRAINT `fk_commercial_contract_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ADD CONSTRAINT `fk_commercial_sales_performance_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ADD CONSTRAINT `fk_commercial_sales_performance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ADD CONSTRAINT `fk_commercial_sales_performance_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ADD CONSTRAINT `fk_commercial_sales_performance_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ADD CONSTRAINT `fk_commercial_copay_program_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ADD CONSTRAINT `fk_commercial_copay_program_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ADD CONSTRAINT `fk_commercial_copay_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ADD CONSTRAINT `fk_commercial_copay_program_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ADD CONSTRAINT `fk_commercial_copay_program_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ADD CONSTRAINT `fk_commercial_copay_redemption_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ADD CONSTRAINT `fk_commercial_copay_redemption_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ADD CONSTRAINT `fk_commercial_copay_redemption_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ADD CONSTRAINT `fk_commercial_copay_redemption_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`address`(`address_id`);

-- ========= commercial --> patient (3 constraint(s)) =========
-- Requires: commercial schema, patient schema
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ADD CONSTRAINT `fk_commercial_psp_enrollment_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ADD CONSTRAINT `fk_commercial_copay_redemption_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_patient_enrollment_id` FOREIGN KEY (`patient_enrollment_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient_enrollment`(`patient_enrollment_id`);

-- ========= commercial --> product (44 constraint(s)) =========
-- Requires: commercial schema, product schema
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_lifecycle_id` FOREIGN KEY (`lifecycle_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`lifecycle`(`lifecycle_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ADD CONSTRAINT `fk_commercial_brand_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ADD CONSTRAINT `fk_commercial_territory_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ADD CONSTRAINT `fk_commercial_sales_rep_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ADD CONSTRAINT `fk_commercial_hcp_target_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ADD CONSTRAINT `fk_commercial_hcp_target_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ADD CONSTRAINT `fk_commercial_call_activity_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ADD CONSTRAINT `fk_commercial_call_activity_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ADD CONSTRAINT `fk_commercial_sample_management_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ADD CONSTRAINT `fk_commercial_sample_management_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ADD CONSTRAINT `fk_commercial_sample_management_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ADD CONSTRAINT `fk_commercial_promo_material_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ADD CONSTRAINT `fk_commercial_promo_material_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ADD CONSTRAINT `fk_commercial_promo_material_labeling_id` FOREIGN KEY (`labeling_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`labeling`(`labeling_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ADD CONSTRAINT `fk_commercial_promo_material_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ADD CONSTRAINT `fk_commercial_mlr_review_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ADD CONSTRAINT `fk_commercial_mlr_review_labeling_id` FOREIGN KEY (`labeling_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`labeling`(`labeling_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ADD CONSTRAINT `fk_commercial_mlr_review_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ADD CONSTRAINT `fk_commercial_patient_support_program_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ADD CONSTRAINT `fk_commercial_patient_support_program_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ADD CONSTRAINT `fk_commercial_patient_support_program_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ADD CONSTRAINT `fk_commercial_patient_support_program_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ADD CONSTRAINT `fk_commercial_psp_enrollment_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ADD CONSTRAINT `fk_commercial_sales_performance_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ADD CONSTRAINT `fk_commercial_sales_performance_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ADD CONSTRAINT `fk_commercial_copay_program_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ADD CONSTRAINT `fk_commercial_copay_program_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ADD CONSTRAINT `fk_commercial_copay_program_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ADD CONSTRAINT `fk_commercial_copay_program_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ADD CONSTRAINT `fk_commercial_copay_redemption_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ADD CONSTRAINT `fk_commercial_copay_redemption_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ADD CONSTRAINT `fk_commercial_copay_redemption_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);

-- ========= commercial --> quality (1 constraint(s)) =========
-- Requires: commercial schema, quality schema
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ADD CONSTRAINT `fk_commercial_mlr_review_change_control_id` FOREIGN KEY (`change_control_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`change_control`(`change_control_id`);

-- ========= discovery --> finance (8 constraint(s)) =========
-- Requires: discovery schema, finance schema
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`hts_campaign` ADD CONSTRAINT `fk_discovery_hts_campaign_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`sar_study` ADD CONSTRAINT `fk_discovery_sar_study_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`lead_series` ADD CONSTRAINT `fk_discovery_lead_series_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound_synthesis` ADD CONSTRAINT `fk_discovery_compound_synthesis_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`project` ADD CONSTRAINT `fk_discovery_project_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`project` ADD CONSTRAINT `fk_discovery_project_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`candidate_nomination` ADD CONSTRAINT `fk_discovery_candidate_nomination_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`candidate_nomination` ADD CONSTRAINT `fk_discovery_candidate_nomination_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);

-- ========= discovery --> intellectual (28 constraint(s)) =========
-- Requires: discovery schema, intellectual schema
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`molecular_target` ADD CONSTRAINT `fk_discovery_molecular_target_fto_analysis_id` FOREIGN KEY (`fto_analysis_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`fto_analysis`(`fto_analysis_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`molecular_target` ADD CONSTRAINT `fk_discovery_molecular_target_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_family`(`patent_family_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`molecular_target` ADD CONSTRAINT `fk_discovery_molecular_target_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`molecular_target` ADD CONSTRAINT `fk_discovery_molecular_target_patent_claim_id` FOREIGN KEY (`patent_claim_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_claim`(`patent_claim_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound` ADD CONSTRAINT `fk_discovery_compound_drug_master_file_id` FOREIGN KEY (`drug_master_file_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`drug_master_file`(`drug_master_file_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound` ADD CONSTRAINT `fk_discovery_compound_fto_analysis_id` FOREIGN KEY (`fto_analysis_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`fto_analysis`(`fto_analysis_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound` ADD CONSTRAINT `fk_discovery_compound_patent_claim_id` FOREIGN KEY (`patent_claim_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_claim`(`patent_claim_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound` ADD CONSTRAINT `fk_discovery_compound_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_family`(`patent_family_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound` ADD CONSTRAINT `fk_discovery_compound_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`assay` ADD CONSTRAINT `fk_discovery_assay_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`assay` ADD CONSTRAINT `fk_discovery_assay_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`sar_study` ADD CONSTRAINT `fk_discovery_sar_study_fto_analysis_id` FOREIGN KEY (`fto_analysis_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`fto_analysis`(`fto_analysis_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`sar_study` ADD CONSTRAINT `fk_discovery_sar_study_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_family`(`patent_family_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`lead_series` ADD CONSTRAINT `fk_discovery_lead_series_fto_analysis_id` FOREIGN KEY (`fto_analysis_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`fto_analysis`(`fto_analysis_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`lead_series` ADD CONSTRAINT `fk_discovery_lead_series_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`lead_series` ADD CONSTRAINT `fk_discovery_lead_series_patent_claim_id` FOREIGN KEY (`patent_claim_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_claim`(`patent_claim_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`lead_series` ADD CONSTRAINT `fk_discovery_lead_series_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_family`(`patent_family_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound_synthesis` ADD CONSTRAINT `fk_discovery_compound_synthesis_fto_analysis_id` FOREIGN KEY (`fto_analysis_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`fto_analysis`(`fto_analysis_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound_synthesis` ADD CONSTRAINT `fk_discovery_compound_synthesis_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_family`(`patent_family_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound_synthesis` ADD CONSTRAINT `fk_discovery_compound_synthesis_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`project` ADD CONSTRAINT `fk_discovery_project_fto_analysis_id` FOREIGN KEY (`fto_analysis_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`fto_analysis`(`fto_analysis_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`project` ADD CONSTRAINT `fk_discovery_project_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`candidate_nomination` ADD CONSTRAINT `fk_discovery_candidate_nomination_drug_master_file_id` FOREIGN KEY (`drug_master_file_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`drug_master_file`(`drug_master_file_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`candidate_nomination` ADD CONSTRAINT `fk_discovery_candidate_nomination_fto_analysis_id` FOREIGN KEY (`fto_analysis_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`fto_analysis`(`fto_analysis_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`candidate_nomination` ADD CONSTRAINT `fk_discovery_candidate_nomination_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`candidate_nomination` ADD CONSTRAINT `fk_discovery_candidate_nomination_patent_claim_id` FOREIGN KEY (`patent_claim_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_claim`(`patent_claim_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`candidate_nomination` ADD CONSTRAINT `fk_discovery_candidate_nomination_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_family`(`patent_family_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`candidate_nomination` ADD CONSTRAINT `fk_discovery_candidate_nomination_trademark_id` FOREIGN KEY (`trademark_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`trademark`(`trademark_id`);

-- ========= discovery --> manufacturing (3 constraint(s)) =========
-- Requires: discovery schema, manufacturing schema
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound_synthesis` ADD CONSTRAINT `fk_discovery_compound_synthesis_master_batch_record_id` FOREIGN KEY (`master_batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record`(`master_batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound_synthesis` ADD CONSTRAINT `fk_discovery_compound_synthesis_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`candidate_nomination` ADD CONSTRAINT `fk_discovery_candidate_nomination_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);

-- ========= discovery --> masterdata (18 constraint(s)) =========
-- Requires: discovery schema, masterdata schema
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`molecular_target` ADD CONSTRAINT `fk_discovery_molecular_target_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound` ADD CONSTRAINT `fk_discovery_compound_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound` ADD CONSTRAINT `fk_discovery_compound_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound` ADD CONSTRAINT `fk_discovery_compound_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound` ADD CONSTRAINT `fk_discovery_compound_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`assay` ADD CONSTRAINT `fk_discovery_assay_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`assay` ADD CONSTRAINT `fk_discovery_assay_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`assay` ADD CONSTRAINT `fk_discovery_assay_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`hts_campaign` ADD CONSTRAINT `fk_discovery_hts_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`hts_campaign` ADD CONSTRAINT `fk_discovery_hts_campaign_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`hts_campaign` ADD CONSTRAINT `fk_discovery_hts_campaign_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound_synthesis` ADD CONSTRAINT `fk_discovery_compound_synthesis_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound_synthesis` ADD CONSTRAINT `fk_discovery_compound_synthesis_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`storage_location`(`storage_location_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound_synthesis` ADD CONSTRAINT `fk_discovery_compound_synthesis_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound_synthesis` ADD CONSTRAINT `fk_discovery_compound_synthesis_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`adme_profile` ADD CONSTRAINT `fk_discovery_adme_profile_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`project` ADD CONSTRAINT `fk_discovery_project_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`candidate_nomination` ADD CONSTRAINT `fk_discovery_candidate_nomination_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);

-- ========= discovery --> product (19 constraint(s)) =========
-- Requires: discovery schema, product schema
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`molecular_target` ADD CONSTRAINT `fk_discovery_molecular_target_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`molecular_target` ADD CONSTRAINT `fk_discovery_molecular_target_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound` ADD CONSTRAINT `fk_discovery_compound_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`compound` ADD CONSTRAINT `fk_discovery_compound_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`assay` ADD CONSTRAINT `fk_discovery_assay_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`hts_campaign` ADD CONSTRAINT `fk_discovery_hts_campaign_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`sar_study` ADD CONSTRAINT `fk_discovery_sar_study_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`sar_study` ADD CONSTRAINT `fk_discovery_sar_study_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`lead_series` ADD CONSTRAINT `fk_discovery_lead_series_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`lead_series` ADD CONSTRAINT `fk_discovery_lead_series_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`adme_profile` ADD CONSTRAINT `fk_discovery_adme_profile_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`project` ADD CONSTRAINT `fk_discovery_project_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`project` ADD CONSTRAINT `fk_discovery_project_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`project` ADD CONSTRAINT `fk_discovery_project_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`project` ADD CONSTRAINT `fk_discovery_project_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`candidate_nomination` ADD CONSTRAINT `fk_discovery_candidate_nomination_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`candidate_nomination` ADD CONSTRAINT `fk_discovery_candidate_nomination_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`candidate_nomination` ADD CONSTRAINT `fk_discovery_candidate_nomination_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`candidate_nomination` ADD CONSTRAINT `fk_discovery_candidate_nomination_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);

-- ========= discovery --> quality (2 constraint(s)) =========
-- Requires: discovery schema, quality schema
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`adme_profile` ADD CONSTRAINT `fk_discovery_adme_profile_method_validation_id` FOREIGN KEY (`method_validation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`method_validation`(`method_validation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`candidate_nomination` ADD CONSTRAINT `fk_discovery_candidate_nomination_validation_id` FOREIGN KEY (`validation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`validation`(`validation_id`);

-- ========= discovery --> regulatory (1 constraint(s)) =========
-- Requires: discovery schema, regulatory schema
ALTER TABLE `pharmaceuticals_ecm`.`discovery`.`project` ADD CONSTRAINT `fk_discovery_project_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`strategy`(`strategy_id`);

-- ========= finance --> commercial (1 constraint(s)) =========
-- Requires: finance schema, commercial schema
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`sales_order`(`sales_order_id`);

-- ========= finance --> discovery (2 constraint(s)) =========
-- Requires: finance schema, discovery schema
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ADD CONSTRAINT `fk_finance_royalty_agreement_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ADD CONSTRAINT `fk_finance_milestone_payment_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);

-- ========= finance --> hcp (1 constraint(s)) =========
-- Requires: finance schema, hcp schema
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`contract`(`contract_id`);

-- ========= finance --> intellectual (2 constraint(s)) =========
-- Requires: finance schema, intellectual schema
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ADD CONSTRAINT `fk_finance_royalty_agreement_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ADD CONSTRAINT `fk_finance_milestone_payment_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);

-- ========= finance --> manufacturing (1 constraint(s)) =========
-- Requires: finance schema, manufacturing schema
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ADD CONSTRAINT `fk_finance_transfer_price_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);

-- ========= finance --> masterdata (50 constraint(s)) =========
-- Requires: finance schema, masterdata schema
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_masterdata_ndc_code_id` FOREIGN KEY (`masterdata_ndc_code_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code`(`masterdata_ndc_code_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`storage_location`(`storage_location_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ADD CONSTRAINT `fk_finance_royalty_agreement_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ADD CONSTRAINT `fk_finance_royalty_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ADD CONSTRAINT `fk_finance_royalty_agreement_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ADD CONSTRAINT `fk_finance_milestone_payment_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ADD CONSTRAINT `fk_finance_milestone_payment_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ADD CONSTRAINT `fk_finance_milestone_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ADD CONSTRAINT `fk_finance_milestone_payment_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ADD CONSTRAINT `fk_finance_milestone_payment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ADD CONSTRAINT `fk_finance_transfer_price_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ADD CONSTRAINT `fk_finance_transfer_price_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ADD CONSTRAINT `fk_finance_transfer_price_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ADD CONSTRAINT `fk_finance_transfer_price_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_address_id` FOREIGN KEY (`address_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`address`(`address_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_address_id` FOREIGN KEY (`address_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`address`(`address_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_invoice_ship_to_address_id` FOREIGN KEY (`invoice_ship_to_address_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`address`(`address_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);

-- ========= finance --> product (10 constraint(s)) =========
-- Requires: finance schema, product schema
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`royalty_agreement` ADD CONSTRAINT `fk_finance_royalty_agreement_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`milestone_payment` ADD CONSTRAINT `fk_finance_milestone_payment_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ADD CONSTRAINT `fk_finance_transfer_price_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`transfer_price` ADD CONSTRAINT `fk_finance_transfer_price_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);

-- ========= finance --> supply (1 constraint(s)) =========
-- Requires: finance schema, supply schema
ALTER TABLE `pharmaceuticals_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_warehouse_receipt_id` FOREIGN KEY (`warehouse_receipt_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`warehouse_receipt`(`warehouse_receipt_id`);

-- ========= hcp --> clinical (5 constraint(s)) =========
-- Requires: hcp schema, clinical schema
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ADD CONSTRAINT `fk_hcp_affiliation_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ADD CONSTRAINT `fk_hcp_engagement_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ADD CONSTRAINT `fk_hcp_sunshine_transfer_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ADD CONSTRAINT `fk_hcp_contract_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ADD CONSTRAINT `fk_hcp_contract_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);

-- ========= hcp --> commercial (7 constraint(s)) =========
-- Requires: hcp schema, commercial schema
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ADD CONSTRAINT `fk_hcp_engagement_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ADD CONSTRAINT `fk_hcp_engagement_sales_rep_id` FOREIGN KEY (`sales_rep_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`sales_rep`(`sales_rep_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ADD CONSTRAINT `fk_hcp_engagement_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ADD CONSTRAINT `fk_hcp_sample_request_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ADD CONSTRAINT `fk_hcp_sample_request_sales_rep_id` FOREIGN KEY (`sales_rep_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`sales_rep`(`sales_rep_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ADD CONSTRAINT `fk_hcp_speaker_program_brand_plan_id` FOREIGN KEY (`brand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand_plan`(`brand_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ADD CONSTRAINT `fk_hcp_contract_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);

-- ========= hcp --> discovery (4 constraint(s)) =========
-- Requires: hcp schema, discovery schema
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ADD CONSTRAINT `fk_hcp_kol_profile_molecular_target_id` FOREIGN KEY (`molecular_target_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`molecular_target`(`molecular_target_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ADD CONSTRAINT `fk_hcp_engagement_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ADD CONSTRAINT `fk_hcp_engagement_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ADD CONSTRAINT `fk_hcp_speaker_program_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);

-- ========= hcp --> finance (14 constraint(s)) =========
-- Requires: hcp schema, finance schema
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ADD CONSTRAINT `fk_hcp_engagement_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ADD CONSTRAINT `fk_hcp_engagement_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ADD CONSTRAINT `fk_hcp_sample_request_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ADD CONSTRAINT `fk_hcp_sunshine_transfer_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ADD CONSTRAINT `fk_hcp_sunshine_transfer_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ADD CONSTRAINT `fk_hcp_sunshine_transfer_payment_run_id` FOREIGN KEY (`payment_run_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ADD CONSTRAINT `fk_hcp_speaker_program_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ADD CONSTRAINT `fk_hcp_speaker_program_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ADD CONSTRAINT `fk_hcp_speaker_program_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ADD CONSTRAINT `fk_hcp_speaker_program_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`invoice`(`invoice_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ADD CONSTRAINT `fk_hcp_contract_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ADD CONSTRAINT `fk_hcp_contract_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ADD CONSTRAINT `fk_hcp_contract_payment_run_id` FOREIGN KEY (`payment_run_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ADD CONSTRAINT `fk_hcp_investigator_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);

-- ========= hcp --> intellectual (9 constraint(s)) =========
-- Requires: hcp schema, intellectual schema
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ADD CONSTRAINT `fk_hcp_kol_profile_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_family`(`patent_family_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ADD CONSTRAINT `fk_hcp_sunshine_transfer_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ADD CONSTRAINT `fk_hcp_sunshine_transfer_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ADD CONSTRAINT `fk_hcp_speaker_program_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ADD CONSTRAINT `fk_hcp_speaker_program_trademark_id` FOREIGN KEY (`trademark_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`trademark`(`trademark_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ADD CONSTRAINT `fk_hcp_contract_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ADD CONSTRAINT `fk_hcp_contract_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ADD CONSTRAINT `fk_hcp_contract_trademark_id` FOREIGN KEY (`trademark_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`trademark`(`trademark_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ADD CONSTRAINT `fk_hcp_investigator_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);

-- ========= hcp --> market (2 constraint(s)) =========
-- Requires: hcp schema, market schema
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ADD CONSTRAINT `fk_hcp_engagement_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ADD CONSTRAINT `fk_hcp_speaker_program_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);

-- ========= hcp --> masterdata (19 constraint(s)) =========
-- Requires: hcp schema, masterdata schema
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`master` ADD CONSTRAINT `fk_hcp_master_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ADD CONSTRAINT `fk_hcp_hco_master_address_id` FOREIGN KEY (`address_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`address`(`address_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ADD CONSTRAINT `fk_hcp_hco_master_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`license` ADD CONSTRAINT `fk_hcp_license_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`affiliation` ADD CONSTRAINT `fk_hcp_affiliation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ADD CONSTRAINT `fk_hcp_engagement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ADD CONSTRAINT `fk_hcp_engagement_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ADD CONSTRAINT `fk_hcp_sample_request_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ADD CONSTRAINT `fk_hcp_sample_request_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ADD CONSTRAINT `fk_hcp_sample_request_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`storage_location`(`storage_location_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`consent_record` ADD CONSTRAINT `fk_hcp_consent_record_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ADD CONSTRAINT `fk_hcp_sunshine_transfer_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ADD CONSTRAINT `fk_hcp_sunshine_transfer_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ADD CONSTRAINT `fk_hcp_speaker_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ADD CONSTRAINT `fk_hcp_speaker_program_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ADD CONSTRAINT `fk_hcp_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ADD CONSTRAINT `fk_hcp_contract_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ADD CONSTRAINT `fk_hcp_contract_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ADD CONSTRAINT `fk_hcp_investigator_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);

-- ========= hcp --> product (14 constraint(s)) =========
-- Requires: hcp schema, product schema
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`hco_master` ADD CONSTRAINT `fk_hcp_hco_master_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ADD CONSTRAINT `fk_hcp_kol_profile_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`kol_profile` ADD CONSTRAINT `fk_hcp_kol_profile_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ADD CONSTRAINT `fk_hcp_engagement_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`engagement` ADD CONSTRAINT `fk_hcp_engagement_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ADD CONSTRAINT `fk_hcp_sample_request_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ADD CONSTRAINT `fk_hcp_sample_request_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sunshine_transfer` ADD CONSTRAINT `fk_hcp_sunshine_transfer_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ADD CONSTRAINT `fk_hcp_speaker_program_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`speaker_program` ADD CONSTRAINT `fk_hcp_speaker_program_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ADD CONSTRAINT `fk_hcp_contract_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`contract` ADD CONSTRAINT `fk_hcp_contract_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ADD CONSTRAINT `fk_hcp_investigator_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`investigator` ADD CONSTRAINT `fk_hcp_investigator_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);

-- ========= hcp --> quality (1 constraint(s)) =========
-- Requires: hcp schema, quality schema
ALTER TABLE `pharmaceuticals_ecm`.`hcp`.`sample_request` ADD CONSTRAINT `fk_hcp_sample_request_quality_deviation_id` FOREIGN KEY (`quality_deviation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_deviation`(`quality_deviation_id`);

-- ========= intellectual --> finance (6 constraint(s)) =========
-- Requires: intellectual schema, finance schema
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`royalty_payment` ADD CONSTRAINT `fk_intellectual_royalty_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`royalty_payment` ADD CONSTRAINT `fk_intellectual_royalty_payment_payment_run_id` FOREIGN KEY (`payment_run_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`payment_run`(`payment_run_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`royalty_payment` ADD CONSTRAINT `fk_intellectual_royalty_payment_royalty_agreement_id` FOREIGN KEY (`royalty_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`royalty_agreement`(`royalty_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_litigation` ADD CONSTRAINT `fk_intellectual_patent_litigation_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_litigation` ADD CONSTRAINT `fk_intellectual_patent_litigation_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`invoice`(`invoice_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_prosecution` ADD CONSTRAINT `fk_intellectual_patent_prosecution_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);

-- ========= intellectual --> masterdata (71 constraint(s)) =========
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
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_claim` ADD CONSTRAINT `fk_intellectual_patent_claim_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_claim` ADD CONSTRAINT `fk_intellectual_patent_claim_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_claim` ADD CONSTRAINT `fk_intellectual_patent_claim_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_claim` ADD CONSTRAINT `fk_intellectual_patent_claim_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_family` ADD CONSTRAINT `fk_intellectual_patent_family_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_family` ADD CONSTRAINT `fk_intellectual_patent_family_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_family` ADD CONSTRAINT `fk_intellectual_patent_family_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_family` ADD CONSTRAINT `fk_intellectual_patent_family_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_family` ADD CONSTRAINT `fk_intellectual_patent_family_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_family` ADD CONSTRAINT `fk_intellectual_patent_family_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_family` ADD CONSTRAINT `fk_intellectual_patent_family_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period` ADD CONSTRAINT `fk_intellectual_exclusivity_period_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period` ADD CONSTRAINT `fk_intellectual_exclusivity_period_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period` ADD CONSTRAINT `fk_intellectual_exclusivity_period_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period` ADD CONSTRAINT `fk_intellectual_exclusivity_period_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period` ADD CONSTRAINT `fk_intellectual_exclusivity_period_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period` ADD CONSTRAINT `fk_intellectual_exclusivity_period_masterdata_ndc_code_id` FOREIGN KEY (`masterdata_ndc_code_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code`(`masterdata_ndc_code_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`trademark` ADD CONSTRAINT `fk_intellectual_trademark_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`trademark` ADD CONSTRAINT `fk_intellectual_trademark_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`trademark` ADD CONSTRAINT `fk_intellectual_trademark_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`trademark` ADD CONSTRAINT `fk_intellectual_trademark_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`trademark` ADD CONSTRAINT `fk_intellectual_trademark_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`trademark` ADD CONSTRAINT `fk_intellectual_trademark_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`trademark` ADD CONSTRAINT `fk_intellectual_trademark_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`drug_master_file` ADD CONSTRAINT `fk_intellectual_drug_master_file_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`drug_master_file` ADD CONSTRAINT `fk_intellectual_drug_master_file_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`drug_master_file` ADD CONSTRAINT `fk_intellectual_drug_master_file_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`drug_master_file` ADD CONSTRAINT `fk_intellectual_drug_master_file_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`drug_master_file` ADD CONSTRAINT `fk_intellectual_drug_master_file_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`drug_master_file` ADD CONSTRAINT `fk_intellectual_drug_master_file_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`drug_master_file` ADD CONSTRAINT `fk_intellectual_drug_master_file_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`drug_master_file` ADD CONSTRAINT `fk_intellectual_drug_master_file_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement` ADD CONSTRAINT `fk_intellectual_licensing_agreement_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement` ADD CONSTRAINT `fk_intellectual_licensing_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement` ADD CONSTRAINT `fk_intellectual_licensing_agreement_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement` ADD CONSTRAINT `fk_intellectual_licensing_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement` ADD CONSTRAINT `fk_intellectual_licensing_agreement_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement` ADD CONSTRAINT `fk_intellectual_licensing_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement` ADD CONSTRAINT `fk_intellectual_licensing_agreement_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`royalty_payment` ADD CONSTRAINT `fk_intellectual_royalty_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`royalty_payment` ADD CONSTRAINT `fk_intellectual_royalty_payment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`royalty_payment` ADD CONSTRAINT `fk_intellectual_royalty_payment_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`fto_analysis` ADD CONSTRAINT `fk_intellectual_fto_analysis_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`fto_analysis` ADD CONSTRAINT `fk_intellectual_fto_analysis_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`fto_analysis` ADD CONSTRAINT `fk_intellectual_fto_analysis_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`fto_analysis` ADD CONSTRAINT `fk_intellectual_fto_analysis_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_litigation` ADD CONSTRAINT `fk_intellectual_patent_litigation_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_litigation` ADD CONSTRAINT `fk_intellectual_patent_litigation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_litigation` ADD CONSTRAINT `fk_intellectual_patent_litigation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_litigation` ADD CONSTRAINT `fk_intellectual_patent_litigation_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_prosecution` ADD CONSTRAINT `fk_intellectual_patent_prosecution_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_prosecution` ADD CONSTRAINT `fk_intellectual_patent_prosecution_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_prosecution` ADD CONSTRAINT `fk_intellectual_patent_prosecution_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_prosecution` ADD CONSTRAINT `fk_intellectual_patent_prosecution_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_term_extension` ADD CONSTRAINT `fk_intellectual_patent_term_extension_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_term_extension` ADD CONSTRAINT `fk_intellectual_patent_term_extension_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_term_extension` ADD CONSTRAINT `fk_intellectual_patent_term_extension_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_term_extension` ADD CONSTRAINT `fk_intellectual_patent_term_extension_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`orange_book_listing` ADD CONSTRAINT `fk_intellectual_orange_book_listing_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`orange_book_listing` ADD CONSTRAINT `fk_intellectual_orange_book_listing_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`orange_book_listing` ADD CONSTRAINT `fk_intellectual_orange_book_listing_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`orange_book_listing` ADD CONSTRAINT `fk_intellectual_orange_book_listing_masterdata_ndc_code_id` FOREIGN KEY (`masterdata_ndc_code_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code`(`masterdata_ndc_code_id`);

-- ========= intellectual --> product (16 constraint(s)) =========
-- Requires: intellectual schema, product schema
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_claim` ADD CONSTRAINT `fk_intellectual_patent_claim_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_claim` ADD CONSTRAINT `fk_intellectual_patent_claim_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_claim` ADD CONSTRAINT `fk_intellectual_patent_claim_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period` ADD CONSTRAINT `fk_intellectual_exclusivity_period_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period` ADD CONSTRAINT `fk_intellectual_exclusivity_period_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`royalty_payment` ADD CONSTRAINT `fk_intellectual_royalty_payment_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`royalty_payment` ADD CONSTRAINT `fk_intellectual_royalty_payment_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`fto_analysis` ADD CONSTRAINT `fk_intellectual_fto_analysis_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`fto_analysis` ADD CONSTRAINT `fk_intellectual_fto_analysis_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`fto_analysis` ADD CONSTRAINT `fk_intellectual_fto_analysis_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_litigation` ADD CONSTRAINT `fk_intellectual_patent_litigation_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_litigation` ADD CONSTRAINT `fk_intellectual_patent_litigation_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_term_extension` ADD CONSTRAINT `fk_intellectual_patent_term_extension_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_term_extension` ADD CONSTRAINT `fk_intellectual_patent_term_extension_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`patent_term_extension` ADD CONSTRAINT `fk_intellectual_patent_term_extension_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`intellectual`.`orange_book_listing` ADD CONSTRAINT `fk_intellectual_orange_book_listing_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);

-- ========= manufacturing --> commercial (7 constraint(s)) =========
-- Requires: manufacturing schema, commercial schema
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_brand_plan_id` FOREIGN KEY (`brand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand_plan`(`brand_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ADD CONSTRAINT `fk_manufacturing_master_batch_record_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_brand_plan_id` FOREIGN KEY (`brand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand_plan`(`brand_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ADD CONSTRAINT `fk_manufacturing_bill_of_materials_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);

-- ========= manufacturing --> finance (13 constraint(s)) =========
-- Requires: manufacturing schema, finance schema
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_transfer_price_id` FOREIGN KEY (`transfer_price_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`transfer_price`(`transfer_price_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ADD CONSTRAINT `fk_manufacturing_line_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ADD CONSTRAINT `fk_manufacturing_line_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ADD CONSTRAINT `fk_manufacturing_equipment_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ADD CONSTRAINT `fk_manufacturing_equipment_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ADD CONSTRAINT `fk_manufacturing_equipment_qualification_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ADD CONSTRAINT `fk_manufacturing_manufacturing_deviation_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ADD CONSTRAINT `fk_manufacturing_bill_of_materials_transfer_price_id` FOREIGN KEY (`transfer_price_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`transfer_price`(`transfer_price_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);

-- ========= manufacturing --> hcp (1 constraint(s)) =========
-- Requires: manufacturing schema, hcp schema
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_investigator_id` FOREIGN KEY (`investigator_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`investigator`(`investigator_id`);

-- ========= manufacturing --> intellectual (12 constraint(s)) =========
-- Requires: manufacturing schema, intellectual schema
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_drug_master_file_id` FOREIGN KEY (`drug_master_file_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`drug_master_file`(`drug_master_file_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ADD CONSTRAINT `fk_manufacturing_master_batch_record_drug_master_file_id` FOREIGN KEY (`drug_master_file_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`drug_master_file`(`drug_master_file_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ADD CONSTRAINT `fk_manufacturing_master_batch_record_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ADD CONSTRAINT `fk_manufacturing_master_batch_record_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ADD CONSTRAINT `fk_manufacturing_site_drug_master_file_id` FOREIGN KEY (`drug_master_file_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`drug_master_file`(`drug_master_file_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ADD CONSTRAINT `fk_manufacturing_manufacturing_deviation_drug_master_file_id` FOREIGN KEY (`drug_master_file_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`drug_master_file`(`drug_master_file_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ADD CONSTRAINT `fk_manufacturing_bill_of_materials_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ADD CONSTRAINT `fk_manufacturing_bill_of_materials_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_drug_master_file_id` FOREIGN KEY (`drug_master_file_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`drug_master_file`(`drug_master_file_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);

-- ========= manufacturing --> market (2 constraint(s)) =========
-- Requires: manufacturing schema, market schema
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_coverage_decision_id` FOREIGN KEY (`coverage_decision_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`coverage_decision`(`coverage_decision_id`);

-- ========= manufacturing --> masterdata (34 constraint(s)) =========
-- Requires: manufacturing schema, masterdata schema
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_masterdata_ndc_code_id` FOREIGN KEY (`masterdata_ndc_code_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code`(`masterdata_ndc_code_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_masterdata_ndc_code_id` FOREIGN KEY (`masterdata_ndc_code_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code`(`masterdata_ndc_code_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ADD CONSTRAINT `fk_manufacturing_master_batch_record_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ADD CONSTRAINT `fk_manufacturing_master_batch_record_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ADD CONSTRAINT `fk_manufacturing_master_batch_record_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ADD CONSTRAINT `fk_manufacturing_site_address_id` FOREIGN KEY (`address_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`address`(`address_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ADD CONSTRAINT `fk_manufacturing_site_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ADD CONSTRAINT `fk_manufacturing_site_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ADD CONSTRAINT `fk_manufacturing_site_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ADD CONSTRAINT `fk_manufacturing_site_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ADD CONSTRAINT `fk_manufacturing_site_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`site` ADD CONSTRAINT `fk_manufacturing_site_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ADD CONSTRAINT `fk_manufacturing_line_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ADD CONSTRAINT `fk_manufacturing_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ADD CONSTRAINT `fk_manufacturing_equipment_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment` ADD CONSTRAINT `fk_manufacturing_equipment_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ADD CONSTRAINT `fk_manufacturing_equipment_qualification_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ADD CONSTRAINT `fk_manufacturing_process_parameter_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter_result` ADD CONSTRAINT `fk_manufacturing_process_parameter_result_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ADD CONSTRAINT `fk_manufacturing_bill_of_materials_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ADD CONSTRAINT `fk_manufacturing_bill_of_materials_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ADD CONSTRAINT `fk_manufacturing_bill_of_materials_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);

-- ========= manufacturing --> pharmacovigilance (2 constraint(s)) =========
-- Requires: manufacturing schema, pharmacovigilance schema
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_pv_product_id` FOREIGN KEY (`pv_product_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product`(`pv_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ADD CONSTRAINT `fk_manufacturing_manufacturing_deviation_pv_product_id` FOREIGN KEY (`pv_product_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product`(`pv_product_id`);

-- ========= manufacturing --> product (31 constraint(s)) =========
-- Requires: manufacturing schema, product schema
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_packaging_configuration_id` FOREIGN KEY (`packaging_configuration_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`packaging_configuration`(`packaging_configuration_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_packaging_configuration_id` FOREIGN KEY (`packaging_configuration_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`packaging_configuration`(`packaging_configuration_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ADD CONSTRAINT `fk_manufacturing_master_batch_record_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ADD CONSTRAINT `fk_manufacturing_master_batch_record_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ADD CONSTRAINT `fk_manufacturing_master_batch_record_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`line` ADD CONSTRAINT `fk_manufacturing_line_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ADD CONSTRAINT `fk_manufacturing_equipment_qualification_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_packaging_configuration_id` FOREIGN KEY (`packaging_configuration_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`packaging_configuration`(`packaging_configuration_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ADD CONSTRAINT `fk_manufacturing_process_parameter_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ADD CONSTRAINT `fk_manufacturing_manufacturing_deviation_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ADD CONSTRAINT `fk_manufacturing_manufacturing_deviation_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ADD CONSTRAINT `fk_manufacturing_manufacturing_deviation_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ADD CONSTRAINT `fk_manufacturing_bill_of_materials_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ADD CONSTRAINT `fk_manufacturing_bill_of_materials_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ADD CONSTRAINT `fk_manufacturing_bill_of_materials_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ADD CONSTRAINT `fk_manufacturing_bill_of_materials_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ADD CONSTRAINT `fk_manufacturing_bill_of_materials_packaging_configuration_id` FOREIGN KEY (`packaging_configuration_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`packaging_configuration`(`packaging_configuration_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_packaging_configuration_id` FOREIGN KEY (`packaging_configuration_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`packaging_configuration`(`packaging_configuration_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ADD CONSTRAINT `fk_manufacturing_environmental_monitoring_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);

-- ========= manufacturing --> quality (12 constraint(s)) =========
-- Requires: manufacturing schema, quality schema
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record` ADD CONSTRAINT `fk_manufacturing_master_batch_record_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification` ADD CONSTRAINT `fk_manufacturing_equipment_qualification_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_parameter` ADD CONSTRAINT `fk_manufacturing_process_parameter_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ADD CONSTRAINT `fk_manufacturing_manufacturing_deviation_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation` ADD CONSTRAINT `fk_manufacturing_manufacturing_deviation_quality_deviation_id` FOREIGN KEY (`quality_deviation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_deviation`(`quality_deviation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`bill_of_materials` ADD CONSTRAINT `fk_manufacturing_bill_of_materials_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_method_validation_id` FOREIGN KEY (`method_validation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`method_validation`(`method_validation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`process_validation` ADD CONSTRAINT `fk_manufacturing_process_validation_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ADD CONSTRAINT `fk_manufacturing_environmental_monitoring_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ADD CONSTRAINT `fk_manufacturing_environmental_monitoring_quality_deviation_id` FOREIGN KEY (`quality_deviation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`quality_deviation`(`quality_deviation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring` ADD CONSTRAINT `fk_manufacturing_environmental_monitoring_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`specification`(`specification_id`);

-- ========= manufacturing --> supply (3 constraint(s)) =========
-- Requires: manufacturing schema, supply schema
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`plan`(`plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`plan`(`plan_id`);

-- ========= market --> commercial (2 constraint(s)) =========
-- Requires: market schema, commercial schema
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ADD CONSTRAINT `fk_market_rebate_claim_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ADD CONSTRAINT `fk_market_gross_to_net_adjustment_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);

-- ========= market --> discovery (2 constraint(s)) =========
-- Requires: market schema, discovery schema
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ADD CONSTRAINT `fk_market_value_dossier_molecular_target_id` FOREIGN KEY (`molecular_target_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`molecular_target`(`molecular_target_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`heor_study` ADD CONSTRAINT `fk_market_heor_study_molecular_target_id` FOREIGN KEY (`molecular_target_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`molecular_target`(`molecular_target_id`);

-- ========= market --> finance (19 constraint(s)) =========
-- Requires: market schema, finance schema
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ADD CONSTRAINT `fk_market_access_strategy_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ADD CONSTRAINT `fk_market_access_strategy_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ADD CONSTRAINT `fk_market_hta_submission_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ADD CONSTRAINT `fk_market_hta_submission_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ADD CONSTRAINT `fk_market_value_dossier_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_contract` ADD CONSTRAINT `fk_market_payer_contract_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_contract` ADD CONSTRAINT `fk_market_payer_contract_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ADD CONSTRAINT `fk_market_rebate_claim_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ADD CONSTRAINT `fk_market_rebate_claim_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`invoice`(`invoice_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ADD CONSTRAINT `fk_market_rebate_claim_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ADD CONSTRAINT `fk_market_gross_to_net_adjustment_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ADD CONSTRAINT `fk_market_gross_to_net_adjustment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ADD CONSTRAINT `fk_market_coverage_decision_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ADD CONSTRAINT `fk_market_patient_access_program_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ADD CONSTRAINT `fk_market_pricing_decision_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ADD CONSTRAINT `fk_market_pricing_decision_transfer_price_id` FOREIGN KEY (`transfer_price_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`transfer_price`(`transfer_price_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`heor_study` ADD CONSTRAINT `fk_market_heor_study_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`heor_study` ADD CONSTRAINT `fk_market_heor_study_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ADD CONSTRAINT `fk_market_payer_engagement_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);

-- ========= market --> hcp (13 constraint(s)) =========
-- Requires: market schema, hcp schema
ALTER TABLE `pharmaceuticals_ecm`.`market`.`formulary_position` ADD CONSTRAINT `fk_market_formulary_position_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ADD CONSTRAINT `fk_market_hta_submission_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ADD CONSTRAINT `fk_market_value_dossier_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ADD CONSTRAINT `fk_market_rebate_claim_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ADD CONSTRAINT `fk_market_coverage_decision_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ADD CONSTRAINT `fk_market_patient_access_program_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ADD CONSTRAINT `fk_market_patient_access_program_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`heor_study` ADD CONSTRAINT `fk_market_heor_study_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`heor_study` ADD CONSTRAINT `fk_market_heor_study_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ADD CONSTRAINT `fk_market_payer_engagement_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ADD CONSTRAINT `fk_market_payer_engagement_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`formulary` ADD CONSTRAINT `fk_market_formulary_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`formulary` ADD CONSTRAINT `fk_market_formulary_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);

-- ========= market --> intellectual (36 constraint(s)) =========
-- Requires: market schema, intellectual schema
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ADD CONSTRAINT `fk_market_access_strategy_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ADD CONSTRAINT `fk_market_access_strategy_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ADD CONSTRAINT `fk_market_access_strategy_orange_book_listing_id` FOREIGN KEY (`orange_book_listing_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`orange_book_listing`(`orange_book_listing_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ADD CONSTRAINT `fk_market_access_strategy_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ADD CONSTRAINT `fk_market_access_strategy_patent_term_extension_id` FOREIGN KEY (`patent_term_extension_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_term_extension`(`patent_term_extension_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`formulary_position` ADD CONSTRAINT `fk_market_formulary_position_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`formulary_position` ADD CONSTRAINT `fk_market_formulary_position_orange_book_listing_id` FOREIGN KEY (`orange_book_listing_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`orange_book_listing`(`orange_book_listing_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`formulary_position` ADD CONSTRAINT `fk_market_formulary_position_patent_term_extension_id` FOREIGN KEY (`patent_term_extension_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_term_extension`(`patent_term_extension_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ADD CONSTRAINT `fk_market_hta_submission_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ADD CONSTRAINT `fk_market_hta_submission_orange_book_listing_id` FOREIGN KEY (`orange_book_listing_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`orange_book_listing`(`orange_book_listing_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ADD CONSTRAINT `fk_market_hta_submission_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ADD CONSTRAINT `fk_market_hta_submission_patent_term_extension_id` FOREIGN KEY (`patent_term_extension_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_term_extension`(`patent_term_extension_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ADD CONSTRAINT `fk_market_value_dossier_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ADD CONSTRAINT `fk_market_value_dossier_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ADD CONSTRAINT `fk_market_value_dossier_patent_term_extension_id` FOREIGN KEY (`patent_term_extension_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_term_extension`(`patent_term_extension_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_contract` ADD CONSTRAINT `fk_market_payer_contract_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_contract` ADD CONSTRAINT `fk_market_payer_contract_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_contract` ADD CONSTRAINT `fk_market_payer_contract_orange_book_listing_id` FOREIGN KEY (`orange_book_listing_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`orange_book_listing`(`orange_book_listing_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_contract` ADD CONSTRAINT `fk_market_payer_contract_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_contract` ADD CONSTRAINT `fk_market_payer_contract_patent_term_extension_id` FOREIGN KEY (`patent_term_extension_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_term_extension`(`patent_term_extension_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ADD CONSTRAINT `fk_market_rebate_claim_orange_book_listing_id` FOREIGN KEY (`orange_book_listing_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`orange_book_listing`(`orange_book_listing_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ADD CONSTRAINT `fk_market_coverage_decision_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ADD CONSTRAINT `fk_market_coverage_decision_orange_book_listing_id` FOREIGN KEY (`orange_book_listing_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`orange_book_listing`(`orange_book_listing_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ADD CONSTRAINT `fk_market_patient_access_program_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ADD CONSTRAINT `fk_market_pricing_decision_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ADD CONSTRAINT `fk_market_pricing_decision_orange_book_listing_id` FOREIGN KEY (`orange_book_listing_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`orange_book_listing`(`orange_book_listing_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ADD CONSTRAINT `fk_market_pricing_decision_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ADD CONSTRAINT `fk_market_pricing_decision_patent_term_extension_id` FOREIGN KEY (`patent_term_extension_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_term_extension`(`patent_term_extension_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`heor_study` ADD CONSTRAINT `fk_market_heor_study_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`heor_study` ADD CONSTRAINT `fk_market_heor_study_patent_term_extension_id` FOREIGN KEY (`patent_term_extension_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_term_extension`(`patent_term_extension_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ADD CONSTRAINT `fk_market_payer_engagement_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ADD CONSTRAINT `fk_market_payer_engagement_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ADD CONSTRAINT `fk_market_reimbursement_policy_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ADD CONSTRAINT `fk_market_reimbursement_policy_orange_book_listing_id` FOREIGN KEY (`orange_book_listing_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`orange_book_listing`(`orange_book_listing_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ADD CONSTRAINT `fk_market_reimbursement_policy_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ADD CONSTRAINT `fk_market_reimbursement_policy_patent_term_extension_id` FOREIGN KEY (`patent_term_extension_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_term_extension`(`patent_term_extension_id`);

-- ========= market --> masterdata (38 constraint(s)) =========
-- Requires: market schema, masterdata schema
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ADD CONSTRAINT `fk_market_access_strategy_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ADD CONSTRAINT `fk_market_access_strategy_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ADD CONSTRAINT `fk_market_payer_account_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ADD CONSTRAINT `fk_market_payer_account_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`formulary_position` ADD CONSTRAINT `fk_market_formulary_position_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`formulary_position` ADD CONSTRAINT `fk_market_formulary_position_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`formulary_position` ADD CONSTRAINT `fk_market_formulary_position_masterdata_ndc_code_id` FOREIGN KEY (`masterdata_ndc_code_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code`(`masterdata_ndc_code_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`formulary_position` ADD CONSTRAINT `fk_market_formulary_position_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ADD CONSTRAINT `fk_market_hta_submission_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ADD CONSTRAINT `fk_market_hta_submission_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ADD CONSTRAINT `fk_market_hta_submission_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ADD CONSTRAINT `fk_market_value_dossier_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ADD CONSTRAINT `fk_market_value_dossier_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ADD CONSTRAINT `fk_market_value_dossier_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_contract` ADD CONSTRAINT `fk_market_payer_contract_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_contract` ADD CONSTRAINT `fk_market_payer_contract_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ADD CONSTRAINT `fk_market_rebate_claim_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ADD CONSTRAINT `fk_market_rebate_claim_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ADD CONSTRAINT `fk_market_rebate_claim_masterdata_ndc_code_id` FOREIGN KEY (`masterdata_ndc_code_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code`(`masterdata_ndc_code_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ADD CONSTRAINT `fk_market_rebate_claim_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ADD CONSTRAINT `fk_market_gross_to_net_adjustment_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ADD CONSTRAINT `fk_market_gross_to_net_adjustment_masterdata_ndc_code_id` FOREIGN KEY (`masterdata_ndc_code_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code`(`masterdata_ndc_code_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ADD CONSTRAINT `fk_market_coverage_decision_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ADD CONSTRAINT `fk_market_coverage_decision_masterdata_ndc_code_id` FOREIGN KEY (`masterdata_ndc_code_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code`(`masterdata_ndc_code_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ADD CONSTRAINT `fk_market_patient_access_program_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ADD CONSTRAINT `fk_market_patient_access_program_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ADD CONSTRAINT `fk_market_patient_access_program_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ADD CONSTRAINT `fk_market_pricing_decision_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ADD CONSTRAINT `fk_market_pricing_decision_masterdata_ndc_code_id` FOREIGN KEY (`masterdata_ndc_code_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code`(`masterdata_ndc_code_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ADD CONSTRAINT `fk_market_pricing_decision_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`heor_study` ADD CONSTRAINT `fk_market_heor_study_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`heor_study` ADD CONSTRAINT `fk_market_heor_study_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`heor_study` ADD CONSTRAINT `fk_market_heor_study_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`heor_study` ADD CONSTRAINT `fk_market_heor_study_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`heor_study` ADD CONSTRAINT `fk_market_heor_study_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ADD CONSTRAINT `fk_market_payer_engagement_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ADD CONSTRAINT `fk_market_reimbursement_policy_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`formulary` ADD CONSTRAINT `fk_market_formulary_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);

-- ========= market --> pharmacovigilance (2 constraint(s)) =========
-- Requires: market schema, pharmacovigilance schema
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ADD CONSTRAINT `fk_market_hta_submission_rmp_id` FOREIGN KEY (`rmp_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`rmp`(`rmp_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ADD CONSTRAINT `fk_market_coverage_decision_safety_signal_id` FOREIGN KEY (`safety_signal_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`safety_signal`(`safety_signal_id`);

-- ========= market --> product (24 constraint(s)) =========
-- Requires: market schema, product schema
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ADD CONSTRAINT `fk_market_access_strategy_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ADD CONSTRAINT `fk_market_access_strategy_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`formulary_position` ADD CONSTRAINT `fk_market_formulary_position_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ADD CONSTRAINT `fk_market_hta_submission_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ADD CONSTRAINT `fk_market_hta_submission_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ADD CONSTRAINT `fk_market_value_dossier_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_contract` ADD CONSTRAINT `fk_market_payer_contract_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ADD CONSTRAINT `fk_market_rebate_claim_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ADD CONSTRAINT `fk_market_rebate_claim_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ADD CONSTRAINT `fk_market_gross_to_net_adjustment_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ADD CONSTRAINT `fk_market_coverage_decision_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ADD CONSTRAINT `fk_market_coverage_decision_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ADD CONSTRAINT `fk_market_coverage_decision_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ADD CONSTRAINT `fk_market_patient_access_program_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ADD CONSTRAINT `fk_market_patient_access_program_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ADD CONSTRAINT `fk_market_patient_access_program_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ADD CONSTRAINT `fk_market_pricing_decision_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ADD CONSTRAINT `fk_market_pricing_decision_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`heor_study` ADD CONSTRAINT `fk_market_heor_study_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`heor_study` ADD CONSTRAINT `fk_market_heor_study_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ADD CONSTRAINT `fk_market_payer_engagement_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ADD CONSTRAINT `fk_market_payer_engagement_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ADD CONSTRAINT `fk_market_reimbursement_policy_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ADD CONSTRAINT `fk_market_reimbursement_policy_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);

-- ========= market --> supply (1 constraint(s)) =========
-- Requires: market schema, supply schema
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ADD CONSTRAINT `fk_market_gross_to_net_adjustment_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);

-- ========= patient --> clinical (33 constraint(s)) =========
-- Requires: patient schema, clinical schema
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_clinical_enrollment_id` FOREIGN KEY (`clinical_enrollment_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`clinical_enrollment`(`clinical_enrollment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ADD CONSTRAINT `fk_patient_informed_consent_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ADD CONSTRAINT `fk_patient_informed_consent_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ADD CONSTRAINT `fk_patient_concomitant_medication_crf_form_id` FOREIGN KEY (`crf_form_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`crf_form`(`crf_form_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ADD CONSTRAINT `fk_patient_concomitant_medication_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ADD CONSTRAINT `fk_patient_concomitant_medication_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`visit`(`visit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ADD CONSTRAINT `fk_patient_adverse_event_crf_form_id` FOREIGN KEY (`crf_form_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`crf_form`(`crf_form_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ADD CONSTRAINT `fk_patient_adverse_event_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ADD CONSTRAINT `fk_patient_adverse_event_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ADD CONSTRAINT `fk_patient_adverse_event_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ADD CONSTRAINT `fk_patient_treatment_exposure_crf_form_id` FOREIGN KEY (`crf_form_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`crf_form`(`crf_form_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ADD CONSTRAINT `fk_patient_treatment_exposure_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ADD CONSTRAINT `fk_patient_treatment_exposure_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ADD CONSTRAINT `fk_patient_treatment_exposure_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`visit`(`visit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ADD CONSTRAINT `fk_patient_clinical_observation_crf_form_id` FOREIGN KEY (`crf_form_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`crf_form`(`crf_form_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ADD CONSTRAINT `fk_patient_clinical_observation_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ADD CONSTRAINT `fk_patient_clinical_observation_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`visit`(`visit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ADD CONSTRAINT `fk_patient_reported_outcome_crf_form_id` FOREIGN KEY (`crf_form_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`crf_form`(`crf_form_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ADD CONSTRAINT `fk_patient_reported_outcome_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ADD CONSTRAINT `fk_patient_reported_outcome_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ADD CONSTRAINT `fk_patient_reported_outcome_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`visit`(`visit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ADD CONSTRAINT `fk_patient_registry_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`protocol`(`protocol_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ADD CONSTRAINT `fk_patient_protocol_deviation_crf_form_id` FOREIGN KEY (`crf_form_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`crf_form`(`crf_form_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ADD CONSTRAINT `fk_patient_protocol_deviation_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ADD CONSTRAINT `fk_patient_protocol_deviation_principal_investigator_id` FOREIGN KEY (`principal_investigator_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`principal_investigator`(`principal_investigator_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ADD CONSTRAINT `fk_patient_protocol_deviation_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`protocol`(`protocol_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ADD CONSTRAINT `fk_patient_protocol_deviation_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ADD CONSTRAINT `fk_patient_biomarker_result_biospecimen_id` FOREIGN KEY (`biospecimen_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`biospecimen`(`biospecimen_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ADD CONSTRAINT `fk_patient_biomarker_result_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ADD CONSTRAINT `fk_patient_biomarker_result_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`visit`(`visit_id`);

-- ========= patient --> commercial (8 constraint(s)) =========
-- Requires: patient schema, commercial schema
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_brand_plan_id` FOREIGN KEY (`brand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand_plan`(`brand_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ADD CONSTRAINT `fk_patient_adverse_event_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ADD CONSTRAINT `fk_patient_treatment_exposure_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ADD CONSTRAINT `fk_patient_clinical_observation_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ADD CONSTRAINT `fk_patient_reported_outcome_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ADD CONSTRAINT `fk_patient_registry_brand_plan_id` FOREIGN KEY (`brand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand_plan`(`brand_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ADD CONSTRAINT `fk_patient_biomarker_result_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);

-- ========= patient --> discovery (10 constraint(s)) =========
-- Requires: patient schema, discovery schema
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_molecular_target_id` FOREIGN KEY (`molecular_target_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`molecular_target`(`molecular_target_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ADD CONSTRAINT `fk_patient_adverse_event_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ADD CONSTRAINT `fk_patient_treatment_exposure_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ADD CONSTRAINT `fk_patient_clinical_observation_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ADD CONSTRAINT `fk_patient_clinical_observation_molecular_target_id` FOREIGN KEY (`molecular_target_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`molecular_target`(`molecular_target_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ADD CONSTRAINT `fk_patient_registry_molecular_target_id` FOREIGN KEY (`molecular_target_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`molecular_target`(`molecular_target_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ADD CONSTRAINT `fk_patient_biomarker_result_candidate_nomination_id` FOREIGN KEY (`candidate_nomination_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`candidate_nomination`(`candidate_nomination_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ADD CONSTRAINT `fk_patient_biomarker_result_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ADD CONSTRAINT `fk_patient_biomarker_result_molecular_target_id` FOREIGN KEY (`molecular_target_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`molecular_target`(`molecular_target_id`);

-- ========= patient --> finance (8 constraint(s)) =========
-- Requires: patient schema, finance schema
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ADD CONSTRAINT `fk_patient_registry_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ADD CONSTRAINT `fk_patient_registry_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ADD CONSTRAINT `fk_patient_support_program_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ADD CONSTRAINT `fk_patient_support_program_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ADD CONSTRAINT `fk_patient_protocol_deviation_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ADD CONSTRAINT `fk_patient_biomarker_result_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);

-- ========= patient --> hcp (9 constraint(s)) =========
-- Requires: patient schema, hcp schema
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ADD CONSTRAINT `fk_patient_informed_consent_investigator_id` FOREIGN KEY (`investigator_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`investigator`(`investigator_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ADD CONSTRAINT `fk_patient_concomitant_medication_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ADD CONSTRAINT `fk_patient_adverse_event_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ADD CONSTRAINT `fk_patient_treatment_exposure_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ADD CONSTRAINT `fk_patient_clinical_observation_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ADD CONSTRAINT `fk_patient_registry_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ADD CONSTRAINT `fk_patient_support_program_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ADD CONSTRAINT `fk_patient_support_program_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ADD CONSTRAINT `fk_patient_protocol_deviation_investigator_id` FOREIGN KEY (`investigator_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`investigator`(`investigator_id`);

-- ========= patient --> intellectual (7 constraint(s)) =========
-- Requires: patient schema, intellectual schema
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ADD CONSTRAINT `fk_patient_adverse_event_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ADD CONSTRAINT `fk_patient_registry_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ADD CONSTRAINT `fk_patient_registry_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ADD CONSTRAINT `fk_patient_support_program_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ADD CONSTRAINT `fk_patient_support_program_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ADD CONSTRAINT `fk_patient_support_program_trademark_id` FOREIGN KEY (`trademark_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`trademark`(`trademark_id`);

-- ========= patient --> manufacturing (4 constraint(s)) =========
-- Requires: patient schema, manufacturing schema
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ADD CONSTRAINT `fk_patient_adverse_event_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ADD CONSTRAINT `fk_patient_adverse_event_manufacturing_deviation_id` FOREIGN KEY (`manufacturing_deviation_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation`(`manufacturing_deviation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ADD CONSTRAINT `fk_patient_treatment_exposure_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ADD CONSTRAINT `fk_patient_treatment_exposure_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`production_order`(`production_order_id`);

-- ========= patient --> market (8 constraint(s)) =========
-- Requires: patient schema, market schema
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`reimbursement_policy`(`reimbursement_policy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ADD CONSTRAINT `fk_patient_informed_consent_patient_access_program_id` FOREIGN KEY (`patient_access_program_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`patient_access_program`(`patient_access_program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ADD CONSTRAINT `fk_patient_treatment_exposure_patient_access_program_id` FOREIGN KEY (`patient_access_program_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`patient_access_program`(`patient_access_program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ADD CONSTRAINT `fk_patient_reported_outcome_heor_study_id` FOREIGN KEY (`heor_study_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`heor_study`(`heor_study_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ADD CONSTRAINT `fk_patient_registry_heor_study_id` FOREIGN KEY (`heor_study_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`heor_study`(`heor_study_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ADD CONSTRAINT `fk_patient_registry_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`reimbursement_policy`(`reimbursement_policy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ADD CONSTRAINT `fk_patient_support_program_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`reimbursement_policy`(`reimbursement_policy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ADD CONSTRAINT `fk_patient_biomarker_result_coverage_decision_id` FOREIGN KEY (`coverage_decision_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`coverage_decision`(`coverage_decision_id`);

-- ========= patient --> masterdata (20 constraint(s)) =========
-- Requires: patient schema, masterdata schema
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient` ADD CONSTRAINT `fk_patient_patient_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ADD CONSTRAINT `fk_patient_informed_consent_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ADD CONSTRAINT `fk_patient_concomitant_medication_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ADD CONSTRAINT `fk_patient_concomitant_medication_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ADD CONSTRAINT `fk_patient_adverse_event_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ADD CONSTRAINT `fk_patient_treatment_exposure_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ADD CONSTRAINT `fk_patient_treatment_exposure_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ADD CONSTRAINT `fk_patient_treatment_exposure_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`storage_location`(`storage_location_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`clinical_observation` ADD CONSTRAINT `fk_patient_clinical_observation_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ADD CONSTRAINT `fk_patient_reported_outcome_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`reported_outcome` ADD CONSTRAINT `fk_patient_reported_outcome_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ADD CONSTRAINT `fk_patient_registry_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ADD CONSTRAINT `fk_patient_registry_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ADD CONSTRAINT `fk_patient_registry_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ADD CONSTRAINT `fk_patient_support_program_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ADD CONSTRAINT `fk_patient_support_program_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ADD CONSTRAINT `fk_patient_protocol_deviation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ADD CONSTRAINT `fk_patient_biomarker_result_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ADD CONSTRAINT `fk_patient_biomarker_result_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);

-- ========= patient --> pharmacovigilance (1 constraint(s)) =========
-- Requires: patient schema, pharmacovigilance schema
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ADD CONSTRAINT `fk_patient_registry_rmp_id` FOREIGN KEY (`rmp_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`rmp`(`rmp_id`);

-- ========= patient --> product (13 constraint(s)) =========
-- Requires: patient schema, product schema
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`concomitant_medication` ADD CONSTRAINT `fk_patient_concomitant_medication_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ADD CONSTRAINT `fk_patient_adverse_event_labeling_id` FOREIGN KEY (`labeling_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`labeling`(`labeling_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ADD CONSTRAINT `fk_patient_adverse_event_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ADD CONSTRAINT `fk_patient_treatment_exposure_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ADD CONSTRAINT `fk_patient_treatment_exposure_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ADD CONSTRAINT `fk_patient_registry_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ADD CONSTRAINT `fk_patient_registry_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ADD CONSTRAINT `fk_patient_registry_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ADD CONSTRAINT `fk_patient_support_program_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ADD CONSTRAINT `fk_patient_biomarker_result_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ADD CONSTRAINT `fk_patient_biomarker_result_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);

-- ========= patient --> quality (1 constraint(s)) =========
-- Requires: patient schema, quality schema
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ADD CONSTRAINT `fk_patient_treatment_exposure_coa_id` FOREIGN KEY (`coa_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`coa`(`coa_id`);

-- ========= patient --> regulatory (18 constraint(s)) =========
-- Requires: patient schema, regulatory schema
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_label_id` FOREIGN KEY (`label_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`label`(`label_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_application_id` FOREIGN KEY (`application_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`application`(`application_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`patient_enrollment` ADD CONSTRAINT `fk_patient_patient_enrollment_rems_id` FOREIGN KEY (`rems_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`rems`(`rems_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ADD CONSTRAINT `fk_patient_informed_consent_label_id` FOREIGN KEY (`label_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`label`(`label_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`informed_consent` ADD CONSTRAINT `fk_patient_informed_consent_application_id` FOREIGN KEY (`application_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`application`(`application_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ADD CONSTRAINT `fk_patient_adverse_event_application_id` FOREIGN KEY (`application_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`application`(`application_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ADD CONSTRAINT `fk_patient_adverse_event_label_id` FOREIGN KEY (`label_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`label`(`label_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ADD CONSTRAINT `fk_patient_adverse_event_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`adverse_event` ADD CONSTRAINT `fk_patient_adverse_event_rems_id` FOREIGN KEY (`rems_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`rems`(`rems_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ADD CONSTRAINT `fk_patient_treatment_exposure_label_id` FOREIGN KEY (`label_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`label`(`label_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ADD CONSTRAINT `fk_patient_treatment_exposure_rems_id` FOREIGN KEY (`rems_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`rems`(`rems_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`registry` ADD CONSTRAINT `fk_patient_registry_post_approval_commitment_id` FOREIGN KEY (`post_approval_commitment_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment`(`post_approval_commitment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ADD CONSTRAINT `fk_patient_support_program_label_id` FOREIGN KEY (`label_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`label`(`label_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ADD CONSTRAINT `fk_patient_support_program_post_approval_commitment_id` FOREIGN KEY (`post_approval_commitment_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment`(`post_approval_commitment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`support_program` ADD CONSTRAINT `fk_patient_support_program_rems_id` FOREIGN KEY (`rems_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`rems`(`rems_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`protocol_deviation` ADD CONSTRAINT `fk_patient_protocol_deviation_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ADD CONSTRAINT `fk_patient_biomarker_result_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`biomarker_result` ADD CONSTRAINT `fk_patient_biomarker_result_label_id` FOREIGN KEY (`label_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`label`(`label_id`);

-- ========= patient --> supply (1 constraint(s)) =========
-- Requires: patient schema, supply schema
ALTER TABLE `pharmaceuticals_ecm`.`patient`.`treatment_exposure` ADD CONSTRAINT `fk_patient_treatment_exposure_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);

-- ========= pharmacovigilance --> clinical (14 constraint(s)) =========
-- Requires: pharmacovigilance schema, clinical schema
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_clinical_enrollment_id` FOREIGN KEY (`clinical_enrollment_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`clinical_enrollment`(`clinical_enrollment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`susar` ADD CONSTRAINT `fk_pharmacovigilance_susar_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`susar` ADD CONSTRAINT `fk_pharmacovigilance_susar_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`protocol`(`protocol_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`susar` ADD CONSTRAINT `fk_pharmacovigilance_susar_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`sae_report` ADD CONSTRAINT `fk_pharmacovigilance_sae_report_clinical_enrollment_id` FOREIGN KEY (`clinical_enrollment_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`clinical_enrollment`(`clinical_enrollment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`sae_report` ADD CONSTRAINT `fk_pharmacovigilance_sae_report_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`sae_report` ADD CONSTRAINT `fk_pharmacovigilance_sae_report_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`sae_report` ADD CONSTRAINT `fk_pharmacovigilance_sae_report_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`visit`(`visit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_submission` ADD CONSTRAINT `fk_pharmacovigilance_pv_submission_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`psur` ADD CONSTRAINT `fk_pharmacovigilance_psur_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`safety_signal` ADD CONSTRAINT `fk_pharmacovigilance_safety_signal_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`suspect_drug` ADD CONSTRAINT `fk_pharmacovigilance_suspect_drug_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_action` ADD CONSTRAINT `fk_pharmacovigilance_pv_action_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);

-- ========= pharmacovigilance --> commercial (16 constraint(s)) =========
-- Requires: pharmacovigilance schema, commercial schema
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_sales_rep_id` FOREIGN KEY (`sales_rep_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`sales_rep`(`sales_rep_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_adverse_reaction` ADD CONSTRAINT `fk_pharmacovigilance_pv_adverse_reaction_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`susar` ADD CONSTRAINT `fk_pharmacovigilance_susar_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`sae_report` ADD CONSTRAINT `fk_pharmacovigilance_sae_report_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`sae_report` ADD CONSTRAINT `fk_pharmacovigilance_sae_report_sales_rep_id` FOREIGN KEY (`sales_rep_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`sales_rep`(`sales_rep_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_submission` ADD CONSTRAINT `fk_pharmacovigilance_pv_submission_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`safety_signal` ADD CONSTRAINT `fk_pharmacovigilance_safety_signal_brand_plan_id` FOREIGN KEY (`brand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand_plan`(`brand_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_brand_plan_id` FOREIGN KEY (`brand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand_plan`(`brand_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`suspect_drug` ADD CONSTRAINT `fk_pharmacovigilance_suspect_drug_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_action` ADD CONSTRAINT `fk_pharmacovigilance_pv_action_brand_plan_id` FOREIGN KEY (`brand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand_plan`(`brand_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_action` ADD CONSTRAINT `fk_pharmacovigilance_pv_action_copay_program_id` FOREIGN KEY (`copay_program_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`copay_program`(`copay_program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_action` ADD CONSTRAINT `fk_pharmacovigilance_pv_action_patient_support_program_id` FOREIGN KEY (`patient_support_program_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`patient_support_program`(`patient_support_program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_action` ADD CONSTRAINT `fk_pharmacovigilance_pv_action_promo_material_id` FOREIGN KEY (`promo_material_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`promo_material`(`promo_material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_agreement` ADD CONSTRAINT `fk_pharmacovigilance_pv_agreement_brand_plan_id` FOREIGN KEY (`brand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand_plan`(`brand_plan_id`);

-- ========= pharmacovigilance --> discovery (15 constraint(s)) =========
-- Requires: pharmacovigilance schema, discovery schema
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_candidate_nomination_id` FOREIGN KEY (`candidate_nomination_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`candidate_nomination`(`candidate_nomination_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`susar` ADD CONSTRAINT `fk_pharmacovigilance_susar_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`susar` ADD CONSTRAINT `fk_pharmacovigilance_susar_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`sae_report` ADD CONSTRAINT `fk_pharmacovigilance_sae_report_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`sae_report` ADD CONSTRAINT `fk_pharmacovigilance_sae_report_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`safety_signal` ADD CONSTRAINT `fk_pharmacovigilance_safety_signal_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`safety_signal` ADD CONSTRAINT `fk_pharmacovigilance_safety_signal_molecular_target_id` FOREIGN KEY (`molecular_target_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`molecular_target`(`molecular_target_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`safety_signal` ADD CONSTRAINT `fk_pharmacovigilance_safety_signal_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_molecular_target_id` FOREIGN KEY (`molecular_target_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`molecular_target`(`molecular_target_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`suspect_drug` ADD CONSTRAINT `fk_pharmacovigilance_suspect_drug_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_agreement` ADD CONSTRAINT `fk_pharmacovigilance_pv_agreement_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);

-- ========= pharmacovigilance --> finance (8 constraint(s)) =========
-- Requires: pharmacovigilance schema, finance schema
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`susar` ADD CONSTRAINT `fk_pharmacovigilance_susar_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`sae_report` ADD CONSTRAINT `fk_pharmacovigilance_sae_report_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`psur` ADD CONSTRAINT `fk_pharmacovigilance_psur_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`psur` ADD CONSTRAINT `fk_pharmacovigilance_psur_milestone_payment_id` FOREIGN KEY (`milestone_payment_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`milestone_payment`(`milestone_payment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`rmp` ADD CONSTRAINT `fk_pharmacovigilance_rmp_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_action` ADD CONSTRAINT `fk_pharmacovigilance_pv_action_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_action` ADD CONSTRAINT `fk_pharmacovigilance_pv_action_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`invoice`(`invoice_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_agreement` ADD CONSTRAINT `fk_pharmacovigilance_pv_agreement_royalty_agreement_id` FOREIGN KEY (`royalty_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`royalty_agreement`(`royalty_agreement_id`);

-- ========= pharmacovigilance --> hcp (13 constraint(s)) =========
-- Requires: pharmacovigilance schema, hcp schema
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_investigator_id` FOREIGN KEY (`investigator_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`investigator`(`investigator_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`susar` ADD CONSTRAINT `fk_pharmacovigilance_susar_investigator_id` FOREIGN KEY (`investigator_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`investigator`(`investigator_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`sae_report` ADD CONSTRAINT `fk_pharmacovigilance_sae_report_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`sae_report` ADD CONSTRAINT `fk_pharmacovigilance_sae_report_investigator_id` FOREIGN KEY (`investigator_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`investigator`(`investigator_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`sae_report` ADD CONSTRAINT `fk_pharmacovigilance_sae_report_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`suspect_drug` ADD CONSTRAINT `fk_pharmacovigilance_suspect_drug_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`reporter` ADD CONSTRAINT `fk_pharmacovigilance_reporter_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`reporter` ADD CONSTRAINT `fk_pharmacovigilance_reporter_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_action` ADD CONSTRAINT `fk_pharmacovigilance_pv_action_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_action` ADD CONSTRAINT `fk_pharmacovigilance_pv_action_investigator_id` FOREIGN KEY (`investigator_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`investigator`(`investigator_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_action` ADD CONSTRAINT `fk_pharmacovigilance_pv_action_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);

-- ========= pharmacovigilance --> intellectual (4 constraint(s)) =========
-- Requires: pharmacovigilance schema, intellectual schema
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`psur` ADD CONSTRAINT `fk_pharmacovigilance_psur_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`safety_signal` ADD CONSTRAINT `fk_pharmacovigilance_safety_signal_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_agreement` ADD CONSTRAINT `fk_pharmacovigilance_pv_agreement_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);

-- ========= pharmacovigilance --> manufacturing (2 constraint(s)) =========
-- Requires: pharmacovigilance schema, manufacturing schema
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_agreement` ADD CONSTRAINT `fk_pharmacovigilance_pv_agreement_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);

-- ========= pharmacovigilance --> market (3 constraint(s)) =========
-- Requires: pharmacovigilance schema, market schema
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`rmp` ADD CONSTRAINT `fk_pharmacovigilance_rmp_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`rmp` ADD CONSTRAINT `fk_pharmacovigilance_rmp_patient_access_program_id` FOREIGN KEY (`patient_access_program_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`patient_access_program`(`patient_access_program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_action` ADD CONSTRAINT `fk_pharmacovigilance_pv_action_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`reimbursement_policy`(`reimbursement_policy_id`);

-- ========= pharmacovigilance --> masterdata (41 constraint(s)) =========
-- Requires: pharmacovigilance schema, masterdata schema
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_adverse_reaction` ADD CONSTRAINT `fk_pharmacovigilance_pv_adverse_reaction_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_adverse_reaction` ADD CONSTRAINT `fk_pharmacovigilance_pv_adverse_reaction_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`susar` ADD CONSTRAINT `fk_pharmacovigilance_susar_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`susar` ADD CONSTRAINT `fk_pharmacovigilance_susar_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`sae_report` ADD CONSTRAINT `fk_pharmacovigilance_sae_report_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_submission` ADD CONSTRAINT `fk_pharmacovigilance_pv_submission_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_submission` ADD CONSTRAINT `fk_pharmacovigilance_pv_submission_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_submission` ADD CONSTRAINT `fk_pharmacovigilance_pv_submission_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`psur` ADD CONSTRAINT `fk_pharmacovigilance_psur_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`psur` ADD CONSTRAINT `fk_pharmacovigilance_psur_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`psur` ADD CONSTRAINT `fk_pharmacovigilance_psur_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`psur` ADD CONSTRAINT `fk_pharmacovigilance_psur_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`psur` ADD CONSTRAINT `fk_pharmacovigilance_psur_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`rmp` ADD CONSTRAINT `fk_pharmacovigilance_rmp_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`rmp` ADD CONSTRAINT `fk_pharmacovigilance_rmp_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`rmp` ADD CONSTRAINT `fk_pharmacovigilance_rmp_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`rmp` ADD CONSTRAINT `fk_pharmacovigilance_rmp_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`safety_signal` ADD CONSTRAINT `fk_pharmacovigilance_safety_signal_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`safety_signal` ADD CONSTRAINT `fk_pharmacovigilance_safety_signal_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`safety_signal` ADD CONSTRAINT `fk_pharmacovigilance_safety_signal_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_masterdata_ndc_code_id` FOREIGN KEY (`masterdata_ndc_code_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code`(`masterdata_ndc_code_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`suspect_drug` ADD CONSTRAINT `fk_pharmacovigilance_suspect_drug_masterdata_ndc_code_id` FOREIGN KEY (`masterdata_ndc_code_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code`(`masterdata_ndc_code_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`suspect_drug` ADD CONSTRAINT `fk_pharmacovigilance_suspect_drug_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`reporter` ADD CONSTRAINT `fk_pharmacovigilance_reporter_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`reporter` ADD CONSTRAINT `fk_pharmacovigilance_reporter_address_id` FOREIGN KEY (`address_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`address`(`address_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_action` ADD CONSTRAINT `fk_pharmacovigilance_pv_action_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_action` ADD CONSTRAINT `fk_pharmacovigilance_pv_action_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_agreement` ADD CONSTRAINT `fk_pharmacovigilance_pv_agreement_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_agreement` ADD CONSTRAINT `fk_pharmacovigilance_pv_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_agreement` ADD CONSTRAINT `fk_pharmacovigilance_pv_agreement_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_agreement` ADD CONSTRAINT `fk_pharmacovigilance_pv_agreement_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);

-- ========= pharmacovigilance --> patient (8 constraint(s)) =========
-- Requires: pharmacovigilance schema, patient schema
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_adverse_reaction` ADD CONSTRAINT `fk_pharmacovigilance_pv_adverse_reaction_adverse_event_id` FOREIGN KEY (`adverse_event_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`adverse_event`(`adverse_event_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`susar` ADD CONSTRAINT `fk_pharmacovigilance_susar_adverse_event_id` FOREIGN KEY (`adverse_event_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`adverse_event`(`adverse_event_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`susar` ADD CONSTRAINT `fk_pharmacovigilance_susar_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`sae_report` ADD CONSTRAINT `fk_pharmacovigilance_sae_report_adverse_event_id` FOREIGN KEY (`adverse_event_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`adverse_event`(`adverse_event_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`sae_report` ADD CONSTRAINT `fk_pharmacovigilance_sae_report_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`suspect_drug` ADD CONSTRAINT `fk_pharmacovigilance_suspect_drug_treatment_exposure_id` FOREIGN KEY (`treatment_exposure_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`treatment_exposure`(`treatment_exposure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_action` ADD CONSTRAINT `fk_pharmacovigilance_pv_action_adverse_event_id` FOREIGN KEY (`adverse_event_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`adverse_event`(`adverse_event_id`);

-- ========= pharmacovigilance --> product (21 constraint(s)) =========
-- Requires: pharmacovigilance schema, product schema
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_adverse_reaction` ADD CONSTRAINT `fk_pharmacovigilance_pv_adverse_reaction_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_adverse_reaction` ADD CONSTRAINT `fk_pharmacovigilance_pv_adverse_reaction_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`susar` ADD CONSTRAINT `fk_pharmacovigilance_susar_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`sae_report` ADD CONSTRAINT `fk_pharmacovigilance_sae_report_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_submission` ADD CONSTRAINT `fk_pharmacovigilance_pv_submission_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`psur` ADD CONSTRAINT `fk_pharmacovigilance_psur_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`psur` ADD CONSTRAINT `fk_pharmacovigilance_psur_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`rmp` ADD CONSTRAINT `fk_pharmacovigilance_rmp_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`rmp` ADD CONSTRAINT `fk_pharmacovigilance_rmp_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`safety_signal` ADD CONSTRAINT `fk_pharmacovigilance_safety_signal_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`safety_signal` ADD CONSTRAINT `fk_pharmacovigilance_safety_signal_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_labeling_id` FOREIGN KEY (`labeling_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`labeling`(`labeling_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`suspect_drug` ADD CONSTRAINT `fk_pharmacovigilance_suspect_drug_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`suspect_drug` ADD CONSTRAINT `fk_pharmacovigilance_suspect_drug_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_action` ADD CONSTRAINT `fk_pharmacovigilance_pv_action_labeling_id` FOREIGN KEY (`labeling_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`labeling`(`labeling_id`);

-- ========= pharmacovigilance --> regulatory (41 constraint(s)) =========
-- Requires: pharmacovigilance schema, regulatory schema
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr` ADD CONSTRAINT `fk_pharmacovigilance_icsr_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_adverse_reaction` ADD CONSTRAINT `fk_pharmacovigilance_pv_adverse_reaction_label_id` FOREIGN KEY (`label_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`label`(`label_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`susar` ADD CONSTRAINT `fk_pharmacovigilance_susar_application_id` FOREIGN KEY (`application_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`application`(`application_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`susar` ADD CONSTRAINT `fk_pharmacovigilance_susar_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`susar` ADD CONSTRAINT `fk_pharmacovigilance_susar_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`sae_report` ADD CONSTRAINT `fk_pharmacovigilance_sae_report_application_id` FOREIGN KEY (`application_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`application`(`application_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`sae_report` ADD CONSTRAINT `fk_pharmacovigilance_sae_report_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`sae_report` ADD CONSTRAINT `fk_pharmacovigilance_sae_report_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_submission` ADD CONSTRAINT `fk_pharmacovigilance_pv_submission_application_id` FOREIGN KEY (`application_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`application`(`application_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_submission` ADD CONSTRAINT `fk_pharmacovigilance_pv_submission_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_submission` ADD CONSTRAINT `fk_pharmacovigilance_pv_submission_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_submission` ADD CONSTRAINT `fk_pharmacovigilance_pv_submission_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_submission` ADD CONSTRAINT `fk_pharmacovigilance_pv_submission_variation_id` FOREIGN KEY (`variation_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`variation`(`variation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`psur` ADD CONSTRAINT `fk_pharmacovigilance_psur_application_id` FOREIGN KEY (`application_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`application`(`application_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`psur` ADD CONSTRAINT `fk_pharmacovigilance_psur_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`psur` ADD CONSTRAINT `fk_pharmacovigilance_psur_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`psur` ADD CONSTRAINT `fk_pharmacovigilance_psur_label_id` FOREIGN KEY (`label_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`label`(`label_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`psur` ADD CONSTRAINT `fk_pharmacovigilance_psur_post_approval_commitment_id` FOREIGN KEY (`post_approval_commitment_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment`(`post_approval_commitment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`psur` ADD CONSTRAINT `fk_pharmacovigilance_psur_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`rmp` ADD CONSTRAINT `fk_pharmacovigilance_rmp_application_id` FOREIGN KEY (`application_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`application`(`application_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`rmp` ADD CONSTRAINT `fk_pharmacovigilance_rmp_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`rmp` ADD CONSTRAINT `fk_pharmacovigilance_rmp_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`rmp` ADD CONSTRAINT `fk_pharmacovigilance_rmp_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`safety_signal` ADD CONSTRAINT `fk_pharmacovigilance_safety_signal_label_id` FOREIGN KEY (`label_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`label`(`label_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`safety_signal` ADD CONSTRAINT `fk_pharmacovigilance_safety_signal_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_label_id` FOREIGN KEY (`label_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`label`(`label_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_rems_id` FOREIGN KEY (`rems_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`rems`(`rems_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product` ADD CONSTRAINT `fk_pharmacovigilance_pv_product_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`suspect_drug` ADD CONSTRAINT `fk_pharmacovigilance_suspect_drug_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`suspect_drug` ADD CONSTRAINT `fk_pharmacovigilance_suspect_drug_label_id` FOREIGN KEY (`label_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`label`(`label_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_action` ADD CONSTRAINT `fk_pharmacovigilance_pv_action_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_action` ADD CONSTRAINT `fk_pharmacovigilance_pv_action_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_action` ADD CONSTRAINT `fk_pharmacovigilance_pv_action_label_change_id` FOREIGN KEY (`label_change_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`label_change`(`label_change_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_action` ADD CONSTRAINT `fk_pharmacovigilance_pv_action_label_id` FOREIGN KEY (`label_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`label`(`label_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_action` ADD CONSTRAINT `fk_pharmacovigilance_pv_action_post_approval_commitment_id` FOREIGN KEY (`post_approval_commitment_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment`(`post_approval_commitment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_action` ADD CONSTRAINT `fk_pharmacovigilance_pv_action_rems_id` FOREIGN KEY (`rems_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`rems`(`rems_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_action` ADD CONSTRAINT `fk_pharmacovigilance_pv_action_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_action` ADD CONSTRAINT `fk_pharmacovigilance_pv_action_variation_id` FOREIGN KEY (`variation_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`variation`(`variation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_agreement` ADD CONSTRAINT `fk_pharmacovigilance_pv_agreement_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`approval`(`approval_id`);

-- ========= pharmacovigilance --> supply (3 constraint(s)) =========
-- Requires: pharmacovigilance schema, supply schema
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`suspect_drug` ADD CONSTRAINT `fk_pharmacovigilance_suspect_drug_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_action` ADD CONSTRAINT `fk_pharmacovigilance_pv_action_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_action` ADD CONSTRAINT `fk_pharmacovigilance_pv_action_product_recall_id` FOREIGN KEY (`product_recall_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`product_recall`(`product_recall_id`);

-- ========= product --> finance (1 constraint(s)) =========
-- Requires: product schema, finance schema
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ADD CONSTRAINT `fk_product_formulation_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);

-- ========= product --> intellectual (37 constraint(s)) =========
-- Requires: product schema, intellectual schema
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ADD CONSTRAINT `fk_product_medicinal_product_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ADD CONSTRAINT `fk_product_medicinal_product_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_family`(`patent_family_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ADD CONSTRAINT `fk_product_medicinal_product_trademark_id` FOREIGN KEY (`trademark_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`trademark`(`trademark_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ADD CONSTRAINT `fk_product_drug_substance_drug_master_file_id` FOREIGN KEY (`drug_master_file_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`drug_master_file`(`drug_master_file_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ADD CONSTRAINT `fk_product_drug_substance_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_family`(`patent_family_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ADD CONSTRAINT `fk_product_drug_substance_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ADD CONSTRAINT `fk_product_drug_product_drug_master_file_id` FOREIGN KEY (`drug_master_file_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`drug_master_file`(`drug_master_file_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ADD CONSTRAINT `fk_product_drug_product_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ADD CONSTRAINT `fk_product_drug_product_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_family`(`patent_family_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ADD CONSTRAINT `fk_product_drug_product_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ADD CONSTRAINT `fk_product_drug_product_trademark_id` FOREIGN KEY (`trademark_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`trademark`(`trademark_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ADD CONSTRAINT `fk_product_formulation_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ADD CONSTRAINT `fk_product_formulation_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ADD CONSTRAINT `fk_product_formulation_ingredient_drug_master_file_id` FOREIGN KEY (`drug_master_file_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`drug_master_file`(`drug_master_file_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ADD CONSTRAINT `fk_product_formulation_ingredient_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ADD CONSTRAINT `fk_product_packaging_configuration_orange_book_listing_id` FOREIGN KEY (`orange_book_listing_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`orange_book_listing`(`orange_book_listing_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ADD CONSTRAINT `fk_product_packaging_configuration_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_orange_book_listing_id` FOREIGN KEY (`orange_book_listing_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`orange_book_listing`(`orange_book_listing_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_trademark_id` FOREIGN KEY (`trademark_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`trademark`(`trademark_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ADD CONSTRAINT `fk_product_product_ndc_code_orange_book_listing_id` FOREIGN KEY (`orange_book_listing_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`orange_book_listing`(`orange_book_listing_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ADD CONSTRAINT `fk_product_product_ndc_code_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ADD CONSTRAINT `fk_product_lifecycle_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ADD CONSTRAINT `fk_product_lifecycle_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_family`(`patent_family_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ADD CONSTRAINT `fk_product_regulatory_identifier_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ADD CONSTRAINT `fk_product_regulatory_identifier_orange_book_listing_id` FOREIGN KEY (`orange_book_listing_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`orange_book_listing`(`orange_book_listing_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ADD CONSTRAINT `fk_product_regulatory_identifier_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ADD CONSTRAINT `fk_product_indication_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ADD CONSTRAINT `fk_product_indication_orange_book_listing_id` FOREIGN KEY (`orange_book_listing_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`orange_book_listing`(`orange_book_listing_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ADD CONSTRAINT `fk_product_indication_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ADD CONSTRAINT `fk_product_labeling_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ADD CONSTRAINT `fk_product_labeling_orange_book_listing_id` FOREIGN KEY (`orange_book_listing_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`orange_book_listing`(`orange_book_listing_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ADD CONSTRAINT `fk_product_labeling_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ADD CONSTRAINT `fk_product_combination_product_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ADD CONSTRAINT `fk_product_combination_product_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_family`(`patent_family_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ADD CONSTRAINT `fk_product_combination_product_trademark_id` FOREIGN KEY (`trademark_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`trademark`(`trademark_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ADD CONSTRAINT `fk_product_excipient_drug_master_file_id` FOREIGN KEY (`drug_master_file_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`drug_master_file`(`drug_master_file_id`);

-- ========= product --> manufacturing (2 constraint(s)) =========
-- Requires: product schema, manufacturing schema
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ADD CONSTRAINT `fk_product_combination_product_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);

-- ========= product --> masterdata (65 constraint(s)) =========
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
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ADD CONSTRAINT `fk_product_drug_substance_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ADD CONSTRAINT `fk_product_drug_substance_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ADD CONSTRAINT `fk_product_drug_substance_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ADD CONSTRAINT `fk_product_drug_substance_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ADD CONSTRAINT `fk_product_drug_product_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ADD CONSTRAINT `fk_product_drug_product_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ADD CONSTRAINT `fk_product_drug_product_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ADD CONSTRAINT `fk_product_drug_product_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ADD CONSTRAINT `fk_product_drug_product_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ADD CONSTRAINT `fk_product_drug_product_masterdata_ndc_code_id` FOREIGN KEY (`masterdata_ndc_code_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code`(`masterdata_ndc_code_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ADD CONSTRAINT `fk_product_drug_product_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ADD CONSTRAINT `fk_product_drug_product_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ADD CONSTRAINT `fk_product_drug_product_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ADD CONSTRAINT `fk_product_formulation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ADD CONSTRAINT `fk_product_formulation_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ADD CONSTRAINT `fk_product_formulation_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ADD CONSTRAINT `fk_product_formulation_ingredient_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ADD CONSTRAINT `fk_product_formulation_ingredient_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ADD CONSTRAINT `fk_product_formulation_ingredient_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ADD CONSTRAINT `fk_product_packaging_configuration_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ADD CONSTRAINT `fk_product_packaging_configuration_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ADD CONSTRAINT `fk_product_packaging_configuration_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_masterdata_ndc_code_id` FOREIGN KEY (`masterdata_ndc_code_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code`(`masterdata_ndc_code_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ADD CONSTRAINT `fk_product_product_ndc_code_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ADD CONSTRAINT `fk_product_product_ndc_code_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ADD CONSTRAINT `fk_product_product_ndc_code_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ADD CONSTRAINT `fk_product_lifecycle_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ADD CONSTRAINT `fk_product_lifecycle_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ADD CONSTRAINT `fk_product_regulatory_identifier_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ADD CONSTRAINT `fk_product_regulatory_identifier_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ADD CONSTRAINT `fk_product_regulatory_identifier_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ADD CONSTRAINT `fk_product_regulatory_identifier_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ADD CONSTRAINT `fk_product_indication_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ADD CONSTRAINT `fk_product_indication_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ADD CONSTRAINT `fk_product_indication_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ADD CONSTRAINT `fk_product_labeling_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ADD CONSTRAINT `fk_product_labeling_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ADD CONSTRAINT `fk_product_labeling_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ADD CONSTRAINT `fk_product_labeling_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ADD CONSTRAINT `fk_product_combination_product_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ADD CONSTRAINT `fk_product_combination_product_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ADD CONSTRAINT `fk_product_combination_product_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ADD CONSTRAINT `fk_product_combination_product_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ADD CONSTRAINT `fk_product_combination_product_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ADD CONSTRAINT `fk_product_combination_product_masterdata_ndc_code_id` FOREIGN KEY (`masterdata_ndc_code_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code`(`masterdata_ndc_code_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ADD CONSTRAINT `fk_product_therapeutic_area_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ADD CONSTRAINT `fk_product_therapeutic_area_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ADD CONSTRAINT `fk_product_therapeutic_area_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ADD CONSTRAINT `fk_product_therapeutic_area_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ADD CONSTRAINT `fk_product_excipient_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ADD CONSTRAINT `fk_product_excipient_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ADD CONSTRAINT `fk_product_excipient_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ADD CONSTRAINT `fk_product_excipient_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);

-- ========= product --> regulatory (1 constraint(s)) =========
-- Requires: product schema, regulatory schema
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ADD CONSTRAINT `fk_product_labeling_label_id` FOREIGN KEY (`label_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`label`(`label_id`);

-- ========= quality --> clinical (3 constraint(s)) =========
-- Requires: quality schema, clinical schema
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);

-- ========= quality --> commercial (13 constraint(s)) =========
-- Requires: quality schema, commercial schema
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_sales_rep_id` FOREIGN KEY (`sales_rep_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`sales_rep`(`sales_rep_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ADD CONSTRAINT `fk_quality_coa_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ADD CONSTRAINT `fk_quality_coa_contract_account_id` FOREIGN KEY (`contract_account_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`contract_account`(`contract_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ADD CONSTRAINT `fk_quality_coa_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ADD CONSTRAINT `fk_quality_batch_disposition_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_sales_rep_id` FOREIGN KEY (`sales_rep_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`sales_rep`(`sales_rep_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ADD CONSTRAINT `fk_quality_validation_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);

-- ========= quality --> discovery (1 constraint(s)) =========
-- Requires: quality schema, discovery schema
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ADD CONSTRAINT `fk_quality_method_validation_assay_id` FOREIGN KEY (`assay_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`assay`(`assay_id`);

-- ========= quality --> finance (14 constraint(s)) =========
-- Requires: quality schema, finance schema
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ADD CONSTRAINT `fk_quality_method_validation_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`invoice`(`invoice_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ADD CONSTRAINT `fk_quality_validation_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ADD CONSTRAINT `fk_quality_validation_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ADD CONSTRAINT `fk_quality_supplier_qualification_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);

-- ========= quality --> hcp (11 constraint(s)) =========
-- Requires: quality schema, hcp schema
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_investigator_id` FOREIGN KEY (`investigator_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`investigator`(`investigator_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_investigator_id` FOREIGN KEY (`investigator_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`investigator`(`investigator_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ADD CONSTRAINT `fk_quality_coa_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_investigator_id` FOREIGN KEY (`investigator_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`investigator`(`investigator_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_sample_request_id` FOREIGN KEY (`sample_request_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`sample_request`(`sample_request_id`);

-- ========= quality --> intellectual (10 constraint(s)) =========
-- Requires: quality schema, intellectual schema
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_drug_master_file_id` FOREIGN KEY (`drug_master_file_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`drug_master_file`(`drug_master_file_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ADD CONSTRAINT `fk_quality_method_validation_drug_master_file_id` FOREIGN KEY (`drug_master_file_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`drug_master_file`(`drug_master_file_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ADD CONSTRAINT `fk_quality_method_validation_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_trademark_id` FOREIGN KEY (`trademark_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`trademark`(`trademark_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ADD CONSTRAINT `fk_quality_validation_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_drug_master_file_id` FOREIGN KEY (`drug_master_file_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`drug_master_file`(`drug_master_file_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ADD CONSTRAINT `fk_quality_supplier_qualification_drug_master_file_id` FOREIGN KEY (`drug_master_file_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`drug_master_file`(`drug_master_file_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ADD CONSTRAINT `fk_quality_supplier_qualification_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);

-- ========= quality --> manufacturing (23 constraint(s)) =========
-- Requires: quality schema, manufacturing schema
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`equipment`(`equipment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`equipment`(`equipment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_line_id` FOREIGN KEY (`line_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`line`(`line_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
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

-- ========= quality --> market (4 constraint(s)) =========
-- Requires: quality schema, market schema
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_patient_access_program_id` FOREIGN KEY (`patient_access_program_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`patient_access_program`(`patient_access_program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ADD CONSTRAINT `fk_quality_coa_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_patient_access_program_id` FOREIGN KEY (`patient_access_program_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`patient_access_program`(`patient_access_program_id`);

-- ========= quality --> masterdata (35 constraint(s)) =========
-- Requires: quality schema, masterdata schema
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ADD CONSTRAINT `fk_quality_lab_test_result_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ADD CONSTRAINT `fk_quality_lab_test_result_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ADD CONSTRAINT `fk_quality_method_validation_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ADD CONSTRAINT `fk_quality_method_validation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ADD CONSTRAINT `fk_quality_coa_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ADD CONSTRAINT `fk_quality_coa_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ADD CONSTRAINT `fk_quality_coa_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ADD CONSTRAINT `fk_quality_coa_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ADD CONSTRAINT `fk_quality_batch_disposition_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ADD CONSTRAINT `fk_quality_batch_disposition_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ADD CONSTRAINT `fk_quality_batch_disposition_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`storage_location`(`storage_location_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ADD CONSTRAINT `fk_quality_validation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ADD CONSTRAINT `fk_quality_supplier_qualification_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ADD CONSTRAINT `fk_quality_supplier_qualification_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ADD CONSTRAINT `fk_quality_supplier_qualification_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);

-- ========= quality --> patient (5 constraint(s)) =========
-- Requires: quality schema, patient schema
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_treatment_exposure_id` FOREIGN KEY (`treatment_exposure_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`treatment_exposure`(`treatment_exposure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_adverse_event_id` FOREIGN KEY (`adverse_event_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`adverse_event`(`adverse_event_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_patient_enrollment_id` FOREIGN KEY (`patient_enrollment_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient_enrollment`(`patient_enrollment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_protocol_deviation_id` FOREIGN KEY (`protocol_deviation_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`protocol_deviation`(`protocol_deviation_id`);

-- ========= quality --> pharmacovigilance (7 constraint(s)) =========
-- Requires: quality schema, pharmacovigilance schema
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_icsr_id` FOREIGN KEY (`icsr_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr`(`icsr_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_icsr_id` FOREIGN KEY (`icsr_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr`(`icsr_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_pv_agreement_id` FOREIGN KEY (`pv_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_agreement`(`pv_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ADD CONSTRAINT `fk_quality_batch_disposition_icsr_id` FOREIGN KEY (`icsr_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr`(`icsr_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ADD CONSTRAINT `fk_quality_batch_disposition_safety_signal_id` FOREIGN KEY (`safety_signal_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`safety_signal`(`safety_signal_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_icsr_id` FOREIGN KEY (`icsr_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`icsr`(`icsr_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_pv_adverse_reaction_id` FOREIGN KEY (`pv_adverse_reaction_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_adverse_reaction`(`pv_adverse_reaction_id`);

-- ========= quality --> product (35 constraint(s)) =========
-- Requires: quality schema, product schema
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`change_control` ADD CONSTRAINT `fk_quality_change_control_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ADD CONSTRAINT `fk_quality_lab_test_result_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ADD CONSTRAINT `fk_quality_lab_test_result_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_packaging_configuration_id` FOREIGN KEY (`packaging_configuration_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`packaging_configuration`(`packaging_configuration_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ADD CONSTRAINT `fk_quality_method_validation_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ADD CONSTRAINT `fk_quality_method_validation_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`method_validation` ADD CONSTRAINT `fk_quality_method_validation_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ADD CONSTRAINT `fk_quality_coa_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ADD CONSTRAINT `fk_quality_coa_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ADD CONSTRAINT `fk_quality_coa_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ADD CONSTRAINT `fk_quality_coa_packaging_configuration_id` FOREIGN KEY (`packaging_configuration_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`packaging_configuration`(`packaging_configuration_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ADD CONSTRAINT `fk_quality_batch_disposition_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ADD CONSTRAINT `fk_quality_batch_disposition_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ADD CONSTRAINT `fk_quality_batch_disposition_packaging_configuration_id` FOREIGN KEY (`packaging_configuration_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`packaging_configuration`(`packaging_configuration_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_packaging_configuration_id` FOREIGN KEY (`packaging_configuration_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`packaging_configuration`(`packaging_configuration_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ADD CONSTRAINT `fk_quality_validation_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ADD CONSTRAINT `fk_quality_validation_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ADD CONSTRAINT `fk_quality_validation_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ADD CONSTRAINT `fk_quality_validation_packaging_configuration_id` FOREIGN KEY (`packaging_configuration_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`packaging_configuration`(`packaging_configuration_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_excipient_id` FOREIGN KEY (`excipient_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`excipient`(`excipient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`specification` ADD CONSTRAINT `fk_quality_specification_packaging_configuration_id` FOREIGN KEY (`packaging_configuration_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`packaging_configuration`(`packaging_configuration_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ADD CONSTRAINT `fk_quality_supplier_qualification_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ADD CONSTRAINT `fk_quality_supplier_qualification_excipient_id` FOREIGN KEY (`excipient_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`excipient`(`excipient_id`);

-- ========= quality --> regulatory (8 constraint(s)) =========
-- Requires: quality schema, regulatory schema
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`capa` ADD CONSTRAINT `fk_quality_capa_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_health_authority_id` FOREIGN KEY (`health_authority_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`health_authority`(`health_authority_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ADD CONSTRAINT `fk_quality_coa_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ADD CONSTRAINT `fk_quality_batch_disposition_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ADD CONSTRAINT `fk_quality_supplier_qualification_dmf_id` FOREIGN KEY (`dmf_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`dmf`(`dmf_id`);

-- ========= quality --> supply (13 constraint(s)) =========
-- Requires: quality schema, supply schema
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`quality_deviation` ADD CONSTRAINT `fk_quality_quality_deviation_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`oos_investigation` ADD CONSTRAINT `fk_quality_oos_investigation_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_distribution_network_id` FOREIGN KEY (`distribution_network_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`distribution_network`(`distribution_network_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`audit` ADD CONSTRAINT `fk_quality_audit_warehouse_receipt_id` FOREIGN KEY (`warehouse_receipt_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`warehouse_receipt`(`warehouse_receipt_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`lab_test_result` ADD CONSTRAINT `fk_quality_lab_test_result_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`stability_study` ADD CONSTRAINT `fk_quality_stability_study_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`coa` ADD CONSTRAINT `fk_quality_coa_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`batch_disposition` ADD CONSTRAINT `fk_quality_batch_disposition_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`complaint` ADD CONSTRAINT `fk_quality_complaint_product_recall_id` FOREIGN KEY (`product_recall_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`product_recall`(`product_recall_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ADD CONSTRAINT `fk_quality_validation_distribution_network_id` FOREIGN KEY (`distribution_network_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`distribution_network`(`distribution_network_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`validation` ADD CONSTRAINT `fk_quality_validation_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`plan`(`plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`quality`.`supplier_qualification` ADD CONSTRAINT `fk_quality_supplier_qualification_distribution_network_id` FOREIGN KEY (`distribution_network_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`distribution_network`(`distribution_network_id`);

-- ========= regulatory --> commercial (20 constraint(s)) =========
-- Requires: regulatory schema, commercial schema
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`milestone` ADD CONSTRAINT `fk_regulatory_milestone_brand_plan_id` FOREIGN KEY (`brand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand_plan`(`brand_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`milestone` ADD CONSTRAINT `fk_regulatory_milestone_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`ha_interaction` ADD CONSTRAINT `fk_regulatory_ha_interaction_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label` ADD CONSTRAINT `fk_regulatory_label_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label` ADD CONSTRAINT `fk_regulatory_label_brand_plan_id` FOREIGN KEY (`brand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand_plan`(`brand_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label_change` ADD CONSTRAINT `fk_regulatory_label_change_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label_change` ADD CONSTRAINT `fk_regulatory_label_change_brand_plan_id` FOREIGN KEY (`brand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand_plan`(`brand_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label_change` ADD CONSTRAINT `fk_regulatory_label_change_mlr_review_id` FOREIGN KEY (`mlr_review_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`mlr_review`(`mlr_review_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`rems` ADD CONSTRAINT `fk_regulatory_rems_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`rems` ADD CONSTRAINT `fk_regulatory_rems_brand_plan_id` FOREIGN KEY (`brand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand_plan`(`brand_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment` ADD CONSTRAINT `fk_regulatory_post_approval_commitment_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`designation` ADD CONSTRAINT `fk_regulatory_designation_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`designation` ADD CONSTRAINT `fk_regulatory_designation_brand_plan_id` FOREIGN KEY (`brand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand_plan`(`brand_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`variation` ADD CONSTRAINT `fk_regulatory_variation_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`variation` ADD CONSTRAINT `fk_regulatory_variation_brand_plan_id` FOREIGN KEY (`brand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand_plan`(`brand_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`variation` ADD CONSTRAINT `fk_regulatory_variation_mlr_review_id` FOREIGN KEY (`mlr_review_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`mlr_review`(`mlr_review_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`product_registration` ADD CONSTRAINT `fk_regulatory_product_registration_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`product_registration` ADD CONSTRAINT `fk_regulatory_product_registration_brand_plan_id` FOREIGN KEY (`brand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand_plan`(`brand_plan_id`);

-- ========= regulatory --> finance (7 constraint(s)) =========
-- Requires: regulatory schema, finance schema
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`application` ADD CONSTRAINT `fk_regulatory_application_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`milestone` ADD CONSTRAINT `fk_regulatory_milestone_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`rems` ADD CONSTRAINT `fk_regulatory_rems_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment` ADD CONSTRAINT `fk_regulatory_post_approval_commitment_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`strategy` ADD CONSTRAINT `fk_regulatory_strategy_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`variation` ADD CONSTRAINT `fk_regulatory_variation_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);

-- ========= regulatory --> hcp (5 constraint(s)) =========
-- Requires: regulatory schema, hcp schema
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_investigator_id` FOREIGN KEY (`investigator_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`investigator`(`investigator_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`milestone` ADD CONSTRAINT `fk_regulatory_milestone_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment` ADD CONSTRAINT `fk_regulatory_post_approval_commitment_hco_master_id` FOREIGN KEY (`hco_master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`hco_master`(`hco_master_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment` ADD CONSTRAINT `fk_regulatory_post_approval_commitment_investigator_id` FOREIGN KEY (`investigator_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`investigator`(`investigator_id`);

-- ========= regulatory --> intellectual (21 constraint(s)) =========
-- Requires: regulatory schema, intellectual schema
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`application` ADD CONSTRAINT `fk_regulatory_application_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`application` ADD CONSTRAINT `fk_regulatory_application_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`application` ADD CONSTRAINT `fk_regulatory_application_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`milestone` ADD CONSTRAINT `fk_regulatory_milestone_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`milestone` ADD CONSTRAINT `fk_regulatory_milestone_patent_term_extension_id` FOREIGN KEY (`patent_term_extension_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_term_extension`(`patent_term_extension_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_orange_book_listing_id` FOREIGN KEY (`orange_book_listing_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`orange_book_listing`(`orange_book_listing_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_trademark_id` FOREIGN KEY (`trademark_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`trademark`(`trademark_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`dmf` ADD CONSTRAINT `fk_regulatory_dmf_drug_master_file_id` FOREIGN KEY (`drug_master_file_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`drug_master_file`(`drug_master_file_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`dmf` ADD CONSTRAINT `fk_regulatory_dmf_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_family`(`patent_family_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`strategy` ADD CONSTRAINT `fk_regulatory_strategy_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`strategy` ADD CONSTRAINT `fk_regulatory_strategy_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`strategy` ADD CONSTRAINT `fk_regulatory_strategy_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_family`(`patent_family_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`designation` ADD CONSTRAINT `fk_regulatory_designation_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`designation` ADD CONSTRAINT `fk_regulatory_designation_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`variation` ADD CONSTRAINT `fk_regulatory_variation_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`variation` ADD CONSTRAINT `fk_regulatory_variation_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`product_registration` ADD CONSTRAINT `fk_regulatory_product_registration_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`product_registration` ADD CONSTRAINT `fk_regulatory_product_registration_trademark_id` FOREIGN KEY (`trademark_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`trademark`(`trademark_id`);

-- ========= regulatory --> manufacturing (10 constraint(s)) =========
-- Requires: regulatory schema, manufacturing schema
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_process_validation_id` FOREIGN KEY (`process_validation_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`process_validation`(`process_validation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`milestone` ADD CONSTRAINT `fk_regulatory_milestone_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`dmf` ADD CONSTRAINT `fk_regulatory_dmf_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment` ADD CONSTRAINT `fk_regulatory_post_approval_commitment_process_validation_id` FOREIGN KEY (`process_validation_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`process_validation`(`process_validation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment` ADD CONSTRAINT `fk_regulatory_post_approval_commitment_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`variation` ADD CONSTRAINT `fk_regulatory_variation_master_batch_record_id` FOREIGN KEY (`master_batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record`(`master_batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`variation` ADD CONSTRAINT `fk_regulatory_variation_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`product_registration` ADD CONSTRAINT `fk_regulatory_product_registration_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);

-- ========= regulatory --> market (19 constraint(s)) =========
-- Requires: regulatory schema, market schema
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_pricing_decision_id` FOREIGN KEY (`pricing_decision_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`pricing_decision`(`pricing_decision_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`application` ADD CONSTRAINT `fk_regulatory_application_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`milestone` ADD CONSTRAINT `fk_regulatory_milestone_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_pricing_decision_id` FOREIGN KEY (`pricing_decision_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`pricing_decision`(`pricing_decision_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`reimbursement_policy`(`reimbursement_policy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label` ADD CONSTRAINT `fk_regulatory_label_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`reimbursement_policy`(`reimbursement_policy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label` ADD CONSTRAINT `fk_regulatory_label_value_dossier_id` FOREIGN KEY (`value_dossier_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`value_dossier`(`value_dossier_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label_change` ADD CONSTRAINT `fk_regulatory_label_change_coverage_decision_id` FOREIGN KEY (`coverage_decision_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`coverage_decision`(`coverage_decision_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label_change` ADD CONSTRAINT `fk_regulatory_label_change_pricing_decision_id` FOREIGN KEY (`pricing_decision_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`pricing_decision`(`pricing_decision_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label_change` ADD CONSTRAINT `fk_regulatory_label_change_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`reimbursement_policy`(`reimbursement_policy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`rems` ADD CONSTRAINT `fk_regulatory_rems_patient_access_program_id` FOREIGN KEY (`patient_access_program_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`patient_access_program`(`patient_access_program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment` ADD CONSTRAINT `fk_regulatory_post_approval_commitment_heor_study_id` FOREIGN KEY (`heor_study_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`heor_study`(`heor_study_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment` ADD CONSTRAINT `fk_regulatory_post_approval_commitment_hta_submission_id` FOREIGN KEY (`hta_submission_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`hta_submission`(`hta_submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`designation` ADD CONSTRAINT `fk_regulatory_designation_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`variation` ADD CONSTRAINT `fk_regulatory_variation_hta_submission_id` FOREIGN KEY (`hta_submission_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`hta_submission`(`hta_submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`variation` ADD CONSTRAINT `fk_regulatory_variation_pricing_decision_id` FOREIGN KEY (`pricing_decision_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`pricing_decision`(`pricing_decision_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`product_registration` ADD CONSTRAINT `fk_regulatory_product_registration_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`product_registration` ADD CONSTRAINT `fk_regulatory_product_registration_hta_submission_id` FOREIGN KEY (`hta_submission_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`hta_submission`(`hta_submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`product_registration` ADD CONSTRAINT `fk_regulatory_product_registration_pricing_decision_id` FOREIGN KEY (`pricing_decision_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`pricing_decision`(`pricing_decision_id`);

-- ========= regulatory --> masterdata (39 constraint(s)) =========
-- Requires: regulatory schema, masterdata schema
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`health_authority` ADD CONSTRAINT `fk_regulatory_health_authority_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`health_authority` ADD CONSTRAINT `fk_regulatory_health_authority_address_id` FOREIGN KEY (`address_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`address`(`address_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`application` ADD CONSTRAINT `fk_regulatory_application_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`application` ADD CONSTRAINT `fk_regulatory_application_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`application` ADD CONSTRAINT `fk_regulatory_application_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_masterdata_ndc_code_id` FOREIGN KEY (`masterdata_ndc_code_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code`(`masterdata_ndc_code_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`ha_interaction` ADD CONSTRAINT `fk_regulatory_ha_interaction_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`dmf` ADD CONSTRAINT `fk_regulatory_dmf_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`dmf` ADD CONSTRAINT `fk_regulatory_dmf_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`dmf` ADD CONSTRAINT `fk_regulatory_dmf_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`dmf` ADD CONSTRAINT `fk_regulatory_dmf_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label` ADD CONSTRAINT `fk_regulatory_label_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label` ADD CONSTRAINT `fk_regulatory_label_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label` ADD CONSTRAINT `fk_regulatory_label_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label_change` ADD CONSTRAINT `fk_regulatory_label_change_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label_change` ADD CONSTRAINT `fk_regulatory_label_change_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`rems` ADD CONSTRAINT `fk_regulatory_rems_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`rems` ADD CONSTRAINT `fk_regulatory_rems_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment` ADD CONSTRAINT `fk_regulatory_post_approval_commitment_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`strategy` ADD CONSTRAINT `fk_regulatory_strategy_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`strategy` ADD CONSTRAINT `fk_regulatory_strategy_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`designation` ADD CONSTRAINT `fk_regulatory_designation_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`designation` ADD CONSTRAINT `fk_regulatory_designation_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`designation` ADD CONSTRAINT `fk_regulatory_designation_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`variation` ADD CONSTRAINT `fk_regulatory_variation_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`variation` ADD CONSTRAINT `fk_regulatory_variation_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`product_registration` ADD CONSTRAINT `fk_regulatory_product_registration_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`product_registration` ADD CONSTRAINT `fk_regulatory_product_registration_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`product_registration` ADD CONSTRAINT `fk_regulatory_product_registration_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`product_registration` ADD CONSTRAINT `fk_regulatory_product_registration_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`product_registration` ADD CONSTRAINT `fk_regulatory_product_registration_masterdata_ndc_code_id` FOREIGN KEY (`masterdata_ndc_code_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code`(`masterdata_ndc_code_id`);

-- ========= regulatory --> pharmacovigilance (5 constraint(s)) =========
-- Requires: regulatory schema, pharmacovigilance schema
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`milestone` ADD CONSTRAINT `fk_regulatory_milestone_psur_id` FOREIGN KEY (`psur_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`psur`(`psur_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`milestone` ADD CONSTRAINT `fk_regulatory_milestone_rmp_id` FOREIGN KEY (`rmp_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`rmp`(`rmp_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`ha_interaction` ADD CONSTRAINT `fk_regulatory_ha_interaction_safety_signal_id` FOREIGN KEY (`safety_signal_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`safety_signal`(`safety_signal_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label_change` ADD CONSTRAINT `fk_regulatory_label_change_safety_signal_id` FOREIGN KEY (`safety_signal_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`safety_signal`(`safety_signal_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`variation` ADD CONSTRAINT `fk_regulatory_variation_safety_signal_id` FOREIGN KEY (`safety_signal_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`safety_signal`(`safety_signal_id`);

-- ========= regulatory --> product (37 constraint(s)) =========
-- Requires: regulatory schema, product schema
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`application` ADD CONSTRAINT `fk_regulatory_application_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`application` ADD CONSTRAINT `fk_regulatory_application_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`application` ADD CONSTRAINT `fk_regulatory_application_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`milestone` ADD CONSTRAINT `fk_regulatory_milestone_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`milestone` ADD CONSTRAINT `fk_regulatory_milestone_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`ha_interaction` ADD CONSTRAINT `fk_regulatory_ha_interaction_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`dmf` ADD CONSTRAINT `fk_regulatory_dmf_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label` ADD CONSTRAINT `fk_regulatory_label_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label` ADD CONSTRAINT `fk_regulatory_label_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label` ADD CONSTRAINT `fk_regulatory_label_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label_change` ADD CONSTRAINT `fk_regulatory_label_change_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label_change` ADD CONSTRAINT `fk_regulatory_label_change_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label_change` ADD CONSTRAINT `fk_regulatory_label_change_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`rems` ADD CONSTRAINT `fk_regulatory_rems_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`rems` ADD CONSTRAINT `fk_regulatory_rems_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment` ADD CONSTRAINT `fk_regulatory_post_approval_commitment_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment` ADD CONSTRAINT `fk_regulatory_post_approval_commitment_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment` ADD CONSTRAINT `fk_regulatory_post_approval_commitment_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`post_approval_commitment` ADD CONSTRAINT `fk_regulatory_post_approval_commitment_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`strategy` ADD CONSTRAINT `fk_regulatory_strategy_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`strategy` ADD CONSTRAINT `fk_regulatory_strategy_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`strategy` ADD CONSTRAINT `fk_regulatory_strategy_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`designation` ADD CONSTRAINT `fk_regulatory_designation_indication_id` FOREIGN KEY (`indication_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`indication`(`indication_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`designation` ADD CONSTRAINT `fk_regulatory_designation_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`variation` ADD CONSTRAINT `fk_regulatory_variation_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`variation` ADD CONSTRAINT `fk_regulatory_variation_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`variation` ADD CONSTRAINT `fk_regulatory_variation_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`variation` ADD CONSTRAINT `fk_regulatory_variation_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`product_registration` ADD CONSTRAINT `fk_regulatory_product_registration_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`product_registration` ADD CONSTRAINT `fk_regulatory_product_registration_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`product_registration` ADD CONSTRAINT `fk_regulatory_product_registration_packaging_configuration_id` FOREIGN KEY (`packaging_configuration_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`packaging_configuration`(`packaging_configuration_id`);

-- ========= regulatory --> quality (4 constraint(s)) =========
-- Requires: regulatory schema, quality schema
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`milestone` ADD CONSTRAINT `fk_regulatory_milestone_validation_id` FOREIGN KEY (`validation_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`validation`(`validation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label` ADD CONSTRAINT `fk_regulatory_label_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`specification`(`specification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label_change` ADD CONSTRAINT `fk_regulatory_label_change_capa_id` FOREIGN KEY (`capa_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`capa`(`capa_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`product_registration` ADD CONSTRAINT `fk_regulatory_product_registration_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `pharmaceuticals_ecm`.`quality`.`specification`(`specification_id`);

-- ========= regulatory --> supply (5 constraint(s)) =========
-- Requires: regulatory schema, supply schema
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`milestone` ADD CONSTRAINT `fk_regulatory_milestone_product_recall_id` FOREIGN KEY (`product_recall_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`product_recall`(`product_recall_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`label_change` ADD CONSTRAINT `fk_regulatory_label_change_product_recall_id` FOREIGN KEY (`product_recall_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`product_recall`(`product_recall_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`variation` ADD CONSTRAINT `fk_regulatory_variation_inventory_lot_id` FOREIGN KEY (`inventory_lot_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`inventory_lot`(`inventory_lot_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`variation` ADD CONSTRAINT `fk_regulatory_variation_product_recall_id` FOREIGN KEY (`product_recall_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`product_recall`(`product_recall_id`);
ALTER TABLE `pharmaceuticals_ecm`.`regulatory`.`product_registration` ADD CONSTRAINT `fk_regulatory_product_registration_serialization_record_id` FOREIGN KEY (`serialization_record_id`) REFERENCES `pharmaceuticals_ecm`.`supply`.`serialization_record`(`serialization_record_id`);

-- ========= supply --> clinical (11 constraint(s)) =========
-- Requires: supply schema, clinical schema
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`inventory_lot` ADD CONSTRAINT `fk_supply_inventory_lot_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`clinical_supply_order` ADD CONSTRAINT `fk_supply_clinical_supply_order_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`clinical_supply_order` ADD CONSTRAINT `fk_supply_clinical_supply_order_investigational_site_id` FOREIGN KEY (`investigational_site_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`investigational_site`(`investigational_site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`clinical_supply_order` ADD CONSTRAINT `fk_supply_clinical_supply_order_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`protocol`(`protocol_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`clinical_supply_order` ADD CONSTRAINT `fk_supply_clinical_supply_order_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`trial`(`trial_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`serialization_record` ADD CONSTRAINT `fk_supply_serialization_record_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`cold_chain_record` ADD CONSTRAINT `fk_supply_cold_chain_record_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `pharmaceuticals_ecm`.`clinical`.`investigational_product`(`investigational_product_id`);

-- ========= supply --> commercial (11 constraint(s)) =========
-- Requires: supply schema, commercial schema
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_brand_plan_id` FOREIGN KEY (`brand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand_plan`(`brand_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_brand_plan_id` FOREIGN KEY (`brand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand_plan`(`brand_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`inventory_lot` ADD CONSTRAINT `fk_supply_inventory_lot_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`delivery_order` ADD CONSTRAINT `fk_supply_delivery_order_contract_account_id` FOREIGN KEY (`contract_account_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`contract_account`(`contract_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_brand_plan_id` FOREIGN KEY (`brand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand_plan`(`brand_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`serialization_record` ADD CONSTRAINT `fk_supply_serialization_record_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`serialization_record` ADD CONSTRAINT `fk_supply_serialization_record_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`cold_chain_record` ADD CONSTRAINT `fk_supply_cold_chain_record_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);

-- ========= supply --> discovery (3 constraint(s)) =========
-- Requires: supply schema, discovery schema
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`clinical_supply_order` ADD CONSTRAINT `fk_supply_clinical_supply_order_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`compound`(`compound_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`clinical_supply_order` ADD CONSTRAINT `fk_supply_clinical_supply_order_project_id` FOREIGN KEY (`project_id`) REFERENCES `pharmaceuticals_ecm`.`discovery`.`project`(`project_id`);

-- ========= supply --> finance (6 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`inventory_lot` ADD CONSTRAINT `fk_supply_inventory_lot_transfer_price_id` FOREIGN KEY (`transfer_price_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`transfer_price`(`transfer_price_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`goods_issue` ADD CONSTRAINT `fk_supply_goods_issue_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`stock_transfer_order` ADD CONSTRAINT `fk_supply_stock_transfer_order_transfer_price_id` FOREIGN KEY (`transfer_price_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`transfer_price`(`transfer_price_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`clinical_supply_order` ADD CONSTRAINT `fk_supply_clinical_supply_order_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `pharmaceuticals_ecm`.`finance`.`internal_order`(`internal_order_id`);

-- ========= supply --> hcp (3 constraint(s)) =========
-- Requires: supply schema, hcp schema
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`inventory_lot` ADD CONSTRAINT `fk_supply_inventory_lot_investigator_id` FOREIGN KEY (`investigator_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`investigator`(`investigator_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`clinical_supply_order` ADD CONSTRAINT `fk_supply_clinical_supply_order_investigator_id` FOREIGN KEY (`investigator_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`investigator`(`investigator_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`serialization_record` ADD CONSTRAINT `fk_supply_serialization_record_master_id` FOREIGN KEY (`master_id`) REFERENCES `pharmaceuticals_ecm`.`hcp`.`master`(`master_id`);

-- ========= supply --> intellectual (12 constraint(s)) =========
-- Requires: supply schema, intellectual schema
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_family`(`patent_family_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_exclusivity_period_id` FOREIGN KEY (`exclusivity_period_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`exclusivity_period`(`exclusivity_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent_family`(`patent_family_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`inventory_lot` ADD CONSTRAINT `fk_supply_inventory_lot_drug_master_file_id` FOREIGN KEY (`drug_master_file_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`drug_master_file`(`drug_master_file_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`clinical_supply_order` ADD CONSTRAINT `fk_supply_clinical_supply_order_licensing_agreement_id` FOREIGN KEY (`licensing_agreement_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`licensing_agreement`(`licensing_agreement_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`clinical_supply_order` ADD CONSTRAINT `fk_supply_clinical_supply_order_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`patent`(`patent_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_drug_master_file_id` FOREIGN KEY (`drug_master_file_id`) REFERENCES `pharmaceuticals_ecm`.`intellectual`.`drug_master_file`(`drug_master_file_id`);

-- ========= supply --> manufacturing (13 constraint(s)) =========
-- Requires: supply schema, manufacturing schema
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_source_site_id` FOREIGN KEY (`source_site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`inventory_lot` ADD CONSTRAINT `fk_supply_inventory_lot_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`distribution_network` ADD CONSTRAINT `fk_supply_distribution_network_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`clinical_supply_order` ADD CONSTRAINT `fk_supply_clinical_supply_order_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`clinical_supply_order` ADD CONSTRAINT `fk_supply_clinical_supply_order_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_line_id` FOREIGN KEY (`line_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`line`(`line_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_manufacturing_deviation_id` FOREIGN KEY (`manufacturing_deviation_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation`(`manufacturing_deviation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_master_batch_record_id` FOREIGN KEY (`master_batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`master_batch_record`(`master_batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`serialization_record` ADD CONSTRAINT `fk_supply_serialization_record_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`serialization_record` ADD CONSTRAINT `fk_supply_serialization_record_site_id` FOREIGN KEY (`site_id`) REFERENCES `pharmaceuticals_ecm`.`manufacturing`.`site`(`site_id`);

-- ========= supply --> market (9 constraint(s)) =========
-- Requires: supply schema, market schema
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`inventory_lot` ADD CONSTRAINT `fk_supply_inventory_lot_patient_access_program_id` FOREIGN KEY (`patient_access_program_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`patient_access_program`(`patient_access_program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_patient_access_program_id` FOREIGN KEY (`patient_access_program_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`patient_access_program`(`patient_access_program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_payer_account_id` FOREIGN KEY (`payer_account_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`payer_account`(`payer_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`delivery_order` ADD CONSTRAINT `fk_supply_delivery_order_patient_access_program_id` FOREIGN KEY (`patient_access_program_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`patient_access_program`(`patient_access_program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_coverage_decision_id` FOREIGN KEY (`coverage_decision_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`coverage_decision`(`coverage_decision_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_patient_access_program_id` FOREIGN KEY (`patient_access_program_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`patient_access_program`(`patient_access_program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`reimbursement_policy`(`reimbursement_policy_id`);

-- ========= supply --> masterdata (54 constraint(s)) =========
-- Requires: supply schema, masterdata schema
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`storage_location`(`storage_location_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`inventory_lot` ADD CONSTRAINT `fk_supply_inventory_lot_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`inventory_lot` ADD CONSTRAINT `fk_supply_inventory_lot_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`inventory_lot` ADD CONSTRAINT `fk_supply_inventory_lot_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`storage_location`(`storage_location_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`inventory_lot` ADD CONSTRAINT `fk_supply_inventory_lot_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`inventory_lot` ADD CONSTRAINT `fk_supply_inventory_lot_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`warehouse_receipt` ADD CONSTRAINT `fk_supply_warehouse_receipt_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`warehouse_receipt` ADD CONSTRAINT `fk_supply_warehouse_receipt_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`warehouse_receipt` ADD CONSTRAINT `fk_supply_warehouse_receipt_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`storage_location`(`storage_location_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`warehouse_receipt` ADD CONSTRAINT `fk_supply_warehouse_receipt_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`warehouse_receipt` ADD CONSTRAINT `fk_supply_warehouse_receipt_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`goods_issue` ADD CONSTRAINT `fk_supply_goods_issue_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`goods_issue` ADD CONSTRAINT `fk_supply_goods_issue_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`storage_location`(`storage_location_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`goods_issue` ADD CONSTRAINT `fk_supply_goods_issue_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`goods_issue` ADD CONSTRAINT `fk_supply_goods_issue_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`goods_issue` ADD CONSTRAINT `fk_supply_goods_issue_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`goods_issue` ADD CONSTRAINT `fk_supply_goods_issue_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`stock_transfer_order` ADD CONSTRAINT `fk_supply_stock_transfer_order_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`stock_transfer_order` ADD CONSTRAINT `fk_supply_stock_transfer_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`stock_transfer_order` ADD CONSTRAINT `fk_supply_stock_transfer_order_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`storage_location`(`storage_location_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`stock_transfer_order` ADD CONSTRAINT `fk_supply_stock_transfer_order_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`delivery_order` ADD CONSTRAINT `fk_supply_delivery_order_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`delivery_order` ADD CONSTRAINT `fk_supply_delivery_order_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`delivery_order` ADD CONSTRAINT `fk_supply_delivery_order_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`storage_location`(`storage_location_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`delivery_order` ADD CONSTRAINT `fk_supply_delivery_order_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`distribution_network` ADD CONSTRAINT `fk_supply_distribution_network_address_id` FOREIGN KEY (`address_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`address`(`address_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`distribution_network` ADD CONSTRAINT `fk_supply_distribution_network_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`distribution_network` ADD CONSTRAINT `fk_supply_distribution_network_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`distribution_network` ADD CONSTRAINT `fk_supply_distribution_network_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`clinical_supply_order` ADD CONSTRAINT `fk_supply_clinical_supply_order_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`clinical_supply_order` ADD CONSTRAINT `fk_supply_clinical_supply_order_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`clinical_supply_order` ADD CONSTRAINT `fk_supply_clinical_supply_order_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`serialization_record` ADD CONSTRAINT `fk_supply_serialization_record_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`serialization_record` ADD CONSTRAINT `fk_supply_serialization_record_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`serialization_record` ADD CONSTRAINT `fk_supply_serialization_record_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`serialization_record` ADD CONSTRAINT `fk_supply_serialization_record_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`storage_location`(`storage_location_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`cold_chain_record` ADD CONSTRAINT `fk_supply_cold_chain_record_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`business_partner`(`business_partner_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`cold_chain_record` ADD CONSTRAINT `fk_supply_cold_chain_record_material_id` FOREIGN KEY (`material_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`material`(`material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`cold_chain_record` ADD CONSTRAINT `fk_supply_cold_chain_record_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`storage_location`(`storage_location_id`);

-- ========= supply --> patient (4 constraint(s)) =========
-- Requires: supply schema, patient schema
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`clinical_supply_order` ADD CONSTRAINT `fk_supply_clinical_supply_order_patient_enrollment_id` FOREIGN KEY (`patient_enrollment_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient_enrollment`(`patient_enrollment_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`serialization_record` ADD CONSTRAINT `fk_supply_serialization_record_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`patient`(`patient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`serialization_record` ADD CONSTRAINT `fk_supply_serialization_record_treatment_exposure_id` FOREIGN KEY (`treatment_exposure_id`) REFERENCES `pharmaceuticals_ecm`.`patient`.`treatment_exposure`(`treatment_exposure_id`);

-- ========= supply --> pharmacovigilance (2 constraint(s)) =========
-- Requires: supply schema, pharmacovigilance schema
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_pv_product_id` FOREIGN KEY (`pv_product_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`pv_product`(`pv_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_safety_signal_id` FOREIGN KEY (`safety_signal_id`) REFERENCES `pharmaceuticals_ecm`.`pharmacovigilance`.`safety_signal`(`safety_signal_id`);

-- ========= supply --> product (25 constraint(s)) =========
-- Requires: supply schema, product schema
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_packaging_configuration_id` FOREIGN KEY (`packaging_configuration_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`packaging_configuration`(`packaging_configuration_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`inventory_lot` ADD CONSTRAINT `fk_supply_inventory_lot_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`inventory_lot` ADD CONSTRAINT `fk_supply_inventory_lot_packaging_configuration_id` FOREIGN KEY (`packaging_configuration_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`packaging_configuration`(`packaging_configuration_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`inventory_lot` ADD CONSTRAINT `fk_supply_inventory_lot_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`warehouse_receipt` ADD CONSTRAINT `fk_supply_warehouse_receipt_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`goods_issue` ADD CONSTRAINT `fk_supply_goods_issue_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`stock_transfer_order` ADD CONSTRAINT `fk_supply_stock_transfer_order_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`stock_transfer_order` ADD CONSTRAINT `fk_supply_stock_transfer_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`delivery_order` ADD CONSTRAINT `fk_supply_delivery_order_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`delivery_order` ADD CONSTRAINT `fk_supply_delivery_order_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`clinical_supply_order` ADD CONSTRAINT `fk_supply_clinical_supply_order_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`clinical_supply_order` ADD CONSTRAINT `fk_supply_clinical_supply_order_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_packaging_configuration_id` FOREIGN KEY (`packaging_configuration_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`packaging_configuration`(`packaging_configuration_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`serialization_record` ADD CONSTRAINT `fk_supply_serialization_record_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`serialization_record` ADD CONSTRAINT `fk_supply_serialization_record_packaging_configuration_id` FOREIGN KEY (`packaging_configuration_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`packaging_configuration`(`packaging_configuration_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`serialization_record` ADD CONSTRAINT `fk_supply_serialization_record_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`cold_chain_record` ADD CONSTRAINT `fk_supply_cold_chain_record_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);

-- ========= supply --> regulatory (1 constraint(s)) =========
-- Requires: supply schema, regulatory schema
ALTER TABLE `pharmaceuticals_ecm`.`supply`.`product_recall` ADD CONSTRAINT `fk_supply_product_recall_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `pharmaceuticals_ecm`.`regulatory`.`approval`(`approval_id`);

