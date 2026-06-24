-- Schema for Domain: shared | Business:  | Version: v2_ecm
-- Generated on: 2026-06-24 00:02:29

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`shared` COMMENT 'Shared domain (auto-created for table site)';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`shared`.`site` (
    `site_id` BIGINT COMMENT 'Primary key for site',
    `parent_site_id` BIGINT COMMENT 'Self-referencing FK on site (parent_site_id)',
    `location_id` BIGINT COMMENT 'Foreign key linking to shared.location. Business justification: Site belongs to a geographic location; adding site_location_id creates a child→parent FK and eliminates potential duplicate address data.',
    `address_line1` STRING COMMENT 'First line of the site’s street address.',
    `address_line2` STRING COMMENT 'Second line of the site’s street address (optional).',
    `capacity_per_day` STRING COMMENT 'Maximum number of units the site can produce per day.',
    `city` STRING COMMENT 'City where the site is located.',
    `closing_date` DATE COMMENT 'Date the site ceased operations, if applicable.',
    `site_code` STRING COMMENT 'External code used to reference the site in enterprise systems.',
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
    `site_name` STRING COMMENT 'Human‑readable name of the site.',
    `number_of_employees` STRING COMMENT 'Total number of staff assigned to the site.',
    `opening_date` DATE COMMENT 'Date the site began operations.',
    `operational_since` TIMESTAMP COMMENT 'Exact timestamp when the site became operational.',
    `owner` STRING COMMENT 'Organizational unit that owns the site.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the site address.',
    `power_capacity_kw` BIGINT COMMENT 'Maximum electrical power capacity of the site in kilowatts.',
    `primary_contact_phone` STRING COMMENT 'General contact phone number for the site.',
    `region` STRING COMMENT 'Broad geographic region grouping for the site.',
    `security_classification` STRING COMMENT 'Data security level assigned to the site.',
    `site_type` STRING COMMENT 'Category describing the primary function of the site.',
    `square_footage` BIGINT COMMENT 'Total usable floor area of the site in square feet.',
    `state_province` STRING COMMENT 'State or province of the site location.',
    `site_status` STRING COMMENT 'Current operational status of the site.',
    `timezone` STRING COMMENT 'IANA time‑zone identifier for the site (e.g., America/Los_Angeles).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the site record.',
    CONSTRAINT pk_site PRIMARY KEY(`site_id`)
) COMMENT 'Master reference table for site. Referenced by site_id.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`shared`.`location` (
    `location_id` BIGINT COMMENT 'Primary key for location',
    `parent_location_id` BIGINT COMMENT 'Identifier of the parent location in a hierarchical geography (e.g., campus > building).',
    `address_line1` STRING COMMENT 'Primary street address of the location.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, building, etc.).',
    `capacity_per_day` DECIMAL(18,2) COMMENT 'Maximum number of units the facility can produce per day.',
    `city` STRING COMMENT 'City where the location is situated.',
    `closing_date` DATE COMMENT 'Date the location ceased operations (null if still active).',
    `location_code` STRING COMMENT 'External business code used to reference the location in contracts, shipping documents and ERP systems.',
    `cost_center_code` STRING COMMENT 'Financial cost‑center identifier linked to the location.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code where the location resides.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the location record was first created in the data lake.',
    `location_description` STRING COMMENT 'Free‑form description providing additional context about the location.',
    `email_address` STRING COMMENT 'Primary email address for the location.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude in decimal degrees.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude in decimal degrees.',
    `manager_name` STRING COMMENT 'Name of the person responsible for day‑to‑day operations.',
    `location_name` STRING COMMENT 'Human‑readable name of the facility, plant, warehouse or office.',
    `number_of_employees` STRING COMMENT 'Number of staff assigned to the location.',
    `opening_date` DATE COMMENT 'Date the location became operational.',
    `phone_number` STRING COMMENT 'Primary telephone number for the location.',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the locations mailing address.',
    `region` STRING COMMENT 'Broad geographic region (e.g., EMEA, APAC, AMER) for reporting aggregation.',
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

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`shared`.`fab` (
    `fab_id` BIGINT COMMENT 'Primary key for fab',
    `location_id` BIGINT COMMENT 'Foreign key linking to shared.location. Business justification: Fab is situated at a location; adding fab_location_id creates a child→parent FK and allows removal of address fields now stored in location.',
    `site_id` BIGINT COMMENT 'P1: Add column site_id (BIGINT) to shared.fab with FK to shared.site.site_id so shared.fab links to site for physical location hierarchy consistency. P1: connect_table: shared.fab** - add column site_id (BIGINT) with FK to shared.site.site_',
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

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`shared`.`currency` (
    `currency_id` BIGINT COMMENT 'Primary key for currency',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code',
    `country_code` STRING COMMENT 'Primary country code associated with this currency',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the currency record was created',
    `decimal_places` STRING COMMENT 'Number of decimal places used in this currency',
    `effective_date` TIMESTAMP COMMENT 'Date from which this currency record is effective',
    `estimated_budget_amount` DECIMAL(18,2) COMMENT 'Automatically added monetary attribute for normalization.',
    `exchange_rate_date` DATE COMMENT 'Date when the exchange rate was last updated',
    `exchange_rate_to_usd` DECIMAL(18,2) COMMENT 'Current exchange rate relative to US Dollar',
    `expiration_date` TIMESTAMP COMMENT 'Date after which this currency record is no longer valid',
    `is_active` BOOLEAN COMMENT 'Whether the currency is currently active for use',
    `currency_name` STRING COMMENT 'Full name of the currency',
    `numeric_code` STRING COMMENT 'ISO 4217 numeric currency code',
    `symbol` STRING COMMENT 'Display symbol for the currency',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the currency record was last updated',
    CONSTRAINT pk_currency PRIMARY KEY(`currency_id`)
) COMMENT 'Reference entity for ISO currency codes used across financial and commercial domains';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`shared`.`unit_of_measure` (
    `unit_of_measure_id` BIGINT COMMENT 'Primary key for the unit of measure record.',
    `base_uom_code` STRING COMMENT 'The base unit for conversion within the same category.',
    `conversion_factor_to_base` DECIMAL(18,2) COMMENT 'Multiplication factor to convert this UOM to the base UOM.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was created.',
    `unit_of_measure_description` STRING COMMENT 'Detailed description of the unit of measure.',
    `is_active` BOOLEAN COMMENT 'Whether the unit of measure is currently active.',
    `iso_standard` STRING COMMENT 'ISO standard reference for this unit if applicable.',
    `uom_category` STRING COMMENT 'Category grouping (e.g., length, weight, quantity, volume, time).',
    `uom_code` STRING COMMENT 'Short code for the unit of measure (e.g., EA, KG, MM).',
    `uom_name` STRING COMMENT 'Full name of the unit of measure.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was last updated.',
    CONSTRAINT pk_unit_of_measure PRIMARY KEY(`unit_of_measure_id`)
) COMMENT 'Reference entity for standard units of measure (length, weight, volume, etc.) used across supply, inventory, and process domains';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`shared`.`calendar` (
    `calendar_id` BIGINT COMMENT 'Primary key for calendar',
    `site_id` BIGINT COMMENT 'Foreign key to the site this calendar applies to',
    `calendar_type` STRING COMMENT 'Type of calendar such as production, corporate, holiday',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the calendar record was created',
    `effective_date` TIMESTAMP COMMENT 'Date from which this calendar is effective',
    `end_date` TIMESTAMP COMMENT 'Date after which this calendar is no longer valid',
    `is_active` BOOLEAN COMMENT 'Whether this calendar is currently active',
    `calendar_name` STRING COMMENT 'Name of the business calendar',
    `timezone` STRING COMMENT 'Timezone applicable to this calendar',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the calendar record was last updated',
    `working_days_per_week` STRING COMMENT 'Number of standard working days per week',
    `year` STRING COMMENT 'Calendar year this record applies to',
    CONSTRAINT pk_calendar PRIMARY KEY(`calendar_id`)
) COMMENT 'Shared business calendar defining working days, holidays, and shifts across all sites and domains';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ADD CONSTRAINT `fk_shared_site_parent_site_id` FOREIGN KEY (`parent_site_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`site`(`site_id`);
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ADD CONSTRAINT `fk_shared_site_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`location`(`location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ADD CONSTRAINT `fk_shared_location_parent_location_id` FOREIGN KEY (`parent_location_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`location`(`location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ADD CONSTRAINT `fk_shared_fab_location_id` FOREIGN KEY (`location_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`location`(`location_id`);
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ADD CONSTRAINT `fk_shared_fab_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`site`(`site_id`);
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`calendar` ADD CONSTRAINT `fk_shared_calendar_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_semiconductors_v1`.`shared`.`site`(`site_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`shared` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_semiconductors_v1`.`shared` SET TAGS ('dbx_domain' = 'shared');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` SET TAGS ('dbx_subdomain' = 'physical_infrastructure');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` SET TAGS ('dbx_domain' = 'shared');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `parent_site_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Site Id');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `parent_site_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Site Location Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `address_line2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `capacity_per_day` SET TAGS ('dbx_business_glossary_term' = 'Capacity Per Day');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Closing Date');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `site_code` SET TAGS ('dbx_business_glossary_term' = 'Site Code');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `data_center_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Center Flag');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `site_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `environmental_certification` SET TAGS ('dbx_business_glossary_term' = 'Environmental Certification');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `manager_email` SET TAGS ('dbx_business_glossary_term' = 'Manager Email');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `manager_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Manager Name');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `manager_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `manager_phone` SET TAGS ('dbx_business_glossary_term' = 'Manager Phone');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `manager_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Site Name');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `number_of_employees` SET TAGS ('dbx_business_glossary_term' = 'Number Of Employees');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Opening Date');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `operational_since` SET TAGS ('dbx_business_glossary_term' = 'Operational Since');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Site Owner');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `owner` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `power_capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'Power Capacity Kw');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `security_classification` SET TAGS ('dbx_business_glossary_term' = 'Security Classification');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `site_type` SET TAGS ('dbx_business_glossary_term' = 'Site Type');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `site_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Timezone');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`site` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` SET TAGS ('dbx_subdomain' = 'physical_infrastructure');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` SET TAGS ('dbx_domain' = 'shared');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` SET TAGS ('dbx_entity_type' = 'master');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `parent_location_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Location Id');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `address_line2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `capacity_per_day` SET TAGS ('dbx_business_glossary_term' = 'Capacity Per Day');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Closing Date');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `email_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Manager Name');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `manager_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `number_of_employees` SET TAGS ('dbx_business_glossary_term' = 'Number Of Employees');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Opening Date');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `phone_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `location_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Timezone');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`location` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Url');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` SET TAGS ('dbx_subdomain' = 'physical_infrastructure');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` SET TAGS ('dbx_domain' = 'shared');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` SET TAGS ('dbx_entity_type' = 'master');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `fab_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Location Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `annual_power_mwh` SET TAGS ('dbx_business_glossary_term' = 'Annual Power Mwh');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `annual_water_m3` SET TAGS ('dbx_business_glossary_term' = 'Annual Water M3');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `capacity_units_per_month` SET TAGS ('dbx_business_glossary_term' = 'Capacity Units Per Month');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `carbon_footprint_tons` SET TAGS ('dbx_business_glossary_term' = 'Carbon Footprint Tons');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `cleanroom_count` SET TAGS ('dbx_business_glossary_term' = 'Cleanroom Count');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `fab_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `emergency_contact_number` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Number');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `emergency_contact_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `emergency_contact_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `environmental_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `is_critical_facility` SET TAGS ('dbx_business_glossary_term' = 'Is Critical Facility');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `maintenance_window_end_time` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window End Time');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `maintenance_window_start_time` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window Start Time');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `manager_email` SET TAGS ('dbx_business_glossary_term' = 'Manager Email');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `manager_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Manager Name');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `manager_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `manager_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `manager_phone` SET TAGS ('dbx_business_glossary_term' = 'Manager Phone');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `manager_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `fab_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `number_of_equipment_units` SET TAGS ('dbx_business_glossary_term' = 'Number Of Equipment Units');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `operating_shift_count` SET TAGS ('dbx_business_glossary_term' = 'Operating Shift Count');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `owner_company` SET TAGS ('dbx_business_glossary_term' = 'Owner Company');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `primary_product_family` SET TAGS ('dbx_business_glossary_term' = 'Primary Product Family');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `safety_certification` SET TAGS ('dbx_business_glossary_term' = 'Safety Certification');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Level');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `shutdown_date` SET TAGS ('dbx_business_glossary_term' = 'Shutdown Date');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `fab_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `technology_node_nm` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Nm');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `total_area_sqft` SET TAGS ('dbx_business_glossary_term' = 'Total Area Sqft');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `fab_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`fab` ALTER COLUMN `waste_disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Waste Disposal Method');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`currency` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`currency` SET TAGS ('dbx_subdomain' = 'reference_data');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`currency` SET TAGS ('dbx_domain' = 'shared');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`currency` SET TAGS ('dbx_entity_type' = 'reference');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`currency` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency ID');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`currency` ALTER COLUMN `currency_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`currency` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`currency` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`currency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`currency` ALTER COLUMN `decimal_places` SET TAGS ('dbx_business_glossary_term' = 'Decimal Places');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`currency` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`currency` ALTER COLUMN `exchange_rate_date` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Date');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`currency` ALTER COLUMN `exchange_rate_to_usd` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate to USD');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`currency` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`currency` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`currency` ALTER COLUMN `currency_name` SET TAGS ('dbx_business_glossary_term' = 'Currency Name');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`currency` ALTER COLUMN `numeric_code` SET TAGS ('dbx_business_glossary_term' = 'Numeric Code');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`currency` ALTER COLUMN `symbol` SET TAGS ('dbx_business_glossary_term' = 'Currency Symbol');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`currency` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`unit_of_measure` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`unit_of_measure` SET TAGS ('dbx_subdomain' = 'reference_data');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`unit_of_measure` SET TAGS ('dbx_domain' = 'shared');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`unit_of_measure` SET TAGS ('dbx_entity_type' = 'reference');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`unit_of_measure` ALTER COLUMN `unit_of_measure_id` SET TAGS ('dbx_business_glossary_term' = 'UOM Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`unit_of_measure` ALTER COLUMN `base_uom_code` SET TAGS ('dbx_business_glossary_term' = 'Base UOM Code');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`unit_of_measure` ALTER COLUMN `conversion_factor_to_base` SET TAGS ('dbx_business_glossary_term' = 'Conversion Factor');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`unit_of_measure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`unit_of_measure` ALTER COLUMN `unit_of_measure_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`unit_of_measure` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`unit_of_measure` ALTER COLUMN `iso_standard` SET TAGS ('dbx_business_glossary_term' = 'ISO Standard');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`unit_of_measure` ALTER COLUMN `uom_category` SET TAGS ('dbx_business_glossary_term' = 'UOM Category');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`unit_of_measure` ALTER COLUMN `uom_code` SET TAGS ('dbx_business_glossary_term' = 'UOM Code');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`unit_of_measure` ALTER COLUMN `uom_name` SET TAGS ('dbx_business_glossary_term' = 'UOM Name');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`unit_of_measure` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`calendar` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`calendar` SET TAGS ('dbx_subdomain' = 'reference_data');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`calendar` SET TAGS ('dbx_domain' = 'shared');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`calendar` SET TAGS ('dbx_layer' = 'reference');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`calendar` ALTER COLUMN `calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Calendar ID');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`calendar` ALTER COLUMN `calendar_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`calendar` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`calendar` ALTER COLUMN `calendar_type` SET TAGS ('dbx_business_glossary_term' = 'Calendar Type');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`calendar` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`calendar` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`calendar` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`calendar` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`calendar` ALTER COLUMN `calendar_name` SET TAGS ('dbx_business_glossary_term' = 'Calendar Name');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`calendar` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Timezone');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`calendar` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`calendar` ALTER COLUMN `working_days_per_week` SET TAGS ('dbx_business_glossary_term' = 'Working Days Per Week');
ALTER TABLE `vibe_semiconductors_v1`.`shared`.`calendar` ALTER COLUMN `year` SET TAGS ('dbx_business_glossary_term' = 'Year');
