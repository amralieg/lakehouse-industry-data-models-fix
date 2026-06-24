-- Schema for Domain: field_services | Business:  | Version: v2_ecm
-- Generated on: 2026-06-23 03:51:16

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_automotive_v1`.`field_services` COMMENT '';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_automotive_v1`.`field_services`.`field_technician_dispatch` (
    `field_technician_dispatch_id` BIGINT COMMENT '',
    `vin_registry_id` BIGINT COMMENT '',
    `field_technician_dispatch_status` STRING COMMENT '',
    `created_at` TIMESTAMP COMMENT '',
    CONSTRAINT pk_field_technician_dispatch PRIMARY KEY(`field_technician_dispatch_id`)
) COMMENT '';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`field_services`.`mobile_service_order` (
    `mobile_service_order_id` BIGINT COMMENT '',
    `vin_registry_id` BIGINT COMMENT '',
    `mobile_service_order_status` STRING COMMENT '',
    `created_at` TIMESTAMP COMMENT '',
    CONSTRAINT pk_mobile_service_order PRIMARY KEY(`mobile_service_order_id`)
) COMMENT '';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`field_services`.`roadside_assistance` (
    `roadside_assistance_id` BIGINT COMMENT '',
    `vin_registry_id` BIGINT COMMENT '',
    `roadside_assistance_status` STRING COMMENT '',
    `created_at` TIMESTAMP COMMENT '',
    CONSTRAINT pk_roadside_assistance PRIMARY KEY(`roadside_assistance_id`)
) COMMENT '';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`field_services`.`towing_breakdown_management` (
    `towing_breakdown_management_id` BIGINT COMMENT '',
    `vin_registry_id` BIGINT COMMENT '',
    `towing_breakdown_management_status` STRING COMMENT '',
    `created_at` TIMESTAMP COMMENT '',
    CONSTRAINT pk_towing_breakdown_management PRIMARY KEY(`towing_breakdown_management_id`)
) COMMENT '';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`field_services`.`field_quality_investigation` (
    `field_quality_investigation_id` BIGINT COMMENT '',
    `vin_registry_id` BIGINT COMMENT '',
    `field_quality_investigation_status` STRING COMMENT '',
    `created_at` TIMESTAMP COMMENT '',
    CONSTRAINT pk_field_quality_investigation PRIMARY KEY(`field_quality_investigation_id`)
) COMMENT '';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`field_services`.`field_failure_analysis` (
    `field_failure_analysis_id` BIGINT COMMENT '',
    `vin_registry_id` BIGINT COMMENT '',
    `field_failure_analysis_status` STRING COMMENT '',
    `created_at` TIMESTAMP COMMENT '',
    CONSTRAINT pk_field_failure_analysis PRIMARY KEY(`field_failure_analysis_id`)
) COMMENT '';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`field_services`.`field_engineering_report` (
    `field_engineering_report_id` BIGINT COMMENT '',
    `vin_registry_id` BIGINT COMMENT '',
    `field_engineering_report_status` STRING COMMENT '',
    `created_at` TIMESTAMP COMMENT '',
    CONSTRAINT pk_field_engineering_report PRIMARY KEY(`field_engineering_report_id`)
) COMMENT '';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`field_services`.`telemetry_service_scheduling_workflow` (
    `telemetry_service_scheduling_workflow_id` BIGINT COMMENT '',
    `vin_registry_id` BIGINT COMMENT '',
    `telemetry_service_scheduling_workflow_status` STRING COMMENT '',
    `created_at` TIMESTAMP COMMENT '',
    CONSTRAINT pk_telemetry_service_scheduling_workflow PRIMARY KEY(`telemetry_service_scheduling_workflow_id`)
) COMMENT '';

-- ========= TAGS =========
ALTER SCHEMA `vibe_automotive_v1`.`field_services` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_automotive_v1`.`field_services` SET TAGS ('dbx_domain' = 'field_services');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`field_technician_dispatch` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`field_technician_dispatch` ALTER COLUMN `field_technician_dispatch_id` SET TAGS ('dbx_role' = 'primary_key');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`field_technician_dispatch` ALTER COLUMN `vin_registry_id` SET TAGS ('dbx_role' = 'foreign_key');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`field_technician_dispatch` ALTER COLUMN `field_technician_dispatch_status` SET TAGS ('dbx_role' = 'attribute');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`field_technician_dispatch` ALTER COLUMN `created_at` SET TAGS ('dbx_role' = 'attribute');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`mobile_service_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`mobile_service_order` ALTER COLUMN `mobile_service_order_id` SET TAGS ('dbx_role' = 'primary_key');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`mobile_service_order` ALTER COLUMN `vin_registry_id` SET TAGS ('dbx_role' = 'foreign_key');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`mobile_service_order` ALTER COLUMN `mobile_service_order_status` SET TAGS ('dbx_role' = 'attribute');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`mobile_service_order` ALTER COLUMN `created_at` SET TAGS ('dbx_role' = 'attribute');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`roadside_assistance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`roadside_assistance` ALTER COLUMN `roadside_assistance_id` SET TAGS ('dbx_role' = 'primary_key');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`roadside_assistance` ALTER COLUMN `vin_registry_id` SET TAGS ('dbx_role' = 'foreign_key');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`roadside_assistance` ALTER COLUMN `roadside_assistance_status` SET TAGS ('dbx_role' = 'attribute');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`roadside_assistance` ALTER COLUMN `created_at` SET TAGS ('dbx_role' = 'attribute');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`towing_breakdown_management` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`towing_breakdown_management` ALTER COLUMN `towing_breakdown_management_id` SET TAGS ('dbx_role' = 'primary_key');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`towing_breakdown_management` ALTER COLUMN `vin_registry_id` SET TAGS ('dbx_role' = 'foreign_key');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`towing_breakdown_management` ALTER COLUMN `towing_breakdown_management_status` SET TAGS ('dbx_role' = 'attribute');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`towing_breakdown_management` ALTER COLUMN `created_at` SET TAGS ('dbx_role' = 'attribute');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`field_quality_investigation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`field_quality_investigation` ALTER COLUMN `field_quality_investigation_id` SET TAGS ('dbx_role' = 'primary_key');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`field_quality_investigation` ALTER COLUMN `vin_registry_id` SET TAGS ('dbx_role' = 'foreign_key');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`field_quality_investigation` ALTER COLUMN `field_quality_investigation_status` SET TAGS ('dbx_role' = 'attribute');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`field_quality_investigation` ALTER COLUMN `created_at` SET TAGS ('dbx_role' = 'attribute');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`field_failure_analysis` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`field_failure_analysis` ALTER COLUMN `field_failure_analysis_id` SET TAGS ('dbx_role' = 'primary_key');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`field_failure_analysis` ALTER COLUMN `vin_registry_id` SET TAGS ('dbx_role' = 'foreign_key');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`field_failure_analysis` ALTER COLUMN `field_failure_analysis_status` SET TAGS ('dbx_role' = 'attribute');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`field_failure_analysis` ALTER COLUMN `created_at` SET TAGS ('dbx_role' = 'attribute');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`field_engineering_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`field_engineering_report` ALTER COLUMN `field_engineering_report_id` SET TAGS ('dbx_role' = 'primary_key');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`field_engineering_report` ALTER COLUMN `vin_registry_id` SET TAGS ('dbx_role' = 'foreign_key');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`field_engineering_report` ALTER COLUMN `field_engineering_report_status` SET TAGS ('dbx_role' = 'attribute');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`field_engineering_report` ALTER COLUMN `created_at` SET TAGS ('dbx_role' = 'attribute');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`telemetry_service_scheduling_workflow` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`telemetry_service_scheduling_workflow` ALTER COLUMN `telemetry_service_scheduling_workflow_id` SET TAGS ('dbx_role' = 'primary_key');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`telemetry_service_scheduling_workflow` ALTER COLUMN `vin_registry_id` SET TAGS ('dbx_role' = 'foreign_key');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`telemetry_service_scheduling_workflow` ALTER COLUMN `telemetry_service_scheduling_workflow_status` SET TAGS ('dbx_role' = 'attribute');
ALTER TABLE `vibe_automotive_v1`.`field_services`.`telemetry_service_scheduling_workflow` ALTER COLUMN `created_at` SET TAGS ('dbx_role' = 'attribute');
