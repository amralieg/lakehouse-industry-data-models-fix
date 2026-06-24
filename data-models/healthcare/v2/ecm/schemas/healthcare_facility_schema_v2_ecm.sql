-- Schema for Domain: facility | Business:  | Version: v2_ecm
-- Generated on: 2026-06-23 13:03:44

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`facility` COMMENT 'Healthcare facility and physical infrastructure management. Owns hospitals, clinics, outpatient centers, care sites, bed management, room/unit configuration, OR/ICU/ED space, equipment assets, biomedical engineering, preventive maintenance, environmental services, facility licensing, and accreditation status. Supports multi-site integrated delivery networks. Integrates with SAP PM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`care_site` (
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site record.',
    `parent_care_site_id` BIGINT COMMENT 'Self-referential FK to parent care site for hierarchical organization.',
    `npi_registry_id` BIGINT COMMENT 'FK to the NPI registry for the facility NPI lookup.',
    `organization_id` BIGINT COMMENT 'FK to facility.organization establishing the legal entity owning this care site.',
    `accreditation_body` STRING COMMENT 'Organization that granted accreditation (e.g., Joint Commission, DNV).',
    `accreditation_expiration_date` DECIMAL(18,2) COMMENT 'Date when current accreditation expires.',
    `accreditation_status` STRING COMMENT 'Current accreditation status (e.g., Accredited, Provisional, Denied).',
    `address_line_1` STRING COMMENT 'Primary street address of the care site.',
    `address_line_2` STRING COMMENT 'Secondary address information (suite, floor, etc.).',
    `ccn` STRING COMMENT 'CMS Certification Number for Medicare/Medicaid participation.',
    `city` STRING COMMENT 'City where the care site is located.',
    `closure_date` DATE COMMENT 'Date the care site was permanently closed.',
    `country_code` STRING COMMENT 'ISO country code for the care site location.',
    `county` STRING COMMENT 'County where the care site is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was created.',
    `critical_access_hospital` BOOLEAN COMMENT 'Indicates if the facility is designated as a Critical Access Hospital.',
    `disproportionate_share_hospital` BOOLEAN COMMENT 'Indicates if the facility qualifies as a Disproportionate Share Hospital.',
    `email_address` STRING COMMENT 'Primary email contact for the care site.',
    `emergency_services_available` BOOLEAN COMMENT 'Indicates if emergency department services are available.',
    `facility_type` STRING COMMENT 'Classification of the facility (e.g., Hospital, Clinic, SNF).',
    `fax_number` STRING COMMENT 'Fax number for the care site.',
    `go_live_date` DATE COMMENT 'Date the care site went live in the EHR system.',
    `hierarchy_effective_date` DATE COMMENT 'Date the current hierarchy assignment became effective.',
    `hierarchy_level` STRING COMMENT 'Level in the organizational hierarchy (e.g., System, Region, Facility).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this record.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the care site.',
    `license_effective_date` DATE COMMENT 'Date the facility license became effective.',
    `license_expiration_date` DECIMAL(18,2) COMMENT 'Date the facility license expires.',
    `license_number` STRING COMMENT 'State-issued facility license number.',
    `licensed_bed_capacity` STRING COMMENT 'Total number of beds the facility is licensed to operate.',
    `licensure_status` STRING COMMENT 'Current licensure status (Active, Expired, Suspended).',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the care site.',
    `medicaid_provider_number` STRING COMMENT 'State Medicaid provider identification number.',
    `medicare_provider_number` STRING COMMENT 'CMS Medicare provider identification number.',
    `operational_status` DECIMAL(18,2) COMMENT 'Current operational status (Open, Closed, Under Construction).',
    `ownership_type` STRING COMMENT 'Type of ownership (Non-Profit, For-Profit, Government).',
    `phone_number` STRING COMMENT 'Primary phone number for the care site.',
    `postal_code` STRING COMMENT 'ZIP or postal code of the care site.',
    `site_name` STRING COMMENT 'Official name of the care site.',
    `site_npi` STRING COMMENT 'National Provider Identifier for the facility.',
    `sole_community_hospital` BOOLEAN COMMENT 'Indicates if the facility is designated as a Sole Community Hospital.',
    `staffed_bed_capacity` STRING COMMENT 'Number of beds currently staffed and available for patient use.',
    `state` STRING COMMENT 'State or province where the care site is located.',
    `teaching_status` BOOLEAN COMMENT 'Indicates if the facility is a teaching hospital.',
    `time_zone` STRING COMMENT 'Time zone of the care site location.',
    `trauma_level` STRING COMMENT 'Trauma center designation level (I, II, III, IV, V).',
    `vibe_canonical_facility_marker` BOOLEAN COMMENT 'Marker confirming this facility product is part of the canonical 26-product set.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    `vibe_placeholder` STRING COMMENT 'Added by VIBE mutator to ensure target entity is touched.',
    `website_url` STRING COMMENT 'Public website URL for the care site.',
    CONSTRAINT pk_care_site PRIMARY KEY(`care_site_id`)
) COMMENT 'Represents a physical or logical healthcare delivery location such as a hospital, clinic, or ambulatory surgery center. Serves as the anchor entity for the facility hierarchy.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`building` (
    `building_id` BIGINT COMMENT 'Unique identifier for the building record.',
    `care_site_id` BIGINT COMMENT 'FK to the care site this building belongs to.',
    `geographic_region_id` BIGINT COMMENT 'FK to geographic region for property tax parcel.',
    `ada_compliant` BOOLEAN COMMENT 'Indicates if the building meets ADA accessibility requirements.',
    `address_line_1` STRING COMMENT 'Primary street address of the building.',
    `address_line_2` STRING COMMENT 'Secondary address information.',
    `annual_property_tax_amount` DECIMAL(18,2) COMMENT 'Annual property tax amount for the building.',
    `building_type` STRING COMMENT 'Classification of the building (e.g., Main Hospital, MOB, Parking).',
    `city` STRING COMMENT 'City where the building is located.',
    `cms_certification_number` STRING COMMENT 'CMS certification number if applicable.',
    `building_code` STRING COMMENT 'Internal code identifying the building.',
    `construction_year` STRING COMMENT 'Year the building was originally constructed.',
    `country_code` STRING COMMENT 'ISO country code.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was created.',
    `effective_date` DATE COMMENT 'Date the building record became effective.',
    `electrical_service_capacity_kva` DECIMAL(18,2) COMMENT 'Electrical service capacity in kilovolt-amperes.',
    `emergency_generator_capacity_kw` DECIMAL(18,2) COMMENT 'Emergency generator capacity in kilowatts.',
    `emergency_generator_coverage_type` STRING COMMENT 'Type of emergency generator coverage (Full, Partial, Critical Only).',
    `facility_license_expiration_date` DECIMAL(18,2) COMMENT 'Date the facility license for this building expires.',
    `facility_license_number` STRING COMMENT 'Facility license number for this building.',
    `fire_safety_classification` STRING COMMENT 'Fire safety classification per NFPA codes.',
    `gross_square_footage` DECIMAL(18,2) COMMENT 'Total gross square footage of the building.',
    `helipad_available` BOOLEAN COMMENT 'Indicates if a helipad is available at this building.',
    `hvac_system_type` STRING COMMENT 'Type of HVAC system installed.',
    `insurance_policy_number` STRING COMMENT 'Property insurance policy number.',
    `joint_commission_accreditation_expiration_date` DECIMAL(18,2) COMMENT 'Joint Commission accreditation expiration date.',
    `joint_commission_accreditation_status` STRING COMMENT 'Joint Commission accreditation status.',
    `last_major_renovation_year` STRING COMMENT 'Year of the last major renovation.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the building.',
    `leed_certification_level` STRING COMMENT 'LEED green building certification level.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the building.',
    `medical_gas_system_installed` BOOLEAN COMMENT 'Indicates if medical gas piping system is installed.',
    `building_name` STRING COMMENT 'Name of the building.',
    `net_usable_square_footage` DECIMAL(18,2) COMMENT 'Net usable square footage excluding common areas.',
    `number_of_elevators` STRING COMMENT 'Total number of elevators in the building.',
    `number_of_floors` STRING COMMENT 'Total number of floors in the building.',
    `operational_status` DECIMAL(18,2) COMMENT 'Current operational status of the building.',
    `ownership_type` STRING COMMENT 'Ownership type (Owned, Leased, Shared).',
    `parking_spaces_count` STRING COMMENT 'Number of parking spaces associated with the building.',
    `postal_code` STRING COMMENT 'ZIP or postal code.',
    `property_tax_parcel_number` STRING COMMENT 'Property tax parcel identification number.',
    `replacement_value_amount` DECIMAL(18,2) COMMENT 'Estimated replacement value of the building.',
    `seismic_zone` STRING COMMENT 'Seismic zone classification for the building location.',
    `sprinkler_system_type` STRING COMMENT 'Type of fire sprinkler system installed.',
    `state_province` STRING COMMENT 'State or province where the building is located.',
    `termination_date` DATE COMMENT 'Date the building was decommissioned or terminated.',
    `vibe_canonical_facility_marker` BOOLEAN COMMENT 'Marker confirming this facility product is part of the canonical 26-product set.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    `vibe_placeholder` STRING COMMENT 'Added by VIBE mutator to ensure target entity is touched.',
    CONSTRAINT pk_building PRIMARY KEY(`building_id`)
) COMMENT 'Represents a physical building structure within a care site, tracking construction details, compliance certifications, and infrastructure capabilities.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`unit` (
    `unit_id` BIGINT COMMENT 'Unique identifier for the unit.',
    `building_id` BIGINT COMMENT 'Building Id for unit.',
    `care_site_id` BIGINT COMMENT 'FK to the care site this unit belongs to.',
    `cost_center_id` BIGINT COMMENT 'FK to the finance cost center for this unit.',
    `accepts_admissions` BOOLEAN COMMENT 'Indicates if the unit currently accepts new admissions.',
    `accepts_transfers` BOOLEAN COMMENT 'Indicates if the unit currently accepts transfers.',
    `acuity_level` STRING COMMENT 'Patient acuity level supported by this unit.',
    `age_restriction` STRING COMMENT 'Age restrictions for patients on this unit.',
    `air_changes_per_hour` STRING COMMENT 'Number of air changes per hour for infection control.',
    `bed_count` STRING COMMENT 'Bed Count for unit.',
    `chest_pain_center_accreditation` BOOLEAN COMMENT 'Indicates chest pain center accreditation status.',
    `unit_code` STRING COMMENT 'Internal code for the unit.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was created.',
    `department_code` STRING COMMENT 'Department code for the unit.',
    `effective_date` DATE COMMENT 'Date the unit configuration became effective.',
    `electronic_health_record_system` STRING COMMENT 'EHR system used on this unit.',
    `emergency_power_backup` BOOLEAN COMMENT 'Indicates if emergency power backup is available.',
    `expiration_date` DECIMAL(18,2) COMMENT 'Date the unit configuration expires.',
    `floor_number` STRING COMMENT 'Floor number where the unit is located.',
    `gender_restriction` STRING COMMENT 'Gender restrictions for patients on this unit.',
    `hvac_system_type` STRING COMMENT 'Type of HVAC system on this unit.',
    `infection_control_zone` STRING COMMENT 'Infection control zone designation.',
    `is_active` BOOLEAN COMMENT 'Is Active for unit.',
    `is_twenty_four_seven` BOOLEAN COMMENT 'Indicates if the unit operates 24/7.',
    `isolation_room_count` STRING COMMENT 'Number of isolation rooms on this unit.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification.',
    `licensed_bed_count` STRING COMMENT 'Number of licensed beds on this unit.',
    `magnet_recognition` BOOLEAN COMMENT 'Indicates if the unit has Magnet nursing recognition.',
    `medical_gas_system` STRING COMMENT 'Type of medical gas system available.',
    `unit_name` STRING COMMENT 'Name of the unit.',
    `negative_pressure_room_count` STRING COMMENT 'Number of negative pressure rooms.',
    `nurse_call_system_type` STRING COMMENT 'Type of nurse call system installed.',
    `nurse_to_patient_ratio` DECIMAL(18,2) COMMENT 'Target nurse-to-patient staffing ratio.',
    `operational_hours_end` DECIMAL(18,2) COMMENT 'End time of operational hours if not 24/7.',
    `operational_hours_start` DECIMAL(18,2) COMMENT 'Start time of operational hours if not 24/7.',
    `revenue_center_code` STRING COMMENT 'Revenue center code for billing purposes.',
    `specialty_service_line` STRING COMMENT 'Clinical specialty or service line of the unit.',
    `square_footage` DECIMAL(18,2) COMMENT 'Total square footage of the unit.',
    `staffed_bed_count` STRING COMMENT 'Number of beds currently staffed.',
    `stroke_center_designation` STRING COMMENT 'Stroke center designation level.',
    `teaching_unit_flag` BOOLEAN COMMENT 'Indicates if this is a teaching unit.',
    `telemetry_monitoring_capability` BOOLEAN COMMENT 'Indicates if telemetry monitoring is available.',
    `trauma_level` STRING COMMENT 'Trauma level designation for this unit.',
    `unit_status` STRING COMMENT 'Current operational status of the unit.',
    `unit_type` STRING COMMENT 'Type classification of the unit (ICU, Med/Surg, etc.).',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp for unit.',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure change',
    `vibe_canonical_facility_marker` BOOLEAN COMMENT 'Marker confirming this facility product is part of the canonical 26-product set.',
    `vibe_canonical_products_marker` BOOLEAN COMMENT 'Marker confirming canonical product list pass applied.',
    `vibe_placeholder` STRING COMMENT 'Added by VIBE mutator to ensure target entity is touched.',
    `wing_or_section` STRING COMMENT 'Wing or section within the building.',
    CONSTRAINT pk_unit PRIMARY KEY(`unit_id`)
) COMMENT 'Represents a clinical or administrative unit within a facility, such as a nursing unit, ICU, or department, with staffing and capacity details.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`room` (
    `room_id` BIGINT COMMENT 'Unique identifier for the room.',
    `building_id` BIGINT COMMENT 'Building Id for room.',
    `care_site_id` BIGINT COMMENT 'FK to the care site.',
    `cost_center_id` BIGINT COMMENT 'FK to the finance cost center.',
    `unit_id` BIGINT COMMENT 'FK to the unit this room belongs to.',
    `org_unit_id` BIGINT COMMENT 'FK to the workforce organizational unit.',
    `accreditation_status` STRING COMMENT 'Room accreditation status.',
    `active_flag` BOOLEAN COMMENT 'Indicates if the room is currently active.',
    `ada_compliant_flag` BOOLEAN COMMENT 'Indicates ADA compliance.',
    `bariatric_capable_flag` BOOLEAN COMMENT 'Indicates bariatric patient capability.',
    `bed_count` STRING COMMENT 'Number of beds in the room.',
    `boom_configuration` DECIMAL(18,2) COMMENT 'Equipment boom configuration.',
    `capacity` STRING COMMENT 'Capacity for room.',
    `class` STRING COMMENT 'Classification of the room.',
    `room_code` STRING COMMENT 'Room Code for room.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `effective_from_date` DATE COMMENT 'Date the room configuration became effective.',
    `effective_to_date` DATE COMMENT 'Date the room configuration expires.',
    `emergency_power_flag` BOOLEAN COMMENT 'Indicates emergency power availability.',
    `hand_hygiene_station_count` STRING COMMENT 'Number of hand hygiene stations.',
    `hvac_air_exchange_rate` DECIMAL(18,2) COMMENT 'Air exchange rate per hour.',
    `imaging_integration_flag` BOOLEAN COMMENT 'Indicates imaging system integration.',
    `is_active` BOOLEAN COMMENT 'Is Active for room.',
    `isolation_capable_flag` BOOLEAN COMMENT 'Indicates isolation capability.',
    `last_deep_clean_date` DATE COMMENT 'Date of last deep cleaning.',
    `last_inspection_date` DATE COMMENT 'Date of last inspection.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp.',
    `lease_ownership_indicator` BOOLEAN COMMENT 'Indicates if space is leased or owned.',
    `license_number` STRING COMMENT 'Room license number if applicable.',
    `medical_air_outlet_count` STRING COMMENT 'Number of medical air outlets.',
    `monthly_space_cost` DECIMAL(18,2) COMMENT 'Monthly cost allocated to this room.',
    `room_name` STRING COMMENT 'Name of the room.',
    `negative_pressure_flag` BOOLEAN COMMENT 'Indicates negative pressure capability.',
    `next_scheduled_maintenance_date` DATE COMMENT 'Next scheduled maintenance date.',
    `nitrous_oxide_outlet_count` STRING COMMENT 'Number of nitrous oxide outlets.',
    `nurse_call_system_flag` BOOLEAN COMMENT 'Indicates nurse call system availability.',
    `occupancy_percentage` DECIMAL(18,2) COMMENT 'Current occupancy percentage.',
    `or_airflow_class` STRING COMMENT 'Operating room airflow classification.',
    `oxygen_outlet_count` STRING COMMENT 'Number of oxygen outlets.',
    `room_number` STRING COMMENT 'Room number identifier.',
    `room_status` STRING COMMENT 'Current status of the room.',
    `room_type` STRING COMMENT 'Type of room (Patient, Procedure, Storage, etc.).',
    `square_footage` DECIMAL(18,2) COMMENT 'Total square footage of the room.',
    `telemetry_capable_flag` BOOLEAN COMMENT 'Indicates telemetry monitoring capability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp for room.',
    `vacuum_outlet_count` STRING COMMENT 'Number of vacuum outlets.',
    `ventilator_outlet_count` STRING COMMENT 'Number of ventilator outlets.',
    `vibe_canonical_facility_marker` BOOLEAN COMMENT 'Marker confirming this facility product is part of the canonical 26-product set.',
    `vibe_placeholder` STRING COMMENT 'Added by VIBE mutator to ensure target entity is touched.',
    CONSTRAINT pk_room PRIMARY KEY(`room_id`)
) COMMENT 'Represents a physical room within a unit, tracking room capabilities, infrastructure, and compliance status.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`bed` (
    `bed_id` BIGINT COMMENT 'Unique identifier for the bed.',
    `building_id` BIGINT COMMENT 'FK to the building.',
    `care_site_id` BIGINT COMMENT 'FK to the care site.',
    `mpi_record_id` BIGINT COMMENT 'FK to the currently assigned patient.',
    `room_id` BIGINT COMMENT 'FK to the room containing this bed.',
    `unit_id` BIGINT COMMENT 'FK to the unit.',
    `visit_id` BIGINT COMMENT 'FK to the current patient visit.',
    `age_restriction` STRING COMMENT 'Age restrictions for this bed.',
    `asset_tag` STRING COMMENT 'Physical asset tag number.',
    `assignment_timestamp` TIMESTAMP COMMENT 'When the current patient was assigned.',
    `bed_status` STRING COMMENT 'Current status (Available, Occupied, Blocked, etc.).',
    `bed_type` STRING COMMENT 'Type of bed (Standard, ICU, Bariatric, etc.).',
    `blocked_reason` STRING COMMENT 'Reason the bed is blocked if applicable.',
    `bed_category` STRING COMMENT 'Category of the bed.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `discharge_ready_timestamp` TIMESTAMP COMMENT 'When the bed was marked discharge-ready.',
    `effective_end_date` DATE COMMENT 'End date of bed configuration.',
    `effective_start_date` DATE COMMENT 'Start date of bed configuration.',
    `expected_available_timestamp` TIMESTAMP COMMENT 'Expected availability timestamp.',
    `floor_number` STRING COMMENT 'Floor number where the bed is located.',
    `gender_restriction` STRING COMMENT 'Gender restrictions for this bed.',
    `is_active` BOOLEAN COMMENT 'Indicates if the bed is active.',
    `is_air_fluidized` BOOLEAN COMMENT 'Indicates air fluidized bed capability.',
    `is_bariatric_capable` BOOLEAN COMMENT 'Indicates bariatric patient capability.',
    `is_isolation_capable` BOOLEAN COMMENT 'Indicates isolation capability.',
    `is_licensed` BOOLEAN COMMENT 'Indicates if the bed is licensed.',
    `is_low_bed` BOOLEAN COMMENT 'Indicates if this is a low-height bed for fall prevention.',
    `is_negative_pressure_room` BOOLEAN COMMENT 'Indicates if in a negative pressure room.',
    `is_private_room` BOOLEAN COMMENT 'Indicates if in a private room.',
    `is_staffed` BOOLEAN COMMENT 'Indicates if the bed is currently staffed.',
    `is_telemetry_capable` BOOLEAN COMMENT 'Indicates telemetry monitoring capability.',
    `label` STRING COMMENT 'Display label for the bed (e.g., 4A-101-A).',
    `last_cleaned_timestamp` TIMESTAMP COMMENT 'Timestamp of last cleaning.',
    `last_maintenance_date` DATE COMMENT 'Date of last maintenance.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `next_maintenance_due_date` DATE COMMENT 'Next scheduled maintenance date.',
    `out_of_service_reason` STRING COMMENT 'Reason the bed is out of service.',
    `position` STRING COMMENT 'Position within the room (Window, Door, etc.).',
    `status_timestamp` TIMESTAMP COMMENT 'When the current status was set.',
    `vibe_added_flag` BOOLEAN COMMENT '',
    `vibe_canonical_facility_marker` BOOLEAN COMMENT 'Marker confirming this facility product is part of the canonical 26-product set.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    `vibe_placeholder` STRING COMMENT 'Added by VIBE mutator to ensure target entity is touched.',
    `weight_capacity_lbs` DECIMAL(18,2) COMMENT 'Maximum weight capacity in pounds.',
    CONSTRAINT pk_bed PRIMARY KEY(`bed_id`)
) COMMENT 'Represents an individual bed within a room, tracking bed type, capabilities, current assignment, and maintenance status.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` (
    `bed_status_event_id` BIGINT COMMENT 'Unique identifier for the bed status event.',
    `bed_id` BIGINT COMMENT 'FK to the bed.',
    `care_site_id` BIGINT COMMENT 'FK to the care site.',
    `employee_id` BIGINT COMMENT 'FK to the employee who triggered the event.',
    `environmental_service_request_id` BIGINT COMMENT 'FK to the associated EVS request.',
    `maintenance_order_id` BIGINT COMMENT 'FK to associated maintenance order.',
    `mpi_record_id` BIGINT COMMENT 'FK to the patient involved.',
    `unit_id` BIGINT COMMENT 'FK to the unit.',
    `room_id` BIGINT COMMENT 'FK to the room.',
    `visit_id` BIGINT COMMENT 'FK to the patient visit.',
    `actual_availability_timestamp` TIMESTAMP COMMENT 'Actual timestamp when bed became available.',
    `acuity_level` STRING COMMENT 'Patient acuity level at time of event.',
    `adt_event_type` STRING COMMENT 'Type of ADT event triggering the status change.',
    `bed_assignment_method` STRING COMMENT 'Method used for bed assignment.',
    `blocked_reason_category` STRING COMMENT 'Category of blocking reason.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `duration_minutes` DECIMAL(18,2) COMMENT 'Duration of the status in minutes.',
    `event_sequence_number` STRING COMMENT 'Sequence number for ordering events.',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp when the event occurred.',
    `expected_availability_timestamp` TIMESTAMP COMMENT 'Expected availability timestamp.',
    `initiating_user_role` STRING COMMENT 'Role of the user who initiated the event.',
    `is_elective_flag` BOOLEAN COMMENT 'Indicates if related to an elective admission.',
    `is_emergency_flag` BOOLEAN COMMENT 'Indicates if related to an emergency admission.',
    `isolation_type` STRING COMMENT 'Type of isolation if applicable.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp.',
    `new_status_code` STRING COMMENT 'New bed status after the event.',
    `notes` STRING COMMENT 'Free-text notes about the event.',
    `prior_status_code` STRING COMMENT 'Bed status before the event.',
    `priority_flag` BOOLEAN COMMENT 'Indicates if this is a priority event.',
    `reason_code` STRING COMMENT 'Coded reason for the status change.',
    `reason_description` STRING COMMENT 'Description of the reason for status change.',
    `source_system_code` STRING COMMENT 'Source system code.',
    `source_system_event_code` STRING COMMENT 'Event code from the source system.',
    `vibe_canonical_facility_marker` BOOLEAN COMMENT 'Marker confirming this facility product is part of the canonical 26-product set.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    `vibe_placeholder` STRING COMMENT 'Added by VIBE mutator to ensure target entity is touched.',
    CONSTRAINT pk_bed_status_event PRIMARY KEY(`bed_status_event_id`)
) COMMENT 'Tracks status changes for beds over time, supporting bed management, turnaround time analysis, and capacity planning.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`or_suite` (
    `or_suite_id` BIGINT COMMENT 'Unique identifier for the OR suite.',
    `building_id` BIGINT COMMENT 'FK to the building.',
    `care_site_id` BIGINT COMMENT 'FK to the care site.',
    `unit_id` BIGINT COMMENT 'FK to the surgical unit.',
    `accreditation_status` STRING COMMENT 'Current accreditation status.',
    `anesthesia_machine_model` STRING COMMENT 'Model of anesthesia machine installed.',
    `boom_configuration` DECIMAL(18,2) COMMENT 'Equipment boom configuration.',
    `capacity` STRING COMMENT 'Capacity for or suite.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `emergency_power_backup_flag` BOOLEAN COMMENT 'Indicates emergency power backup.',
    `emergency_use_flag` BOOLEAN COMMENT 'Indicates if designated for emergency use.',
    `equipment_inventory_list` STRING COMMENT 'List of major equipment in the OR.',
    `fire_suppression_system_type` STRING COMMENT 'Type of fire suppression system.',
    `hvac_air_exchange_rate_per_hour` DECIMAL(18,2) COMMENT 'HVAC air exchanges per hour.',
    `imaging_integration_type` DECIMAL(18,2) COMMENT 'Type of imaging integration available.',
    `is_active` BOOLEAN COMMENT 'Is Active for or suite.',
    `isolation_capable_flag` BOOLEAN COMMENT 'Indicates isolation capability.',
    `laminar_airflow_class` STRING COMMENT 'Laminar airflow classification.',
    `last_accreditation_survey_date` DATE COMMENT 'Date of last accreditation survey.',
    `last_maintenance_date` DATE COMMENT 'Date of last maintenance.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `license_expiration_date` DECIMAL(18,2) COMMENT 'License expiration date.',
    `license_number` STRING COMMENT 'OR suite license number.',
    `medical_gas_outlets_count` STRING COMMENT 'Number of medical gas outlets.',
    `next_accreditation_survey_due_date` DATE COMMENT 'Next accreditation survey due date.',
    `next_maintenance_due_date` DATE COMMENT 'Next maintenance due date.',
    `operational_status` DECIMAL(18,2) COMMENT 'Current operational status.',
    `or_name` STRING COMMENT 'Name of the operating room.',
    `or_number` STRING COMMENT 'Operating room number.',
    `or_type` STRING COMMENT 'Type of operating room.',
    `pediatric_capable_flag` BOOLEAN COMMENT 'Indicates pediatric surgery capability.',
    `positive_pressure_maintained_flag` BOOLEAN COMMENT 'Indicates positive pressure maintenance.',
    `robotic_surgery_compatible_flag` BOOLEAN COMMENT 'Indicates robotic surgery compatibility.',
    `room_height_feet` DECIMAL(18,2) COMMENT 'Room height in feet.',
    `room_length_feet` DECIMAL(18,2) COMMENT 'Room length in feet.',
    `room_width_feet` DECIMAL(18,2) COMMENT 'Room width in feet.',
    `scheduled_maintenance_window` STRING COMMENT 'Scheduled maintenance window.',
    `or_suite_status` STRING COMMENT 'Status for or suite.',
    `status_effective_timestamp` TIMESTAMP COMMENT 'When current status became effective.',
    `status_reason_code` STRING COMMENT 'Reason for current status.',
    `suite_code` STRING COMMENT 'Suite Code for or suite.',
    `suite_name` STRING COMMENT 'Suite Name for or suite.',
    `suite_type` STRING COMMENT 'Suite Type for or suite.',
    `surgical_table_type` STRING COMMENT 'Type of surgical table.',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp for or suite.',
    `vibe_canonical_facility_marker` BOOLEAN COMMENT 'Marker confirming this facility product is part of the canonical 26-product set.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    `vibe_placeholder` STRING COMMENT 'Added by VIBE mutator to ensure target entity is touched.',
    `video_integration_capability_flag` BOOLEAN COMMENT 'Indicates video integration capability.',
    CONSTRAINT pk_or_suite PRIMARY KEY(`or_suite_id`)
) COMMENT 'Represents an operating room suite with detailed infrastructure, equipment, and compliance information for surgical scheduling and safety.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` (
    `equipment_asset_id` BIGINT COMMENT '',
    `building_id` BIGINT COMMENT '',
    `care_site_id` BIGINT COMMENT '',
    `room_id` BIGINT COMMENT '',
    `unit_id` BIGINT COMMENT '',
    `org_unit_id` BIGINT COMMENT '',
    `acquisition_cost` DECIMAL(18,2) COMMENT '',
    `acquisition_date` DATE COMMENT '',
    `asset_tag` STRING COMMENT '',
    `calibration_required_flag` BOOLEAN COMMENT '',
    `current_location_floor` STRING COMMENT '',
    `depreciation_method` STRING COMMENT '',
    `disposal_method` STRING COMMENT '',
    `environmental_requirements` STRING COMMENT '',
    `equipment_category` STRING COMMENT '',
    `equipment_name` STRING COMMENT '',
    `equipment_type` STRING COMMENT '',
    `fda_device_class` STRING COMMENT '',
    `infection_control_category` STRING COMMENT '',
    `installation_date` DATE COMMENT '',
    `last_calibration_date` DECIMAL(18,2) COMMENT '',
    `last_pm_date` DATE COMMENT '',
    `manufacturer` STRING COMMENT '',
    `mobility_indicator` BOOLEAN COMMENT '',
    `model_number` STRING COMMENT '',
    `next_calibration_due_date` DECIMAL(18,2) COMMENT '',
    `next_pm_due_date` DATE COMMENT '',
    `notes` STRING COMMENT '',
    `operational_status` DECIMAL(18,2) COMMENT '',
    `pm_compliance_status` STRING COMMENT '',
    `pm_frequency_days` STRING COMMENT '',
    `power_requirements` STRING COMMENT '',
    `recall_date` DATE COMMENT '',
    `recall_number` STRING COMMENT '',
    `recall_remediation_date` DATE COMMENT '',
    `recall_status` STRING COMMENT '',
    `retirement_date` DATE COMMENT '',
    `risk_category` STRING COMMENT '',
    `sap_equipment_number` STRING COMMENT '',
    `serial_number` STRING COMMENT '',
    `service_contract_expiration_date` DECIMAL(18,2) COMMENT '',
    `service_contract_number` STRING COMMENT '',
    `service_contract_vendor` STRING COMMENT '',
    `udi` STRING COMMENT '',
    `useful_life_years` STRING COMMENT '',
    `vibe_canonical_facility_marker` BOOLEAN COMMENT 'Marker confirming this facility product is part of the canonical 26-product set.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    `vibe_placeholder` STRING COMMENT 'Added by VIBE mutator to ensure target entity is touched.',
    `warranty_expiration_date` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_equipment_asset PRIMARY KEY(`equipment_asset_id`)
) COMMENT 'Tracks medical and facility equipment assets including acquisition, maintenance schedules, recalls, and compliance status.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` (
    `maintenance_order_id` BIGINT COMMENT '',
    `care_site_id` BIGINT COMMENT '',
    `cost_center_id` BIGINT COMMENT '',
    `equipment_asset_id` BIGINT COMMENT '',
    `pm_schedule_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `tertiary_maintenance_approved_by_employee_id` BIGINT COMMENT '',
    `vendor_id` BIGINT COMMENT '',
    `actual_completion_datetime` TIMESTAMP COMMENT '',
    `actual_start_datetime` TIMESTAMP COMMENT '',
    `approval_datetime` TIMESTAMP COMMENT '',
    `approval_required_flag` BOOLEAN COMMENT '',
    `completed_date` DATE COMMENT 'Completed Date for maintenance order.',
    `completion_notes` STRING COMMENT '',
    `cost_amount` DECIMAL(18,2) COMMENT 'Cost Amount for maintenance order.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `downtime_minutes` STRING COMMENT '',
    `failure_code` STRING COMMENT '',
    `labor_cost` DECIMAL(18,2) COMMENT '',
    `labor_hours` DECIMAL(18,2) COMMENT '',
    `order_status` STRING COMMENT '',
    `order_type` STRING COMMENT '',
    `parts_cost` DECIMAL(18,2) COMMENT '',
    `priority` STRING COMMENT 'Priority for maintenance order.',
    `priority_level` STRING COMMENT '',
    `problem_description` STRING COMMENT '',
    `purchase_order_number` STRING COMMENT '',
    `regulatory_driver` STRING COMMENT '',
    `request_datetime` TIMESTAMP COMMENT '',
    `requested_date` DATE COMMENT 'Requested Date for maintenance order.',
    `risk_assessment_score` STRING COMMENT '',
    `safety_incident_flag` BOOLEAN COMMENT '',
    `scheduled_date` DATE COMMENT 'Scheduled Date for maintenance order.',
    `scheduled_end_datetime` TIMESTAMP COMMENT '',
    `scheduled_start_datetime` TIMESTAMP COMMENT '',
    `maintenance_order_status` STRING COMMENT 'Status for maintenance order.',
    `total_cost` DECIMAL(18,2) COMMENT '',
    `trade_type` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `vendor_service_flag` BOOLEAN COMMENT '',
    `vibe_canonical_facility_marker` BOOLEAN COMMENT 'Marker confirming this facility product is part of the canonical 26-product set.',
    `vibe_placeholder` STRING COMMENT 'Added by VIBE mutator to ensure target entity is touched.',
    `warranty_claim_flag` BOOLEAN COMMENT '',
    `work_order_number` STRING COMMENT '',
    CONSTRAINT pk_maintenance_order PRIMARY KEY(`maintenance_order_id`)
) COMMENT 'Work orders for preventive and corrective maintenance of facility equipment and infrastructure.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` (
    `pm_schedule_id` BIGINT COMMENT '',
    `care_site_id` BIGINT COMMENT '',
    `equipment_asset_id` BIGINT COMMENT '',
    `auto_generate_work_order` DECIMAL(18,2) COMMENT '',
    `cost_center` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `documentation_required` STRING COMMENT '',
    `downtime_required` BOOLEAN COMMENT '',
    `equipment_category` STRING COMMENT '',
    `estimated_downtime_hours` DECIMAL(18,2) COMMENT '',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT '',
    `frequency` STRING COMMENT '',
    `frequency_days` STRING COMMENT 'Frequency Days for pm schedule.',
    `frequency_interval` STRING COMMENT '',
    `frequency_unit` STRING COMMENT '',
    `last_completed_date` DATE COMMENT '',
    `last_performed_date` DATE COMMENT 'Last Performed Date for pm schedule.',
    `lead_time_days` STRING COMMENT '',
    `maintenance_task_description` STRING COMMENT '',
    `maintenance_type` STRING COMMENT '',
    `manufacturer_recommendation` STRING COMMENT '',
    `modified_by` STRING COMMENT '',
    `modified_timestamp` TIMESTAMP COMMENT '',
    `next_due_date` DATE COMMENT '',
    `notes` STRING COMMENT '',
    `notification_required` BOOLEAN COMMENT '',
    `parts_required` STRING COMMENT '',
    `planner_group` STRING COMMENT '',
    `priority` STRING COMMENT '',
    `regulatory_citation` STRING COMMENT '',
    `regulatory_driver` STRING COMMENT '',
    `required_trade` STRING COMMENT '',
    `safety_precautions` STRING COMMENT '',
    `schedule_code` STRING COMMENT '',
    `schedule_end_date` DATE COMMENT '',
    `schedule_name` STRING COMMENT '',
    `schedule_start_date` DATE COMMENT '',
    `schedule_status` STRING COMMENT '',
    `schedule_type` STRING COMMENT 'Schedule Type for pm schedule.',
    `pm_schedule_status` STRING COMMENT 'Status for pm schedule.',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp for pm schedule.',
    `vibe_canonical_facility_marker` BOOLEAN COMMENT 'Marker confirming this facility product is part of the canonical 26-product set.',
    `vibe_placeholder` STRING COMMENT 'Added by VIBE mutator to ensure target entity is touched.',
    `work_order_type` STRING COMMENT '',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_pm_schedule PRIMARY KEY(`pm_schedule_id`)
) COMMENT 'Preventive maintenance schedules for equipment and facility systems, ensuring regulatory compliance and operational readiness.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`inspection` (
    `inspection_id` BIGINT COMMENT '',
    `building_id` BIGINT COMMENT '',
    `care_site_id` BIGINT COMMENT '',
    `org_unit_id` BIGINT COMMENT '',
    `accreditation_cycle_year` STRING COMMENT '',
    `accreditation_decision` STRING COMMENT '',
    `certification_decision` STRING COMMENT '',
    `cms_certification_number` STRING COMMENT '',
    `complaint_based_flag` BOOLEAN COMMENT '',
    `condition_level_count` STRING COMMENT '',
    `coordinator_name` STRING COMMENT '',
    `cost` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `deemed_status_applicable_flag` BOOLEAN COMMENT '',
    `end_timestamp` TIMESTAMP COMMENT '',
    `environment_of_care_chapter` STRING COMMENT '',
    `findings_count` STRING COMMENT '',
    `follow_up_survey_date` DATE COMMENT '',
    `follow_up_survey_required_flag` BOOLEAN COMMENT '',
    `immediate_jeopardy_count` STRING COMMENT '',
    `inspection_date` DATE COMMENT '',
    `inspection_number` STRING COMMENT '',
    `inspection_status` STRING COMMENT '',
    `inspection_type` STRING COMMENT '',
    `inspector_credentials` STRING COMMENT '',
    `inspector_name` STRING COMMENT '',
    `inspector_organization` STRING COMMENT '',
    `life_safety_code_edition` STRING COMMENT '',
    `next_scheduled_inspection_date` DATE COMMENT '',
    `notes` STRING COMMENT '',
    `observation_count` STRING COMMENT '',
    `overall_disposition` STRING COMMENT '',
    `poc_acceptance_date` DATE COMMENT '',
    `poc_completion_verification_date` DATE COMMENT '',
    `poc_due_date` DATE COMMENT '',
    `poc_status` STRING COMMENT '',
    `poc_submission_date` DATE COMMENT '',
    `regulatory_authority` STRING COMMENT '',
    `report_issued_date` DATE COMMENT '',
    `scope` STRING COMMENT '',
    `scope_description` STRING COMMENT '',
    `standard_level_count` STRING COMMENT '',
    `start_timestamp` TIMESTAMP COMMENT '',
    `tjc_survey_type` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `vibe_canonical_facility_marker` BOOLEAN COMMENT 'Marker confirming this facility product is part of the canonical 26-product set.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    `vibe_placeholder` STRING COMMENT 'Added by VIBE mutator to ensure target entity is touched.',
    CONSTRAINT pk_inspection PRIMARY KEY(`inspection_id`)
) COMMENT 'Records of facility inspections by regulatory authorities, accreditation bodies, and internal quality teams.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` (
    `inspection_finding_id` BIGINT COMMENT '',
    `inspection_id` BIGINT COMMENT '',
    `previous_finding_inspection_finding_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `org_unit_id` BIGINT COMMENT '',
    `accreditation_impact_flag` BOOLEAN COMMENT '',
    `affected_location` STRING COMMENT '',
    `affected_patient_count` STRING COMMENT '',
    `citation_reference` STRING COMMENT '',
    `corrective_action_owner_name` STRING COMMENT '',
    `corrective_action_plan` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `due_date` DATE COMMENT '',
    `extended_due_date` DATE COMMENT '',
    `financial_penalty_amount` DECIMAL(18,2) COMMENT '',
    `finding_category` STRING COMMENT '',
    `finding_code` STRING COMMENT 'Finding Code for inspection finding.',
    `finding_date` DATE COMMENT '',
    `finding_description` STRING COMMENT '',
    `finding_number` STRING COMMENT '',
    `inspector_name` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `medicare_certification_impact_flag` BOOLEAN COMMENT '',
    `notes` STRING COMMENT '',
    `patient_safety_impact_flag` BOOLEAN COMMENT '',
    `recurrence_flag` BOOLEAN COMMENT '',
    `regulatory_body` STRING COMMENT '',
    `resolution_date` DATE COMMENT '',
    `resolution_status` STRING COMMENT '',
    `resolved_date` DATE COMMENT 'Resolved Date for inspection finding.',
    `risk_score` STRING COMMENT '',
    `root_cause_analysis_completion_date` DATE COMMENT '',
    `root_cause_analysis_required_flag` BOOLEAN COMMENT '',
    `severity` STRING COMMENT 'Severity for inspection finding.',
    `severity_level` STRING COMMENT '',
    `standard_code` STRING COMMENT '',
    `standard_description` STRING COMMENT '',
    `inspection_finding_status` STRING COMMENT 'Status for inspection finding.',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp for inspection finding.',
    `verification_date` DATE COMMENT '',
    `verification_method` STRING COMMENT '',
    `verified_by_name` STRING COMMENT '',
    `vibe_canonical_facility_marker` BOOLEAN COMMENT 'Marker confirming this facility product is part of the canonical 26-product set.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    `vibe_placeholder` STRING COMMENT 'Added by VIBE mutator to ensure target entity is touched.',
    CONSTRAINT pk_inspection_finding PRIMARY KEY(`inspection_finding_id`)
) COMMENT 'Individual findings from facility inspections, including citations, corrective actions, and resolution tracking.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` (
    `license_accreditation_id` BIGINT COMMENT '',
    `accreditation_status_id` BIGINT COMMENT '',
    `building_id` BIGINT COMMENT '',
    `care_site_id` BIGINT COMMENT '',
    `accreditation_level` STRING COMMENT '',
    `attestation_by` STRING COMMENT '',
    `attestation_date` DATE COMMENT '',
    `bed_capacity_authorized` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `credential_name` STRING COMMENT '',
    `credential_number` STRING COMMENT '',
    `credential_type` STRING COMMENT '',
    `deemed_status_flag` BOOLEAN COMMENT '',
    `deeming_organization` STRING COMMENT '',
    `deficiency_count` STRING COMMENT '',
    `document_reference_url` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiration_date` DECIMAL(18,2) COMMENT '',
    `issue_date` DATE COMMENT '',
    `issuing_authority` STRING COMMENT '',
    `issuing_authority_code` STRING COMMENT '',
    `license_number` STRING COMMENT 'License Number for license accreditation.',
    `license_type` STRING COMMENT 'License Type for license accreditation.',
    `medicaid_provider_number` STRING COMMENT '',
    `medicare_provider_number` STRING COMMENT '',
    `next_survey_date` DATE COMMENT '',
    `notes` STRING COMMENT '',
    `payer_contract_requirement_flag` BOOLEAN COMMENT '',
    `plan_of_correction_approved_date` DATE COMMENT '',
    `plan_of_correction_due_date` DATE COMMENT '',
    `plan_of_correction_submitted_date` DATE COMMENT '',
    `public_disclosure_flag` BOOLEAN COMMENT '',
    `renewal_application_date` DATE COMMENT '',
    `renewal_due_date` DATE COMMENT '',
    `scope_of_credential` STRING COMMENT '',
    `license_accreditation_status` STRING COMMENT 'Status for license accreditation.',
    `status_effective_date` DATE COMMENT '',
    `status_reason` STRING COMMENT '',
    `survey_date` DATE COMMENT '',
    `survey_outcome` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `vibe_canonical_facility_marker` BOOLEAN COMMENT 'Marker confirming this facility product is part of the canonical 26-product set.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    `vibe_placeholder` STRING COMMENT 'Added by VIBE mutator to ensure target entity is touched.',
    CONSTRAINT pk_license_accreditation PRIMARY KEY(`license_accreditation_id`)
) COMMENT 'Facility licenses and accreditations from regulatory bodies, tracking status, renewal dates, and compliance requirements.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` (
    `space_allocation_id` BIGINT COMMENT '',
    `building_id` BIGINT COMMENT '',
    `care_site_id` BIGINT COMMENT '',
    `cost_center_id` BIGINT COMMENT '',
    `room_id` BIGINT COMMENT '',
    `unit_id` BIGINT COMMENT '',
    `org_unit_id` BIGINT COMMENT '',
    `allocated_square_footage` DECIMAL(18,2) COMMENT '',
    `allocation_end_date` DATE COMMENT '',
    `allocation_notes` STRING COMMENT '',
    `allocation_number` STRING COMMENT '',
    `allocation_priority` STRING COMMENT '',
    `allocation_purpose` STRING COMMENT '',
    `allocation_start_date` DATE COMMENT '',
    `allocation_status` STRING COMMENT '',
    `allocation_type` STRING COMMENT 'Allocation Type for space allocation.',
    `annual_space_cost` DECIMAL(18,2) COMMENT '',
    `approval_date` DATE COMMENT '',
    `approved_by` STRING COMMENT '',
    `cost_per_square_foot` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `effective_end_date` DATE COMMENT 'Effective End Date for space allocation.',
    `effective_from_timestamp` TIMESTAMP COMMENT '',
    `effective_start_date` DATE COMMENT 'Effective Start Date for space allocation.',
    `effective_to_timestamp` TIMESTAMP COMMENT '',
    `floor_number` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `last_review_date` DATE COMMENT '',
    `lease_ownership_indicator` BOOLEAN COMMENT '',
    `monthly_space_cost` DECIMAL(18,2) COMMENT '',
    `next_review_date` DATE COMMENT '',
    `occupancy_percentage` DECIMAL(18,2) COMMENT '',
    `primary_use_flag` BOOLEAN COMMENT '',
    `service_line` STRING COMMENT '',
    `shared_space_flag` BOOLEAN COMMENT '',
    `space_subtype` STRING COMMENT '',
    `space_type` STRING COMMENT '',
    `square_footage` DECIMAL(18,2) COMMENT 'Square Footage for space allocation.',
    `termination_reason` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp for space allocation.',
    `vibe_canonical_facility_marker` BOOLEAN COMMENT 'Marker confirming this facility product is part of the canonical 26-product set.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    `vibe_placeholder` STRING COMMENT 'Added by VIBE mutator to ensure target entity is touched.',
    `wing_section` STRING COMMENT '',
    CONSTRAINT pk_space_allocation PRIMARY KEY(`space_allocation_id`)
) COMMENT 'Allocation of physical space to departments, services, and cost centers for space planning and cost accounting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` (
    `environmental_service_request_id` BIGINT COMMENT '',
    `bed_id` BIGINT COMMENT '',
    `building_id` BIGINT COMMENT '',
    `care_site_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `primary_environmental_employee_id` BIGINT COMMENT '',
    `room_id` BIGINT COMMENT '',
    `tertiary_environmental_cancelled_by_user_employee_id` BIGINT COMMENT '',
    `unit_id` BIGINT COMMENT '',
    `assigned_timestamp` TIMESTAMP COMMENT '',
    `bed_board_integration_flag` BOOLEAN COMMENT '',
    `bed_status_updated_flag` BOOLEAN COMMENT '',
    `cancellation_reason` STRING COMMENT '',
    `cancellation_timestamp` TIMESTAMP COMMENT '',
    `cleaning_protocol_used` STRING COMMENT '',
    `completion_timestamp` TIMESTAMP COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `discharge_to_clean_cycle_time_minutes` DECIMAL(18,2) COMMENT '',
    `disinfectant_product_used` STRING COMMENT '',
    `infection_prevention_alert_flag` BOOLEAN COMMENT '',
    `inspection_timestamp` TIMESTAMP COMMENT '',
    `isolation_precaution_type` STRING COMMENT '',
    `last_updated_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT '',
    `patient_discharge_timestamp` TIMESTAMP COMMENT '',
    `priority_level` STRING COMMENT '',
    `quality_inspection_performed_flag` BOOLEAN COMMENT '',
    `quality_inspection_result` STRING COMMENT '',
    `request_number` STRING COMMENT '',
    `request_status` STRING COMMENT '',
    `request_timestamp` TIMESTAMP COMMENT '',
    `request_to_start_time_minutes` DECIMAL(18,2) COMMENT '',
    `request_type` STRING COMMENT '',
    `special_equipment_required` STRING COMMENT '',
    `start_timestamp` TIMESTAMP COMMENT '',
    `vibe_canonical_facility_marker` BOOLEAN COMMENT 'Marker confirming this facility product is part of the canonical 26-product set.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    `vibe_placeholder` STRING COMMENT 'Added by VIBE mutator to ensure target entity is touched.',
    `work_duration_minutes` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_environmental_service_request PRIMARY KEY(`environmental_service_request_id`)
) COMMENT 'Environmental services (housekeeping) requests for room cleaning, bed turnaround, and infection control protocols.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` (
    `capacity_snapshot_id` BIGINT COMMENT '',
    `building_id` BIGINT COMMENT '',
    `care_site_id` BIGINT COMMENT '',
    `unit_id` BIGINT COMMENT '',
    `alternate_care_site_activation_status` STRING COMMENT '',
    `ambulance_diversion_status` STRING COMMENT '',
    `available_beds` STRING COMMENT '',
    `bariatric_beds_available` STRING COMMENT '',
    `beds_in_cleaning` STRING COMMENT '',
    `beds_out_of_service` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `disaster_census` STRING COMMENT '',
    `ed_boarding_count` STRING COMMENT '',
    `ed_bypass_status` STRING COMMENT '',
    `ed_census` STRING COMMENT '',
    `eoc_activation_status` STRING COMMENT '',
    `icu_bypass_status` STRING COMMENT '',
    `icu_census` STRING COMMENT '',
    `isolation_beds_available` STRING COMMENT '',
    `nicu_census` STRING COMMENT '',
    `observation_beds_available` STRING COMMENT '',
    `occupancy_percentage` DECIMAL(18,2) COMMENT '',
    `occupied_beds` STRING COMMENT '',
    `or_utilization_percentage` DECIMAL(18,2) COMMENT '',
    `pediatric_beds_available` STRING COMMENT '',
    `snapshot_source_system` STRING COMMENT '',
    `snapshot_timestamp` TIMESTAMP COMMENT '',
    `snapshot_type` STRING COMMENT '',
    `surge_beds_available` STRING COMMENT '',
    `telemetry_beds_available` STRING COMMENT '',
    `total_licensed_beds` STRING COMMENT '',
    `total_staffed_beds` STRING COMMENT '',
    `ventilator_availability_count` STRING COMMENT '',
    `vibe_canonical_facility_marker` BOOLEAN COMMENT 'Marker confirming this facility product is part of the canonical 26-product set.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    `vibe_placeholder` STRING COMMENT 'Added by VIBE mutator to ensure target entity is touched.',
    CONSTRAINT pk_capacity_snapshot PRIMARY KEY(`capacity_snapshot_id`)
) COMMENT 'Point-in-time snapshots of facility capacity including bed availability, census, and diversion status for operational planning.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`service` (
    `service_id` BIGINT COMMENT '',
    `building_id` BIGINT COMMENT '',
    `care_site_id` BIGINT COMMENT '',
    `cost_center_id` BIGINT COMMENT '',
    `clinician_id` BIGINT COMMENT '',
    `unit_id` BIGINT COMMENT '',
    `org_unit_id` BIGINT COMMENT '',
    `accreditation_body` STRING COMMENT '',
    `accreditation_date` DATE COMMENT '',
    `accreditation_expiration_date` DECIMAL(18,2) COMMENT '',
    `accreditation_level` STRING COMMENT '',
    `accreditation_required_flag` BOOLEAN COMMENT '',
    `bariatric_surgery_accreditation` STRING COMMENT '',
    `cancer_program_accreditation` STRING COMMENT '',
    `service_category` STRING COMMENT '',
    `chest_pain_center_accreditation` STRING COMMENT '',
    `clinical_specialty` STRING COMMENT '',
    `cms_service_type_code` STRING COMMENT '',
    `service_code` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `service_description` STRING COMMENT '',
    `effective_end_date` DATE COMMENT 'Effective End Date for service.',
    `effective_start_date` DATE COMMENT 'Effective Start Date for service.',
    `emergency_service_flag` BOOLEAN COMMENT '',
    `end_date` DATE COMMENT '',
    `is_active` BOOLEAN COMMENT 'Is Active for service.',
    `license_expiration_date` DECIMAL(18,2) COMMENT '',
    `license_number` STRING COMMENT '',
    `license_required_flag` BOOLEAN COMMENT '',
    `line` STRING COMMENT '',
    `service_name` STRING COMMENT '',
    `nicu_level` STRING COMMENT '',
    `patient_access_phone` STRING COMMENT '',
    `payer_contracted_flag` BOOLEAN COMMENT '',
    `referral_required_flag` BOOLEAN COMMENT '',
    `service_status` STRING COMMENT '',
    `service_type` STRING COMMENT 'Service Type for service.',
    `start_date` DATE COMMENT '',
    `stroke_center_designation` STRING COMMENT '',
    `telehealth_enabled_flag` BOOLEAN COMMENT '',
    `trauma_level` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `url` STRING COMMENT '',
    `vibe_canonical_facility_marker` BOOLEAN COMMENT 'Marker confirming this facility product is part of the canonical 26-product set.',
    `vibe_placeholder` STRING COMMENT 'Added by VIBE mutator to ensure target entity is touched.',
    `volume_annual` STRING COMMENT '',
    CONSTRAINT pk_service PRIMARY KEY(`service_id`)
) COMMENT 'Clinical and administrative services offered at a care site, including accreditation status and operational details.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`contract` (
    `contract_id` BIGINT COMMENT '',
    `building_id` BIGINT COMMENT '',
    `business_associate_agreement_id` BIGINT COMMENT '',
    `care_site_id` BIGINT COMMENT '',
    `cost_center_id` BIGINT COMMENT '',
    `vendor_id` BIGINT COMMENT '',
    `annual_spend_amount` DECIMAL(18,2) COMMENT '',
    `approval_date` DATE COMMENT '',
    `approved_by` STRING COMMENT '',
    `auto_renewal_flag` BOOLEAN COMMENT '',
    `contract_number` STRING COMMENT '',
    `contract_status` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `document_url` STRING COMMENT '',
    `end_date` DATE COMMENT '',
    `general_ledger_account_code` STRING COMMENT '',
    `insurance_certificate_expiration_date` DECIMAL(18,2) COMMENT '',
    `insurance_requirement_description` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `last_performance_review_date` DATE COMMENT '',
    `modified_by_user` STRING COMMENT '',
    `contract_name` STRING COMMENT '',
    `next_performance_review_date` DATE COMMENT '',
    `notes` STRING COMMENT '',
    `notice_period_days` STRING COMMENT '',
    `owner_email` STRING COMMENT '',
    `owner_name` STRING COMMENT '',
    `owner_phone` STRING COMMENT '',
    `payment_terms` DECIMAL(18,2) COMMENT '',
    `performance_metric_description` STRING COMMENT '',
    `regulatory_compliance_notes` STRING COMMENT '',
    `renewal_option_flag` BOOLEAN COMMENT '',
    `service_type` STRING COMMENT '',
    `signed_date` DATE COMMENT '',
    `sla_response_time_hours` DECIMAL(18,2) COMMENT '',
    `sla_terms` STRING COMMENT '',
    `sla_uptime_percentage` DECIMAL(18,2) COMMENT '',
    `start_date` DATE COMMENT '',
    `termination_clause_description` STRING COMMENT '',
    `value_amount` DECIMAL(18,2) COMMENT '',
    `value_currency_code` STRING COMMENT '',
    `vbc_integration_flag` BOOLEAN COMMENT '',
    `vendor_contact_email` STRING COMMENT '',
    `vendor_contact_name` STRING COMMENT '',
    `vendor_contact_phone` STRING COMMENT '',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure change',
    `vibe_canonical_facility_marker` BOOLEAN COMMENT 'Marker confirming this facility product is part of the canonical 26-product set.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    `vibe_placeholder` STRING COMMENT 'Added by VIBE mutator to ensure target entity is touched.',
    CONSTRAINT pk_contract PRIMARY KEY(`contract_id`)
) COMMENT 'Facility service contracts with vendors for maintenance, supplies, and outsourced services.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` (
    `hazardous_material_id` BIGINT COMMENT '',
    `building_id` BIGINT COMMENT '',
    `care_site_id` BIGINT COMMENT '',
    `room_id` BIGINT COMMENT '',
    `unit_id` BIGINT COMMENT '',
    `org_unit_id` BIGINT COMMENT '',
    `activity_level` DECIMAL(18,2) COMMENT '',
    `biohazard_level` STRING COMMENT '',
    `cas_number` STRING COMMENT '',
    `chemical_name` STRING COMMENT '',
    `container_size` STRING COMMENT '',
    `container_type` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `current_quantity_on_hand` DECIMAL(18,2) COMMENT '',
    `disposal_method` STRING COMMENT '',
    `epa_reportable_quantity_flag` BOOLEAN COMMENT '',
    `expiration_date` DECIMAL(18,2) COMMENT '',
    `ghs_pictogram_codes` STRING COMMENT '',
    `hazard_class` STRING COMMENT '',
    `hazardous_material_status` STRING COMMENT '',
    `incompatible_materials` STRING COMMENT '',
    `infectious_agent_name` STRING COMMENT '',
    `last_inspection_date` DATE COMMENT '',
    `lot_number` STRING COMMENT '',
    `manufacturer_name` STRING COMMENT '',
    `manufacturer_product_code` STRING COMMENT '',
    `material_name` STRING COMMENT '',
    `maximum_allowable_quantity` DECIMAL(18,2) COMMENT '',
    `next_inspection_due_date` DATE COMMENT '',
    `nfpa_rating` STRING COMMENT '',
    `permit_expiration_date` DECIMAL(18,2) COMMENT '',
    `permit_number` STRING COMMENT '',
    `personal_protective_equipment_required` STRING COMMENT '',
    `radioactive_isotope` STRING COMMENT '',
    `radioactive_material_flag` BOOLEAN COMMENT '',
    `receipt_date` DATE COMMENT '',
    `regulatory_permit_required_flag` BOOLEAN COMMENT '',
    `responsible_person_contact` STRING COMMENT '',
    `responsible_person_name` STRING COMMENT '',
    `sara_title_iii_reportable_flag` BOOLEAN COMMENT '',
    `sds_document_number` STRING COMMENT '',
    `sds_revision_date` DATE COMMENT '',
    `special_handling_instructions` STRING COMMENT '',
    `storage_cabinet_type` STRING COMMENT '',
    `storage_location_description` STRING COMMENT '',
    `unit_of_measure` STRING COMMENT '',
    `ventilation_requirement` STRING COMMENT '',
    `vibe_canonical_facility_marker` BOOLEAN COMMENT 'Marker confirming this facility product is part of the canonical 26-product set.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    `vibe_placeholder` STRING COMMENT 'Added by VIBE mutator to ensure target entity is touched.',
    `waste_stream_code` STRING COMMENT '',
    CONSTRAINT pk_hazardous_material PRIMARY KEY(`hazardous_material_id`)
) COMMENT 'Inventory and tracking of hazardous materials stored at facility locations, supporting OSHA and EPA compliance.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` (
    `safety_incident_id` BIGINT COMMENT '',
    `bed_id` BIGINT COMMENT '',
    `building_id` BIGINT COMMENT '',
    `care_site_id` BIGINT COMMENT '',
    `mpi_record_id` BIGINT COMMENT '',
    `investigation_id` BIGINT COMMENT '',
    `material_master_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `room_id` BIGINT COMMENT '',
    `unit_id` BIGINT COMMENT '',
    `corrective_action_description` STRING COMMENT '',
    `corrective_action_due_date` DATE COMMENT '',
    `corrective_action_status` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `days_away_from_work` STRING COMMENT 'Number of days away from work due to the incident.',
    `days_of_restricted_work` STRING COMMENT 'Number of days of restricted work activity.',
    `safety_incident_description` STRING COMMENT 'Description for safety incident.',
    `environmental_factor` STRING COMMENT '',
    `environmental_release_flag` BOOLEAN COMMENT 'Indicates whether an environmental release occurred.',
    `equipment_involved` STRING COMMENT 'Equipment involved in the incident.',
    `equipment_involved_flag` BOOLEAN COMMENT '',
    `event_description` STRING COMMENT '',
    `event_timestamp` TIMESTAMP COMMENT '',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether follow-up is required.',
    `harm_level` STRING COMMENT '',
    `hazard_type` STRING COMMENT '',
    `immediate_action_taken` STRING COMMENT 'Immediate actions taken at the time of the incident.',
    `incident_category` STRING COMMENT '',
    `incident_date` DATE COMMENT 'Incident Date for safety incident.',
    `incident_number` STRING COMMENT '',
    `incident_status` STRING COMMENT '',
    `incident_time` TIMESTAMP COMMENT 'Time the incident occurred.',
    `incident_type` STRING COMMENT '',
    `injury_body_part` STRING COMMENT 'Body part injured if applicable.',
    `injury_description` STRING COMMENT '',
    `injury_nature` STRING COMMENT 'Nature of the injury.',
    `injury_type` STRING COMMENT '',
    `investigation_completion_date` DATE COMMENT 'Date the investigation was completed.',
    `investigation_required_flag` BOOLEAN COMMENT 'Indicates whether a formal investigation is required.',
    `investigation_status` STRING COMMENT '',
    `involved_person_name` STRING COMMENT 'Name of the person involved in the incident.',
    `involved_person_role` STRING COMMENT 'Role of the person involved.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `location_description` STRING COMMENT '',
    `near_miss_flag` BOOLEAN COMMENT '',
    `notes` STRING COMMENT 'Free-text notes about the incident.',
    `osha_recordable_flag` BOOLEAN COMMENT '',
    `osha_report_date` DATE COMMENT '',
    `osha_report_number` STRING COMMENT 'OSHA report number if applicable.',
    `patient_involved_flag` BOOLEAN COMMENT '',
    `property_damage_amount` DECIMAL(18,2) COMMENT 'Estimated property damage amount.',
    `property_damage_flag` BOOLEAN COMMENT 'Indicates whether property damage occurred.',
    `regulatory_report_required_flag` BOOLEAN COMMENT '',
    `regulatory_report_submitted_date` DATE COMMENT 'Date the regulatory report was submitted.',
    `reported_by` STRING COMMENT 'Reported By for safety incident.',
    `resolution_date` DATE COMMENT '',
    `root_cause` STRING COMMENT '',
    `root_cause_analysis_date` DATE COMMENT 'Date root cause analysis was completed.',
    `severity` STRING COMMENT 'Severity for safety incident.',
    `severity_level` STRING COMMENT '',
    `safety_incident_status` STRING COMMENT 'Status for safety incident.',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp for safety incident.',
    `vibe_canonical_facility_marker` BOOLEAN COMMENT 'Marker confirming this facility product is part of the canonical 26-product set.',
    `vibe_placeholder` STRING COMMENT 'Added by VIBE mutator to ensure target entity is touched.',
    `visitor_involved_flag` BOOLEAN COMMENT '',
    `witness_count` STRING COMMENT '',
    `witness_names` STRING COMMENT 'Names of witnesses to the incident.',
    `workers_comp_claim_flag` BOOLEAN COMMENT '',
    `workers_comp_claim_number` STRING COMMENT 'Workers compensation claim number if applicable.',
    CONSTRAINT pk_safety_incident PRIMARY KEY(`safety_incident_id`)
) COMMENT 'Facility safety incidents including injuries, near-misses, and environmental hazards for risk management and OSHA reporting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` (
    `site_hierarchy_id` BIGINT COMMENT '',
    `organization_id` BIGINT COMMENT 'FK to facility.organization for hierarchy root.',
    `care_site_id` BIGINT COMMENT '',
    `primary_care_site_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `effective_end_date` DATE COMMENT '',
    `effective_start_date` DATE COMMENT '',
    `hierarchy_level` STRING COMMENT '',
    `hierarchy_name` STRING COMMENT '',
    `hierarchy_path` STRING COMMENT 'Hierarchy Path for site hierarchy.',
    `hierarchy_type` STRING COMMENT '',
    `is_active` BOOLEAN COMMENT 'Is Active for site hierarchy.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT '',
    `region_code` STRING COMMENT '',
    `region_name` STRING COMMENT '',
    `reporting_rollup_flag` BOOLEAN COMMENT 'Indicates whether this relationship is used for reporting rollup.',
    `sort_order` STRING COMMENT '',
    `site_hierarchy_status` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp for site hierarchy.',
    `vibe_canonical_facility_marker` BOOLEAN COMMENT 'Marker confirming this facility product is part of the canonical 26-product set.',
    `vibe_placeholder` STRING COMMENT 'Added by VIBE mutator to ensure target entity is touched.',
    CONSTRAINT pk_site_hierarchy PRIMARY KEY(`site_hierarchy_id`)
) COMMENT 'Defines the organizational hierarchy of care sites, regions, and systems for multi-facility health system management.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`network_contract` (
    `network_contract_id` BIGINT COMMENT '',
    `care_site_id` BIGINT COMMENT '',
    `payer_id` BIGINT COMMENT '',
    `provider_network_id` BIGINT COMMENT '',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract auto-renews.',
    `contract_effective_date` DATE COMMENT '',
    `contract_name` STRING COMMENT '',
    `contract_number` STRING COMMENT '',
    `contract_status` STRING COMMENT '',
    `contract_termination_date` DATE COMMENT '',
    `contract_type` STRING COMMENT '',
    `contract_value` DECIMAL(18,2) COMMENT 'Contract Value for network contract.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `document_url` STRING COMMENT 'URL to the contract document.',
    `effective_date` DATE COMMENT 'Effective Date for network contract.',
    `fee_schedule_type` DECIMAL(18,2) COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `last_renegotiation_date` DATE COMMENT 'Date of the last renegotiation.',
    `network_name` STRING COMMENT '',
    `network_tier` STRING COMMENT '',
    `next_renegotiation_date` DATE COMMENT 'Date of the next scheduled renegotiation.',
    `notes` STRING COMMENT '',
    `notice_period_days` STRING COMMENT 'Notice period in days for termination.',
    `owner_name` STRING COMMENT 'Name of the contract owner.',
    `payment_model` DECIMAL(18,2) COMMENT 'Payment model (FFS, capitation, bundled, etc.).',
    `performance_incentive_flag` BOOLEAN COMMENT 'Indicates whether performance incentives are included.',
    `reimbursement_methodology` STRING COMMENT '',
    `renewal_date` DATE COMMENT '',
    `signed_date` DATE COMMENT 'Date the contract was signed.',
    `network_contract_status` STRING COMMENT 'Status for network contract.',
    `termination_date` DATE COMMENT 'Termination Date for network contract.',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp for network contract.',
    `value_amount` DECIMAL(18,2) COMMENT 'Total contract value amount.',
    `vibe_canonical_facility_marker` BOOLEAN COMMENT 'Marker confirming this facility product is part of the canonical 26-product set.',
    `vibe_placeholder` STRING COMMENT 'Added by VIBE mutator to ensure target entity is touched.',
    CONSTRAINT pk_network_contract PRIMARY KEY(`network_contract_id`)
) COMMENT 'Contracts between the facility and payer networks defining participation terms and reimbursement arrangements.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` (
    `facility_program_participation_id` BIGINT COMMENT '',
    `care_site_id` BIGINT COMMENT '',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to the health plan that participates in the quality program',
    `quality_program_id` BIGINT COMMENT '',
    `attestation_date` DATE COMMENT '',
    `compliance_status` STRING COMMENT 'Indicates whether this health plan is meeting all reporting and performance requirements for this quality program. Drives penalty assessment and program standing.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this program participation record was created in the system.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `effective_date` DATE COMMENT 'Date on which the health plans participation in this quality program became active. Defines the start of the measurement and reporting obligations.',
    `effective_end_date` DATE COMMENT '',
    `effective_start_date` DATE COMMENT '',
    `enrollment_count_at_participation` STRING COMMENT 'The number of members enrolled in this health plan at the time of program participation. Used for risk stratification and measure applicability determination.',
    `enrollment_date` DATE COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `last_submission_date` DATE COMMENT 'The most recent date on which this health plan submitted quality data or performance reports for this program. Used to track compliance with reporting requirements.',
    `measure_set_version` STRING COMMENT 'The specific version or subset of quality measures applicable to this health plan within this program. Plans may have different measure sets based on plan type (MA vs Medicaid), enrollment size, or voluntary vs mandatory participation.',
    `notes` STRING COMMENT '',
    `participation_status` STRING COMMENT '',
    `participation_type` STRING COMMENT 'Indicates whether this health plans participation in this quality program is mandatory (regulatory requirement), voluntary (elective participation), or part of a pilot program.',
    `performance_period_end` DATE COMMENT '',
    `performance_period_start` DATE COMMENT '',
    `performance_score` DECIMAL(18,2) COMMENT 'The calculated performance score for this specific health plan within this quality program for the program year. Methodology defined in quality_program.total_performance_score_methodology. Used to determine payment adjustments or star ratings.',
    `program_name` STRING COMMENT '',
    `program_type` STRING COMMENT '',
    `quality_program_participation_status` STRING COMMENT 'Current lifecycle status of the health plans participation in this quality program. Drives eligibility for performance measurement and payment adjustments.',
    `reporting_frequency` STRING COMMENT 'The cadence at which this health plan must submit quality data or performance reports for this program. May vary by plan based on program requirements and plan characteristics.',
    `reporting_period` STRING COMMENT '',
    `reporting_period_end` DATE COMMENT 'End date of the reporting period.',
    `reporting_period_start` DATE COMMENT 'Start date of the reporting period.',
    `ssot_canonical_reference` STRING COMMENT 'Fully-qualified reference to the canonical SSOT table that supersedes this duplicate concept.',
    `ssot_reconciliation_status` STRING COMMENT 'SSOT reconciliation status indicating this product was reconciled against its canonical source-of-truth table.',
    `submission_method` STRING COMMENT 'The technical method by which this health plan submits quality data for this program. May vary by plan based on plan size, technical capabilities, or program-specific requirements.',
    `termination_date` DATE COMMENT 'Date on which the health plans participation in this quality program ended or is scheduled to end. Null for ongoing participation.',
    `termination_reason` STRING COMMENT 'Reason for termination of participation.',
    `updated_date` TIMESTAMP COMMENT 'Timestamp when this program participation record was last modified.',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `vibe_canonical_facility_marker` BOOLEAN COMMENT 'Marker confirming this facility product is part of the canonical 26-product set.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    `vibe_placeholder` STRING COMMENT 'Added by VIBE mutator to ensure target entity is touched.',
    CONSTRAINT pk_facility_program_participation PRIMARY KEY(`facility_program_participation_id`)
) COMMENT 'Tracks facility participation in quality programs, value-based care initiatives, and regulatory programs. Facility-level program participation. For quality program participation see quality.quality_program_participation.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` (
    `block_assignment_id` BIGINT COMMENT '',
    `care_site_id` BIGINT COMMENT '',
    `clinician_id` BIGINT COMMENT '',
    `or_suite_id` BIGINT COMMENT '',
    `service_id` BIGINT COMMENT '',
    `org_unit_id` BIGINT COMMENT 'FK to the org unit (service line) assigned the block.',
    `block_date` DATE COMMENT 'Date of the block assignment.',
    `block_day_of_week` STRING COMMENT '',
    `block_end_time` TIMESTAMP COMMENT '',
    `block_name` STRING COMMENT '',
    `block_start_time` TIMESTAMP COMMENT '',
    `block_status` STRING COMMENT 'Current status of the block assignment.',
    `block_type` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `day_of_week` STRING COMMENT 'Day of week for recurring blocks.',
    `duration_minutes` DECIMAL(18,2) COMMENT 'Duration of the block in minutes.',
    `effective_end_date` DATE COMMENT '',
    `effective_start_date` DATE COMMENT '',
    `is_recurring` BOOLEAN COMMENT 'Indicates whether the block is recurring.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `minimum_utilization_threshold` DECIMAL(18,2) COMMENT '',
    `notes` STRING COMMENT '',
    `release_deadline_hours` STRING COMMENT 'Hours before block start by which unused time must be released.',
    `release_policy` STRING COMMENT '',
    `release_window_hours` STRING COMMENT '',
    `service_line` STRING COMMENT 'Service line associated with the block.',
    `block_assignment_status` STRING COMMENT '',
    `utilization_percentage` DECIMAL(18,2) COMMENT '',
    `vibe_canonical_facility_marker` BOOLEAN COMMENT 'Marker confirming this facility product is part of the canonical 26-product set.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    `vibe_placeholder` STRING COMMENT 'Added by VIBE mutator to ensure target entity is touched.',
    CONSTRAINT pk_block_assignment PRIMARY KEY(`block_assignment_id`)
) COMMENT 'Assignment of OR block time to surgeons and service lines for surgical scheduling optimization.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` (
    `equipment_authorization_id` BIGINT COMMENT '',
    `care_site_id` BIGINT COMMENT '',
    `clinician_id` BIGINT COMMENT '',
    `equipment_asset_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT 'FK to the employee who granted the authorization.',
    `equipment_employee_id` BIGINT COMMENT 'FK to the authorized employee.',
    `authorization_date` DATE COMMENT '',
    `authorization_level` STRING COMMENT 'Level of authorization granted.',
    `authorization_number` STRING COMMENT 'Authorization number for tracking.',
    `authorization_status` STRING COMMENT '',
    `authorization_type` STRING COMMENT '',
    `competency_assessment_date` DATE COMMENT '',
    `competency_level` STRING COMMENT '',
    `competency_verification_date` DATE COMMENT 'Date competency was verified.',
    `competency_verified_flag` BOOLEAN COMMENT 'Indicates whether competency was verified.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `equipment_category` STRING COMMENT 'Category of equipment authorized.',
    `expiration_date` DECIMAL(18,2) COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT '',
    `renewal_required_flag` BOOLEAN COMMENT '',
    `training_completion_date` DATE COMMENT '',
    `training_program_name` STRING COMMENT '',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether training is required.',
    `vibe_canonical_facility_marker` BOOLEAN COMMENT 'Marker confirming this facility product is part of the canonical 26-product set.',
    `vibe_mutation_timestamp` TIMESTAMP COMMENT 'Timestamp indicating VIBE mutation application',
    `vibe_placeholder` STRING COMMENT 'Added by VIBE mutator to ensure target entity is touched.',
    CONSTRAINT pk_equipment_authorization PRIMARY KEY(`equipment_authorization_id`)
) COMMENT 'Authorization records for equipment use by specific providers or departments, ensuring competency and safety compliance.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`facility`.`organization` (
    `organization_id` BIGINT COMMENT 'Primary key for organization.',
    `care_site_id` BIGINT COMMENT 'FK to facility.care_site anchoring the organization to a physical care site.',
    `parent_organization_id` BIGINT COMMENT 'Self-referential FK enabling organization hierarchy traversal.',
    `address_line_1` STRING COMMENT 'Primary street address of the organization.',
    `address_line_2` STRING COMMENT 'Secondary street address of the organization.',
    `city` STRING COMMENT 'City where the organization is located.',
    `organization_code` STRING COMMENT 'Short code identifying the organization.',
    `country_code` STRING COMMENT 'ISO country code.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `dba_name` STRING COMMENT 'Doing-business-as name if different from legal name.',
    `effective_date` DATE COMMENT 'Date the organization record became effective.',
    `effective_end_date` DATE COMMENT 'Date the organization was deactivated or merged.',
    `effective_start_date` DATE COMMENT 'Date the organization became active in the system.',
    `ein` STRING COMMENT '',
    `email_address` STRING COMMENT 'General contact email for the organization.',
    `fax_number` STRING COMMENT 'Fax number for the organization.',
    `hierarchy_level` STRING COMMENT 'Numeric level in the organizational hierarchy.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the organization is currently active.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `legal_entity_type` STRING COMMENT 'Legal entity type (corporation, LLC, non-profit, etc.).',
    `organization_name` STRING COMMENT 'Legal name of the organization.',
    `npi` STRING COMMENT 'National Provider Identifier for the organization.',
    `operational_status` STRING COMMENT 'Current operational status of the organization.',
    `organization_status` STRING COMMENT '',
    `organization_type` STRING COMMENT 'Type classification: health_system, hospital, clinic, etc.',
    `ownership_type` STRING COMMENT 'Ownership classification (non-profit, for-profit, government).',
    `phone_number` STRING COMMENT 'Main phone number for the organization.',
    `postal_code` STRING COMMENT 'ZIP or postal code.',
    `state` STRING COMMENT 'State or province code.',
    `state_of_incorporation` DECIMAL(18,2) COMMENT '',
    `tax_exempt_flag` BOOLEAN COMMENT '',
    `tax_exempt_status` STRING COMMENT 'Tax-exempt status (501(c)(3), etc.).',
    `tax_identification_number` STRING COMMENT 'Federal tax identification number (EIN) for the organization.',
    `termination_date` DATE COMMENT 'Date the organization record was terminated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the organization record was last updated.',
    `vibe_canonical_facility_marker` BOOLEAN COMMENT 'Marker confirming this facility product is part of the canonical 26-product set.',
    `vibe_placeholder` STRING COMMENT 'Added by VIBE mutator to ensure target entity is touched.',
    `website_url` STRING COMMENT '',
    CONSTRAINT pk_organization PRIMARY KEY(`organization_id`)
) COMMENT 'Represents the legal organizational entity (health system, hospital, practice group) that owns or operates care sites. Foundational for multi-entity governance.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ADD CONSTRAINT `fk_facility_care_site_parent_care_site_id` FOREIGN KEY (`parent_care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ADD CONSTRAINT `fk_facility_care_site_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`organization`(`organization_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ADD CONSTRAINT `fk_facility_building_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ADD CONSTRAINT `fk_facility_unit_building_id` FOREIGN KEY (`building_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`building`(`building_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ADD CONSTRAINT `fk_facility_unit_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ADD CONSTRAINT `fk_facility_room_building_id` FOREIGN KEY (`building_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`building`(`building_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ADD CONSTRAINT `fk_facility_room_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ADD CONSTRAINT `fk_facility_room_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ADD CONSTRAINT `fk_facility_bed_building_id` FOREIGN KEY (`building_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`building`(`building_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ADD CONSTRAINT `fk_facility_bed_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ADD CONSTRAINT `fk_facility_bed_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ADD CONSTRAINT `fk_facility_bed_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ADD CONSTRAINT `fk_facility_bed_status_event_bed_id` FOREIGN KEY (`bed_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`bed`(`bed_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ADD CONSTRAINT `fk_facility_bed_status_event_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ADD CONSTRAINT `fk_facility_bed_status_event_environmental_service_request_id` FOREIGN KEY (`environmental_service_request_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`environmental_service_request`(`environmental_service_request_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ADD CONSTRAINT `fk_facility_bed_status_event_maintenance_order_id` FOREIGN KEY (`maintenance_order_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`maintenance_order`(`maintenance_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ADD CONSTRAINT `fk_facility_bed_status_event_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ADD CONSTRAINT `fk_facility_bed_status_event_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ADD CONSTRAINT `fk_facility_or_suite_building_id` FOREIGN KEY (`building_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`building`(`building_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ADD CONSTRAINT `fk_facility_or_suite_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ADD CONSTRAINT `fk_facility_or_suite_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ADD CONSTRAINT `fk_facility_equipment_asset_building_id` FOREIGN KEY (`building_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`building`(`building_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ADD CONSTRAINT `fk_facility_equipment_asset_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ADD CONSTRAINT `fk_facility_equipment_asset_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ADD CONSTRAINT `fk_facility_equipment_asset_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ADD CONSTRAINT `fk_facility_maintenance_order_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ADD CONSTRAINT `fk_facility_maintenance_order_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ADD CONSTRAINT `fk_facility_maintenance_order_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ADD CONSTRAINT `fk_facility_pm_schedule_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ADD CONSTRAINT `fk_facility_pm_schedule_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection` ADD CONSTRAINT `fk_facility_inspection_building_id` FOREIGN KEY (`building_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`building`(`building_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection` ADD CONSTRAINT `fk_facility_inspection_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ADD CONSTRAINT `fk_facility_inspection_finding_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`inspection`(`inspection_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ADD CONSTRAINT `fk_facility_inspection_finding_previous_finding_inspection_finding_id` FOREIGN KEY (`previous_finding_inspection_finding_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`inspection_finding`(`inspection_finding_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ADD CONSTRAINT `fk_facility_license_accreditation_building_id` FOREIGN KEY (`building_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`building`(`building_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ADD CONSTRAINT `fk_facility_license_accreditation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ADD CONSTRAINT `fk_facility_space_allocation_building_id` FOREIGN KEY (`building_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`building`(`building_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ADD CONSTRAINT `fk_facility_space_allocation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ADD CONSTRAINT `fk_facility_space_allocation_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ADD CONSTRAINT `fk_facility_space_allocation_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ADD CONSTRAINT `fk_facility_environmental_service_request_bed_id` FOREIGN KEY (`bed_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`bed`(`bed_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ADD CONSTRAINT `fk_facility_environmental_service_request_building_id` FOREIGN KEY (`building_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`building`(`building_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ADD CONSTRAINT `fk_facility_environmental_service_request_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ADD CONSTRAINT `fk_facility_environmental_service_request_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ADD CONSTRAINT `fk_facility_environmental_service_request_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ADD CONSTRAINT `fk_facility_capacity_snapshot_building_id` FOREIGN KEY (`building_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`building`(`building_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ADD CONSTRAINT `fk_facility_capacity_snapshot_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ADD CONSTRAINT `fk_facility_capacity_snapshot_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ADD CONSTRAINT `fk_facility_service_building_id` FOREIGN KEY (`building_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`building`(`building_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ADD CONSTRAINT `fk_facility_service_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ADD CONSTRAINT `fk_facility_service_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ADD CONSTRAINT `fk_facility_contract_building_id` FOREIGN KEY (`building_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`building`(`building_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ADD CONSTRAINT `fk_facility_contract_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ADD CONSTRAINT `fk_facility_hazardous_material_building_id` FOREIGN KEY (`building_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`building`(`building_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ADD CONSTRAINT `fk_facility_hazardous_material_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ADD CONSTRAINT `fk_facility_hazardous_material_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ADD CONSTRAINT `fk_facility_hazardous_material_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ADD CONSTRAINT `fk_facility_safety_incident_bed_id` FOREIGN KEY (`bed_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`bed`(`bed_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ADD CONSTRAINT `fk_facility_safety_incident_building_id` FOREIGN KEY (`building_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`building`(`building_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ADD CONSTRAINT `fk_facility_safety_incident_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ADD CONSTRAINT `fk_facility_safety_incident_room_id` FOREIGN KEY (`room_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`room`(`room_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ADD CONSTRAINT `fk_facility_safety_incident_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`unit`(`unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ADD CONSTRAINT `fk_facility_site_hierarchy_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`organization`(`organization_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ADD CONSTRAINT `fk_facility_site_hierarchy_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ADD CONSTRAINT `fk_facility_site_hierarchy_primary_care_site_id` FOREIGN KEY (`primary_care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ADD CONSTRAINT `fk_facility_network_contract_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ADD CONSTRAINT `fk_facility_facility_program_participation_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ADD CONSTRAINT `fk_facility_block_assignment_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ADD CONSTRAINT `fk_facility_block_assignment_or_suite_id` FOREIGN KEY (`or_suite_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`or_suite`(`or_suite_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ADD CONSTRAINT `fk_facility_block_assignment_service_id` FOREIGN KEY (`service_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`service`(`service_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ADD CONSTRAINT `fk_facility_equipment_authorization_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ADD CONSTRAINT `fk_facility_equipment_authorization_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ADD CONSTRAINT `fk_facility_organization_care_site_id` FOREIGN KEY (`care_site_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`care_site`(`care_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ADD CONSTRAINT `fk_facility_organization_parent_organization_id` FOREIGN KEY (`parent_organization_id`) REFERENCES `vibe_healthcare_v1`.`facility`.`organization`(`organization_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`facility` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`facility` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` SET TAGS ('pii_subdomain' = 'site_infrastructure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` SET TAGS ('pii_vibe_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site Identifier');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `parent_care_site_id` SET TAGS ('pii_business_glossary_term' = 'Parent Care Site');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_business_glossary_term' = 'NPI Registry Reference');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `accreditation_body` SET TAGS ('pii_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `accreditation_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Accreditation Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `accreditation_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `accreditation_status` SET TAGS ('pii_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `address_line_1` SET TAGS ('pii_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `address_line_1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `address_line_1` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `address_line_2` SET TAGS ('pii_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `address_line_2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `address_line_2` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `ccn` SET TAGS ('pii_business_glossary_term' = 'CMS Certification Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `city` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `closure_date` SET TAGS ('pii_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `county` SET TAGS ('pii_business_glossary_term' = 'County');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `critical_access_hospital` SET TAGS ('pii_business_glossary_term' = 'Critical Access Hospital Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `disproportionate_share_hospital` SET TAGS ('pii_business_glossary_term' = 'DSH Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `email_address` SET TAGS ('pii_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `email_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `email_address` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `emergency_services_available` SET TAGS ('pii_business_glossary_term' = 'Emergency Services Available');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `facility_type` SET TAGS ('pii_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `fax_number` SET TAGS ('pii_business_glossary_term' = 'Fax Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `fax_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `fax_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `fax_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `fax_number` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `go_live_date` SET TAGS ('pii_business_glossary_term' = 'Go Live Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `hierarchy_effective_date` SET TAGS ('pii_business_glossary_term' = 'Hierarchy Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `hierarchy_level` SET TAGS ('pii_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `latitude` SET TAGS ('pii_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `latitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `latitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `license_effective_date` SET TAGS ('pii_business_glossary_term' = 'License Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `license_effective_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `license_effective_date` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `license_expiration_date` SET TAGS ('pii_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `license_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `license_expiration_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `license_expiration_date` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `license_number` SET TAGS ('pii_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `license_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `license_number` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `licensed_bed_capacity` SET TAGS ('pii_business_glossary_term' = 'Licensed Bed Capacity');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `licensed_bed_capacity` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `licensed_bed_capacity` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `licensure_status` SET TAGS ('pii_business_glossary_term' = 'Licensure Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `longitude` SET TAGS ('pii_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `longitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `longitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `medicaid_provider_number` SET TAGS ('pii_business_glossary_term' = 'Medicaid Provider Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `medicare_provider_number` SET TAGS ('pii_business_glossary_term' = 'Medicare Provider Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `operational_status` SET TAGS ('pii_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `ownership_type` SET TAGS ('pii_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `phone_number` SET TAGS ('pii_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `phone_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `phone_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `phone_number` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `postal_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `postal_code` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `site_name` SET TAGS ('pii_business_glossary_term' = 'Site Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `site_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `site_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `site_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `site_npi` SET TAGS ('pii_business_glossary_term' = 'Site NPI');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `site_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `site_npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `sole_community_hospital` SET TAGS ('pii_business_glossary_term' = 'Sole Community Hospital Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `staffed_bed_capacity` SET TAGS ('pii_business_glossary_term' = 'Staffed Bed Capacity');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `staffed_bed_capacity` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `staffed_bed_capacity` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `state` SET TAGS ('pii_business_glossary_term' = 'State');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `teaching_status` SET TAGS ('pii_business_glossary_term' = 'Teaching Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `time_zone` SET TAGS ('pii_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `trauma_level` SET TAGS ('pii_business_glossary_term' = 'Trauma Level');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`care_site` ALTER COLUMN `website_url` SET TAGS ('pii_business_glossary_term' = 'Website URL');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` SET TAGS ('pii_subdomain' = 'site_infrastructure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` SET TAGS ('pii_vibe_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `building_id` SET TAGS ('pii_business_glossary_term' = 'Building Identifier');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `ada_compliant` SET TAGS ('pii_business_glossary_term' = 'ADA Compliant');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `address_line_1` SET TAGS ('pii_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `address_line_1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `address_line_1` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `address_line_2` SET TAGS ('pii_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `address_line_2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `address_line_2` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `annual_property_tax_amount` SET TAGS ('pii_business_glossary_term' = 'Annual Property Tax');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `building_type` SET TAGS ('pii_business_glossary_term' = 'Building Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `city` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `cms_certification_number` SET TAGS ('pii_business_glossary_term' = 'CMS Certification Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `building_code` SET TAGS ('pii_business_glossary_term' = 'Building Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `construction_year` SET TAGS ('pii_business_glossary_term' = 'Construction Year');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `electrical_service_capacity_kva` SET TAGS ('pii_business_glossary_term' = 'Electrical Capacity KVA');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `electrical_service_capacity_kva` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `electrical_service_capacity_kva` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `emergency_generator_capacity_kw` SET TAGS ('pii_business_glossary_term' = 'Generator Capacity KW');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `emergency_generator_capacity_kw` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `emergency_generator_capacity_kw` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `emergency_generator_coverage_type` SET TAGS ('pii_business_glossary_term' = 'Generator Coverage Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `facility_license_expiration_date` SET TAGS ('pii_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `facility_license_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `facility_license_expiration_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `facility_license_expiration_date` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `facility_license_number` SET TAGS ('pii_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `facility_license_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `facility_license_number` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `fire_safety_classification` SET TAGS ('pii_business_glossary_term' = 'Fire Safety Classification');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `gross_square_footage` SET TAGS ('pii_business_glossary_term' = 'Gross Square Footage');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `helipad_available` SET TAGS ('pii_business_glossary_term' = 'Helipad Available');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `hvac_system_type` SET TAGS ('pii_business_glossary_term' = 'HVAC System Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `insurance_policy_number` SET TAGS ('pii_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `insurance_policy_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `insurance_policy_number` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `joint_commission_accreditation_expiration_date` SET TAGS ('pii_business_glossary_term' = 'JC Accreditation Expiration');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `joint_commission_accreditation_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `joint_commission_accreditation_status` SET TAGS ('pii_business_glossary_term' = 'JC Accreditation Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `last_major_renovation_year` SET TAGS ('pii_business_glossary_term' = 'Last Renovation Year');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `latitude` SET TAGS ('pii_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `latitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `latitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `leed_certification_level` SET TAGS ('pii_business_glossary_term' = 'LEED Certification');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `longitude` SET TAGS ('pii_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `longitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `longitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `medical_gas_system_installed` SET TAGS ('pii_business_glossary_term' = 'Medical Gas System');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `medical_gas_system_installed` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `medical_gas_system_installed` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `building_name` SET TAGS ('pii_business_glossary_term' = 'Building Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `building_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `building_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `building_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `net_usable_square_footage` SET TAGS ('pii_business_glossary_term' = 'Net Usable Square Footage');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `number_of_elevators` SET TAGS ('pii_business_glossary_term' = 'Number of Elevators');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `number_of_floors` SET TAGS ('pii_business_glossary_term' = 'Number of Floors');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `operational_status` SET TAGS ('pii_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `ownership_type` SET TAGS ('pii_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `parking_spaces_count` SET TAGS ('pii_business_glossary_term' = 'Parking Spaces');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `postal_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `postal_code` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `property_tax_parcel_number` SET TAGS ('pii_business_glossary_term' = 'Parcel Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `replacement_value_amount` SET TAGS ('pii_business_glossary_term' = 'Replacement Value');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `seismic_zone` SET TAGS ('pii_business_glossary_term' = 'Seismic Zone');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `sprinkler_system_type` SET TAGS ('pii_business_glossary_term' = 'Sprinkler System Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `state_province` SET TAGS ('pii_business_glossary_term' = 'State/Province');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`building` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` SET TAGS ('pii_subdomain' = 'site_infrastructure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` SET TAGS ('pii_vibe_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `unit_id` SET TAGS ('pii_business_glossary_term' = 'Unit Identifier');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `building_id` SET TAGS ('pii_business_glossary_term' = 'Building Id');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `accepts_admissions` SET TAGS ('pii_business_glossary_term' = 'Accepts Admissions');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `accepts_transfers` SET TAGS ('pii_business_glossary_term' = 'Accepts Transfers');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `acuity_level` SET TAGS ('pii_business_glossary_term' = 'Acuity Level');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `age_restriction` SET TAGS ('pii_business_glossary_term' = 'Age Restriction');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `air_changes_per_hour` SET TAGS ('pii_business_glossary_term' = 'Air Changes Per Hour');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `bed_count` SET TAGS ('pii_business_glossary_term' = 'Bed Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `chest_pain_center_accreditation` SET TAGS ('pii_business_glossary_term' = 'Chest Pain Center Accreditation');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `unit_code` SET TAGS ('pii_business_glossary_term' = 'Unit Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `department_code` SET TAGS ('pii_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `electronic_health_record_system` SET TAGS ('pii_business_glossary_term' = 'EHR System');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `electronic_health_record_system` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `electronic_health_record_system` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `electronic_health_record_system` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `electronic_health_record_system` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `emergency_power_backup` SET TAGS ('pii_business_glossary_term' = 'Emergency Power Backup');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `floor_number` SET TAGS ('pii_business_glossary_term' = 'Floor Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `gender_restriction` SET TAGS ('pii_business_glossary_term' = 'Gender Restriction');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `gender_restriction` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `gender_restriction` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `gender_restriction` SET TAGS ('pii_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `hvac_system_type` SET TAGS ('pii_business_glossary_term' = 'HVAC System Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `infection_control_zone` SET TAGS ('pii_business_glossary_term' = 'Infection Control Zone');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `is_twenty_four_seven` SET TAGS ('pii_business_glossary_term' = '24/7 Operation');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `isolation_room_count` SET TAGS ('pii_business_glossary_term' = 'Isolation Room Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `licensed_bed_count` SET TAGS ('pii_business_glossary_term' = 'Licensed Bed Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `licensed_bed_count` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `licensed_bed_count` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `magnet_recognition` SET TAGS ('pii_business_glossary_term' = 'Magnet Recognition');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `medical_gas_system` SET TAGS ('pii_business_glossary_term' = 'Medical Gas System');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `medical_gas_system` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `medical_gas_system` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `unit_name` SET TAGS ('pii_business_glossary_term' = 'Unit Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `unit_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `unit_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `unit_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `negative_pressure_room_count` SET TAGS ('pii_business_glossary_term' = 'Negative Pressure Room Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `nurse_call_system_type` SET TAGS ('pii_business_glossary_term' = 'Nurse Call System');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `nurse_to_patient_ratio` SET TAGS ('pii_business_glossary_term' = 'Nurse to Patient Ratio');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `nurse_to_patient_ratio` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `nurse_to_patient_ratio` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `operational_hours_end` SET TAGS ('pii_business_glossary_term' = 'Operational Hours End');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `operational_hours_start` SET TAGS ('pii_business_glossary_term' = 'Operational Hours Start');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `revenue_center_code` SET TAGS ('pii_business_glossary_term' = 'Revenue Center Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `specialty_service_line` SET TAGS ('pii_business_glossary_term' = 'Specialty Service Line');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `square_footage` SET TAGS ('pii_business_glossary_term' = 'Square Footage');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `staffed_bed_count` SET TAGS ('pii_business_glossary_term' = 'Staffed Bed Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `stroke_center_designation` SET TAGS ('pii_business_glossary_term' = 'Stroke Center Designation');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `teaching_unit_flag` SET TAGS ('pii_business_glossary_term' = 'Teaching Unit Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `telemetry_monitoring_capability` SET TAGS ('pii_business_glossary_term' = 'Telemetry Capability');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `trauma_level` SET TAGS ('pii_business_glossary_term' = 'Trauma Level');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `unit_status` SET TAGS ('pii_business_glossary_term' = 'Unit Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `unit_type` SET TAGS ('pii_business_glossary_term' = 'Unit Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `vibe_added_flag` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`unit` ALTER COLUMN `wing_or_section` SET TAGS ('pii_business_glossary_term' = 'Wing or Section');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` SET TAGS ('pii_subdomain' = 'site_infrastructure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` SET TAGS ('pii_vibe_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `room_id` SET TAGS ('pii_business_glossary_term' = 'Room Identifier');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `building_id` SET TAGS ('pii_business_glossary_term' = 'Building Id');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `unit_id` SET TAGS ('pii_business_glossary_term' = 'Unit');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Org Unit');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `accreditation_status` SET TAGS ('pii_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `active_flag` SET TAGS ('pii_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `ada_compliant_flag` SET TAGS ('pii_business_glossary_term' = 'ADA Compliant');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `bariatric_capable_flag` SET TAGS ('pii_business_glossary_term' = 'Bariatric Capable');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `bed_count` SET TAGS ('pii_business_glossary_term' = 'Bed Count');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `boom_configuration` SET TAGS ('pii_business_glossary_term' = 'Boom Configuration');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `capacity` SET TAGS ('pii_business_glossary_term' = 'Capacity');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `capacity` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `capacity` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `class` SET TAGS ('pii_business_glossary_term' = 'Room Class');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `room_code` SET TAGS ('pii_business_glossary_term' = 'Room Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `effective_from_date` SET TAGS ('pii_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `effective_to_date` SET TAGS ('pii_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `emergency_power_flag` SET TAGS ('pii_business_glossary_term' = 'Emergency Power');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `hand_hygiene_station_count` SET TAGS ('pii_business_glossary_term' = 'Hand Hygiene Stations');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `hvac_air_exchange_rate` SET TAGS ('pii_business_glossary_term' = 'HVAC Air Exchange Rate');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `imaging_integration_flag` SET TAGS ('pii_business_glossary_term' = 'Imaging Integration');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `isolation_capable_flag` SET TAGS ('pii_business_glossary_term' = 'Isolation Capable');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `last_deep_clean_date` SET TAGS ('pii_business_glossary_term' = 'Last Deep Clean Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `last_inspection_date` SET TAGS ('pii_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `lease_ownership_indicator` SET TAGS ('pii_business_glossary_term' = 'Lease/Ownership');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `license_number` SET TAGS ('pii_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `license_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `license_number` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `medical_air_outlet_count` SET TAGS ('pii_business_glossary_term' = 'Medical Air Outlets');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `medical_air_outlet_count` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `medical_air_outlet_count` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `monthly_space_cost` SET TAGS ('pii_business_glossary_term' = 'Monthly Space Cost');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `room_name` SET TAGS ('pii_business_glossary_term' = 'Room Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `room_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `room_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `room_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `negative_pressure_flag` SET TAGS ('pii_business_glossary_term' = 'Negative Pressure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `next_scheduled_maintenance_date` SET TAGS ('pii_business_glossary_term' = 'Next Maintenance Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `nitrous_oxide_outlet_count` SET TAGS ('pii_business_glossary_term' = 'Nitrous Oxide Outlets');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `nurse_call_system_flag` SET TAGS ('pii_business_glossary_term' = 'Nurse Call System');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `occupancy_percentage` SET TAGS ('pii_business_glossary_term' = 'Occupancy Percentage');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `or_airflow_class` SET TAGS ('pii_business_glossary_term' = 'OR Airflow Class');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `oxygen_outlet_count` SET TAGS ('pii_business_glossary_term' = 'Oxygen Outlets');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `room_number` SET TAGS ('pii_business_glossary_term' = 'Room Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `room_status` SET TAGS ('pii_business_glossary_term' = 'Room Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `room_type` SET TAGS ('pii_business_glossary_term' = 'Room Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `square_footage` SET TAGS ('pii_business_glossary_term' = 'Square Footage');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `telemetry_capable_flag` SET TAGS ('pii_business_glossary_term' = 'Telemetry Capable');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `vacuum_outlet_count` SET TAGS ('pii_business_glossary_term' = 'Vacuum Outlets');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`room` ALTER COLUMN `ventilator_outlet_count` SET TAGS ('pii_business_glossary_term' = 'Ventilator Outlets');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` SET TAGS ('pii_subdomain' = 'site_infrastructure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` SET TAGS ('pii_vibe_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `bed_id` SET TAGS ('pii_business_glossary_term' = 'Bed Identifier');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `building_id` SET TAGS ('pii_business_glossary_term' = 'Building');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `room_id` SET TAGS ('pii_business_glossary_term' = 'Room');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `unit_id` SET TAGS ('pii_business_glossary_term' = 'Unit');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `age_restriction` SET TAGS ('pii_business_glossary_term' = 'Age Restriction');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `asset_tag` SET TAGS ('pii_business_glossary_term' = 'Asset Tag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `assignment_timestamp` SET TAGS ('pii_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `bed_status` SET TAGS ('pii_business_glossary_term' = 'Bed Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `bed_type` SET TAGS ('pii_business_glossary_term' = 'Bed Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `blocked_reason` SET TAGS ('pii_business_glossary_term' = 'Blocked Reason');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `bed_category` SET TAGS ('pii_business_glossary_term' = 'Bed Category');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `discharge_ready_timestamp` SET TAGS ('pii_business_glossary_term' = 'Discharge Ready Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `expected_available_timestamp` SET TAGS ('pii_business_glossary_term' = 'Expected Available');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `floor_number` SET TAGS ('pii_business_glossary_term' = 'Floor Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `gender_restriction` SET TAGS ('pii_business_glossary_term' = 'Gender Restriction');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `gender_restriction` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `gender_restriction` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `gender_restriction` SET TAGS ('pii_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Active');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `is_air_fluidized` SET TAGS ('pii_business_glossary_term' = 'Air Fluidized');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `is_bariatric_capable` SET TAGS ('pii_business_glossary_term' = 'Bariatric Capable');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `is_isolation_capable` SET TAGS ('pii_business_glossary_term' = 'Isolation Capable');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `is_licensed` SET TAGS ('pii_business_glossary_term' = 'Licensed');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `is_licensed` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `is_licensed` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `is_low_bed` SET TAGS ('pii_business_glossary_term' = 'Low Bed');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `is_negative_pressure_room` SET TAGS ('pii_business_glossary_term' = 'Negative Pressure Room');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `is_private_room` SET TAGS ('pii_business_glossary_term' = 'Private Room');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `is_staffed` SET TAGS ('pii_business_glossary_term' = 'Staffed');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `is_telemetry_capable` SET TAGS ('pii_business_glossary_term' = 'Telemetry Capable');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `label` SET TAGS ('pii_business_glossary_term' = 'Bed Label');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `last_cleaned_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Cleaned');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `last_maintenance_date` SET TAGS ('pii_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `next_maintenance_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Maintenance Due');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `out_of_service_reason` SET TAGS ('pii_business_glossary_term' = 'Out of Service Reason');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `position` SET TAGS ('pii_business_glossary_term' = 'Position');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `status_timestamp` SET TAGS ('pii_business_glossary_term' = 'Status Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `weight_capacity_lbs` SET TAGS ('pii_business_glossary_term' = 'Weight Capacity');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `weight_capacity_lbs` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed` ALTER COLUMN `weight_capacity_lbs` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` SET TAGS ('pii_subdomain' = 'capacity_operations');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` SET TAGS ('pii_vibe_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `bed_status_event_id` SET TAGS ('pii_business_glossary_term' = 'Bed Status Event ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `bed_id` SET TAGS ('pii_business_glossary_term' = 'Bed');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `environmental_service_request_id` SET TAGS ('pii_business_glossary_term' = 'EVS Request');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `maintenance_order_id` SET TAGS ('pii_business_glossary_term' = 'Maintenance Order');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Patient');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `unit_id` SET TAGS ('pii_business_glossary_term' = 'Unit');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `room_id` SET TAGS ('pii_business_glossary_term' = 'Room');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Visit');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `actual_availability_timestamp` SET TAGS ('pii_business_glossary_term' = 'Actual Availability');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `acuity_level` SET TAGS ('pii_business_glossary_term' = 'Acuity Level');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `adt_event_type` SET TAGS ('pii_business_glossary_term' = 'ADT Event Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `bed_assignment_method` SET TAGS ('pii_business_glossary_term' = 'Assignment Method');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `blocked_reason_category` SET TAGS ('pii_business_glossary_term' = 'Blocked Reason Category');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Duration Minutes');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `event_sequence_number` SET TAGS ('pii_business_glossary_term' = 'Event Sequence');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `event_timestamp` SET TAGS ('pii_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `expected_availability_timestamp` SET TAGS ('pii_business_glossary_term' = 'Expected Availability');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `initiating_user_role` SET TAGS ('pii_business_glossary_term' = 'Initiating User Role');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `is_elective_flag` SET TAGS ('pii_business_glossary_term' = 'Elective Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `is_emergency_flag` SET TAGS ('pii_business_glossary_term' = 'Emergency Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `isolation_type` SET TAGS ('pii_business_glossary_term' = 'Isolation Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `new_status_code` SET TAGS ('pii_business_glossary_term' = 'New Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `prior_status_code` SET TAGS ('pii_business_glossary_term' = 'Prior Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `priority_flag` SET TAGS ('pii_business_glossary_term' = 'Priority Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `reason_code` SET TAGS ('pii_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `reason_description` SET TAGS ('pii_business_glossary_term' = 'Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `source_system_event_code` SET TAGS ('pii_business_glossary_term' = 'Source Event Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`bed_status_event` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` SET TAGS ('pii_subdomain' = 'site_infrastructure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` SET TAGS ('pii_vibe_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `or_suite_id` SET TAGS ('pii_business_glossary_term' = 'OR Suite Identifier');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `building_id` SET TAGS ('pii_business_glossary_term' = 'Building');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `unit_id` SET TAGS ('pii_business_glossary_term' = 'Unit');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `accreditation_status` SET TAGS ('pii_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `anesthesia_machine_model` SET TAGS ('pii_business_glossary_term' = 'Anesthesia Machine Model');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `boom_configuration` SET TAGS ('pii_business_glossary_term' = 'Boom Configuration');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `capacity` SET TAGS ('pii_business_glossary_term' = 'Capacity');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `capacity` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `capacity` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `emergency_power_backup_flag` SET TAGS ('pii_business_glossary_term' = 'Emergency Power Backup');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `emergency_use_flag` SET TAGS ('pii_business_glossary_term' = 'Emergency Use');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `equipment_inventory_list` SET TAGS ('pii_business_glossary_term' = 'Equipment Inventory');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `fire_suppression_system_type` SET TAGS ('pii_business_glossary_term' = 'Fire Suppression');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `hvac_air_exchange_rate_per_hour` SET TAGS ('pii_business_glossary_term' = 'Air Exchange Rate');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `imaging_integration_type` SET TAGS ('pii_business_glossary_term' = 'Imaging Integration');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `isolation_capable_flag` SET TAGS ('pii_business_glossary_term' = 'Isolation Capable');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `laminar_airflow_class` SET TAGS ('pii_business_glossary_term' = 'Laminar Airflow Class');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `last_accreditation_survey_date` SET TAGS ('pii_business_glossary_term' = 'Last Survey Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `last_maintenance_date` SET TAGS ('pii_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `license_expiration_date` SET TAGS ('pii_business_glossary_term' = 'License Expiration');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `license_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `license_expiration_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `license_expiration_date` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `license_number` SET TAGS ('pii_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `license_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `license_number` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `medical_gas_outlets_count` SET TAGS ('pii_business_glossary_term' = 'Medical Gas Outlets');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `medical_gas_outlets_count` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `medical_gas_outlets_count` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `next_accreditation_survey_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Survey Due');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `next_maintenance_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Maintenance Due');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `operational_status` SET TAGS ('pii_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `or_name` SET TAGS ('pii_business_glossary_term' = 'OR Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `or_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `or_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `or_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `or_number` SET TAGS ('pii_business_glossary_term' = 'OR Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `or_type` SET TAGS ('pii_business_glossary_term' = 'OR Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `pediatric_capable_flag` SET TAGS ('pii_business_glossary_term' = 'Pediatric Capable');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `positive_pressure_maintained_flag` SET TAGS ('pii_business_glossary_term' = 'Positive Pressure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `robotic_surgery_compatible_flag` SET TAGS ('pii_business_glossary_term' = 'Robotic Surgery Compatible');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `room_height_feet` SET TAGS ('pii_business_glossary_term' = 'Room Height');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `room_length_feet` SET TAGS ('pii_business_glossary_term' = 'Room Length');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `room_width_feet` SET TAGS ('pii_business_glossary_term' = 'Room Width');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `scheduled_maintenance_window` SET TAGS ('pii_business_glossary_term' = 'Maintenance Window');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `or_suite_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `status_effective_timestamp` SET TAGS ('pii_business_glossary_term' = 'Status Effective');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `status_reason_code` SET TAGS ('pii_business_glossary_term' = 'Status Reason');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `suite_code` SET TAGS ('pii_business_glossary_term' = 'Suite Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `suite_name` SET TAGS ('pii_business_glossary_term' = 'Suite Name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `suite_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `suite_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `suite_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `suite_type` SET TAGS ('pii_business_glossary_term' = 'Suite Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `surgical_table_type` SET TAGS ('pii_business_glossary_term' = 'Surgical Table Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`or_suite` ALTER COLUMN `video_integration_capability_flag` SET TAGS ('pii_business_glossary_term' = 'Video Integration');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` SET TAGS ('pii_subdomain' = 'equipment_maintenance');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` SET TAGS ('pii_vibe_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `equipment_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `equipment_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `equipment_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `last_calibration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `next_calibration_due_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `service_contract_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_asset` ALTER COLUMN `warranty_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` SET TAGS ('pii_subdomain' = 'equipment_maintenance');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` SET TAGS ('pii_vibe_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `tertiary_maintenance_approved_by_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `tertiary_maintenance_approved_by_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `completed_date` SET TAGS ('pii_business_glossary_term' = 'Completed Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `cost_amount` SET TAGS ('pii_business_glossary_term' = 'Cost Amount');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `regulatory_driver` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `regulatory_driver` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `requested_date` SET TAGS ('pii_business_glossary_term' = 'Requested Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `scheduled_date` SET TAGS ('pii_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`maintenance_order` ALTER COLUMN `maintenance_order_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` SET TAGS ('pii_subdomain' = 'equipment_maintenance');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` SET TAGS ('pii_vibe_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `auto_generate_work_order` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `frequency_days` SET TAGS ('pii_business_glossary_term' = 'Frequency Days');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `last_performed_date` SET TAGS ('pii_business_glossary_term' = 'Last Performed Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `regulatory_driver` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `regulatory_driver` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `schedule_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `schedule_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `schedule_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `schedule_type` SET TAGS ('pii_business_glossary_term' = 'Schedule Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `pm_schedule_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`pm_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection` SET TAGS ('pii_subdomain' = 'compliance_safety');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection` SET TAGS ('pii_vibe_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection` ALTER COLUMN `coordinator_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection` ALTER COLUMN `coordinator_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection` ALTER COLUMN `inspector_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection` ALTER COLUMN `inspector_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection` ALTER COLUMN `observation_count` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection` ALTER COLUMN `observation_count` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` SET TAGS ('pii_subdomain' = 'compliance_safety');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` SET TAGS ('pii_vibe_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `affected_patient_count` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `affected_patient_count` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `corrective_action_owner_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `corrective_action_owner_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `finding_code` SET TAGS ('pii_business_glossary_term' = 'Finding Code');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `inspector_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `inspector_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `patient_safety_impact_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `patient_safety_impact_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `resolved_date` SET TAGS ('pii_business_glossary_term' = 'Resolved Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `severity` SET TAGS ('pii_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `inspection_finding_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `verified_by_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `verified_by_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`inspection_finding` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` SET TAGS ('pii_subdomain' = 'compliance_safety');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` SET TAGS ('pii_vibe_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `license_accreditation_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `license_accreditation_id` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `bed_capacity_authorized` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `bed_capacity_authorized` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `credential_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `credential_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `credential_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `license_number` SET TAGS ('pii_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `license_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `license_number` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `license_type` SET TAGS ('pii_business_glossary_term' = 'License Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `license_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `license_type` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `license_accreditation_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `license_accreditation_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `license_accreditation_status` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`license_accreditation` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` SET TAGS ('pii_subdomain' = 'site_infrastructure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` SET TAGS ('pii_vibe_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `allocation_type` SET TAGS ('pii_business_glossary_term' = 'Allocation Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `square_footage` SET TAGS ('pii_business_glossary_term' = 'Square Footage');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`space_allocation` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` SET TAGS ('pii_subdomain' = 'capacity_operations');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` SET TAGS ('pii_vibe_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `primary_environmental_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `primary_environmental_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `tertiary_environmental_cancelled_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `tertiary_environmental_cancelled_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `patient_discharge_timestamp` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `patient_discharge_timestamp` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`environmental_service_request` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` SET TAGS ('pii_subdomain' = 'capacity_operations');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` SET TAGS ('pii_vibe_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `capacity_snapshot_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `capacity_snapshot_id` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `observation_beds_available` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `observation_beds_available` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `total_licensed_beds` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `total_licensed_beds` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`capacity_snapshot` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` SET TAGS ('pii_subdomain' = 'vendor_contracting');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` SET TAGS ('pii_vibe_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `clinician_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `clinician_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `accreditation_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `license_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `license_expiration_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `license_expiration_date` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `license_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `license_number` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `license_required_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `license_required_flag` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `service_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `service_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `service_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `patient_access_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `patient_access_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `patient_access_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `patient_access_phone` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `service_type` SET TAGS ('pii_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`service` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` SET TAGS ('pii_subdomain' = 'vendor_contracting');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` SET TAGS ('pii_vibe_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `insurance_certificate_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `insurance_certificate_expiration_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `insurance_certificate_expiration_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `insurance_requirement_description` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `insurance_requirement_description` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `contract_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `contract_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `contract_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `owner_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `owner_email` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `owner_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `owner_name` SET TAGS ('pii_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `owner_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `owner_name` SET TAGS ('pii_category' = 'person_name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `owner_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `owner_name` SET TAGS ('pii_type' = 'person_name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `owner_name` SET TAGS ('pii_classification' = 'person_name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `owner_name` SET TAGS ('pii_mask_nonprod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `owner_name` SET TAGS ('pii_subtype' = 'person_name');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `owner_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `owner_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `owner_phone` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `vendor_contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `vendor_contact_email` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `vendor_contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `vendor_contact_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `vendor_contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `vendor_contact_phone` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `vibe_added_flag` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`contract` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` SET TAGS ('pii_subdomain' = 'compliance_safety');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` SET TAGS ('pii_vibe_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `chemical_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `chemical_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `chemical_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `infectious_agent_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `infectious_agent_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `infectious_agent_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `material_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `material_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `material_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `permit_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `responsible_person_contact` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `responsible_person_contact` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `responsible_person_contact` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `responsible_person_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `responsible_person_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`hazardous_material` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` SET TAGS ('pii_subdomain' = 'compliance_safety');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` SET TAGS ('pii_vibe_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `safety_incident_description` SET TAGS ('pii_business_glossary_term' = 'Description');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `incident_date` SET TAGS ('pii_business_glossary_term' = 'Incident Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `involved_person_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `involved_person_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `patient_involved_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `patient_involved_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `reported_by` SET TAGS ('pii_business_glossary_term' = 'Reported By');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `severity` SET TAGS ('pii_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `safety_incident_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `witness_names` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`safety_incident` ALTER COLUMN `witness_names` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` SET TAGS ('pii_subdomain' = 'site_infrastructure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` SET TAGS ('pii_vibe_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `hierarchy_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `hierarchy_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `hierarchy_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `hierarchy_path` SET TAGS ('pii_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `region_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `region_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `region_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`site_hierarchy` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` SET TAGS ('pii_subdomain' = 'vendor_contracting');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` SET TAGS ('pii_association_edges' = 'facility.care_site,insurance.payer');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` SET TAGS ('pii_vibe_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `contract_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `contract_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `contract_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `contract_value` SET TAGS ('pii_business_glossary_term' = 'Contract Value');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `network_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `network_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `network_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `owner_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `owner_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `network_contract_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`network_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` SET TAGS ('pii_subdomain' = 'vendor_contracting');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` SET TAGS ('pii_association_edges' = 'facility.care_site,quality.quality_program');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` SET TAGS ('pii_vibe_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Program Participation - Health Plan Id');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `health_plan_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `health_plan_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `created_date` SET TAGS ('pii_business_glossary_term' = 'Record Created Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Participation Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `enrollment_count_at_participation` SET TAGS ('pii_business_glossary_term' = 'Enrollment Count at Participation');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `last_submission_date` SET TAGS ('pii_business_glossary_term' = 'Last Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `measure_set_version` SET TAGS ('pii_business_glossary_term' = 'Plan Measure Set Version');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `participation_type` SET TAGS ('pii_business_glossary_term' = 'Participation Type');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `performance_score` SET TAGS ('pii_business_glossary_term' = 'Plan Performance Score');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `program_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `program_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `program_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `quality_program_participation_status` SET TAGS ('pii_business_glossary_term' = 'Program Participation Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Plan Reporting Frequency');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `ssot_canonical_reference` SET TAGS ('pii_business_glossary_term' = 'SSOT Canonical Reference');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `ssot_canonical_reference` SET TAGS ('pii_ssot_canonical' = 'quality.quality_program_participation');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `ssot_reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'SSOT Reconciliation Status');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `ssot_reconciliation_status` SET TAGS ('pii_ssot_status' = 'consolidated_to_canonical');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `submission_method` SET TAGS ('pii_business_glossary_term' = 'Plan Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Participation Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `updated_date` SET TAGS ('pii_business_glossary_term' = 'Record Updated Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`facility_program_participation` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` SET TAGS ('pii_subdomain' = 'capacity_operations');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` SET TAGS ('pii_association_edges' = 'facility.or_suite,workforce.employee');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` SET TAGS ('pii_vibe_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ALTER COLUMN `block_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ALTER COLUMN `block_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ALTER COLUMN `block_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ALTER COLUMN `release_deadline_hours` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ALTER COLUMN `release_deadline_hours` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`block_assignment` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` SET TAGS ('pii_subdomain' = 'equipment_maintenance');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` SET TAGS ('pii_association_edges' = 'facility.equipment_asset,workforce.employee');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` SET TAGS ('pii_vibe_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ALTER COLUMN `equipment_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ALTER COLUMN `equipment_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ALTER COLUMN `expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ALTER COLUMN `training_program_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ALTER COLUMN `training_program_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ALTER COLUMN `training_program_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`equipment_authorization` ALTER COLUMN `vibe_mutation_timestamp` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` SET TAGS ('pii_subdomain' = 'site_infrastructure');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` SET TAGS ('pii_domain' = 'facility');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` SET TAGS ('pii_vibe_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `address_line_1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `address_line_1` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `address_line_2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `address_line_2` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `city` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `dba_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `dba_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `dba_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `email_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `email_address` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `fax_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `fax_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `fax_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `fax_number` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `organization_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `organization_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `organization_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `phone_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `phone_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `phone_number` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `postal_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `postal_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `postal_code` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_business_glossary_term' = 'Tax ID');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `tax_identification_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`facility`.`organization` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
