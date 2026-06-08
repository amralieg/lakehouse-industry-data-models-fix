-- Schema for Domain: shared | Business: Semiconductors | Version: v1_ecm
-- Generated on: 2026-05-06 18:26:05

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `semiconductors_ecm`.`shared` COMMENT 'Shared domain (auto-created for table site)';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `semiconductors_ecm`.`shared`.`site` (
    `site_id` BIGINT COMMENT 'Primary key for site',
    `location_id` BIGINT COMMENT 'Foreign key linking to shared.location. Business justification: Site belongs to a geographic location; adding site_location_id creates a child→parent FK and eliminates potential duplicate address data.',
    `parent_site_id` BIGINT COMMENT 'Self-referencing FK on site (parent_site_id)',
    `address_line1` STRING COMMENT 'First line of the site’s street address.',
    `address_line2` STRING COMMENT 'Second line of the site’s street address (optional).',
    `capacity_per_day` STRING COMMENT 'Maximum number of units the site can produce per day.',
    `city` STRING COMMENT 'City where the site is located.',
    `closing_date` DATE COMMENT 'Date the site ceased operations, if applicable.',
    `compliance_status` STRING COMMENT 'Current regulatory compliance state of the site.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code where the site resides.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the site record was first created in the data lake.',
    `data_center_flag` BOOLEAN COMMENT 'True if the site hosts data‑center facilities.',
    `site_description` STRING COMMENT 'Free‑form description of the site’s purpose or characteristics.',
    `environmental_certification` STRING COMMENT 'Environmental sustainability certification held by the site.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent scheduled maintenance.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the site in decimal degrees.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the site in decimal degrees.',
    `manager_email` STRING COMMENT 'Email address of the site manager.',
    `manager_name` STRING COMMENT 'Full name of the person responsible for site operations.',
    `manager_phone` STRING COMMENT 'Contact phone number of the site manager.',
    `number_of_employees` STRING COMMENT 'Total number of staff assigned to the site.',
    `opening_date` DATE COMMENT 'Date the site began operations.',
    `operational_since` TIMESTAMP COMMENT 'Exact timestamp when the site became operational.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the site address.',
    `power_capacity_kw` BIGINT COMMENT 'Maximum electrical power capacity of the site in kilowatts.',
    `primary_contact_phone` STRING COMMENT 'General contact phone number for the site.',
    `region` STRING COMMENT 'Broad geographic region grouping for the site.',
    `security_classification` STRING COMMENT 'Data security level assigned to the site.',
    `site_code` STRING COMMENT 'External code used to reference the site in enterprise systems.',
    `site_name` STRING COMMENT 'Human‑readable name of the site.',
    `site_owner` STRING COMMENT 'Organizational unit that owns the site.',
    `site_type` STRING COMMENT 'Category describing the primary function of the site.',
    `square_footage` BIGINT COMMENT 'Total usable floor area of the site in square feet.',
    `state_province` STRING COMMENT 'State or province of the site location.',
    `site_status` STRING COMMENT 'Current operational status of the site.',
    `timezone` STRING COMMENT 'IANA time‑zone identifier for the site (e.g., America/Los_Angeles).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the site record.',
    CONSTRAINT pk_site PRIMARY KEY(`site_id`)
) COMMENT 'Master reference table for site. Referenced by site_id.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`shared`.`location` (
    `location_id` BIGINT COMMENT 'Primary key for location',
    `parent_location_id` BIGINT COMMENT 'Identifier of the parent location in a hierarchical geography (e.g., campus > building).',
    `address_line1` STRING COMMENT 'Primary street address of the location.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, building, etc.).',
    `capacity_per_day` DECIMAL(18,2) COMMENT 'Maximum number of units the facility can produce per day.',
    `city` STRING COMMENT 'City where the location is situated.',
    `closing_date` DATE COMMENT 'Date the location ceased operations (null if still active).',
    `cost_center_code` STRING COMMENT 'Financial cost‑center identifier linked to the location.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code where the location resides.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the location record was first created in the data lake.',
    `location_description` STRING COMMENT 'Free‑form description providing additional context about the location.',
    `email_address` STRING COMMENT 'Primary email address for the location.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude in decimal degrees.',
    `location_code` STRING COMMENT 'External business code used to reference the location in contracts, shipping documents and ERP systems.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude in decimal degrees.',
    `manager_name` STRING COMMENT 'Name of the person responsible for day‑to‑day operations.',
    `location_name` STRING COMMENT 'Human‑readable name of the facility, plant, warehouse or office.',
    `number_of_employees` STRING COMMENT 'Number of staff assigned to the location.',
    `opening_date` DATE COMMENT 'Date the location became operational.',
    `phone_number` STRING COMMENT 'Primary telephone number for the location.',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the locations mailing address.',
    `region` STRING COMMENT 'Broad geographic region (e.g., EMEA, APAC, AMER) for reporting aggregation.',
    `source_system` STRING COMMENT 'Name of the upstream operational system that supplied the record.',
    `source_system_code` STRING COMMENT 'Native identifier of the location in the source system.',
    `square_footage` DECIMAL(18,2) COMMENT 'Total usable floor area of the location in square feet.',
    `state_province` STRING COMMENT 'State or province abbreviation for the location.',
    `location_status` STRING COMMENT 'Current lifecycle status of the location.',
    `timezone` STRING COMMENT 'IANA time‑zone identifier for the location (e.g., America/Los_Angeles).',
    `location_type` STRING COMMENT 'Category of the location indicating its primary function within the semiconductor business.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the location record.',
    `website_url` STRING COMMENT 'Public website URL for the location, if applicable.',
    CONSTRAINT pk_location PRIMARY KEY(`location_id`)
) COMMENT 'Master reference table for location. Referenced by location_id.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`shared`.`fab` (
    `fab_id` BIGINT COMMENT 'Primary key for fab',
    `location_id` BIGINT COMMENT 'Foreign key linking to shared.location. Business justification: Fab is situated at a location; adding fab_location_id creates a child→parent FK and allows removal of address fields now stored in location.',
    `annual_power_mwh` DECIMAL(18,2) COMMENT 'Total electricity consumption per year in megawatt‑hours.',
    `annual_water_m3` DECIMAL(18,2) COMMENT 'Total water usage per year in cubic meters.',
    `audit_score` DECIMAL(18,2) COMMENT 'Score from the latest audit (0‑100).',
    `capacity_units_per_month` STRING COMMENT 'Maximum number of wafers or units the fab can produce per month.',
    `carbon_footprint_tons` DECIMAL(18,2) COMMENT 'Estimated CO₂ emissions per year in metric tons.',
    `cleanroom_count` STRING COMMENT 'Count of ISO‑class cleanroom spaces within the fab.',
    `fab_code` STRING COMMENT 'External code used to reference the fab in enterprise systems.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fab record was first created in the data lake.',
    `emergency_contact_number` STRING COMMENT 'Phone number for emergency response at the fab.',
    `environmental_compliance_status` STRING COMMENT 'Current status of environmental regulatory compliance.',
    `is_critical_facility` BOOLEAN COMMENT 'Indicates whether the fab is designated as a critical manufacturing site.',
    `last_audit_date` DATE COMMENT 'Date of the most recent internal or external audit.',
    `maintenance_window_end_time` TIMESTAMP COMMENT 'Scheduled end time for regular maintenance window.',
    `maintenance_window_start_time` TIMESTAMP COMMENT 'Scheduled start time for regular maintenance window.',
    `manager_email` STRING COMMENT 'Email address of the fab manager.',
    `manager_name` STRING COMMENT 'Name of the person responsible for overall fab management.',
    `manager_phone` STRING COMMENT 'Contact phone number for the fab manager.',
    `fab_name` STRING COMMENT 'Human‑readable name of the fab.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information about the fab.',
    `number_of_equipment_units` STRING COMMENT 'Total number of major manufacturing equipment units.',
    `operating_shift_count` STRING COMMENT 'Number of production shifts run per day.',
    `owner_company` STRING COMMENT 'Legal entity that owns the fab.',
    `primary_product_family` STRING COMMENT 'Main product family manufactured at the fab.',
    `safety_certification` STRING COMMENT 'Safety management certification held by the fab.',
    `security_clearance_level` STRING COMMENT 'Security classification required for personnel accessing the fab.',
    `shutdown_date` DATE COMMENT 'Date when the fab ceased operations (null if still active).',
    `start_date` DATE COMMENT 'Date when the fab began operations.',
    `fab_status` STRING COMMENT 'Current operational status of the fab.',
    `technology_node_nm` STRING COMMENT 'Process technology node supported (e.g., 7nm, 14nm).',
    `total_area_sqft` DECIMAL(18,2) COMMENT 'Total built‑up area of the fab in square feet.',
    `fab_type` STRING COMMENT 'Category of manufacturing performed at the fab.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the fab record.',
    `waste_disposal_method` STRING COMMENT 'Primary method for handling manufacturing waste.',
    CONSTRAINT pk_fab PRIMARY KEY(`fab_id`)
) COMMENT 'Master reference table for fab. Referenced by fab_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `semiconductors_ecm`.`shared`.`site` ADD CONSTRAINT `fk_shared_site_location_id` FOREIGN KEY (`location_id`) REFERENCES `semiconductors_ecm`.`shared`.`location`(`location_id`);
ALTER TABLE `semiconductors_ecm`.`shared`.`site` ADD CONSTRAINT `fk_shared_site_parent_site_id` FOREIGN KEY (`parent_site_id`) REFERENCES `semiconductors_ecm`.`shared`.`site`(`site_id`);
ALTER TABLE `semiconductors_ecm`.`shared`.`location` ADD CONSTRAINT `fk_shared_location_parent_location_id` FOREIGN KEY (`parent_location_id`) REFERENCES `semiconductors_ecm`.`shared`.`location`(`location_id`);
ALTER TABLE `semiconductors_ecm`.`shared`.`fab` ADD CONSTRAINT `fk_shared_fab_location_id` FOREIGN KEY (`location_id`) REFERENCES `semiconductors_ecm`.`shared`.`location`(`location_id`);

-- ========= TAGS =========
ALTER SCHEMA `semiconductors_ecm`.`shared` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `semiconductors_ecm`.`shared` SET TAGS ('dbx_domain' = 'shared');
ALTER TABLE `semiconductors_ecm`.`shared`.`site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`shared`.`site` SET TAGS ('dbx_subdomain' = 'shared_core');
ALTER TABLE `semiconductors_ecm`.`shared`.`site` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier');
ALTER TABLE `semiconductors_ecm`.`shared`.`site` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Site Location Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`shared`.`site` ALTER COLUMN `parent_site_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`site` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`site` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`site` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`site` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`site` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`site` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`site` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`site` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`site` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`site` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`site` ALTER COLUMN `manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`site` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`site` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`site` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`site` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`site` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`site` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`shared`.`location` SET TAGS ('dbx_subdomain' = 'shared_core');
ALTER TABLE `semiconductors_ecm`.`shared`.`location` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `semiconductors_ecm`.`shared`.`location` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`location` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`location` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`location` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`location` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`location` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`location` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`location` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`location` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`location` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`fab` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`shared`.`fab` SET TAGS ('dbx_subdomain' = 'shared_core');
ALTER TABLE `semiconductors_ecm`.`shared`.`fab` ALTER COLUMN `fab_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Identifier');
ALTER TABLE `semiconductors_ecm`.`shared`.`fab` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Location Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`shared`.`fab` ALTER COLUMN `emergency_contact_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`fab` ALTER COLUMN `emergency_contact_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`fab` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`fab` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`fab` ALTER COLUMN `manager_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`fab` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`fab` ALTER COLUMN `manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`shared`.`fab` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
