-- Schema for Domain: fk | Business:  | Version: v5_ecm
-- Generated on: 2026-05-21 09:45:14

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `healthcare_ecm_v1`.`fk` COMMENT '';

-- ========= TABLES =========
CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`fk`.`new_connections` (
    `new_connections_id` BIGINT COMMENT 'Primary key for new_connections',
    `clinical_order_id` BIGINT COMMENT 'FK linking pharmacy.prescription.clinical_order_id to order.clinical_order',
    `provider_network_id` BIGINT COMMENT 'FK linking insurance.provider_network.network_id to insurance.provider_network',
    `visit_id` BIGINT COMMENT 'FK linking scheduling.scheduling_appointment.visit_id to encounter.visit',
    CONSTRAINT pk_new_connections PRIMARY KEY(`new_connections_id`)
) COMMENT 'Add 62 new FK connections from next_vibes priorities 35-96.';

-- ========= TAGS =========
ALTER SCHEMA `healthcare_ecm_v1`.`fk` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `healthcare_ecm_v1`.`fk` SET TAGS ('dbx_domain' = 'fk');
ALTER TABLE `healthcare_ecm_v1`.`fk`.`new_connections` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`fk`.`new_connections` ALTER COLUMN `new_connections_id` SET TAGS ('dbx_business_glossary_term' = 'new_connections Identifier');
