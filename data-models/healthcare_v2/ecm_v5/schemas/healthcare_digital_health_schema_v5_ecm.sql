-- Schema for Domain: digital_health | Business:  | Version: v5_ecm
-- Generated on: 2026-05-21 09:45:13

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `healthcare_ecm_v1`.`digital_health` COMMENT 'Captures patient‑engagement data including remote patient monitoring device/sensor readings, RPM program enrollment with alert thresholds, patient‑reported outcome measures (PROMs), and patient portal interaction metrics.';

-- ========= TABLES =========
CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`digital_health`.`rpm_device_readings` (
    `rpm_device_readings_id` BIGINT COMMENT 'Primary key for rpm_device_readings',
    `device_id` BIGINT COMMENT 'Identifier of the remote patient monitoring device that generated this reading.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient from whom this device reading was captured.',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider who ordered the RPM monitoring that generated this reading.',
    `rpm_enrollment_id` BIGINT COMMENT 'Identifier of the RPM program enrollment under which this reading was captured.',
    `rpm_reviewing_provider_clinician_id` BIGINT COMMENT 'Identifier of the clinical provider who reviewed and acknowledged this reading.',
    `visit_id` BIGINT COMMENT 'Identifier of the associated clinical encounter if this reading is linked to a specific telehealth or in-person visit.',
    `alert_severity` STRING COMMENT 'Severity level of the alert triggered by this reading, used for clinical triage and escalation workflows.',
    `alert_triggered` BOOLEAN COMMENT 'Indicates whether this reading triggered a clinical alert based on the patients configured threshold parameters in the RPM program.',
    `battery_level_percent` STRING COMMENT 'Battery charge level of the device at the time of reading capture, used for proactive device maintenance and data reliability assessment.',
    `body_position` STRING COMMENT 'Patient body position during measurement capture, which can significantly affect readings such as blood pressure.',
    `body_site` STRING COMMENT 'Anatomical location where the measurement was taken (e.g., left arm, right index finger, oral, axillary, tympanic).',
    `data_quality_flag` STRING COMMENT 'Indicator of the quality and reliability of the captured reading based on device diagnostics and signal analysis.',
    `device_model` STRING COMMENT 'Model name or number of the RPM device that generated this reading.',
    `device_serial_number` STRING COMMENT 'Manufacturer serial number of the specific device that captured this reading, used for device tracking and recall management.',
    `external_reading_code` STRING COMMENT 'Unique identifier assigned to this reading by the originating RPM device platform, used for deduplication and source traceability.',
    `firmware_version` STRING COMMENT 'Version of the device firmware at the time the reading was captured, important for data quality assessment and device management.',
    `hipaa_retention_expiry_date` DATE COMMENT 'Date after which this record may be purged per HIPAA medical record retention requirements (typically 6 years from creation or last access).',
    `interpretation_code` STRING COMMENT 'Clinical interpretation of the reading value relative to reference ranges (normal, abnormal, critically high/low).',
    `is_patient_reported` BOOLEAN COMMENT 'Indicates whether this reading was manually entered by the patient rather than automatically captured by the device.',
    `measurement_context` STRING COMMENT 'Clinical context or condition under which the measurement was taken, important for proper interpretation of results.',
    `notes` STRING COMMENT 'Free-text clinical notes or patient-provided context associated with this reading (e.g., patient felt dizzy, took medication 30 minutes prior).',
    `numeric_value` DECIMAL(18,2) COMMENT 'The primary numeric measurement value captured by the device (e.g., 72 for heart rate BPM, 120 for systolic mmHg, 98.6 for temperature).',
    `observation_code` STRING COMMENT 'The LOINC code identifying the specific clinical observation or measurement type (e.g., 8867-4 for heart rate, 2339-0 for glucose).',
    `observation_display_name` STRING COMMENT 'Human-readable display name for the observation code (e.g., Heart Rate, Blood Glucose, Systolic Blood Pressure).',
    `reading_status` STRING COMMENT 'Current status of the device reading in its lifecycle, indicating whether the reading has been validated, is preliminary, or has been corrected.',
    `reading_timestamp` TIMESTAMP COMMENT 'The date and time when the device measurement was actually taken by the sensor or device at the patient location.',
    `reading_type` STRING COMMENT 'High-level classification of the type of physiological measurement captured by the device. [ENUM-REF-CANDIDATE: vital_sign|glucose|weight|activity|sleep|oxygen_saturation|blood_pressure|heart_rate|temperature|respiratory_rate|peak_flow|ecg — promote to reference product]',
    `received_timestamp` TIMESTAMP COMMENT 'The date and time when the reading was received by the healthcare system platform from the device transmission.',
    `reference_range_high` DECIMAL(18,2) COMMENT 'Upper bound of the clinically normal reference range for this observation type, specific to the patients demographics.',
    `reference_range_low` DECIMAL(18,2) COMMENT 'Lower bound of the clinically normal reference range for this observation type, specific to the patients demographics.',
    `reviewed_timestamp` TIMESTAMP COMMENT 'Date and time when a clinical provider reviewed this reading, important for CMS billing compliance (CPT 99457 requires interactive communication).',
    `secondary_numeric_value` DECIMAL(18,2) COMMENT 'Secondary numeric measurement value for compound readings (e.g., diastolic blood pressure of 80 when primary is systolic 120, or post-meal glucose paired with fasting glucose).',
    `sensor_type` STRING COMMENT 'Type of sensor used to capture the measurement (e.g., pulse oximeter, glucometer, sphygmomanometer, thermometer, accelerometer, ECG lead).',
    `signal_strength` STRING COMMENT 'Signal strength indicator (e.g., RSSI in dBm) at the time of data transmission from device to gateway, affecting data reliability.',
    `source_system` STRING COMMENT 'Name of the RPM platform or integration system that transmitted this reading to the data warehouse (e.g., Vivify Health, BioTelemetry, Philips eCareCoordinator).',
    `string_value` DECIMAL(18,2) COMMENT 'Non-numeric observation value for readings that produce categorical or textual results (e.g., ECG rhythm classification, sleep stage label).',
    `threshold_high_value` DECIMAL(18,2) COMMENT 'The upper threshold limit that was active at the time of this reading, used to determine if the reading exceeded normal parameters.',
    `threshold_low_value` DECIMAL(18,2) COMMENT 'The lower threshold limit that was active at the time of this reading, used to determine if the reading fell below normal parameters.',
    `transmission_latency_seconds` STRING COMMENT 'Time difference in seconds between when the reading was captured on the device and when it was received by the platform, used for monitoring connectivity issues.',
    `transmission_method` STRING COMMENT 'Communication protocol used to transmit the reading from the device to the receiving platform.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the numeric reading value expressed in UCUM (Unified Code for Units of Measure) format (e.g., bpm, mmHg, mg/dL, kg, °F, %).',
    CONSTRAINT pk_rpm_device_readings PRIMARY KEY(`rpm_device_readings_id`)
) COMMENT 'Deprecated placeholder - use digital_health.rpm_reading instead';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`digital_health`.`prom_responses` (
    `prom_responses_id` BIGINT COMMENT 'Primary key for prom_responses',
    `clinician_id` BIGINT COMMENT 'Identifier of the ordering or responsible provider who requested the PROM assessment.',
    `episode_of_care_visit_id` BIGINT COMMENT 'Identifier linking this PROM response to a specific episode of care for longitudinal outcome tracking.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient who submitted the PROM response.',
    `prom_questionnaire_id` BIGINT COMMENT 'Foreign key linking to digital_health.prom_questionnaire. Business justification: prom_responses (deprecated) currently has only a self-reference and no in-domain FK. Adding prom_questionnaire_id connects it to the PROM questionnaire master. The instrument_code and instrument_versi',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter associated with this PROM response, if collected during a visit.',
    `administration_date` DATE COMMENT 'Clinical date on which the PROM was administered, which may differ from submission date for paper-based or delayed entries.',
    `alert_triggered` BOOLEAN COMMENT 'Indicates whether the PROM score triggered a clinical alert or notification to the care team based on predefined thresholds.',
    `assisted_by` STRING COMMENT 'Indicates who assisted the patient in completing the PROM, relevant for data quality and proxy response identification.',
    `change_from_baseline` DECIMAL(18,2) COMMENT 'Difference between this responses total score and the patients baseline score for the same instrument, indicating clinical improvement or decline.',
    `clinical_context` STRING COMMENT 'Clinical timing context in which the PROM was administered relative to the patients care episode.',
    `clinically_meaningful_change` BOOLEAN COMMENT 'Indicates whether the change from baseline exceeds the minimally important difference (MID) threshold for the instrument.',
    `collection_method` STRING COMMENT 'Method by which the PROM response was collected from the patient.',
    `completion_duration_seconds` STRING COMMENT 'Total time in seconds the patient spent completing the PROM questionnaire from start to submission.',
    `condition_code` STRING COMMENT 'ICD-10-CM diagnosis code for the condition being assessed by this PROM, enabling condition-specific outcome analysis.',
    `domain_category` STRING COMMENT 'Health domain measured by this response (e.g., physical function, pain interference, mental health, fatigue, social participation). [ENUM-REF-CANDIDATE: physical_function|pain_interference|mental_health|fatigue|social_participation|sleep_disturbance|anxiety|depression|global_health — promote to reference product]',
    `external_questionnaire_code` STRING COMMENT 'Identifier from the source system linking this response to the specific questionnaire instance or session.',
    `is_baseline` BOOLEAN COMMENT 'Indicates whether this response represents the baseline measurement for the patients treatment episode.',
    `items_administered` STRING COMMENT 'Number of individual questionnaire items presented to and answered by the patient in this session.',
    `items_completed` STRING COMMENT 'Number of items the patient actually completed, used to assess response completeness.',
    `language_code` STRING COMMENT 'ISO 639-1 language code indicating the language in which the PROM was administered to the patient.',
    `raw_score` DECIMAL(18,2) COMMENT 'Sum of individual item responses before any standardization or T-score conversion.',
    `response_status` STRING COMMENT 'Current lifecycle status of the PROM response submission.',
    `review_timestamp` TIMESTAMP COMMENT 'Date and time when the responsible provider reviewed and acknowledged the PROM response.',
    `reviewed_by_provider` BOOLEAN COMMENT 'Indicates whether a clinician has reviewed this PROM response and acknowledged the results.',
    `scoring_algorithm` STRING COMMENT 'Name or identifier of the scoring algorithm applied to compute the total score (e.g., IRT, summative, weighted).',
    `severity_level` STRING COMMENT 'Clinically interpreted severity category derived from the total score based on validated instrument cut-points.',
    `source_system` STRING COMMENT 'Originating system from which the PROM response was captured (e.g., Epic MyChart, Cerner HealtheLife, custom patient portal).',
    `standard_error` DECIMAL(18,2) COMMENT 'Standard error associated with the computed score, indicating measurement precision for CAT-administered instruments.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the patient submitted the completed PROM questionnaire.',
    `total_score` DECIMAL(18,2) COMMENT 'Final standardized score (e.g., T-score with mean 50 and SD 10 for PROMIS instruments) representing the patients measured outcome.',
    CONSTRAINT pk_prom_responses PRIMARY KEY(`prom_responses_id`)
) COMMENT 'Deprecated placeholder - use digital_health.prom_response instead';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`digital_health`.`portal_engagement_events` (
    `portal_engagement_events_id` BIGINT COMMENT 'Primary key for portal_engagement_events',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility context in which the portal event occurred.',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider involved in the portal interaction such as message recipient or appointment scheduler.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient who performed the portal interaction.',
    `phi_access_log_id` BIGINT COMMENT 'Unique identifier linking this portal event to the HIPAA-required access audit log for PHI disclosure tracking.',
    `proxy_access_id` BIGINT COMMENT 'Identifier of the authorized proxy user who performed the action on behalf of the patient, if proxy access was used.',
    `consent_session_id` BIGINT COMMENT 'Unique session identifier linking multiple events within a single patient portal login session.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter associated with this portal event, if applicable.',
    `accessibility_mode_flag` BOOLEAN COMMENT 'Indicates whether the patient was using accessibility features (screen reader, high contrast, large text) during this portal event.',
    `action_detail` STRING COMMENT 'Descriptive detail of the specific action taken within the event type, such as the specific lab test viewed or message subject category.',
    `authentication_method` STRING COMMENT 'Method used by the patient to authenticate into the portal for this session.',
    `browser_or_app_version` STRING COMMENT 'Version of the web browser or mobile application used for the portal interaction.',
    `content_reference` STRING COMMENT 'Identifier of the specific content item accessed during the event, such as a lab result ID, message thread ID, or educational material ID.',
    `content_type` STRING COMMENT 'Type of clinical or administrative content accessed or interacted with during the portal event. [ENUM-REF-CANDIDATE: lab_result|radiology_report|clinical_note|medication_list|immunization_record|billing_statement|discharge_summary|care_plan|allergy_list|vital_signs|referral|prescription — promote to reference product]',
    `data_download_flag` BOOLEAN COMMENT 'Indicates whether the patient downloaded health data during this event, relevant to Meaningful Use and information blocking compliance.',
    `device_type` STRING COMMENT 'Type of device used by the patient to access the portal during this event.',
    `download_format` STRING COMMENT 'File format of the data downloaded by the patient during this portal event.',
    `duration_seconds` STRING COMMENT 'Time in seconds the patient spent on this specific portal engagement action or page view.',
    `error_code` STRING COMMENT 'System error code captured when the portal event resulted in a failure or timeout, used for technical support and UX improvement.',
    `error_message` STRING COMMENT 'Human-readable error message displayed to the patient when the event failed, supporting troubleshooting and user experience analysis.',
    `event_category` STRING COMMENT 'High-level functional category grouping the portal event for analytics and reporting purposes.',
    `event_channel` STRING COMMENT 'Digital channel or interface through which the patient accessed the portal for this event.',
    `event_status` STRING COMMENT 'Outcome status indicating whether the portal engagement action was successfully completed.',
    `event_timestamp` TIMESTAMP COMMENT 'Exact date and time when the patient portal engagement event occurred.',
    `event_type` STRING COMMENT 'Classification of the portal engagement action performed by the patient. [ENUM-REF-CANDIDATE: login|logout|message_sent|message_read|appointment_scheduled|appointment_cancelled|lab_result_viewed|medication_refill|document_download|bill_payment|health_record_access|proxy_access|form_submission|video_visit_joined|education_viewed — promote to reference product]',
    `geolocation_region` STRING COMMENT 'Geographic region or state derived from the access location, used for access pattern analytics without storing precise coordinates.',
    `ip_address` STRING COMMENT 'IP address from which the patient accessed the portal, used for security auditing and fraud detection.',
    `is_first_time_action` BOOLEAN COMMENT 'Indicates whether this is the first time the patient has performed this specific type of action on the portal, useful for adoption tracking.',
    `language_preference` STRING COMMENT 'Language in which the portal was displayed during this event, in ISO 639-1 format with optional region code.',
    `message_recipient_type` STRING COMMENT 'Category of the recipient when the event involves sending a portal message.',
    `notification_reference` STRING COMMENT 'Identifier of the notification or alert that triggered this portal visit, linking engagement back to outreach campaigns.',
    `operating_system` STRING COMMENT 'Operating system of the device used for the portal interaction.',
    `page_or_section_name` STRING COMMENT 'Name of the specific portal page, module, or section where the engagement event took place.',
    `phi_accessed_flag` BOOLEAN COMMENT 'Indicates whether the portal event involved viewing or downloading Protected Health Information, triggering HIPAA audit requirements.',
    `portal_version` STRING COMMENT 'Version of the patient portal application at the time of the event, supporting A/B testing and feature rollout analysis.',
    `proxy_access_flag` BOOLEAN COMMENT 'Indicates whether this portal event was performed by an authorized proxy (caregiver, guardian, or legal representative) on behalf of the patient.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this portal engagement event record was first captured in the data platform.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this portal engagement event record was last modified in the data platform.',
    `referral_source` STRING COMMENT 'Source or trigger that prompted the patient to engage with the portal for this event.',
    `satisfaction_rating` STRING COMMENT 'Patient-provided satisfaction rating for the portal interaction on a 1-5 scale, captured via optional post-action survey.',
    `source_event_reference` STRING COMMENT 'Original event identifier from the source patient portal system for traceability and deduplication.',
    `source_system` STRING COMMENT 'Name of the EHR or portal system that generated this engagement event record, such as Epic MyChart or Cerner HealtheLife.',
    CONSTRAINT pk_portal_engagement_events PRIMARY KEY(`portal_engagement_events_id`)
) COMMENT 'Deprecated placeholder - use digital_health.portal_engagement_event instead';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`digital_health`.`digital_health_patient_engagement` (
    `digital_health_patient_engagement_id` BIGINT COMMENT 'Primary key for digital_health_patient_engagement',
    `mpi_record_id` BIGINT COMMENT 'description',
    `portal_account_id` BIGINT COMMENT 'description',
    `action_taken` STRING COMMENT 'description',
    `app_version` STRING COMMENT 'description',
    `content_category` STRING COMMENT 'description',
    `created_at` TIMESTAMP COMMENT 'description',
    `device_type` STRING COMMENT 'description',
    `engagement_channel` STRING COMMENT 'description',
    `engagement_datetime` TIMESTAMP COMMENT 'description',
    `engagement_score` DECIMAL(18,2) COMMENT 'description',
    `engagement_type` STRING COMMENT 'description',
    `is_active` BOOLEAN COMMENT 'description',
    `is_first_engagement` BOOLEAN COMMENT 'description',
    `patient_engagement_code` BIGINT COMMENT 'description',
    `referral_source` STRING COMMENT 'description',
    `session_duration_seconds` STRING COMMENT 'description',
    `updated_at` TIMESTAMP COMMENT 'description',
    CONSTRAINT pk_digital_health_patient_engagement PRIMARY KEY(`digital_health_patient_engagement_id`)
) COMMENT 'Deprecated placeholder - use digital_health.portal_engagement_event instead';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`digital_health`.`device` (
    `device_id` BIGINT COMMENT 'System-generated unique identifier for the remote patient monitoring device.',
    `care_site_id` BIGINT COMMENT 'Reference to the facility or site where the device is installed.',
    `equipment_asset_id` BIGINT COMMENT 'Foreign key linking to facility.equipment_asset. Business justification: Connected device telemetry records must link to physical asset management records for unified maintenance scheduling, FDA recall tracking, and Joint Commission EC.02.04.01 compliance reporting.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: RPM devices are capitalized assets requiring depreciation tracking, net book value reporting, and FDA asset lifecycle compliance. Healthcare finance must link physical devices to their fixed asset reg',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Healthcare orgs procure RPM/connected devices through supply chain. Linking deployed devices to item master enables recall management, reorder triggers, warranty tracking, and cost accounting for digi',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient associated with the device for RPM.',
    `trading_partner_id` BIGINT COMMENT 'Foreign key linking to interoperability.trading_partner. Business justification: Device manufacturers receiving PHI are HIPAA trading partners. Linking devices to trading partners enables BAA compliance tracking, SLA monitoring, and vendor management for connected health devices.',
    `udi_record_id` BIGINT COMMENT 'Foreign key linking to supply.udi_record. Business justification: FDA UDI System mandates tracking connected medical devices. Links deployed RPM devices to formal UDI records for post-market surveillance, adverse event reporting, and MedWatch compliance per 21 CFR 8',
    `unit_id` BIGINT COMMENT 'Foreign key linking to facility.unit. Business justification: Biomedical engineering tracks connected devices at unit level for maintenance scheduling, infection control zone compliance, and Joint Commission EC standards. Provides granularity beyond care_site fo',
    `activation_date` DATE COMMENT 'Date the device became operational.',
    `alert_threshold_unit` STRING COMMENT 'Unit of measure for the alert threshold.. Valid values are `bpm|mg/dL|mmHg|percent`',
    `alert_threshold_value` DOUBLE COMMENT 'Numeric threshold that triggers a patient or clinician alert.',
    `asset_tag` STRING COMMENT 'Internal asset‑management tag used for inventory and tracking.',
    `battery_capacity_mah` STRING COMMENT 'Designed battery capacity in milliampere‑hours.',
    `battery_level_percent` STRING COMMENT 'Current battery charge expressed as a percentage of capacity.',
    `calibration_date` DATE COMMENT 'Date of the most recent calibration activity.',
    `compliance_status` STRING COMMENT 'Indicates whether the device meets regulatory and internal compliance requirements.. Valid values are `compliant|non_compliant|pending`',
    `connectivity_protocol` STRING COMMENT 'Application‑layer protocol used for data transmission.. Valid values are `http|mqtt|coap`',
    `connectivity_type` STRING COMMENT 'Primary network technology used by the device.. Valid values are `wifi|bluetooth|cellular|ethernet`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the device record was first created in the data lake.',
    `data_retention_policy` STRING COMMENT 'HIPAA‑aligned retention rule governing how long device data is kept.. Valid values are `7_years|indefinite`',
    `decommission_date` DATE COMMENT 'Date the device was retired or removed from service.',
    `deployment_status` STRING COMMENT 'Current deployment lifecycle state of the device.. Valid values are `deployed|pending|failed|retired`',
    `device_category` STRING COMMENT 'Functional domain the device belongs to.. Valid values are `vital_signs|medication_adherence|activity|glucose|cardiac`',
    `device_name` STRING COMMENT 'Human‑readable name assigned to the device for display in portals and reports.',
    `device_type` STRING COMMENT 'Broad classification of the device based on its clinical purpose.. Valid values are `monitor|sensor|insulin_pump|wearable|implantable`',
    `enrollment_date` DATE COMMENT 'Date the device was enrolled in the RPM program.',
    `enrollment_status` STRING COMMENT 'RPM program enrollment state for the device.. Valid values are `enrolled|pending|withdrawn`',
    `firmware_update_available` BOOLEAN COMMENT 'True if a newer firmware version is available for the device.',
    `firmware_update_version` STRING COMMENT 'Version identifier of the pending firmware update.',
    `firmware_version` STRING COMMENT 'Version of the firmware currently installed on the device.',
    `hardware_version` STRING COMMENT 'Version of the physical hardware components.',
    `ip_address` STRING COMMENT 'Network IP address assigned to the device when online.',
    `is_calibrated` BOOLEAN COMMENT 'True if the device has been calibrated according to manufacturer specifications.',
    `is_secure` BOOLEAN COMMENT 'Indicates whether the device meets defined security hardening standards.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent preventive or corrective maintenance.',
    `last_reading_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent sensor measurement.',
    `last_reading_value` DOUBLE COMMENT 'Numeric value of the most recent sensor measurement.',
    `mac_address` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive',
    `maintenance_interval_days` STRING COMMENT 'Planned number of days between routine maintenance events.',
    `manufacturer` STRING COMMENT 'Company that produced the device.',
    `model_number` STRING COMMENT 'Manufacturers model identifier for the device.',
    `notes` STRING COMMENT 'Additional free‑form information captured by administrators.',
    `reading_unit` STRING COMMENT 'Unit of measure for the sensor reading.. Valid values are `bpm|mg/dL|mmHg|percent`',
    `registration_date` DATE COMMENT 'Date the device record was created in the system.',
    `serial_number` STRING COMMENT 'Manufacturer‑assigned serial number uniquely identifying the hardware unit.',
    `signal_strength_dbm` STRING COMMENT 'Radio signal strength in dBm measured at the device.',
    `software_version` STRING COMMENT 'Version of any on‑device software or applications.',
    `status_reason` STRING COMMENT 'Free‑text explanation for the current status, e.g., error codes or maintenance notes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the device record.',
    `warranty_expiration_date` DATE COMMENT 'Date the manufacturer warranty ends.',
    `location_id` BIGINT COMMENT 'Reference to the facility or site where the device is installed.',
    `patient_id` BIGINT COMMENT 'Reference to the patient associated with the device for RPM.',
    `device_status_reason` STRING COMMENT 'Free‑text explanation for the current status, e.g., error codes or maintenance notes.',
    CONSTRAINT pk_device PRIMARY KEY(`device_id`)
) COMMENT 'Master record for remote patient monitoring devices, capturing device type, manufacturer, model number, firmware version, connectivity details, and deployment status.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`digital_health`.`rpm_program` (
    `rpm_program_id` BIGINT COMMENT 'System-generated unique identifier for the RPM program.',
    `care_program_id` BIGINT COMMENT 'Foreign key linking to patient.care_program. Business justification: RPM programs operate as components of broader care programs (e.g., diabetes RPM under chronic disease management). Required for program hierarchy reporting, budget rollup, and population health progra',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: RPM programs are operated by specific facilities for accreditation reporting, CMS certification, and cost center allocation. Facility administrators need to know which programs run at their site.',
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to billing.cdm_entry.BIGINT surrogate key for clean keying. Business justification: RPM program setup requires mapping to CDM entries for standardized charge capture. Normalizes billing_code/billing_rate already on rpm_program into proper reference to charge description master for re',
    `compliance_program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: RPM programs must operate under a governing compliance program (HIPAA telehealth/remote monitoring regulations). This FK enables compliance officers to identify which RPM programs fall under their ove',
    `consent_form_template_id` BIGINT COMMENT 'Foreign key linking to consent.consent_form_template. Business justification: RPM program configuration requires specifying which consent form template patients must complete at enrollment. Program managers define required consent documentation during program setup for regulato',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: RPM programs must be assigned to cost centers for departmental P&L reporting, Medicare cost report allocation, and operational budgeting. Healthcare finance teams track digital health program costs by',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: CMS RPM reimbursement requires specific CPT codes (99453-99458). Programs must link to CPT for claims generation, revenue tracking, and compliance with Medicare RPM billing rules.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee.BIGINT surrogate key for clean keying. Business justification: RPM program governance requires tracking which employee owns/directs the program for CMS compliance reporting, budget accountability, and operational oversight. Healthcare orgs assign program director',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: RPM billing (CPT 99453-99458) requires linking programs to covering health plans for reimbursement eligibility verification and claims submission. Payers design RPM as plan-specific covered benefits.',
    `insurance_coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.insurance_coverage_policy. Business justification: Coverage determination for RPM requires checking payer coverage policies defining medical necessity criteria, prior auth requirements, and eligible diagnoses for remote monitoring services.',
    `population_health_cohort_mgmt_cohort_definition_id` BIGINT COMMENT 'Foreign key linking to population_health_cohort_mgmt.cohort_definition. Business justification: Population health programs target specific cohorts. RPM programs are designed for defined patient populations (e.g., CHF high-risk cohort). Program managers link programs to cohorts for enrollment e',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: Decentralized clinical trials (DCTs) use RPM programs as data collection vehicles. FDA guidance on DCTs requires linking remote monitoring programs to their governing research protocol for regulatory ',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: RPM programs target specific clinical specialties (cardiology, pulmonology). Needed for network adequacy reporting, provider-program matching, and specialty-based quality measure alignment.',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: RPM programs target specific conditions (hypertension, CHF, diabetes). SNOMED linkage enables automated patient eligibility matching, condition-specific outcome reporting, and population health analyt',
    `alert_threshold_unit` STRING COMMENT 'Unit of measure for the alert threshold value.. Valid values are `bpm|mg/dL|%|mmHg|steps`',
    `alert_threshold_value` DECIMAL(18,2) COMMENT 'Numeric value that, when crossed, generates an alert.',
    `alert_type` STRING COMMENT 'Mechanism that triggers a patient or clinician alert.. Valid values are `threshold|trend|absence`',
    `billing_code` STRING COMMENT 'CPT code used for billing the RPM program.',
    `billing_rate` DECIMAL(18,2) COMMENT 'Reimbursement rate per enrollment period (e.g., per month).',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the RPM program record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the billing rate.',
    `data_capture_frequency` STRING COMMENT 'How often sensor data is recorded and transmitted.. Valid values are `continuous|hourly|daily|weekly`',
    `data_retention_period_days` STRING COMMENT 'Number of days patient data is retained in the lakehouse before archival or deletion.',
    `device_type` STRING COMMENT 'Category of device used to capture patient data.. Valid values are `wearable|implantable|home_monitor|mobile_app`',
    `duration_days` STRING COMMENT 'Standard length of the program in days once a patient is enrolled.',
    `end_date` DATE COMMENT 'Date when the program ends or is retired (nullable for open‑ended programs).',
    `enrollment_criteria` STRING COMMENT 'Business rules defining which patients are eligible for enrollment.',
    `enrollment_end_date` DATE COMMENT 'Last date on which patients may be enrolled.',
    `enrollment_start_date` DATE COMMENT 'First date on which patients may be enrolled.',
    `is_pilot_program` BOOLEAN COMMENT 'True if the program is a pilot or limited‑scope rollout.',
    `last_modified_by` STRING COMMENT 'Identifier of the user or system that last modified the program record.',
    `portal_access_enabled` BOOLEAN COMMENT 'Indicates whether enrolled patients have access to a patient portal for RPM data.',
    `program_code` STRING COMMENT 'External business code or identifier assigned to the RPM program.',
    `program_name` STRING COMMENT 'Human‑readable name of the RPM program.',
    `program_owner` STRING COMMENT 'Business unit or department responsible for the RPM program.',
    `program_type` STRING COMMENT 'Categorization of the program based on clinical use case.. Valid values are `chronic|post_acute|wellness|preventive|rehab`',
    `requires_consent` BOOLEAN COMMENT 'Indicates whether explicit patient consent is required for participation.',
    `rpm_program_description` STRING COMMENT 'Detailed description of the programs purpose, clinical objectives, and target population.',
    `rpm_program_status` STRING COMMENT 'Current lifecycle status of the program.. Valid values are `active|inactive|completed|suspended|draft`',
    `sensor_type` STRING COMMENT 'Specific physiological parameter measured by the device.. Valid values are `heart_rate|glucose|blood_pressure|oxygen_saturation|weight`',
    `start_date` DATE COMMENT 'Date when the program becomes effective for enrolled patients.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the RPM program record.',
    `description` STRING COMMENT 'Detailed description of the programs purpose, clinical objectives, and target population.',
    `status` STRING COMMENT 'Current lifecycle status of the program.. Valid values are `active|inactive|completed|suspended|draft`',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the program record.',
    CONSTRAINT pk_rpm_program PRIMARY KEY(`rpm_program_id`)
) COMMENT 'Definition of a Remote Patient Monitoring (RPM) program, including program name, clinical objectives, enrollment criteria, duration, billing code, and associated care pathways.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` (
    `rpm_enrollment_id` BIGINT COMMENT 'System-generated unique identifier for each RPM program enrollment record.',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to clinical.care_plan.BIGINT surrogate key for clean keying. Business justification: RPM enrollment is initiated as an intervention within a care plan (e.g., CHF management plan prescribes daily weight and BP monitoring). Care plan compliance reporting requires this linkage.',
    `care_program_enrollment_id` BIGINT COMMENT 'Foreign key linking to patient.care_program_enrollment. Business justification: RPM enrollments are initiated as part of broader care program enrollments (e.g., CHF management). Required for care coordination reporting, CMS chronic care management billing, and program outcome tra',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: CMS RPM billing (CPT 99453-99458) requires identifying the supervising facility. Enrollment-level care_site tracks which facility administers the remote monitoring program for cost allocation and regu',
    `care_team_id` BIGINT COMMENT 'BIGINT',
    `clinical_ai_patient_risk_score_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.patient_risk_score. Business justification: CMS RPM billing requires medical necessity documentation. The patient risk score that justified enrollment is tracked for audit, utilization review, and demonstrating clinical appropriateness of RPM s',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order.BIGINT surrogate key for clean keying. Business justification: Physicians order RPM monitoring via clinical orders; enrollment must trace to the originating order for medical necessity documentation, billing justification, and compliance audit trails per CMS RPM ',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: CMS RPM billing (CPT 99453/99454) mandates documented patient consent before remote monitoring enrollment. Enrollment must link to the specific consent record for audit, compliance verification, and b',
    `data_sharing_agreement_id` BIGINT COMMENT 'Foreign key linking to interoperability.data_sharing_agreement. Business justification: HIPAA requires data sharing agreements when RPM patient data flows to external device vendors. Enrollment-level linkage enables compliance auditing of which patients data is governed by which DSA.',
    `device_id` BIGINT COMMENT 'Unique identifier of the monitoring device assigned to the patient.',
    `scheduling_appointment_id` BIGINT COMMENT 'Foreign key linking to scheduling.scheduling_appointment. Business justification: RPM device setup/training visits are billed under CPT 99453. Programs must track which appointment initiated enrollment for billing compliance and device provisioning workflows.',
    `member_enrollment_id` BIGINT COMMENT 'Foreign key linking to insurance.member_enrollment. Business justification: RPM claims require active insurance coverage verification. CMS RPM billing mandates linking patient device enrollment to their insurance enrollment for eligibility and reimbursement processing.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient enrolling in the RPM program.',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: RPM is physician-ordered; CMS requires documenting the ordering provider for CPT 99453-99458 billing. Every RPM enrollment must trace to the clinician who initiated remote monitoring.',
    `population_health_cohort_cohort_definition_id` BIGINT COMMENT 'Foreign key linking to population_health_cohort.cohort_definition. Business justification: Value-based care workflow: population health teams identify at-risk cohorts (e.g., uncontrolled HbA1c) then enroll members into RPM programs. Tracking which cohort triggered enrollment supports progra',
    `population_health_cohort_management_cohort_membership_id` BIGINT COMMENT 'Foreign key linking to population_health_cohort_management.cohort_membership. Business justification: Population health teams identify at-risk cohorts then enroll members into RPM programs. Tracking which cohort membership triggered an RPM enrollment supports care gap closure reporting and program eff',
    `population_health_cohort_mgmt_cohort_definition_id` BIGINT COMMENT 'Foreign key linking to population_health_cohort_mgmt.cohort_definition. Business justification: Care managers enroll patients into RPM based on cohort qualification. Tracking which cohort qualified a patient for enrollment supports program effectiveness analysis, regulatory reporting, and ensure',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_episode. Business justification: Transitional care management: RPM enrollments are frequently initiated upon discharge to post-acute care. CMS requires tracking RPM in context of care transitions for bundled payment programs.',
    `problem_id` BIGINT COMMENT 'Foreign key linking to clinical.problem. Business justification: RPM programs target specific clinical problems (hypertension, CHF, COPD). Linking enrollment to the problem list enables condition-specific monitoring effectiveness analysis and supports CPT 99453-994',
    `rpm_program_id` BIGINT COMMENT 'Identifier of the remote patient monitoring program to which the patient is enrolled.',
    `alert_frequency` STRING COMMENT 'How often the system evaluates the threshold and generates alerts.. Valid values are `hourly|daily|weekly|monthly|as_needed`',
    `alert_threshold_unit` STRING COMMENT 'Unit of measure for the alert threshold value.. Valid values are `bpm|mmhg|mgdl|percent|celsius|fahrenheit`',
    `alert_threshold_value` DECIMAL(18,2) COMMENT 'Numeric value that triggers an alert when the monitored measurement exceeds it.',
    `consent_status` STRING COMMENT 'Patients consent state for data collection and sharing within the RPM program.. Valid values are `consented|declined|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment record was first created in the system.',
    `data_retention_policy` STRING COMMENT 'Policy governing how long enrollment data is retained to meet HIPAA and organizational requirements.. Valid values are `1yr|5yr|indefinite`',
    `device_serial_number` STRING COMMENT 'Manufacturer serial number of the assigned monitoring device; used for warranty and support.',
    `enrollment_date` DATE COMMENT 'Date the patient officially started participation in the RPM program.',
    `enrollment_end_date` DATE COMMENT 'Planned or actual date when the RPM enrollment ends or is terminated; null for open‑ended enrollments.',
    `enrollment_notes` STRING COMMENT 'Additional comments or observations recorded by staff during enrollment.',
    `enrollment_source` STRING COMMENT 'Origin channel through which the patient entered the RPM program.. Valid values are `patient_portal|clinic|referral|api|other`',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the RPM enrollment.. Valid values are `active|inactive|suspended|completed|terminated`',
    `hipaa_retention_annotation` STRING COMMENT 'Annotation indicating HIPAA‑required retention period for the enrollment record.',
    `portal_engagement_score` DECIMAL(18,2) COMMENT 'Composite score reflecting patient interaction frequency and depth within the portal.',
    `portal_last_login` TIMESTAMP COMMENT 'Timestamp of the most recent patient login to the health portal.',
    `prom_measure_name` STRING COMMENT 'Name of the patient‑reported outcome measure collected (e.g., pain_score, fatigue_level).',
    `prom_measure_unit` STRING COMMENT 'Unit of the PROM value (e.g., score, mmHg).. Valid values are `score|mmhg|mgdl|percent`',
    `prom_measure_value` DECIMAL(18,2) COMMENT 'Numeric result reported by the patient for the selected PROM.',
    `terminated_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment was terminated, if applicable.',
    `termination_reason` STRING COMMENT 'Reason why the RPM enrollment ended.. Valid values are `patient_request|provider_decision|noncompliance|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the enrollment record.',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient enrolling in the RPM program.',
    `program_id` BIGINT COMMENT 'Identifier of the remote patient monitoring program to which the patient is enrolled.',
    CONSTRAINT pk_rpm_enrollment PRIMARY KEY(`rpm_enrollment_id`)
) COMMENT 'Transactional record of a patient enrolling in an RPM program, capturing patient ID, program ID, enrollment date, consent status, assigned device, and care team assignment.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`digital_health`.`rpm_reading` (
    `rpm_reading_id` BIGINT COMMENT 'System-generated unique identifier for each RPM reading record.',
    `device_id` BIGINT COMMENT 'Unique identifier of the device or sensor that captured the reading.',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: RPM readings (BP, glucose, SpO2) require LOINC coding for FHIR Observation interoperability, quality measure reporting, and standardized clinical decision support across EHR systems.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient associated with the reading.',
    `rpm_enrollment_id` BIGINT COMMENT 'Identifier of the patient enrollment record for the RPM program.',
    `rpm_program_id` BIGINT COMMENT 'Identifier of the RPM program or care pathway the patient is enrolled in.',
    `visit_id` BIGINT COMMENT 'Foreign key linking to encounter.visit. Business justification: RPM readings reviewed during telehealth/office encounters must link to that visit for CPT 99457/99458 billing documentation, clinical context, and care coordination reporting. Standard RPM workflow.',
    `alert_flag` BOOLEAN COMMENT 'Indicates whether the reading triggered a clinical alert based on configured thresholds.',
    `alert_triggered_timestamp` TIMESTAMP COMMENT 'Date and time when the alert condition was met.',
    `battery_level` STRING COMMENT 'Remaining battery percentage of the device when the reading was taken.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reading record was first created in the lakehouse.',
    `firmware_version` STRING COMMENT 'Software version running on the monitoring device.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the device at the time of measurement.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the device at the time of measurement.',
    `measurement_type` STRING COMMENT 'Clinical category of the measurement captured (e.g., heart rate, blood pressure).. Valid values are `heart_rate|blood_pressure|oxygen_saturation|glucose|temperature|respiratory_rate`',
    `measurement_value` DECIMAL(18,2) COMMENT 'Numeric value of the measurement expressed in the associated unit.',
    `notes` STRING COMMENT 'Free‑text comments or observations added by clinicians or device operators.',
    `patient_consent` BOOLEAN COMMENT 'Indicates whether the patient has provided consent for remote monitoring.',
    `reading_status` STRING COMMENT 'Lifecycle status of the reading after validation.. Valid values are `valid|invalid|suspect|missing`',
    `reading_timestamp` TIMESTAMP COMMENT 'Date and time when the measurement was taken by the device.',
    `signal_quality` STRING COMMENT 'Assessment of the raw signal integrity at the time of capture.. Valid values are `good|fair|poor|bad|no_signal`',
    `source_system` STRING COMMENT 'Originating system that supplied the reading data.. Valid values are `Epic|Cerner|Custom|ThirdParty`',
    `threshold_value` DECIMAL(18,2) COMMENT 'Configured threshold value for the measurement type that, when crossed, generates an alert.',
    `unit_of_measure` STRING COMMENT 'Standard unit for the measurement value (e.g., beats per minute).. Valid values are `bpm|mmHg|%|mg/dL|C|breaths/min`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the reading record.',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient associated with the reading.',
    `enrollment_id` BIGINT COMMENT 'Identifier of the patient enrollment record for the RPM program.',
    `program_id` BIGINT COMMENT 'Identifier of the RPM program or care pathway the patient is enrolled in.',
    CONSTRAINT pk_rpm_reading PRIMARY KEY(`rpm_reading_id`)
) COMMENT 'Individual remote monitoring measurement captured from a device, including timestamp, vital sign type, measured value, unit, signal quality, and source device ID.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` (
    `rpm_alert_threshold_id` BIGINT COMMENT 'Unique identifier for the RPM alert threshold configuration.',
    `device_id` BIGINT COMMENT 'Identifier of the remote monitoring device or sensor.',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Alert thresholds define clinical limits for specific measurements. LOINC coding enables evidence-based threshold management, cross-system portability, and guideline-driven threshold configuration.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient to whom this alert threshold applies.',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Patient-specific alert thresholds are clinical orders set by physicians. Tracking the ordering clinician ensures clinical accountability and supports scope-of-practice compliance for threshold modific',
    `employee_id` BIGINT COMMENT 'Identifier of the user who last modified the threshold configuration.',
    `rpm_employee_id` BIGINT COMMENT 'Identifier of the user who created the threshold configuration.',
    `rpm_program_id` BIGINT COMMENT 'Foreign key linking to digital_health.rpm_program. Business justification: Alert thresholds are often program-specific - different RPM programs (e.g., cardiac vs. diabetes monitoring) have different clinical threshold standards. Linking thresholds to programs enables program',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the alert threshold record was created.',
    `effective_end_date` DATE COMMENT 'Date when the alert threshold expires or is deactivated (nullable).',
    `effective_start_date` DATE COMMENT 'Date when the alert threshold becomes active.',
    `escalation_policy` STRING COMMENT 'Name or identifier of the escalation workflow to invoke on alert.',
    `evaluation_result` STRING COMMENT 'Result of the most recent evaluation (e.g., within_range|breached).',
    `last_evaluated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent evaluation of the metric against this threshold.',
    `lower_threshold` DECIMAL(18,2) COMMENT 'Lower bound that triggers an alert when the metric falls below this value.',
    `metric_code` STRING COMMENT 'Standard code for the metric (e.g., LOINC code).',
    `metric_name` STRING COMMENT 'Name of the clinical measurement (e.g., heart rate, blood pressure).',
    `notification_channel` STRING COMMENT 'Delivery method for the alert notification.. Valid values are `email|sms|app|pager`',
    `rpm_alert_threshold_description` STRING COMMENT 'Free‑text description of the purpose or context of the threshold.',
    `rpm_alert_threshold_status` STRING COMMENT 'Current lifecycle status of the alert threshold configuration.. Valid values are `active|inactive|suspended|pending`',
    `severity_level` STRING COMMENT 'Severity assigned to the alert when the threshold is breached.. Valid values are `low|medium|high|critical`',
    `threshold_type` STRING COMMENT 'Indicates whether the threshold is an absolute value, relative change, or percentage.. Valid values are `absolute|relative|percent`',
    `unit_of_measure` STRING COMMENT 'Unit in which the metric is measured (e.g., bpm, mmHg).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the alert threshold record.',
    `upper_threshold` DECIMAL(18,2) COMMENT 'Upper bound that triggers an alert when the metric exceeds this value.',
    `patient_id` BIGINT COMMENT 'Identifier of the patient to whom this alert threshold applies.',
    `status` STRING COMMENT 'Current lifecycle status of the alert threshold configuration.. Valid values are `active|inactive|suspended|pending`',
    `description` STRING COMMENT 'Free‑text description of the purpose or context of the threshold.',
    `created_by_user_id` BIGINT COMMENT 'Identifier of the user who created the threshold configuration.',
    `updated_by_user_id` BIGINT COMMENT 'Identifier of the user who last modified the threshold configuration.',
    CONSTRAINT pk_rpm_alert_threshold PRIMARY KEY(`rpm_alert_threshold_id`)
) COMMENT 'Configuration of alert thresholds for RPM measurements per patient and device, specifying metric, upper/lower limits, severity level, notification channel, and escalation workflow.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` (
    `prom_questionnaire_id` BIGINT COMMENT 'Unique surrogate key for the PROM questionnaire.',
    `facility_organization_id` BIGINT COMMENT 'Identifier of the organization that owns or publishes the questionnaire.',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Validated PROMs (PHQ-9, GAD-7, PROMIS) have assigned LOINC codes required by CMS quality programs, MIPS reporting, and FHIR QuestionnaireResponse resource generation.',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: PROMs measure specific clinical conditions (depression, anxiety, pain). SNOMED linkage enables condition-specific outcome analytics, clinical pathway integration, and quality measure stratification.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the questionnaire record was first created in the system.',
    `data_retention_period_days` STRING COMMENT 'Number of days the questionnaire responses must be retained per compliance policy.',
    `effective_from` DATE COMMENT 'Date when the questionnaire becomes valid for use.',
    `effective_until` DATE COMMENT 'Date when the questionnaire is retired or superseded (null if open‑ended).',
    `is_anonymous` BOOLEAN COMMENT 'Indicates whether responses are collected without linking to patient identifiers.',
    `is_deleted` BOOLEAN COMMENT 'True if the questionnaire has been logically removed from active catalogs.',
    `is_public` BOOLEAN COMMENT 'True if the questionnaire is available for external use (e.g., patient portal).',
    `is_score_weighted` BOOLEAN COMMENT 'Indicates whether individual question scores are weighted.',
    `language` STRING COMMENT 'Primary language of the questionnaire content. [ENUM-REF-CANDIDATE: en|es|fr|de|zh|ar|hi|pt — promote to reference product]',
    `last_review_date` DATE COMMENT 'Date when the questionnaire content was last clinically reviewed.',
    `license_contact_email` STRING COMMENT 'Email address for license‑related communication.',
    `license_contact_name` STRING COMMENT 'Name of the person responsible for license inquiries.',
    `license_name` STRING COMMENT 'Formal name of the license (e.g., Creative Commons BY‑SA 4.0).',
    `license_url` STRING COMMENT 'Web address where the full license text is hosted.',
    `licensing_type` STRING COMMENT 'Legal licensing model governing questionnaire reuse.. Valid values are `proprietary|open_source|cc_by|cc_by_sa|custom`',
    `max_age` STRING COMMENT 'Maximum patient age (in years) for which the questionnaire is appropriate.',
    `max_score` STRING COMMENT 'Maximum score allowed for a single response (if different from total_score_max).',
    `min_age` STRING COMMENT 'Minimum patient age (in years) for which the questionnaire is appropriate.',
    `min_score` STRING COMMENT 'Lowest possible score (often zero) for the questionnaire.',
    `prom_questionnaire_description` STRING COMMENT 'Detailed narrative describing the purpose, scope, and content of the questionnaire.',
    `prom_questionnaire_status` STRING COMMENT 'Current lifecycle state of the questionnaire.. Valid values are `active|inactive|draft|retired|archived`',
    `question_count` STRING COMMENT 'Total count of individual items/questions in the questionnaire.',
    `question_structure` STRING COMMENT 'JSON string representing the hierarchical structure of questions and response options.',
    `required_consent` BOOLEAN COMMENT 'Indicates whether patient consent is required before administering the questionnaire.',
    `scoring_algorithm` STRING COMMENT 'Description of the algorithm used to calculate the final score (e.g., sum, weighted, Rasch).',
    `scoring_scale` STRING COMMENT 'Definition of the scoring range (e.g., 0‑100, 1‑5 Likert).',
    `survey_mode` STRING COMMENT 'Primary mode of delivery for the questionnaire.. Valid values are `online|paper|tablet|interview`',
    `target_population` STRING COMMENT 'Population segment for which the questionnaire is intended.. Valid values are `adult|pediatric|geriatric|all|specific_condition`',
    `title` STRING COMMENT 'Human‑readable title of the patient‑reported outcome measure questionnaire.',
    `total_score_max` STRING COMMENT 'Highest possible aggregate score achievable across all questions.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the questionnaire record.',
    `version_date` DATE COMMENT 'Date on which the current version of the questionnaire was released.',
    `version_notes` STRING COMMENT 'Free‑text notes describing changes made in this version.',
    `version_number` STRING COMMENT 'Version identifier (e.g., 1.0, 2.1) used to track revisions of the questionnaire.',
    `description` STRING COMMENT 'Detailed narrative describing the purpose, scope, and content of the questionnaire.',
    `status` STRING COMMENT 'Current lifecycle state of the questionnaire.. Valid values are `active|inactive|draft|retired|archived`',
    `organization_id` BIGINT COMMENT 'Identifier of the organization that owns or publishes the questionnaire.',
    CONSTRAINT pk_prom_questionnaire PRIMARY KEY(`prom_questionnaire_id`)
) COMMENT 'Master definition of a Patient-Reported Outcome Measure (PROM) questionnaire, including questionnaire title, version, list of questions, scoring algorithm, target population, and licensing information.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`digital_health`.`prom_response` (
    `prom_response_id` BIGINT COMMENT 'Unique identifier for the patient-reported outcome measure response.',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to clinical.care_plan.BIGINT surrogate key for clean keying. Business justification: PROM questionnaires are administered as part of a care plans outcome monitoring (e.g., post-surgical recovery, chronic disease management). Care coordinators track PROM completion rates per care plan',
    `care_site_id` BIGINT COMMENT 'Identifier of the care site or location where the response was captured.',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order.BIGINT surrogate key for clean keying. Business justification: Clinicians order PROM assessments (e.g., PHQ-9, PROMIS); responses must link to the originating order for care plan compliance tracking, quality measure reporting (MIPS), and closed-loop documentation',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider overseeing the patient at the time of response, if applicable.',
    `device_id` BIGINT COMMENT 'Identifier of the device or sensor used to capture the response, if applicable.',
    `mpi_record_id` BIGINT COMMENT 'Medical Record Number of the patient who provided the response.',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_episode. Business justification: Quality measurement: PROMs collected during PAC episodes (home health OASIS, SNF MDS) must link to episodes for CMS quality reporting and functional status tracking.',
    `problem_id` BIGINT COMMENT 'Foreign key linking to clinical.problem. Business justification: PROMs target specific clinical problems (PHQ-9 for depression, KOOS for knee osteoarthritis). Linking responses to the problem list enables condition-specific outcome trending and population health an',
    `prom_questionnaire_id` BIGINT COMMENT 'Identifier of the PROM questionnaire.',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: Patient-Reported Outcomes (PROs) are primary/secondary endpoints in clinical trials per FDA PRO Guidance. PROM responses collected for a study must link to the research_study for endpoint analysis and',
    `rpm_enrollment_id` BIGINT COMMENT 'Identifier of the remote patient monitoring program enrollment associated with this response.',
    `scheduling_appointment_id` BIGINT COMMENT 'Foreign key linking to scheduling.scheduling_appointment. Business justification: Pre-visit PROMs are sent linked to upcoming appointments via patient portals. Clinicians review scores before the visit for care planning. Standard patient engagement workflow.',
    `subject_enrollment_id` BIGINT COMMENT 'Foreign key linking to research.subject_enrollment. Business justification: Per-subject PRO data collection in trials requires linking each PROM response to the specific subject enrollment for randomization arm analysis, visit window compliance, and ITT/PP population assignme',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter associated with the response, if any.',
    `alert_threshold_unit` STRING COMMENT 'Unit of measure for the alert threshold (e.g., points).',
    `alert_threshold_value` DECIMAL(18,2) COMMENT 'Threshold value that, if exceeded by the total score, triggers an alert.',
    `alert_triggered` BOOLEAN COMMENT 'Indicates whether the response triggered a clinical alert based on predefined thresholds.',
    `answer_json` STRING COMMENT 'JSON representation of individual item answers for the questionnaire.',
    `consent_given` BOOLEAN COMMENT 'Indicates whether the patient consented to use the response data for research/analytics.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the response record was created in the system.',
    `data_source` STRING COMMENT 'Specifies if the response was self-reported or assisted by a clinician.. Valid values are `self_report|clinician_assisted`',
    `interpretation` STRING COMMENT 'Clinical interpretation of the total score.. Valid values are `normal|abnormal|critical`',
    `is_test_response` BOOLEAN COMMENT 'Indicates whether the response is a test/sandbox entry.',
    `language_code` STRING COMMENT 'ISO 639-1 language code of the questionnaire presented to the patient.. Valid values are `en|es|fr|de|zh|ar`',
    `notes` STRING COMMENT 'Free-text notes or comments provided by the patient.',
    `prom_response_status` STRING COMMENT 'Current processing status of the response.. Valid values are `completed|in_progress|cancelled`',
    `response_timestamp` TIMESTAMP COMMENT 'Date and time when the patient submitted the response.',
    `source_channel` STRING COMMENT 'Channel through which the patient submitted the response.. Valid values are `portal|mobile_app|tablet|wearable|call_center`',
    `total_score` DECIMAL(18,2) COMMENT 'Calculated total score from the questionnaire responses.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the response record.',
    `version_number` STRING COMMENT 'Version of the questionnaire used for this response.',
    `patient_id` BIGINT COMMENT 'Medical Record Number of the patient who provided the response.',
    `questionnaire_id` BIGINT COMMENT 'Identifier of the PROM questionnaire.',
    `enrollment_id` BIGINT COMMENT 'Identifier of the remote patient monitoring program enrollment associated with this response.',
    `status` STRING COMMENT 'Current processing status of the response.. Valid values are `completed|in_progress|cancelled`',
    `provider_id` BIGINT COMMENT 'Identifier of the provider overseeing the patient at the time of response, if applicable.',
    `encounter_id` BIGINT COMMENT 'Identifier of the clinical encounter associated with the response, if any.',
    `location_id` BIGINT COMMENT 'Identifier of the care site or location where the response was captured.',
    CONSTRAINT pk_prom_response PRIMARY KEY(`prom_response_id`)
) COMMENT 'Patient response to a PROM questionnaire, capturing patient ID, questionnaire ID, response timestamp, individual item answers, calculated score, and clinical interpretation.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` (
    `portal_engagement_event_id` BIGINT COMMENT 'System-generated unique identifier for each portal engagement event record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient who performed the portal interaction.',
    `portal_account_id` BIGINT COMMENT 'Foreign key linking to patient.portal_account. Business justification: Portal engagement events occur within a specific portal account session. Required for patient engagement analytics, security auditing, and portal usage dashboards that track account-level activity pat',
    `scheduling_appointment_id` BIGINT COMMENT 'Foreign key linking to scheduling.scheduling_appointment. Business justification: Online scheduling/cancellation via patient portal is a core engagement function. Linking portal events to affected appointments enables self-scheduling analytics and no-show prediction.',
    `device_type` STRING COMMENT 'Type of device used to access the portal.. Valid values are `web|mobile|tablet`',
    `event_outcome` STRING COMMENT 'Result of the interaction – whether it completed successfully or failed.. Valid values are `success|failure`',
    `event_payload` STRING COMMENT 'Free‑form details or JSON payload associated with the event (e.g., message content, document ID).',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the portal interaction actually occurred.',
    `event_type` STRING COMMENT 'pii_phi,pii_pii,pii_sensitive. Valid values are `login|message|document_view|appointment|lab_result_view`',
    `ingestion_timestamp` TIMESTAMP COMMENT 'Date and time when the event record was loaded into the lakehouse.',
    `ip_address` STRING COMMENT 'IP address of the client device at the time of the event.',
    `portal_session_code` STRING COMMENT 'Identifier of the user session during which the event occurred.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the event record was first created in the source system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the event record.',
    `user_agent` STRING COMMENT 'Browser or application user‑agent string identifying the client software.',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient who performed the portal interaction.',
    `session_id` STRING COMMENT 'Identifier of the user session during which the event occurred.',
    CONSTRAINT pk_portal_engagement_event PRIMARY KEY(`portal_engagement_event_id`)
) COMMENT 'Log of a patient interaction with the online portal, including event type (login, message, document view), timestamp, device type, IP address, and associated patient ID.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`digital_health`.`health_alert` (
    `health_alert_id` BIGINT COMMENT 'Unique identifier for the health alert record.',
    `clinical_ai_model_card_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.model_card. Business justification: AI-generated health alerts (anomaly detection, predictive deterioration) must trace to the governing model card for FDA SaMD compliance, bias monitoring, and clinical AI governance transparency requir',
    `clinical_ai_model_inference_log_id` BIGINT COMMENT 'Foreign key linking to clinical_ai.model_inference_log. Business justification: Full traceability from AI-generated alert to specific model inference enables clinician review of prediction confidence, feature importance, and supports adverse event investigation per FDA post-marke',
    `device_id` BIGINT COMMENT 'Unique identifier of the remote monitoring device that generated the reading.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee.BIGINT surrogate key for clean keying. Business justification: RPM alert triage workflows require tracking which staff member resolved each alert for workload balancing, response time reporting, and CMS RPM billing documentation (99457/99458 time tracking).',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Health alerts triggered by specific vital signs require LOINC standardization for interoperable clinical decision support, alert routing rules, and integration with EHR clinical workflows.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier of the patient associated with the alert.',
    `post_acute_episode_id` BIGINT COMMENT 'Foreign key linking to post_acute_care.post_acute_episode. Business justification: Care escalation workflow: RPM alerts during PAC episodes trigger clinical interventions. Linking alerts to episodes enables PAC teams to prioritize responses and track readmission risk.',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Clinical alerts require provider review/acknowledgment per RPM care protocols. Tracking the responding clinician supports CMS interactive communication requirements and malpractice documentation.',
    `rpm_alert_threshold_id` BIGINT COMMENT 'Foreign key linking to digital_health.rpm_alert_threshold. Business justification: When an alert fires, it should reference which threshold configuration was violated. This enables threshold tuning analysis, audit of alert accuracy, and configuration management. Population: at alert',
    `rpm_enrollment_id` BIGINT COMMENT 'Foreign key linking to digital_health.rpm_enrollment. Business justification: Health alerts are generated in the context of an RPM enrollment. Linking the alert to the enrollment enables clinical workflow tracking, program-level alert analytics, and care team notification routi',
    `rpm_program_id` BIGINT COMMENT 'Foreign key linking to digital_health.rpm_program. Business justification: Provides direct program context for health alerts, enabling program-level alert dashboards and analytics without requiring join through enrollment. Alerts may fire in program context even when enrollm',
    `rpm_reading_id` BIGINT COMMENT 'Foreign key linking to digital_health.rpm_reading. Business justification: A health alert is triggered by a specific RPM reading that exceeded defined thresholds. Linking the alert to the causative reading is essential for clinical review, root cause analysis, and audit trai',
    `visit_id` BIGINT COMMENT 'Foreign key linking to encounter.visit. Business justification: When RPM alerts trigger clinical encounters (ED visits, telehealth), linking alert to resulting visit supports care coordination, RPM program effectiveness reporting, and CMS quality measures for chro',
    `alert_category` STRING COMMENT 'Category classifying the type of alert.. Valid values are `vital_sign|device_error|patient_report|system`',
    `alert_description` STRING COMMENT 'Free-text description providing context for the alert.',
    `alert_timestamp` TIMESTAMP COMMENT 'Timestamp when the alert condition was detected.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the alert record was created in the system.',
    `measured_value` DECIMAL(18,2) COMMENT 'Measured value of the metric at the time of alert.',
    `metric_name` STRING COMMENT 'Name of the health metric being monitored.',
    `notification_method` STRING COMMENT 'Method used to notify the patient or care team about the alert.. Valid values are `email|sms|push|phone`',
    `resolution_status` STRING COMMENT 'Current status of the alert resolution process.. Valid values are `open|closed|dismissed`',
    `resolution_timestamp` TIMESTAMP COMMENT 'Timestamp when the alert was resolved or dismissed.',
    `severity` STRING COMMENT 'Severity level assigned to the alert based on deviation magnitude.. Valid values are `critical|high|medium|low`',
    `threshold_unit` STRING COMMENT 'Unit of measure for the threshold value.',
    `threshold_value` DECIMAL(18,2) COMMENT 'Configured threshold value for the metric that triggers the alert.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the metric value.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the alert record.',
    `patient_id` BIGINT COMMENT 'Unique identifier of the patient associated with the alert.',
    CONSTRAINT pk_health_alert PRIMARY KEY(`health_alert_id`)
) COMMENT 'Generated alert when a RPM reading exceeds defined thresholds, capturing alert ID, patient ID, device ID, metric, measured value, threshold breached, severity, notification method, and resolution status.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`digital_health`.`rpm_device_reading` (
    `rpm_device_reading_id` BIGINT COMMENT 'Primary key for rpm_device_reading',
    `clinician_id` BIGINT COMMENT 'Identifier of the healthcare provider who reviewed this reading, supporting care team attribution and billing provider documentation.',
    `device_id` BIGINT COMMENT 'Identifier of the remote monitoring device or sensor that captured this reading. Traceable to the patient and thus considered PHI.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient from whom this device reading was captured. Links the physiological measurement to the individual under remote monitoring.',
    `rpm_enrollment_id` BIGINT COMMENT 'Identifier of the RPM program enrollment under which this reading was collected, linking to the patients active monitoring program.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter associated with this reading, if the reading was reviewed or triggered a clinical interaction.',
    `abnormal_flag` STRING COMMENT 'Interpretation flag indicating whether the reading falls within normal, abnormal, or critical ranges based on clinical reference ranges for the patients demographics.',
    `alert_severity` STRING COMMENT 'Severity classification of the alert triggered by this reading, used to prioritize clinical response and escalation workflows.',
    `body_site` STRING COMMENT 'Anatomical location where the measurement was taken (e.g., left arm, right wrist, fingertip), which may affect clinical interpretation of values.',
    `clinical_note` STRING COMMENT 'Free-text clinical annotation added by the reviewing provider regarding this reading, documenting clinical interpretation or action taken.',
    `clinician_reviewed_flag` BOOLEAN COMMENT 'Indicates whether a clinician has reviewed this reading, relevant for CPT 99457/99458 billing which requires interactive communication time.',
    `device_battery_pct` DECIMAL(18,2) COMMENT 'Battery level of the monitoring device at the time of reading capture, used for proactive device maintenance and patient outreach when battery is low.',
    `external_reading_code` STRING COMMENT 'Unique identifier assigned by the source device platform or vendor system for this reading, enabling cross-system reconciliation and deduplication.',
    `firmware_version` STRING COMMENT 'Version of the device firmware at the time of reading capture, important for data quality assessment and device recall tracking.',
    `hipaa_retention_date` DATE COMMENT 'The earliest date this record may be purged per HIPAA and state medical record retention requirements, typically 6-10 years from creation depending on jurisdiction.',
    `is_alert_triggered` BOOLEAN COMMENT 'Indicates whether this reading triggered a clinical alert based on the patients configured threshold parameters in the RPM program.',
    `is_manually_entered` BOOLEAN COMMENT 'Indicates whether this reading was manually entered by the patient rather than automatically transmitted by the device, affecting data reliability assessment.',
    `loinc_code` STRING COMMENT 'The LOINC code that precisely identifies the type of observation or measurement captured, enabling interoperability and standardized clinical interpretation.',
    `patient_position` STRING COMMENT 'The patients body position during measurement capture, clinically relevant for blood pressure and other position-sensitive readings.',
    `quality_indicator` STRING COMMENT 'Assessment of the signal quality or measurement confidence reported by the device, indicating reliability of the captured value for clinical decision-making.',
    `reading_status` STRING COMMENT 'Current status of the device reading in its lifecycle, indicating whether the measurement is finalized, preliminary, amended after review, or invalidated.',
    `reading_timestamp` TIMESTAMP COMMENT 'The exact date and time when the physiological measurement was captured by the device sensor. This is the clinically relevant event time.',
    `reading_type` STRING COMMENT 'Classification of the physiological parameter being measured by the device. Determines the expected value ranges and clinical interpretation context. [ENUM-REF-CANDIDATE: blood_pressure|heart_rate|blood_glucose|oxygen_saturation|weight|temperature|respiratory_rate|peak_flow|ecg|activity_level — promote to reference product]',
    `received_timestamp` TIMESTAMP COMMENT 'The date and time when the reading was received by the healthcare systems data platform, used to measure transmission latency.',
    `reviewed_timestamp` TIMESTAMP COMMENT 'Date and time when a clinician reviewed this reading, used for compliance tracking and billing documentation of RPM management services.',
    `source_system` STRING COMMENT 'Name of the originating system or device platform that transmitted this reading (e.g., vendor gateway, patient app, EHR integration).',
    `threshold_high` DECIMAL(18,2) COMMENT 'The upper threshold value that was active at the time of this reading, against which the measurement was evaluated for alert generation.',
    `threshold_low` DECIMAL(18,2) COMMENT 'The lower threshold value that was active at the time of this reading, against which the measurement was evaluated for alert generation.',
    `transmission_method` STRING COMMENT 'The communication channel or protocol used to transmit the reading from the device to the healthcare platform.',
    `unit_of_measure` STRING COMMENT 'The unit of measurement for the captured reading value, expressed in UCUM (Unified Code for Units of Measure) notation where applicable.',
    `value_numeric` DECIMAL(18,2) COMMENT 'The primary numeric measurement value captured by the device (e.g., heart rate in bpm, glucose in mg/dL, weight in kg). Constitutes PHI when linked to a patient.',
    `value_secondary_numeric` DECIMAL(18,2) COMMENT 'A secondary numeric value for compound measurements such as diastolic blood pressure (when value_numeric holds systolic), or a secondary axis reading.',
    `value_string` STRING COMMENT 'Non-numeric reading value for qualitative measurements or device status messages that cannot be expressed as a number (e.g., ECG waveform classification, rhythm type).',
    CONSTRAINT pk_rpm_device_reading PRIMARY KEY(`rpm_device_reading_id`)
) COMMENT 'Deprecated placeholder - use digital_health.rpm_reading instead';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`digital_health`.`portal_engagement` (
    `portal_engagement_id` BIGINT COMMENT 'Primary key for portal_engagement',
    `care_site_id` BIGINT COMMENT 'Identifier of the facility context in which the portal engagement occurred.',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider whose content or message the patient engaged with.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the patient who performed the portal interaction.',
    `consent_session_id` BIGINT COMMENT 'Unique session identifier linking multiple portal events within a single user session.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter associated with this portal engagement, if applicable.',
    `accessibility_mode_flag` BOOLEAN COMMENT 'Indicates whether the patient was using accessibility features (screen reader, high contrast, etc.) during this portal session.',
    `action_detail` STRING COMMENT 'Detailed description of the specific action taken within the portal event (e.g., viewed lab result for CBC, sent message to PCP).',
    `authentication_method` STRING COMMENT 'Method used by the patient to authenticate for this portal session.',
    `browser_application` STRING COMMENT 'Browser or mobile application used to access the patient portal.',
    `channel` STRING COMMENT 'Digital channel through which the patient accessed the portal for this interaction.',
    `consent_status` STRING COMMENT 'Status of the patients consent for portal data sharing and communication preferences at the time of this event.',
    `content_category` STRING COMMENT 'High-level category of the content the patient engaged with during this portal event.',
    `data_download_flag` BOOLEAN COMMENT 'Indicates whether the patient downloaded health data during this portal event, supporting Meaningful Use and information blocking compliance.',
    `device_type` STRING COMMENT 'Type of device used by the patient to access the portal during this engagement.',
    `download_format` STRING COMMENT 'Format of the health data downloaded by the patient during this portal event.',
    `duration_seconds` STRING COMMENT 'Duration in seconds the patient spent on this specific portal interaction or page view.',
    `engagement_outcome` STRING COMMENT 'Outcome of the portal engagement event indicating whether the intended action was successfully completed.',
    `error_code` STRING COMMENT 'Error code captured if the portal engagement event resulted in a system error or failure.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the patient portal interaction event occurred.',
    `event_type` STRING COMMENT 'Classification of the portal interaction event performed by the patient. [ENUM-REF-CANDIDATE: login|logout|message_sent|message_read|record_view|lab_result_view|appointment_request|appointment_cancel|prescription_refill|bill_payment|form_submission|document_upload|proxy_access|video_visit_join|education_view — promote to reference product]',
    `geolocation_region` STRING COMMENT 'Geographic region from which the portal was accessed, derived from IP geolocation, used for security monitoring and access pattern analysis.',
    `ip_address` STRING COMMENT 'IP address of the client device from which the portal was accessed.',
    `is_first_login` BOOLEAN COMMENT 'Indicates whether this event represents the patients first-ever login to the portal.',
    `is_proxy_access` BOOLEAN COMMENT 'Indicates whether this portal engagement was performed by an authorized proxy (e.g., parent, caregiver) on behalf of the patient.',
    `is_task_completed` BOOLEAN COMMENT 'Indicates whether the patient completed the intended task during this portal session (e.g., scheduled appointment, paid bill, submitted form).',
    `language_preference` STRING COMMENT 'Language in which the patient accessed the portal during this event, expressed as ISO 639-1 code with optional region.',
    `mychart_activity_reference` STRING COMMENT 'Source system activity identifier from Epic MyChart or equivalent patient portal system for traceability.',
    `notification_reference` BIGINT COMMENT 'Identifier of the notification that triggered this portal engagement, if applicable.',
    `operating_system` STRING COMMENT 'Operating system of the device used for portal access (e.g., iOS, Android, Windows, macOS).',
    `page_or_section` STRING COMMENT 'Specific page, module, or section of the patient portal that was accessed during this event.',
    `phi_accessed_flag` BOOLEAN COMMENT 'Indicates whether the patient accessed Protected Health Information during this portal event, used for HIPAA audit trail compliance.',
    `portal_version` STRING COMMENT 'Version of the patient portal application in use at the time of this engagement event.',
    `proxy_relationship` STRING COMMENT 'Relationship of the proxy user to the patient when proxy access is used.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this portal engagement record was first captured in the data platform.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this portal engagement record was last modified in the data platform.',
    `referral_source` STRING COMMENT 'Source or trigger that prompted the patient to access the portal for this engagement.',
    `satisfaction_rating` STRING COMMENT 'Patient-provided satisfaction rating for this portal interaction on a 1-5 scale, if feedback was collected.',
    `source_system` STRING COMMENT 'Name of the operational system that generated this portal engagement record (e.g., Epic MyChart, Cerner HealtheLife).',
    CONSTRAINT pk_portal_engagement PRIMARY KEY(`portal_engagement_id`)
) COMMENT 'Deprecated placeholder - use digital_health.portal_engagement_event instead';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`digital_health`.`program_monitoring_requirement` (
    `program_monitoring_requirement_id` BIGINT COMMENT 'System-generated unique identifier for the program monitoring requirement record.',
    `rpm_program_id` BIGINT COMMENT 'Foreign key linking to the RPM program that defines this monitoring requirement',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to the laboratory test catalog entry required by the program',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this monitoring requirement record was created.',
    `effective_date` DATE COMMENT 'Date when this test requirement became active for the RPM program. Supports versioning of program protocols over time.',
    `end_date` DATE COMMENT 'Date when this test requirement was retired or superseded within the RPM program. Null indicates currently active requirement.',
    `frequency_requirement` STRING COMMENT 'How often the test must be performed within the program (e.g., weekly, monthly, quarterly). Defines the clinical protocol cadence for this specific test within this specific program.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this lab test is mandatory (true) or optional/recommended (false) for patients enrolled in the RPM program.',
    `monitoring_interval_days` STRING COMMENT 'Number of days between required test administrations for this program-test combination. Provides numeric precision for scheduling and compliance tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this monitoring requirement record was last modified.',
    CONSTRAINT pk_program_monitoring_requirement PRIMARY KEY(`program_monitoring_requirement_id`)
) COMMENT 'This association product represents the contractual requirement between an RPM program and a laboratory test catalog entry. It captures which lab tests are required or recommended for each remote patient monitoring program, along with the frequency, interval, and mandatory/optional status of each test within the program. Each record links one RPM program to one test catalog entry with attributes that exist only in the context of this monitoring protocol relationship.. Existence Justification: RPM programs define required laboratory monitoring protocols where one diabetes RPM program requires multiple lab tests (HbA1c, BMP, lipid panel) and one lab test like HbA1c serves multiple RPM programs (diabetes management, cardiovascular risk, pre-surgical optimization). Healthcare organizations actively manage these program-test associations with specific frequency requirements, mandatory/optional designations, and effective date ranges that belong to neither the program nor the test alone.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`digital_health`.`program_metric` (
    `program_metric_id` BIGINT COMMENT 'System-generated unique identifier for the program metric configuration record.',
    `loinc_code_id` BIGINT COMMENT 'Foreign key to the LOINC code identifying the clinical metric being monitored.',
    `rpm_program_id` BIGINT COMMENT 'Foreign key linking to the RPM program that monitors this metric',
    `created_timestamp` TIMESTAMP COMMENT 'Date-time when this program metric configuration record was first created.',
    `effective_date` DATE COMMENT 'Date when this metric configuration became active for the RPM program.',
    `end_date` DATE COMMENT 'Date when this metric was removed from the RPM program configuration (nullable for currently active metrics).',
    `is_primary_metric` BOOLEAN COMMENT 'Indicates whether this LOINC-coded metric is the primary monitored metric for the program (true) or a secondary/supplementary metric (false).',
    `measurement_frequency` STRING COMMENT 'Required frequency of measurement capture for this metric within this program (e.g., twice_daily, daily, weekly).',
    `target_range_high` DECIMAL(18,2) COMMENT 'The upper bound of the acceptable target range for this metric within this specific RPM program.',
    `target_range_low` DECIMAL(18,2) COMMENT 'The lower bound of the acceptable target range for this metric within this specific RPM program.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date-time of the most recent update to this program metric configuration.',
    CONSTRAINT pk_program_metric PRIMARY KEY(`program_metric_id`)
) COMMENT 'This association product represents the contractual configuration between an RPM program and a LOINC-coded metric it monitors. It captures the program-specific target ranges, measurement frequency requirements, and primary/secondary designation for each metric within each program. Each record links one RPM program to one LOINC code with clinical parameters that exist only in the context of this specific program-metric relationship.. Existence Justification: An RPM program monitors multiple vital signs/metrics (each identified by a LOINC code), and a single LOINC code (e.g., systolic blood pressure, blood glucose) can be monitored across multiple RPM programs. Clinical operations teams actively configure which LOINC-coded metrics each program tracks, with program-specific target ranges, measurement frequencies, and primary/secondary designations that vary per program-metric combination.';

CREATE TABLE IF NOT EXISTS `healthcare_ecm_v1`.`digital_health`.`cohort_program_assignment` (
    `cohort_program_assignment_id` BIGINT COMMENT 'System-generated unique identifier for the cohort-program assignment record.',
    `population_health_cohort_cohort_definition_id` BIGINT COMMENT 'Foreign key linking to the cohort definition targeted by the RPM program',
    `rpm_program_id` BIGINT COMMENT 'Foreign key linking to the RPM program that targets this cohort',
    `auto_enroll_enabled` BOOLEAN COMMENT 'Indicates whether patients entering this cohort are automatically enrolled in the linked RPM program without manual intervention.',
    `effective_end_date` DATE COMMENT 'Date when this program-cohort assignment expires and new enrollments from this cohort cease.',
    `effective_start_date` DATE COMMENT 'Date when this program-cohort assignment becomes active and cohort members become eligible for the RPM program.',
    `priority_rank` STRING COMMENT 'Numeric rank indicating which program takes precedence when a patient belongs to multiple cohorts assigned to overlapping programs.',
    CONSTRAINT pk_cohort_program_assignment PRIMARY KEY(`cohort_program_assignment_id`)
) COMMENT 'This association product represents the contractual assignment between an RPM program and a population health cohort definition. It captures which cohorts are targeted by which remote monitoring programs, with effective dating, priority ranking, and auto-enrollment configuration. Each record links one RPM program to one cohort definition with attributes that exist only in the context of this assignment relationship.. Existence Justification: In population health management, RPM programs target specific patient cohorts for enrollment, and a single cohort (e.g., elderly diabetics) may qualify for multiple RPM programs (glucose monitoring, hypertension monitoring) simultaneously. Care managers actively configure and manage these program-cohort assignments with effective dates, priority rankings, and auto-enrollment rules. This is an operational relationship that humans create, update, and retire as programs evolve.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_readings` ADD CONSTRAINT `fk_digital_health_rpm_device_readings_device_id` FOREIGN KEY (`device_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`device`(`device_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_readings` ADD CONSTRAINT `fk_digital_health_rpm_device_readings_rpm_enrollment_id` FOREIGN KEY (`rpm_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment`(`rpm_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_responses` ADD CONSTRAINT `fk_digital_health_prom_responses_prom_questionnaire_id` FOREIGN KEY (`prom_questionnaire_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire`(`prom_questionnaire_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ADD CONSTRAINT `fk_digital_health_rpm_enrollment_device_id` FOREIGN KEY (`device_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`device`(`device_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ADD CONSTRAINT `fk_digital_health_rpm_enrollment_rpm_program_id` FOREIGN KEY (`rpm_program_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`rpm_program`(`rpm_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ADD CONSTRAINT `fk_digital_health_rpm_reading_device_id` FOREIGN KEY (`device_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`device`(`device_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ADD CONSTRAINT `fk_digital_health_rpm_reading_rpm_enrollment_id` FOREIGN KEY (`rpm_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment`(`rpm_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ADD CONSTRAINT `fk_digital_health_rpm_reading_rpm_program_id` FOREIGN KEY (`rpm_program_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`rpm_program`(`rpm_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ADD CONSTRAINT `fk_digital_health_rpm_alert_threshold_device_id` FOREIGN KEY (`device_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`device`(`device_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ADD CONSTRAINT `fk_digital_health_rpm_alert_threshold_rpm_program_id` FOREIGN KEY (`rpm_program_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`rpm_program`(`rpm_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ADD CONSTRAINT `fk_digital_health_prom_response_device_id` FOREIGN KEY (`device_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`device`(`device_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ADD CONSTRAINT `fk_digital_health_prom_response_prom_questionnaire_id` FOREIGN KEY (`prom_questionnaire_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire`(`prom_questionnaire_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ADD CONSTRAINT `fk_digital_health_prom_response_rpm_enrollment_id` FOREIGN KEY (`rpm_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment`(`rpm_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ADD CONSTRAINT `fk_digital_health_health_alert_device_id` FOREIGN KEY (`device_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`device`(`device_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ADD CONSTRAINT `fk_digital_health_health_alert_rpm_alert_threshold_id` FOREIGN KEY (`rpm_alert_threshold_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold`(`rpm_alert_threshold_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ADD CONSTRAINT `fk_digital_health_health_alert_rpm_enrollment_id` FOREIGN KEY (`rpm_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment`(`rpm_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ADD CONSTRAINT `fk_digital_health_health_alert_rpm_program_id` FOREIGN KEY (`rpm_program_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`rpm_program`(`rpm_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ADD CONSTRAINT `fk_digital_health_health_alert_rpm_reading_id` FOREIGN KEY (`rpm_reading_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`rpm_reading`(`rpm_reading_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_reading` ADD CONSTRAINT `fk_digital_health_rpm_device_reading_device_id` FOREIGN KEY (`device_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`device`(`device_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_reading` ADD CONSTRAINT `fk_digital_health_rpm_device_reading_rpm_enrollment_id` FOREIGN KEY (`rpm_enrollment_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment`(`rpm_enrollment_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`program_monitoring_requirement` ADD CONSTRAINT `fk_digital_health_program_monitoring_requirement_rpm_program_id` FOREIGN KEY (`rpm_program_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`rpm_program`(`rpm_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`program_metric` ADD CONSTRAINT `fk_digital_health_program_metric_rpm_program_id` FOREIGN KEY (`rpm_program_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`rpm_program`(`rpm_program_id`);
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`cohort_program_assignment` ADD CONSTRAINT `fk_digital_health_cohort_program_assignment_rpm_program_id` FOREIGN KEY (`rpm_program_id`) REFERENCES `healthcare_ecm_v1`.`digital_health`.`rpm_program`(`rpm_program_id`);

-- ========= TAGS =========
ALTER SCHEMA `healthcare_ecm_v1`.`digital_health` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `healthcare_ecm_v1`.`digital_health` SET TAGS ('dbx_domain' = 'digital_health');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_readings` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_readings` SET TAGS ('dbx_subdomain' = 'remote_monitoring');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_readings` ALTER COLUMN `rpm_device_readings_id` SET TAGS ('dbx_business_glossary_term' = 'rpm_device_readings Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_readings` ALTER COLUMN `device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_readings` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_readings` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_readings` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_readings` ALTER COLUMN `body_position` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_readings` ALTER COLUMN `body_position` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_readings` ALTER COLUMN `body_site` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_readings` ALTER COLUMN `body_site` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_readings` ALTER COLUMN `device_serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_readings` ALTER COLUMN `device_serial_number` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_readings` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_readings` ALTER COLUMN `notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_readings` ALTER COLUMN `numeric_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_readings` ALTER COLUMN `numeric_value` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_readings` ALTER COLUMN `secondary_numeric_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_readings` ALTER COLUMN `secondary_numeric_value` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_readings` ALTER COLUMN `string_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_readings` ALTER COLUMN `string_value` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_responses` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_responses` SET TAGS ('dbx_subdomain' = 'patient_engagement');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_responses` ALTER COLUMN `prom_responses_id` SET TAGS ('dbx_business_glossary_term' = 'prom_responses Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_responses` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_responses` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_responses` ALTER COLUMN `prom_questionnaire_id` SET TAGS ('dbx_business_glossary_term' = 'Prom Questionnaire Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_events` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_events` SET TAGS ('dbx_subdomain' = 'patient_engagement');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_events` ALTER COLUMN `portal_engagement_events_id` SET TAGS ('dbx_business_glossary_term' = 'portal_engagement_events Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_events` ALTER COLUMN `proxy_access_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_events` ALTER COLUMN `proxy_access_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_events` ALTER COLUMN `geolocation_region` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_events` ALTER COLUMN `geolocation_region` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_events` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_events` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`digital_health_patient_engagement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`digital_health_patient_engagement` SET TAGS ('dbx_subdomain' = 'patient_engagement');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`digital_health_patient_engagement` ALTER COLUMN `digital_health_patient_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'digital_health_patient_engagement Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`digital_health_patient_engagement` ALTER COLUMN `digital_health_patient_engagement_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`digital_health_patient_engagement` ALTER COLUMN `digital_health_patient_engagement_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` SET TAGS ('dbx_subdomain' = 'remote_monitoring');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` SET TAGS ('dbx_delta_tuneFileSizesForRewrites' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` SET TAGS ('dbx_delta_autoOptimize_optimizeWrite' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` SET TAGS ('dbx_hipaa_retention_years' = '6');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier (DEV_ID)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (LOC_ID)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Asset Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (PAT_ID)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `trading_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `udi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Udi Record Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date (ACTIV_DATE)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `alert_threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Alert Threshold Unit (ALERT_THR_UNIT)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `alert_threshold_unit` SET TAGS ('dbx_value_regex' = 'bpm|mg/dL|mmHg|percent');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `alert_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Alert Threshold Value (ALERT_THR_VAL)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag (ASSET_TAG)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `asset_tag` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `asset_tag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `asset_tag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `battery_capacity_mah` SET TAGS ('dbx_business_glossary_term' = 'Battery Capacity (BAT_CAP_MAH)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `battery_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Battery Level Percent (BAT_LVL_PCT)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date (CALIB_DATE)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPL_STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `connectivity_protocol` SET TAGS ('dbx_business_glossary_term' = 'Connectivity Protocol (CONN_PROTO)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `connectivity_protocol` SET TAGS ('dbx_value_regex' = 'http|mqtt|coap');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `connectivity_type` SET TAGS ('dbx_business_glossary_term' = 'Connectivity Type (CONN_TYPE)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `connectivity_type` SET TAGS ('dbx_value_regex' = 'wifi|bluetooth|cellular|ethernet');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `data_retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Policy (RET_POLICY)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `data_retention_policy` SET TAGS ('dbx_value_regex' = '7_years|indefinite');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date (DECOM_DATE)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `deployment_status` SET TAGS ('dbx_business_glossary_term' = 'Deployment Status (DEPLOY_STAT)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `deployment_status` SET TAGS ('dbx_value_regex' = 'deployed|pending|failed|retired');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `device_category` SET TAGS ('dbx_business_glossary_term' = 'Device Category (DEV_CAT)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `device_category` SET TAGS ('dbx_value_regex' = 'vital_signs|medication_adherence|activity|glucose|cardiac');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `device_name` SET TAGS ('dbx_business_glossary_term' = 'Device Name (DEV_NAME)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type (DEV_TYPE)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'monitor|sensor|insulin_pump|wearable|implantable');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date (ENROLL_DATE)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status (ENROLL_STAT)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'enrolled|pending|withdrawn');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `firmware_update_available` SET TAGS ('dbx_business_glossary_term' = 'Firmware Update Available Flag (FW_UPDATE_AVAIL)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `firmware_update_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Update Version (FW_UPDATE_VER)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version (FW_VER)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `hardware_version` SET TAGS ('dbx_business_glossary_term' = 'Hardware Version (HW_VER)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address (IP_ADDR)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `ip_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `is_calibrated` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status Flag (CALIB_FLAG)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `is_secure` SET TAGS ('dbx_business_glossary_term' = 'Security Enabled Flag (SECURE_FLAG)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date (LAST_MAINT_DATE)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `last_reading_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reading Timestamp (LAST_READ_TS)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `last_reading_value` SET TAGS ('dbx_business_glossary_term' = 'Last Reading Value (LAST_READ_VAL)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `mac_address` SET TAGS ('dbx_business_glossary_term' = 'MAC Address (MAC_ADDR)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `mac_address` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `mac_address` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `mac_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `maintenance_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Interval (MAINT_INT_DAYS)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Device Manufacturer (MANUFACTURER)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number (MODEL_NO)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `reading_unit` SET TAGS ('dbx_business_glossary_term' = 'Reading Unit (READ_UNIT)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `reading_unit` SET TAGS ('dbx_value_regex' = 'bpm|mg/dL|mmHg|percent');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date (REG_DATE)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number (SERIAL_NO)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `serial_number` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `serial_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `serial_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `signal_strength_dbm` SET TAGS ('dbx_business_glossary_term' = 'Signal Strength (SIG_STR_DBM)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version (SW_VER)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Device Status Reason (STATUS_REASON)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date (WARRANTY_EXP_DATE)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (LOC_ID)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (PAT_ID)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`device` ALTER COLUMN `device_status_reason` SET TAGS ('dbx_business_glossary_term' = 'Device Status Reason (STATUS_REASON)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` SET TAGS ('dbx_subdomain' = 'remote_monitoring');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` SET TAGS ('dbx_delta_tuneFileSizesForRewrites' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` SET TAGS ('dbx_delta_autoOptimize_optimizeWrite' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` SET TAGS ('dbx_hipaa_retention_years' = '6');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `rpm_program_id` SET TAGS ('dbx_business_glossary_term' = 'Remote Patient Monitoring Program ID');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `care_program_id` SET TAGS ('dbx_business_glossary_term' = 'Care Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cdm Entry Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `compliance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `consent_form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Form Template Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Owner Employee Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `insurance_coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `population_health_cohort_mgmt_cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Target Cohort Definition Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `population_health_cohort_mgmt_cohort_definition_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `population_health_cohort_mgmt_cohort_definition_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Target Condition Snomed Concept Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `alert_threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Alert Threshold Unit');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `alert_threshold_unit` SET TAGS ('dbx_value_regex' = 'bpm|mg/dL|%|mmHg|steps');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `alert_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Alert Threshold Value');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `alert_type` SET TAGS ('dbx_business_glossary_term' = 'Alert Type');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `alert_type` SET TAGS ('dbx_value_regex' = 'threshold|trend|absence');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `billing_code` SET TAGS ('dbx_business_glossary_term' = 'Billing CPT Code');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `billing_rate` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `data_capture_frequency` SET TAGS ('dbx_business_glossary_term' = 'Data Capture Frequency');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `data_capture_frequency` SET TAGS ('dbx_value_regex' = 'continuous|hourly|daily|weekly');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Days)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'wearable|implantable|home_monitor|mobile_app');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Program Duration (Days)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Program Effective End Date');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `enrollment_criteria` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Criteria');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment End Date');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `enrollment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Start Date');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `is_pilot_program` SET TAGS ('dbx_business_glossary_term' = 'Pilot Program Flag');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `portal_access_enabled` SET TAGS ('dbx_business_glossary_term' = 'Portal Access Enabled');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Remote Patient Monitoring Program Code');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Remote Patient Monitoring Program Name');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `program_owner` SET TAGS ('dbx_business_glossary_term' = 'Program Owner Department');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Remote Patient Monitoring Program Type');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'chronic|post_acute|wellness|preventive|rehab');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `requires_consent` SET TAGS ('dbx_business_glossary_term' = 'Consent Required Flag');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `rpm_program_description` SET TAGS ('dbx_business_glossary_term' = 'Remote Patient Monitoring Program Description');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `rpm_program_status` SET TAGS ('dbx_business_glossary_term' = 'Remote Patient Monitoring Program Status');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `rpm_program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|completed|suspended|draft');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `sensor_type` SET TAGS ('dbx_business_glossary_term' = 'Sensor Type');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `sensor_type` SET TAGS ('dbx_value_regex' = 'heart_rate|glucose|blood_pressure|oxygen_saturation|weight');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Effective Start Date');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `description` SET TAGS ('dbx_business_glossary_term' = 'Remote Patient Monitoring Program Description');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Remote Patient Monitoring Program Status');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'active|inactive|completed|suspended|draft');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_program` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` SET TAGS ('dbx_subdomain' = 'remote_monitoring');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` SET TAGS ('dbx_delta_tuneFileSizesForRewrites' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` SET TAGS ('dbx_delta_autoOptimize_optimizeWrite' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` SET TAGS ('dbx_hipaa_retention_years' = '6');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `rpm_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Remote Patient Monitoring Enrollment ID');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `care_program_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Care Program Enrollment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `care_team_id` SET TAGS ('dbx_business_glossary_term' = 'Care Team Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `clinical_ai_patient_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Risk Score Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `data_sharing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Agreement Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Device Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Scheduling Appointment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `member_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Member Enrollment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Clinician Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `population_health_cohort_cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort Definition Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `population_health_cohort_cohort_definition_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `population_health_cohort_cohort_definition_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `population_health_cohort_management_cohort_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort Membership Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `population_health_cohort_management_cohort_membership_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `population_health_cohort_management_cohort_membership_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `population_health_cohort_mgmt_cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Cohort Definition Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `population_health_cohort_mgmt_cohort_definition_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `population_health_cohort_mgmt_cohort_definition_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `problem_id` SET TAGS ('dbx_business_glossary_term' = 'Problem Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `rpm_program_id` SET TAGS ('dbx_business_glossary_term' = 'RPM Program Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `alert_frequency` SET TAGS ('dbx_business_glossary_term' = 'Alert Frequency');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `alert_frequency` SET TAGS ('dbx_value_regex' = 'hourly|daily|weekly|monthly|as_needed');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `alert_threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Alert Threshold Unit');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `alert_threshold_unit` SET TAGS ('dbx_value_regex' = 'bpm|mmhg|mgdl|percent|celsius|fahrenheit');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `alert_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Alert Threshold Value');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'consented|declined|pending');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `data_retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Policy');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `data_retention_policy` SET TAGS ('dbx_value_regex' = '1yr|5yr|indefinite');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `device_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Device Serial Number');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `device_serial_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `device_serial_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `device_serial_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment End Date');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `enrollment_notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'patient_portal|clinic|referral|api|other');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|completed|terminated');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `hipaa_retention_annotation` SET TAGS ('dbx_business_glossary_term' = 'HIPAA Retention Annotation');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `hipaa_retention_annotation` SET TAGS ('dbx_Added_Unity_Catalog_tags_for_HIPAA_retention' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `portal_engagement_score` SET TAGS ('dbx_business_glossary_term' = 'Portal Engagement Score');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `portal_last_login` SET TAGS ('dbx_business_glossary_term' = 'Portal Last Login Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `prom_measure_name` SET TAGS ('dbx_business_glossary_term' = 'PROM Measure Name');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `prom_measure_unit` SET TAGS ('dbx_business_glossary_term' = 'PROM Measure Unit');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `prom_measure_unit` SET TAGS ('dbx_value_regex' = 'score|mmhg|mgdl|percent');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `prom_measure_value` SET TAGS ('dbx_business_glossary_term' = 'PROM Measure Value');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `prom_measure_value` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `prom_measure_value` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `prom_measure_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `terminated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Termination Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'patient_request|provider_decision|noncompliance|other');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_enrollment` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'RPM Program Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` SET TAGS ('dbx_subdomain' = 'remote_monitoring');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` SET TAGS ('dbx_delta_tuneFileSizesForRewrites' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` SET TAGS ('dbx_delta_autoOptimize_optimizeWrite' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` SET TAGS ('dbx_hipaa_retention_years' = '6');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` SET TAGS ('dbx_liquid_clustering' = 'patient_id');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` SET TAGS ('dbx_reading_timestamp' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `rpm_reading_id` SET TAGS ('dbx_business_glossary_term' = 'Remote Patient Monitoring Reading ID');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Remote Monitoring Device Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `rpm_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'RPM Program Enrollment Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `rpm_program_id` SET TAGS ('dbx_business_glossary_term' = 'RPM Program Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `alert_flag` SET TAGS ('dbx_business_glossary_term' = 'Alert Flag');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `alert_triggered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alert Triggered Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `battery_level` SET TAGS ('dbx_business_glossary_term' = 'Device Battery Level');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Device Firmware Version');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Device Latitude');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Device Longitude');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `measurement_type` SET TAGS ('dbx_value_regex' = 'heart_rate|blood_pressure|oxygen_saturation|glucose|temperature|respiratory_rate');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `measurement_value` SET TAGS ('dbx_business_glossary_term' = 'Measurement Value');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Reading Notes');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `patient_consent` SET TAGS ('dbx_business_glossary_term' = 'Patient Consent for RPM');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `reading_status` SET TAGS ('dbx_business_glossary_term' = 'Reading Status');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `reading_status` SET TAGS ('dbx_value_regex' = 'valid|invalid|suspect|missing');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `reading_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reading Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `signal_quality` SET TAGS ('dbx_business_glossary_term' = 'Signal Quality');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `signal_quality` SET TAGS ('dbx_value_regex' = 'good|fair|poor|bad|no_signal');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Epic|Cerner|Custom|ThirdParty');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Alert Threshold Value');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'bpm|mmHg|%|mg/dL|C|breaths/min');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'RPM Program Enrollment Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_reading` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'RPM Program Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` SET TAGS ('dbx_subdomain' = 'remote_monitoring');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` SET TAGS ('dbx_delta_tuneFileSizesForRewrites' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` SET TAGS ('dbx_delta_autoOptimize_optimizeWrite' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` SET TAGS ('dbx_hipaa_retention_years' = '6');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `rpm_alert_threshold_id` SET TAGS ('dbx_business_glossary_term' = 'RPM Alert Threshold ID');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device ID (DID)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID (PID)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Ordering Clinician Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID (UPDATER_ID)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `rpm_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID (CREATOR_ID)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `rpm_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `rpm_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `rpm_program_id` SET TAGS ('dbx_business_glossary_term' = 'Rpm Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_AT)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFFECTIVE_UNTIL)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFFECTIVE_FROM)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `escalation_policy` SET TAGS ('dbx_business_glossary_term' = 'Escalation Policy (ESCALATION)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `evaluation_result` SET TAGS ('dbx_business_glossary_term' = 'Last Evaluation Result (EVAL_RESULT)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `last_evaluated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Evaluated Timestamp (LAST_EVAL)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `lower_threshold` SET TAGS ('dbx_business_glossary_term' = 'Lower Threshold Value (LOWER_THRESHOLD)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `metric_code` SET TAGS ('dbx_business_glossary_term' = 'Metric Code (METRIC_CODE)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `metric_name` SET TAGS ('dbx_business_glossary_term' = 'Metric Name (METRIC_NAME)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel (CHANNEL)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `notification_channel` SET TAGS ('dbx_value_regex' = 'email|sms|app|pager');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `rpm_alert_threshold_description` SET TAGS ('dbx_business_glossary_term' = 'Alert Threshold Description (DESCRIPTION)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `rpm_alert_threshold_status` SET TAGS ('dbx_business_glossary_term' = 'Alert Threshold Status (STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `rpm_alert_threshold_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level (SEVERITY)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `threshold_type` SET TAGS ('dbx_business_glossary_term' = 'Threshold Type (THRESHOLD_TYPE)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `threshold_type` SET TAGS ('dbx_value_regex' = 'absolute|relative|percent');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_AT)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `upper_threshold` SET TAGS ('dbx_business_glossary_term' = 'Upper Threshold Value (UPPER_THRESHOLD)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID (PID)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Alert Threshold Status (STATUS)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `description` SET TAGS ('dbx_business_glossary_term' = 'Alert Threshold Description (DESCRIPTION)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `created_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID (CREATOR_ID)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_alert_threshold` ALTER COLUMN `updated_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID (UPDATER_ID)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` SET TAGS ('dbx_subdomain' = 'patient_engagement');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` SET TAGS ('dbx_delta_tuneFileSizesForRewrites' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` SET TAGS ('dbx_delta_autoOptimize_optimizeWrite' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` SET TAGS ('dbx_hipaa_retention_years' = '6');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `prom_questionnaire_id` SET TAGS ('dbx_business_glossary_term' = 'PROM Questionnaire ID');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `facility_organization_id` SET TAGS ('dbx_business_glossary_term' = 'Owning Organization ID');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Days)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `is_anonymous` SET TAGS ('dbx_business_glossary_term' = 'Anonymous Response Flag');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `is_deleted` SET TAGS ('dbx_business_glossary_term' = 'Soft Delete Flag');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `is_public` SET TAGS ('dbx_business_glossary_term' = 'Public Availability Flag');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `is_score_weighted` SET TAGS ('dbx_business_glossary_term' = 'Score Weighted Flag');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Questionnaire Language');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `license_contact_email` SET TAGS ('dbx_business_glossary_term' = 'License Contact Email');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `license_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `license_contact_email` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `license_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `license_contact_name` SET TAGS ('dbx_business_glossary_term' = 'License Contact Name');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `license_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `license_contact_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `license_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `license_name` SET TAGS ('dbx_business_glossary_term' = 'License Name');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `license_url` SET TAGS ('dbx_business_glossary_term' = 'License URL');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `licensing_type` SET TAGS ('dbx_business_glossary_term' = 'Licensing Type');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `licensing_type` SET TAGS ('dbx_value_regex' = 'proprietary|open_source|cc_by|cc_by_sa|custom');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `max_age` SET TAGS ('dbx_business_glossary_term' = 'Maximum Age');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `max_score` SET TAGS ('dbx_business_glossary_term' = 'Maximum Score');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `min_age` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `min_score` SET TAGS ('dbx_business_glossary_term' = 'Minimum Score');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `prom_questionnaire_description` SET TAGS ('dbx_business_glossary_term' = 'Questionnaire Description');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `prom_questionnaire_status` SET TAGS ('dbx_business_glossary_term' = 'Questionnaire Status');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `prom_questionnaire_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|retired|archived');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `question_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Questions');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `question_structure` SET TAGS ('dbx_business_glossary_term' = 'Question Structure JSON');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `required_consent` SET TAGS ('dbx_business_glossary_term' = 'Required Consent Flag');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `scoring_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Scoring Algorithm');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `scoring_scale` SET TAGS ('dbx_business_glossary_term' = 'Scoring Scale');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `survey_mode` SET TAGS ('dbx_business_glossary_term' = 'Survey Mode');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `survey_mode` SET TAGS ('dbx_value_regex' = 'online|paper|tablet|interview');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `target_population` SET TAGS ('dbx_business_glossary_term' = 'Target Population');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `target_population` SET TAGS ('dbx_value_regex' = 'adult|pediatric|geriatric|all|specific_condition');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Questionnaire Title');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `total_score_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Total Score');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `version_date` SET TAGS ('dbx_business_glossary_term' = 'Questionnaire Version Date');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `version_notes` SET TAGS ('dbx_business_glossary_term' = 'Version Release Notes');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Questionnaire Version Number');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `description` SET TAGS ('dbx_business_glossary_term' = 'Questionnaire Description');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Questionnaire Status');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|retired|archived');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_questionnaire` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Owning Organization ID');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` SET TAGS ('dbx_subdomain' = 'patient_engagement');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` SET TAGS ('dbx_delta_tuneFileSizesForRewrites' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` SET TAGS ('dbx_delta_autoOptimize_optimizeWrite' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` SET TAGS ('dbx_hipaa_retention_years' = '6');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `prom_response_id` SET TAGS ('dbx_business_glossary_term' = 'PROM Response ID');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `problem_id` SET TAGS ('dbx_business_glossary_term' = 'Problem Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `prom_questionnaire_id` SET TAGS ('dbx_business_glossary_term' = 'Questionnaire Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `rpm_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'RPM Program Enrollment Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Appointment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `subject_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Enrollment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `alert_threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Alert Threshold Unit');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `alert_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Alert Threshold Value');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `alert_triggered` SET TAGS ('dbx_business_glossary_term' = 'Alert Triggered Flag');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `answer_json` SET TAGS ('dbx_business_glossary_term' = 'Answer Set (JSON)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `consent_given` SET TAGS ('dbx_business_glossary_term' = 'Consent Given Flag');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source Type');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'self_report|clinician_assisted');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `interpretation` SET TAGS ('dbx_business_glossary_term' = 'Clinical Interpretation');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `interpretation` SET TAGS ('dbx_value_regex' = 'normal|abnormal|critical');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `is_test_response` SET TAGS ('dbx_business_glossary_term' = 'Test Response Flag');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Response Language Code');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = 'en|es|fr|de|zh|ar');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Response Notes');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `prom_response_status` SET TAGS ('dbx_business_glossary_term' = 'Response Status');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `prom_response_status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|cancelled');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Response Source Channel');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'portal|mobile_app|tablet|wearable|call_center');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `total_score` SET TAGS ('dbx_business_glossary_term' = 'Total PROM Score');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Questionnaire Version Number');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `questionnaire_id` SET TAGS ('dbx_business_glossary_term' = 'Questionnaire Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'RPM Program Enrollment Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `status` SET TAGS ('dbx_business_glossary_term' = 'Response Status');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|cancelled');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `encounter_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`prom_response` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` SET TAGS ('dbx_subdomain' = 'patient_engagement');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` SET TAGS ('dbx_delta_tuneFileSizesForRewrites' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` SET TAGS ('dbx_delta_autoOptimize_optimizeWrite' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` SET TAGS ('dbx_hipaa_retention_years' = '6');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` SET TAGS ('dbx_liquid_clustering' = 'patient_id');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` SET TAGS ('dbx_event_timestamp' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `portal_engagement_event_id` SET TAGS ('dbx_business_glossary_term' = 'Portal Engagement Event ID');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `portal_account_id` SET TAGS ('dbx_business_glossary_term' = 'Portal Account Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Appointment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'web|mobile|tablet');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `event_outcome` SET TAGS ('dbx_business_glossary_term' = 'Event Outcome');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `event_outcome` SET TAGS ('dbx_value_regex' = 'success|failure');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `event_payload` SET TAGS ('dbx_business_glossary_term' = 'Event Payload');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'login|message|document_view|appointment|lab_result_view');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `ingestion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ingestion Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `portal_session_code` SET TAGS ('dbx_business_glossary_term' = 'Session Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent String');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement_event` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Session Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` SET TAGS ('dbx_subdomain' = 'remote_monitoring');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` SET TAGS ('dbx_delta_tuneFileSizesForRewrites' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` SET TAGS ('dbx_delta_autoOptimize_optimizeWrite' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` SET TAGS ('dbx_hipaa_retention_years' = '6');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `health_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Health Alert ID');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `health_alert_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `health_alert_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `clinical_ai_model_card_id` SET TAGS ('dbx_business_glossary_term' = 'Model Card Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `clinical_ai_model_inference_log_id` SET TAGS ('dbx_business_glossary_term' = 'Model Inference Log Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier (Serial Number)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Resolved By Employee Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Loinc Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `post_acute_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Post Acute Episode Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Responding Clinician Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `rpm_alert_threshold_id` SET TAGS ('dbx_business_glossary_term' = 'Rpm Alert Threshold Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `rpm_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Rpm Enrollment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `rpm_program_id` SET TAGS ('dbx_business_glossary_term' = 'Rpm Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `rpm_reading_id` SET TAGS ('dbx_business_glossary_term' = 'Rpm Reading Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Id (Foreign Key)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `alert_category` SET TAGS ('dbx_business_glossary_term' = 'Alert Category');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `alert_category` SET TAGS ('dbx_value_regex' = 'vital_sign|device_error|patient_report|system');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `alert_description` SET TAGS ('dbx_business_glossary_term' = 'Alert Description');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `alert_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alert Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `metric_name` SET TAGS ('dbx_business_glossary_term' = 'Metric Name (e.g., Blood Pressure, Glucose)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'email|sms|push|phone');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Alert Resolution Status');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'open|closed|dismissed');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Alert Severity Level');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (e.g., mmHg, mg/dL)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (MRN)');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`health_alert` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_reading` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_reading` SET TAGS ('dbx_subdomain' = 'remote_monitoring');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `rpm_device_reading_id` SET TAGS ('dbx_business_glossary_term' = 'rpm_device_reading Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `clinical_note` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `clinical_note` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `value_numeric` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `value_numeric` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `value_secondary_numeric` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `value_secondary_numeric` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `value_string` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`rpm_device_reading` ALTER COLUMN `value_string` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement` SET TAGS ('dbx_subdomain' = 'patient_engagement');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement` ALTER COLUMN `portal_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'portal_engagement Identifier');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement` ALTER COLUMN `consent_session_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement` ALTER COLUMN `consent_session_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement` ALTER COLUMN `geolocation_region` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement` ALTER COLUMN `geolocation_region` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`portal_engagement` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`program_monitoring_requirement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`program_monitoring_requirement` SET TAGS ('dbx_subdomain' = 'remote_monitoring');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`program_monitoring_requirement` SET TAGS ('dbx_association_edges' = 'digital_health.rpm_program,laboratory.test_catalog');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`program_monitoring_requirement` ALTER COLUMN `program_monitoring_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Program Monitoring Requirement ID');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`program_monitoring_requirement` ALTER COLUMN `rpm_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Monitoring Requirement - Rpm Program Id');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`program_monitoring_requirement` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Program Monitoring Requirement - Test Catalog Id');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`program_monitoring_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`program_monitoring_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Effective Date');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`program_monitoring_requirement` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement End Date');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`program_monitoring_requirement` ALTER COLUMN `frequency_requirement` SET TAGS ('dbx_business_glossary_term' = 'Test Frequency Requirement');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`program_monitoring_requirement` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Test Flag');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`program_monitoring_requirement` ALTER COLUMN `monitoring_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Interval Days');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`program_monitoring_requirement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`program_metric` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`program_metric` SET TAGS ('dbx_subdomain' = 'remote_monitoring');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`program_metric` SET TAGS ('dbx_association_edges' = 'digital_health.rpm_program,reference.loinc_code');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`program_metric` ALTER COLUMN `program_metric_id` SET TAGS ('dbx_business_glossary_term' = 'Program Metric ID');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`program_metric` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'LOINC Code');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`program_metric` ALTER COLUMN `rpm_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Metric - Rpm Program Id');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`program_metric` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`program_metric` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`program_metric` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`program_metric` ALTER COLUMN `is_primary_metric` SET TAGS ('dbx_business_glossary_term' = 'Primary Metric Flag');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`program_metric` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`program_metric` ALTER COLUMN `target_range_high` SET TAGS ('dbx_business_glossary_term' = 'Target Range Upper Bound');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`program_metric` ALTER COLUMN `target_range_low` SET TAGS ('dbx_business_glossary_term' = 'Target Range Lower Bound');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`program_metric` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`cohort_program_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`cohort_program_assignment` SET TAGS ('dbx_subdomain' = 'remote_monitoring');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`cohort_program_assignment` SET TAGS ('dbx_association_edges' = 'digital_health.rpm_program,population_health_cohort.cohort_definition');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`cohort_program_assignment` ALTER COLUMN `cohort_program_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort Program Assignment ID');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`cohort_program_assignment` ALTER COLUMN `population_health_cohort_cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort Program Assignment - Cohort Definition Id');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`cohort_program_assignment` ALTER COLUMN `population_health_cohort_cohort_definition_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`cohort_program_assignment` ALTER COLUMN `population_health_cohort_cohort_definition_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`cohort_program_assignment` ALTER COLUMN `rpm_program_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort Program Assignment - Rpm Program Id');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`cohort_program_assignment` ALTER COLUMN `auto_enroll_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto-Enrollment Enabled Flag');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`cohort_program_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective End Date');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`cohort_program_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective Start Date');
ALTER TABLE `healthcare_ecm_v1`.`digital_health`.`cohort_program_assignment` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Program Priority Rank');
