-- Schema for Domain: patient_engagement | Business:  | Version: v5_ecm
-- Generated on: 2026-05-21 09:45:17

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `healthcare_ecm_v1`.`patient_engagement` COMMENT 'Patient Engagement subdomain covering RPM device readings, PROM responses, and portal engagement events.';

-- ========= TABLES =========
CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_rpm_device_readings` (
    `patient_engagement_rpm_device_readings_id` BIGINT COMMENT 'Primary key for patient_engagement_rpm_device_readings',
    `behavioral_health_mat_treatment_id` BIGINT COMMENT 'Foreign key linking to behavioral_health.mat_treatment. Business justification: RPM wearables monitor MAT patients for compliance indicators (sleep, activity, vitals) and early relapse detection; OTP programs increasingly require remote monitoring data per treatment.',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_episode. Business justification: RPM devices are deployed during post-acute episodes (home health, SNF discharge). CMS RPM billing (CPT 99453-99458) requires episode association. Enables readmission prevention by linking vitals to re',
    CONSTRAINT pk_patient_engagement_rpm_device_readings PRIMARY KEY(`patient_engagement_rpm_device_readings_id`)
) COMMENT 'Replaced by digital_health.rpm_reading - this table is deprecated';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_prom_responses` (
    `patient_engagement_prom_responses_id` BIGINT COMMENT 'Primary key for patient_engagement_prom_responses',
    `behavioral_health_psychiatric_assessment_id` BIGINT COMMENT 'Foreign key linking to behavioral_health.psychiatric_assessment. Business justification: PROMs (PHQ-9, GAD-7) are administered as part of psychiatric assessments; clinicians use PROM scores to validate assessment findings and track longitudinal outcomes per CMS quality measures.',
    `behavioral_health_sud_episode_id` BIGINT COMMENT 'Foreign key linking to behavioral_health.sud_episode. Business justification: SUD quality programs (HEDIS, MIPS) require patient-reported outcomes (AUDIT, DAST, PROMIS) tracked per treatment episode for outcome reporting and accreditation.',
    `clinical_ai_care_gap_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.care_gap. Business justification: PROM submissions (e.g., PHQ-9, pain scales) directly resolve AI-detected care gaps (e.g., depression screening overdue). Quality programs require linking completed PROMs to the care gaps they satisf',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_episode. Business justification: CMS mandates PROM collection during post-acute episodes (OASIS functional assessments, MDS). Links patient-reported outcomes to episodes for HHVBP quality scoring and discharge readiness determination',
    `service_delivery_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.service_delivery. Business justification: PROMs are administered during specific home health visits/therapy sessions. OASIS assessments occur at SOC/ROC/DC visits. Linking to service_delivery enables visit-level functional status tracking req',
    `therapy_session_id` BIGINT COMMENT 'Foreign key linking to behavioral_health.therapy_session. Business justification: Standard behavioral health practice: outcome measures (PHQ-9, GAD-7, PCL-5) collected before/after each therapy session to measure treatment response and guide clinical decisions.',
    CONSTRAINT pk_patient_engagement_prom_responses PRIMARY KEY(`patient_engagement_prom_responses_id`)
) COMMENT 'Replaced by digital_health.prom_response - this table is deprecated';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_portal_engagement_events` (
    `patient_engagement_portal_engagement_events_id` BIGINT COMMENT 'Primary key for patient_engagement_portal_engagement_events',
    `behavioral_health_cfr42_consent_id` BIGINT COMMENT 'Foreign key linking to behavioral_health.cfr42_consent. Business justification: Patients manage 42 CFR Part 2 consent via portal (view, sign, revoke); tracking portal consent interactions is required for audit trail under federal substance use privacy regulations.',
    `clinical_ai_care_gap_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.care_gap. Business justification: Patient portals surface AI-detected care gaps and track patient engagement (viewed, dismissed, acted-on). Care gap closure workflows require linking portal actions to specific gaps for outreach effect',
    CONSTRAINT pk_patient_engagement_portal_engagement_events PRIMARY KEY(`patient_engagement_portal_engagement_events_id`)
) COMMENT 'Replaced by digital_health.portal_engagement_event - this table is deprecated';

-- ========= TAGS =========
ALTER SCHEMA `healthcare_ecm_v1`.`patient_engagement` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `healthcare_ecm_v1`.`patient_engagement` SET TAGS ('dbx_domain' = 'patient_engagement');
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_rpm_device_readings` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_rpm_device_readings` SET TAGS ('dbx_subdomain' = 'patient_engagement');
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_rpm_device_readings` ALTER COLUMN `patient_engagement_rpm_device_readings_id` SET TAGS ('dbx_business_glossary_term' = 'patient_engagement_rpm_device_readings Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_rpm_device_readings` ALTER COLUMN `behavioral_health_mat_treatment_id` SET TAGS ('dbx_business_glossary_term' = 'Mat Treatment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_rpm_device_readings` ALTER COLUMN `behavioral_health_mat_treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_rpm_device_readings` ALTER COLUMN `behavioral_health_mat_treatment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_rpm_device_readings` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_prom_responses` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_prom_responses` SET TAGS ('dbx_subdomain' = 'patient_engagement');
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_prom_responses` ALTER COLUMN `patient_engagement_prom_responses_id` SET TAGS ('dbx_business_glossary_term' = 'patient_engagement_prom_responses Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_prom_responses` ALTER COLUMN `behavioral_health_psychiatric_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Psychiatric Assessment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_prom_responses` ALTER COLUMN `behavioral_health_psychiatric_assessment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_prom_responses` ALTER COLUMN `behavioral_health_psychiatric_assessment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_prom_responses` ALTER COLUMN `behavioral_health_sud_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Sud Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_prom_responses` ALTER COLUMN `behavioral_health_sud_episode_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_prom_responses` ALTER COLUMN `behavioral_health_sud_episode_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_prom_responses` ALTER COLUMN `clinical_ai_care_gap_id` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_prom_responses` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_prom_responses` ALTER COLUMN `service_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Service Delivery Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_prom_responses` ALTER COLUMN `therapy_session_id` SET TAGS ('dbx_business_glossary_term' = 'Therapy Session Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_portal_engagement_events` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_portal_engagement_events` SET TAGS ('dbx_subdomain' = 'patient_engagement');
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_portal_engagement_events` ALTER COLUMN `patient_engagement_portal_engagement_events_id` SET TAGS ('dbx_business_glossary_term' = 'patient_engagement_portal_engagement_events Identifier');
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_portal_engagement_events` ALTER COLUMN `behavioral_health_cfr42_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Cfr42 Consent Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_portal_engagement_events` ALTER COLUMN `behavioral_health_cfr42_consent_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_portal_engagement_events` ALTER COLUMN `behavioral_health_cfr42_consent_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`patient_engagement`.`patient_engagement_portal_engagement_events` ALTER COLUMN `clinical_ai_care_gap_id` SET TAGS ('dbx_business_glossary_term' = 'Care Gap Id (Foreign Key)');
