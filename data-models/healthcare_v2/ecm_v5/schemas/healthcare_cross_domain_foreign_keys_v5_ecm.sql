-- Cross-Domain Foreign Keys for Business:  | Version: v5_ecm
-- Generated on: 2026-05-21 09:45:22
-- Total cross-domain FK constraints: 3624
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: behavioral_health, billing, claim, clinical, clinical_ai, clinical_ai_governance, clinical_trial_matching, compliance, consent, databricks_governance, delta_tblproperties, digital_health, encounter, facility, finance, fk, genomics, insurance, interoperability, laboratory, metadata, order, patient, patient_engagement, pharmacy, population_health, population_health_cohort, population_health_cohort_management, population_health_cohort_mgmt, post_acute_care, provider, quality, radiology, reference, research, research_clinical_trial_matching, scheduling, supply, uc_tags, workforce

-- ========= behavioral_health --> billing (2 constraint(s)) =========
-- Requires: behavioral_health schema, billing schema
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_mat_treatment_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `healthcare_ecm_v1`.`billing`.`cdm_entry`(`cdm_entry_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ADD CONSTRAINT `fk_behavioral_health_therapy_session_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `healthcare_ecm_v1`.`billing`.`cdm_entry`(`cdm_entry_id`);

-- ========= behavioral_health --> clinical (11 constraint(s)) =========
-- Requires: behavioral_health schema, clinical schema
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ADD CONSTRAINT `fk_behavioral_health_crisis_episode_care_team_id` FOREIGN KEY (`care_team_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`care_team`(`care_team_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_psychiatric_assessment_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_psychiatric_assessment_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_sud_episode_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_sud_episode_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_sud_episode_problem_id` FOREIGN KEY (`problem_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`problem`(`problem_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_mat_treatment_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_otp_enrollment_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_crisis_episode_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ADD CONSTRAINT `fk_behavioral_health_therapy_session_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ADD CONSTRAINT `fk_behavioral_health_therapy_session_problem_id` FOREIGN KEY (`problem_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`problem`(`problem_id`);

-- ========= behavioral_health --> clinical_ai (3 constraint(s)) =========
-- Requires: behavioral_health schema, clinical_ai schema
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_psychiatric_assessment_clinical_ai_patient_risk_score_id` FOREIGN KEY (`clinical_ai_patient_risk_score_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score`(`clinical_ai_patient_risk_score_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_sud_episode_clinical_ai_care_gap_id` FOREIGN KEY (`clinical_ai_care_gap_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap`(`clinical_ai_care_gap_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_otp_enrollment_clinical_ai_patient_risk_score_id` FOREIGN KEY (`clinical_ai_patient_risk_score_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score`(`clinical_ai_patient_risk_score_id`);

-- ========= behavioral_health --> compliance (1 constraint(s)) =========
-- Requires: behavioral_health schema, compliance schema
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ADD CONSTRAINT `fk_behavioral_health_cfr42_consent_workflow_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`audit`(`audit_id`);

-- ========= behavioral_health --> consent (3 constraint(s)) =========
-- Requires: behavioral_health schema, consent schema
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ADD CONSTRAINT `fk_behavioral_health_crisis_episode_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_otp_enrollment_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_cfr42_consent_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);

-- ========= behavioral_health --> digital_health (4 constraint(s)) =========
-- Requires: behavioral_health schema, digital_health schema
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_psychiatric_assessment_prom_response_id` FOREIGN KEY (`prom_response_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`prom_response`(`prom_response_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_sud_episode_rpm_enrollment_id` FOREIGN KEY (`rpm_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment`(`rpm_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ADD CONSTRAINT `fk_behavioral_health_therapy_session_prom_response_id` FOREIGN KEY (`prom_response_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`prom_response`(`prom_response_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ADD CONSTRAINT `fk_behavioral_health_therapy_session_device_id` FOREIGN KEY (`device_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`device`(`device_id`);

-- ========= behavioral_health --> encounter (9 constraint(s)) =========
-- Requires: behavioral_health schema, encounter schema
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ADD CONSTRAINT `fk_behavioral_health_psychiatric_assessment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ADD CONSTRAINT `fk_behavioral_health_sud_episode_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ADD CONSTRAINT `fk_behavioral_health_mat_treatment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ADD CONSTRAINT `fk_behavioral_health_crisis_episode_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ADD CONSTRAINT `fk_behavioral_health_cfr42_consent_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_psychiatric_assessment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_mat_treatment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_crisis_episode_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ADD CONSTRAINT `fk_behavioral_health_therapy_session_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);

-- ========= behavioral_health --> facility (10 constraint(s)) =========
-- Requires: behavioral_health schema, facility schema
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ADD CONSTRAINT `fk_behavioral_health_sud_episode_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ADD CONSTRAINT `fk_behavioral_health_mat_treatment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ADD CONSTRAINT `fk_behavioral_health_crisis_episode_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ADD CONSTRAINT `fk_behavioral_health_cfr42_consent_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_psychiatric_assessment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_sud_episode_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_mat_treatment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_otp_enrollment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_crisis_episode_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ADD CONSTRAINT `fk_behavioral_health_therapy_session_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= behavioral_health --> finance (2 constraint(s)) =========
-- Requires: behavioral_health schema, finance schema
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_otp_enrollment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_otp_enrollment_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`fund`(`fund_id`);

-- ========= behavioral_health --> insurance (6 constraint(s)) =========
-- Requires: behavioral_health schema, insurance schema
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_sud_episode_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_sud_episode_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_mat_treatment_utilization_review_id` FOREIGN KEY (`utilization_review_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`utilization_review`(`utilization_review_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_otp_enrollment_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_otp_enrollment_payer_contact_id` FOREIGN KEY (`payer_contact_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer_contact`(`payer_contact_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ADD CONSTRAINT `fk_behavioral_health_therapy_session_utilization_review_id` FOREIGN KEY (`utilization_review_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`utilization_review`(`utilization_review_id`);

-- ========= behavioral_health --> interoperability (1 constraint(s)) =========
-- Requires: behavioral_health schema, interoperability schema
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_cfr42_consent_hie_participation_id` FOREIGN KEY (`hie_participation_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`hie_participation`(`hie_participation_id`);

-- ========= behavioral_health --> laboratory (1 constraint(s)) =========
-- Requires: behavioral_health schema, laboratory schema
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_mat_treatment_laboratory_test_result_id` FOREIGN KEY (`laboratory_test_result_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`laboratory_test_result`(`laboratory_test_result_id`);

-- ========= behavioral_health --> order (2 constraint(s)) =========
-- Requires: behavioral_health schema, order schema
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_mat_treatment_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ADD CONSTRAINT `fk_behavioral_health_therapy_session_therapy_order_id` FOREIGN KEY (`therapy_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`therapy_order`(`therapy_order_id`);

-- ========= behavioral_health --> patient (22 constraint(s)) =========
-- Requires: behavioral_health schema, patient schema
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ADD CONSTRAINT `fk_behavioral_health_psychiatric_assessment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ADD CONSTRAINT `fk_behavioral_health_sud_episode_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ADD CONSTRAINT `fk_behavioral_health_mat_treatment_care_program_id` FOREIGN KEY (`care_program_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`care_program`(`care_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ADD CONSTRAINT `fk_behavioral_health_mat_treatment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ADD CONSTRAINT `fk_behavioral_health_otp_enrollment_care_program_id` FOREIGN KEY (`care_program_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`care_program`(`care_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ADD CONSTRAINT `fk_behavioral_health_otp_enrollment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ADD CONSTRAINT `fk_behavioral_health_crisis_episode_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ADD CONSTRAINT `fk_behavioral_health_crisis_episode_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ADD CONSTRAINT `fk_behavioral_health_cfr42_consent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_psychiatric_assessment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_psychiatric_assessment_sdoh_assessment_id` FOREIGN KEY (`sdoh_assessment_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`sdoh_assessment`(`sdoh_assessment_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_sud_episode_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_sud_episode_sdoh_assessment_id` FOREIGN KEY (`sdoh_assessment_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`sdoh_assessment`(`sdoh_assessment_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_mat_treatment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_mat_treatment_program_enrollment_id` FOREIGN KEY (`program_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`program_enrollment`(`program_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_otp_enrollment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_crisis_episode_emergency_contact_id` FOREIGN KEY (`emergency_contact_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`emergency_contact`(`emergency_contact_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_crisis_episode_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_cfr42_consent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ADD CONSTRAINT `fk_behavioral_health_cfr42_consent_workflow_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ADD CONSTRAINT `fk_behavioral_health_cfr42_consent_workflow_primary_mpi_record_id` FOREIGN KEY (`primary_mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ADD CONSTRAINT `fk_behavioral_health_therapy_session_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= behavioral_health --> pharmacy (6 constraint(s)) =========
-- Requires: behavioral_health schema, pharmacy schema
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_sud_episode_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `healthcare_ecm_v1`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_mat_treatment_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_mat_treatment_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `healthcare_ecm_v1`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_otp_enrollment_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_otp_enrollment_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `healthcare_ecm_v1`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_crisis_episode_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm_v1`.`pharmacy`.`drug_master`(`drug_master_id`);

-- ========= behavioral_health --> population_health_cohort_management (1 constraint(s)) =========
-- Requires: behavioral_health schema, population_health_cohort_management schema
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_sud_episode_population_health_cohort_management_cohort_membership_id` FOREIGN KEY (`population_health_cohort_management_cohort_membership_id`) REFERENCES `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_membership`(`population_health_cohort_management_cohort_membership_id`);

-- ========= behavioral_health --> post_acute_care (1 constraint(s)) =========
-- Requires: behavioral_health schema, post_acute_care schema
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_mat_treatment_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);

-- ========= behavioral_health --> provider (22 constraint(s)) =========
-- Requires: behavioral_health schema, provider schema
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ADD CONSTRAINT `fk_behavioral_health_psychiatric_assessment_psychiatric_clinician_id` FOREIGN KEY (`psychiatric_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`psychiatric_assessment` ADD CONSTRAINT `fk_behavioral_health_psychiatric_assessment_psychiatric_cosigning_provider_clinician_id` FOREIGN KEY (`psychiatric_cosigning_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ADD CONSTRAINT `fk_behavioral_health_sud_episode_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`sud_episode` ADD CONSTRAINT `fk_behavioral_health_sud_episode_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ADD CONSTRAINT `fk_behavioral_health_mat_treatment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`mat_treatment` ADD CONSTRAINT `fk_behavioral_health_mat_treatment_mat_supervising_provider_clinician_id` FOREIGN KEY (`mat_supervising_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ADD CONSTRAINT `fk_behavioral_health_otp_enrollment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`otp_enrollment` ADD CONSTRAINT `fk_behavioral_health_otp_enrollment_otp_counselor_clinician_id` FOREIGN KEY (`otp_counselor_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ADD CONSTRAINT `fk_behavioral_health_crisis_episode_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`crisis_episode` ADD CONSTRAINT `fk_behavioral_health_crisis_episode_primary_clinician_id` FOREIGN KEY (`primary_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ADD CONSTRAINT `fk_behavioral_health_cfr42_consent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_psychiatric_assessment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_sud_episode_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_sud_episode_group_id` FOREIGN KEY (`group_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`group`(`group_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_mat_treatment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_mat_treatment_dea_registration_id` FOREIGN KEY (`dea_registration_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`dea_registration`(`dea_registration_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_otp_enrollment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_otp_enrollment_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_crisis_episode_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_cfr42_consent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ADD CONSTRAINT `fk_behavioral_health_cfr42_consent_workflow_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ADD CONSTRAINT `fk_behavioral_health_therapy_session_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= behavioral_health --> reference (6 constraint(s)) =========
-- Requires: behavioral_health schema, reference schema
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_psychiatric_assessment_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_psychiatric_assessment_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_sud_episode_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_otp_enrollment_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ADD CONSTRAINT `fk_behavioral_health_therapy_session_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ADD CONSTRAINT `fk_behavioral_health_therapy_session_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);

-- ========= behavioral_health --> research (3 constraint(s)) =========
-- Requires: behavioral_health schema, research schema
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_mat_treatment_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_cfr42_consent_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ADD CONSTRAINT `fk_behavioral_health_therapy_session_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);

-- ========= behavioral_health --> scheduling (3 constraint(s)) =========
-- Requires: behavioral_health schema, scheduling schema
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_psychiatric_assessment_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_mat_treatment_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ADD CONSTRAINT `fk_behavioral_health_therapy_session_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);

-- ========= behavioral_health --> workforce (12 constraint(s)) =========
-- Requires: behavioral_health schema, workforce schema
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent` ADD CONSTRAINT `fk_behavioral_health_cfr42_consent_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_psychiatric_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_mat_treatment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_otp_enrollment` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_otp_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_crisis_episode_behavioral_employee_id` FOREIGN KEY (`behavioral_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_crisis_episode_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_cfr42_consent_behavioral_employee_id` FOREIGN KEY (`behavioral_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent` ADD CONSTRAINT `fk_behavioral_health_behavioral_health_cfr42_consent_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ADD CONSTRAINT `fk_behavioral_health_cfr42_consent_workflow_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`cfr42_consent_workflow` ADD CONSTRAINT `fk_behavioral_health_cfr42_consent_workflow_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ADD CONSTRAINT `fk_behavioral_health_therapy_session_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`behavioral_health`.`therapy_session` ADD CONSTRAINT `fk_behavioral_health_therapy_session_therapy_employee_id` FOREIGN KEY (`therapy_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);

-- ========= billing --> claim (7 constraint(s)) =========
-- Requires: billing schema, claim schema
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_remittance_id` FOREIGN KEY (`remittance_id`) REFERENCES `healthcare_ecm_v1`.`claim`.`remittance`(`remittance_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm_v1`.`claim`.`claim`(`claim_id`);

-- ========= billing --> clinical (2 constraint(s)) =========
-- Requires: billing schema, clinical schema
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_immunization_id` FOREIGN KEY (`immunization_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`immunization`(`immunization_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`procedure_event`(`procedure_event_id`);

-- ========= billing --> clinical_ai (1 constraint(s)) =========
-- Requires: billing schema, clinical_ai schema
ALTER TABLE `healthcare_ecm_v1`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_clinical_ai_clinical_nlp_result_id` FOREIGN KEY (`clinical_ai_clinical_nlp_result_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result`(`clinical_ai_clinical_nlp_result_id`);

-- ========= billing --> compliance (7 constraint(s)) =========
-- Requires: billing schema, compliance schema
ALTER TABLE `healthcare_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`rac_audit` ADD CONSTRAINT `fk_billing_rac_audit_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charity_care_application` ADD CONSTRAINT `fk_billing_charity_care_application_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);

-- ========= billing --> consent (3 constraint(s)) =========
-- Requires: billing schema, consent schema
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_restriction_request_id` FOREIGN KEY (`restriction_request_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`restriction_request`(`restriction_request_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_restriction_request_id` FOREIGN KEY (`restriction_request_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`restriction_request`(`restriction_request_id`);

-- ========= billing --> digital_health (1 constraint(s)) =========
-- Requires: billing schema, digital_health schema
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_rpm_enrollment_id` FOREIGN KEY (`rpm_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment`(`rpm_enrollment_id`);

-- ========= billing --> encounter (11 constraint(s)) =========
-- Requires: billing schema, encounter schema
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_discharge_summary_id` FOREIGN KEY (`discharge_summary_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`discharge_summary`(`discharge_summary_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`collection_account` ADD CONSTRAINT `fk_billing_collection_account_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`rac_audit` ADD CONSTRAINT `fk_billing_rac_audit_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charity_care_application` ADD CONSTRAINT `fk_billing_charity_care_application_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);

-- ========= billing --> facility (13 constraint(s)) =========
-- Requires: billing schema, facility schema
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_bed_id` FOREIGN KEY (`bed_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`bed`(`bed_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`cdm_entry` ADD CONSTRAINT `fk_billing_cdm_entry_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`patient_account` ADD CONSTRAINT `fk_billing_patient_account_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`collection_account` ADD CONSTRAINT `fk_billing_collection_account_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`rac_audit` ADD CONSTRAINT `fk_billing_rac_audit_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`site_cdm_pricing` ADD CONSTRAINT `fk_billing_site_cdm_pricing_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= billing --> finance (10 constraint(s)) =========
-- Requires: billing schema, finance schema
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_ar_account_id` FOREIGN KEY (`ar_account_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`ar_account`(`ar_account_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_finance_ar_transaction_id` FOREIGN KEY (`finance_ar_transaction_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`finance_ar_transaction`(`finance_ar_transaction_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_finance_ar_transaction_id` FOREIGN KEY (`finance_ar_transaction_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`finance_ar_transaction`(`finance_ar_transaction_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`patient_account` ADD CONSTRAINT `fk_billing_patient_account_ar_account_id` FOREIGN KEY (`ar_account_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`ar_account`(`ar_account_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`collection_account` ADD CONSTRAINT `fk_billing_collection_account_ar_account_id` FOREIGN KEY (`ar_account_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`ar_account`(`ar_account_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_finance_ar_transaction_id` FOREIGN KEY (`finance_ar_transaction_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`finance_ar_transaction`(`finance_ar_transaction_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_finance_ar_transaction_id` FOREIGN KEY (`finance_ar_transaction_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`finance_ar_transaction`(`finance_ar_transaction_id`);

-- ========= billing --> insurance (12 constraint(s)) =========
-- Requires: billing schema, insurance schema
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_insurance_network_participation_id` FOREIGN KEY (`insurance_network_participation_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`insurance_network_participation`(`insurance_network_participation_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_tertiary_payer_id` FOREIGN KEY (`tertiary_payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`billing_coverage` ADD CONSTRAINT `fk_billing_billing_coverage_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`billing_coverage` ADD CONSTRAINT `fk_billing_billing_coverage_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`billing_coverage` ADD CONSTRAINT `fk_billing_billing_coverage_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`rac_audit` ADD CONSTRAINT `fk_billing_rac_audit_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);

-- ========= billing --> interoperability (5 constraint(s)) =========
-- Requires: billing schema, interoperability schema
ALTER TABLE `healthcare_ecm_v1`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`cda_document`(`cda_document_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_direct_message_id` FOREIGN KEY (`direct_message_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`direct_message`(`direct_message_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`rac_audit` ADD CONSTRAINT `fk_billing_rac_audit_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`cda_document`(`cda_document_id`);

-- ========= billing --> laboratory (1 constraint(s)) =========
-- Requires: billing schema, laboratory schema
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`lab_order`(`lab_order_id`);

-- ========= billing --> order (6 constraint(s)) =========
-- Requires: billing schema, order schema
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_fulfillment_id` FOREIGN KEY (`fulfillment_id`) REFERENCES `healthcare_ecm_v1`.`order`.`fulfillment`(`fulfillment_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`cdm_entry` ADD CONSTRAINT `fk_billing_cdm_entry_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_referral_order_id` FOREIGN KEY (`referral_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`referral_order`(`referral_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= billing --> patient (32 constraint(s)) =========
-- Requires: billing schema, patient schema
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_invoice_mpi_record_id` FOREIGN KEY (`invoice_mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_payment_mpi_record_id` FOREIGN KEY (`payment_mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_payment_patient_mpi_record_id` FOREIGN KEY (`payment_patient_mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`patient_account` ADD CONSTRAINT `fk_billing_patient_account_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`patient_account` ADD CONSTRAINT `fk_billing_patient_account_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`patient_account` ADD CONSTRAINT `fk_billing_patient_account_primary_mpi_record_id` FOREIGN KEY (`primary_mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`statement` ADD CONSTRAINT `fk_billing_statement_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`statement` ADD CONSTRAINT `fk_billing_statement_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`collection_account` ADD CONSTRAINT `fk_billing_collection_account_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`collection_account` ADD CONSTRAINT `fk_billing_collection_account_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`billing_coverage` ADD CONSTRAINT `fk_billing_billing_coverage_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`billing_coverage` ADD CONSTRAINT `fk_billing_billing_coverage_billing_mpi_record_id` FOREIGN KEY (`billing_mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_financial_assistance_id` FOREIGN KEY (`financial_assistance_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`financial_assistance`(`financial_assistance_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`rac_audit` ADD CONSTRAINT `fk_billing_rac_audit_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charity_care_application` ADD CONSTRAINT `fk_billing_charity_care_application_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charity_care_application` ADD CONSTRAINT `fk_billing_charity_care_application_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`guarantor`(`guarantor_id`);

-- ========= billing --> pharmacy (4 constraint(s)) =========
-- Requires: billing schema, pharmacy schema
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `healthcare_ecm_v1`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`billing_coverage` ADD CONSTRAINT `fk_billing_billing_coverage_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `healthcare_ecm_v1`.`pharmacy`.`formulary`(`formulary_id`);

-- ========= billing --> post_acute_care (5 constraint(s)) =========
-- Requires: billing schema, post_acute_care schema
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_service_delivery_id` FOREIGN KEY (`service_delivery_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`service_delivery`(`service_delivery_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);

-- ========= billing --> provider (11 constraint(s)) =========
-- Requires: billing schema, provider schema
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_primary_charge_clinician_id` FOREIGN KEY (`primary_charge_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_anesthesia_provider_clinician_id` FOREIGN KEY (`anesthesia_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_invoice_clinician_id` FOREIGN KEY (`invoice_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_provider_location_id` FOREIGN KEY (`provider_location_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`provider_location`(`provider_location_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_provider_sanction_id` FOREIGN KEY (`provider_sanction_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`provider_sanction`(`provider_sanction_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`billing_coverage` ADD CONSTRAINT `fk_billing_billing_coverage_group_id` FOREIGN KEY (`group_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`group`(`group_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`billing_coverage` ADD CONSTRAINT `fk_billing_billing_coverage_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`org_provider`(`org_provider_id`);

-- ========= billing --> radiology (1 constraint(s)) =========
-- Requires: billing schema, radiology schema
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `healthcare_ecm_v1`.`radiology`.`imaging_order`(`imaging_order_id`);

-- ========= billing --> reference (19 constraint(s)) =========
-- Requires: billing schema, reference schema
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`cdm_entry` ADD CONSTRAINT `fk_billing_cdm_entry_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`cdm_entry` ADD CONSTRAINT `fk_billing_cdm_entry_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`cdm_entry` ADD CONSTRAINT `fk_billing_cdm_entry_primary_cdm_hcpcs_code_id` FOREIGN KEY (`primary_cdm_hcpcs_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_revenue_code_id` FOREIGN KEY (`revenue_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);

-- ========= billing --> research (1 constraint(s)) =========
-- Requires: billing schema, research schema
ALTER TABLE `healthcare_ecm_v1`.`billing`.`study_service_coverage` ADD CONSTRAINT `fk_billing_study_service_coverage_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);

-- ========= billing --> scheduling (2 constraint(s)) =========
-- Requires: billing schema, scheduling schema
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `healthcare_ecm_v1`.`scheduling`.`surgical_case`(`surgical_case_id`);

-- ========= billing --> supply (7 constraint(s)) =========
-- Requires: billing schema, supply schema
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_case_cart_id` FOREIGN KEY (`case_cart_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`case_cart`(`case_cart_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`cdm_entry` ADD CONSTRAINT `fk_billing_cdm_entry_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`patient_account` ADD CONSTRAINT `fk_billing_patient_account_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`statement` ADD CONSTRAINT `fk_billing_statement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`collection_account` ADD CONSTRAINT `fk_billing_collection_account_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`invoice_material_line` ADD CONSTRAINT `fk_billing_invoice_material_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);

-- ========= billing --> workforce (23 constraint(s)) =========
-- Requires: billing schema, workforce schema
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charge` ADD CONSTRAINT `fk_billing_charge_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`cdm_entry` ADD CONSTRAINT `fk_billing_cdm_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`cdm_entry` ADD CONSTRAINT `fk_billing_cdm_entry_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`coding_assignment` ADD CONSTRAINT `fk_billing_coding_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`statement` ADD CONSTRAINT `fk_billing_statement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`collection_account` ADD CONSTRAINT `fk_billing_collection_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`billing_coverage` ADD CONSTRAINT `fk_billing_billing_coverage_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`billing_coverage` ADD CONSTRAINT `fk_billing_billing_coverage_billing_employee_id` FOREIGN KEY (`billing_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_write_employee_id` FOREIGN KEY (`write_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`rac_audit` ADD CONSTRAINT `fk_billing_rac_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`rac_audit` ADD CONSTRAINT `fk_billing_rac_audit_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charity_care_application` ADD CONSTRAINT `fk_billing_charity_care_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charity_care_application` ADD CONSTRAINT `fk_billing_charity_care_application_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`charity_care_application` ADD CONSTRAINT `fk_billing_charity_care_application_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`billing`.`site_cdm_pricing` ADD CONSTRAINT `fk_billing_site_cdm_pricing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);

-- ========= claim --> billing (6 constraint(s)) =========
-- Requires: claim schema, billing schema
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_line` ADD CONSTRAINT `fk_claim_claim_line_charge_id` FOREIGN KEY (`charge_id`) REFERENCES `healthcare_ecm_v1`.`billing`.`charge`(`charge_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_charge_id` FOREIGN KEY (`charge_id`) REFERENCES `healthcare_ecm_v1`.`billing`.`charge`(`charge_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_denial` ADD CONSTRAINT `fk_claim_claim_denial_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `healthcare_ecm_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_appeal` ADD CONSTRAINT `fk_claim_claim_appeal_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `healthcare_ecm_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_billing_coverage_id` FOREIGN KEY (`billing_coverage_id`) REFERENCES `healthcare_ecm_v1`.`billing`.`billing_coverage`(`billing_coverage_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_patient_account_id` FOREIGN KEY (`patient_account_id`) REFERENCES `healthcare_ecm_v1`.`billing`.`patient_account`(`patient_account_id`);

-- ========= claim --> clinical_ai (1 constraint(s)) =========
-- Requires: claim schema, clinical_ai schema
ALTER TABLE `healthcare_ecm_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_clinical_ai_model_inference_log_id` FOREIGN KEY (`clinical_ai_model_inference_log_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log`(`clinical_ai_model_inference_log_id`);

-- ========= claim --> compliance (5 constraint(s)) =========
-- Requires: claim schema, compliance schema
ALTER TABLE `healthcare_ecm_v1`.`claim`.`diagnosis_link` ADD CONSTRAINT `fk_claim_diagnosis_link_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_stark_arrangement_id` FOREIGN KEY (`stark_arrangement_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`stark_arrangement`(`stark_arrangement_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`audit_sample` ADD CONSTRAINT `fk_claim_audit_sample_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`audit`(`audit_id`);

-- ========= claim --> consent (4 constraint(s)) =========
-- Requires: claim schema, consent schema
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_denial` ADD CONSTRAINT `fk_claim_claim_denial_deficiency_id` FOREIGN KEY (`deficiency_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`deficiency`(`deficiency_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_attachment` ADD CONSTRAINT `fk_claim_claim_attachment_behavioral_health_consent_id` FOREIGN KEY (`behavioral_health_consent_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`behavioral_health_consent`(`behavioral_health_consent_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_attachment` ADD CONSTRAINT `fk_claim_claim_attachment_substance_use_consent_id` FOREIGN KEY (`substance_use_consent_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`substance_use_consent`(`substance_use_consent_id`);

-- ========= claim --> digital_health (1 constraint(s)) =========
-- Requires: claim schema, digital_health schema
ALTER TABLE `healthcare_ecm_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_rpm_program_id` FOREIGN KEY (`rpm_program_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`rpm_program`(`rpm_program_id`);

-- ========= claim --> encounter (6 constraint(s)) =========
-- Requires: claim schema, encounter schema
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`diagnosis_link` ADD CONSTRAINT `fk_claim_diagnosis_link_visit_diagnosis_id` FOREIGN KEY (`visit_diagnosis_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit_diagnosis`(`visit_diagnosis_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_denial` ADD CONSTRAINT `fk_claim_claim_denial_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_attachment` ADD CONSTRAINT `fk_claim_claim_attachment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);

-- ========= claim --> facility (6 constraint(s)) =========
-- Requires: claim schema, facility schema
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_line` ADD CONSTRAINT `fk_claim_claim_line_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_denial` ADD CONSTRAINT `fk_claim_claim_denial_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_attachment` ADD CONSTRAINT `fk_claim_claim_attachment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= claim --> finance (15 constraint(s)) =========
-- Requires: claim schema, finance schema
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_ar_account_id` FOREIGN KEY (`ar_account_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`ar_account`(`ar_account_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_finance_journal_entry_id` FOREIGN KEY (`finance_journal_entry_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`finance_journal_entry`(`finance_journal_entry_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_finance_ar_transaction_id` FOREIGN KEY (`finance_ar_transaction_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`finance_ar_transaction`(`finance_ar_transaction_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_finance_journal_entry_id` FOREIGN KEY (`finance_journal_entry_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`finance_journal_entry`(`finance_journal_entry_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_finance_journal_entry_line_id` FOREIGN KEY (`finance_journal_entry_line_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`finance_journal_entry_line`(`finance_journal_entry_line_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_denial` ADD CONSTRAINT `fk_claim_claim_denial_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_denial` ADD CONSTRAINT `fk_claim_claim_denial_finance_ar_transaction_id` FOREIGN KEY (`finance_ar_transaction_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`finance_ar_transaction`(`finance_ar_transaction_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_denial` ADD CONSTRAINT `fk_claim_claim_denial_finance_journal_entry_id` FOREIGN KEY (`finance_journal_entry_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`finance_journal_entry`(`finance_journal_entry_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_appeal` ADD CONSTRAINT `fk_claim_claim_appeal_finance_journal_entry_id` FOREIGN KEY (`finance_journal_entry_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`finance_journal_entry`(`finance_journal_entry_id`);

-- ========= claim --> insurance (20 constraint(s)) =========
-- Requires: claim schema, insurance schema
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_insurance_fee_schedule_id` FOREIGN KEY (`insurance_fee_schedule_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`insurance_fee_schedule`(`insurance_fee_schedule_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_denial` ADD CONSTRAINT `fk_claim_claim_denial_insurance_coverage_policy_id` FOREIGN KEY (`insurance_coverage_policy_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`insurance_coverage_policy`(`insurance_coverage_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_denial` ADD CONSTRAINT `fk_claim_claim_denial_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_appeal` ADD CONSTRAINT `fk_claim_claim_appeal_insurance_coverage_policy_id` FOREIGN KEY (`insurance_coverage_policy_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`insurance_coverage_policy`(`insurance_coverage_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_appeal` ADD CONSTRAINT `fk_claim_claim_appeal_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_tertiary_payer_id` FOREIGN KEY (`tertiary_payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`authorization_service` ADD CONSTRAINT `fk_claim_authorization_service_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_attachment` ADD CONSTRAINT `fk_claim_claim_attachment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);

-- ========= claim --> interoperability (11 constraint(s)) =========
-- Requires: claim schema, interoperability schema
ALTER TABLE `healthcare_ecm_v1`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_fhir_resource_log_id` FOREIGN KEY (`fhir_resource_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`fhir_resource_log`(`fhir_resource_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_hie_query_id` FOREIGN KEY (`hie_query_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`hie_query`(`hie_query_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_attachment` ADD CONSTRAINT `fk_claim_claim_attachment_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`cda_document`(`cda_document_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_attachment` ADD CONSTRAINT `fk_claim_claim_attachment_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_attachment` ADD CONSTRAINT `fk_claim_claim_attachment_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);

-- ========= claim --> order (5 constraint(s)) =========
-- Requires: claim schema, order schema
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_referral_order_id` FOREIGN KEY (`referral_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`referral_order`(`referral_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_line` ADD CONSTRAINT `fk_claim_claim_line_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_line` ADD CONSTRAINT `fk_claim_claim_line_fulfillment_id` FOREIGN KEY (`fulfillment_id`) REFERENCES `healthcare_ecm_v1`.`order`.`fulfillment`(`fulfillment_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_order_authorization_id` FOREIGN KEY (`order_authorization_id`) REFERENCES `healthcare_ecm_v1`.`order`.`order_authorization`(`order_authorization_id`);

-- ========= claim --> patient (14 constraint(s)) =========
-- Requires: claim schema, patient schema
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_claim_mpi_record_id` FOREIGN KEY (`claim_mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_guarantor_id` FOREIGN KEY (`guarantor_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`guarantor`(`guarantor_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_denial` ADD CONSTRAINT `fk_claim_claim_denial_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_appeal` ADD CONSTRAINT `fk_claim_claim_appeal_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_eligibility_mpi_record_id` FOREIGN KEY (`eligibility_mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_attachment` ADD CONSTRAINT `fk_claim_claim_attachment_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);

-- ========= claim --> post_acute_care (2 constraint(s)) =========
-- Requires: claim schema, post_acute_care schema
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_line` ADD CONSTRAINT `fk_claim_claim_line_service_delivery_id` FOREIGN KEY (`service_delivery_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`service_delivery`(`service_delivery_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);

-- ========= claim --> provider (15 constraint(s)) =========
-- Requires: claim schema, provider schema
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_claim_referring_clinician_id` FOREIGN KEY (`claim_referring_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_claim_rendering_provider_clinician_id` FOREIGN KEY (`claim_rendering_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_referring_clinician_id` FOREIGN KEY (`referring_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_line` ADD CONSTRAINT `fk_claim_claim_line_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`submission` ADD CONSTRAINT `fk_claim_submission_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_denial` ADD CONSTRAINT `fk_claim_claim_denial_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`authorization_service` ADD CONSTRAINT `fk_claim_authorization_service_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`authorization_service` ADD CONSTRAINT `fk_claim_authorization_service_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_attachment` ADD CONSTRAINT `fk_claim_claim_attachment_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_attachment` ADD CONSTRAINT `fk_claim_claim_attachment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= claim --> quality (3 constraint(s)) =========
-- Requires: claim schema, quality schema
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`hedis_measure`(`hedis_measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_denial` ADD CONSTRAINT `fk_claim_claim_denial_quality_peer_review_id` FOREIGN KEY (`quality_peer_review_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`quality_peer_review`(`quality_peer_review_id`);

-- ========= claim --> reference (13 constraint(s)) =========
-- Requires: claim schema, reference schema
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_line` ADD CONSTRAINT `fk_claim_claim_line_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_line` ADD CONSTRAINT `fk_claim_claim_line_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_line` ADD CONSTRAINT `fk_claim_claim_line_revenue_code_id` FOREIGN KEY (`revenue_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`diagnosis_link` ADD CONSTRAINT `fk_claim_diagnosis_link_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`authorization_service` ADD CONSTRAINT `fk_claim_authorization_service_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`authorization_service` ADD CONSTRAINT `fk_claim_authorization_service_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_attachment` ADD CONSTRAINT `fk_claim_claim_attachment_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_attachment` ADD CONSTRAINT `fk_claim_claim_attachment_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);

-- ========= claim --> research (2 constraint(s)) =========
-- Requires: claim schema, research schema
ALTER TABLE `healthcare_ecm_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`study_attribution` ADD CONSTRAINT `fk_claim_study_attribution_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);

-- ========= claim --> supply (3 constraint(s)) =========
-- Requires: claim schema, supply schema
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_line` ADD CONSTRAINT `fk_claim_claim_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`prior_authorization` ADD CONSTRAINT `fk_claim_prior_authorization_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);

-- ========= claim --> workforce (9 constraint(s)) =========
-- Requires: claim schema, workforce schema
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim` ADD CONSTRAINT `fk_claim_claim_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`status_history` ADD CONSTRAINT `fk_claim_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`remittance` ADD CONSTRAINT `fk_claim_remittance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`remittance_line` ADD CONSTRAINT `fk_claim_remittance_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_denial` ADD CONSTRAINT `fk_claim_claim_denial_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_appeal` ADD CONSTRAINT `fk_claim_claim_appeal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_appeal` ADD CONSTRAINT `fk_claim_claim_appeal_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`eligibility` ADD CONSTRAINT `fk_claim_eligibility_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`claim`.`claim_attachment` ADD CONSTRAINT `fk_claim_claim_attachment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);

-- ========= clinical --> billing (2 constraint(s)) =========
-- Requires: clinical schema, billing schema
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `healthcare_ecm_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `healthcare_ecm_v1`.`billing`.`invoice`(`invoice_id`);

-- ========= clinical --> claim (4 constraint(s)) =========
-- Requires: clinical schema, claim schema
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_claim_attachment_id` FOREIGN KEY (`claim_attachment_id`) REFERENCES `healthcare_ecm_v1`.`claim`.`claim_attachment`(`claim_attachment_id`);

-- ========= clinical --> clinical_ai (2 constraint(s)) =========
-- Requires: clinical schema, clinical_ai schema
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_clinical_ai_clinical_nlp_result_id` FOREIGN KEY (`clinical_ai_clinical_nlp_result_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result`(`clinical_ai_clinical_nlp_result_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_clinical_ai_patient_risk_score_id` FOREIGN KEY (`clinical_ai_patient_risk_score_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score`(`clinical_ai_patient_risk_score_id`);

-- ========= clinical --> compliance (5 constraint(s)) =========
-- Requires: clinical schema, compliance schema
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);

-- ========= clinical --> consent (11 constraint(s)) =========
-- Requires: clinical schema, consent schema
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);

-- ========= clinical --> digital_health (1 constraint(s)) =========
-- Requires: clinical schema, digital_health schema
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_prom_response_id` FOREIGN KEY (`prom_response_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`prom_response`(`prom_response_id`);

-- ========= clinical --> encounter (21 constraint(s)) =========
-- Requires: clinical schema, encounter schema
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_problem_visit_id` FOREIGN KEY (`problem_visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_onset_encounter_visit_id` FOREIGN KEY (`onset_encounter_visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);

-- ========= clinical --> facility (27 constraint(s)) =========
-- Requires: clinical schema, facility schema
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_immunization_care_site_id` FOREIGN KEY (`immunization_care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_administered_location_care_site_id` FOREIGN KEY (`administered_location_care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_device_equipment_asset_id` FOREIGN KEY (`device_equipment_asset_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_bed_id` FOREIGN KEY (`bed_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`bed`(`bed_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_bed_id` FOREIGN KEY (`bed_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`bed`(`bed_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`procedure_equipment_usage` ADD CONSTRAINT `fk_clinical_procedure_equipment_usage_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`outbreak` ADD CONSTRAINT `fk_clinical_outbreak_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`flowsheet_template` ADD CONSTRAINT `fk_clinical_flowsheet_template_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= clinical --> finance (2 constraint(s)) =========
-- Requires: clinical schema, finance schema
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= clinical --> genomics (1 constraint(s)) =========
-- Requires: clinical schema, genomics schema
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_genomic_test_result_id` FOREIGN KEY (`genomic_test_result_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_test_result`(`genomic_test_result_id`);

-- ========= clinical --> insurance (5 constraint(s)) =========
-- Requires: clinical schema, insurance schema
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`plan_care_coordination` ADD CONSTRAINT `fk_clinical_plan_care_coordination_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`health_plan`(`health_plan_id`);

-- ========= clinical --> interoperability (2 constraint(s)) =========
-- Requires: clinical schema, interoperability schema
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_public_health_report_id` FOREIGN KEY (`public_health_report_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`public_health_report`(`public_health_report_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`outbreak` ADD CONSTRAINT `fk_clinical_outbreak_public_health_report_id` FOREIGN KEY (`public_health_report_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`public_health_report`(`public_health_report_id`);

-- ========= clinical --> laboratory (10 constraint(s)) =========
-- Requires: clinical schema, laboratory schema
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_laboratory_test_result_id` FOREIGN KEY (`laboratory_test_result_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`laboratory_test_result`(`laboratory_test_result_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_laboratory_test_result_id` FOREIGN KEY (`laboratory_test_result_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`laboratory_test_result`(`laboratory_test_result_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_laboratory_test_result_id` FOREIGN KEY (`laboratory_test_result_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`laboratory_test_result`(`laboratory_test_result_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_laboratory_test_result_id` FOREIGN KEY (`laboratory_test_result_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`laboratory_test_result`(`laboratory_test_result_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_laboratory_test_result_id` FOREIGN KEY (`laboratory_test_result_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`laboratory_test_result`(`laboratory_test_result_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_microbiology_culture_id` FOREIGN KEY (`microbiology_culture_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`microbiology_culture`(`microbiology_culture_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_susceptibility_result_id` FOREIGN KEY (`susceptibility_result_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`susceptibility_result`(`susceptibility_result_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_laboratory_test_result_id` FOREIGN KEY (`laboratory_test_result_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`laboratory_test_result`(`laboratory_test_result_id`);

-- ========= clinical --> order (18 constraint(s)) =========
-- Requires: clinical schema, order schema
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_procedure_clinical_order_id` FOREIGN KEY (`procedure_clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_cpoe_alert_id` FOREIGN KEY (`cpoe_alert_id`) REFERENCES `healthcare_ecm_v1`.`order`.`cpoe_alert`(`cpoe_alert_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_order_set_id` FOREIGN KEY (`order_set_id`) REFERENCES `healthcare_ecm_v1`.`order`.`order_order_set`(`order_set_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_advance_clinical_order_id` FOREIGN KEY (`advance_clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_diet_order_id` FOREIGN KEY (`diet_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`diet_order`(`diet_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= clinical --> patient (26 constraint(s)) =========
-- Requires: clinical schema, patient schema
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_procedure_patient_mpi_record_id` FOREIGN KEY (`procedure_patient_mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_problem_patient_mpi_record_id` FOREIGN KEY (`problem_patient_mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_care_mpi_record_id` FOREIGN KEY (`care_mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);

-- ========= clinical --> pharmacy (8 constraint(s)) =========
-- Requires: clinical schema, pharmacy schema
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `healthcare_ecm_v1`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_mar_record_id` FOREIGN KEY (`mar_record_id`) REFERENCES `healthcare_ecm_v1`.`pharmacy`.`mar_record`(`mar_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_medication_therapy_mgmt_id` FOREIGN KEY (`medication_therapy_mgmt_id`) REFERENCES `healthcare_ecm_v1`.`pharmacy`.`medication_therapy_mgmt`(`medication_therapy_mgmt_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_mar_record_id` FOREIGN KEY (`mar_record_id`) REFERENCES `healthcare_ecm_v1`.`pharmacy`.`mar_record`(`mar_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm_v1`.`pharmacy`.`drug_master`(`drug_master_id`);

-- ========= clinical --> provider (31 constraint(s)) =========
-- Requires: clinical schema, provider schema
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_tertiary_procedure_anesthesia_provider_clinician_id` FOREIGN KEY (`tertiary_procedure_anesthesia_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_anesthesia_clinician_id` FOREIGN KEY (`anesthesia_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_primary_note_attending_provider_clinician_id` FOREIGN KEY (`primary_note_attending_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_tertiary_note_cosigner_provider_clinician_id` FOREIGN KEY (`tertiary_note_cosigner_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_cosigner_clinician_id` FOREIGN KEY (`cosigner_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_tertiary_problem_last_updated_by_provider_clinician_id` FOREIGN KEY (`tertiary_problem_last_updated_by_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_tertiary_immunization_ordering_provider_clinician_id` FOREIGN KEY (`tertiary_immunization_ordering_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_tertiary_care_pcp_clinician_id` FOREIGN KEY (`tertiary_care_pcp_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_tertiary_care_member_provider_clinician_id` FOREIGN KEY (`tertiary_care_member_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`procedure_equipment_usage` ADD CONSTRAINT `fk_clinical_procedure_equipment_usage_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`plan_care_coordination` ADD CONSTRAINT `fk_clinical_plan_care_coordination_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`flowsheet_row` ADD CONSTRAINT `fk_clinical_flowsheet_row_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`specialty`(`specialty_id`);

-- ========= clinical --> quality (14 constraint(s)) =========
-- Requires: clinical schema, quality schema
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`hedis_measure`(`hedis_measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_improvement_initiative_id` FOREIGN KEY (`improvement_initiative_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`improvement_initiative`(`improvement_initiative_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_improvement_initiative_id` FOREIGN KEY (`improvement_initiative_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`improvement_initiative`(`improvement_initiative_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`nursing_assessment` ADD CONSTRAINT `fk_clinical_nursing_assessment_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`patient_safety_event`(`patient_safety_event_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_improvement_initiative_id` FOREIGN KEY (`improvement_initiative_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`improvement_initiative`(`improvement_initiative_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`patient_safety_event`(`patient_safety_event_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);

-- ========= clinical --> radiology (4 constraint(s)) =========
-- Requires: clinical schema, radiology schema
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `healthcare_ecm_v1`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `healthcare_ecm_v1`.`radiology`.`imaging_order`(`imaging_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_report_id` FOREIGN KEY (`report_id`) REFERENCES `healthcare_ecm_v1`.`radiology`.`report`(`report_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_imaging_order_id` FOREIGN KEY (`imaging_order_id`) REFERENCES `healthcare_ecm_v1`.`radiology`.`imaging_order`(`imaging_order_id`);

-- ========= clinical --> reference (29 constraint(s)) =========
-- Requires: clinical schema, reference schema
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`problem` ADD CONSTRAINT `fk_clinical_problem_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`vital_sign` ADD CONSTRAINT `fk_clinical_vital_sign_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`observation` ADD CONSTRAINT `fk_clinical_observation_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`clinical_finding` ADD CONSTRAINT `fk_clinical_clinical_finding_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`flowsheet_row` ADD CONSTRAINT `fk_clinical_flowsheet_row_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`loinc_code`(`loinc_code_id`);

-- ========= clinical --> supply (8 constraint(s)) =========
-- Requires: clinical schema, supply schema
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`procedure_event` ADD CONSTRAINT `fk_clinical_procedure_event_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`allergy` ADD CONSTRAINT `fk_clinical_allergy_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`immunization` ADD CONSTRAINT `fk_clinical_immunization_immunization_supply_lot_number_material_master_id` FOREIGN KEY (`immunization_supply_lot_number_material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_plan` ADD CONSTRAINT `fk_clinical_care_plan_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_plan_goal` ADD CONSTRAINT `fk_clinical_care_plan_goal_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`functional_status` ADD CONSTRAINT `fk_clinical_functional_status_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`hai_event` ADD CONSTRAINT `fk_clinical_hai_event_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);

-- ========= clinical --> workforce (19 constraint(s)) =========
-- Requires: clinical schema, workforce schema
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`diagnosis` ADD CONSTRAINT `fk_clinical_diagnosis_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`note` ADD CONSTRAINT `fk_clinical_note_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_team` ADD CONSTRAINT `fk_clinical_care_team_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`care_team_member` ADD CONSTRAINT `fk_clinical_care_team_member_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`cdi_query` ADD CONSTRAINT `fk_clinical_cdi_query_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`cdi_worksheet` ADD CONSTRAINT `fk_clinical_cdi_worksheet_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`advance_directive` ADD CONSTRAINT `fk_clinical_advance_directive_witness_employee_id` FOREIGN KEY (`witness_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`note_template` ADD CONSTRAINT `fk_clinical_note_template_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`note_template` ADD CONSTRAINT `fk_clinical_note_template_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`outbreak` ADD CONSTRAINT `fk_clinical_outbreak_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`flowsheet_template` ADD CONSTRAINT `fk_clinical_flowsheet_template_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`flowsheet_template` ADD CONSTRAINT `fk_clinical_flowsheet_template_flowsheet_employee_id` FOREIGN KEY (`flowsheet_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`flowsheet_template` ADD CONSTRAINT `fk_clinical_flowsheet_template_flowsheet_workforce_employee_id` FOREIGN KEY (`flowsheet_workforce_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`flowsheet_template` ADD CONSTRAINT `fk_clinical_flowsheet_template_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`flowsheet_template` ADD CONSTRAINT `fk_clinical_flowsheet_template_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`flowsheet_template` ADD CONSTRAINT `fk_clinical_flowsheet_template_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical`.`flowsheet_template` ADD CONSTRAINT `fk_clinical_flowsheet_template_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);

-- ========= clinical_ai --> claim (1 constraint(s)) =========
-- Requires: clinical_ai schema, claim schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_model_inference_log_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm_v1`.`claim`.`claim`(`claim_id`);

-- ========= clinical_ai --> clinical (10 constraint(s)) =========
-- Requires: clinical_ai schema, clinical schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ADD CONSTRAINT `fk_clinical_ai_clinical_nlp_result_note_id` FOREIGN KEY (`note_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`note`(`note_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_clinical_nlp_result_clinical_finding_id` FOREIGN KEY (`clinical_finding_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`clinical_finding`(`clinical_finding_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_clinical_nlp_result_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_clinical_nlp_result_note_id` FOREIGN KEY (`note_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`note`(`note_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_clinical_nlp_result_problem_id` FOREIGN KEY (`problem_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`problem`(`problem_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_clinical_nlp_result_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`observation`(`observation_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_care_gap_care_plan_goal_id` FOREIGN KEY (`care_plan_goal_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`care_plan_goal`(`care_plan_goal_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_care_gap_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_care_gap_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`observation`(`observation_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_care_gap_problem_id` FOREIGN KEY (`problem_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`problem`(`problem_id`);

-- ========= clinical_ai --> clinical_trial_matching (2 constraint(s)) =========
-- Requires: clinical_ai schema, clinical_trial_matching schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_trial_eligibility_criteria` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_trial_eligibility_criteria_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`trial`(`trial_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`criteria_match_evaluation` ADD CONSTRAINT `fk_clinical_ai_criteria_match_evaluation_eligibility_criteria_id` FOREIGN KEY (`eligibility_criteria_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_criteria`(`eligibility_criteria_id`);

-- ========= clinical_ai --> compliance (3 constraint(s)) =========
-- Requires: clinical_ai schema, compliance schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_model_card_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_fda_samd_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`governance` ADD CONSTRAINT `fk_clinical_ai_governance_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_program`(`compliance_program_id`);

-- ========= clinical_ai --> consent (4 constraint(s)) =========
-- Requires: clinical_ai schema, consent schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_health_cohort_definition` ADD CONSTRAINT `fk_clinical_ai_population_health_cohort_definition_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`governance` ADD CONSTRAINT `fk_clinical_ai_governance_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_cohort_membership` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_cohort_membership_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ADD CONSTRAINT `fk_clinical_ai_ai_cohort_membership_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);

-- ========= clinical_ai --> databricks_governance (18 constraint(s)) =========
-- Requires: clinical_ai schema, databricks_governance schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_model_card_databricks_governance_delta_tblproperties4_id` FOREIGN KEY (`databricks_governance_delta_tblproperties4_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_delta_tblproperties4`(`databricks_governance_delta_tblproperties4_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_model_card_databricks_governance_rls_predicates_id` FOREIGN KEY (`databricks_governance_rls_predicates_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_rls_predicates`(`databricks_governance_rls_predicates_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_model_card_databricks_governance_uc_tag_definitions_id` FOREIGN KEY (`databricks_governance_uc_tag_definitions_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_uc_tag_definitions`(`databricks_governance_uc_tag_definitions_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_model_card_hipaa_retention_annotation_id` FOREIGN KEY (`hipaa_retention_annotation_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention_annotation`(`hipaa_retention_annotation_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_model_card_rls_predicate_id` FOREIGN KEY (`rls_predicate_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`rls_predicate`(`rls_predicate_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_model_card_scd_configuration_id` FOREIGN KEY (`scd_configuration_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`scd_configuration`(`scd_configuration_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_model_card_scd_type2_config_id` FOREIGN KEY (`scd_type2_config_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`scd_type2_config`(`scd_type2_config_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_fda_samd_databricks_governance_hipaa_retention_annotations_id` FOREIGN KEY (`databricks_governance_hipaa_retention_annotations_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_hipaa_retention_annotations`(`databricks_governance_hipaa_retention_annotations_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`governance` ADD CONSTRAINT `fk_clinical_ai_governance_hipaa_retention_annotation_id` FOREIGN KEY (`hipaa_retention_annotation_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention_annotation`(`hipaa_retention_annotation_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`governance` ADD CONSTRAINT `fk_clinical_ai_governance_rls_predicate_id` FOREIGN KEY (`rls_predicate_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`rls_predicate`(`rls_predicate_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_feature_store_entity_databricks_governance_delta_tblproperties4_id` FOREIGN KEY (`databricks_governance_delta_tblproperties4_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_delta_tblproperties4`(`databricks_governance_delta_tblproperties4_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_feature_store_entity_databricks_governance_rls_predicates_id` FOREIGN KEY (`databricks_governance_rls_predicates_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_rls_predicates`(`databricks_governance_rls_predicates_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_feature_store_entity_databricks_governance_uc_tag_definitions_id` FOREIGN KEY (`databricks_governance_uc_tag_definitions_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_uc_tag_definitions`(`databricks_governance_uc_tag_definitions_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_feature_store_entity_hipaa_retention_annotation_id` FOREIGN KEY (`hipaa_retention_annotation_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention_annotation`(`hipaa_retention_annotation_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_feature_store_entity_liquid_clustering_config_id` FOREIGN KEY (`liquid_clustering_config_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`liquid_clustering_config`(`liquid_clustering_config_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_feature_store_entity` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_feature_store_entity_rls_predicate_id` FOREIGN KEY (`rls_predicate_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`rls_predicate`(`rls_predicate_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_tag_assignment` ADD CONSTRAINT `fk_clinical_ai_model_tag_assignment_uc_tag_definition_id` FOREIGN KEY (`uc_tag_definition_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`uc_tag_definition`(`uc_tag_definition_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`feature_tag_application` ADD CONSTRAINT `fk_clinical_ai_feature_tag_application_uc_tag_definition_id` FOREIGN KEY (`uc_tag_definition_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`uc_tag_definition`(`uc_tag_definition_id`);

-- ========= clinical_ai --> digital_health (1 constraint(s)) =========
-- Requires: clinical_ai schema, digital_health schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_care_gap_rpm_program_id` FOREIGN KEY (`rpm_program_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`rpm_program`(`rpm_program_id`);

-- ========= clinical_ai --> encounter (9 constraint(s)) =========
-- Requires: clinical_ai schema, encounter schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`patient_risk_score` ADD CONSTRAINT `fk_clinical_ai_patient_risk_score_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ADD CONSTRAINT `fk_clinical_ai_clinical_nlp_result_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`care_gap` ADD CONSTRAINT `fk_clinical_ai_care_gap_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ADD CONSTRAINT `fk_clinical_ai_model_inference_log_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_cohort_membership` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_cohort_membership_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_patient_risk_score_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_clinical_nlp_result_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_model_inference_log_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`trial_eligibility_evaluation` ADD CONSTRAINT `fk_clinical_ai_trial_eligibility_evaluation_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);

-- ========= clinical_ai --> facility (18 constraint(s)) =========
-- Requires: clinical_ai schema, facility schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`patient_risk_score` ADD CONSTRAINT `fk_clinical_ai_patient_risk_score_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`care_gap` ADD CONSTRAINT `fk_clinical_ai_care_gap_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ADD CONSTRAINT `fk_clinical_ai_model_inference_log_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_health_cohort_definition` ADD CONSTRAINT `fk_clinical_ai_population_health_cohort_definition_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_membership` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_population_health_cohort_membership_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_bias_monitoring` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_bias_monitoring_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`cohort_management` ADD CONSTRAINT `fk_clinical_ai_cohort_management_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_patient_risk_score_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_care_gap_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_model_inference_log_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_cohort_definition` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_cohort_definition_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_membership` ADD CONSTRAINT `fk_clinical_ai_population_cohort_membership_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_management` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_population_health_cohort_management_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_mgmt` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_population_health_cohort_mgmt_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_trial_eligibility_criteria` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_trial_eligibility_criteria_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`organization`(`organization_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`trial_eligibility_evaluation` ADD CONSTRAINT `fk_clinical_ai_trial_eligibility_evaluation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_population_health_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort` ADD CONSTRAINT `fk_clinical_ai_population_cohort_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= clinical_ai --> finance (2 constraint(s)) =========
-- Requires: clinical_ai schema, finance schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_model_card_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ADD CONSTRAINT `fk_clinical_ai_model_training_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= clinical_ai --> genomics (4 constraint(s)) =========
-- Requires: clinical_ai schema, genomics schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_patient_risk_score_genomic_test_result_id` FOREIGN KEY (`genomic_test_result_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_test_result`(`genomic_test_result_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_patient_risk_score_genomics_patient_genomic_profile_id` FOREIGN KEY (`genomics_patient_genomic_profile_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile`(`genomics_patient_genomic_profile_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_care_gap_genomics_patient_genomic_profile_id` FOREIGN KEY (`genomics_patient_genomic_profile_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile`(`genomics_patient_genomic_profile_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_model_inference_log_genomics_patient_genomic_profile_id` FOREIGN KEY (`genomics_patient_genomic_profile_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile`(`genomics_patient_genomic_profile_id`);

-- ========= clinical_ai --> insurance (5 constraint(s)) =========
-- Requires: clinical_ai schema, insurance schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`care_gap` ADD CONSTRAINT `fk_clinical_ai_care_gap_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_health_cohort_definition` ADD CONSTRAINT `fk_clinical_ai_population_health_cohort_definition_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_care_gap_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_membership` ADD CONSTRAINT `fk_clinical_ai_population_cohort_membership_insurance_accountable_care_organization_id` FOREIGN KEY (`insurance_accountable_care_organization_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`insurance_accountable_care_organization`(`insurance_accountable_care_organization_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_membership` ADD CONSTRAINT `fk_clinical_ai_population_cohort_membership_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);

-- ========= clinical_ai --> interoperability (2 constraint(s)) =========
-- Requires: clinical_ai schema, interoperability schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_fda_samd_exchange_standard_id` FOREIGN KEY (`exchange_standard_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`exchange_standard`(`exchange_standard_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_clinical_nlp_result_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`cda_document`(`cda_document_id`);

-- ========= clinical_ai --> laboratory (3 constraint(s)) =========
-- Requires: clinical_ai schema, laboratory schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_clinical_nlp_result_pathology_report_id` FOREIGN KEY (`pathology_report_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`pathology_report`(`pathology_report_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_care_gap_laboratory_test_result_id` FOREIGN KEY (`laboratory_test_result_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`laboratory_test_result`(`laboratory_test_result_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_care_gap_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);

-- ========= clinical_ai --> order (2 constraint(s)) =========
-- Requires: clinical_ai schema, order schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_care_gap_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_model_inference_log_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= clinical_ai --> patient (21 constraint(s)) =========
-- Requires: clinical_ai schema, patient schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`patient_risk_score` ADD CONSTRAINT `fk_clinical_ai_patient_risk_score_care_program_id` FOREIGN KEY (`care_program_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`care_program`(`care_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`patient_risk_score` ADD CONSTRAINT `fk_clinical_ai_patient_risk_score_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ADD CONSTRAINT `fk_clinical_ai_clinical_nlp_result_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`care_gap` ADD CONSTRAINT `fk_clinical_ai_care_gap_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ADD CONSTRAINT `fk_clinical_ai_model_inference_log_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_membership` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_population_health_cohort_membership_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_membership` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_population_health_cohort_membership_population_mpi_record_id` FOREIGN KEY (`population_mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_fda_samd_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_cohort_membership` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_cohort_membership_care_program_id` FOREIGN KEY (`care_program_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`care_program`(`care_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_cohort_membership` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_cohort_membership_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_patient_risk_score_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_clinical_nlp_result_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_care_gap_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_model_inference_log_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership` ADD CONSTRAINT `fk_clinical_ai_ai_cohort_membership_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_definition` ADD CONSTRAINT `fk_clinical_ai_population_cohort_definition_care_program_id` FOREIGN KEY (`care_program_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`care_program`(`care_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_membership` ADD CONSTRAINT `fk_clinical_ai_population_cohort_membership_care_program_id` FOREIGN KEY (`care_program_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`care_program`(`care_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_membership` ADD CONSTRAINT `fk_clinical_ai_population_cohort_membership_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_management` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_population_health_cohort_management_care_program_id` FOREIGN KEY (`care_program_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`care_program`(`care_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`trial_eligibility_evaluation` ADD CONSTRAINT `fk_clinical_ai_trial_eligibility_evaluation_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_population_health_care_program_id` FOREIGN KEY (`care_program_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`care_program`(`care_program_id`);

-- ========= clinical_ai --> population_health (1 constraint(s)) =========
-- Requires: clinical_ai schema, population_health schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_care_gap_population_health_dynamic_cohort_definition_id` FOREIGN KEY (`population_health_dynamic_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`population_health`.`population_health_dynamic_cohort_definition`(`population_health_dynamic_cohort_definition_id`);

-- ========= clinical_ai --> population_health_cohort (1 constraint(s)) =========
-- Requires: clinical_ai schema, population_health_cohort schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`cohort_management` ADD CONSTRAINT `fk_clinical_ai_cohort_management_population_health_cohort_cohort_definition_id` FOREIGN KEY (`population_health_cohort_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_definition`(`population_health_cohort_cohort_definition_id`);

-- ========= clinical_ai --> provider (28 constraint(s)) =========
-- Requires: clinical_ai schema, provider schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`patient_risk_score` ADD CONSTRAINT `fk_clinical_ai_patient_risk_score_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`patient_risk_score` ADD CONSTRAINT `fk_clinical_ai_patient_risk_score_patient_reviewed_by_provider_clinician_id` FOREIGN KEY (`patient_reviewed_by_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ADD CONSTRAINT `fk_clinical_ai_clinical_nlp_result_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_nlp_result` ADD CONSTRAINT `fk_clinical_ai_clinical_nlp_result_clinical_validated_by_provider_clinician_id` FOREIGN KEY (`clinical_validated_by_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`care_gap` ADD CONSTRAINT `fk_clinical_ai_care_gap_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_inference_log` ADD CONSTRAINT `fk_clinical_ai_model_inference_log_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_health_cohort_definition` ADD CONSTRAINT `fk_clinical_ai_population_health_cohort_definition_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_membership` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_population_health_cohort_membership_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_model_card_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_population_health_cohort_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`governance` ADD CONSTRAINT `fk_clinical_ai_governance_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_cohort_membership` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_cohort_membership_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_cohort_membership` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_cohort_membership_clinical_override_provider_clinician_id` FOREIGN KEY (`clinical_override_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_clinical_nlp_result_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_care_gap_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_cohort_definition` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_cohort_definition_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_cohort_definition` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_cohort_definition_clinical_clinician_id` FOREIGN KEY (`clinical_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_definition` ADD CONSTRAINT `fk_clinical_ai_population_cohort_definition_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_membership` ADD CONSTRAINT `fk_clinical_ai_population_cohort_membership_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_membership` ADD CONSTRAINT `fk_clinical_ai_population_cohort_membership_population_pcp_provider_clinician_id` FOREIGN KEY (`population_pcp_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_management` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_population_health_cohort_management_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_management` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_population_health_cohort_management_clinical_clinician_id` FOREIGN KEY (`clinical_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_mgmt` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_population_health_cohort_mgmt_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_ai_governance` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_clinical_ai_governance_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`trial_eligibility_evaluation` ADD CONSTRAINT `fk_clinical_ai_trial_eligibility_evaluation_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`trial_eligibility_evaluation` ADD CONSTRAINT `fk_clinical_ai_trial_eligibility_evaluation_trial_clinician_id` FOREIGN KEY (`trial_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_population_health_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort` ADD CONSTRAINT `fk_clinical_ai_population_cohort_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= clinical_ai --> quality (13 constraint(s)) =========
-- Requires: clinical_ai schema, quality schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`care_gap` ADD CONSTRAINT `fk_clinical_ai_care_gap_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_health_cohort_definition` ADD CONSTRAINT `fk_clinical_ai_population_health_cohort_definition_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`cohort_management` ADD CONSTRAINT `fk_clinical_ai_cohort_management_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`cohort_management` ADD CONSTRAINT `fk_clinical_ai_cohort_management_vbp_program_id` FOREIGN KEY (`vbp_program_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`vbp_program`(`vbp_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_population_health_cohort_measure_set_id` FOREIGN KEY (`measure_set_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure_set`(`measure_set_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_population_health_cohort_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_cohort_definition` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_cohort_definition_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort_definition` ADD CONSTRAINT `fk_clinical_ai_population_cohort_definition_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_management` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_population_health_cohort_management_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health_cohort_mgmt` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_population_health_cohort_mgmt_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_dynamic_cohort_definition` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_dynamic_cohort_definition_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_population_health` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_population_health_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_cohort` ADD CONSTRAINT `fk_clinical_ai_population_cohort_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);

-- ========= clinical_ai --> radiology (3 constraint(s)) =========
-- Requires: clinical_ai schema, radiology schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_clinical_nlp_result_report_id` FOREIGN KEY (`report_id`) REFERENCES `healthcare_ecm_v1`.`radiology`.`report`(`report_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_care_gap_follow_up_id` FOREIGN KEY (`follow_up_id`) REFERENCES `healthcare_ecm_v1`.`radiology`.`follow_up`(`follow_up_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_model_inference_log_report_id` FOREIGN KEY (`report_id`) REFERENCES `healthcare_ecm_v1`.`radiology`.`report`(`report_id`);

-- ========= clinical_ai --> reference (6 constraint(s)) =========
-- Requires: clinical_ai schema, reference schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_model_card_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_fda_samd_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_clinical_nlp_result_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_care_gap_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_care_gap_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_trial_eligibility_criteria` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_trial_eligibility_criteria_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);

-- ========= clinical_ai --> research (1 constraint(s)) =========
-- Requires: clinical_ai schema, research schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`trial_eligibility_evaluation` ADD CONSTRAINT `fk_clinical_ai_trial_eligibility_evaluation_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);

-- ========= clinical_ai --> research_clinical_trial_matching (1 constraint(s)) =========
-- Requires: clinical_ai schema, research_clinical_trial_matching schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`population_health_cohort_definition` ADD CONSTRAINT `fk_clinical_ai_population_health_cohort_definition_research_clinical_trial_matching_eligibility_criteria_id` FOREIGN KEY (`research_clinical_trial_matching_eligibility_criteria_id`) REFERENCES `healthcare_ecm_v1`.`research_clinical_trial_matching`.`research_clinical_trial_matching_eligibility_criteria`(`research_clinical_trial_matching_eligibility_criteria_id`);

-- ========= clinical_ai --> supply (1 constraint(s)) =========
-- Requires: clinical_ai schema, supply schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_fda_samd` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_fda_samd_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`vendor`(`vendor_id`);

-- ========= clinical_ai --> workforce (15 constraint(s)) =========
-- Requires: clinical_ai schema, workforce schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_model_card_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`cohort_management` ADD CONSTRAINT `fk_clinical_ai_cohort_management_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`governance` ADD CONSTRAINT `fk_clinical_ai_governance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_care_gap_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ADD CONSTRAINT `fk_clinical_ai_ai_cohort_definition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition` ADD CONSTRAINT `fk_clinical_ai_ai_cohort_definition_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ADD CONSTRAINT `fk_clinical_ai_model_version_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_version` ADD CONSTRAINT `fk_clinical_ai_model_version_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`model_training_run` ADD CONSTRAINT `fk_clinical_ai_model_training_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_ai_governance` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_clinical_ai_governance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_ai_governance` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_clinical_ai_governance_clinical_responsible_data_scientist_employee_id` FOREIGN KEY (`clinical_responsible_data_scientist_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_trial_eligibility_criteria` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_trial_eligibility_criteria_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_trial_eligibility_criteria` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_trial_eligibility_criteria_clinical_employee_id` FOREIGN KEY (`clinical_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_dynamic_cohort_definition` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_dynamic_cohort_definition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_dynamic_cohort_definition` ADD CONSTRAINT `fk_clinical_ai_clinical_ai_dynamic_cohort_definition_clinical_employee_id` FOREIGN KEY (`clinical_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);

-- ========= clinical_ai_governance --> clinical_ai (3 constraint(s)) =========
-- Requires: clinical_ai_governance schema, clinical_ai schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai_governance`.`clinical_ai_governance_model_card` ADD CONSTRAINT `fk_clinical_ai_governance_clinical_ai_governance_model_card_model_version_id` FOREIGN KEY (`model_version_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`model_version`(`model_version_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai_governance`.`clinical_ai_governance_bias_monitoring` ADD CONSTRAINT `fk_clinical_ai_governance_clinical_ai_governance_bias_monitoring_model_version_id` FOREIGN KEY (`model_version_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`model_version`(`model_version_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_ai_governance`.`clinical_ai_governance_fda_samd` ADD CONSTRAINT `fk_clinical_ai_governance_clinical_ai_governance_fda_samd_model_version_id` FOREIGN KEY (`model_version_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`model_version`(`model_version_id`);

-- ========= clinical_trial_matching --> clinical_ai (4 constraint(s)) =========
-- Requires: clinical_trial_matching schema, clinical_ai schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility` ADD CONSTRAINT `fk_clinical_trial_matching_patient_eligibility_clinical_ai_patient_risk_score_id` FOREIGN KEY (`clinical_ai_patient_risk_score_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score`(`clinical_ai_patient_risk_score_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_criteria_evaluation` ADD CONSTRAINT `fk_clinical_trial_matching_eligibility_criteria_evaluation_clinical_ai_clinical_nlp_result_id` FOREIGN KEY (`clinical_ai_clinical_nlp_result_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result`(`clinical_ai_clinical_nlp_result_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match_result` ADD CONSTRAINT `fk_clinical_trial_matching_trial_match_result_clinical_ai_model_card_id` FOREIGN KEY (`clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match_result` ADD CONSTRAINT `fk_clinical_trial_matching_trial_match_result_clinical_ai_patient_risk_score_id` FOREIGN KEY (`clinical_ai_patient_risk_score_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score`(`clinical_ai_patient_risk_score_id`);

-- ========= clinical_trial_matching --> consent (1 constraint(s)) =========
-- Requires: clinical_trial_matching schema, consent schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`match_result` ADD CONSTRAINT `fk_clinical_trial_matching_match_result_hipaa_authorization_id` FOREIGN KEY (`hipaa_authorization_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`hipaa_authorization`(`hipaa_authorization_id`);

-- ========= clinical_trial_matching --> encounter (8 constraint(s)) =========
-- Requires: clinical_trial_matching schema, encounter schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation` ADD CONSTRAINT `fk_clinical_trial_matching_eligibility_evaluation_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_match` ADD CONSTRAINT `fk_clinical_trial_matching_patient_eligibility_match_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match` ADD CONSTRAINT `fk_clinical_trial_matching_trial_match_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility` ADD CONSTRAINT `fk_clinical_trial_matching_trial_eligibility_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_evaluation` ADD CONSTRAINT `fk_clinical_trial_matching_patient_eligibility_evaluation_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility_status` ADD CONSTRAINT `fk_clinical_trial_matching_trial_eligibility_status_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_trial_match` ADD CONSTRAINT `fk_clinical_trial_matching_patient_trial_match_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`match_result` ADD CONSTRAINT `fk_clinical_trial_matching_match_result_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);

-- ========= clinical_trial_matching --> facility (9 constraint(s)) =========
-- Requires: clinical_trial_matching schema, facility schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation` ADD CONSTRAINT `fk_clinical_trial_matching_eligibility_evaluation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_match` ADD CONSTRAINT `fk_clinical_trial_matching_patient_eligibility_match_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match` ADD CONSTRAINT `fk_clinical_trial_matching_trial_match_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility` ADD CONSTRAINT `fk_clinical_trial_matching_trial_eligibility_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial` ADD CONSTRAINT `fk_clinical_trial_matching_trial_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_evaluation` ADD CONSTRAINT `fk_clinical_trial_matching_patient_eligibility_evaluation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility_status` ADD CONSTRAINT `fk_clinical_trial_matching_trial_eligibility_status_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_trial_match` ADD CONSTRAINT `fk_clinical_trial_matching_patient_trial_match_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`match_result` ADD CONSTRAINT `fk_clinical_trial_matching_match_result_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= clinical_trial_matching --> genomics (4 constraint(s)) =========
-- Requires: clinical_trial_matching schema, genomics schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility` ADD CONSTRAINT `fk_clinical_trial_matching_patient_eligibility_genomics_patient_genomic_profile_id` FOREIGN KEY (`genomics_patient_genomic_profile_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile`(`genomics_patient_genomic_profile_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match_result` ADD CONSTRAINT `fk_clinical_trial_matching_trial_match_result_genomic_test_result_id` FOREIGN KEY (`genomic_test_result_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_test_result`(`genomic_test_result_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match_result` ADD CONSTRAINT `fk_clinical_trial_matching_trial_match_result_genomics_patient_genomic_profile_id` FOREIGN KEY (`genomics_patient_genomic_profile_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile`(`genomics_patient_genomic_profile_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`clinical_trial_matching_trial_eligibility_match` ADD CONSTRAINT `fk_clinical_trial_matching_clinical_trial_matching_trial_eligibility_match_genomic_test_result_id` FOREIGN KEY (`genomic_test_result_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_test_result`(`genomic_test_result_id`);

-- ========= clinical_trial_matching --> patient (10 constraint(s)) =========
-- Requires: clinical_trial_matching schema, patient schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility` ADD CONSTRAINT `fk_clinical_trial_matching_patient_eligibility_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation` ADD CONSTRAINT `fk_clinical_trial_matching_eligibility_evaluation_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match_result` ADD CONSTRAINT `fk_clinical_trial_matching_trial_match_result_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_match` ADD CONSTRAINT `fk_clinical_trial_matching_patient_eligibility_match_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match` ADD CONSTRAINT `fk_clinical_trial_matching_trial_match_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility` ADD CONSTRAINT `fk_clinical_trial_matching_trial_eligibility_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_evaluation` ADD CONSTRAINT `fk_clinical_trial_matching_patient_eligibility_evaluation_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility_status` ADD CONSTRAINT `fk_clinical_trial_matching_trial_eligibility_status_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_trial_match` ADD CONSTRAINT `fk_clinical_trial_matching_patient_trial_match_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`match_result` ADD CONSTRAINT `fk_clinical_trial_matching_match_result_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= clinical_trial_matching --> post_acute_care (1 constraint(s)) =========
-- Requires: clinical_trial_matching schema, post_acute_care schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_enrollment` ADD CONSTRAINT `fk_clinical_trial_matching_trial_enrollment_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);

-- ========= clinical_trial_matching --> provider (8 constraint(s)) =========
-- Requires: clinical_trial_matching schema, provider schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_match` ADD CONSTRAINT `fk_clinical_trial_matching_patient_eligibility_match_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_match` ADD CONSTRAINT `fk_clinical_trial_matching_patient_eligibility_match_patient_referring_provider_clinician_id` FOREIGN KEY (`patient_referring_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match` ADD CONSTRAINT `fk_clinical_trial_matching_trial_match_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match` ADD CONSTRAINT `fk_clinical_trial_matching_trial_match_trial_principal_investigator_clinician_id` FOREIGN KEY (`trial_principal_investigator_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility` ADD CONSTRAINT `fk_clinical_trial_matching_trial_eligibility_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_eligibility_status` ADD CONSTRAINT `fk_clinical_trial_matching_trial_eligibility_status_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_trial_match` ADD CONSTRAINT `fk_clinical_trial_matching_patient_trial_match_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_trial_match` ADD CONSTRAINT `fk_clinical_trial_matching_patient_trial_match_patient_principal_investigator_clinician_id` FOREIGN KEY (`patient_principal_investigator_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= clinical_trial_matching --> reference (1 constraint(s)) =========
-- Requires: clinical_trial_matching schema, reference schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`clinical_trial_matching_trial_eligibility_criteria` ADD CONSTRAINT `fk_clinical_trial_matching_clinical_trial_matching_trial_eligibility_criteria_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);

-- ========= clinical_trial_matching --> research (1 constraint(s)) =========
-- Requires: clinical_trial_matching schema, research schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation` ADD CONSTRAINT `fk_clinical_trial_matching_eligibility_evaluation_protocol_version_id` FOREIGN KEY (`protocol_version_id`) REFERENCES `healthcare_ecm_v1`.`research`.`protocol_version`(`protocol_version_id`);

-- ========= clinical_trial_matching --> workforce (10 constraint(s)) =========
-- Requires: clinical_trial_matching schema, workforce schema
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation` ADD CONSTRAINT `fk_clinical_trial_matching_eligibility_evaluation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation` ADD CONSTRAINT `fk_clinical_trial_matching_eligibility_evaluation_eligibility_override_provider_employee_id` FOREIGN KEY (`eligibility_override_provider_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_evaluation` ADD CONSTRAINT `fk_clinical_trial_matching_eligibility_evaluation_eligibility_referring_provider_employee_id` FOREIGN KEY (`eligibility_referring_provider_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match` ADD CONSTRAINT `fk_clinical_trial_matching_trial_match_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_eligibility_evaluation` ADD CONSTRAINT `fk_clinical_trial_matching_patient_eligibility_evaluation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`patient_trial_match` ADD CONSTRAINT `fk_clinical_trial_matching_patient_trial_match_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`clinical_trial_matching_trial_eligibility_criteria` ADD CONSTRAINT `fk_clinical_trial_matching_clinical_trial_matching_trial_eligibility_criteria_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`match_result` ADD CONSTRAINT `fk_clinical_trial_matching_match_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`match_result` ADD CONSTRAINT `fk_clinical_trial_matching_match_result_match_principal_investigator_employee_id` FOREIGN KEY (`match_principal_investigator_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`clinical_trial_matching`.`match_result` ADD CONSTRAINT `fk_clinical_trial_matching_match_result_match_research_coordinator_employee_id` FOREIGN KEY (`match_research_coordinator_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);

-- ========= compliance --> behavioral_health (3 constraint(s)) =========
-- Requires: compliance schema, behavioral_health schema
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`hipaa_privacy_incident` ADD CONSTRAINT `fk_compliance_hipaa_privacy_incident_behavioral_health_cfr42_consent_id` FOREIGN KEY (`behavioral_health_cfr42_consent_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent`(`behavioral_health_cfr42_consent_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`hipaa_privacy_incident` ADD CONSTRAINT `fk_compliance_hipaa_privacy_incident_behavioral_health_sud_episode_id` FOREIGN KEY (`behavioral_health_sud_episode_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode`(`behavioral_health_sud_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`phi_access_log` ADD CONSTRAINT `fk_compliance_phi_access_log_behavioral_health_cfr42_consent_id` FOREIGN KEY (`behavioral_health_cfr42_consent_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent`(`behavioral_health_cfr42_consent_id`);

-- ========= compliance --> clinical (3 constraint(s)) =========
-- Requires: compliance schema, clinical schema
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`hipaa_privacy_incident` ADD CONSTRAINT `fk_compliance_hipaa_privacy_incident_note_id` FOREIGN KEY (`note_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`note`(`note_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`osha_exposure_incident` ADD CONSTRAINT `fk_compliance_osha_exposure_incident_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`procedure_event`(`procedure_event_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`phi_access_log` ADD CONSTRAINT `fk_compliance_phi_access_log_note_id` FOREIGN KEY (`note_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`note`(`note_id`);

-- ========= compliance --> clinical_ai (1 constraint(s)) =========
-- Requires: compliance schema, clinical_ai schema
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_clinical_ai_model_card_id` FOREIGN KEY (`clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);

-- ========= compliance --> digital_health (3 constraint(s)) =========
-- Requires: compliance schema, digital_health schema
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`hipaa_privacy_incident` ADD CONSTRAINT `fk_compliance_hipaa_privacy_incident_device_id` FOREIGN KEY (`device_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`device`(`device_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`hipaa_security_risk` ADD CONSTRAINT `fk_compliance_hipaa_security_risk_device_id` FOREIGN KEY (`device_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`device`(`device_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`phi_access_log` ADD CONSTRAINT `fk_compliance_phi_access_log_device_id` FOREIGN KEY (`device_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`device`(`device_id`);

-- ========= compliance --> encounter (2 constraint(s)) =========
-- Requires: compliance schema, encounter schema
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`notice_of_privacy_practices` ADD CONSTRAINT `fk_compliance_notice_of_privacy_practices_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`phi_access_log` ADD CONSTRAINT `fk_compliance_phi_access_log_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);

-- ========= compliance --> facility (14 constraint(s)) =========
-- Requires: compliance schema, facility schema
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`hipaa_privacy_incident` ADD CONSTRAINT `fk_compliance_hipaa_privacy_incident_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`hipaa_security_risk` ADD CONSTRAINT `fk_compliance_hipaa_security_risk_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`conflict_of_interest` ADD CONSTRAINT `fk_compliance_conflict_of_interest_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`hotline_report` ADD CONSTRAINT `fk_compliance_hotline_report_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`investigation` ADD CONSTRAINT `fk_compliance_investigation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`osha_exposure_incident` ADD CONSTRAINT `fk_compliance_osha_exposure_incident_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`cms_condition_status` ADD CONSTRAINT `fk_compliance_cms_condition_status_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`accreditation_status` ADD CONSTRAINT `fk_compliance_accreditation_status_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`notice_of_privacy_practices` ADD CONSTRAINT `fk_compliance_notice_of_privacy_practices_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`phi_access_log` ADD CONSTRAINT `fk_compliance_phi_access_log_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`monitoring_activity` ADD CONSTRAINT `fk_compliance_monitoring_activity_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= compliance --> finance (14 constraint(s)) =========
-- Requires: compliance schema, finance schema
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`compliance_program` ADD CONSTRAINT `fk_compliance_compliance_program_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`budget`(`budget_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`budget`(`budget_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`training` ADD CONSTRAINT `fk_compliance_training_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`compliance_regulatory_submission` ADD CONSTRAINT `fk_compliance_compliance_regulatory_submission_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`compliance_regulatory_submission` ADD CONSTRAINT `fk_compliance_compliance_regulatory_submission_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`compliance_regulatory_submission` ADD CONSTRAINT `fk_compliance_compliance_regulatory_submission_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`investigation` ADD CONSTRAINT `fk_compliance_investigation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`stark_arrangement` ADD CONSTRAINT `fk_compliance_stark_arrangement_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`osha_safety_program` ADD CONSTRAINT `fk_compliance_osha_safety_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`cms_condition_status` ADD CONSTRAINT `fk_compliance_cms_condition_status_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`monitoring_activity` ADD CONSTRAINT `fk_compliance_monitoring_activity_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= compliance --> genomics (1 constraint(s)) =========
-- Requires: compliance schema, genomics schema
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`phi_access_log` ADD CONSTRAINT `fk_compliance_phi_access_log_genomics_genomic_sequence_id` FOREIGN KEY (`genomics_genomic_sequence_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence`(`genomics_genomic_sequence_id`);

-- ========= compliance --> insurance (10 constraint(s)) =========
-- Requires: compliance schema, insurance schema
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`hipaa_privacy_incident` ADD CONSTRAINT `fk_compliance_hipaa_privacy_incident_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`compliance_regulatory_submission` ADD CONSTRAINT `fk_compliance_compliance_regulatory_submission_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`exclusion_screening` ADD CONSTRAINT `fk_compliance_exclusion_screening_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`cms_condition_status` ADD CONSTRAINT `fk_compliance_cms_condition_status_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`accreditation_status` ADD CONSTRAINT `fk_compliance_accreditation_status_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`business_associate_agreement` ADD CONSTRAINT `fk_compliance_business_associate_agreement_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`phi_access_log` ADD CONSTRAINT `fk_compliance_phi_access_log_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`policy_payer_applicability` ADD CONSTRAINT `fk_compliance_policy_payer_applicability_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);

-- ========= compliance --> interoperability (6 constraint(s)) =========
-- Requires: compliance schema, interoperability schema
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`hipaa_privacy_incident` ADD CONSTRAINT `fk_compliance_hipaa_privacy_incident_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`hipaa_security_risk` ADD CONSTRAINT `fk_compliance_hipaa_security_risk_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`compliance_regulatory_submission` ADD CONSTRAINT `fk_compliance_compliance_regulatory_submission_public_health_report_id` FOREIGN KEY (`public_health_report_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`public_health_report`(`public_health_report_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`phi_access_log` ADD CONSTRAINT `fk_compliance_phi_access_log_fhir_resource_log_id` FOREIGN KEY (`fhir_resource_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`fhir_resource_log`(`fhir_resource_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`monitoring_activity` ADD CONSTRAINT `fk_compliance_monitoring_activity_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);

-- ========= compliance --> order (1 constraint(s)) =========
-- Requires: compliance schema, order schema
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`hipaa_privacy_incident` ADD CONSTRAINT `fk_compliance_hipaa_privacy_incident_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= compliance --> patient (6 constraint(s)) =========
-- Requires: compliance schema, patient schema
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`hipaa_privacy_incident` ADD CONSTRAINT `fk_compliance_hipaa_privacy_incident_hipaa_mpi_record_id` FOREIGN KEY (`hipaa_mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`hipaa_privacy_incident` ADD CONSTRAINT `fk_compliance_hipaa_privacy_incident_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`investigation` ADD CONSTRAINT `fk_compliance_investigation_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`osha_exposure_incident` ADD CONSTRAINT `fk_compliance_osha_exposure_incident_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`notice_of_privacy_practices` ADD CONSTRAINT `fk_compliance_notice_of_privacy_practices_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`phi_access_log` ADD CONSTRAINT `fk_compliance_phi_access_log_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= compliance --> post_acute_care (3 constraint(s)) =========
-- Requires: compliance schema, post_acute_care schema
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_post_acute_location_id` FOREIGN KEY (`post_acute_location_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location`(`post_acute_location_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`cms_condition_status` ADD CONSTRAINT `fk_compliance_cms_condition_status_post_acute_location_id` FOREIGN KEY (`post_acute_location_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location`(`post_acute_location_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`accreditation_status` ADD CONSTRAINT `fk_compliance_accreditation_status_post_acute_location_id` FOREIGN KEY (`post_acute_location_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location`(`post_acute_location_id`);

-- ========= compliance --> provider (1 constraint(s)) =========
-- Requires: compliance schema, provider schema
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`stark_arrangement` ADD CONSTRAINT `fk_compliance_stark_arrangement_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= compliance --> reference (14 constraint(s)) =========
-- Requires: compliance schema, reference schema
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_code_set_version_id` FOREIGN KEY (`code_set_version_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`code_set_version`(`code_set_version_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`compliance_policy` ADD CONSTRAINT `fk_compliance_compliance_policy_code_set_version_id` FOREIGN KEY (`code_set_version_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`code_set_version`(`code_set_version_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`training` ADD CONSTRAINT `fk_compliance_training_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`compliance_regulatory_submission` ADD CONSTRAINT `fk_compliance_compliance_regulatory_submission_code_set_version_id` FOREIGN KEY (`code_set_version_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`code_set_version`(`code_set_version_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`exclusion_screening` ADD CONSTRAINT `fk_compliance_exclusion_screening_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`stark_arrangement` ADD CONSTRAINT `fk_compliance_stark_arrangement_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`osha_exposure_incident` ADD CONSTRAINT `fk_compliance_osha_exposure_incident_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`monitoring_activity` ADD CONSTRAINT `fk_compliance_monitoring_activity_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`monitoring_activity` ADD CONSTRAINT `fk_compliance_monitoring_activity_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);

-- ========= compliance --> scheduling (3 constraint(s)) =========
-- Requires: compliance schema, scheduling schema
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`osha_exposure_incident` ADD CONSTRAINT `fk_compliance_osha_exposure_incident_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`notice_of_privacy_practices` ADD CONSTRAINT `fk_compliance_notice_of_privacy_practices_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`phi_access_log` ADD CONSTRAINT `fk_compliance_phi_access_log_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);

-- ========= compliance --> workforce (31 constraint(s)) =========
-- Requires: compliance schema, workforce schema
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`compliance_program` ADD CONSTRAINT `fk_compliance_compliance_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`policy_version` ADD CONSTRAINT `fk_compliance_policy_version_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`policy_version` ADD CONSTRAINT `fk_compliance_policy_version_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`policy_version` ADD CONSTRAINT `fk_compliance_policy_version_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_lead_auditor_employee_id` FOREIGN KEY (`lead_auditor_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`hipaa_privacy_incident` ADD CONSTRAINT `fk_compliance_hipaa_privacy_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`hipaa_privacy_incident` ADD CONSTRAINT `fk_compliance_hipaa_privacy_incident_reported_by_employee_id` FOREIGN KEY (`reported_by_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`hipaa_security_risk` ADD CONSTRAINT `fk_compliance_hipaa_security_risk_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`hipaa_security_risk` ADD CONSTRAINT `fk_compliance_hipaa_security_risk_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`training_completion` ADD CONSTRAINT `fk_compliance_training_completion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`compliance_regulatory_submission` ADD CONSTRAINT `fk_compliance_compliance_regulatory_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`exclusion_screening` ADD CONSTRAINT `fk_compliance_exclusion_screening_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`conflict_of_interest` ADD CONSTRAINT `fk_compliance_conflict_of_interest_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`conflict_of_interest` ADD CONSTRAINT `fk_compliance_conflict_of_interest_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`hotline_report` ADD CONSTRAINT `fk_compliance_hotline_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`hotline_report` ADD CONSTRAINT `fk_compliance_hotline_report_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`investigation` ADD CONSTRAINT `fk_compliance_investigation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`investigation` ADD CONSTRAINT `fk_compliance_investigation_investigation_employee_id` FOREIGN KEY (`investigation_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`osha_safety_program` ADD CONSTRAINT `fk_compliance_osha_safety_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`osha_exposure_incident` ADD CONSTRAINT `fk_compliance_osha_exposure_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`osha_exposure_incident` ADD CONSTRAINT `fk_compliance_osha_exposure_incident_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`notice_of_privacy_practices` ADD CONSTRAINT `fk_compliance_notice_of_privacy_practices_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`phi_access_log` ADD CONSTRAINT `fk_compliance_phi_access_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`monitoring_activity` ADD CONSTRAINT `fk_compliance_monitoring_activity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`policy_regulatory_impact` ADD CONSTRAINT `fk_compliance_policy_regulatory_impact_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`compliance`.`regulatory_requirement` ADD CONSTRAINT `fk_compliance_regulatory_requirement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);

-- ========= consent --> behavioral_health (1 constraint(s)) =========
-- Requires: consent schema, behavioral_health schema
ALTER TABLE `healthcare_ecm_v1`.`consent`.`substance_use_consent` ADD CONSTRAINT `fk_consent_substance_use_consent_behavioral_health_sud_episode_id` FOREIGN KEY (`behavioral_health_sud_episode_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode`(`behavioral_health_sud_episode_id`);

-- ========= consent --> clinical_ai (1 constraint(s)) =========
-- Requires: consent schema, clinical_ai schema
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_record` ADD CONSTRAINT `fk_consent_consent_consent_record_clinical_ai_model_card_id` FOREIGN KEY (`clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);

-- ========= consent --> compliance (14 constraint(s)) =========
-- Requires: consent schema, compliance schema
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_form_template` ADD CONSTRAINT `fk_consent_consent_form_template_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`hipaa_authorization` ADD CONSTRAINT `fk_consent_hipaa_authorization_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`research_consent` ADD CONSTRAINT `fk_consent_research_consent_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`npp_acknowledgment` ADD CONSTRAINT `fk_consent_npp_acknowledgment_notice_of_privacy_practices_id` FOREIGN KEY (`notice_of_privacy_practices_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`notice_of_privacy_practices`(`notice_of_privacy_practices_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`restriction_request` ADD CONSTRAINT `fk_consent_restriction_request_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`disclosure_log` ADD CONSTRAINT `fk_consent_disclosure_log_phi_access_log_id` FOREIGN KEY (`phi_access_log_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`phi_access_log`(`phi_access_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`capacity_assessment` ADD CONSTRAINT `fk_consent_capacity_assessment_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_policy` ADD CONSTRAINT `fk_consent_consent_policy_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_workflow_entity` ADD CONSTRAINT `fk_consent_consent_workflow_entity_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`deficiency` ADD CONSTRAINT `fk_consent_deficiency_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`deficiency` ADD CONSTRAINT `fk_consent_deficiency_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_record` ADD CONSTRAINT `fk_consent_consent_consent_record_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_verification` ADD CONSTRAINT `fk_consent_consent_consent_verification_monitoring_activity_id` FOREIGN KEY (`monitoring_activity_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`monitoring_activity`(`monitoring_activity_id`);

-- ========= consent --> encounter (28 constraint(s)) =========
-- Requires: consent schema, encounter schema
ALTER TABLE `healthcare_ecm_v1`.`consent`.`hipaa_authorization` ADD CONSTRAINT `fk_consent_hipaa_authorization_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`hie_directive` ADD CONSTRAINT `fk_consent_hie_directive_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`telehealth_consent` ADD CONSTRAINT `fk_consent_telehealth_consent_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`minor_consent` ADD CONSTRAINT `fk_consent_minor_consent_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`npp_acknowledgment` ADD CONSTRAINT `fk_consent_npp_acknowledgment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`restriction_request` ADD CONSTRAINT `fk_consent_restriction_request_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`disclosure_log` ADD CONSTRAINT `fk_consent_disclosure_log_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`capacity_assessment` ADD CONSTRAINT `fk_consent_capacity_assessment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`deficiency` ADD CONSTRAINT `fk_consent_deficiency_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`substance_use_consent` ADD CONSTRAINT `fk_consent_substance_use_consent_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`behavioral_health_consent` ADD CONSTRAINT `fk_consent_behavioral_health_consent_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`expiration_alert` ADD CONSTRAINT `fk_consent_expiration_alert_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`genetic_testing_consent` ADD CONSTRAINT `fk_consent_genetic_testing_consent_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`photography_media_consent` ADD CONSTRAINT `fk_consent_photography_media_consent_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`amendment_request` ADD CONSTRAINT `fk_consent_amendment_request_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_session` ADD CONSTRAINT `fk_consent_consent_session_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_workflow_tbl` ADD CONSTRAINT `fk_consent_consent_workflow_tbl_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_record` ADD CONSTRAINT `fk_consent_consent_consent_record_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_event` ADD CONSTRAINT `fk_consent_consent_consent_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_exception` ADD CONSTRAINT `fk_consent_consent_consent_exception_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_translation` ADD CONSTRAINT `fk_consent_consent_consent_translation_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_verification` ADD CONSTRAINT `fk_consent_consent_consent_verification_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_workflow` ADD CONSTRAINT `fk_consent_consent_workflow_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_record_tbl` ADD CONSTRAINT `fk_consent_consent_record_tbl_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_event_tbl` ADD CONSTRAINT `fk_consent_consent_event_tbl_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_verification_tbl` ADD CONSTRAINT `fk_consent_consent_verification_tbl_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_workflow_tbl` ADD CONSTRAINT `fk_consent_consent_consent_workflow_tbl_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);

-- ========= consent --> facility (24 constraint(s)) =========
-- Requires: consent schema, facility schema
ALTER TABLE `healthcare_ecm_v1`.`consent`.`hipaa_authorization` ADD CONSTRAINT `fk_consent_hipaa_authorization_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`hie_directive` ADD CONSTRAINT `fk_consent_hie_directive_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`npp_acknowledgment` ADD CONSTRAINT `fk_consent_npp_acknowledgment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`restriction_request` ADD CONSTRAINT `fk_consent_restriction_request_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`disclosure_log` ADD CONSTRAINT `fk_consent_disclosure_log_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`deficiency` ADD CONSTRAINT `fk_consent_deficiency_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`substance_use_consent` ADD CONSTRAINT `fk_consent_substance_use_consent_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`behavioral_health_consent` ADD CONSTRAINT `fk_consent_behavioral_health_consent_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`genetic_testing_consent` ADD CONSTRAINT `fk_consent_genetic_testing_consent_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`photography_media_consent` ADD CONSTRAINT `fk_consent_photography_media_consent_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`amendment_request` ADD CONSTRAINT `fk_consent_amendment_request_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_session` ADD CONSTRAINT `fk_consent_consent_session_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_workflow_tbl` ADD CONSTRAINT `fk_consent_consent_workflow_tbl_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_event` ADD CONSTRAINT `fk_consent_consent_consent_event_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_exception` ADD CONSTRAINT `fk_consent_consent_consent_exception_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_verification` ADD CONSTRAINT `fk_consent_consent_consent_verification_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_workflow` ADD CONSTRAINT `fk_consent_consent_workflow_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_record_tbl` ADD CONSTRAINT `fk_consent_consent_record_tbl_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_event_tbl` ADD CONSTRAINT `fk_consent_consent_event_tbl_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_exception_tbl` ADD CONSTRAINT `fk_consent_consent_exception_tbl_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_verification_tbl` ADD CONSTRAINT `fk_consent_consent_verification_tbl_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_workflow_tbl` ADD CONSTRAINT `fk_consent_consent_consent_workflow_tbl_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`workflow_template` ADD CONSTRAINT `fk_consent_workflow_template_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= consent --> genomics (1 constraint(s)) =========
-- Requires: consent schema, genomics schema
ALTER TABLE `healthcare_ecm_v1`.`consent`.`genetic_testing_consent` ADD CONSTRAINT `fk_consent_genetic_testing_consent_genomics_genomic_order_id` FOREIGN KEY (`genomics_genomic_order_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order`(`genomics_genomic_order_id`);

-- ========= consent --> insurance (1 constraint(s)) =========
-- Requires: consent schema, insurance schema
ALTER TABLE `healthcare_ecm_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);

-- ========= consent --> interoperability (12 constraint(s)) =========
-- Requires: consent schema, interoperability schema
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_form_template` ADD CONSTRAINT `fk_consent_consent_form_template_exchange_standard_id` FOREIGN KEY (`exchange_standard_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`exchange_standard`(`exchange_standard_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`hipaa_authorization` ADD CONSTRAINT `fk_consent_hipaa_authorization_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`cda_document`(`cda_document_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`hie_directive` ADD CONSTRAINT `fk_consent_hie_directive_hie_participation_id` FOREIGN KEY (`hie_participation_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`hie_participation`(`hie_participation_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`hie_directive` ADD CONSTRAINT `fk_consent_hie_directive_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`research_consent` ADD CONSTRAINT `fk_consent_research_consent_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`cda_document`(`cda_document_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`disclosure_log` ADD CONSTRAINT `fk_consent_disclosure_log_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_policy` ADD CONSTRAINT `fk_consent_consent_policy_exchange_standard_id` FOREIGN KEY (`exchange_standard_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`exchange_standard`(`exchange_standard_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`substance_use_consent` ADD CONSTRAINT `fk_consent_substance_use_consent_direct_message_id` FOREIGN KEY (`direct_message_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`direct_message`(`direct_message_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`behavioral_health_consent` ADD CONSTRAINT `fk_consent_behavioral_health_consent_direct_message_id` FOREIGN KEY (`direct_message_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`direct_message`(`direct_message_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_record` ADD CONSTRAINT `fk_consent_consent_consent_record_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_event` ADD CONSTRAINT `fk_consent_consent_consent_event_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_verification` ADD CONSTRAINT `fk_consent_consent_consent_verification_fhir_resource_log_id` FOREIGN KEY (`fhir_resource_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`fhir_resource_log`(`fhir_resource_log_id`);

-- ========= consent --> order (2 constraint(s)) =========
-- Requires: consent schema, order schema
ALTER TABLE `healthcare_ecm_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_record` ADD CONSTRAINT `fk_consent_consent_consent_record_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= consent --> patient (37 constraint(s)) =========
-- Requires: consent schema, patient schema
ALTER TABLE `healthcare_ecm_v1`.`consent`.`hipaa_authorization` ADD CONSTRAINT `fk_consent_hipaa_authorization_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`hie_directive` ADD CONSTRAINT `fk_consent_hie_directive_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`research_consent` ADD CONSTRAINT `fk_consent_research_consent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`telehealth_consent` ADD CONSTRAINT `fk_consent_telehealth_consent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`minor_consent` ADD CONSTRAINT `fk_consent_minor_consent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`delegation` ADD CONSTRAINT `fk_consent_delegation_delegation_mpi_record_id` FOREIGN KEY (`delegation_mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`delegation` ADD CONSTRAINT `fk_consent_delegation_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`revocation` ADD CONSTRAINT `fk_consent_revocation_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`npp_acknowledgment` ADD CONSTRAINT `fk_consent_npp_acknowledgment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`restriction_request` ADD CONSTRAINT `fk_consent_restriction_request_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`restriction_request` ADD CONSTRAINT `fk_consent_restriction_request_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`disclosure_log` ADD CONSTRAINT `fk_consent_disclosure_log_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`capacity_assessment` ADD CONSTRAINT `fk_consent_capacity_assessment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`deficiency` ADD CONSTRAINT `fk_consent_deficiency_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`substance_use_consent` ADD CONSTRAINT `fk_consent_substance_use_consent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`behavioral_health_consent` ADD CONSTRAINT `fk_consent_behavioral_health_consent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`expiration_alert` ADD CONSTRAINT `fk_consent_expiration_alert_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`genetic_testing_consent` ADD CONSTRAINT `fk_consent_genetic_testing_consent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`photography_media_consent` ADD CONSTRAINT `fk_consent_photography_media_consent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`amendment_request` ADD CONSTRAINT `fk_consent_amendment_request_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_session` ADD CONSTRAINT `fk_consent_consent_session_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_workflow_tbl` ADD CONSTRAINT `fk_consent_consent_workflow_tbl_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_record` ADD CONSTRAINT `fk_consent_consent_consent_record_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_record` ADD CONSTRAINT `fk_consent_consent_consent_record_consent_patient_mpi_record_id` FOREIGN KEY (`consent_patient_mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_record` ADD CONSTRAINT `fk_consent_consent_consent_record_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_event` ADD CONSTRAINT `fk_consent_consent_consent_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_exception` ADD CONSTRAINT `fk_consent_consent_consent_exception_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_translation` ADD CONSTRAINT `fk_consent_consent_consent_translation_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_verification` ADD CONSTRAINT `fk_consent_consent_consent_verification_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_workflow` ADD CONSTRAINT `fk_consent_consent_workflow_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_record_tbl` ADD CONSTRAINT `fk_consent_consent_record_tbl_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_event_tbl` ADD CONSTRAINT `fk_consent_consent_event_tbl_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_exception_tbl` ADD CONSTRAINT `fk_consent_consent_exception_tbl_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_verification_tbl` ADD CONSTRAINT `fk_consent_consent_verification_tbl_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_workflow_tbl` ADD CONSTRAINT `fk_consent_consent_consent_workflow_tbl_emergency_contact_id` FOREIGN KEY (`emergency_contact_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`emergency_contact`(`emergency_contact_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_workflow_tbl` ADD CONSTRAINT `fk_consent_consent_consent_workflow_tbl_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= consent --> provider (20 constraint(s)) =========
-- Requires: consent schema, provider schema
ALTER TABLE `healthcare_ecm_v1`.`consent`.`hie_directive` ADD CONSTRAINT `fk_consent_hie_directive_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_tertiary_treatment_performing_provider_clinician_id` FOREIGN KEY (`tertiary_treatment_performing_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`research_consent` ADD CONSTRAINT `fk_consent_research_consent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`telehealth_consent` ADD CONSTRAINT `fk_consent_telehealth_consent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`minor_consent` ADD CONSTRAINT `fk_consent_minor_consent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`capacity_assessment` ADD CONSTRAINT `fk_consent_capacity_assessment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`deficiency` ADD CONSTRAINT `fk_consent_deficiency_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`substance_use_consent` ADD CONSTRAINT `fk_consent_substance_use_consent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`behavioral_health_consent` ADD CONSTRAINT `fk_consent_behavioral_health_consent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`genetic_testing_consent` ADD CONSTRAINT `fk_consent_genetic_testing_consent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`photography_media_consent` ADD CONSTRAINT `fk_consent_photography_media_consent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_record` ADD CONSTRAINT `fk_consent_consent_consent_record_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_exception` ADD CONSTRAINT `fk_consent_consent_consent_exception_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_workflow` ADD CONSTRAINT `fk_consent_consent_workflow_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_record_tbl` ADD CONSTRAINT `fk_consent_consent_record_tbl_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_event_tbl` ADD CONSTRAINT `fk_consent_consent_event_tbl_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_exception_tbl` ADD CONSTRAINT `fk_consent_consent_exception_tbl_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_verification_tbl` ADD CONSTRAINT `fk_consent_consent_verification_tbl_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_workflow_tbl` ADD CONSTRAINT `fk_consent_consent_consent_workflow_tbl_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= consent --> reference (1 constraint(s)) =========
-- Requires: consent schema, reference schema
ALTER TABLE `healthcare_ecm_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);

-- ========= consent --> research (5 constraint(s)) =========
-- Requires: consent schema, research schema
ALTER TABLE `healthcare_ecm_v1`.`consent`.`hipaa_authorization` ADD CONSTRAINT `fk_consent_hipaa_authorization_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`research_consent` ADD CONSTRAINT `fk_consent_research_consent_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`genetic_testing_consent` ADD CONSTRAINT `fk_consent_genetic_testing_consent_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`photography_media_consent` ADD CONSTRAINT `fk_consent_photography_media_consent_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_record` ADD CONSTRAINT `fk_consent_consent_consent_record_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);

-- ========= consent --> supply (1 constraint(s)) =========
-- Requires: consent schema, supply schema
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_translation` ADD CONSTRAINT `fk_consent_consent_consent_translation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`vendor`(`vendor_id`);

-- ========= consent --> workforce (51 constraint(s)) =========
-- Requires: consent schema, workforce schema
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_record` ADD CONSTRAINT `fk_consent_consent_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`hipaa_authorization` ADD CONSTRAINT `fk_consent_hipaa_authorization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_treatment_employee_id` FOREIGN KEY (`treatment_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`treatment_consent` ADD CONSTRAINT `fk_consent_treatment_consent_witness_employee_id` FOREIGN KEY (`witness_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`minor_consent` ADD CONSTRAINT `fk_consent_minor_consent_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`delegation` ADD CONSTRAINT `fk_consent_delegation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`delegation` ADD CONSTRAINT `fk_consent_delegation_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`revocation` ADD CONSTRAINT `fk_consent_revocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`npp_acknowledgment` ADD CONSTRAINT `fk_consent_npp_acknowledgment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`npp_acknowledgment` ADD CONSTRAINT `fk_consent_npp_acknowledgment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`restriction_request` ADD CONSTRAINT `fk_consent_restriction_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`capacity_assessment` ADD CONSTRAINT `fk_consent_capacity_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_policy` ADD CONSTRAINT `fk_consent_consent_policy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_policy` ADD CONSTRAINT `fk_consent_consent_policy_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_workflow_entity` ADD CONSTRAINT `fk_consent_consent_workflow_entity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`deficiency` ADD CONSTRAINT `fk_consent_deficiency_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`deficiency` ADD CONSTRAINT `fk_consent_deficiency_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`deficiency` ADD CONSTRAINT `fk_consent_deficiency_tertiary_deficiency_escalated_to_user_bigint_surrogate_key_for_clean_keying` FOREIGN KEY (`tertiary_deficiency_escalated_to_user_bigint_surrogate_key_for_clean_keying`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`deficiency` ADD CONSTRAINT `fk_consent_deficiency_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`expiration_alert` ADD CONSTRAINT `fk_consent_expiration_alert_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`expiration_alert` ADD CONSTRAINT `fk_consent_expiration_alert_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`genetic_testing_consent` ADD CONSTRAINT `fk_consent_genetic_testing_consent_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`amendment_request` ADD CONSTRAINT `fk_consent_amendment_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`amendment_request` ADD CONSTRAINT `fk_consent_amendment_request_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_session` ADD CONSTRAINT `fk_consent_consent_session_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_workflow_tbl` ADD CONSTRAINT `fk_consent_consent_workflow_tbl_assigned_to_employee_id` FOREIGN KEY (`assigned_to_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_workflow_tbl` ADD CONSTRAINT `fk_consent_consent_workflow_tbl_completed_by_employee_id` FOREIGN KEY (`completed_by_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_workflow_tbl` ADD CONSTRAINT `fk_consent_consent_workflow_tbl_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_workflow_tbl` ADD CONSTRAINT `fk_consent_consent_workflow_tbl_escalated_to_employee_id` FOREIGN KEY (`escalated_to_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_workflow_tbl` ADD CONSTRAINT `fk_consent_consent_workflow_tbl_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_record` ADD CONSTRAINT `fk_consent_consent_consent_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_record` ADD CONSTRAINT `fk_consent_consent_consent_record_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_event` ADD CONSTRAINT `fk_consent_consent_consent_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_event` ADD CONSTRAINT `fk_consent_consent_consent_event_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_exception` ADD CONSTRAINT `fk_consent_consent_consent_exception_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_translation` ADD CONSTRAINT `fk_consent_consent_consent_translation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_verification` ADD CONSTRAINT `fk_consent_consent_consent_verification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_workflow` ADD CONSTRAINT `fk_consent_consent_workflow_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_workflow` ADD CONSTRAINT `fk_consent_consent_workflow_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_exception_tbl` ADD CONSTRAINT `fk_consent_consent_exception_tbl_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_translation_tbl` ADD CONSTRAINT `fk_consent_consent_translation_tbl_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_workflow_tbl` ADD CONSTRAINT `fk_consent_consent_consent_workflow_tbl_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_workflow_tbl` ADD CONSTRAINT `fk_consent_consent_consent_workflow_tbl_consent_completed_by_employee_id` FOREIGN KEY (`consent_completed_by_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_workflow_tbl` ADD CONSTRAINT `fk_consent_consent_consent_workflow_tbl_consent_delegated_to_employee_id` FOREIGN KEY (`consent_delegated_to_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_workflow_tbl` ADD CONSTRAINT `fk_consent_consent_consent_workflow_tbl_consent_employee_id` FOREIGN KEY (`consent_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_workflow_tbl` ADD CONSTRAINT `fk_consent_consent_consent_workflow_tbl_consent_escalated_to_employee_id` FOREIGN KEY (`consent_escalated_to_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`consent_consent_workflow_tbl` ADD CONSTRAINT `fk_consent_consent_consent_workflow_tbl_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`workflow_template` ADD CONSTRAINT `fk_consent_workflow_template_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`workflow_template` ADD CONSTRAINT `fk_consent_workflow_template_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`consent`.`workflow_template` ADD CONSTRAINT `fk_consent_workflow_template_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);

-- ========= delta_tblproperties --> databricks_governance (2 constraint(s)) =========
-- Requires: delta_tblproperties schema, databricks_governance schema
ALTER TABLE `healthcare_ecm_v1`.`delta_tblproperties`.`delta_tblproperties_liquid_clustering_config` ADD CONSTRAINT `fk_delta_tblproperties_delta_tblproperties_liquid_clustering_config_databricks_governance_delta_tblproperties_id` FOREIGN KEY (`databricks_governance_delta_tblproperties_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`databricks_governance_delta_tblproperties`(`databricks_governance_delta_tblproperties_id`);
ALTER TABLE `healthcare_ecm_v1`.`delta_tblproperties`.`delta_tblproperties_liquid_clustering_config` ADD CONSTRAINT `fk_delta_tblproperties_delta_tblproperties_liquid_clustering_config_liquid_clustering_config_id` FOREIGN KEY (`liquid_clustering_config_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`liquid_clustering_config`(`liquid_clustering_config_id`);

-- ========= digital_health --> billing (1 constraint(s)) =========
-- Requires: digital_health schema, billing schema
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ADD CONSTRAINT `fk_digital_health_rpm_program_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `healthcare_ecm_v1`.`billing`.`cdm_entry`(`cdm_entry_id`);

-- ========= digital_health --> clinical (5 constraint(s)) =========
-- Requires: digital_health schema, clinical schema
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ADD CONSTRAINT `fk_digital_health_rpm_enrollment_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ADD CONSTRAINT `fk_digital_health_rpm_enrollment_care_team_id` FOREIGN KEY (`care_team_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`care_team`(`care_team_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ADD CONSTRAINT `fk_digital_health_rpm_enrollment_problem_id` FOREIGN KEY (`problem_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`problem`(`problem_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ADD CONSTRAINT `fk_digital_health_prom_response_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ADD CONSTRAINT `fk_digital_health_prom_response_problem_id` FOREIGN KEY (`problem_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`problem`(`problem_id`);

-- ========= digital_health --> clinical_ai (3 constraint(s)) =========
-- Requires: digital_health schema, clinical_ai schema
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ADD CONSTRAINT `fk_digital_health_rpm_enrollment_clinical_ai_patient_risk_score_id` FOREIGN KEY (`clinical_ai_patient_risk_score_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score`(`clinical_ai_patient_risk_score_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ADD CONSTRAINT `fk_digital_health_health_alert_clinical_ai_model_card_id` FOREIGN KEY (`clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ADD CONSTRAINT `fk_digital_health_health_alert_clinical_ai_model_inference_log_id` FOREIGN KEY (`clinical_ai_model_inference_log_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log`(`clinical_ai_model_inference_log_id`);

-- ========= digital_health --> compliance (2 constraint(s)) =========
-- Requires: digital_health schema, compliance schema
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_events` ADD CONSTRAINT `fk_digital_health_portal_engagement_events_phi_access_log_id` FOREIGN KEY (`phi_access_log_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`phi_access_log`(`phi_access_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ADD CONSTRAINT `fk_digital_health_rpm_program_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_program`(`compliance_program_id`);

-- ========= digital_health --> consent (4 constraint(s)) =========
-- Requires: digital_health schema, consent schema
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_events` ADD CONSTRAINT `fk_digital_health_portal_engagement_events_consent_session_id` FOREIGN KEY (`consent_session_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_session`(`consent_session_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ADD CONSTRAINT `fk_digital_health_rpm_program_consent_form_template_id` FOREIGN KEY (`consent_form_template_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_form_template`(`consent_form_template_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ADD CONSTRAINT `fk_digital_health_rpm_enrollment_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement` ADD CONSTRAINT `fk_digital_health_portal_engagement_consent_session_id` FOREIGN KEY (`consent_session_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_session`(`consent_session_id`);

-- ========= digital_health --> encounter (9 constraint(s)) =========
-- Requires: digital_health schema, encounter schema
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_readings` ADD CONSTRAINT `fk_digital_health_rpm_device_readings_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_responses` ADD CONSTRAINT `fk_digital_health_prom_responses_episode_of_care_visit_id` FOREIGN KEY (`episode_of_care_visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_responses` ADD CONSTRAINT `fk_digital_health_prom_responses_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_events` ADD CONSTRAINT `fk_digital_health_portal_engagement_events_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ADD CONSTRAINT `fk_digital_health_rpm_reading_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ADD CONSTRAINT `fk_digital_health_prom_response_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ADD CONSTRAINT `fk_digital_health_health_alert_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_reading` ADD CONSTRAINT `fk_digital_health_rpm_device_reading_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement` ADD CONSTRAINT `fk_digital_health_portal_engagement_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);

-- ========= digital_health --> facility (9 constraint(s)) =========
-- Requires: digital_health schema, facility schema
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_events` ADD CONSTRAINT `fk_digital_health_portal_engagement_events_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ADD CONSTRAINT `fk_digital_health_device_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ADD CONSTRAINT `fk_digital_health_device_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ADD CONSTRAINT `fk_digital_health_device_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ADD CONSTRAINT `fk_digital_health_rpm_program_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ADD CONSTRAINT `fk_digital_health_rpm_enrollment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ADD CONSTRAINT `fk_digital_health_prom_questionnaire_facility_organization_id` FOREIGN KEY (`facility_organization_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`facility_organization`(`facility_organization_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ADD CONSTRAINT `fk_digital_health_prom_response_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement` ADD CONSTRAINT `fk_digital_health_portal_engagement_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= digital_health --> finance (2 constraint(s)) =========
-- Requires: digital_health schema, finance schema
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ADD CONSTRAINT `fk_digital_health_device_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ADD CONSTRAINT `fk_digital_health_rpm_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= digital_health --> insurance (3 constraint(s)) =========
-- Requires: digital_health schema, insurance schema
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ADD CONSTRAINT `fk_digital_health_rpm_program_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ADD CONSTRAINT `fk_digital_health_rpm_program_insurance_coverage_policy_id` FOREIGN KEY (`insurance_coverage_policy_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`insurance_coverage_policy`(`insurance_coverage_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ADD CONSTRAINT `fk_digital_health_rpm_enrollment_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`member_enrollment`(`member_enrollment_id`);

-- ========= digital_health --> interoperability (2 constraint(s)) =========
-- Requires: digital_health schema, interoperability schema
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ADD CONSTRAINT `fk_digital_health_device_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ADD CONSTRAINT `fk_digital_health_rpm_enrollment_data_sharing_agreement_id` FOREIGN KEY (`data_sharing_agreement_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`data_sharing_agreement`(`data_sharing_agreement_id`);

-- ========= digital_health --> laboratory (1 constraint(s)) =========
-- Requires: digital_health schema, laboratory schema
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`program_monitoring_requirement` ADD CONSTRAINT `fk_digital_health_program_monitoring_requirement_test_catalog_id` FOREIGN KEY (`test_catalog_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`test_catalog`(`test_catalog_id`);

-- ========= digital_health --> order (2 constraint(s)) =========
-- Requires: digital_health schema, order schema
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ADD CONSTRAINT `fk_digital_health_rpm_enrollment_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ADD CONSTRAINT `fk_digital_health_prom_response_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= digital_health --> patient (18 constraint(s)) =========
-- Requires: digital_health schema, patient schema
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_readings` ADD CONSTRAINT `fk_digital_health_rpm_device_readings_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_responses` ADD CONSTRAINT `fk_digital_health_prom_responses_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_events` ADD CONSTRAINT `fk_digital_health_portal_engagement_events_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_events` ADD CONSTRAINT `fk_digital_health_portal_engagement_events_proxy_access_id` FOREIGN KEY (`proxy_access_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`proxy_access`(`proxy_access_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`digital_health_patient_engagement` ADD CONSTRAINT `fk_digital_health_digital_health_patient_engagement_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`digital_health_patient_engagement` ADD CONSTRAINT `fk_digital_health_digital_health_patient_engagement_portal_account_id` FOREIGN KEY (`portal_account_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`portal_account`(`portal_account_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ADD CONSTRAINT `fk_digital_health_device_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ADD CONSTRAINT `fk_digital_health_rpm_program_care_program_id` FOREIGN KEY (`care_program_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`care_program`(`care_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ADD CONSTRAINT `fk_digital_health_rpm_enrollment_care_program_enrollment_id` FOREIGN KEY (`care_program_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`care_program_enrollment`(`care_program_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ADD CONSTRAINT `fk_digital_health_rpm_enrollment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ADD CONSTRAINT `fk_digital_health_rpm_reading_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ADD CONSTRAINT `fk_digital_health_rpm_alert_threshold_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ADD CONSTRAINT `fk_digital_health_prom_response_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` ADD CONSTRAINT `fk_digital_health_portal_engagement_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` ADD CONSTRAINT `fk_digital_health_portal_engagement_event_portal_account_id` FOREIGN KEY (`portal_account_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`portal_account`(`portal_account_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ADD CONSTRAINT `fk_digital_health_health_alert_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_reading` ADD CONSTRAINT `fk_digital_health_rpm_device_reading_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement` ADD CONSTRAINT `fk_digital_health_portal_engagement_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= digital_health --> population_health_cohort (2 constraint(s)) =========
-- Requires: digital_health schema, population_health_cohort schema
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ADD CONSTRAINT `fk_digital_health_rpm_enrollment_population_health_cohort_cohort_definition_id` FOREIGN KEY (`population_health_cohort_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_definition`(`population_health_cohort_cohort_definition_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`cohort_program_assignment` ADD CONSTRAINT `fk_digital_health_cohort_program_assignment_population_health_cohort_cohort_definition_id` FOREIGN KEY (`population_health_cohort_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_definition`(`population_health_cohort_cohort_definition_id`);

-- ========= digital_health --> population_health_cohort_management (1 constraint(s)) =========
-- Requires: digital_health schema, population_health_cohort_management schema
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ADD CONSTRAINT `fk_digital_health_rpm_enrollment_population_health_cohort_management_cohort_membership_id` FOREIGN KEY (`population_health_cohort_management_cohort_membership_id`) REFERENCES `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_membership`(`population_health_cohort_management_cohort_membership_id`);

-- ========= digital_health --> population_health_cohort_mgmt (2 constraint(s)) =========
-- Requires: digital_health schema, population_health_cohort_mgmt schema
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ADD CONSTRAINT `fk_digital_health_rpm_program_population_health_cohort_mgmt_cohort_definition_id` FOREIGN KEY (`population_health_cohort_mgmt_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_definition`(`population_health_cohort_mgmt_cohort_definition_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ADD CONSTRAINT `fk_digital_health_rpm_enrollment_population_health_cohort_mgmt_cohort_definition_id` FOREIGN KEY (`population_health_cohort_mgmt_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_definition`(`population_health_cohort_mgmt_cohort_definition_id`);

-- ========= digital_health --> post_acute_care (3 constraint(s)) =========
-- Requires: digital_health schema, post_acute_care schema
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ADD CONSTRAINT `fk_digital_health_rpm_enrollment_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ADD CONSTRAINT `fk_digital_health_prom_response_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ADD CONSTRAINT `fk_digital_health_health_alert_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);

-- ========= digital_health --> provider (11 constraint(s)) =========
-- Requires: digital_health schema, provider schema
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_readings` ADD CONSTRAINT `fk_digital_health_rpm_device_readings_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_readings` ADD CONSTRAINT `fk_digital_health_rpm_device_readings_rpm_reviewing_provider_clinician_id` FOREIGN KEY (`rpm_reviewing_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_responses` ADD CONSTRAINT `fk_digital_health_prom_responses_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_events` ADD CONSTRAINT `fk_digital_health_portal_engagement_events_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ADD CONSTRAINT `fk_digital_health_rpm_program_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ADD CONSTRAINT `fk_digital_health_rpm_enrollment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ADD CONSTRAINT `fk_digital_health_rpm_alert_threshold_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ADD CONSTRAINT `fk_digital_health_prom_response_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ADD CONSTRAINT `fk_digital_health_health_alert_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_reading` ADD CONSTRAINT `fk_digital_health_rpm_device_reading_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement` ADD CONSTRAINT `fk_digital_health_portal_engagement_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= digital_health --> reference (8 constraint(s)) =========
-- Requires: digital_health schema, reference schema
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ADD CONSTRAINT `fk_digital_health_rpm_program_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ADD CONSTRAINT `fk_digital_health_rpm_program_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ADD CONSTRAINT `fk_digital_health_rpm_reading_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ADD CONSTRAINT `fk_digital_health_rpm_alert_threshold_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ADD CONSTRAINT `fk_digital_health_prom_questionnaire_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ADD CONSTRAINT `fk_digital_health_prom_questionnaire_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ADD CONSTRAINT `fk_digital_health_health_alert_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`program_metric` ADD CONSTRAINT `fk_digital_health_program_metric_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`loinc_code`(`loinc_code_id`);

-- ========= digital_health --> research (3 constraint(s)) =========
-- Requires: digital_health schema, research schema
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ADD CONSTRAINT `fk_digital_health_rpm_program_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ADD CONSTRAINT `fk_digital_health_prom_response_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ADD CONSTRAINT `fk_digital_health_prom_response_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);

-- ========= digital_health --> scheduling (3 constraint(s)) =========
-- Requires: digital_health schema, scheduling schema
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ADD CONSTRAINT `fk_digital_health_rpm_enrollment_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ADD CONSTRAINT `fk_digital_health_prom_response_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` ADD CONSTRAINT `fk_digital_health_portal_engagement_event_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);

-- ========= digital_health --> supply (2 constraint(s)) =========
-- Requires: digital_health schema, supply schema
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ADD CONSTRAINT `fk_digital_health_device_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ADD CONSTRAINT `fk_digital_health_device_udi_record_id` FOREIGN KEY (`udi_record_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`udi_record`(`udi_record_id`);

-- ========= digital_health --> workforce (4 constraint(s)) =========
-- Requires: digital_health schema, workforce schema
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ADD CONSTRAINT `fk_digital_health_rpm_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ADD CONSTRAINT `fk_digital_health_rpm_alert_threshold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ADD CONSTRAINT `fk_digital_health_rpm_alert_threshold_rpm_employee_id` FOREIGN KEY (`rpm_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ADD CONSTRAINT `fk_digital_health_health_alert_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);

-- ========= encounter --> clinical (2 constraint(s)) =========
-- Requires: encounter schema, clinical schema
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`procedure_event`(`procedure_event_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_note_id` FOREIGN KEY (`note_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`note`(`note_id`);

-- ========= encounter --> clinical_ai (1 constraint(s)) =========
-- Requires: encounter schema, clinical_ai schema
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_clinical_ai_patient_risk_score_id` FOREIGN KEY (`clinical_ai_patient_risk_score_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score`(`clinical_ai_patient_risk_score_id`);

-- ========= encounter --> compliance (4 constraint(s)) =========
-- Requires: encounter schema, compliance schema
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_training_completion_id` FOREIGN KEY (`training_completion_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`training_completion`(`training_completion_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_stark_arrangement_id` FOREIGN KEY (`stark_arrangement_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`stark_arrangement`(`stark_arrangement_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`triage_assessment` ADD CONSTRAINT `fk_encounter_triage_assessment_osha_exposure_incident_id` FOREIGN KEY (`osha_exposure_incident_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`osha_exposure_incident`(`osha_exposure_incident_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);

-- ========= encounter --> facility (16 constraint(s)) =========
-- Requires: encounter schema, facility schema
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_visit_care_site_id` FOREIGN KEY (`visit_care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`bed_assignment` ADD CONSTRAINT `fk_encounter_bed_assignment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`bed_assignment` ADD CONSTRAINT `fk_encounter_bed_assignment_bed_id` FOREIGN KEY (`bed_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`bed`(`bed_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_status_history` ADD CONSTRAINT `fk_encounter_visit_status_history_bed_id` FOREIGN KEY (`bed_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`bed`(`bed_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_status_history` ADD CONSTRAINT `fk_encounter_visit_status_history_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`triage_assessment` ADD CONSTRAINT `fk_encounter_triage_assessment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`transfer_request` ADD CONSTRAINT `fk_encounter_transfer_request_bed_id` FOREIGN KEY (`bed_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`bed`(`bed_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`transfer_request` ADD CONSTRAINT `fk_encounter_transfer_request_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`transfer_request` ADD CONSTRAINT `fk_encounter_transfer_request_origin_bed_id` FOREIGN KEY (`origin_bed_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`bed`(`bed_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`transfer_request` ADD CONSTRAINT `fk_encounter_transfer_request_primary_transfer_care_site_id` FOREIGN KEY (`primary_transfer_care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= encounter --> finance (8 constraint(s)) =========
-- Requires: encounter schema, finance schema
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`encounter_authorization` ADD CONSTRAINT `fk_encounter_encounter_authorization_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`transfer_request` ADD CONSTRAINT `fk_encounter_transfer_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= encounter --> insurance (12 constraint(s)) =========
-- Requires: encounter schema, insurance schema
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_insurance_network_participation_id` FOREIGN KEY (`insurance_network_participation_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`insurance_network_participation`(`insurance_network_participation_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`encounter_authorization` ADD CONSTRAINT `fk_encounter_encounter_authorization_insurance_coverage_policy_id` FOREIGN KEY (`insurance_coverage_policy_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`insurance_coverage_policy`(`insurance_coverage_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`encounter_authorization` ADD CONSTRAINT `fk_encounter_encounter_authorization_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`encounter_authorization` ADD CONSTRAINT `fk_encounter_encounter_authorization_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_coverage` ADD CONSTRAINT `fk_encounter_visit_coverage_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);

-- ========= encounter --> interoperability (6 constraint(s)) =========
-- Requires: encounter schema, interoperability schema
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`adt_event` ADD CONSTRAINT `fk_encounter_adt_event_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`encounter_authorization` ADD CONSTRAINT `fk_encounter_encounter_authorization_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_status_history` ADD CONSTRAINT `fk_encounter_visit_status_history_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_care_transition_notification_id` FOREIGN KEY (`care_transition_notification_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`care_transition_notification`(`care_transition_notification_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`cda_document`(`cda_document_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`transfer_request` ADD CONSTRAINT `fk_encounter_transfer_request_care_transition_notification_id` FOREIGN KEY (`care_transition_notification_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`care_transition_notification`(`care_transition_notification_id`);

-- ========= encounter --> order (3 constraint(s)) =========
-- Requires: encounter schema, order schema
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_referral_order_id` FOREIGN KEY (`referral_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`referral_order`(`referral_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`triage_assessment` ADD CONSTRAINT `fk_encounter_triage_assessment_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= encounter --> patient (21 constraint(s)) =========
-- Requires: encounter schema, patient schema
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_visit_mpi_record_id` FOREIGN KEY (`visit_mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`adt_event` ADD CONSTRAINT `fk_encounter_adt_event_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`bed_assignment` ADD CONSTRAINT `fk_encounter_bed_assignment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_insurance` ADD CONSTRAINT `fk_encounter_visit_insurance_visit_mpi_record_id` FOREIGN KEY (`visit_mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`encounter_authorization` ADD CONSTRAINT `fk_encounter_encounter_authorization_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_status_history` ADD CONSTRAINT `fk_encounter_visit_status_history_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`triage_assessment` ADD CONSTRAINT `fk_encounter_triage_assessment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_discharge_mpi_record_id` FOREIGN KEY (`discharge_mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`transfer_request` ADD CONSTRAINT `fk_encounter_transfer_request_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= encounter --> post_acute_care (4 constraint(s)) =========
-- Requires: encounter schema, post_acute_care schema
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_referral_id` FOREIGN KEY (`referral_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`referral`(`referral_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`transfer_request` ADD CONSTRAINT `fk_encounter_transfer_request_post_acute_location_id` FOREIGN KEY (`post_acute_location_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location`(`post_acute_location_id`);

-- ========= encounter --> provider (24 constraint(s)) =========
-- Requires: encounter schema, provider schema
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_tertiary_visit_discharging_provider_clinician_id` FOREIGN KEY (`tertiary_visit_discharging_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_visit_admitting_clinician_id` FOREIGN KEY (`visit_admitting_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_visit_discharge_clinician_id` FOREIGN KEY (`visit_discharge_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_admitting_clinician_id` FOREIGN KEY (`admitting_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_discharge_clinician_id` FOREIGN KEY (`discharge_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`adt_event` ADD CONSTRAINT `fk_encounter_adt_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_network_affiliation_id` FOREIGN KEY (`network_affiliation_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`network_affiliation`(`network_affiliation_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_provider_payer_enrollment_id` FOREIGN KEY (`provider_payer_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`provider_payer_enrollment`(`provider_payer_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_tertiary_visit_supervising_provider_clinician_id` FOREIGN KEY (`tertiary_visit_supervising_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_privileging_id` FOREIGN KEY (`privileging_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`privileging`(`privileging_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`bed_assignment` ADD CONSTRAINT `fk_encounter_bed_assignment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`encounter_authorization` ADD CONSTRAINT `fk_encounter_encounter_authorization_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_status_history` ADD CONSTRAINT `fk_encounter_visit_status_history_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`triage_assessment` ADD CONSTRAINT `fk_encounter_triage_assessment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_tertiary_discharge_follow_up_provider_clinician_id` FOREIGN KEY (`tertiary_discharge_follow_up_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`transfer_request` ADD CONSTRAINT `fk_encounter_transfer_request_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_recall_impact` ADD CONSTRAINT `fk_encounter_visit_recall_impact_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= encounter --> radiology (1 constraint(s)) =========
-- Requires: encounter schema, radiology schema
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_interventional_procedure_id` FOREIGN KEY (`interventional_procedure_id`) REFERENCES `healthcare_ecm_v1`.`radiology`.`interventional_procedure`(`interventional_procedure_id`);

-- ========= encounter --> reference (17 constraint(s)) =========
-- Requires: encounter schema, reference schema
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit` ADD CONSTRAINT `fk_encounter_visit_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`adt_event` ADD CONSTRAINT `fk_encounter_adt_event_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`encounter_authorization` ADD CONSTRAINT `fk_encounter_encounter_authorization_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`encounter_authorization` ADD CONSTRAINT `fk_encounter_encounter_authorization_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`encounter_authorization` ADD CONSTRAINT `fk_encounter_encounter_authorization_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`encounter_authorization` ADD CONSTRAINT `fk_encounter_encounter_authorization_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`triage_assessment` ADD CONSTRAINT `fk_encounter_triage_assessment_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`triage_assessment` ADD CONSTRAINT `fk_encounter_triage_assessment_acuity_level_code_id` FOREIGN KEY (`acuity_level_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`readmission` ADD CONSTRAINT `fk_encounter_readmission_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);

-- ========= encounter --> research (4 constraint(s)) =========
-- Requires: encounter schema, research schema
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`encounter_authorization` ADD CONSTRAINT `fk_encounter_encounter_authorization_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);

-- ========= encounter --> supply (5 constraint(s)) =========
-- Requires: encounter schema, supply schema
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_diagnosis` ADD CONSTRAINT `fk_encounter_visit_diagnosis_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_procedure` ADD CONSTRAINT `fk_encounter_visit_procedure_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`bed_assignment` ADD CONSTRAINT `fk_encounter_bed_assignment_inventory_location_id` FOREIGN KEY (`inventory_location_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`inventory_location`(`inventory_location_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`encounter_authorization` ADD CONSTRAINT `fk_encounter_encounter_authorization_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_recall_impact` ADD CONSTRAINT `fk_encounter_visit_recall_impact_recall_notice_id` FOREIGN KEY (`recall_notice_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`recall_notice`(`recall_notice_id`);

-- ========= encounter --> workforce (10 constraint(s)) =========
-- Requires: encounter schema, workforce schema
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`adt_event` ADD CONSTRAINT `fk_encounter_adt_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_provider` ADD CONSTRAINT `fk_encounter_visit_provider_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`drg_assignment` ADD CONSTRAINT `fk_encounter_drg_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`bed_assignment` ADD CONSTRAINT `fk_encounter_bed_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`encounter_authorization` ADD CONSTRAINT `fk_encounter_encounter_authorization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_status_history` ADD CONSTRAINT `fk_encounter_visit_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`visit_status_history` ADD CONSTRAINT `fk_encounter_visit_status_history_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`triage_assessment` ADD CONSTRAINT `fk_encounter_triage_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`discharge_summary` ADD CONSTRAINT `fk_encounter_discharge_summary_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`encounter`.`transfer_request` ADD CONSTRAINT `fk_encounter_transfer_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);

-- ========= facility --> compliance (3 constraint(s)) =========
-- Requires: facility schema, compliance schema
ALTER TABLE `healthcare_ecm_v1`.`facility`.`license_accreditation` ADD CONSTRAINT `fk_facility_license_accreditation_accreditation_status_id` FOREIGN KEY (`accreditation_status_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`accreditation_status`(`accreditation_status_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`facility_contract` ADD CONSTRAINT `fk_facility_facility_contract_business_associate_agreement_id` FOREIGN KEY (`business_associate_agreement_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`business_associate_agreement`(`business_associate_agreement_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`safety_incident` ADD CONSTRAINT `fk_facility_safety_incident_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`investigation`(`investigation_id`);

-- ========= facility --> encounter (2 constraint(s)) =========
-- Requires: facility schema, encounter schema
ALTER TABLE `healthcare_ecm_v1`.`facility`.`bed` ADD CONSTRAINT `fk_facility_bed_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`bed_status_event` ADD CONSTRAINT `fk_facility_bed_status_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);

-- ========= facility --> finance (6 constraint(s)) =========
-- Requires: facility schema, finance schema
ALTER TABLE `healthcare_ecm_v1`.`facility`.`unit` ADD CONSTRAINT `fk_facility_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`room` ADD CONSTRAINT `fk_facility_room_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`maintenance_order` ADD CONSTRAINT `fk_facility_maintenance_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`space_allocation` ADD CONSTRAINT `fk_facility_space_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`facility_service` ADD CONSTRAINT `fk_facility_facility_service_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`facility_contract` ADD CONSTRAINT `fk_facility_facility_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= facility --> insurance (1 constraint(s)) =========
-- Requires: facility schema, insurance schema
ALTER TABLE `healthcare_ecm_v1`.`facility`.`network_contract` ADD CONSTRAINT `fk_facility_network_contract_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);

-- ========= facility --> patient (5 constraint(s)) =========
-- Requires: facility schema, patient schema
ALTER TABLE `healthcare_ecm_v1`.`facility`.`bed` ADD CONSTRAINT `fk_facility_bed_bed_mpi_record_id` FOREIGN KEY (`bed_mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`bed` ADD CONSTRAINT `fk_facility_bed_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`bed` ADD CONSTRAINT `fk_facility_bed_current_patient_mpi_record_id` FOREIGN KEY (`current_patient_mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`bed_status_event` ADD CONSTRAINT `fk_facility_bed_status_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`safety_incident` ADD CONSTRAINT `fk_facility_safety_incident_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= facility --> provider (2 constraint(s)) =========
-- Requires: facility schema, provider schema
ALTER TABLE `healthcare_ecm_v1`.`facility`.`unit` ADD CONSTRAINT `fk_facility_unit_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`facility_service` ADD CONSTRAINT `fk_facility_facility_service_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= facility --> quality (1 constraint(s)) =========
-- Requires: facility schema, quality schema
ALTER TABLE `healthcare_ecm_v1`.`facility`.`facility_program_participation` ADD CONSTRAINT `fk_facility_facility_program_participation_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`quality_program`(`quality_program_id`);

-- ========= facility --> reference (2 constraint(s)) =========
-- Requires: facility schema, reference schema
ALTER TABLE `healthcare_ecm_v1`.`facility`.`care_site` ADD CONSTRAINT `fk_facility_care_site_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`building` ADD CONSTRAINT `fk_facility_building_geographic_region_id` FOREIGN KEY (`geographic_region_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`geographic_region`(`geographic_region_id`);

-- ========= facility --> supply (3 constraint(s)) =========
-- Requires: facility schema, supply schema
ALTER TABLE `healthcare_ecm_v1`.`facility`.`maintenance_order` ADD CONSTRAINT `fk_facility_maintenance_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`facility_contract` ADD CONSTRAINT `fk_facility_facility_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`safety_incident` ADD CONSTRAINT `fk_facility_safety_incident_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);

-- ========= facility --> workforce (21 constraint(s)) =========
-- Requires: facility schema, workforce schema
ALTER TABLE `healthcare_ecm_v1`.`facility`.`room` ADD CONSTRAINT `fk_facility_room_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`bed_status_event` ADD CONSTRAINT `fk_facility_bed_status_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`equipment_asset` ADD CONSTRAINT `fk_facility_equipment_asset_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`maintenance_order` ADD CONSTRAINT `fk_facility_maintenance_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`maintenance_order` ADD CONSTRAINT `fk_facility_maintenance_order_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`facility_inspection` ADD CONSTRAINT `fk_facility_facility_inspection_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`inspection_finding` ADD CONSTRAINT `fk_facility_inspection_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`inspection_finding` ADD CONSTRAINT `fk_facility_inspection_finding_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`space_allocation` ADD CONSTRAINT `fk_facility_space_allocation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`environmental_service_request` ADD CONSTRAINT `fk_facility_environmental_service_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`environmental_service_request` ADD CONSTRAINT `fk_facility_environmental_service_request_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`environmental_service_request` ADD CONSTRAINT `fk_facility_environmental_service_request_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`facility_service` ADD CONSTRAINT `fk_facility_facility_service_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`hazardous_material` ADD CONSTRAINT `fk_facility_hazardous_material_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`safety_incident` ADD CONSTRAINT `fk_facility_safety_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`safety_incident` ADD CONSTRAINT `fk_facility_safety_incident_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`site_hierarchy` ADD CONSTRAINT `fk_facility_site_hierarchy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`facility_program_participation` ADD CONSTRAINT `fk_facility_facility_program_participation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`block_assignment` ADD CONSTRAINT `fk_facility_block_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`equipment_authorization` ADD CONSTRAINT `fk_facility_equipment_authorization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`facility`.`equipment_authorization` ADD CONSTRAINT `fk_facility_equipment_authorization_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);

-- ========= finance --> facility (13 constraint(s)) =========
-- Requires: finance schema, facility schema
ALTER TABLE `healthcare_ecm_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`capital_expenditure` ADD CONSTRAINT `fk_finance_capital_expenditure_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`fund` ADD CONSTRAINT `fk_finance_fund_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`donor` ADD CONSTRAINT `fk_finance_donor_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`finance_asset_book` ADD CONSTRAINT `fk_finance_finance_asset_book_facility_organization_id` FOREIGN KEY (`facility_organization_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`facility_organization`(`facility_organization_id`);

-- ========= finance --> post_acute_care (1 constraint(s)) =========
-- Requires: finance schema, post_acute_care schema
ALTER TABLE `healthcare_ecm_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);

-- ========= finance --> provider (1 constraint(s)) =========
-- Requires: finance schema, provider schema
ALTER TABLE `healthcare_ecm_v1`.`finance`.`fund_allocation` ADD CONSTRAINT `fk_finance_fund_allocation_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`org_provider`(`org_provider_id`);

-- ========= finance --> radiology (1 constraint(s)) =========
-- Requires: finance schema, radiology schema
ALTER TABLE `healthcare_ecm_v1`.`finance`.`capital_expenditure` ADD CONSTRAINT `fk_finance_capital_expenditure_modality_id` FOREIGN KEY (`modality_id`) REFERENCES `healthcare_ecm_v1`.`radiology`.`modality`(`modality_id`);

-- ========= finance --> reference (1 constraint(s)) =========
-- Requires: finance schema, reference schema
ALTER TABLE `healthcare_ecm_v1`.`finance`.`finance_journal_entry_line` ADD CONSTRAINT `fk_finance_finance_journal_entry_line_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`drg`(`drg_id`);

-- ========= finance --> research (1 constraint(s)) =========
-- Requires: finance schema, research schema
ALTER TABLE `healthcare_ecm_v1`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_research_grant_award_id` FOREIGN KEY (`research_grant_award_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_grant_award`(`research_grant_award_id`);

-- ========= finance --> supply (7 constraint(s)) =========
-- Requires: finance schema, supply schema
ALTER TABLE `healthcare_ecm_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_vendor_site_id` FOREIGN KEY (`vendor_site_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`vendor_site`(`vendor_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_purchase_order_line_id` FOREIGN KEY (`purchase_order_line_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`purchase_order_line`(`purchase_order_line_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`capital_expenditure` ADD CONSTRAINT `fk_finance_capital_expenditure_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`vendor`(`vendor_id`);

-- ========= finance --> workforce (69 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `healthcare_ecm_v1`.`finance`.`finance_journal_entry` ADD CONSTRAINT `fk_finance_finance_journal_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`finance_journal_entry` ADD CONSTRAINT `fk_finance_finance_journal_entry_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`finance_journal_entry_line` ADD CONSTRAINT `fk_finance_finance_journal_entry_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`finance_journal_entry_line` ADD CONSTRAINT `fk_finance_finance_journal_entry_line_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_fte_budget_id` FOREIGN KEY (`fte_budget_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`fte_budget`(`fte_budget_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_position_id` FOREIGN KEY (`position_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_approved_by_employee_id` FOREIGN KEY (`approved_by_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`finance_budget_transfer` ADD CONSTRAINT `fk_finance_finance_budget_transfer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`finance_budget_transfer` ADD CONSTRAINT `fk_finance_finance_budget_transfer_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`finance_budget_transfer` ADD CONSTRAINT `fk_finance_finance_budget_transfer_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_requester_employee_id` FOREIGN KEY (`requester_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_approved_by_employee_id` FOREIGN KEY (`approved_by_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_requester_employee_id` FOREIGN KEY (`requester_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`ar_account` ADD CONSTRAINT `fk_finance_ar_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`ar_account` ADD CONSTRAINT `fk_finance_ar_account_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`finance_ar_transaction` ADD CONSTRAINT `fk_finance_finance_ar_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`capital_expenditure` ADD CONSTRAINT `fk_finance_capital_expenditure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`capital_expenditure` ADD CONSTRAINT `fk_finance_capital_expenditure_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`capital_expenditure` ADD CONSTRAINT `fk_finance_capital_expenditure_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`allocation_method` ADD CONSTRAINT `fk_finance_allocation_method_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`allocation_method` ADD CONSTRAINT `fk_finance_allocation_method_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`allocation_method` ADD CONSTRAINT `fk_finance_allocation_method_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`finance_bank_reconciliation` ADD CONSTRAINT `fk_finance_finance_bank_reconciliation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`finance_bank_reconciliation` ADD CONSTRAINT `fk_finance_finance_bank_reconciliation_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`financial_period_close` ADD CONSTRAINT `fk_finance_financial_period_close_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`fund` ADD CONSTRAINT `fk_finance_fund_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`financial_forecast` ADD CONSTRAINT `fk_finance_financial_forecast_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`invoice_payment_application` ADD CONSTRAINT `fk_finance_invoice_payment_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`fund_allocation` ADD CONSTRAINT `fk_finance_fund_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`payment_batch` ADD CONSTRAINT `fk_finance_payment_batch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`payment_batch` ADD CONSTRAINT `fk_finance_payment_batch_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`transaction_batch` ADD CONSTRAINT `fk_finance_transaction_batch_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`transaction_batch` ADD CONSTRAINT `fk_finance_transaction_batch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`transaction_batch` ADD CONSTRAINT `fk_finance_transaction_batch_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`transaction_batch` ADD CONSTRAINT `fk_finance_transaction_batch_transaction_employee_id` FOREIGN KEY (`transaction_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`allocation_run` ADD CONSTRAINT `fk_finance_allocation_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`allocation_run` ADD CONSTRAINT `fk_finance_allocation_run_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`intercompany_agreement` ADD CONSTRAINT `fk_finance_intercompany_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`recurring_schedule` ADD CONSTRAINT `fk_finance_recurring_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`recurring_schedule` ADD CONSTRAINT `fk_finance_recurring_schedule_recurring_employee_id` FOREIGN KEY (`recurring_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`recurring_schedule` ADD CONSTRAINT `fk_finance_recurring_schedule_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`finance_asset_book` ADD CONSTRAINT `fk_finance_finance_asset_book_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`finance_asset_book` ADD CONSTRAINT `fk_finance_finance_asset_book_finance_employee_id` FOREIGN KEY (`finance_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`finance_asset_book` ADD CONSTRAINT `fk_finance_finance_asset_book_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`finance_asset_book` ADD CONSTRAINT `fk_finance_finance_asset_book_quaternary_finance_responsible_bigint_surrogate_key_for_clean_keying` FOREIGN KEY (`quaternary_finance_responsible_bigint_surrogate_key_for_clean_keying`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`finance`.`finance_asset_book` ADD CONSTRAINT `fk_finance_finance_asset_book_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);

-- ========= fk --> encounter (1 constraint(s)) =========
-- Requires: fk schema, encounter schema
ALTER TABLE `healthcare_ecm_v1`.`fk`.`new_connections` ADD CONSTRAINT `fk_fk_new_connections_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);

-- ========= fk --> insurance (1 constraint(s)) =========
-- Requires: fk schema, insurance schema
ALTER TABLE `healthcare_ecm_v1`.`fk`.`new_connections` ADD CONSTRAINT `fk_fk_new_connections_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`provider_network`(`provider_network_id`);

-- ========= fk --> order (1 constraint(s)) =========
-- Requires: fk schema, order schema
ALTER TABLE `healthcare_ecm_v1`.`fk`.`new_connections` ADD CONSTRAINT `fk_fk_new_connections_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= genomics --> billing (1 constraint(s)) =========
-- Requires: genomics schema, billing schema
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ADD CONSTRAINT `fk_genomics_genomics_genomic_order_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `healthcare_ecm_v1`.`billing`.`cdm_entry`(`cdm_entry_id`);

-- ========= genomics --> clinical (5 constraint(s)) =========
-- Requires: genomics schema, clinical schema
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ADD CONSTRAINT `fk_genomics_genomic_order_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ADD CONSTRAINT `fk_genomics_genomics_genomic_order_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ADD CONSTRAINT `fk_genomics_genomic_report_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ADD CONSTRAINT `fk_genomics_genomic_interpretation_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`test_order` ADD CONSTRAINT `fk_genomics_test_order_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`diagnosis`(`diagnosis_id`);

-- ========= genomics --> clinical_trial_matching (3 constraint(s)) =========
-- Requires: genomics schema, clinical_trial_matching schema
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ADD CONSTRAINT `fk_genomics_genomics_genomic_order_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`trial`(`trial_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ADD CONSTRAINT `fk_genomics_precision_treatment_plan_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`trial`(`trial_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_trial_eligibility_match` ADD CONSTRAINT `fk_genomics_genomics_trial_eligibility_match_trial_match_id` FOREIGN KEY (`trial_match_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`trial_match`(`trial_match_id`);

-- ========= genomics --> consent (5 constraint(s)) =========
-- Requires: genomics schema, consent schema
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ADD CONSTRAINT `fk_genomics_genomic_sequence_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ADD CONSTRAINT `fk_genomics_genomics_genomic_consent_consent_form_template_id` FOREIGN KEY (`consent_form_template_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_form_template`(`consent_form_template_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ADD CONSTRAINT `fk_genomics_genomics_genomic_consent_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ADD CONSTRAINT `fk_genomics_precision_trial_enroll_research_consent_id` FOREIGN KEY (`research_consent_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`research_consent`(`research_consent_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_profile` ADD CONSTRAINT `fk_genomics_patient_profile_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);

-- ========= genomics --> databricks_governance (4 constraint(s)) =========
-- Requires: genomics schema, databricks_governance schema
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ADD CONSTRAINT `fk_genomics_genomics_genomic_order_hipaa_retention_annotation_id` FOREIGN KEY (`hipaa_retention_annotation_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention_annotation`(`hipaa_retention_annotation_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ADD CONSTRAINT `fk_genomics_genomics_sequencing_run_hipaa_retention_annotation_id` FOREIGN KEY (`hipaa_retention_annotation_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention_annotation`(`hipaa_retention_annotation_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ADD CONSTRAINT `fk_genomics_genomics_genomic_sequence_hipaa_retention_annotation_id` FOREIGN KEY (`hipaa_retention_annotation_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention_annotation`(`hipaa_retention_annotation_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ADD CONSTRAINT `fk_genomics_genomic_report_hipaa_retention_annotation_id` FOREIGN KEY (`hipaa_retention_annotation_id`) REFERENCES `healthcare_ecm_v1`.`databricks_governance`.`hipaa_retention_annotation`(`hipaa_retention_annotation_id`);

-- ========= genomics --> encounter (32 constraint(s)) =========
-- Requires: genomics schema, encounter schema
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ADD CONSTRAINT `fk_genomics_variant_interpretation_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ADD CONSTRAINT `fk_genomics_genomic_sequence_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_annotation` ADD CONSTRAINT `fk_genomics_variant_annotation_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ADD CONSTRAINT `fk_genomics_patient_genomic_profile_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ADD CONSTRAINT `fk_genomics_sequencing_result_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` ADD CONSTRAINT `fk_genomics_genomic_consent_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_trial` ADD CONSTRAINT `fk_genomics_precision_medicine_trial_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ADD CONSTRAINT `fk_genomics_genomic_order_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` ADD CONSTRAINT `fk_genomics_precision_medicine_report_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genome_sequence` ADD CONSTRAINT `fk_genomics_genome_sequence_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`gene_expression` ADD CONSTRAINT `fk_genomics_gene_expression_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`clinical_genomics_report` ADD CONSTRAINT `fk_genomics_clinical_genomics_report_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ADD CONSTRAINT `fk_genomics_genomics_genomic_order_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ADD CONSTRAINT `fk_genomics_genomic_report_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ADD CONSTRAINT `fk_genomics_genomics_genomic_consent_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test` ADD CONSTRAINT `fk_genomics_genomic_test_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequencing_result` ADD CONSTRAINT `fk_genomics_genomic_sequencing_result_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ADD CONSTRAINT `fk_genomics_precision_treatment_plan_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_data` ADD CONSTRAINT `fk_genomics_sequencing_data_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence_data` ADD CONSTRAINT `fk_genomics_sequence_data_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence` ADD CONSTRAINT `fk_genomics_sequence_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_report` ADD CONSTRAINT `fk_genomics_genomics_report_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ADD CONSTRAINT `fk_genomics_variant_call_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_order` ADD CONSTRAINT `fk_genomics_genomic_test_order_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ADD CONSTRAINT `fk_genomics_patient_genomic_study_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`test_order` ADD CONSTRAINT `fk_genomics_test_order_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_test_result` ADD CONSTRAINT `fk_genomics_genomics_test_result_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_profile` ADD CONSTRAINT `fk_genomics_patient_profile_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_data` ADD CONSTRAINT `fk_genomics_genomics_data_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant_result` ADD CONSTRAINT `fk_genomics_genomic_variant_result_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`pharmacogenomics` ADD CONSTRAINT `fk_genomics_pharmacogenomics_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ADD CONSTRAINT `fk_genomics_genomic_profile_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);

-- ========= genomics --> facility (35 constraint(s)) =========
-- Requires: genomics schema, facility schema
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ADD CONSTRAINT `fk_genomics_genomic_sequence_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ADD CONSTRAINT `fk_genomics_sequencing_run_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ADD CONSTRAINT `fk_genomics_sequencing_result_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` ADD CONSTRAINT `fk_genomics_genomic_consent_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_trial` ADD CONSTRAINT `fk_genomics_precision_medicine_trial_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ADD CONSTRAINT `fk_genomics_genomic_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ADD CONSTRAINT `fk_genomics_genomic_order_genomic_ordering_facility_care_site_id` FOREIGN KEY (`genomic_ordering_facility_care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` ADD CONSTRAINT `fk_genomics_precision_medicine_report_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genome_sequence` ADD CONSTRAINT `fk_genomics_genome_sequence_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genome_sequence` ADD CONSTRAINT `fk_genomics_genome_sequence_genome_ordering_facility_care_site_id` FOREIGN KEY (`genome_ordering_facility_care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`gene_expression` ADD CONSTRAINT `fk_genomics_gene_expression_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`clinical_genomics_report` ADD CONSTRAINT `fk_genomics_clinical_genomics_report_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ADD CONSTRAINT `fk_genomics_genomics_genomic_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ADD CONSTRAINT `fk_genomics_genomics_sequencing_run_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ADD CONSTRAINT `fk_genomics_genomic_report_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ADD CONSTRAINT `fk_genomics_genomics_patient_genomic_profile_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ADD CONSTRAINT `fk_genomics_genomic_interpretation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ADD CONSTRAINT `fk_genomics_genomic_test_result_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test` ADD CONSTRAINT `fk_genomics_genomic_test_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test` ADD CONSTRAINT `fk_genomics_genomic_test_genomic_ordering_facility_care_site_id` FOREIGN KEY (`genomic_ordering_facility_care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequencing_result` ADD CONSTRAINT `fk_genomics_genomic_sequencing_result_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ADD CONSTRAINT `fk_genomics_precision_treatment_plan_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_data` ADD CONSTRAINT `fk_genomics_sequencing_data_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence_data` ADD CONSTRAINT `fk_genomics_sequence_data_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence` ADD CONSTRAINT `fk_genomics_sequence_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`assay` ADD CONSTRAINT `fk_genomics_assay_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_report` ADD CONSTRAINT `fk_genomics_genomics_report_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ADD CONSTRAINT `fk_genomics_variant_call_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_order` ADD CONSTRAINT `fk_genomics_genomic_test_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_order` ADD CONSTRAINT `fk_genomics_genomic_test_order_genomic_ordering_facility_care_site_id` FOREIGN KEY (`genomic_ordering_facility_care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`test_order` ADD CONSTRAINT `fk_genomics_test_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`test_order` ADD CONSTRAINT `fk_genomics_test_order_test_facility_care_site_id` FOREIGN KEY (`test_facility_care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_test_result` ADD CONSTRAINT `fk_genomics_genomics_test_result_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant_result` ADD CONSTRAINT `fk_genomics_genomic_variant_result_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ADD CONSTRAINT `fk_genomics_genomic_profile_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= genomics --> interoperability (3 constraint(s)) =========
-- Requires: genomics schema, interoperability schema
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ADD CONSTRAINT `fk_genomics_genomics_genomic_order_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ADD CONSTRAINT `fk_genomics_genomic_report_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`cda_document`(`cda_document_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ADD CONSTRAINT `fk_genomics_genomics_genomic_consent_data_sharing_agreement_id` FOREIGN KEY (`data_sharing_agreement_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`data_sharing_agreement`(`data_sharing_agreement_id`);

-- ========= genomics --> laboratory (21 constraint(s)) =========
-- Requires: genomics schema, laboratory schema
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ADD CONSTRAINT `fk_genomics_genomic_sequence_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant` ADD CONSTRAINT `fk_genomics_genomic_variant_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ADD CONSTRAINT `fk_genomics_sequencing_run_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant` ADD CONSTRAINT `fk_genomics_variant_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genome_sequence` ADD CONSTRAINT `fk_genomics_genome_sequence_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`gene_expression` ADD CONSTRAINT `fk_genomics_gene_expression_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ADD CONSTRAINT `fk_genomics_genomics_genomic_order_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ADD CONSTRAINT `fk_genomics_genomics_sequencing_run_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ADD CONSTRAINT `fk_genomics_genomics_sequencing_run_genomics_specimen_id` FOREIGN KEY (`genomics_specimen_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ADD CONSTRAINT `fk_genomics_genomics_sequencing_run_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ADD CONSTRAINT `fk_genomics_genomics_genomic_sequence_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ADD CONSTRAINT `fk_genomics_genomics_genomic_sequence_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ADD CONSTRAINT `fk_genomics_genomic_report_molecular_test_id` FOREIGN KEY (`molecular_test_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`molecular_test`(`molecular_test_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ADD CONSTRAINT `fk_genomics_genomic_test_result_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ADD CONSTRAINT `fk_genomics_genomic_test_result_genomic_specimen_id` FOREIGN KEY (`genomic_specimen_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ADD CONSTRAINT `fk_genomics_genomic_test_result_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_data` ADD CONSTRAINT `fk_genomics_sequencing_data_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence_data` ADD CONSTRAINT `fk_genomics_sequence_data_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence` ADD CONSTRAINT `fk_genomics_sequence_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence` ADD CONSTRAINT `fk_genomics_sequence_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ADD CONSTRAINT `fk_genomics_variant_call_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`specimen`(`specimen_id`);

-- ========= genomics --> order (2 constraint(s)) =========
-- Requires: genomics schema, order schema
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ADD CONSTRAINT `fk_genomics_genomics_genomic_order_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ADD CONSTRAINT `fk_genomics_genomics_genomic_order_order_authorization_id` FOREIGN KEY (`order_authorization_id`) REFERENCES `healthcare_ecm_v1`.`order`.`order_authorization`(`order_authorization_id`);

-- ========= genomics --> patient (44 constraint(s)) =========
-- Requires: genomics schema, patient schema
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequencing` ADD CONSTRAINT `fk_genomics_genomic_sequencing_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ADD CONSTRAINT `fk_genomics_variant_interpretation_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ADD CONSTRAINT `fk_genomics_genomic_sequence_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_annotation` ADD CONSTRAINT `fk_genomics_variant_annotation_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant` ADD CONSTRAINT `fk_genomics_genomic_variant_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ADD CONSTRAINT `fk_genomics_patient_genomic_profile_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ADD CONSTRAINT `fk_genomics_sequencing_result_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` ADD CONSTRAINT `fk_genomics_genomic_consent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_trial` ADD CONSTRAINT `fk_genomics_precision_medicine_trial_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ADD CONSTRAINT `fk_genomics_genomic_order_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ADD CONSTRAINT `fk_genomics_genomic_order_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` ADD CONSTRAINT `fk_genomics_precision_medicine_report_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant` ADD CONSTRAINT `fk_genomics_variant_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genome_sequence` ADD CONSTRAINT `fk_genomics_genome_sequence_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`gene_expression` ADD CONSTRAINT `fk_genomics_gene_expression_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`clinical_genomics_report` ADD CONSTRAINT `fk_genomics_clinical_genomics_report_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ADD CONSTRAINT `fk_genomics_genomics_genomic_order_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ADD CONSTRAINT `fk_genomics_genomics_sequencing_run_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence` ADD CONSTRAINT `fk_genomics_genomics_genomic_sequence_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ADD CONSTRAINT `fk_genomics_genomic_report_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ADD CONSTRAINT `fk_genomics_genomics_genomic_consent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ADD CONSTRAINT `fk_genomics_genomics_patient_genomic_profile_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ADD CONSTRAINT `fk_genomics_genomic_interpretation_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ADD CONSTRAINT `fk_genomics_genomic_test_result_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ADD CONSTRAINT `fk_genomics_precision_trial_enroll_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test` ADD CONSTRAINT `fk_genomics_genomic_test_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequencing_result` ADD CONSTRAINT `fk_genomics_genomic_sequencing_result_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ADD CONSTRAINT `fk_genomics_precision_treatment_plan_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_data` ADD CONSTRAINT `fk_genomics_sequencing_data_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence_data` ADD CONSTRAINT `fk_genomics_sequence_data_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence` ADD CONSTRAINT `fk_genomics_sequence_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_report` ADD CONSTRAINT `fk_genomics_genomics_report_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`phenotype_association` ADD CONSTRAINT `fk_genomics_phenotype_association_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ADD CONSTRAINT `fk_genomics_variant_call_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_order` ADD CONSTRAINT `fk_genomics_genomic_test_order_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_order` ADD CONSTRAINT `fk_genomics_genomic_test_order_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ADD CONSTRAINT `fk_genomics_patient_genomic_study_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`test_order` ADD CONSTRAINT `fk_genomics_test_order_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_test_result` ADD CONSTRAINT `fk_genomics_genomics_test_result_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_profile` ADD CONSTRAINT `fk_genomics_patient_profile_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_data` ADD CONSTRAINT `fk_genomics_genomics_data_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant_result` ADD CONSTRAINT `fk_genomics_genomic_variant_result_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`pharmacogenomics` ADD CONSTRAINT `fk_genomics_pharmacogenomics_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ADD CONSTRAINT `fk_genomics_genomic_profile_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= genomics --> pharmacy (1 constraint(s)) =========
-- Requires: genomics schema, pharmacy schema
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`pharmacogenomics` ADD CONSTRAINT `fk_genomics_pharmacogenomics_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm_v1`.`pharmacy`.`drug_master`(`drug_master_id`);

-- ========= genomics --> population_health_cohort (2 constraint(s)) =========
-- Requires: genomics schema, population_health_cohort schema
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ADD CONSTRAINT `fk_genomics_precision_trial_enroll_population_health_cohort_cohort_definition_id` FOREIGN KEY (`population_health_cohort_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_definition`(`population_health_cohort_cohort_definition_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_cohort_inclusion` ADD CONSTRAINT `fk_genomics_genomic_cohort_inclusion_population_health_cohort_cohort_definition_id` FOREIGN KEY (`population_health_cohort_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_definition`(`population_health_cohort_cohort_definition_id`);

-- ========= genomics --> population_health_cohort_mgmt (1 constraint(s)) =========
-- Requires: genomics schema, population_health_cohort_mgmt schema
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_cohort_qualification` ADD CONSTRAINT `fk_genomics_genomic_cohort_qualification_population_health_cohort_mgmt_cohort_definition_id` FOREIGN KEY (`population_health_cohort_mgmt_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_definition`(`population_health_cohort_mgmt_cohort_definition_id`);

-- ========= genomics --> provider (59 constraint(s)) =========
-- Requires: genomics schema, provider schema
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ADD CONSTRAINT `fk_genomics_variant_interpretation_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_interpretation` ADD CONSTRAINT `fk_genomics_variant_interpretation_variant_interpreting_provider_clinician_id` FOREIGN KEY (`variant_interpreting_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequence` ADD CONSTRAINT `fk_genomics_genomic_sequence_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_annotation` ADD CONSTRAINT `fk_genomics_variant_annotation_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_annotation` ADD CONSTRAINT `fk_genomics_variant_annotation_variant_reviewed_by_provider_clinician_id` FOREIGN KEY (`variant_reviewed_by_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant` ADD CONSTRAINT `fk_genomics_genomic_variant_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ADD CONSTRAINT `fk_genomics_sequencing_run_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ADD CONSTRAINT `fk_genomics_patient_genomic_profile_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_profile` ADD CONSTRAINT `fk_genomics_patient_genomic_profile_patient_interpreting_provider_clinician_id` FOREIGN KEY (`patient_interpreting_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ADD CONSTRAINT `fk_genomics_sequencing_result_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ADD CONSTRAINT `fk_genomics_sequencing_result_sequencing_interpreting_geneticist_clinician_id` FOREIGN KEY (`sequencing_interpreting_geneticist_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` ADD CONSTRAINT `fk_genomics_genomic_consent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_trial` ADD CONSTRAINT `fk_genomics_precision_medicine_trial_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_trial` ADD CONSTRAINT `fk_genomics_precision_medicine_trial_precision_principal_investigator_clinician_id` FOREIGN KEY (`precision_principal_investigator_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_order` ADD CONSTRAINT `fk_genomics_genomic_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` ADD CONSTRAINT `fk_genomics_precision_medicine_report_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` ADD CONSTRAINT `fk_genomics_precision_medicine_report_precision_interpreting_provider_clinician_id` FOREIGN KEY (`precision_interpreting_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant` ADD CONSTRAINT `fk_genomics_variant_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genome_sequence` ADD CONSTRAINT `fk_genomics_genome_sequence_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`gene_expression` ADD CONSTRAINT `fk_genomics_gene_expression_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`clinical_genomics_report` ADD CONSTRAINT `fk_genomics_clinical_genomics_report_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`clinical_genomics_report` ADD CONSTRAINT `fk_genomics_clinical_genomics_report_clinical_interpreting_geneticist_clinician_id` FOREIGN KEY (`clinical_interpreting_geneticist_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ADD CONSTRAINT `fk_genomics_genomics_genomic_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ADD CONSTRAINT `fk_genomics_genomics_genomic_order_provider_location_id` FOREIGN KEY (`provider_location_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`provider_location`(`provider_location_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ADD CONSTRAINT `fk_genomics_genomics_sequencing_run_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ADD CONSTRAINT `fk_genomics_genomic_report_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ADD CONSTRAINT `fk_genomics_genomic_report_primary_genomic_clinician_id` FOREIGN KEY (`primary_genomic_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ADD CONSTRAINT `fk_genomics_genomics_genomic_consent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile` ADD CONSTRAINT `fk_genomics_genomics_patient_genomic_profile_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ADD CONSTRAINT `fk_genomics_genomic_interpretation_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_result` ADD CONSTRAINT `fk_genomics_genomic_test_result_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ADD CONSTRAINT `fk_genomics_precision_trial_enroll_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test` ADD CONSTRAINT `fk_genomics_genomic_test_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test` ADD CONSTRAINT `fk_genomics_genomic_test_genomic_genetic_counselor_clinician_id` FOREIGN KEY (`genomic_genetic_counselor_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_sequencing_result` ADD CONSTRAINT `fk_genomics_genomic_sequencing_result_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ADD CONSTRAINT `fk_genomics_precision_treatment_plan_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_treatment_plan` ADD CONSTRAINT `fk_genomics_precision_treatment_plan_precision_reviewing_pathologist_clinician_id` FOREIGN KEY (`precision_reviewing_pathologist_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_data` ADD CONSTRAINT `fk_genomics_sequencing_data_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence_data` ADD CONSTRAINT `fk_genomics_sequence_data_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequence` ADD CONSTRAINT `fk_genomics_sequence_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`assay` ADD CONSTRAINT `fk_genomics_assay_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_report` ADD CONSTRAINT `fk_genomics_genomics_report_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_report` ADD CONSTRAINT `fk_genomics_genomics_report_genomics_interpreting_provider_clinician_id` FOREIGN KEY (`genomics_interpreting_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`phenotype_association` ADD CONSTRAINT `fk_genomics_phenotype_association_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ADD CONSTRAINT `fk_genomics_variant_call_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`variant_call` ADD CONSTRAINT `fk_genomics_variant_call_variant_interpreting_pathologist_clinician_id` FOREIGN KEY (`variant_interpreting_pathologist_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_test_order` ADD CONSTRAINT `fk_genomics_genomic_test_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ADD CONSTRAINT `fk_genomics_patient_genomic_study_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`test_order` ADD CONSTRAINT `fk_genomics_test_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_test_result` ADD CONSTRAINT `fk_genomics_genomics_test_result_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_test_result` ADD CONSTRAINT `fk_genomics_genomics_test_result_genomics_interpreting_geneticist_clinician_id` FOREIGN KEY (`genomics_interpreting_geneticist_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_profile` ADD CONSTRAINT `fk_genomics_patient_profile_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_profile` ADD CONSTRAINT `fk_genomics_patient_profile_patient_interpreting_provider_clinician_id` FOREIGN KEY (`patient_interpreting_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_data` ADD CONSTRAINT `fk_genomics_genomics_data_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_data` ADD CONSTRAINT `fk_genomics_genomics_data_genomics_interpreting_provider_clinician_id` FOREIGN KEY (`genomics_interpreting_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant_result` ADD CONSTRAINT `fk_genomics_genomic_variant_result_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_variant_result` ADD CONSTRAINT `fk_genomics_genomic_variant_result_genomic_interpreting_pathologist_clinician_id` FOREIGN KEY (`genomic_interpreting_pathologist_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`pharmacogenomics` ADD CONSTRAINT `fk_genomics_pharmacogenomics_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_profile` ADD CONSTRAINT `fk_genomics_genomic_profile_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= genomics --> radiology (2 constraint(s)) =========
-- Requires: genomics schema, radiology schema
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_trial` ADD CONSTRAINT `fk_genomics_precision_medicine_trial_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `healthcare_ecm_v1`.`radiology`.`protocol`(`protocol_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ADD CONSTRAINT `fk_genomics_genomic_report_radiology_study_id` FOREIGN KEY (`radiology_study_id`) REFERENCES `healthcare_ecm_v1`.`radiology`.`radiology_study`(`radiology_study_id`);

-- ========= genomics --> reference (4 constraint(s)) =========
-- Requires: genomics schema, reference schema
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ADD CONSTRAINT `fk_genomics_genomics_genomic_order_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_report` ADD CONSTRAINT `fk_genomics_genomic_report_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_interpretation` ADD CONSTRAINT `fk_genomics_genomic_interpretation_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`phenotype_association` ADD CONSTRAINT `fk_genomics_phenotype_association_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);

-- ========= genomics --> research (10 constraint(s)) =========
-- Requires: genomics schema, research schema
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_result` ADD CONSTRAINT `fk_genomics_sequencing_result_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomic_consent` ADD CONSTRAINT `fk_genomics_genomic_consent_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_medicine_report` ADD CONSTRAINT `fk_genomics_precision_medicine_report_research_document_id` FOREIGN KEY (`research_document_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_document`(`research_document_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order` ADD CONSTRAINT `fk_genomics_genomics_genomic_order_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ADD CONSTRAINT `fk_genomics_precision_trial_enroll_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ADD CONSTRAINT `fk_genomics_precision_trial_enroll_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `healthcare_ecm_v1`.`research`.`study_site`(`study_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ADD CONSTRAINT `fk_genomics_patient_genomic_study_research_document_id` FOREIGN KEY (`research_document_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_document`(`research_document_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`patient_genomic_study` ADD CONSTRAINT `fk_genomics_patient_genomic_study_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_test_result` ADD CONSTRAINT `fk_genomics_genomics_test_result_research_document_id` FOREIGN KEY (`research_document_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_document`(`research_document_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_data` ADD CONSTRAINT `fk_genomics_genomics_data_research_document_id` FOREIGN KEY (`research_document_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_document`(`research_document_id`);

-- ========= genomics --> research_clinical_trial_matching (2 constraint(s)) =========
-- Requires: genomics schema, research_clinical_trial_matching schema
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ADD CONSTRAINT `fk_genomics_precision_trial_enroll_research_clinical_trial_matching_eligibility_evaluation_id` FOREIGN KEY (`research_clinical_trial_matching_eligibility_evaluation_id`) REFERENCES `healthcare_ecm_v1`.`research_clinical_trial_matching`.`research_clinical_trial_matching_eligibility_evaluation`(`research_clinical_trial_matching_eligibility_evaluation_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_trial_eligibility_match` ADD CONSTRAINT `fk_genomics_genomics_trial_eligibility_match_research_clinical_trial_matching_eligibility_criteria_id` FOREIGN KEY (`research_clinical_trial_matching_eligibility_criteria_id`) REFERENCES `healthcare_ecm_v1`.`research_clinical_trial_matching`.`research_clinical_trial_matching_eligibility_criteria`(`research_clinical_trial_matching_eligibility_criteria_id`);

-- ========= genomics --> supply (1 constraint(s)) =========
-- Requires: genomics schema, supply schema
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ADD CONSTRAINT `fk_genomics_genomics_sequencing_run_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);

-- ========= genomics --> workforce (6 constraint(s)) =========
-- Requires: genomics schema, workforce schema
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`sequencing_run` ADD CONSTRAINT `fk_genomics_sequencing_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run` ADD CONSTRAINT `fk_genomics_genomics_sequencing_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ADD CONSTRAINT `fk_genomics_genomics_genomic_consent_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent` ADD CONSTRAINT `fk_genomics_genomics_genomic_consent_genomics_employee_id` FOREIGN KEY (`genomics_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`precision_trial_enroll` ADD CONSTRAINT `fk_genomics_precision_trial_enroll_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`genomics`.`pharmacogenomics` ADD CONSTRAINT `fk_genomics_pharmacogenomics_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);

-- ========= insurance --> claim (2 constraint(s)) =========
-- Requires: insurance schema, claim schema
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`eligibility_span` ADD CONSTRAINT `fk_insurance_eligibility_span_eligibility_id` FOREIGN KEY (`eligibility_id`) REFERENCES `healthcare_ecm_v1`.`claim`.`eligibility`(`eligibility_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`accumulator` ADD CONSTRAINT `fk_insurance_accumulator_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm_v1`.`claim`.`claim`(`claim_id`);

-- ========= insurance --> clinical (2 constraint(s)) =========
-- Requires: insurance schema, clinical schema
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`risk_adjustment` ADD CONSTRAINT `fk_insurance_risk_adjustment_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`member_attribution` ADD CONSTRAINT `fk_insurance_member_attribution_care_team_id` FOREIGN KEY (`care_team_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`care_team`(`care_team_id`);

-- ========= insurance --> clinical_ai (1 constraint(s)) =========
-- Requires: insurance schema, clinical_ai schema
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`member_attribution` ADD CONSTRAINT `fk_insurance_member_attribution_clinical_ai_patient_risk_score_id` FOREIGN KEY (`clinical_ai_patient_risk_score_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score`(`clinical_ai_patient_risk_score_id`);

-- ========= insurance --> compliance (4 constraint(s)) =========
-- Requires: insurance schema, compliance schema
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`insurance_coverage_policy` ADD CONSTRAINT `fk_insurance_insurance_coverage_policy_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`payer_compliance_requirement` ADD CONSTRAINT `fk_insurance_payer_compliance_requirement_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_program`(`compliance_program_id`);

-- ========= insurance --> consent (6 constraint(s)) =========
-- Requires: insurance schema, consent schema
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`health_plan` ADD CONSTRAINT `fk_insurance_health_plan_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`insurance_coverage_policy` ADD CONSTRAINT `fk_insurance_insurance_coverage_policy_consent_form_template_id` FOREIGN KEY (`consent_form_template_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_form_template`(`consent_form_template_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_consent_form_template_id` FOREIGN KEY (`consent_form_template_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_form_template`(`consent_form_template_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`plan_consent_requirement` ADD CONSTRAINT `fk_insurance_plan_consent_requirement_consent_form_template_id` FOREIGN KEY (`consent_form_template_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_form_template`(`consent_form_template_id`);

-- ========= insurance --> encounter (5 constraint(s)) =========
-- Requires: insurance schema, encounter schema
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_encounter_authorization_id` FOREIGN KEY (`encounter_authorization_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`encounter_authorization`(`encounter_authorization_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`risk_adjustment` ADD CONSTRAINT `fk_insurance_risk_adjustment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`member_attribution` ADD CONSTRAINT `fk_insurance_member_attribution_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);

-- ========= insurance --> facility (7 constraint(s)) =========
-- Requires: insurance schema, facility schema
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`payer_contract` ADD CONSTRAINT `fk_insurance_payer_contract_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`capitation_contract` ADD CONSTRAINT `fk_insurance_capitation_contract_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`capitation_payment` ADD CONSTRAINT `fk_insurance_capitation_payment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`insurance_payer_enrollment` ADD CONSTRAINT `fk_insurance_insurance_payer_enrollment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`insurance_accountable_care_organization` ADD CONSTRAINT `fk_insurance_insurance_accountable_care_organization_facility_organization_id` FOREIGN KEY (`facility_organization_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`facility_organization`(`facility_organization_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`insurance_network_participation` ADD CONSTRAINT `fk_insurance_insurance_network_participation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= insurance --> finance (5 constraint(s)) =========
-- Requires: insurance schema, finance schema
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`capitation_payment` ADD CONSTRAINT `fk_insurance_capitation_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`capitation_payment` ADD CONSTRAINT `fk_insurance_capitation_payment_finance_ar_transaction_id` FOREIGN KEY (`finance_ar_transaction_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`finance_ar_transaction`(`finance_ar_transaction_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`vbc_performance` ADD CONSTRAINT `fk_insurance_vbc_performance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`member_attribution` ADD CONSTRAINT `fk_insurance_member_attribution_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= insurance --> order (1 constraint(s)) =========
-- Requires: insurance schema, order schema
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`member_attribution` ADD CONSTRAINT `fk_insurance_member_attribution_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= insurance --> patient (10 constraint(s)) =========
-- Requires: insurance schema, patient schema
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`subscriber` ADD CONSTRAINT `fk_insurance_subscriber_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`insurance_dependent` ADD CONSTRAINT `fk_insurance_insurance_dependent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`eligibility_span` ADD CONSTRAINT `fk_insurance_eligibility_span_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`accumulator` ADD CONSTRAINT `fk_insurance_accumulator_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`risk_adjustment` ADD CONSTRAINT `fk_insurance_risk_adjustment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`coordination_of_benefits` ADD CONSTRAINT `fk_insurance_coordination_of_benefits_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`coordination_of_benefits` ADD CONSTRAINT `fk_insurance_coordination_of_benefits_primary_mpi_record_id` FOREIGN KEY (`primary_mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`member_attribution` ADD CONSTRAINT `fk_insurance_member_attribution_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= insurance --> pharmacy (2 constraint(s)) =========
-- Requires: insurance schema, pharmacy schema
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`health_plan` ADD CONSTRAINT `fk_insurance_health_plan_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `healthcare_ecm_v1`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`insurance_formulary_tier` ADD CONSTRAINT `fk_insurance_insurance_formulary_tier_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `healthcare_ecm_v1`.`pharmacy`.`formulary`(`formulary_id`);

-- ========= insurance --> post_acute_care (2 constraint(s)) =========
-- Requires: insurance schema, post_acute_care schema
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`plan_service_coverage` ADD CONSTRAINT `fk_insurance_plan_service_coverage_post_acute_service_id` FOREIGN KEY (`post_acute_service_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service`(`post_acute_service_id`);

-- ========= insurance --> provider (26 constraint(s)) =========
-- Requires: insurance schema, provider schema
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`insurance_coverage_policy` ADD CONSTRAINT `fk_insurance_insurance_coverage_policy_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`insurance_coverage_policy` ADD CONSTRAINT `fk_insurance_insurance_coverage_policy_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`insurance_dependent` ADD CONSTRAINT `fk_insurance_insurance_dependent_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`payer_contract` ADD CONSTRAINT `fk_insurance_payer_contract_group_id` FOREIGN KEY (`group_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`group`(`group_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`payer_contract` ADD CONSTRAINT `fk_insurance_payer_contract_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`payer_contract` ADD CONSTRAINT `fk_insurance_payer_contract_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`insurance_fee_schedule` ADD CONSTRAINT `fk_insurance_insurance_fee_schedule_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`insurance_fee_schedule` ADD CONSTRAINT `fk_insurance_insurance_fee_schedule_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_taxonomy_id` FOREIGN KEY (`taxonomy_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`taxonomy`(`taxonomy_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`eligibility_span` ADD CONSTRAINT `fk_insurance_eligibility_span_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`capitation_contract` ADD CONSTRAINT `fk_insurance_capitation_contract_group_id` FOREIGN KEY (`group_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`group`(`group_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`capitation_contract` ADD CONSTRAINT `fk_insurance_capitation_contract_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`capitation_payment` ADD CONSTRAINT `fk_insurance_capitation_payment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`capitation_payment` ADD CONSTRAINT `fk_insurance_capitation_payment_group_id` FOREIGN KEY (`group_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`group`(`group_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`risk_adjustment` ADD CONSTRAINT `fk_insurance_risk_adjustment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`risk_adjustment` ADD CONSTRAINT `fk_insurance_risk_adjustment_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`vbc_performance` ADD CONSTRAINT `fk_insurance_vbc_performance_group_id` FOREIGN KEY (`group_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`group`(`group_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`vbc_performance` ADD CONSTRAINT `fk_insurance_vbc_performance_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`member_attribution` ADD CONSTRAINT `fk_insurance_member_attribution_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`member_attribution` ADD CONSTRAINT `fk_insurance_member_attribution_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`insurance_payer_enrollment` ADD CONSTRAINT `fk_insurance_insurance_payer_enrollment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`insurance_network_participation` ADD CONSTRAINT `fk_insurance_insurance_network_participation_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= insurance --> quality (4 constraint(s)) =========
-- Requires: insurance schema, quality schema
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`vbc_performance` ADD CONSTRAINT `fk_insurance_vbc_performance_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`quality_program`(`quality_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`member_attribution` ADD CONSTRAINT `fk_insurance_member_attribution_quality_program_id` FOREIGN KEY (`quality_program_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`quality_program`(`quality_program_id`);

-- ========= insurance --> reference (11 constraint(s)) =========
-- Requires: insurance schema, reference schema
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`benefit` ADD CONSTRAINT `fk_insurance_benefit_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`benefit` ADD CONSTRAINT `fk_insurance_benefit_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`benefit` ADD CONSTRAINT `fk_insurance_benefit_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`insurance_coverage_policy` ADD CONSTRAINT `fk_insurance_insurance_coverage_policy_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`insurance_coverage_policy` ADD CONSTRAINT `fk_insurance_insurance_coverage_policy_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`insurance_coverage_policy` ADD CONSTRAINT `fk_insurance_insurance_coverage_policy_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`insurance_coverage_policy` ADD CONSTRAINT `fk_insurance_insurance_coverage_policy_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`insurance_fee_schedule_line` ADD CONSTRAINT `fk_insurance_insurance_fee_schedule_line_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`insurance_fee_schedule_line` ADD CONSTRAINT `fk_insurance_insurance_fee_schedule_line_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`insurance_formulary_tier` ADD CONSTRAINT `fk_insurance_insurance_formulary_tier_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);

-- ========= insurance --> workforce (2 constraint(s)) =========
-- Requires: insurance schema, workforce schema
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`insurance`.`risk_adjustment` ADD CONSTRAINT `fk_insurance_risk_adjustment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);

-- ========= interoperability --> clinical (1 constraint(s)) =========
-- Requires: interoperability schema, clinical schema
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`cda_document` ADD CONSTRAINT `fk_interoperability_cda_document_problem_id` FOREIGN KEY (`problem_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`problem`(`problem_id`);

-- ========= interoperability --> clinical_ai (3 constraint(s)) =========
-- Requires: interoperability schema, clinical_ai schema
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`fhir_resource_log` ADD CONSTRAINT `fk_interoperability_fhir_resource_log_clinical_ai_model_inference_log_id` FOREIGN KEY (`clinical_ai_model_inference_log_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log`(`clinical_ai_model_inference_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`subscription_topic` ADD CONSTRAINT `fk_interoperability_subscription_topic_clinical_ai_model_card_id` FOREIGN KEY (`clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`subscription_notification` ADD CONSTRAINT `fk_interoperability_subscription_notification_clinical_ai_patient_risk_score_id` FOREIGN KEY (`clinical_ai_patient_risk_score_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score`(`clinical_ai_patient_risk_score_id`);

-- ========= interoperability --> compliance (1 constraint(s)) =========
-- Requires: interoperability schema, compliance schema
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`hie_participation` ADD CONSTRAINT `fk_interoperability_hie_participation_business_associate_agreement_id` FOREIGN KEY (`business_associate_agreement_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`business_associate_agreement`(`business_associate_agreement_id`);

-- ========= interoperability --> consent (1 constraint(s)) =========
-- Requires: interoperability schema, consent schema
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`hie_query` ADD CONSTRAINT `fk_interoperability_hie_query_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_policy`(`consent_policy_id`);

-- ========= interoperability --> digital_health (2 constraint(s)) =========
-- Requires: interoperability schema, digital_health schema
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`subscription_notification` ADD CONSTRAINT `fk_interoperability_subscription_notification_health_alert_id` FOREIGN KEY (`health_alert_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`health_alert`(`health_alert_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`care_transition_notification` ADD CONSTRAINT `fk_interoperability_care_transition_notification_rpm_enrollment_id` FOREIGN KEY (`rpm_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment`(`rpm_enrollment_id`);

-- ========= interoperability --> encounter (11 constraint(s)) =========
-- Requires: interoperability schema, encounter schema
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`message_log` ADD CONSTRAINT `fk_interoperability_message_log_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`message_error` ADD CONSTRAINT `fk_interoperability_message_error_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`fhir_resource_log` ADD CONSTRAINT `fk_interoperability_fhir_resource_log_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`hie_query` ADD CONSTRAINT `fk_interoperability_hie_query_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`cda_document` ADD CONSTRAINT `fk_interoperability_cda_document_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`cda_validation_result` ADD CONSTRAINT `fk_interoperability_cda_validation_result_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`direct_message` ADD CONSTRAINT `fk_interoperability_direct_message_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`subscription_notification` ADD CONSTRAINT `fk_interoperability_subscription_notification_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`public_health_report` ADD CONSTRAINT `fk_interoperability_public_health_report_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`care_transition_notification` ADD CONSTRAINT `fk_interoperability_care_transition_notification_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`hie_transaction` ADD CONSTRAINT `fk_interoperability_hie_transaction_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);

-- ========= interoperability --> facility (13 constraint(s)) =========
-- Requires: interoperability schema, facility schema
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`interface_engine` ADD CONSTRAINT `fk_interoperability_interface_engine_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`interface_channel` ADD CONSTRAINT `fk_interoperability_interface_channel_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`message_log` ADD CONSTRAINT `fk_interoperability_message_log_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`message_log` ADD CONSTRAINT `fk_interoperability_message_log_receiving_facility_care_site_id` FOREIGN KEY (`receiving_facility_care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`hie_participation` ADD CONSTRAINT `fk_interoperability_hie_participation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`hie_query` ADD CONSTRAINT `fk_interoperability_hie_query_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`cda_document` ADD CONSTRAINT `fk_interoperability_cda_document_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`patient_identity_match` ADD CONSTRAINT `fk_interoperability_patient_identity_match_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`direct_address` ADD CONSTRAINT `fk_interoperability_direct_address_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`subscription_notification` ADD CONSTRAINT `fk_interoperability_subscription_notification_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`promoting_interoperability` ADD CONSTRAINT `fk_interoperability_promoting_interoperability_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`public_health_report` ADD CONSTRAINT `fk_interoperability_public_health_report_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`care_transition_notification` ADD CONSTRAINT `fk_interoperability_care_transition_notification_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= interoperability --> finance (3 constraint(s)) =========
-- Requires: interoperability schema, finance schema
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`hie_participation` ADD CONSTRAINT `fk_interoperability_hie_participation_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`cda_document` ADD CONSTRAINT `fk_interoperability_cda_document_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`subscription_notification` ADD CONSTRAINT `fk_interoperability_subscription_notification_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`financial_entity`(`financial_entity_id`);

-- ========= interoperability --> patient (13 constraint(s)) =========
-- Requires: interoperability schema, patient schema
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`message_log` ADD CONSTRAINT `fk_interoperability_message_log_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`message_error` ADD CONSTRAINT `fk_interoperability_message_error_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`fhir_resource_log` ADD CONSTRAINT `fk_interoperability_fhir_resource_log_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`hie_query` ADD CONSTRAINT `fk_interoperability_hie_query_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`cda_document` ADD CONSTRAINT `fk_interoperability_cda_document_consent_reference_id` FOREIGN KEY (`consent_reference_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`consent_reference`(`consent_reference_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`cda_document` ADD CONSTRAINT `fk_interoperability_cda_document_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`patient_identity_match` ADD CONSTRAINT `fk_interoperability_patient_identity_match_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`direct_message` ADD CONSTRAINT `fk_interoperability_direct_message_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`direct_address` ADD CONSTRAINT `fk_interoperability_direct_address_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`subscription_notification` ADD CONSTRAINT `fk_interoperability_subscription_notification_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`public_health_report` ADD CONSTRAINT `fk_interoperability_public_health_report_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`care_transition_notification` ADD CONSTRAINT `fk_interoperability_care_transition_notification_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`hie_transaction` ADD CONSTRAINT `fk_interoperability_hie_transaction_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);

-- ========= interoperability --> post_acute_care (1 constraint(s)) =========
-- Requires: interoperability schema, post_acute_care schema
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`care_transition_notification` ADD CONSTRAINT `fk_interoperability_care_transition_notification_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);

-- ========= interoperability --> provider (12 constraint(s)) =========
-- Requires: interoperability schema, provider schema
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`trading_partner` ADD CONSTRAINT `fk_interoperability_trading_partner_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`fhir_endpoint` ADD CONSTRAINT `fk_interoperability_fhir_endpoint_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`hie_participation` ADD CONSTRAINT `fk_interoperability_hie_participation_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`hie_query` ADD CONSTRAINT `fk_interoperability_hie_query_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`cda_document` ADD CONSTRAINT `fk_interoperability_cda_document_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`cda_document` ADD CONSTRAINT `fk_interoperability_cda_document_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`direct_address` ADD CONSTRAINT `fk_interoperability_direct_address_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`onboarding_project` ADD CONSTRAINT `fk_interoperability_onboarding_project_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`promoting_interoperability` ADD CONSTRAINT `fk_interoperability_promoting_interoperability_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`promoting_interoperability` ADD CONSTRAINT `fk_interoperability_promoting_interoperability_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`public_health_report` ADD CONSTRAINT `fk_interoperability_public_health_report_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`care_transition_notification` ADD CONSTRAINT `fk_interoperability_care_transition_notification_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= interoperability --> quality (1 constraint(s)) =========
-- Requires: interoperability schema, quality schema
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`public_health_report` ADD CONSTRAINT `fk_interoperability_public_health_report_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);

-- ========= interoperability --> reference (9 constraint(s)) =========
-- Requires: interoperability schema, reference schema
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`mapping_rule` ADD CONSTRAINT `fk_interoperability_mapping_rule_crosswalk_id` FOREIGN KEY (`crosswalk_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`crosswalk`(`crosswalk_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`interoperability_terminology_mapping` ADD CONSTRAINT `fk_interoperability_interoperability_terminology_mapping_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`interoperability_terminology_mapping` ADD CONSTRAINT `fk_interoperability_interoperability_terminology_mapping_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`interoperability_terminology_mapping` ADD CONSTRAINT `fk_interoperability_interoperability_terminology_mapping_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`interoperability_terminology_mapping` ADD CONSTRAINT `fk_interoperability_interoperability_terminology_mapping_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`interoperability_terminology_mapping` ADD CONSTRAINT `fk_interoperability_interoperability_terminology_mapping_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`interoperability_terminology_mapping` ADD CONSTRAINT `fk_interoperability_interoperability_terminology_mapping_code_set_version_id` FOREIGN KEY (`code_set_version_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`code_set_version`(`code_set_version_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`interoperability_terminology_mapping` ADD CONSTRAINT `fk_interoperability_interoperability_terminology_mapping_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`public_health_report` ADD CONSTRAINT `fk_interoperability_public_health_report_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);

-- ========= interoperability --> scheduling (3 constraint(s)) =========
-- Requires: interoperability schema, scheduling schema
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`message_log` ADD CONSTRAINT `fk_interoperability_message_log_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`subscription_notification` ADD CONSTRAINT `fk_interoperability_subscription_notification_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`care_transition_notification` ADD CONSTRAINT `fk_interoperability_care_transition_notification_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);

-- ========= interoperability --> workforce (11 constraint(s)) =========
-- Requires: interoperability schema, workforce schema
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`exchange_standard` ADD CONSTRAINT `fk_interoperability_exchange_standard_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`message_error` ADD CONSTRAINT `fk_interoperability_message_error_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`fhir_resource_log` ADD CONSTRAINT `fk_interoperability_fhir_resource_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`hie_participation` ADD CONSTRAINT `fk_interoperability_hie_participation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`patient_identity_match` ADD CONSTRAINT `fk_interoperability_patient_identity_match_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`interface_downtime` ADD CONSTRAINT `fk_interoperability_interface_downtime_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`interoperability_terminology_mapping` ADD CONSTRAINT `fk_interoperability_interoperability_terminology_mapping_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`interoperability_terminology_mapping` ADD CONSTRAINT `fk_interoperability_interoperability_terminology_mapping_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`onboarding_project` ADD CONSTRAINT `fk_interoperability_onboarding_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`promoting_interoperability` ADD CONSTRAINT `fk_interoperability_promoting_interoperability_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`interoperability`.`data_use_agreement` ADD CONSTRAINT `fk_interoperability_data_use_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);

-- ========= laboratory --> billing (3 constraint(s)) =========
-- Requires: laboratory schema, billing schema
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_charge_id` FOREIGN KEY (`charge_id`) REFERENCES `healthcare_ecm_v1`.`billing`.`charge`(`charge_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_charge_id` FOREIGN KEY (`charge_id`) REFERENCES `healthcare_ecm_v1`.`billing`.`charge`(`charge_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_billing_coverage_id` FOREIGN KEY (`billing_coverage_id`) REFERENCES `healthcare_ecm_v1`.`billing`.`billing_coverage`(`billing_coverage_id`);

-- ========= laboratory --> claim (1 constraint(s)) =========
-- Requires: laboratory schema, claim schema
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm_v1`.`claim`.`claim`(`claim_id`);

-- ========= laboratory --> clinical_ai (1 constraint(s)) =========
-- Requires: laboratory schema, clinical_ai schema
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`feature_contribution` ADD CONSTRAINT `fk_laboratory_feature_contribution_clinical_ai_patient_risk_score_id` FOREIGN KEY (`clinical_ai_patient_risk_score_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score`(`clinical_ai_patient_risk_score_id`);

-- ========= laboratory --> compliance (12 constraint(s)) =========
-- Requires: laboratory schema, compliance schema
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_training_id` FOREIGN KEY (`training_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`training`(`training_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`qc_run` ADD CONSTRAINT `fk_laboratory_qc_run_training_id` FOREIGN KEY (`training_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`training`(`training_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_osha_safety_program_id` FOREIGN KEY (`osha_safety_program_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`osha_safety_program`(`osha_safety_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_training_id` FOREIGN KEY (`training_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`training`(`training_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`clia_certificate` ADD CONSTRAINT `fk_laboratory_clia_certificate_accreditation_status_id` FOREIGN KEY (`accreditation_status_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`accreditation_status`(`accreditation_status_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`clia_certificate` ADD CONSTRAINT `fk_laboratory_clia_certificate_cms_condition_status_id` FOREIGN KEY (`cms_condition_status_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`cms_condition_status`(`cms_condition_status_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`clia_certificate` ADD CONSTRAINT `fk_laboratory_clia_certificate_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`reagent_lot` ADD CONSTRAINT `fk_laboratory_reagent_lot_osha_safety_program_id` FOREIGN KEY (`osha_safety_program_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`osha_safety_program`(`osha_safety_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`instrument_policy_compliance` ADD CONSTRAINT `fk_laboratory_instrument_policy_compliance_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);

-- ========= laboratory --> consent (7 constraint(s)) =========
-- Requires: laboratory schema, consent schema
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`laboratory_test_result` ADD CONSTRAINT `fk_laboratory_laboratory_test_result_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`blood_bank_unit` ADD CONSTRAINT `fk_laboratory_blood_bank_unit_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_genetic_testing_consent_id` FOREIGN KEY (`genetic_testing_consent_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`genetic_testing_consent`(`genetic_testing_consent_id`);

-- ========= laboratory --> encounter (9 constraint(s)) =========
-- Requires: laboratory schema, encounter schema
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`laboratory_test_result` ADD CONSTRAINT `fk_laboratory_laboratory_test_result_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);

-- ========= laboratory --> facility (10 constraint(s)) =========
-- Requires: laboratory schema, facility schema
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`laboratory_test_result` ADD CONSTRAINT `fk_laboratory_laboratory_test_result_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`blood_bank_unit` ADD CONSTRAINT `fk_laboratory_blood_bank_unit_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`clia_certificate` ADD CONSTRAINT `fk_laboratory_clia_certificate_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`reagent_lot` ADD CONSTRAINT `fk_laboratory_reagent_lot_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`room`(`room_id`);

-- ========= laboratory --> finance (15 constraint(s)) =========
-- Requires: laboratory schema, finance schema
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`laboratory_test_result` ADD CONSTRAINT `fk_laboratory_laboratory_test_result_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`blood_bank_unit` ADD CONSTRAINT `fk_laboratory_blood_bank_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`qc_run` ADD CONSTRAINT `fk_laboratory_qc_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`clia_certificate` ADD CONSTRAINT `fk_laboratory_clia_certificate_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`reagent_lot` ADD CONSTRAINT `fk_laboratory_reagent_lot_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= laboratory --> genomics (1 constraint(s)) =========
-- Requires: laboratory schema, genomics schema
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_genomics_genomic_order_id` FOREIGN KEY (`genomics_genomic_order_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order`(`genomics_genomic_order_id`);

-- ========= laboratory --> insurance (10 constraint(s)) =========
-- Requires: laboratory schema, insurance schema
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`test_coverage_policy` ADD CONSTRAINT `fk_laboratory_test_coverage_policy_insurance_coverage_policy_id` FOREIGN KEY (`insurance_coverage_policy_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`insurance_coverage_policy`(`insurance_coverage_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`lab_fee_schedule_line` ADD CONSTRAINT `fk_laboratory_lab_fee_schedule_line_insurance_fee_schedule_id` FOREIGN KEY (`insurance_fee_schedule_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`insurance_fee_schedule`(`insurance_fee_schedule_id`);

-- ========= laboratory --> interoperability (6 constraint(s)) =========
-- Requires: laboratory schema, interoperability schema
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`cda_document`(`cda_document_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`clia_certificate` ADD CONSTRAINT `fk_laboratory_clia_certificate_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`cda_document`(`cda_document_id`);

-- ========= laboratory --> order (4 constraint(s)) =========
-- Requires: laboratory schema, order schema
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`laboratory_test_result` ADD CONSTRAINT `fk_laboratory_laboratory_test_result_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= laboratory --> patient (12 constraint(s)) =========
-- Requires: laboratory schema, patient schema
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`laboratory_test_result` ADD CONSTRAINT `fk_laboratory_laboratory_test_result_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`laboratory_test_result` ADD CONSTRAINT `fk_laboratory_laboratory_test_result_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`susceptibility_result` ADD CONSTRAINT `fk_laboratory_susceptibility_result_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);

-- ========= laboratory --> provider (8 constraint(s)) =========
-- Requires: laboratory schema, provider schema
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_tertiary_lab_cancelled_by_provider_clinician_id` FOREIGN KEY (`tertiary_lab_cancelled_by_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`laboratory_test_result` ADD CONSTRAINT `fk_laboratory_laboratory_test_result_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`laboratory_test_result` ADD CONSTRAINT `fk_laboratory_laboratory_test_result_tertiary_test_ordering_provider_clinician_id` FOREIGN KEY (`tertiary_test_ordering_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`susceptibility_result` ADD CONSTRAINT `fk_laboratory_susceptibility_result_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= laboratory --> quality (7 constraint(s)) =========
-- Requires: laboratory schema, quality schema
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`laboratory_test_result` ADD CONSTRAINT `fk_laboratory_laboratory_test_result_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`patient_safety_event`(`patient_safety_event_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`patient_safety_event`(`patient_safety_event_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`qc_run` ADD CONSTRAINT `fk_laboratory_qc_run_accreditation_survey_id` FOREIGN KEY (`accreditation_survey_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`accreditation_survey`(`accreditation_survey_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`clia_certificate` ADD CONSTRAINT `fk_laboratory_clia_certificate_accreditation_program_id` FOREIGN KEY (`accreditation_program_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`accreditation_program`(`accreditation_program_id`);

-- ========= laboratory --> reference (19 constraint(s)) =========
-- Requires: laboratory schema, reference schema
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`laboratory_test_result` ADD CONSTRAINT `fk_laboratory_laboratory_test_result_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`laboratory_test_result` ADD CONSTRAINT `fk_laboratory_laboratory_test_result_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`laboratory_test_result` ADD CONSTRAINT `fk_laboratory_laboratory_test_result_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`reference_range` ADD CONSTRAINT `fk_laboratory_reference_range_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`blood_bank_unit` ADD CONSTRAINT `fk_laboratory_blood_bank_unit_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`reagent_lot` ADD CONSTRAINT `fk_laboratory_reagent_lot_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`organism` ADD CONSTRAINT `fk_laboratory_organism_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);

-- ========= laboratory --> research (6 constraint(s)) =========
-- Requires: laboratory schema, research schema
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`lab_order` ADD CONSTRAINT `fk_laboratory_lab_order_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`laboratory_test_result` ADD CONSTRAINT `fk_laboratory_laboratory_test_result_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`study_test_requirement` ADD CONSTRAINT `fk_laboratory_study_test_requirement_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);

-- ========= laboratory --> scheduling (3 constraint(s)) =========
-- Requires: laboratory schema, scheduling schema
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`pathology_report` ADD CONSTRAINT `fk_laboratory_pathology_report_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `healthcare_ecm_v1`.`scheduling`.`surgical_case`(`surgical_case_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `healthcare_ecm_v1`.`scheduling`.`surgical_case`(`surgical_case_id`);

-- ========= laboratory --> supply (10 constraint(s)) =========
-- Requires: laboratory schema, supply schema
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`blood_bank_unit` ADD CONSTRAINT `fk_laboratory_blood_bank_unit_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`test_catalog` ADD CONSTRAINT `fk_laboratory_test_catalog_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`lab_charge` ADD CONSTRAINT `fk_laboratory_lab_charge_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`molecular_test` ADD CONSTRAINT `fk_laboratory_molecular_test_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`reagent_lot` ADD CONSTRAINT `fk_laboratory_reagent_lot_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`reagent_lot` ADD CONSTRAINT `fk_laboratory_reagent_lot_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`vendor`(`vendor_id`);

-- ========= laboratory --> workforce (11 constraint(s)) =========
-- Requires: laboratory schema, workforce schema
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`specimen` ADD CONSTRAINT `fk_laboratory_specimen_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`laboratory_test_result` ADD CONSTRAINT `fk_laboratory_laboratory_test_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`laboratory_test_result` ADD CONSTRAINT `fk_laboratory_laboratory_test_result_laboratory_employee_id` FOREIGN KEY (`laboratory_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`laboratory_test_result` ADD CONSTRAINT `fk_laboratory_laboratory_test_result_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`microbiology_culture` ADD CONSTRAINT `fk_laboratory_microbiology_culture_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`transfusion_event` ADD CONSTRAINT `fk_laboratory_transfusion_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`point_of_care_test` ADD CONSTRAINT `fk_laboratory_point_of_care_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`qc_run` ADD CONSTRAINT `fk_laboratory_qc_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`reagent_lot` ADD CONSTRAINT `fk_laboratory_reagent_lot_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`laboratory`.`instrument_policy_compliance` ADD CONSTRAINT `fk_laboratory_instrument_policy_compliance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);

-- ========= order --> clinical_ai (1 constraint(s)) =========
-- Requires: order schema, clinical_ai schema
ALTER TABLE `healthcare_ecm_v1`.`order`.`cpoe_alert` ADD CONSTRAINT `fk_order_cpoe_alert_clinical_ai_model_inference_log_id` FOREIGN KEY (`clinical_ai_model_inference_log_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log`(`clinical_ai_model_inference_log_id`);

-- ========= order --> compliance (11 constraint(s)) =========
-- Requires: order schema, compliance schema
ALTER TABLE `healthcare_ecm_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_attestation_id` FOREIGN KEY (`attestation_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`attestation`(`attestation_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_routing` ADD CONSTRAINT `fk_order_order_routing_business_associate_agreement_id` FOREIGN KEY (`business_associate_agreement_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`business_associate_agreement`(`business_associate_agreement_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`cpoe_alert` ADD CONSTRAINT `fk_order_cpoe_alert_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_authorization` ADD CONSTRAINT `fk_order_order_authorization_business_associate_agreement_id` FOREIGN KEY (`business_associate_agreement_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`business_associate_agreement`(`business_associate_agreement_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`reconciliation` ADD CONSTRAINT `fk_order_reconciliation_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_order_set` ADD CONSTRAINT `fk_order_order_order_set_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_order_set` ADD CONSTRAINT `fk_order_order_order_set_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_program`(`compliance_program_id`);

-- ========= order --> consent (6 constraint(s)) =========
-- Requires: order schema, consent schema
ALTER TABLE `healthcare_ecm_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_record`(`consent_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_consent_form_template_id` FOREIGN KEY (`consent_form_template_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_form_template`(`consent_form_template_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_order_set` ADD CONSTRAINT `fk_order_order_order_set_consent_form_template_id` FOREIGN KEY (`consent_form_template_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_form_template`(`consent_form_template_id`);

-- ========= order --> digital_health (1 constraint(s)) =========
-- Requires: order schema, digital_health schema
ALTER TABLE `healthcare_ecm_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_rpm_enrollment_id` FOREIGN KEY (`rpm_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment`(`rpm_enrollment_id`);

-- ========= order --> encounter (9 constraint(s)) =========
-- Requires: order schema, encounter schema
ALTER TABLE `healthcare_ecm_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_status_history` ADD CONSTRAINT `fk_order_order_status_history_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`cpoe_alert` ADD CONSTRAINT `fk_order_cpoe_alert_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`reconciliation` ADD CONSTRAINT `fk_order_reconciliation_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);

-- ========= order --> facility (11 constraint(s)) =========
-- Requires: order schema, facility schema
ALTER TABLE `healthcare_ecm_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_routing` ADD CONSTRAINT `fk_order_order_routing_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`routing_rule` ADD CONSTRAINT `fk_order_routing_rule_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_set_tbl` ADD CONSTRAINT `fk_order_order_set_tbl_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_order_set` ADD CONSTRAINT `fk_order_order_order_set_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= order --> finance (5 constraint(s)) =========
-- Requires: order schema, finance schema
ALTER TABLE `healthcare_ecm_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= order --> insurance (10 constraint(s)) =========
-- Requires: order schema, insurance schema
ALTER TABLE `healthcare_ecm_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`cpoe_alert` ADD CONSTRAINT `fk_order_cpoe_alert_insurance_coverage_policy_id` FOREIGN KEY (`insurance_coverage_policy_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`insurance_coverage_policy`(`insurance_coverage_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_authorization` ADD CONSTRAINT `fk_order_order_authorization_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_authorization` ADD CONSTRAINT `fk_order_order_authorization_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_order_set` ADD CONSTRAINT `fk_order_order_order_set_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`health_plan`(`health_plan_id`);

-- ========= order --> interoperability (6 constraint(s)) =========
-- Requires: order schema, interoperability schema
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_status_history` ADD CONSTRAINT `fk_order_order_status_history_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_status_history` ADD CONSTRAINT `fk_order_order_status_history_source_system_event_message_log_id` FOREIGN KEY (`source_system_event_message_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_routing` ADD CONSTRAINT `fk_order_order_routing_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`reconciliation` ADD CONSTRAINT `fk_order_reconciliation_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`message_log`(`message_log_id`);

-- ========= order --> laboratory (1 constraint(s)) =========
-- Requires: order schema, laboratory schema
ALTER TABLE `healthcare_ecm_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`specimen`(`specimen_id`);

-- ========= order --> patient (9 constraint(s)) =========
-- Requires: order schema, patient schema
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_status_history` ADD CONSTRAINT `fk_order_order_status_history_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`cpoe_alert` ADD CONSTRAINT `fk_order_cpoe_alert_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_authorization` ADD CONSTRAINT `fk_order_order_authorization_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`reconciliation` ADD CONSTRAINT `fk_order_reconciliation_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= order --> post_acute_care (1 constraint(s)) =========
-- Requires: order schema, post_acute_care schema
ALTER TABLE `healthcare_ecm_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);

-- ========= order --> provider (19 constraint(s)) =========
-- Requires: order schema, provider schema
ALTER TABLE `healthcare_ecm_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_tertiary_clinical_authorizing_provider_clinician_id` FOREIGN KEY (`tertiary_clinical_authorizing_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_status_history` ADD CONSTRAINT `fk_order_order_status_history_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_receiving_provider_clinician_id` FOREIGN KEY (`receiving_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_receiving_clinician_id` FOREIGN KEY (`receiving_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`cpoe_alert` ADD CONSTRAINT `fk_order_cpoe_alert_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`reconciliation` ADD CONSTRAINT `fk_order_reconciliation_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_set_tbl` ADD CONSTRAINT `fk_order_order_set_tbl_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_set_tbl` ADD CONSTRAINT `fk_order_order_set_tbl_order_clinician_id` FOREIGN KEY (`order_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_order_set` ADD CONSTRAINT `fk_order_order_order_set_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_order_set` ADD CONSTRAINT `fk_order_order_order_set_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`specialty`(`specialty_id`);

-- ========= order --> quality (5 constraint(s)) =========
-- Requires: order schema, quality schema
ALTER TABLE `healthcare_ecm_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_order_set` ADD CONSTRAINT `fk_order_order_order_set_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);

-- ========= order --> reference (15 constraint(s)) =========
-- Requires: order schema, reference schema
ALTER TABLE `healthcare_ecm_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_authorization` ADD CONSTRAINT `fk_order_order_authorization_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_authorization` ADD CONSTRAINT `fk_order_order_authorization_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_order_set` ADD CONSTRAINT `fk_order_order_order_set_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_order_set` ADD CONSTRAINT `fk_order_order_order_set_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);

-- ========= order --> research (8 constraint(s)) =========
-- Requires: order schema, research schema
ALTER TABLE `healthcare_ecm_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_authorization` ADD CONSTRAINT `fk_order_order_authorization_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_order_set` ADD CONSTRAINT `fk_order_order_order_set_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);

-- ========= order --> scheduling (3 constraint(s)) =========
-- Requires: order schema, scheduling schema
ALTER TABLE `healthcare_ecm_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_order_set` ADD CONSTRAINT `fk_order_order_order_set_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `healthcare_ecm_v1`.`scheduling`.`appointment_type`(`appointment_type_id`);

-- ========= order --> supply (6 constraint(s)) =========
-- Requires: order schema, supply schema
ALTER TABLE `healthcare_ecm_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`clinical_order` ADD CONSTRAINT `fk_order_clinical_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_authorization` ADD CONSTRAINT `fk_order_order_authorization_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);

-- ========= order --> workforce (21 constraint(s)) =========
-- Requires: order schema, workforce schema
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_status_history` ADD CONSTRAINT `fk_order_order_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_status_history` ADD CONSTRAINT `fk_order_order_status_history_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`referral_order` ADD CONSTRAINT `fk_order_referral_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`set_item` ADD CONSTRAINT `fk_order_set_item_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_routing` ADD CONSTRAINT `fk_order_order_routing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_routing` ADD CONSTRAINT `fk_order_order_routing_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_routing` ADD CONSTRAINT `fk_order_order_routing_source_department_org_unit_id` FOREIGN KEY (`source_department_org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`fulfillment` ADD CONSTRAINT `fk_order_fulfillment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_verbal_employee_id` FOREIGN KEY (`verbal_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`verbal_order` ADD CONSTRAINT `fk_order_verbal_order_read_back_by_employee_id` FOREIGN KEY (`read_back_by_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`standing_order` ADD CONSTRAINT `fk_order_standing_order_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`diet_order` ADD CONSTRAINT `fk_order_diet_order_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`therapy_order` ADD CONSTRAINT `fk_order_therapy_order_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`alert_rule` ADD CONSTRAINT `fk_order_alert_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`alert_rule` ADD CONSTRAINT `fk_order_alert_rule_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`routing_rule` ADD CONSTRAINT `fk_order_routing_rule_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`order`.`order_set_tbl` ADD CONSTRAINT `fk_order_order_set_tbl_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);

-- ========= patient --> behavioral_health (2 constraint(s)) =========
-- Requires: patient schema, behavioral_health schema
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ADD CONSTRAINT `fk_patient_flag_behavioral_health_psychiatric_assessment_id` FOREIGN KEY (`behavioral_health_psychiatric_assessment_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment`(`behavioral_health_psychiatric_assessment_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ADD CONSTRAINT `fk_patient_flag_behavioral_health_sud_episode_id` FOREIGN KEY (`behavioral_health_sud_episode_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode`(`behavioral_health_sud_episode_id`);

-- ========= patient --> clinical (8 constraint(s)) =========
-- Requires: patient schema, clinical schema
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ADD CONSTRAINT `fk_patient_care_program_enrollment_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ADD CONSTRAINT `fk_patient_quality_measure_evaluation_care_team_id` FOREIGN KEY (`care_team_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`care_team`(`care_team_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`need_closure_tracking` ADD CONSTRAINT `fk_patient_need_closure_tracking_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`chw_interventions` ADD CONSTRAINT `fk_patient_chw_interventions_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_subdomain` ADD CONSTRAINT `fk_patient_sdoh_subdomain_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_need_closure` ADD CONSTRAINT `fk_patient_sdoh_need_closure_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_z_code_mapping` ADD CONSTRAINT `fk_patient_sdoh_z_code_mapping_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_chw_interventions` ADD CONSTRAINT `fk_patient_sdoh_chw_interventions_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`care_plan`(`care_plan_id`);

-- ========= patient --> clinical_ai (3 constraint(s)) =========
-- Requires: patient schema, clinical_ai schema
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ADD CONSTRAINT `fk_patient_flag_clinical_ai_patient_risk_score_id` FOREIGN KEY (`clinical_ai_patient_risk_score_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score`(`clinical_ai_patient_risk_score_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ADD CONSTRAINT `fk_patient_care_program_enrollment_clinical_ai_patient_risk_score_id` FOREIGN KEY (`clinical_ai_patient_risk_score_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score`(`clinical_ai_patient_risk_score_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_risk_stratification` ADD CONSTRAINT `fk_patient_sdoh_risk_stratification_clinical_ai_model_card_id` FOREIGN KEY (`clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);

-- ========= patient --> consent (1 constraint(s)) =========
-- Requires: patient schema, consent schema
ALTER TABLE `healthcare_ecm_v1`.`patient`.`consent_reference` ADD CONSTRAINT `fk_patient_consent_reference_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);

-- ========= patient --> encounter (11 constraint(s)) =========
-- Requires: patient schema, encounter schema
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ADD CONSTRAINT `fk_patient_flag_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`referral_management` ADD CONSTRAINT `fk_patient_referral_management_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`need_closure_tracking` ADD CONSTRAINT `fk_patient_need_closure_tracking_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`chw_interventions` ADD CONSTRAINT `fk_patient_chw_interventions_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` ADD CONSTRAINT `fk_patient_risk_stratification_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_subdomain` ADD CONSTRAINT `fk_patient_sdoh_subdomain_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_referral_management` ADD CONSTRAINT `fk_patient_sdoh_referral_management_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_need_closure` ADD CONSTRAINT `fk_patient_sdoh_need_closure_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_z_code_mapping` ADD CONSTRAINT `fk_patient_sdoh_z_code_mapping_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_chw_interventions` ADD CONSTRAINT `fk_patient_sdoh_chw_interventions_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_referral` ADD CONSTRAINT `fk_patient_sdoh_referral_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);

-- ========= patient --> facility (9 constraint(s)) =========
-- Requires: patient schema, facility schema
ALTER TABLE `healthcare_ecm_v1`.`patient`.`address` ADD CONSTRAINT `fk_patient_address_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mrn_crosswalk` ADD CONSTRAINT `fk_patient_mrn_crosswalk_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`referral_management` ADD CONSTRAINT `fk_patient_referral_management_facility_organization_id` FOREIGN KEY (`facility_organization_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`facility_organization`(`facility_organization_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`chw_interventions` ADD CONSTRAINT `fk_patient_chw_interventions_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` ADD CONSTRAINT `fk_patient_risk_stratification_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_subdomain` ADD CONSTRAINT `fk_patient_sdoh_subdomain_facility_organization_id` FOREIGN KEY (`facility_organization_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`facility_organization`(`facility_organization_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_referral_management` ADD CONSTRAINT `fk_patient_sdoh_referral_management_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_referral_management` ADD CONSTRAINT `fk_patient_sdoh_referral_management_facility_organization_id` FOREIGN KEY (`facility_organization_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`facility_organization`(`facility_organization_id`);

-- ========= patient --> insurance (8 constraint(s)) =========
-- Requires: patient schema, insurance schema
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ADD CONSTRAINT `fk_patient_insurance_coverage_insurance_network_participation_id` FOREIGN KEY (`insurance_network_participation_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`insurance_network_participation`(`insurance_network_participation_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`insurance_coverage` ADD CONSTRAINT `fk_patient_insurance_coverage_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`eligibility_check` ADD CONSTRAINT `fk_patient_eligibility_check_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ADD CONSTRAINT `fk_patient_patient_coverage_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ADD CONSTRAINT `fk_patient_patient_coverage_insurance_dependent_id` FOREIGN KEY (`insurance_dependent_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`insurance_dependent`(`insurance_dependent_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ADD CONSTRAINT `fk_patient_patient_coverage_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`patient_coverage` ADD CONSTRAINT `fk_patient_patient_coverage_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` ADD CONSTRAINT `fk_patient_risk_stratification_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`health_plan`(`health_plan_id`);

-- ========= patient --> pharmacy (1 constraint(s)) =========
-- Requires: patient schema, pharmacy schema
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ADD CONSTRAINT `fk_patient_preference_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `healthcare_ecm_v1`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);

-- ========= patient --> post_acute_care (4 constraint(s)) =========
-- Requires: patient schema, post_acute_care schema
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ADD CONSTRAINT `fk_patient_financial_assistance_referral_id` FOREIGN KEY (`referral_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`referral`(`referral_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ADD CONSTRAINT `fk_patient_quality_measure_evaluation_referral_id` FOREIGN KEY (`referral_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`referral`(`referral_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`chw_interventions` ADD CONSTRAINT `fk_patient_chw_interventions_referral_id` FOREIGN KEY (`referral_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`referral`(`referral_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_referral_management` ADD CONSTRAINT `fk_patient_sdoh_referral_management_referral_id` FOREIGN KEY (`referral_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`referral`(`referral_id`);

-- ========= patient --> provider (19 constraint(s)) =========
-- Requires: patient schema, provider schema
ALTER TABLE `healthcare_ecm_v1`.`patient`.`mpi_record` ADD CONSTRAINT `fk_patient_mpi_record_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`demographics` ADD CONSTRAINT `fk_patient_demographics_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`preference` ADD CONSTRAINT `fk_patient_preference_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`flag` ADD CONSTRAINT `fk_patient_flag_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program_enrollment` ADD CONSTRAINT `fk_patient_care_program_enrollment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ADD CONSTRAINT `fk_patient_communication_log_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ADD CONSTRAINT `fk_patient_quality_measure_evaluation_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`program_enrollment` ADD CONSTRAINT `fk_patient_program_enrollment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`care_program` ADD CONSTRAINT `fk_patient_care_program_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`referral_management` ADD CONSTRAINT `fk_patient_referral_management_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`need_closure_tracking` ADD CONSTRAINT `fk_patient_need_closure_tracking_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`chw_interventions` ADD CONSTRAINT `fk_patient_chw_interventions_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` ADD CONSTRAINT `fk_patient_risk_stratification_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`risk_stratification` ADD CONSTRAINT `fk_patient_risk_stratification_risk_clinician_id` FOREIGN KEY (`risk_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_subdomain` ADD CONSTRAINT `fk_patient_sdoh_subdomain_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_referral_management` ADD CONSTRAINT `fk_patient_sdoh_referral_management_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_need_closure` ADD CONSTRAINT `fk_patient_sdoh_need_closure_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_chw_interventions` ADD CONSTRAINT `fk_patient_sdoh_chw_interventions_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_referral` ADD CONSTRAINT `fk_patient_sdoh_referral_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= patient --> quality (2 constraint(s)) =========
-- Requires: patient schema, quality schema
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ADD CONSTRAINT `fk_patient_quality_measure_evaluation_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`z_code_mapping` ADD CONSTRAINT `fk_patient_z_code_mapping_hedis_measure_id` FOREIGN KEY (`hedis_measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`hedis_measure`(`hedis_measure_id`);

-- ========= patient --> reference (5 constraint(s)) =========
-- Requires: patient schema, reference schema
ALTER TABLE `healthcare_ecm_v1`.`patient`.`z_code_mapping` ADD CONSTRAINT `fk_patient_z_code_mapping_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_referral_management` ADD CONSTRAINT `fk_patient_sdoh_referral_management_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_risk_stratification` ADD CONSTRAINT `fk_patient_sdoh_risk_stratification_geographic_region_id` FOREIGN KEY (`geographic_region_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`geographic_region`(`geographic_region_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_zcode_mapping` ADD CONSTRAINT `fk_patient_sdoh_zcode_mapping_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_z_code_mapping` ADD CONSTRAINT `fk_patient_sdoh_z_code_mapping_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);

-- ========= patient --> workforce (17 constraint(s)) =========
-- Requires: patient schema, workforce schema
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_assessment` ADD CONSTRAINT `fk_patient_sdoh_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`registration_event` ADD CONSTRAINT `fk_patient_registration_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ADD CONSTRAINT `fk_patient_identity_merge_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`identity_merge_history` ADD CONSTRAINT `fk_patient_identity_merge_history_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`financial_assistance` ADD CONSTRAINT `fk_patient_financial_assistance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_log` ADD CONSTRAINT `fk_patient_communication_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`quality_measure_evaluation` ADD CONSTRAINT `fk_patient_quality_measure_evaluation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`communication_campaign` ADD CONSTRAINT `fk_patient_communication_campaign_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ADD CONSTRAINT `fk_patient_message_template_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ADD CONSTRAINT `fk_patient_message_template_message_employee_id` FOREIGN KEY (`message_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`message_template` ADD CONSTRAINT `fk_patient_message_template_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`referral_management` ADD CONSTRAINT `fk_patient_referral_management_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`need_closure_tracking` ADD CONSTRAINT `fk_patient_need_closure_tracking_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`chw_interventions` ADD CONSTRAINT `fk_patient_chw_interventions_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_subdomain` ADD CONSTRAINT `fk_patient_sdoh_subdomain_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_chw_intervention` ADD CONSTRAINT `fk_patient_sdoh_chw_intervention_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient`.`sdoh_chw_interventions` ADD CONSTRAINT `fk_patient_sdoh_chw_interventions_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);

-- ========= patient_engagement --> behavioral_health (5 constraint(s)) =========
-- Requires: patient_engagement schema, behavioral_health schema
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_rpm_device_readings` ADD CONSTRAINT `fk_patient_engagement_patient_engagement_rpm_device_readings_behavioral_health_mat_treatment_id` FOREIGN KEY (`behavioral_health_mat_treatment_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment`(`behavioral_health_mat_treatment_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_prom_responses` ADD CONSTRAINT `fk_patient_engagement_patient_engagement_prom_responses_behavioral_health_psychiatric_assessment_id` FOREIGN KEY (`behavioral_health_psychiatric_assessment_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment`(`behavioral_health_psychiatric_assessment_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_prom_responses` ADD CONSTRAINT `fk_patient_engagement_patient_engagement_prom_responses_behavioral_health_sud_episode_id` FOREIGN KEY (`behavioral_health_sud_episode_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode`(`behavioral_health_sud_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_prom_responses` ADD CONSTRAINT `fk_patient_engagement_patient_engagement_prom_responses_therapy_session_id` FOREIGN KEY (`therapy_session_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`therapy_session`(`therapy_session_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_portal_engagement_events` ADD CONSTRAINT `fk_patient_engagement_patient_engagement_portal_engagement_events_behavioral_health_cfr42_consent_id` FOREIGN KEY (`behavioral_health_cfr42_consent_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_cfr42_consent`(`behavioral_health_cfr42_consent_id`);

-- ========= patient_engagement --> clinical_ai (2 constraint(s)) =========
-- Requires: patient_engagement schema, clinical_ai schema
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_prom_responses` ADD CONSTRAINT `fk_patient_engagement_patient_engagement_prom_responses_clinical_ai_care_gap_id` FOREIGN KEY (`clinical_ai_care_gap_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap`(`clinical_ai_care_gap_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_portal_engagement_events` ADD CONSTRAINT `fk_patient_engagement_patient_engagement_portal_engagement_events_clinical_ai_care_gap_id` FOREIGN KEY (`clinical_ai_care_gap_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap`(`clinical_ai_care_gap_id`);

-- ========= patient_engagement --> post_acute_care (3 constraint(s)) =========
-- Requires: patient_engagement schema, post_acute_care schema
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_rpm_device_readings` ADD CONSTRAINT `fk_patient_engagement_patient_engagement_rpm_device_readings_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_prom_responses` ADD CONSTRAINT `fk_patient_engagement_patient_engagement_prom_responses_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_prom_responses` ADD CONSTRAINT `fk_patient_engagement_patient_engagement_prom_responses_service_delivery_id` FOREIGN KEY (`service_delivery_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`service_delivery`(`service_delivery_id`);

-- ========= pharmacy --> behavioral_health (1 constraint(s)) =========
-- Requires: pharmacy schema, behavioral_health schema
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_behavioral_health_mat_treatment_id` FOREIGN KEY (`behavioral_health_mat_treatment_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_mat_treatment`(`behavioral_health_mat_treatment_id`);

-- ========= pharmacy --> claim (7 constraint(s)) =========
-- Requires: pharmacy schema, claim schema
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `healthcare_ecm_v1`.`claim`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm_v1`.`claim`.`claim`(`claim_id`);

-- ========= pharmacy --> clinical (7 constraint(s)) =========
-- Requires: pharmacy schema, clinical schema
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`diagnosis`(`diagnosis_id`);

-- ========= pharmacy --> clinical_ai (3 constraint(s)) =========
-- Requires: pharmacy schema, clinical_ai schema
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_clinical_ai_model_inference_log_id` FOREIGN KEY (`clinical_ai_model_inference_log_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log`(`clinical_ai_model_inference_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_clinical_ai_care_gap_id` FOREIGN KEY (`clinical_ai_care_gap_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap`(`clinical_ai_care_gap_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_clinical_ai_patient_risk_score_id` FOREIGN KEY (`clinical_ai_patient_risk_score_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score`(`clinical_ai_patient_risk_score_id`);

-- ========= pharmacy --> compliance (15 constraint(s)) =========
-- Requires: pharmacy schema, compliance schema
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`drug_master` ADD CONSTRAINT `fk_pharmacy_drug_master_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_hotline_report_id` FOREIGN KEY (`hotline_report_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`hotline_report`(`hotline_report_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`investigation`(`investigation_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_cms_condition_status_id` FOREIGN KEY (`cms_condition_status_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`cms_condition_status`(`cms_condition_status_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`rems_compliance` ADD CONSTRAINT `fk_pharmacy_rems_compliance_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`rems_compliance` ADD CONSTRAINT `fk_pharmacy_rems_compliance_training_id` FOREIGN KEY (`training_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`training`(`training_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`drug_recall` ADD CONSTRAINT `fk_pharmacy_drug_recall_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_accreditation_status_id` FOREIGN KEY (`accreditation_status_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`accreditation_status`(`accreditation_status_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_business_associate_agreement_id` FOREIGN KEY (`business_associate_agreement_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`business_associate_agreement`(`business_associate_agreement_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_cms_condition_status_id` FOREIGN KEY (`cms_condition_status_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`cms_condition_status`(`cms_condition_status_id`);

-- ========= pharmacy --> consent (5 constraint(s)) =========
-- Requires: pharmacy schema, consent schema
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_substance_use_consent_id` FOREIGN KEY (`substance_use_consent_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`substance_use_consent`(`substance_use_consent_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`rems_compliance` ADD CONSTRAINT `fk_pharmacy_rems_compliance_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);

-- ========= pharmacy --> digital_health (3 constraint(s)) =========
-- Requires: pharmacy schema, digital_health schema
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_health_alert_id` FOREIGN KEY (`health_alert_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`health_alert`(`health_alert_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_rpm_reading_id` FOREIGN KEY (`rpm_reading_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`rpm_reading`(`rpm_reading_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`drug_monitoring_protocol` ADD CONSTRAINT `fk_pharmacy_drug_monitoring_protocol_rpm_program_id` FOREIGN KEY (`rpm_program_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`rpm_program`(`rpm_program_id`);

-- ========= pharmacy --> encounter (9 constraint(s)) =========
-- Requires: pharmacy schema, encounter schema
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_review` ADD CONSTRAINT `fk_pharmacy_medication_review_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);

-- ========= pharmacy --> facility (6 constraint(s)) =========
-- Requires: pharmacy schema, facility schema
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`inventory` ADD CONSTRAINT `fk_pharmacy_inventory_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= pharmacy --> finance (6 constraint(s)) =========
-- Requires: pharmacy schema, finance schema
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_ar_account_id` FOREIGN KEY (`ar_account_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`ar_account`(`ar_account_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= pharmacy --> genomics (5 constraint(s)) =========
-- Requires: pharmacy schema, genomics schema
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_genomics_patient_genomic_profile_id` FOREIGN KEY (`genomics_patient_genomic_profile_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile`(`genomics_patient_genomic_profile_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_genomic_test_result_id` FOREIGN KEY (`genomic_test_result_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_test_result`(`genomic_test_result_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`rems_compliance` ADD CONSTRAINT `fk_pharmacy_rems_compliance_genomic_test_result_id` FOREIGN KEY (`genomic_test_result_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_test_result`(`genomic_test_result_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`study_drug_assignment` ADD CONSTRAINT `fk_pharmacy_study_drug_assignment_genomic_test_result_id` FOREIGN KEY (`genomic_test_result_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_test_result`(`genomic_test_result_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`pharmacogenomic_interaction` ADD CONSTRAINT `fk_pharmacy_pharmacogenomic_interaction_genomic_test_result_id` FOREIGN KEY (`genomic_test_result_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_test_result`(`genomic_test_result_id`);

-- ========= pharmacy --> insurance (9 constraint(s)) =========
-- Requires: pharmacy schema, insurance schema
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_network_participation_id` FOREIGN KEY (`network_participation_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`network_participation`(`network_participation_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_insurance_network_participation_id` FOREIGN KEY (`insurance_network_participation_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`insurance_network_participation`(`insurance_network_participation_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`pharmacy_network_participation` ADD CONSTRAINT `fk_pharmacy_pharmacy_network_participation_insurance_network_participation_id` FOREIGN KEY (`insurance_network_participation_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`insurance_network_participation`(`insurance_network_participation_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`pharmacy_network_participation` ADD CONSTRAINT `fk_pharmacy_pharmacy_network_participation_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`provider_network`(`provider_network_id`);

-- ========= pharmacy --> interoperability (23 constraint(s)) =========
-- Requires: pharmacy schema, interoperability schema
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`drug_master` ADD CONSTRAINT `fk_pharmacy_drug_master_interoperability_terminology_mapping_id` FOREIGN KEY (`interoperability_terminology_mapping_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`interoperability_terminology_mapping`(`interoperability_terminology_mapping_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_interoperability_terminology_mapping_id` FOREIGN KEY (`interoperability_terminology_mapping_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`interoperability_terminology_mapping`(`interoperability_terminology_mapping_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_direct_message_id` FOREIGN KEY (`direct_message_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`direct_message`(`direct_message_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_hie_query_id` FOREIGN KEY (`hie_query_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`hie_query`(`hie_query_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_promoting_interoperability_id` FOREIGN KEY (`promoting_interoperability_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`promoting_interoperability`(`promoting_interoperability_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_care_transition_notification_id` FOREIGN KEY (`care_transition_notification_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`care_transition_notification`(`care_transition_notification_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`cda_document`(`cda_document_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_fhir_resource_log_id` FOREIGN KEY (`fhir_resource_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`fhir_resource_log`(`fhir_resource_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`cda_document`(`cda_document_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_public_health_report_id` FOREIGN KEY (`public_health_report_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`public_health_report`(`public_health_report_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_public_health_report_id` FOREIGN KEY (`public_health_report_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`public_health_report`(`public_health_report_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_direct_message_id` FOREIGN KEY (`direct_message_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`direct_message`(`direct_message_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`cda_document`(`cda_document_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_promoting_interoperability_id` FOREIGN KEY (`promoting_interoperability_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`promoting_interoperability`(`promoting_interoperability_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`drug_recall` ADD CONSTRAINT `fk_pharmacy_drug_recall_direct_message_id` FOREIGN KEY (`direct_message_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`direct_message`(`direct_message_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`drug_recall` ADD CONSTRAINT `fk_pharmacy_drug_recall_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`message_log`(`message_log_id`);

-- ========= pharmacy --> laboratory (7 constraint(s)) =========
-- Requires: pharmacy schema, laboratory schema
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`rems_compliance` ADD CONSTRAINT `fk_pharmacy_rems_compliance_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`lab_order`(`lab_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`lab_order`(`lab_order_id`);

-- ========= pharmacy --> order (9 constraint(s)) =========
-- Requires: pharmacy schema, order schema
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_prescription_fk_to_order_clinical_order_id` FOREIGN KEY (`prescription_fk_to_order_clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= pharmacy --> patient (16 constraint(s)) =========
-- Requires: pharmacy schema, patient schema
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_prescription_patient_mpi_record_id` FOREIGN KEY (`prescription_patient_mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_primary_mpi_record_id` FOREIGN KEY (`primary_mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`rems_compliance` ADD CONSTRAINT `fk_pharmacy_rems_compliance_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_review` ADD CONSTRAINT `fk_pharmacy_medication_review_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= pharmacy --> post_acute_care (2 constraint(s)) =========
-- Requires: pharmacy schema, post_acute_care schema
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`care_plan_medication` ADD CONSTRAINT `fk_pharmacy_care_plan_medication_post_acute_care_plan_id` FOREIGN KEY (`post_acute_care_plan_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan`(`post_acute_care_plan_id`);

-- ========= pharmacy --> provider (15 constraint(s)) =========
-- Requires: pharmacy schema, provider schema
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_primary_prescription_clinician_id` FOREIGN KEY (`primary_prescription_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_supervising_clinician_id` FOREIGN KEY (`supervising_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`rems_compliance` ADD CONSTRAINT `fk_pharmacy_rems_compliance_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_review` ADD CONSTRAINT `fk_pharmacy_medication_review_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= pharmacy --> quality (7 constraint(s)) =========
-- Requires: pharmacy schema, quality schema
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`patient_safety_event`(`patient_safety_event_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_improvement_initiative_id` FOREIGN KEY (`improvement_initiative_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`improvement_initiative`(`improvement_initiative_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`patient_safety_event`(`patient_safety_event_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_population_health_gap_id` FOREIGN KEY (`population_health_gap_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`population_health_gap`(`population_health_gap_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_measure_result_id` FOREIGN KEY (`measure_result_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure_result`(`measure_result_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`rems_compliance` ADD CONSTRAINT `fk_pharmacy_rems_compliance_measure_result_id` FOREIGN KEY (`measure_result_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure_result`(`measure_result_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`drug_recall` ADD CONSTRAINT `fk_pharmacy_drug_recall_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`patient_safety_event`(`patient_safety_event_id`);

-- ========= pharmacy --> reference (16 constraint(s)) =========
-- Requires: pharmacy schema, reference schema
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`drug_master` ADD CONSTRAINT `fk_pharmacy_drug_master_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`inventory` ADD CONSTRAINT `fk_pharmacy_inventory_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`drug_recall` ADD CONSTRAINT `fk_pharmacy_drug_recall_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);

-- ========= pharmacy --> research (11 constraint(s)) =========
-- Requires: pharmacy schema, research schema
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`inventory` ADD CONSTRAINT `fk_pharmacy_inventory_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `healthcare_ecm_v1`.`research`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`drug_recall` ADD CONSTRAINT `fk_pharmacy_drug_recall_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `healthcare_ecm_v1`.`research`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`study_drug_assignment` ADD CONSTRAINT `fk_pharmacy_study_drug_assignment_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);

-- ========= pharmacy --> scheduling (1 constraint(s)) =========
-- Requires: pharmacy schema, scheduling schema
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);

-- ========= pharmacy --> supply (8 constraint(s)) =========
-- Requires: pharmacy schema, supply schema
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`inventory` ADD CONSTRAINT `fk_pharmacy_inventory_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`inventory` ADD CONSTRAINT `fk_pharmacy_inventory_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_inventory_location_id` FOREIGN KEY (`inventory_location_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`inventory_location`(`inventory_location_id`);

-- ========= pharmacy --> workforce (15 constraint(s)) =========
-- Requires: pharmacy schema, workforce schema
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_verified_by_employee_id` FOREIGN KEY (`verified_by_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`inventory` ADD CONSTRAINT `fk_pharmacy_inventory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`rems_compliance` ADD CONSTRAINT `fk_pharmacy_rems_compliance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`drug_recall` ADD CONSTRAINT `fk_pharmacy_drug_recall_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_verified_by_employee_id` FOREIGN KEY (`verified_by_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`pharmacy`.`pharmacy_location` ADD CONSTRAINT `fk_pharmacy_pharmacy_location_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);

-- ========= population_health --> clinical_ai (1 constraint(s)) =========
-- Requires: population_health schema, clinical_ai schema
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_cohort_membership` ADD CONSTRAINT `fk_population_health_population_health_cohort_membership_clinical_ai_patient_risk_score_id` FOREIGN KEY (`clinical_ai_patient_risk_score_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score`(`clinical_ai_patient_risk_score_id`);

-- ========= population_health --> facility (3 constraint(s)) =========
-- Requires: population_health schema, facility schema
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_dynamic_cohort_definition` ADD CONSTRAINT `fk_population_health_population_health_dynamic_cohort_definition_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`organization`(`organization_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`cohort_refresh_log` ADD CONSTRAINT `fk_population_health_cohort_refresh_log_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`cohort_outcome_tracking` ADD CONSTRAINT `fk_population_health_cohort_outcome_tracking_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= population_health --> genomics (1 constraint(s)) =========
-- Requires: population_health schema, genomics schema
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_cohort_membership` ADD CONSTRAINT `fk_population_health_population_health_cohort_membership_genomic_test_result_id` FOREIGN KEY (`genomic_test_result_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_test_result`(`genomic_test_result_id`);

-- ========= population_health --> insurance (2 constraint(s)) =========
-- Requires: population_health schema, insurance schema
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`cohort_refresh_log` ADD CONSTRAINT `fk_population_health_cohort_refresh_log_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`cohort_outcome_tracking` ADD CONSTRAINT `fk_population_health_cohort_outcome_tracking_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`health_plan`(`health_plan_id`);

-- ========= population_health --> patient (7 constraint(s)) =========
-- Requires: population_health schema, patient schema
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_dynamic_cohort_definition` ADD CONSTRAINT `fk_population_health_population_health_dynamic_cohort_definition_care_program_id` FOREIGN KEY (`care_program_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`care_program`(`care_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_cohort_membership` ADD CONSTRAINT `fk_population_health_population_health_cohort_membership_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_management` ADD CONSTRAINT `fk_population_health_population_health_population_health_cohort_management_care_program_enrollment_id` FOREIGN KEY (`care_program_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`care_program_enrollment`(`care_program_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_management` ADD CONSTRAINT `fk_population_health_population_health_population_health_cohort_management_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`cohort_refresh_log` ADD CONSTRAINT `fk_population_health_cohort_refresh_log_care_program_id` FOREIGN KEY (`care_program_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`care_program`(`care_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`cohort_outcome_tracking` ADD CONSTRAINT `fk_population_health_cohort_outcome_tracking_care_program_id` FOREIGN KEY (`care_program_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`care_program`(`care_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`cohort_outcome_tracking` ADD CONSTRAINT `fk_population_health_cohort_outcome_tracking_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= population_health --> provider (1 constraint(s)) =========
-- Requires: population_health schema, provider schema
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_definition` ADD CONSTRAINT `fk_population_health_population_health_population_health_cohort_definition_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= population_health --> quality (3 constraint(s)) =========
-- Requires: population_health schema, quality schema
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_dynamic_cohort_definition` ADD CONSTRAINT `fk_population_health_population_health_dynamic_cohort_definition_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_definition` ADD CONSTRAINT `fk_population_health_population_health_population_health_cohort_definition_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_definition` ADD CONSTRAINT `fk_population_health_population_health_population_health_cohort_definition_population_quality_measure_id` FOREIGN KEY (`population_quality_measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);

-- ========= population_health --> workforce (5 constraint(s)) =========
-- Requires: population_health schema, workforce schema
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_dynamic_cohort_definition` ADD CONSTRAINT `fk_population_health_population_health_dynamic_cohort_definition_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_dynamic_cohort_definition` ADD CONSTRAINT `fk_population_health_population_health_dynamic_cohort_definition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_definition` ADD CONSTRAINT `fk_population_health_population_health_population_health_cohort_definition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`cohort_refresh_log` ADD CONSTRAINT `fk_population_health_cohort_refresh_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health`.`cohort_outcome_tracking` ADD CONSTRAINT `fk_population_health_cohort_outcome_tracking_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);

-- ========= population_health_cohort --> clinical_ai (3 constraint(s)) =========
-- Requires: population_health_cohort schema, clinical_ai schema
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_definition` ADD CONSTRAINT `fk_population_health_cohort_population_health_cohort_cohort_definition_clinical_ai_model_card_id` FOREIGN KEY (`clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_membership` ADD CONSTRAINT `fk_population_health_cohort_population_health_cohort_cohort_membership_clinical_ai_patient_risk_score_id` FOREIGN KEY (`clinical_ai_patient_risk_score_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score`(`clinical_ai_patient_risk_score_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_dynamic_cohort_definition` ADD CONSTRAINT `fk_population_health_cohort_population_health_cohort_dynamic_cohort_definition_clinical_ai_dynamic_cohort_definition_id` FOREIGN KEY (`clinical_ai_dynamic_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_dynamic_cohort_definition`(`clinical_ai_dynamic_cohort_definition_id`);

-- ========= population_health_cohort --> patient (1 constraint(s)) =========
-- Requires: population_health_cohort schema, patient schema
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_membership` ADD CONSTRAINT `fk_population_health_cohort_population_health_cohort_cohort_membership_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= population_health_cohort_management --> clinical_ai (5 constraint(s)) =========
-- Requires: population_health_cohort_management schema, clinical_ai schema
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_definition` ADD CONSTRAINT `fk_population_health_cohort_management_population_health_cohort_management_cohort_definition_ai_cohort_definition_id` FOREIGN KEY (`ai_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition`(`ai_cohort_definition_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_definition` ADD CONSTRAINT `fk_population_health_cohort_management_population_health_cohort_management_cohort_definition_clinical_ai_model_card_id` FOREIGN KEY (`clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_definition` ADD CONSTRAINT `fk_population_health_cohort_management_population_health_cohort_management_cohort_definition_model_version_id` FOREIGN KEY (`model_version_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`model_version`(`model_version_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_membership` ADD CONSTRAINT `fk_population_health_cohort_management_population_health_cohort_management_cohort_membership_ai_cohort_membership_id` FOREIGN KEY (`ai_cohort_membership_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_membership`(`ai_cohort_membership_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_membership` ADD CONSTRAINT `fk_population_health_cohort_management_population_health_cohort_management_cohort_membership_clinical_ai_patient_risk_score_id` FOREIGN KEY (`clinical_ai_patient_risk_score_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score`(`clinical_ai_patient_risk_score_id`);

-- ========= population_health_cohort_management --> digital_health (1 constraint(s)) =========
-- Requires: population_health_cohort_management schema, digital_health schema
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_definition` ADD CONSTRAINT `fk_population_health_cohort_management_population_health_cohort_management_cohort_definition_rpm_program_id` FOREIGN KEY (`rpm_program_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`rpm_program`(`rpm_program_id`);

-- ========= population_health_cohort_management --> genomics (1 constraint(s)) =========
-- Requires: population_health_cohort_management schema, genomics schema
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_membership` ADD CONSTRAINT `fk_population_health_cohort_management_population_health_cohort_management_cohort_membership_genomic_test_result_id` FOREIGN KEY (`genomic_test_result_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_test_result`(`genomic_test_result_id`);

-- ========= population_health_cohort_management --> patient (1 constraint(s)) =========
-- Requires: population_health_cohort_management schema, patient schema
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_membership` ADD CONSTRAINT `fk_population_health_cohort_management_population_health_cohort_management_cohort_membership_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= population_health_cohort_management --> workforce (1 constraint(s)) =========
-- Requires: population_health_cohort_management schema, workforce schema
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_definition` ADD CONSTRAINT `fk_population_health_cohort_management_population_health_cohort_management_cohort_definition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);

-- ========= population_health_cohort_mgmt --> clinical_ai (5 constraint(s)) =========
-- Requires: population_health_cohort_mgmt schema, clinical_ai schema
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_definition` ADD CONSTRAINT `fk_population_health_cohort_mgmt_population_health_cohort_mgmt_cohort_definition_clinical_ai_model_card_id` FOREIGN KEY (`clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_definition` ADD CONSTRAINT `fk_population_health_cohort_mgmt_population_health_cohort_mgmt_cohort_definition_ai_cohort_definition_id` FOREIGN KEY (`ai_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition`(`ai_cohort_definition_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_definition` ADD CONSTRAINT `fk_population_health_cohort_mgmt_population_health_cohort_mgmt_cohort_definition_population_cohort_definition_ai_cohort_definition_id` FOREIGN KEY (`population_cohort_definition_ai_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`ai_cohort_definition`(`ai_cohort_definition_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_membership` ADD CONSTRAINT `fk_population_health_cohort_mgmt_population_health_cohort_mgmt_cohort_membership_clinical_ai_patient_risk_score_id` FOREIGN KEY (`clinical_ai_patient_risk_score_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score`(`clinical_ai_patient_risk_score_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_dynamic_cohort_definition` ADD CONSTRAINT `fk_population_health_cohort_mgmt_population_health_cohort_mgmt_dynamic_cohort_definition_clinical_ai_model_card_id` FOREIGN KEY (`clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);

-- ========= population_health_cohort_mgmt --> genomics (1 constraint(s)) =========
-- Requires: population_health_cohort_mgmt schema, genomics schema
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_membership` ADD CONSTRAINT `fk_population_health_cohort_mgmt_population_health_cohort_mgmt_cohort_membership_genomics_patient_genomic_profile_id` FOREIGN KEY (`genomics_patient_genomic_profile_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomics_patient_genomic_profile`(`genomics_patient_genomic_profile_id`);

-- ========= population_health_cohort_mgmt --> patient (2 constraint(s)) =========
-- Requires: population_health_cohort_mgmt schema, patient schema
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_definition` ADD CONSTRAINT `fk_population_health_cohort_mgmt_population_health_cohort_mgmt_cohort_definition_population_segment_id` FOREIGN KEY (`population_segment_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`population_segment`(`population_segment_id`);
ALTER TABLE `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_membership` ADD CONSTRAINT `fk_population_health_cohort_mgmt_population_health_cohort_mgmt_cohort_membership_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= post_acute_care --> behavioral_health (2 constraint(s)) =========
-- Requires: post_acute_care schema, behavioral_health schema
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ADD CONSTRAINT `fk_post_acute_care_post_acute_episode_behavioral_health_crisis_episode_id` FOREIGN KEY (`behavioral_health_crisis_episode_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode`(`behavioral_health_crisis_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ADD CONSTRAINT `fk_post_acute_care_referral_behavioral_health_sud_episode_id` FOREIGN KEY (`behavioral_health_sud_episode_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode`(`behavioral_health_sud_episode_id`);

-- ========= post_acute_care --> claim (2 constraint(s)) =========
-- Requires: post_acute_care schema, claim schema
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ADD CONSTRAINT `fk_post_acute_care_readmission_event_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ADD CONSTRAINT `fk_post_acute_care_referral_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `healthcare_ecm_v1`.`claim`.`prior_authorization`(`prior_authorization_id`);

-- ========= post_acute_care --> clinical (6 constraint(s)) =========
-- Requires: post_acute_care schema, clinical schema
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_care` ADD CONSTRAINT `fk_post_acute_care_hospice_care_advance_directive_id` FOREIGN KEY (`advance_directive_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`advance_directive`(`advance_directive_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ADD CONSTRAINT `fk_post_acute_care_post_acute_episode_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ADD CONSTRAINT `fk_post_acute_care_post_acute_episode_care_team_id` FOREIGN KEY (`care_team_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`care_team`(`care_team_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ADD CONSTRAINT `fk_post_acute_care_post_acute_episode_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ADD CONSTRAINT `fk_post_acute_care_post_acute_care_plan_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ADD CONSTRAINT `fk_post_acute_care_referral_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`care_plan`(`care_plan_id`);

-- ========= post_acute_care --> clinical_ai (3 constraint(s)) =========
-- Requires: post_acute_care schema, clinical_ai schema
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ADD CONSTRAINT `fk_post_acute_care_service_delivery_clinical_ai_care_gap_id` FOREIGN KEY (`clinical_ai_care_gap_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap`(`clinical_ai_care_gap_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ADD CONSTRAINT `fk_post_acute_care_post_acute_care_plan_clinical_ai_care_gap_id` FOREIGN KEY (`clinical_ai_care_gap_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap`(`clinical_ai_care_gap_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ADD CONSTRAINT `fk_post_acute_care_readmission_event_clinical_ai_patient_risk_score_id` FOREIGN KEY (`clinical_ai_patient_risk_score_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score`(`clinical_ai_patient_risk_score_id`);

-- ========= post_acute_care --> consent (2 constraint(s)) =========
-- Requires: post_acute_care schema, consent schema
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ADD CONSTRAINT `fk_post_acute_care_post_acute_episode_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ADD CONSTRAINT `fk_post_acute_care_referral_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);

-- ========= post_acute_care --> digital_health (2 constraint(s)) =========
-- Requires: post_acute_care schema, digital_health schema
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ADD CONSTRAINT `fk_post_acute_care_post_acute_care_plan_rpm_program_id` FOREIGN KEY (`rpm_program_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`rpm_program`(`rpm_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ADD CONSTRAINT `fk_post_acute_care_outcome_measure_prom_response_id` FOREIGN KEY (`prom_response_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`prom_response`(`prom_response_id`);

-- ========= post_acute_care --> encounter (5 constraint(s)) =========
-- Requires: post_acute_care schema, encounter schema
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ADD CONSTRAINT `fk_post_acute_care_post_acute_episode_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ADD CONSTRAINT `fk_post_acute_care_service_delivery_encounter_authorization_id` FOREIGN KEY (`encounter_authorization_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`encounter_authorization`(`encounter_authorization_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ADD CONSTRAINT `fk_post_acute_care_post_acute_care_plan_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ADD CONSTRAINT `fk_post_acute_care_outcome_measure_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ADD CONSTRAINT `fk_post_acute_care_readmission_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);

-- ========= post_acute_care --> facility (5 constraint(s)) =========
-- Requires: post_acute_care schema, facility schema
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ADD CONSTRAINT `fk_post_acute_care_post_acute_episode_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ADD CONSTRAINT `fk_post_acute_care_readmission_event_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ADD CONSTRAINT `fk_post_acute_care_referral_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ADD CONSTRAINT `fk_post_acute_care_post_acute_location_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ADD CONSTRAINT `fk_post_acute_care_post_acute_location_facility_organization_id` FOREIGN KEY (`facility_organization_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`facility_organization`(`facility_organization_id`);

-- ========= post_acute_care --> finance (1 constraint(s)) =========
-- Requires: post_acute_care schema, finance schema
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ADD CONSTRAINT `fk_post_acute_care_post_acute_location_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= post_acute_care --> insurance (6 constraint(s)) =========
-- Requires: post_acute_care schema, insurance schema
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ADD CONSTRAINT `fk_post_acute_care_post_acute_episode_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ADD CONSTRAINT `fk_post_acute_care_post_acute_episode_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ADD CONSTRAINT `fk_post_acute_care_readmission_event_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ADD CONSTRAINT `fk_post_acute_care_readmission_event_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ADD CONSTRAINT `fk_post_acute_care_referral_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ADD CONSTRAINT `fk_post_acute_care_post_acute_provider_assignment_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`provider_network`(`provider_network_id`);

-- ========= post_acute_care --> order (2 constraint(s)) =========
-- Requires: post_acute_care schema, order schema
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ADD CONSTRAINT `fk_post_acute_care_service_delivery_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ADD CONSTRAINT `fk_post_acute_care_referral_referral_order_id` FOREIGN KEY (`referral_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`referral_order`(`referral_order_id`);

-- ========= post_acute_care --> patient (10 constraint(s)) =========
-- Requires: post_acute_care schema, patient schema
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`snf_stay` ADD CONSTRAINT `fk_post_acute_care_snf_stay_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`home_health` ADD CONSTRAINT `fk_post_acute_care_home_health_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`hospice_care` ADD CONSTRAINT `fk_post_acute_care_hospice_care_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ADD CONSTRAINT `fk_post_acute_care_post_acute_episode_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ADD CONSTRAINT `fk_post_acute_care_service_delivery_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ADD CONSTRAINT `fk_post_acute_care_post_acute_care_plan_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ADD CONSTRAINT `fk_post_acute_care_care_plan_update_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ADD CONSTRAINT `fk_post_acute_care_outcome_measure_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ADD CONSTRAINT `fk_post_acute_care_readmission_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ADD CONSTRAINT `fk_post_acute_care_referral_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= post_acute_care --> pharmacy (2 constraint(s)) =========
-- Requires: post_acute_care schema, pharmacy schema
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ADD CONSTRAINT `fk_post_acute_care_post_acute_episode_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `healthcare_ecm_v1`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ADD CONSTRAINT `fk_post_acute_care_service_delivery_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `healthcare_ecm_v1`.`pharmacy`.`prescription`(`prescription_id`);

-- ========= post_acute_care --> population_health_cohort (2 constraint(s)) =========
-- Requires: post_acute_care schema, population_health_cohort schema
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ADD CONSTRAINT `fk_post_acute_care_post_acute_care_plan_population_health_cohort_cohort_definition_id` FOREIGN KEY (`population_health_cohort_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_definition`(`population_health_cohort_cohort_definition_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_cohort_membership` ADD CONSTRAINT `fk_post_acute_care_post_acute_care_cohort_membership_population_health_cohort_cohort_definition_id` FOREIGN KEY (`population_health_cohort_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_definition`(`population_health_cohort_cohort_definition_id`);

-- ========= post_acute_care --> population_health_cohort_mgmt (2 constraint(s)) =========
-- Requires: post_acute_care schema, population_health_cohort_mgmt schema
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ADD CONSTRAINT `fk_post_acute_care_post_acute_episode_population_health_cohort_mgmt_cohort_definition_id` FOREIGN KEY (`population_health_cohort_mgmt_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_definition`(`population_health_cohort_mgmt_cohort_definition_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ADD CONSTRAINT `fk_post_acute_care_referral_population_health_cohort_mgmt_cohort_definition_id` FOREIGN KEY (`population_health_cohort_mgmt_cohort_definition_id`) REFERENCES `healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_definition`(`population_health_cohort_mgmt_cohort_definition_id`);

-- ========= post_acute_care --> provider (9 constraint(s)) =========
-- Requires: post_acute_care schema, provider schema
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ADD CONSTRAINT `fk_post_acute_care_post_acute_episode_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ADD CONSTRAINT `fk_post_acute_care_service_delivery_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ADD CONSTRAINT `fk_post_acute_care_post_acute_care_plan_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ADD CONSTRAINT `fk_post_acute_care_outcome_measure_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ADD CONSTRAINT `fk_post_acute_care_readmission_event_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ADD CONSTRAINT `fk_post_acute_care_referral_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ADD CONSTRAINT `fk_post_acute_care_post_acute_provider_assignment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ADD CONSTRAINT `fk_post_acute_care_post_acute_provider_assignment_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ADD CONSTRAINT `fk_post_acute_care_post_acute_location_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`org_provider`(`org_provider_id`);

-- ========= post_acute_care --> quality (2 constraint(s)) =========
-- Requires: post_acute_care schema, quality schema
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ADD CONSTRAINT `fk_post_acute_care_outcome_measure_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`measure`(`measure_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ADD CONSTRAINT `fk_post_acute_care_readmission_event_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`patient_safety_event`(`patient_safety_event_id`);

-- ========= post_acute_care --> reference (7 constraint(s)) =========
-- Requires: post_acute_care schema, reference schema
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ADD CONSTRAINT `fk_post_acute_care_post_acute_episode_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ADD CONSTRAINT `fk_post_acute_care_post_acute_episode_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ADD CONSTRAINT `fk_post_acute_care_service_delivery_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`outcome_measure` ADD CONSTRAINT `fk_post_acute_care_outcome_measure_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ADD CONSTRAINT `fk_post_acute_care_readmission_event_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ADD CONSTRAINT `fk_post_acute_care_referral_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location` ADD CONSTRAINT `fk_post_acute_care_post_acute_location_geographic_region_id` FOREIGN KEY (`geographic_region_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`geographic_region`(`geographic_region_id`);

-- ========= post_acute_care --> research (1 constraint(s)) =========
-- Requires: post_acute_care schema, research schema
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ADD CONSTRAINT `fk_post_acute_care_post_acute_episode_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);

-- ========= post_acute_care --> scheduling (2 constraint(s)) =========
-- Requires: post_acute_care schema, scheduling schema
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ADD CONSTRAINT `fk_post_acute_care_post_acute_care_plan_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ADD CONSTRAINT `fk_post_acute_care_referral_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);

-- ========= post_acute_care --> workforce (8 constraint(s)) =========
-- Requires: post_acute_care schema, workforce schema
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode` ADD CONSTRAINT `fk_post_acute_care_post_acute_episode_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`service_delivery` ADD CONSTRAINT `fk_post_acute_care_service_delivery_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan` ADD CONSTRAINT `fk_post_acute_care_post_acute_care_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`care_plan_update` ADD CONSTRAINT `fk_post_acute_care_care_plan_update_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`readmission_event` ADD CONSTRAINT `fk_post_acute_care_readmission_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ADD CONSTRAINT `fk_post_acute_care_referral_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`referral` ADD CONSTRAINT `fk_post_acute_care_referral_referral_employee_id` FOREIGN KEY (`referral_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment` ADD CONSTRAINT `fk_post_acute_care_post_acute_provider_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);

-- ========= provider --> compliance (14 constraint(s)) =========
-- Requires: provider schema, compliance schema
ALTER TABLE `healthcare_ecm_v1`.`provider`.`org_provider` ADD CONSTRAINT `fk_provider_org_provider_business_associate_agreement_id` FOREIGN KEY (`business_associate_agreement_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`business_associate_agreement`(`business_associate_agreement_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`provider_credential` ADD CONSTRAINT `fk_provider_provider_credential_training_id` FOREIGN KEY (`training_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`training`(`training_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`privileging` ADD CONSTRAINT `fk_provider_privileging_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`credentialing_application` ADD CONSTRAINT `fk_provider_credentialing_application_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`group` ADD CONSTRAINT `fk_provider_group_business_associate_agreement_id` FOREIGN KEY (`business_associate_agreement_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`business_associate_agreement`(`business_associate_agreement_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`malpractice_coverage` ADD CONSTRAINT `fk_provider_malpractice_coverage_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`npdb_query` ADD CONSTRAINT `fk_provider_npdb_query_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`provider_sanction` ADD CONSTRAINT `fk_provider_provider_sanction_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`provider_sanction` ADD CONSTRAINT `fk_provider_provider_sanction_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`investigation`(`investigation_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`board_certification` ADD CONSTRAINT `fk_provider_board_certification_training_id` FOREIGN KEY (`training_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`training`(`training_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`reappointment` ADD CONSTRAINT `fk_provider_reappointment_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`peer_reference` ADD CONSTRAINT `fk_provider_peer_reference_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`investigation`(`investigation_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`cme_activity` ADD CONSTRAINT `fk_provider_cme_activity_training_id` FOREIGN KEY (`training_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`training`(`training_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`telehealth_authorization` ADD CONSTRAINT `fk_provider_telehealth_authorization_compliance_regulatory_submission_id` FOREIGN KEY (`compliance_regulatory_submission_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_regulatory_submission`(`compliance_regulatory_submission_id`);

-- ========= provider --> digital_health (1 constraint(s)) =========
-- Requires: provider schema, digital_health schema
ALTER TABLE `healthcare_ecm_v1`.`provider`.`program_assignment` ADD CONSTRAINT `fk_provider_program_assignment_rpm_program_id` FOREIGN KEY (`rpm_program_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`rpm_program`(`rpm_program_id`);

-- ========= provider --> facility (15 constraint(s)) =========
-- Requires: provider schema, facility schema
ALTER TABLE `healthcare_ecm_v1`.`provider`.`clinician` ADD CONSTRAINT `fk_provider_clinician_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`privileging` ADD CONSTRAINT `fk_provider_privileging_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`credentialing_application` ADD CONSTRAINT `fk_provider_credentialing_application_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`group_membership` ADD CONSTRAINT `fk_provider_group_membership_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`malpractice_coverage` ADD CONSTRAINT `fk_provider_malpractice_coverage_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`npdb_query` ADD CONSTRAINT `fk_provider_npdb_query_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`dea_registration` ADD CONSTRAINT `fk_provider_dea_registration_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`provider_location` ADD CONSTRAINT `fk_provider_provider_location_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`provider_location` ADD CONSTRAINT `fk_provider_provider_location_provider_location_care_site_id` FOREIGN KEY (`provider_location_care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`reappointment` ADD CONSTRAINT `fk_provider_reappointment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`peer_reference` ADD CONSTRAINT `fk_provider_peer_reference_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`cme_activity` ADD CONSTRAINT `fk_provider_cme_activity_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`telehealth_authorization` ADD CONSTRAINT `fk_provider_telehealth_authorization_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`credentialing_file` ADD CONSTRAINT `fk_provider_credentialing_file_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= provider --> finance (8 constraint(s)) =========
-- Requires: provider schema, finance schema
ALTER TABLE `healthcare_ecm_v1`.`provider`.`org_provider` ADD CONSTRAINT `fk_provider_org_provider_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`provider_credential` ADD CONSTRAINT `fk_provider_provider_credential_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`credentialing_application` ADD CONSTRAINT `fk_provider_credentialing_application_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`provider_payer_enrollment` ADD CONSTRAINT `fk_provider_provider_payer_enrollment_ar_account_id` FOREIGN KEY (`ar_account_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`ar_account`(`ar_account_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`provider_payer_enrollment` ADD CONSTRAINT `fk_provider_provider_payer_enrollment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`group` ADD CONSTRAINT `fk_provider_group_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`malpractice_coverage` ADD CONSTRAINT `fk_provider_malpractice_coverage_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`cme_activity` ADD CONSTRAINT `fk_provider_cme_activity_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`ap_invoice`(`ap_invoice_id`);

-- ========= provider --> insurance (8 constraint(s)) =========
-- Requires: provider schema, insurance schema
ALTER TABLE `healthcare_ecm_v1`.`provider`.`credentialing_application` ADD CONSTRAINT `fk_provider_credentialing_application_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`provider_payer_enrollment` ADD CONSTRAINT `fk_provider_provider_payer_enrollment_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`provider_payer_enrollment` ADD CONSTRAINT `fk_provider_provider_payer_enrollment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`network_affiliation` ADD CONSTRAINT `fk_provider_network_affiliation_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`provider_sanction` ADD CONSTRAINT `fk_provider_provider_sanction_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`credentialing_file` ADD CONSTRAINT `fk_provider_credentialing_file_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);

-- ========= provider --> quality (4 constraint(s)) =========
-- Requires: provider schema, quality schema
ALTER TABLE `healthcare_ecm_v1`.`provider`.`provider_sanction` ADD CONSTRAINT `fk_provider_provider_sanction_patient_safety_event_id` FOREIGN KEY (`patient_safety_event_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`patient_safety_event`(`patient_safety_event_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`provider_sanction` ADD CONSTRAINT `fk_provider_provider_sanction_quality_peer_review_id` FOREIGN KEY (`quality_peer_review_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`quality_peer_review`(`quality_peer_review_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`reappointment` ADD CONSTRAINT `fk_provider_reappointment_quality_peer_review_id` FOREIGN KEY (`quality_peer_review_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`quality_peer_review`(`quality_peer_review_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`survey_participation` ADD CONSTRAINT `fk_provider_survey_participation_accreditation_survey_id` FOREIGN KEY (`accreditation_survey_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`accreditation_survey`(`accreditation_survey_id`);

-- ========= provider --> reference (10 constraint(s)) =========
-- Requires: provider schema, reference schema
ALTER TABLE `healthcare_ecm_v1`.`provider`.`clinician` ADD CONSTRAINT `fk_provider_clinician_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`org_provider` ADD CONSTRAINT `fk_provider_org_provider_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`specialty` ADD CONSTRAINT `fk_provider_specialty_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`specialty` ADD CONSTRAINT `fk_provider_specialty_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`specialty` ADD CONSTRAINT `fk_provider_specialty_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`provider_credential` ADD CONSTRAINT `fk_provider_provider_credential_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`provider_payer_enrollment` ADD CONSTRAINT `fk_provider_provider_payer_enrollment_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`provider_location` ADD CONSTRAINT `fk_provider_provider_location_geographic_region_id` FOREIGN KEY (`geographic_region_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`geographic_region`(`geographic_region_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`taxonomy` ADD CONSTRAINT `fk_provider_taxonomy_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`taxonomy` ADD CONSTRAINT `fk_provider_taxonomy_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);

-- ========= provider --> research (1 constraint(s)) =========
-- Requires: provider schema, research schema
ALTER TABLE `healthcare_ecm_v1`.`provider`.`study_team_member` ADD CONSTRAINT `fk_provider_study_team_member_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);

-- ========= provider --> supply (2 constraint(s)) =========
-- Requires: provider schema, supply schema
ALTER TABLE `healthcare_ecm_v1`.`provider`.`provider_payer_enrollment` ADD CONSTRAINT `fk_provider_provider_payer_enrollment_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`preference_card` ADD CONSTRAINT `fk_provider_preference_card_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);

-- ========= provider --> workforce (15 constraint(s)) =========
-- Requires: provider schema, workforce schema
ALTER TABLE `healthcare_ecm_v1`.`provider`.`provider_credential` ADD CONSTRAINT `fk_provider_provider_credential_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`privileging` ADD CONSTRAINT `fk_provider_privileging_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`credentialing_application` ADD CONSTRAINT `fk_provider_credentialing_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`provider_payer_enrollment` ADD CONSTRAINT `fk_provider_provider_payer_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`malpractice_coverage` ADD CONSTRAINT `fk_provider_malpractice_coverage_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`board_certification` ADD CONSTRAINT `fk_provider_board_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`education_training` ADD CONSTRAINT `fk_provider_education_training_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`reappointment` ADD CONSTRAINT `fk_provider_reappointment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`peer_reference` ADD CONSTRAINT `fk_provider_peer_reference_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`cme_activity` ADD CONSTRAINT `fk_provider_cme_activity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`provider_assignment` ADD CONSTRAINT `fk_provider_provider_assignment_position_id` FOREIGN KEY (`position_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`affiliation` ADD CONSTRAINT `fk_provider_affiliation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`credentialing_file` ADD CONSTRAINT `fk_provider_credentialing_file_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`provider_committee` ADD CONSTRAINT `fk_provider_provider_committee_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`provider`.`provider_committee` ADD CONSTRAINT `fk_provider_provider_committee_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);

-- ========= quality --> behavioral_health (5 constraint(s)) =========
-- Requires: quality schema, behavioral_health schema
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_behavioral_health_crisis_episode_id` FOREIGN KEY (`behavioral_health_crisis_episode_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode`(`behavioral_health_crisis_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_behavioral_health_crisis_episode_id` FOREIGN KEY (`behavioral_health_crisis_episode_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_crisis_episode`(`behavioral_health_crisis_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_behavioral_health_psychiatric_assessment_id` FOREIGN KEY (`behavioral_health_psychiatric_assessment_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment`(`behavioral_health_psychiatric_assessment_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_behavioral_health_psychiatric_assessment_id` FOREIGN KEY (`behavioral_health_psychiatric_assessment_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_psychiatric_assessment`(`behavioral_health_psychiatric_assessment_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_therapy_session_id` FOREIGN KEY (`therapy_session_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`therapy_session`(`therapy_session_id`);

-- ========= quality --> claim (1 constraint(s)) =========
-- Requires: quality schema, claim schema
ALTER TABLE `healthcare_ecm_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm_v1`.`claim`.`claim`(`claim_id`);

-- ========= quality --> clinical_ai (5 constraint(s)) =========
-- Requires: quality schema, clinical_ai schema
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ADD CONSTRAINT `fk_quality_cdi_review_clinical_ai_clinical_nlp_result_id` FOREIGN KEY (`clinical_ai_clinical_nlp_result_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_clinical_nlp_result`(`clinical_ai_clinical_nlp_result_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_clinical_ai_model_card_id` FOREIGN KEY (`clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_clinical_ai_patient_risk_score_id` FOREIGN KEY (`clinical_ai_patient_risk_score_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score`(`clinical_ai_patient_risk_score_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_clinical_ai_care_gap_id` FOREIGN KEY (`clinical_ai_care_gap_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap`(`clinical_ai_care_gap_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_model_validation` ADD CONSTRAINT `fk_quality_measure_model_validation_clinical_ai_model_card_id` FOREIGN KEY (`clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);

-- ========= quality --> digital_health (5 constraint(s)) =========
-- Requires: quality schema, digital_health schema
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_health_alert_id` FOREIGN KEY (`health_alert_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`health_alert`(`health_alert_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_rpm_enrollment_id` FOREIGN KEY (`rpm_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment`(`rpm_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_rpm_enrollment_id` FOREIGN KEY (`rpm_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment`(`rpm_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_rpm_reading_id` FOREIGN KEY (`rpm_reading_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`rpm_reading`(`rpm_reading_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_measure_alignment` ADD CONSTRAINT `fk_quality_program_measure_alignment_rpm_program_id` FOREIGN KEY (`rpm_program_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`rpm_program`(`rpm_program_id`);

-- ========= quality --> encounter (11 constraint(s)) =========
-- Requires: quality schema, encounter schema
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ADD CONSTRAINT `fk_quality_cahps_response_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ADD CONSTRAINT `fk_quality_cdi_review_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ADD CONSTRAINT `fk_quality_standard_finding_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ADD CONSTRAINT `fk_quality_sdoh_screening_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_primary_care_closing_visit_id` FOREIGN KEY (`primary_care_closing_visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_tertiary_care_visit_id` FOREIGN KEY (`tertiary_care_visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`root_cause_analysis` ADD CONSTRAINT `fk_quality_root_cause_analysis_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);

-- ========= quality --> facility (18 constraint(s)) =========
-- Requires: quality schema, facility schema
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ADD CONSTRAINT `fk_quality_hedis_result_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ADD CONSTRAINT `fk_quality_cahps_survey_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ADD CONSTRAINT `fk_quality_cahps_response_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ADD CONSTRAINT `fk_quality_safety_event_review_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ADD CONSTRAINT `fk_quality_safety_event_review_safety_location_care_site_id` FOREIGN KEY (`safety_location_care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ADD CONSTRAINT `fk_quality_accreditation_survey_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ADD CONSTRAINT `fk_quality_accreditation_survey_facility_organization_id` FOREIGN KEY (`facility_organization_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`facility_organization`(`facility_organization_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ADD CONSTRAINT `fk_quality_standard_finding_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ADD CONSTRAINT `fk_quality_sdoh_screening_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mips_clinician_measure` ADD CONSTRAINT `fk_quality_mips_clinician_measure_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`apm_program_enrollment` ADD CONSTRAINT `fk_quality_apm_program_enrollment_facility_organization_id` FOREIGN KEY (`facility_organization_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`facility_organization`(`facility_organization_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`apm_program_enrollment` ADD CONSTRAINT `fk_quality_apm_program_enrollment_apm_facility_organization_id` FOREIGN KEY (`apm_facility_organization_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`facility_organization`(`facility_organization_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`apm_program_enrollment` ADD CONSTRAINT `fk_quality_apm_program_enrollment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mips_reporting` ADD CONSTRAINT `fk_quality_mips_reporting_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mips_reporting` ADD CONSTRAINT `fk_quality_mips_reporting_facility_organization_id` FOREIGN KEY (`facility_organization_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`facility_organization`(`facility_organization_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`root_cause_analysis` ADD CONSTRAINT `fk_quality_root_cause_analysis_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= quality --> finance (1 constraint(s)) =========
-- Requires: quality schema, finance schema
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_budget_allocation` ADD CONSTRAINT `fk_quality_measure_budget_allocation_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`budget_line`(`budget_line_id`);

-- ========= quality --> genomics (1 constraint(s)) =========
-- Requires: quality schema, genomics schema
ALTER TABLE `healthcare_ecm_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_genomic_test_result_id` FOREIGN KEY (`genomic_test_result_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_test_result`(`genomic_test_result_id`);

-- ========= quality --> insurance (5 constraint(s)) =========
-- Requires: quality schema, insurance schema
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ADD CONSTRAINT `fk_quality_hedis_result_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`contract_initiative` ADD CONSTRAINT `fk_quality_contract_initiative_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program_participation` ADD CONSTRAINT `fk_quality_quality_program_participation_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`apm_program_enrollment` ADD CONSTRAINT `fk_quality_apm_program_enrollment_insurance_accountable_care_organization_id` FOREIGN KEY (`insurance_accountable_care_organization_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`insurance_accountable_care_organization`(`insurance_accountable_care_organization_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`apm_program_enrollment` ADD CONSTRAINT `fk_quality_apm_program_enrollment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);

-- ========= quality --> order (2 constraint(s)) =========
-- Requires: quality schema, order schema
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ADD CONSTRAINT `fk_quality_hedis_result_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= quality --> patient (15 constraint(s)) =========
-- Requires: quality schema, patient schema
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ADD CONSTRAINT `fk_quality_hedis_result_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ADD CONSTRAINT `fk_quality_cahps_survey_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ADD CONSTRAINT `fk_quality_cahps_response_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ADD CONSTRAINT `fk_quality_safety_event_review_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ADD CONSTRAINT `fk_quality_cdi_review_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ADD CONSTRAINT `fk_quality_standard_finding_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_care_program_id` FOREIGN KEY (`care_program_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`care_program`(`care_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ADD CONSTRAINT `fk_quality_sdoh_screening_community_resource_id` FOREIGN KEY (`community_resource_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`community_resource`(`community_resource_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ADD CONSTRAINT `fk_quality_sdoh_screening_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_care_mpi_record_id` FOREIGN KEY (`care_mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= quality --> post_acute_care (7 constraint(s)) =========
-- Requires: quality schema, post_acute_care schema
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ADD CONSTRAINT `fk_quality_hedis_result_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ADD CONSTRAINT `fk_quality_cahps_response_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ADD CONSTRAINT `fk_quality_accreditation_survey_post_acute_location_id` FOREIGN KEY (`post_acute_location_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location`(`post_acute_location_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ADD CONSTRAINT `fk_quality_sdoh_screening_referral_id` FOREIGN KEY (`referral_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`referral`(`referral_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`measure_applicability` ADD CONSTRAINT `fk_quality_measure_applicability_post_acute_service_id` FOREIGN KEY (`post_acute_service_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service`(`post_acute_service_id`);

-- ========= quality --> provider (15 constraint(s)) =========
-- Requires: quality schema, provider schema
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ADD CONSTRAINT `fk_quality_hedis_result_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`hedis_result` ADD CONSTRAINT `fk_quality_hedis_result_attributed_clinician_id` FOREIGN KEY (`attributed_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ADD CONSTRAINT `fk_quality_cahps_survey_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mortality_review` ADD CONSTRAINT `fk_quality_mortality_review_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ADD CONSTRAINT `fk_quality_standard_finding_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_peer_review` ADD CONSTRAINT `fk_quality_quality_peer_review_reviewer_clinician_id` FOREIGN KEY (`reviewer_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`population_health_gap` ADD CONSTRAINT `fk_quality_population_health_gap_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mips_clinician_measure` ADD CONSTRAINT `fk_quality_mips_clinician_measure_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`apm_program_enrollment` ADD CONSTRAINT `fk_quality_apm_program_enrollment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`apm_program_enrollment` ADD CONSTRAINT `fk_quality_apm_program_enrollment_org_provider_id` FOREIGN KEY (`org_provider_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`org_provider`(`org_provider_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_primary_care_assigned_clinician_id` FOREIGN KEY (`primary_care_assigned_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`care_gap_closure` ADD CONSTRAINT `fk_quality_care_gap_closure_tertiary_care_closure_clinician_id` FOREIGN KEY (`tertiary_care_closure_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mips_clinician_measure_report` ADD CONSTRAINT `fk_quality_mips_clinician_measure_report_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`mips_reporting` ADD CONSTRAINT `fk_quality_mips_reporting_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= quality --> research (1 constraint(s)) =========
-- Requires: quality schema, research schema
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` ADD CONSTRAINT `fk_quality_program_study_participation_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);

-- ========= quality --> supply (1 constraint(s)) =========
-- Requires: quality schema, supply schema
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_survey` ADD CONSTRAINT `fk_quality_cahps_survey_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`vendor`(`vendor_id`);

-- ========= quality --> workforce (21 constraint(s)) =========
-- Requires: quality schema, workforce schema
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ADD CONSTRAINT `fk_quality_cahps_response_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cahps_response` ADD CONSTRAINT `fk_quality_cahps_response_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`patient_safety_event` ADD CONSTRAINT `fk_quality_patient_safety_event_reported_by_employee_id` FOREIGN KEY (`reported_by_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`safety_event_review` ADD CONSTRAINT `fk_quality_safety_event_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`cdi_review` ADD CONSTRAINT `fk_quality_cdi_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`accreditation_survey` ADD CONSTRAINT `fk_quality_accreditation_survey_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ADD CONSTRAINT `fk_quality_standard_finding_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ADD CONSTRAINT `fk_quality_standard_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`standard_finding` ADD CONSTRAINT `fk_quality_standard_finding_standard_employee_id` FOREIGN KEY (`standard_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`sdoh_screening` ADD CONSTRAINT `fk_quality_sdoh_screening_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ADD CONSTRAINT `fk_quality_quality_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_program` ADD CONSTRAINT `fk_quality_quality_program_quality_employee_id` FOREIGN KEY (`quality_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`initiative_measure_target` ADD CONSTRAINT `fk_quality_initiative_measure_target_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`program_study_participation` ADD CONSTRAINT `fk_quality_program_study_participation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ADD CONSTRAINT `fk_quality_quality_committee_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`quality_committee` ADD CONSTRAINT `fk_quality_quality_committee_quality_employee_id` FOREIGN KEY (`quality_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`root_cause_analysis` ADD CONSTRAINT `fk_quality_root_cause_analysis_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`root_cause_analysis` ADD CONSTRAINT `fk_quality_root_cause_analysis_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`quality`.`root_cause_analysis` ADD CONSTRAINT `fk_quality_root_cause_analysis_root_executive_sponsor_employee_id` FOREIGN KEY (`root_executive_sponsor_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);

-- ========= radiology --> claim (2 constraint(s)) =========
-- Requires: radiology schema, claim schema
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm_v1`.`claim`.`claim`(`claim_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_order_status_history` ADD CONSTRAINT `fk_radiology_radiology_order_status_history_status_history_id` FOREIGN KEY (`status_history_id`) REFERENCES `healthcare_ecm_v1`.`claim`.`status_history`(`status_history_id`);

-- ========= radiology --> clinical (1 constraint(s)) =========
-- Requires: radiology schema, clinical schema
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_cdi_query_id` FOREIGN KEY (`cdi_query_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`cdi_query`(`cdi_query_id`);

-- ========= radiology --> clinical_ai (1 constraint(s)) =========
-- Requires: radiology schema, clinical_ai schema
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_finding` ADD CONSTRAINT `fk_radiology_radiology_finding_clinical_ai_model_inference_log_id` FOREIGN KEY (`clinical_ai_model_inference_log_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log`(`clinical_ai_model_inference_log_id`);

-- ========= radiology --> compliance (14 constraint(s)) =========
-- Requires: radiology schema, compliance schema
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`modality` ADD CONSTRAINT `fk_radiology_modality_osha_safety_program_id` FOREIGN KEY (`osha_safety_program_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`osha_safety_program`(`osha_safety_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_osha_exposure_incident_id` FOREIGN KEY (`osha_exposure_incident_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`osha_exposure_incident`(`osha_exposure_incident_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_osha_safety_program_id` FOREIGN KEY (`osha_safety_program_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`osha_safety_program`(`osha_safety_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`reader_assignment` ADD CONSTRAINT `fk_radiology_reader_assignment_stark_arrangement_id` FOREIGN KEY (`stark_arrangement_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`stark_arrangement`(`stark_arrangement_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_peer_review` ADD CONSTRAINT `fk_radiology_radiology_peer_review_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_peer_review` ADD CONSTRAINT `fk_radiology_radiology_peer_review_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_business_associate_agreement_id` FOREIGN KEY (`business_associate_agreement_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`business_associate_agreement`(`business_associate_agreement_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_stark_arrangement_id` FOREIGN KEY (`stark_arrangement_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`stark_arrangement`(`stark_arrangement_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_osha_exposure_incident_id` FOREIGN KEY (`osha_exposure_incident_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`osha_exposure_incident`(`osha_exposure_incident_id`);

-- ========= radiology --> consent (4 constraint(s)) =========
-- Requires: radiology schema, consent schema
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);

-- ========= radiology --> encounter (15 constraint(s)) =========
-- Requires: radiology schema, encounter schema
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`reader_assignment` ADD CONSTRAINT `fk_radiology_reader_assignment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_peer_review` ADD CONSTRAINT `fk_radiology_radiology_peer_review_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_finding` ADD CONSTRAINT `fk_radiology_radiology_finding_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_order_status_history` ADD CONSTRAINT `fk_radiology_radiology_order_status_history_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);

-- ========= radiology --> facility (21 constraint(s)) =========
-- Requires: radiology schema, facility schema
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_ordering_location_care_site_id` FOREIGN KEY (`ordering_location_care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_report_performing_facility_care_site_id` FOREIGN KEY (`report_performing_facility_care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_performing_facility_care_site_id` FOREIGN KEY (`performing_facility_care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`modality` ADD CONSTRAINT `fk_radiology_modality_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`reader_assignment` ADD CONSTRAINT `fk_radiology_reader_assignment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_peer_review` ADD CONSTRAINT `fk_radiology_radiology_peer_review_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_order_status_history` ADD CONSTRAINT `fk_radiology_radiology_order_status_history_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`network_modality_participation` ADD CONSTRAINT `fk_radiology_network_modality_participation_facility_contract_id` FOREIGN KEY (`facility_contract_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`facility_contract`(`facility_contract_id`);

-- ========= radiology --> finance (5 constraint(s)) =========
-- Requires: radiology schema, finance schema
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`modality` ADD CONSTRAINT `fk_radiology_modality_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`ap_invoice`(`ap_invoice_id`);

-- ========= radiology --> insurance (6 constraint(s)) =========
-- Requires: radiology schema, insurance schema
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`network_modality_participation` ADD CONSTRAINT `fk_radiology_network_modality_participation_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`provider_network`(`provider_network_id`);

-- ========= radiology --> interoperability (15 constraint(s)) =========
-- Requires: radiology schema, interoperability schema
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_hie_query_id` FOREIGN KEY (`hie_query_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`hie_query`(`hie_query_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_hie_query_id` FOREIGN KEY (`hie_query_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`hie_query`(`hie_query_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`cda_document`(`cda_document_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`modality` ADD CONSTRAINT `fk_radiology_modality_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_public_health_report_id` FOREIGN KEY (`public_health_report_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`public_health_report`(`public_health_report_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_order_status_history` ADD CONSTRAINT `fk_radiology_radiology_order_status_history_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`report_distribution` ADD CONSTRAINT `fk_radiology_report_distribution_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`report_distribution` ADD CONSTRAINT `fk_radiology_report_distribution_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`transmission` ADD CONSTRAINT `fk_radiology_transmission_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);

-- ========= radiology --> laboratory (3 constraint(s)) =========
-- Requires: radiology schema, laboratory schema
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_laboratory_test_result_id` FOREIGN KEY (`laboratory_test_result_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`laboratory_test_result`(`laboratory_test_result_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_specimen_id` FOREIGN KEY (`specimen_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`specimen`(`specimen_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`lab_order`(`lab_order_id`);

-- ========= radiology --> order (9 constraint(s)) =========
-- Requires: radiology schema, order schema
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= radiology --> patient (14 constraint(s)) =========
-- Requires: radiology schema, patient schema
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_finding` ADD CONSTRAINT `fk_radiology_radiology_finding_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_order_status_history` ADD CONSTRAINT `fk_radiology_radiology_order_status_history_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);

-- ========= radiology --> pharmacy (5 constraint(s)) =========
-- Requires: radiology schema, pharmacy schema
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm_v1`.`pharmacy`.`drug_master`(`drug_master_id`);

-- ========= radiology --> provider (19 constraint(s)) =========
-- Requires: radiology schema, provider schema
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_tertiary_report_reading_radiologist_clinician_id` FOREIGN KEY (`tertiary_report_reading_radiologist_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_tertiary_report_ordering_provider_clinician_id` FOREIGN KEY (`tertiary_report_ordering_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_tertiary_radiology_referring_provider_clinician_id` FOREIGN KEY (`tertiary_radiology_referring_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`reader_assignment` ADD CONSTRAINT `fk_radiology_reader_assignment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_tertiary_critical_ordering_provider_clinician_id` FOREIGN KEY (`tertiary_critical_ordering_provider_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_finding` ADD CONSTRAINT `fk_radiology_radiology_finding_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_order_status_history` ADD CONSTRAINT `fk_radiology_radiology_order_status_history_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= radiology --> reference (24 constraint(s)) =========
-- Requires: radiology schema, reference schema
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_loinc_code_id` FOREIGN KEY (`loinc_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`loinc_code`(`loinc_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`reader_assignment` ADD CONSTRAINT `fk_radiology_reader_assignment_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_peer_review` ADD CONSTRAINT `fk_radiology_radiology_peer_review_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_finding` ADD CONSTRAINT `fk_radiology_radiology_finding_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_finding` ADD CONSTRAINT `fk_radiology_radiology_finding_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);

-- ========= radiology --> research (9 constraint(s)) =========
-- Requires: radiology schema, research schema
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_finding` ADD CONSTRAINT `fk_radiology_radiology_finding_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);

-- ========= radiology --> scheduling (4 constraint(s)) =========
-- Requires: radiology schema, scheduling schema
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `healthcare_ecm_v1`.`scheduling`.`surgical_case`(`surgical_case_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_order_status_history` ADD CONSTRAINT `fk_radiology_radiology_order_status_history_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);

-- ========= radiology --> supply (5 constraint(s)) =========
-- Requires: radiology schema, supply schema
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`contrast_admin` ADD CONSTRAINT `fk_radiology_contrast_admin_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);

-- ========= radiology --> workforce (21 constraint(s)) =========
-- Requires: radiology schema, workforce schema
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`imaging_order` ADD CONSTRAINT `fk_radiology_imaging_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_study` ADD CONSTRAINT `fk_radiology_radiology_study_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`dicom_series` ADD CONSTRAINT `fk_radiology_dicom_series_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_report_transcriptionist_employee_id` FOREIGN KEY (`report_transcriptionist_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`report` ADD CONSTRAINT `fk_radiology_report_transcribed_by_employee_id` FOREIGN KEY (`transcribed_by_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`report_addendum` ADD CONSTRAINT `fk_radiology_report_addendum_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`modality` ADD CONSTRAINT `fk_radiology_modality_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`protocol` ADD CONSTRAINT `fk_radiology_protocol_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`dose_record` ADD CONSTRAINT `fk_radiology_dose_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_appointment` ADD CONSTRAINT `fk_radiology_radiology_appointment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`critical_result` ADD CONSTRAINT `fk_radiology_critical_result_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_peer_review` ADD CONSTRAINT `fk_radiology_radiology_peer_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_peer_review` ADD CONSTRAINT `fk_radiology_radiology_peer_review_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`teleradiology_case` ADD CONSTRAINT `fk_radiology_teleradiology_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`follow_up` ADD CONSTRAINT `fk_radiology_follow_up_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`interventional_procedure` ADD CONSTRAINT `fk_radiology_interventional_procedure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_order_status_history` ADD CONSTRAINT `fk_radiology_radiology_order_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`radiology_order_status_history` ADD CONSTRAINT `fk_radiology_radiology_order_status_history_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`radiology`.`transmission` ADD CONSTRAINT `fk_radiology_transmission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);

-- ========= reference --> interoperability (1 constraint(s)) =========
-- Requires: reference schema, interoperability schema
ALTER TABLE `healthcare_ecm_v1`.`reference`.`fhir_value_set` ADD CONSTRAINT `fk_reference_fhir_value_set_exchange_standard_id` FOREIGN KEY (`exchange_standard_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`exchange_standard`(`exchange_standard_id`);

-- ========= reference --> post_acute_care (1 constraint(s)) =========
-- Requires: reference schema, post_acute_care schema
ALTER TABLE `healthcare_ecm_v1`.`reference`.`service_indication` ADD CONSTRAINT `fk_reference_service_indication_post_acute_service_id` FOREIGN KEY (`post_acute_service_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service`(`post_acute_service_id`);

-- ========= research --> behavioral_health (1 constraint(s)) =========
-- Requires: research schema, behavioral_health schema
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ADD CONSTRAINT `fk_research_subject_enrollment_behavioral_health_sud_episode_id` FOREIGN KEY (`behavioral_health_sud_episode_id`) REFERENCES `healthcare_ecm_v1`.`behavioral_health`.`behavioral_health_sud_episode`(`behavioral_health_sud_episode_id`);

-- ========= research --> claim (1 constraint(s)) =========
-- Requires: research schema, claim schema
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `healthcare_ecm_v1`.`claim`.`claim`(`claim_id`);

-- ========= research --> clinical_ai (6 constraint(s)) =========
-- Requires: research schema, clinical_ai schema
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_trial_eligibility_evaluation` ADD CONSTRAINT `fk_research_research_trial_eligibility_evaluation_clinical_ai_model_inference_log_id` FOREIGN KEY (`clinical_ai_model_inference_log_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log`(`clinical_ai_model_inference_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_trial_eligibility_evaluation` ADD CONSTRAINT `fk_research_research_trial_eligibility_evaluation_model_version_id` FOREIGN KEY (`model_version_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`model_version`(`model_version_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_trial_eligibility_evaluation` ADD CONSTRAINT `fk_research_research_trial_eligibility_evaluation_trial_eligibility_evaluation_id` FOREIGN KEY (`trial_eligibility_evaluation_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`trial_eligibility_evaluation`(`trial_eligibility_evaluation_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`patient_trial_matching_result` ADD CONSTRAINT `fk_research_patient_trial_matching_result_clinical_ai_model_card_id` FOREIGN KEY (`clinical_ai_model_card_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_card`(`clinical_ai_model_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`patient_trial_matching_result` ADD CONSTRAINT `fk_research_patient_trial_matching_result_model_version_id` FOREIGN KEY (`model_version_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`model_version`(`model_version_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`clinical_trial_eligibility_evaluation` ADD CONSTRAINT `fk_research_clinical_trial_eligibility_evaluation_clinical_ai_model_inference_log_id` FOREIGN KEY (`clinical_ai_model_inference_log_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_model_inference_log`(`clinical_ai_model_inference_log_id`);

-- ========= research --> clinical_trial_matching (4 constraint(s)) =========
-- Requires: research schema, clinical_trial_matching schema
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_safety_monitoring` ADD CONSTRAINT `fk_research_data_safety_monitoring_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`trial`(`trial_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ADD CONSTRAINT `fk_research_research_document_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`trial`(`trial_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`trial_matching` ADD CONSTRAINT `fk_research_trial_matching_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`trial`(`trial_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_trial_eligibility_criteria` ADD CONSTRAINT `fk_research_research_trial_eligibility_criteria_eligibility_criteria_id` FOREIGN KEY (`eligibility_criteria_id`) REFERENCES `healthcare_ecm_v1`.`clinical_trial_matching`.`eligibility_criteria`(`eligibility_criteria_id`);

-- ========= research --> digital_health (3 constraint(s)) =========
-- Requires: research schema, digital_health schema
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ADD CONSTRAINT `fk_research_subject_enrollment_rpm_enrollment_id` FOREIGN KEY (`rpm_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment`(`rpm_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ADD CONSTRAINT `fk_research_adverse_event_health_alert_id` FOREIGN KEY (`health_alert_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`health_alert`(`health_alert_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ADD CONSTRAINT `fk_research_adverse_event_rpm_reading_id` FOREIGN KEY (`rpm_reading_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`rpm_reading`(`rpm_reading_id`);

-- ========= research --> encounter (3 constraint(s)) =========
-- Requires: research schema, encounter schema
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ADD CONSTRAINT `fk_research_ip_dispensation_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`clinical_trial_eligibility_evaluation` ADD CONSTRAINT `fk_research_clinical_trial_eligibility_evaluation_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`trial_matching` ADD CONSTRAINT `fk_research_trial_matching_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);

-- ========= research --> facility (6 constraint(s)) =========
-- Requires: research schema, facility schema
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ADD CONSTRAINT `fk_research_study_site_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_partner_agreement` ADD CONSTRAINT `fk_research_study_partner_agreement_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`organization`(`organization_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ADD CONSTRAINT `fk_research_research_grant_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`trial_matching` ADD CONSTRAINT `fk_research_trial_matching_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`institutional_review_board` ADD CONSTRAINT `fk_research_institutional_review_board_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`organization`(`organization_id`);

-- ========= research --> genomics (8 constraint(s)) =========
-- Requires: research schema, genomics schema
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ADD CONSTRAINT `fk_research_subject_enrollment_genomics_genomic_consent_id` FOREIGN KEY (`genomics_genomic_consent_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomics_genomic_consent`(`genomics_genomic_consent_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ADD CONSTRAINT `fk_research_subject_enrollment_genomics_genomic_order_id` FOREIGN KEY (`genomics_genomic_order_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order`(`genomics_genomic_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ADD CONSTRAINT `fk_research_study_visit_genomics_genomic_order_id` FOREIGN KEY (`genomics_genomic_order_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order`(`genomics_genomic_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_genomics_genomic_order_id` FOREIGN KEY (`genomics_genomic_order_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order`(`genomics_genomic_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_genomics_genomic_sequence_id` FOREIGN KEY (`genomics_genomic_sequence_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomics_genomic_sequence`(`genomics_genomic_sequence_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_genomics_genomic_order_id` FOREIGN KEY (`genomics_genomic_order_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomics_genomic_order`(`genomics_genomic_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_trial_eligibility_evaluation` ADD CONSTRAINT `fk_research_research_trial_eligibility_evaluation_genomic_test_result_id` FOREIGN KEY (`genomic_test_result_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_test_result`(`genomic_test_result_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_genomic_eligibility` ADD CONSTRAINT `fk_research_study_genomic_eligibility_genomic_test_result_id` FOREIGN KEY (`genomic_test_result_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_test_result`(`genomic_test_result_id`);

-- ========= research --> insurance (1 constraint(s)) =========
-- Requires: research schema, insurance schema
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ADD CONSTRAINT `fk_research_coverage_analysis_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);

-- ========= research --> order (2 constraint(s)) =========
-- Requires: research schema, order schema
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ADD CONSTRAINT `fk_research_subject_enrollment_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ADD CONSTRAINT `fk_research_adverse_event_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= research --> patient (9 constraint(s)) =========
-- Requires: research schema, patient schema
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ADD CONSTRAINT `fk_research_subject_enrollment_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ADD CONSTRAINT `fk_research_informed_consent_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ADD CONSTRAINT `fk_research_adverse_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_trial_eligibility_evaluation` ADD CONSTRAINT `fk_research_research_trial_eligibility_evaluation_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`patient_trial_matching_result` ADD CONSTRAINT `fk_research_patient_trial_matching_result_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`clinical_trial_eligibility_evaluation` ADD CONSTRAINT `fk_research_clinical_trial_eligibility_evaluation_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`trial_matching` ADD CONSTRAINT `fk_research_trial_matching_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= research --> post_acute_care (2 constraint(s)) =========
-- Requires: research schema, post_acute_care schema
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ADD CONSTRAINT `fk_research_study_site_post_acute_location_id` FOREIGN KEY (`post_acute_location_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location`(`post_acute_location_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ADD CONSTRAINT `fk_research_ip_dispensation_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);

-- ========= research --> provider (18 constraint(s)) =========
-- Requires: research schema, provider schema
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_study` ADD CONSTRAINT `fk_research_research_study_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`irb_submission` ADD CONSTRAINT `fk_research_irb_submission_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_site` ADD CONSTRAINT `fk_research_study_site_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ADD CONSTRAINT `fk_research_subject_enrollment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_award` ADD CONSTRAINT `fk_research_research_grant_award_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_regulatory_submission` ADD CONSTRAINT `fk_research_research_regulatory_submission_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ADD CONSTRAINT `fk_research_study_budget_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_budget` ADD CONSTRAINT `fk_research_study_budget_primary_study_clinician_id` FOREIGN KEY (`primary_study_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_record` ADD CONSTRAINT `fk_research_research_grant_record_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ADD CONSTRAINT `fk_research_research_grant_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ADD CONSTRAINT `fk_research_research_grant_research_co_investigator_clinician_id` FOREIGN KEY (`research_co_investigator_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_trial_eligibility_evaluation` ADD CONSTRAINT `fk_research_research_trial_eligibility_evaluation_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`clinical_trial_eligibility_evaluation` ADD CONSTRAINT `fk_research_clinical_trial_eligibility_evaluation_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`trial_matching` ADD CONSTRAINT `fk_research_trial_matching_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`trial_matching` ADD CONSTRAINT `fk_research_trial_matching_trial_clinician_id` FOREIGN KEY (`trial_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`trial_matching` ADD CONSTRAINT `fk_research_trial_matching_trial_principal_investigator_clinician_id` FOREIGN KEY (`trial_principal_investigator_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_genomic_eligibility` ADD CONSTRAINT `fk_research_study_genomic_eligibility_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_version` ADD CONSTRAINT `fk_research_protocol_version_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= research --> radiology (4 constraint(s)) =========
-- Requires: research schema, radiology schema
ALTER TABLE `healthcare_ecm_v1`.`research`.`subject_enrollment` ADD CONSTRAINT `fk_research_subject_enrollment_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `healthcare_ecm_v1`.`radiology`.`protocol`(`protocol_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_arm` ADD CONSTRAINT `fk_research_study_arm_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `healthcare_ecm_v1`.`radiology`.`protocol`(`protocol_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_document` ADD CONSTRAINT `fk_research_research_document_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `healthcare_ecm_v1`.`radiology`.`protocol`(`protocol_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`trial_matching` ADD CONSTRAINT `fk_research_trial_matching_protocol_id` FOREIGN KEY (`protocol_id`) REFERENCES `healthcare_ecm_v1`.`radiology`.`protocol`(`protocol_id`);

-- ========= research --> supply (1 constraint(s)) =========
-- Requires: research schema, supply schema
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_expenditure` ADD CONSTRAINT `fk_research_grant_expenditure_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`vendor`(`vendor_id`);

-- ========= research --> workforce (21 constraint(s)) =========
-- Requires: research schema, workforce schema
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ADD CONSTRAINT `fk_research_informed_consent_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`informed_consent` ADD CONSTRAINT `fk_research_informed_consent_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`study_visit` ADD CONSTRAINT `fk_research_study_visit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`adverse_event` ADD CONSTRAINT `fk_research_adverse_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`ip_dispensation` ADD CONSTRAINT `fk_research_ip_dispensation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`coverage_analysis` ADD CONSTRAINT `fk_research_coverage_analysis_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`monitoring_visit` ADD CONSTRAINT `fk_research_monitoring_visit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ADD CONSTRAINT `fk_research_protocol_deviation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_deviation` ADD CONSTRAINT `fk_research_protocol_deviation_protocol_employee_id` FOREIGN KEY (`protocol_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`data_access_request` ADD CONSTRAINT `fk_research_data_access_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ADD CONSTRAINT `fk_research_consent_template_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`consent_template` ADD CONSTRAINT `fk_research_consent_template_primary_employee_id` FOREIGN KEY (`primary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`grant_personnel` ADD CONSTRAINT `fk_research_grant_personnel_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`investigational_product_training` ADD CONSTRAINT `fk_research_investigational_product_training_education_program_id` FOREIGN KEY (`education_program_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`education_program`(`education_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant_record` ADD CONSTRAINT `fk_research_research_grant_record_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_grant` ADD CONSTRAINT `fk_research_research_grant_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`research_trial_eligibility_evaluation` ADD CONSTRAINT `fk_research_research_trial_eligibility_evaluation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`patient_trial_matching_result` ADD CONSTRAINT `fk_research_patient_trial_matching_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_version` ADD CONSTRAINT `fk_research_protocol_version_author_employee_id` FOREIGN KEY (`author_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`research`.`protocol_version` ADD CONSTRAINT `fk_research_protocol_version_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);

-- ========= research_clinical_trial_matching --> clinical_ai (1 constraint(s)) =========
-- Requires: research_clinical_trial_matching schema, clinical_ai schema
ALTER TABLE `healthcare_ecm_v1`.`research_clinical_trial_matching`.`research_clinical_trial_matching_eligibility_evaluation` ADD CONSTRAINT `fk_research_clinical_trial_matching_research_clinical_trial_matching_eligibility_evaluation_clinical_ai_patient_risk_score_id` FOREIGN KEY (`clinical_ai_patient_risk_score_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score`(`clinical_ai_patient_risk_score_id`);

-- ========= research_clinical_trial_matching --> genomics (1 constraint(s)) =========
-- Requires: research_clinical_trial_matching schema, genomics schema
ALTER TABLE `healthcare_ecm_v1`.`research_clinical_trial_matching`.`research_clinical_trial_matching_eligibility_evaluation` ADD CONSTRAINT `fk_research_clinical_trial_matching_research_clinical_trial_matching_eligibility_evaluation_genomic_test_result_id` FOREIGN KEY (`genomic_test_result_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomic_test_result`(`genomic_test_result_id`);

-- ========= research_clinical_trial_matching --> patient (1 constraint(s)) =========
-- Requires: research_clinical_trial_matching schema, patient schema
ALTER TABLE `healthcare_ecm_v1`.`research_clinical_trial_matching`.`research_clinical_trial_matching_eligibility_evaluation` ADD CONSTRAINT `fk_research_clinical_trial_matching_research_clinical_trial_matching_eligibility_evaluation_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);

-- ========= research_clinical_trial_matching --> post_acute_care (1 constraint(s)) =========
-- Requires: research_clinical_trial_matching schema, post_acute_care schema
ALTER TABLE `healthcare_ecm_v1`.`research_clinical_trial_matching`.`research_clinical_trial_matching_eligibility_evaluation` ADD CONSTRAINT `fk_research_clinical_trial_matching_research_clinical_trial_matching_eligibility_evaluation_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);

-- ========= research_clinical_trial_matching --> research (2 constraint(s)) =========
-- Requires: research_clinical_trial_matching schema, research schema
ALTER TABLE `healthcare_ecm_v1`.`research_clinical_trial_matching`.`research_clinical_trial_matching_eligibility_criteria` ADD CONSTRAINT `fk_research_clinical_trial_matching_research_clinical_trial_matching_eligibility_criteria_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`research_clinical_trial_matching`.`research_clinical_trial_matching_trial_eligibility_criteria` ADD CONSTRAINT `fk_research_clinical_trial_matching_research_clinical_trial_matching_trial_eligibility_criteria_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);

-- ========= scheduling --> billing (3 constraint(s)) =========
-- Requires: scheduling schema, billing schema
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`appointment_type` ADD CONSTRAINT `fk_scheduling_appointment_type_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `healthcare_ecm_v1`.`billing`.`cdm_entry`(`cdm_entry_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `healthcare_ecm_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_cdm_entry_id` FOREIGN KEY (`cdm_entry_id`) REFERENCES `healthcare_ecm_v1`.`billing`.`cdm_entry`(`cdm_entry_id`);

-- ========= scheduling --> claim (4 constraint(s)) =========
-- Requires: scheduling schema, claim schema
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_eligibility_id` FOREIGN KEY (`eligibility_id`) REFERENCES `healthcare_ecm_v1`.`claim`.`eligibility`(`eligibility_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `healthcare_ecm_v1`.`claim`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `healthcare_ecm_v1`.`claim`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `healthcare_ecm_v1`.`claim`.`prior_authorization`(`prior_authorization_id`);

-- ========= scheduling --> clinical (13 constraint(s)) =========
-- Requires: scheduling schema, clinical schema
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`procedure_event`(`procedure_event_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`procedure_event`(`procedure_event_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_problem_id` FOREIGN KEY (`problem_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`problem`(`problem_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`appointment_reminder` ADD CONSTRAINT `fk_scheduling_appointment_reminder_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_care_plan_id` FOREIGN KEY (`care_plan_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`care_plan`(`care_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_immunization_id` FOREIGN KEY (`immunization_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`immunization`(`immunization_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_problem_id` FOREIGN KEY (`problem_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`problem`(`problem_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`procedure_event`(`procedure_event_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_diagnosis_id` FOREIGN KEY (`diagnosis_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`diagnosis`(`diagnosis_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`procedure_event`(`procedure_event_id`);

-- ========= scheduling --> clinical_ai (3 constraint(s)) =========
-- Requires: scheduling schema, clinical_ai schema
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_clinical_ai_patient_risk_score_id` FOREIGN KEY (`clinical_ai_patient_risk_score_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_patient_risk_score`(`clinical_ai_patient_risk_score_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_clinical_ai_care_gap_id` FOREIGN KEY (`clinical_ai_care_gap_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap`(`clinical_ai_care_gap_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_clinical_ai_care_gap_id` FOREIGN KEY (`clinical_ai_care_gap_id`) REFERENCES `healthcare_ecm_v1`.`clinical_ai`.`clinical_ai_care_gap`(`clinical_ai_care_gap_id`);

-- ========= scheduling --> compliance (12 constraint(s)) =========
-- Requires: scheduling schema, compliance schema
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`appointment_type` ADD CONSTRAINT `fk_scheduling_appointment_type_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`schedulable_resource` ADD CONSTRAINT `fk_scheduling_schedulable_resource_training_completion_id` FOREIGN KEY (`training_completion_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`training_completion`(`training_completion_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`booking_rule` ADD CONSTRAINT `fk_scheduling_booking_rule_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_hipaa_privacy_incident_id` FOREIGN KEY (`hipaa_privacy_incident_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`hipaa_privacy_incident`(`hipaa_privacy_incident_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`surgical_case_team` ADD CONSTRAINT `fk_scheduling_surgical_case_team_training_completion_id` FOREIGN KEY (`training_completion_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`training_completion`(`training_completion_id`);

-- ========= scheduling --> consent (6 constraint(s)) =========
-- Requires: scheduling schema, consent schema
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_treatment_consent_id` FOREIGN KEY (`treatment_consent_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`treatment_consent`(`treatment_consent_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_telehealth_consent_id` FOREIGN KEY (`telehealth_consent_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`telehealth_consent`(`telehealth_consent_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `healthcare_ecm_v1`.`consent`.`consent_consent_record`(`consent_record_id`);

-- ========= scheduling --> digital_health (1 constraint(s)) =========
-- Requires: scheduling schema, digital_health schema
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_rpm_enrollment_id` FOREIGN KEY (`rpm_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment`(`rpm_enrollment_id`);

-- ========= scheduling --> encounter (7 constraint(s)) =========
-- Requires: scheduling schema, encounter schema
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_encounter_authorization_id` FOREIGN KEY (`encounter_authorization_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`encounter_authorization`(`encounter_authorization_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_encounter_authorization_id` FOREIGN KEY (`encounter_authorization_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`encounter_authorization`(`encounter_authorization_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_encounter_authorization_id` FOREIGN KEY (`encounter_authorization_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`encounter_authorization`(`encounter_authorization_id`);

-- ========= scheduling --> facility (30 constraint(s)) =========
-- Requires: scheduling schema, facility schema
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_facility_contract_id` FOREIGN KEY (`facility_contract_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`facility_contract`(`facility_contract_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_facility_service_id` FOREIGN KEY (`facility_service_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`facility_service`(`facility_service_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`schedulable_resource` ADD CONSTRAINT `fk_scheduling_schedulable_resource_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`schedulable_resource` ADD CONSTRAINT `fk_scheduling_schedulable_resource_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`appointment_status_history` ADD CONSTRAINT `fk_scheduling_appointment_status_history_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`capacity_utilization` ADD CONSTRAINT `fk_scheduling_capacity_utilization_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`block_utilization` ADD CONSTRAINT `fk_scheduling_block_utilization_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`block_utilization` ADD CONSTRAINT `fk_scheduling_block_utilization_facility_service_id` FOREIGN KEY (`facility_service_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`facility_service`(`facility_service_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`block_utilization` ADD CONSTRAINT `fk_scheduling_block_utilization_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`booking_rule` ADD CONSTRAINT `fk_scheduling_booking_rule_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`patient_preference` ADD CONSTRAINT `fk_scheduling_patient_preference_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`provider_availability` ADD CONSTRAINT `fk_scheduling_provider_availability_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`reminder_template` ADD CONSTRAINT `fk_scheduling_reminder_template_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= scheduling --> finance (8 constraint(s)) =========
-- Requires: scheduling schema, finance schema
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`budget`(`budget_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`appointment_reminder` ADD CONSTRAINT `fk_scheduling_appointment_reminder_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`capacity_utilization` ADD CONSTRAINT `fk_scheduling_capacity_utilization_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`budget`(`budget_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`fixed_asset`(`fixed_asset_id`);

-- ========= scheduling --> insurance (13 constraint(s)) =========
-- Requires: scheduling schema, insurance schema
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_member_enrollment_id` FOREIGN KEY (`member_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`appointment_reminder` ADD CONSTRAINT `fk_scheduling_appointment_reminder_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`appointment_prior_auth_requirement` ADD CONSTRAINT `fk_scheduling_appointment_prior_auth_requirement_prior_auth_rule_id` FOREIGN KEY (`prior_auth_rule_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);

-- ========= scheduling --> interoperability (1 constraint(s)) =========
-- Requires: scheduling schema, interoperability schema
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_fhir_resource_log_id` FOREIGN KEY (`fhir_resource_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`fhir_resource_log`(`fhir_resource_log_id`);

-- ========= scheduling --> laboratory (1 constraint(s)) =========
-- Requires: scheduling schema, laboratory schema
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_lab_order_id` FOREIGN KEY (`lab_order_id`) REFERENCES `healthcare_ecm_v1`.`laboratory`.`lab_order`(`lab_order_id`);

-- ========= scheduling --> order (5 constraint(s)) =========
-- Requires: scheduling schema, order schema
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_referral_order_id` FOREIGN KEY (`referral_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`referral_order`(`referral_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_referral_order_id` FOREIGN KEY (`referral_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`referral_order`(`referral_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= scheduling --> patient (12 constraint(s)) =========
-- Requires: scheduling schema, patient schema
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_surgical_mpi_record_id` FOREIGN KEY (`surgical_mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`appointment_reminder` ADD CONSTRAINT `fk_scheduling_appointment_reminder_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`patient_preference` ADD CONSTRAINT `fk_scheduling_patient_preference_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_mpi_record_id` FOREIGN KEY (`mpi_record_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`mpi_record`(`mpi_record_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_insurance_coverage_id` FOREIGN KEY (`insurance_coverage_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`insurance_coverage`(`insurance_coverage_id`);

-- ========= scheduling --> provider (22 constraint(s)) =========
-- Requires: scheduling schema, provider schema
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_network_affiliation_id` FOREIGN KEY (`network_affiliation_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`network_affiliation`(`network_affiliation_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_provider_payer_enrollment_id` FOREIGN KEY (`provider_payer_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`provider_payer_enrollment`(`provider_payer_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_malpractice_coverage_id` FOREIGN KEY (`malpractice_coverage_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`malpractice_coverage`(`malpractice_coverage_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_privileging_id` FOREIGN KEY (`privileging_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`privileging`(`privileging_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_anesthesiologist_clinician_id` FOREIGN KEY (`anesthesiologist_clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`block_utilization` ADD CONSTRAINT `fk_scheduling_block_utilization_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`booking_rule` ADD CONSTRAINT `fk_scheduling_booking_rule_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`patient_preference` ADD CONSTRAINT `fk_scheduling_patient_preference_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_provider_credential_id` FOREIGN KEY (`provider_credential_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`provider_credential`(`provider_credential_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`telehealth_session` ADD CONSTRAINT `fk_scheduling_telehealth_session_telehealth_authorization_id` FOREIGN KEY (`telehealth_authorization_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`telehealth_authorization`(`telehealth_authorization_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`provider_availability` ADD CONSTRAINT `fk_scheduling_provider_availability_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`reminder_template` ADD CONSTRAINT `fk_scheduling_reminder_template_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`specialty`(`specialty_id`);

-- ========= scheduling --> quality (2 constraint(s)) =========
-- Requires: scheduling schema, quality schema
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_population_health_gap_id` FOREIGN KEY (`population_health_gap_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`population_health_gap`(`population_health_gap_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_population_health_gap_id` FOREIGN KEY (`population_health_gap_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`population_health_gap`(`population_health_gap_id`);

-- ========= scheduling --> reference (11 constraint(s)) =========
-- Requires: scheduling schema, reference schema
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`appointment_type` ADD CONSTRAINT `fk_scheduling_appointment_type_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_drg_id` FOREIGN KEY (`drg_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`drg`(`drg_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);

-- ========= scheduling --> research (7 constraint(s)) =========
-- Requires: scheduling schema, research schema
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `healthcare_ecm_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_study_visit_id` FOREIGN KEY (`study_visit_id`) REFERENCES `healthcare_ecm_v1`.`research`.`study_visit`(`study_visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);

-- ========= scheduling --> supply (4 constraint(s)) =========
-- Requires: scheduling schema, supply schema
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_surgical_bom_id` FOREIGN KEY (`surgical_bom_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`surgical_bom`(`surgical_bom_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`case_material_usage` ADD CONSTRAINT `fk_scheduling_case_material_usage_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `healthcare_ecm_v1`.`supply`.`material_master`(`material_master_id`);

-- ========= scheduling --> workforce (34 constraint(s)) =========
-- Requires: scheduling schema, workforce schema
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`schedulable_resource` ADD CONSTRAINT `fk_scheduling_schedulable_resource_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`schedulable_resource` ADD CONSTRAINT `fk_scheduling_schedulable_resource_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`resource_assignment` ADD CONSTRAINT `fk_scheduling_resource_assignment_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`appointment_status_history` ADD CONSTRAINT `fk_scheduling_appointment_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`capacity_utilization` ADD CONSTRAINT `fk_scheduling_capacity_utilization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`capacity_utilization` ADD CONSTRAINT `fk_scheduling_capacity_utilization_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`block_utilization` ADD CONSTRAINT `fk_scheduling_block_utilization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`booking_rule` ADD CONSTRAINT `fk_scheduling_booking_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`booking_rule` ADD CONSTRAINT `fk_scheduling_booking_rule_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`patient_preference` ADD CONSTRAINT `fk_scheduling_patient_preference_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`patient_preference` ADD CONSTRAINT `fk_scheduling_patient_preference_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`patient_preference` ADD CONSTRAINT `fk_scheduling_patient_preference_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`recall_list` ADD CONSTRAINT `fk_scheduling_recall_list_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`provider_availability` ADD CONSTRAINT `fk_scheduling_provider_availability_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`provider_availability` ADD CONSTRAINT `fk_scheduling_provider_availability_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`provider_availability` ADD CONSTRAINT `fk_scheduling_provider_availability_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`surgical_case_team` ADD CONSTRAINT `fk_scheduling_surgical_case_team_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`surgical_case_team` ADD CONSTRAINT `fk_scheduling_surgical_case_team_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`booking_queue` ADD CONSTRAINT `fk_scheduling_booking_queue_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`equipment_reservation` ADD CONSTRAINT `fk_scheduling_equipment_reservation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`case_material_usage` ADD CONSTRAINT `fk_scheduling_case_material_usage_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`scheduling`.`reminder_template` ADD CONSTRAINT `fk_scheduling_reminder_template_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);

-- ========= supply --> clinical (1 constraint(s)) =========
-- Requires: supply schema, clinical schema
ALTER TABLE `healthcare_ecm_v1`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_procedure_event_id` FOREIGN KEY (`procedure_event_id`) REFERENCES `healthcare_ecm_v1`.`clinical`.`procedure_event`(`procedure_event_id`);

-- ========= supply --> compliance (9 constraint(s)) =========
-- Requires: supply schema, compliance schema
ALTER TABLE `healthcare_ecm_v1`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`vendor` ADD CONSTRAINT `fk_supply_vendor_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`inventory_location` ADD CONSTRAINT `fk_supply_inventory_location_osha_safety_program_id` FOREIGN KEY (`osha_safety_program_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`osha_safety_program`(`osha_safety_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`surgical_bom` ADD CONSTRAINT `fk_supply_surgical_bom_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`sterile_processing_record` ADD CONSTRAINT `fk_supply_sterile_processing_record_cms_condition_status_id` FOREIGN KEY (`cms_condition_status_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`cms_condition_status`(`cms_condition_status_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`recall_notice` ADD CONSTRAINT `fk_supply_recall_notice_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`vendor_contract` ADD CONSTRAINT `fk_supply_vendor_contract_business_associate_agreement_id` FOREIGN KEY (`business_associate_agreement_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`business_associate_agreement`(`business_associate_agreement_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`location_audit` ADD CONSTRAINT `fk_supply_location_audit_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`material_policy_governance` ADD CONSTRAINT `fk_supply_material_policy_governance_compliance_policy_id` FOREIGN KEY (`compliance_policy_id`) REFERENCES `healthcare_ecm_v1`.`compliance`.`compliance_policy`(`compliance_policy_id`);

-- ========= supply --> encounter (3 constraint(s)) =========
-- Requires: supply schema, encounter schema
ALTER TABLE `healthcare_ecm_v1`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_visit_procedure_id` FOREIGN KEY (`visit_procedure_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit_procedure`(`visit_procedure_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `healthcare_ecm_v1`.`encounter`.`visit`(`visit_id`);

-- ========= supply --> facility (16 constraint(s)) =========
-- Requires: supply schema, facility schema
ALTER TABLE `healthcare_ecm_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`inventory_location` ADD CONSTRAINT `fk_supply_inventory_location_building_id` FOREIGN KEY (`building_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`building`(`building_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`inventory_location` ADD CONSTRAINT `fk_supply_inventory_location_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`inventory_location` ADD CONSTRAINT `fk_supply_inventory_location_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`surgical_bom` ADD CONSTRAINT `fk_supply_surgical_bom_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`surgical_bom` ADD CONSTRAINT `fk_supply_surgical_bom_facility_service_id` FOREIGN KEY (`facility_service_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`facility_service`(`facility_service_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`case_cart` ADD CONSTRAINT `fk_supply_case_cart_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`case_cart` ADD CONSTRAINT `fk_supply_case_cart_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`sterile_processing_record` ADD CONSTRAINT `fk_supply_sterile_processing_record_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`sterile_processing_record` ADD CONSTRAINT `fk_supply_sterile_processing_record_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`recall_notice` ADD CONSTRAINT `fk_supply_recall_notice_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);

-- ========= supply --> finance (13 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `healthcare_ecm_v1`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`fund`(`fund_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`inventory_location` ADD CONSTRAINT `fk_supply_inventory_location_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`case_cart` ADD CONSTRAINT `fk_supply_case_cart_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`vendor_contract` ADD CONSTRAINT `fk_supply_vendor_contract_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);

-- ========= supply --> genomics (1 constraint(s)) =========
-- Requires: supply schema, genomics schema
ALTER TABLE `healthcare_ecm_v1`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_genomics_sequencing_run_id` FOREIGN KEY (`genomics_sequencing_run_id`) REFERENCES `healthcare_ecm_v1`.`genomics`.`genomics_sequencing_run`(`genomics_sequencing_run_id`);

-- ========= supply --> insurance (4 constraint(s)) =========
-- Requires: supply schema, insurance schema
ALTER TABLE `healthcare_ecm_v1`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`recall_notice` ADD CONSTRAINT `fk_supply_recall_notice_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);

-- ========= supply --> interoperability (5 constraint(s)) =========
-- Requires: supply schema, interoperability schema
ALTER TABLE `healthcare_ecm_v1`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_interoperability_terminology_mapping_id` FOREIGN KEY (`interoperability_terminology_mapping_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`interoperability_terminology_mapping`(`interoperability_terminology_mapping_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`vendor` ADD CONSTRAINT `fk_supply_vendor_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`recall_notice` ADD CONSTRAINT `fk_supply_recall_notice_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`recall_notice` ADD CONSTRAINT `fk_supply_recall_notice_public_health_report_id` FOREIGN KEY (`public_health_report_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`public_health_report`(`public_health_report_id`);

-- ========= supply --> order (9 constraint(s)) =========
-- Requires: supply schema, order schema
ALTER TABLE `healthcare_ecm_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_requisition_clinical_order_id` FOREIGN KEY (`requisition_clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`surgical_bom` ADD CONSTRAINT `fk_supply_surgical_bom_order_set_id` FOREIGN KEY (`order_set_id`) REFERENCES `healthcare_ecm_v1`.`order`.`order_order_set`(`order_set_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`case_cart` ADD CONSTRAINT `fk_supply_case_cart_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`sterile_processing_record` ADD CONSTRAINT `fk_supply_sterile_processing_record_clinical_order_id` FOREIGN KEY (`clinical_order_id`) REFERENCES `healthcare_ecm_v1`.`order`.`clinical_order`(`clinical_order_id`);

-- ========= supply --> patient (1 constraint(s)) =========
-- Requires: supply schema, patient schema
ALTER TABLE `healthcare_ecm_v1`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_demographics_id` FOREIGN KEY (`demographics_id`) REFERENCES `healthcare_ecm_v1`.`patient`.`demographics`(`demographics_id`);

-- ========= supply --> post_acute_care (3 constraint(s)) =========
-- Requires: supply schema, post_acute_care schema
ALTER TABLE `healthcare_ecm_v1`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_post_acute_episode_id` FOREIGN KEY (`post_acute_episode_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`(`post_acute_episode_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`service_supply_requirement` ADD CONSTRAINT `fk_supply_service_supply_requirement_post_acute_service_id` FOREIGN KEY (`post_acute_service_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_service`(`post_acute_service_id`);

-- ========= supply --> provider (3 constraint(s)) =========
-- Requires: supply schema, provider schema
ALTER TABLE `healthcare_ecm_v1`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`surgical_bom` ADD CONSTRAINT `fk_supply_surgical_bom_preference_card_id` FOREIGN KEY (`preference_card_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`preference_card`(`preference_card_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`case_cart` ADD CONSTRAINT `fk_supply_case_cart_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= supply --> reference (7 constraint(s)) =========
-- Requires: supply schema, reference schema
ALTER TABLE `healthcare_ecm_v1`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_ndc_drug_id` FOREIGN KEY (`ndc_drug_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`ndc_drug`(`ndc_drug_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`udi_record` ADD CONSTRAINT `fk_supply_udi_record_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`surgical_bom` ADD CONSTRAINT `fk_supply_surgical_bom_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`case_cart` ADD CONSTRAINT `fk_supply_case_cart_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);

-- ========= supply --> scheduling (3 constraint(s)) =========
-- Requires: supply schema, scheduling schema
ALTER TABLE `healthcare_ecm_v1`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `healthcare_ecm_v1`.`scheduling`.`surgical_case`(`surgical_case_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`case_cart` ADD CONSTRAINT `fk_supply_case_cart_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `healthcare_ecm_v1`.`scheduling`.`surgical_case`(`surgical_case_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`sterile_processing_record` ADD CONSTRAINT `fk_supply_sterile_processing_record_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `healthcare_ecm_v1`.`scheduling`.`surgical_case`(`surgical_case_id`);

-- ========= supply --> workforce (23 constraint(s)) =========
-- Requires: supply schema, workforce schema
ALTER TABLE `healthcare_ecm_v1`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`vendor` ADD CONSTRAINT `fk_supply_vendor_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_purchase_employee_id` FOREIGN KEY (`purchase_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_approved_by_employee_id` FOREIGN KEY (`approved_by_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`inventory_location` ADD CONSTRAINT `fk_supply_inventory_location_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`inventory_balance` ADD CONSTRAINT `fk_supply_inventory_balance_last_count_employee_id` FOREIGN KEY (`last_count_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`inventory_transaction` ADD CONSTRAINT `fk_supply_inventory_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_approver_employee_id` FOREIGN KEY (`approver_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_requisition_employee_id` FOREIGN KEY (`requisition_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_requisition_requestor_employee_id` FOREIGN KEY (`requisition_requestor_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_approved_by_employee_id` FOREIGN KEY (`approved_by_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`surgical_bom` ADD CONSTRAINT `fk_supply_surgical_bom_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`surgical_bom` ADD CONSTRAINT `fk_supply_surgical_bom_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`case_cart` ADD CONSTRAINT `fk_supply_case_cart_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`case_cart` ADD CONSTRAINT `fk_supply_case_cart_tertiary_employee_id` FOREIGN KEY (`tertiary_employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`sterile_processing_record` ADD CONSTRAINT `fk_supply_sterile_processing_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`recall_notice` ADD CONSTRAINT `fk_supply_recall_notice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `healthcare_ecm_v1`.`supply`.`vendor_contract` ADD CONSTRAINT `fk_supply_vendor_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `healthcare_ecm_v1`.`workforce`.`employee`(`employee_id`);

-- ========= uc_tags --> metadata (1 constraint(s)) =========
-- Requires: uc_tags schema, metadata schema
ALTER TABLE `healthcare_ecm_v1`.`uc_tags`.`industry_outcome_plugin_registry` ADD CONSTRAINT `fk_uc_tags_industry_outcome_plugin_registry_industry_outcome_plugin_id` FOREIGN KEY (`industry_outcome_plugin_id`) REFERENCES `healthcare_ecm_v1`.`metadata`.`industry_outcome_plugin`(`industry_outcome_plugin_id`);

-- ========= workforce --> facility (17 constraint(s)) =========
-- Requires: workforce schema, facility schema
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_primary_work_location_care_site_id` FOREIGN KEY (`primary_work_location_care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`employment_competency` ADD CONSTRAINT `fk_workforce_employment_competency_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`competency_assessment` ADD CONSTRAINT `fk_workforce_competency_assessment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`workforce_shift_schedule` ADD CONSTRAINT `fk_workforce_workforce_shift_schedule_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`workforce_shift_schedule` ADD CONSTRAINT `fk_workforce_workforce_shift_schedule_room_id` FOREIGN KEY (`room_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`workforce_shift_schedule` ADD CONSTRAINT `fk_workforce_workforce_shift_schedule_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`recruitment` ADD CONSTRAINT `fk_workforce_recruitment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`fte_budget` ADD CONSTRAINT `fk_workforce_fte_budget_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`education_program` ADD CONSTRAINT `fk_workforce_education_program_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`applicant` ADD CONSTRAINT `fk_workforce_applicant_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`payroll_calendar` ADD CONSTRAINT `fk_workforce_payroll_calendar_facility_organization_id` FOREIGN KEY (`facility_organization_id`) REFERENCES `healthcare_ecm_v1`.`facility`.`facility_organization`(`facility_organization_id`);

-- ========= workforce --> finance (7 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`workforce_shift_schedule` ADD CONSTRAINT `fk_workforce_workforce_shift_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`fte_budget` ADD CONSTRAINT `fk_workforce_fte_budget_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`benefit_plan` ADD CONSTRAINT `fk_workforce_benefit_plan_financial_entity_id` FOREIGN KEY (`financial_entity_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`financial_entity`(`financial_entity_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`payroll_calendar` ADD CONSTRAINT `fk_workforce_payroll_calendar_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `healthcare_ecm_v1`.`finance`.`fiscal_period`(`fiscal_period_id`);

-- ========= workforce --> insurance (2 constraint(s)) =========
-- Requires: workforce schema, insurance schema
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`workforce_provider_network_participation` ADD CONSTRAINT `fk_workforce_workforce_provider_network_participation_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `healthcare_ecm_v1`.`insurance`.`payer`(`payer_id`);

-- ========= workforce --> interoperability (1 constraint(s)) =========
-- Requires: workforce schema, interoperability schema
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`channel_support_assignment` ADD CONSTRAINT `fk_workforce_channel_support_assignment_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `healthcare_ecm_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);

-- ========= workforce --> post_acute_care (1 constraint(s)) =========
-- Requires: workforce schema, post_acute_care schema
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`staffing_assignment` ADD CONSTRAINT `fk_workforce_staffing_assignment_post_acute_location_id` FOREIGN KEY (`post_acute_location_id`) REFERENCES `healthcare_ecm_v1`.`post_acute_care`.`post_acute_location`(`post_acute_location_id`);

-- ========= workforce --> provider (5 constraint(s)) =========
-- Requires: workforce schema, provider schema
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_specialty_id` FOREIGN KEY (`specialty_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`specialty`(`specialty_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`employment_competency` ADD CONSTRAINT `fk_workforce_employment_competency_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`competency_assessment` ADD CONSTRAINT `fk_workforce_competency_assessment_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`workforce_shift_schedule` ADD CONSTRAINT `fk_workforce_workforce_shift_schedule_clinician_id` FOREIGN KEY (`clinician_id`) REFERENCES `healthcare_ecm_v1`.`provider`.`clinician`(`clinician_id`);

-- ========= workforce --> quality (1 constraint(s)) =========
-- Requires: workforce schema, quality schema
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_improvement_initiative_id` FOREIGN KEY (`improvement_initiative_id`) REFERENCES `healthcare_ecm_v1`.`quality`.`improvement_initiative`(`improvement_initiative_id`);

-- ========= workforce --> reference (11 constraint(s)) =========
-- Requires: workforce schema, reference schema
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_npi_registry_id` FOREIGN KEY (`npi_registry_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`npi_registry`(`npi_registry_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`employment_competency` ADD CONSTRAINT `fk_workforce_employment_competency_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`employment_competency` ADD CONSTRAINT `fk_workforce_employment_competency_hcpcs_code_id` FOREIGN KEY (`hcpcs_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`hcpcs_code`(`hcpcs_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`employment_competency` ADD CONSTRAINT `fk_workforce_employment_competency_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`competency_assessment` ADD CONSTRAINT `fk_workforce_competency_assessment_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`competency_assessment` ADD CONSTRAINT `fk_workforce_competency_assessment_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`competency_assessment` ADD CONSTRAINT `fk_workforce_competency_assessment_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_icd_code_id` FOREIGN KEY (`icd_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`icd_code`(`icd_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_snomed_concept_id` FOREIGN KEY (`snomed_concept_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`clinical_privilege` ADD CONSTRAINT `fk_workforce_clinical_privilege_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);
ALTER TABLE `healthcare_ecm_v1`.`workforce`.`position_procedure_authorization` ADD CONSTRAINT `fk_workforce_position_procedure_authorization_cpt_code_id` FOREIGN KEY (`cpt_code_id`) REFERENCES `healthcare_ecm_v1`.`reference`.`cpt_code`(`cpt_code_id`);

