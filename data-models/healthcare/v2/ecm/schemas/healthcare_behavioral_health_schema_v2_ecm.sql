-- Schema for Domain: behavioral_health | Business:  | Version: v2_ecm
-- Generated on: 2026-06-23 13:03:42

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`behavioral_health` COMMENT '';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` (
    `psychiatric_assessment_id` BIGINT COMMENT '',
    `demographics_id` BIGINT COMMENT '',
    `assessment_date` DATE COMMENT '',
    `phq9_score` BIGINT COMMENT '',
    `gad7_score` BIGINT COMMENT '',
    `cssrs_score` BIGINT COMMENT '',
    CONSTRAINT pk_psychiatric_assessment PRIMARY KEY(`psychiatric_assessment_id`)
) COMMENT '';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` (
    `sud_episode_id` BIGINT COMMENT '',
    `demographics_id` BIGINT COMMENT '',
    `substance_type` STRING COMMENT '',
    `episode_start_date` DATE COMMENT '',
    `episode_end_date` DATE COMMENT '',
    CONSTRAINT pk_sud_episode PRIMARY KEY(`sud_episode_id`)
) COMMENT '';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` (
    `mat_treatment_id` BIGINT COMMENT '',
    `demographics_id` BIGINT COMMENT '',
    `sud_episode_id` BIGINT COMMENT '',
    `medication` STRING COMMENT '',
    `start_date` DATE COMMENT '',
    CONSTRAINT pk_mat_treatment PRIMARY KEY(`mat_treatment_id`)
) COMMENT '';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` (
    `otp_enrollment_id` BIGINT COMMENT '',
    `demographics_id` BIGINT COMMENT '',
    `program_name` STRING COMMENT '',
    `enrollment_date` DATE COMMENT '',
    CONSTRAINT pk_otp_enrollment PRIMARY KEY(`otp_enrollment_id`)
) COMMENT '';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` (
    `crisis_episode_id` BIGINT COMMENT '',
    `demographics_id` BIGINT COMMENT '',
    `crisis_type` STRING COMMENT '',
    `crisis_date` DATE COMMENT '',
    `disposition` STRING COMMENT '',
    CONSTRAINT pk_crisis_episode PRIMARY KEY(`crisis_episode_id`)
) COMMENT '';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` (
    `part2_consent_id` BIGINT COMMENT '',
    `demographics_id` BIGINT COMMENT '',
    `consent_status` STRING COMMENT '',
    `consent_date` DATE COMMENT '',
    `expiration_date` DATE COMMENT '',
    CONSTRAINT pk_part2_consent PRIMARY KEY(`part2_consent_id`)
) COMMENT '';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent_disclosure` (
    `part2_consent_disclosure_id` BIGINT COMMENT '',
    `part2_consent_id` BIGINT COMMENT '',
    `psychiatric_assessment_id` BIGINT COMMENT '',
    `sud_episode_id` BIGINT COMMENT '',
    `recipient` STRING COMMENT '',
    `disclosure_date` DATE COMMENT '',
    CONSTRAINT pk_part2_consent_disclosure PRIMARY KEY(`part2_consent_disclosure_id`)
) COMMENT '';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ADD CONSTRAINT `fk_behavioral_health_mat_treatment_sud_episode_id` FOREIGN KEY (`sud_episode_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`sud_episode`(`sud_episode_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent_disclosure` ADD CONSTRAINT `fk_behavioral_health_part2_consent_disclosure_part2_consent_id` FOREIGN KEY (`part2_consent_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`part2_consent`(`part2_consent_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent_disclosure` ADD CONSTRAINT `fk_behavioral_health_part2_consent_disclosure_psychiatric_assessment_id` FOREIGN KEY (`psychiatric_assessment_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment`(`psychiatric_assessment_id`);
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent_disclosure` ADD CONSTRAINT `fk_behavioral_health_part2_consent_disclosure_sud_episode_id` FOREIGN KEY (`sud_episode_id`) REFERENCES `vibe_healthcare_v1`.`behavioral_health`.`sud_episode`(`sud_episode_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`behavioral_health` SET TAGS ('pii_division' = 'business');
ALTER SCHEMA `vibe_healthcare_v1`.`behavioral_health` SET TAGS ('pii_domain' = 'behavioral_health');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `demographics_id` SET TAGS ('pii_regulation' = '42_CFR_Part_2');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `phq9_score` SET TAGS ('pii_instrument' = 'PHQ-9');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `gad7_score` SET TAGS ('pii_instrument' = 'GAD-7');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`psychiatric_assessment` ALTER COLUMN `cssrs_score` SET TAGS ('pii_instrument' = 'Columbia_Suicide_Severity_Rating_Scale');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`sud_episode` ALTER COLUMN `demographics_id` SET TAGS ('pii_regulation' = '42_CFR_Part_2');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`mat_treatment` ALTER COLUMN `demographics_id` SET TAGS ('pii_regulation' = '42_CFR_Part_2');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`otp_enrollment` ALTER COLUMN `demographics_id` SET TAGS ('pii_regulation' = '42_CFR_Part_2');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`crisis_episode` ALTER COLUMN `demographics_id` SET TAGS ('pii_regulation' = '42_CFR_Part_2');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `demographics_id` SET TAGS ('pii_regulation' = '42_CFR_Part_2');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent` ALTER COLUMN `consent_status` SET TAGS ('pii_regulation' = '42_CFR_Part_2');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent_disclosure` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`behavioral_health`.`part2_consent_disclosure` ALTER COLUMN `part2_consent_id` SET TAGS ('pii_regulation' = '42_CFR_Part_2');
