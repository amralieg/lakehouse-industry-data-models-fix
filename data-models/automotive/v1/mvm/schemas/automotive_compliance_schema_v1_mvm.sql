-- Schema for Domain: compliance | Business: Automotive | Version: v1_mvm
-- Generated on: 2026-05-07 02:20:08

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `automotive_ecm`.`compliance` COMMENT 'Regulatory compliance and homologation management across all global markets. Owns CAFE (Corporate Average Fuel Economy) reporting, EPA/CARB emissions certifications, NHTSA FMVSS homologation records, WLTP/Euro NCAP test submissions, UNECE type approvals, and recall regulatory filings. Manages compliance testing, certification documentation, regulatory submissions, and audit trails. Ensures adherence to environmental, safety, and trade regulations across jurisdictions.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `automotive_ecm`.`compliance`.`homologation_record` (
    `homologation_record_id` BIGINT COMMENT 'Unique surrogate key for the homologation record.',
    `configuration_id` BIGINT COMMENT 'Foreign key linking to vehicle.configuration. Business justification: EU/UNECE Whole Vehicle Type Approval is issued per specific configuration (body style, drivetrain, transmission). Homologation records must reference the exact configuration certified. body_style, dri',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: homologation_record.market_jurisdiction is a denormalized string representing the regulatory jurisdiction for the type approval. The jurisdiction table is the authoritative reference master for all re',
    `model_id` BIGINT COMMENT 'Foreign key linking to vehicle.model. Business justification: Homologation records certify a specific vehicle model for market approval; FK to model ties approvals to the correct model definition.',
    `powertrain_variant_id` BIGINT COMMENT 'Foreign key linking to vehicle.powertrain_variant. Business justification: EU type approval and UNECE regulations certify specific powertrain variants. Homologation records reference engine displacement, fuel type, and transmission — all powertrain_variant attributes. engine',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: homologation_record.regulatory_reference is a denormalized string referencing the applicable regulation (e.g., FMVSS 208, WLTP, Euro 6). The regulatory_requirement table is the authoritative reference',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Homologation records certify specific vehicle programs for market entry. The homologation_record has vehicle_model and model_year as denormalized plain-text fields. Direct FK to vehicle_program normal',
    `approval_name` STRING COMMENT 'Human‑readable name of the homologation approval.',
    `approval_number` STRING COMMENT 'Official approval number or certificate identifier issued by the regulatory authority.',
    `approval_status_date` DATE COMMENT 'Date when the current status was assigned to the approval.',
    `approval_type` STRING COMMENT 'Category of the approval (e.g., type approval, certification, test, homologation).. Valid values are `type_approval|type_certification|type_test|type_homologation`',
    `certification_document_url` STRING COMMENT 'Link to the electronic copy of the certification document.',
    `co2_emissions_g_per_km` DECIMAL(18,2) COMMENT 'Measured CO2 emissions in grams per kilometer.',
    `compliance_notes` STRING COMMENT 'Free‑form notes regarding special conditions, exemptions, or observations.',
    `document_version` STRING COMMENT 'Version identifier of the certification document.',
    `effective_date` DATE COMMENT 'Date from which the approval is effective for sales.',
    `expiration_date` DATE COMMENT 'Date on which the approval expires or must be renewed.',
    `fuel_consumption_l_per_100km` DECIMAL(18,2) COMMENT 'Measured fuel consumption in liters per 100 kilometers.',
    `homologation_record_status` STRING COMMENT 'Current lifecycle status of the homologation record.. Valid values are `pending|approved|rejected|revoked|expired`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the homologation record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the homologation record.',
    `regulatory_body` STRING COMMENT 'Authority that issued the approval.. Valid values are `NHTSA|EPA|EURO_NCAP|UNECE|CARB|DOT`',
    `test_cycle` STRING COMMENT 'Regulatory test cycle used for emissions and fuel consumption testing.. Valid values are `WLTP|NEDC|EPA|ECE|Euro_5|Euro_6`',
    `test_date` DATE COMMENT 'Date on which the regulatory test was performed.',
    `test_lab` STRING COMMENT 'Name of the accredited laboratory that performed the test.',
    `updated_by` STRING COMMENT 'Identifier of the user who last modified the record.',
    `vehicle_type` STRING COMMENT 'Broad classification of the vehicle.. Valid values are `passenger|commercial|truck|suv|motorcycle|utility`',
    `created_by` STRING COMMENT 'Identifier of the user who created the record.',
    CONSTRAINT pk_homologation_record PRIMARY KEY(`homologation_record_id`)
) COMMENT 'Master record for vehicle type approval and homologation certifications across global markets. Captures UNECE type approval numbers, FMVSS homologation status, Euro NCAP ratings, WLTP certification references, and jurisdiction-specific approval details for each vehicle model and variant. Serves as the authoritative SSOT for all regulatory type approvals required before a vehicle can be sold in a given market.';

CREATE OR REPLACE TABLE `automotive_ecm`.`compliance`.`regulatory_submission` (
    `regulatory_submission_id` BIGINT COMMENT 'System-generated unique identifier for each regulatory submission record.',
    `apqp_plan_id` BIGINT COMMENT 'Foreign key linking to quality.apqp_plan. Business justification: Regulatory submissions (type approval, certification applications) require APQP documentation as evidence of design validation and production readiness. Compliance teams must trace submissions to APQP',
    `configuration_id` BIGINT COMMENT 'Foreign key linking to vehicle.configuration. Business justification: CAFE and EPA regulatory submissions are filed at configuration level (specific powertrain/trim combinations), not only at VIN level. Existing vin_registry_id covers individual vehicles; configuration_',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: regulatory_submission.jurisdiction is a denormalized STRING column representing the regulatory jurisdiction for the submission. The jurisdiction table is the authoritative reference master. Adding jur',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: A regulatory submission is typically made to fulfill a specific compliance obligation (e.g., submitting CAFE data to satisfy a CAFE reporting obligation, or filing an emissions certification to satisf',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Associate each regulatory submission with the specific regulatory requirement it satisfies.',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Regulatory submissions (CAFE, emission certification, safety certification) are made for specific vehicle programs. The regulatory_submission has vehicle_model_year and vehicle_type as denormalized fi',
    `vin_registry_id` BIGINT COMMENT 'Foreign key linking to vehicle.vin_registry. Business justification: Regulatory submissions often reference a specific vehicle VIN; linking to vin_registry enables validation of VIN status and history for compliance reporting.',
    `approval_date` DATE COMMENT 'Date the regulatory body approved the submission.',
    `cafe_value` DECIMAL(18,2) COMMENT 'Reported CAFE metric associated with the submission, expressed in mpg.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the submission record was first created in the system.',
    `document_path` STRING COMMENT 'File system or storage URI where the submission package is stored.',
    `document_version` STRING COMMENT 'Version identifier of the submitted document (e.g., v1.0).',
    `effective_from` DATE COMMENT 'Date from which the submitted certification or approval becomes effective.',
    `effective_until` DATE COMMENT 'Expiration date of the certification or approval, if applicable.',
    `emission_standard` STRING COMMENT 'Applicable emissions regulation (e.g., EPA Tier 3, Euro 6).',
    `fee_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the fee.. Valid values are `^[A-Z]{3}$`',
    `fee_gross_amount` DECIMAL(18,2) COMMENT 'Total fee charged before taxes or adjustments.',
    `fee_net_amount` DECIMAL(18,2) COMMENT 'Net fee after tax and any discounts.',
    `fee_tax_amount` DECIMAL(18,2) COMMENT 'Tax component of the submission fee.',
    `fuel_type` STRING COMMENT 'Primary propulsion technology of the vehicle(s) covered.. Valid values are `gasoline|diesel|hybrid|electric|hydrogen`',
    `is_critical` BOOLEAN COMMENT 'Flag indicating whether the submission is critical for regulatory compliance.',
    `is_urgent` BOOLEAN COMMENT 'Flag indicating whether the submission requires expedited handling.',
    `regulatory_body_code` STRING COMMENT 'Code of the governing body receiving the submission.. Valid values are `NHTSA|EPA|CARB|UNECE|Euro_NCAP|DOT`',
    `regulatory_body_name` STRING COMMENT 'Full name of the regulatory authority (e.g., National Highway Traffic Safety Administration).',
    `regulatory_submission_status` STRING COMMENT 'Current lifecycle status of the submission.. Valid values are `submitted|acknowledged|approved|rejected|under_review`',
    `rejection_reason` STRING COMMENT 'Textual explanation provided by the regulator when a submission is rejected.',
    `reviewer_comments` STRING COMMENT 'Internal comments from the compliance reviewer regarding the submission.',
    `status_change_date` DATE COMMENT 'Date when the status last transitioned.',
    `submission_category` STRING COMMENT 'Indicates whether the submission is for domestic market, export market, or both.. Valid values are `domestic|export|both`',
    `submission_date` DATE COMMENT 'Date the submission was formally sent to the regulatory authority.',
    `submission_reference_number` STRING COMMENT 'External reference number assigned by the regulatory body or internal tracking system.',
    `submission_type` STRING COMMENT 'Category of the regulatory filing (e.g., type approval, recall notice).. Valid values are `type_approval|certificate_of_conformity|recall_notice|cafe_report|safety_compliance_report`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the submission record.',
    CONSTRAINT pk_regulatory_submission PRIMARY KEY(`regulatory_submission_id`)
) COMMENT 'Transactional record for each formal regulatory submission made to a governing body (NHTSA, EPA, CARB, UNECE, Euro NCAP, DOT). Captures submission type (type approval application, certificate of conformity, recall notice, CAFE report, safety standard compliance report), submission date, regulatory body, submission reference number, status (submitted, acknowledged, approved, rejected, under review), and responsible compliance officer. Central audit trail for all outbound regulatory filings.';

CREATE OR REPLACE TABLE `automotive_ecm`.`compliance`.`recall_campaign` (
    `recall_campaign_id` BIGINT COMMENT 'Unique identifier for the compliance_recall_campaign data product (auto-inserted pre-linking).',
    `configuration_id` BIGINT COMMENT 'Foreign key linking to vehicle.configuration. Business justification: Recall campaigns often target specific configurations (e.g., only AWD variants with a specific ECU). NHTSA Part 573 filings require identification of affected configurations. This enables precise reca',
    `model_id` BIGINT COMMENT 'Foreign key linking to vehicle.model. Business justification: NHTSA and global recall filings identify affected vehicle models. Recall campaigns are initiated at model level for safety defect remediation. A compliance domain expert would immediately expect recal',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Recall campaigns are triggered by defective parts. Linking recall_campaign to part_master enables root cause traceability — identifying which part caused the recall, its supplier, and all affected BOM',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Link recall campaign to the regulatory requirement that triggered the recall.',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Recall campaigns target vehicles from specific vehicle programs. NHTSA and global recall management requires linking each recall to the affected vehicle program for scope determination, owner notifica',
    CONSTRAINT pk_recall_campaign PRIMARY KEY(`recall_campaign_id`)
) COMMENT 'Master record for NHTSA safety recall campaigns and OEM-initiated service campaigns. Captures NHTSA recall number, campaign type (safety recall, emissions recall, OEM voluntary service campaign), defect description, affected population (VIN range, model year, nameplate), remedy description, campaign open date, remedy availability date, and campaign closure status. Serves as the compliance SSOT for recall management, distinct from aftersales.recall_completion which tracks dealer-level execution.';

CREATE OR REPLACE TABLE `automotive_ecm`.`compliance`.`test_event` (
    `test_event_id` BIGINT COMMENT 'System-generated unique identifier for the compliance test event record.',
    `configuration_id` BIGINT COMMENT 'Foreign key linking to vehicle.configuration. Business justification: Emissions and safety test events (WLTP, EPA, NCAP) are conducted on specific vehicle configurations. vehicle_model_code, vehicle_model_year, vehicle_variant are denormalized configuration identifiers.',
    `control_plan_id` BIGINT COMMENT 'Foreign key linking to quality.control_plan. Business justification: Compliance test events (emissions, crash, durability) validate that control plan parameters meet regulatory limits. Test engineers reference control plans to verify production process capability suppo',
    `homologation_id` BIGINT COMMENT 'Identifier of the homologation record associated with this test.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Identify the obligation that the test event is validating.',
    `powertrain_variant_id` BIGINT COMMENT 'Foreign key linking to vehicle.powertrain_variant. Business justification: WLTP, EPA, and emissions certification tests are specific to powertrain variants. Regulatory bodies require test results linked to exact powertrain (displacement, fuel type, motor power). powertrain_t',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Connect test events to the regulatory requirement they are designed to meet.',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Compliance test events are conducted for specific vehicle programs. The test_event has vehicle_model_code and vehicle_model_year as denormalized plain-text fields. Linking to vehicle_program normalize',
    `ambient_humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity percentage at the test site.',
    `ambient_pressure_kpa` DECIMAL(18,2) COMMENT 'Barometric pressure at the test site in kilopascals.',
    `ambient_temperature_c` DECIMAL(18,2) COMMENT 'Ambient air temperature measured at the test site in degrees Celsius.',
    `certification_body` STRING COMMENT 'Regulatory authority or organization issuing the certification.',
    `certification_number` STRING COMMENT 'Official certification number assigned after successful test.',
    `certification_status` STRING COMMENT 'Current status of the regulatory certification linked to this test.. Valid values are `pending|issued|rejected|withdrawn`',
    `created_by_user` STRING COMMENT 'User identifier who initially created the record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the test event record was first created in the system.',
    `data_source_system` STRING COMMENT 'Originating operational system of record (e.g., SAP QM, Apriso MES).',
    `is_retest` BOOLEAN COMMENT 'True if the test is a repeat of a prior failed or conditional test.',
    `measured_unit` STRING COMMENT 'Unit of the measured value (e.g., g/km, km/h, dB).',
    `measured_value` DECIMAL(18,2) COMMENT 'Primary quantitative measurement recorded (e.g., CO2 g/km, g-force).',
    `notes` STRING COMMENT 'Free-text field for additional observations or comments.',
    `pass_fail_flag` BOOLEAN COMMENT 'Boolean indicator where true = pass, false = fail.',
    `regulatory_jurisdiction` STRING COMMENT 'Geographic or market jurisdiction governing the test (e.g., US, EU).',
    `result` STRING COMMENT 'Overall outcome of the test (pass, fail, or conditional).. Valid values are `pass|fail|conditional`',
    `retest_reason` STRING COMMENT 'Explanation why a retest was required.',
    `test_batch_number` STRING COMMENT 'Identifier for the group of tests executed together.',
    `test_category` STRING COMMENT 'Broad classification of the test (emissions, crash safety, noise, etc.).. Valid values are `emissions|crash|noise|fuel_economy|range|charging`',
    `test_condition` STRING COMMENT 'Operational condition under which the test was performed (e.g., cold start, hot start).',
    `test_equipment_name` STRING COMMENT 'Descriptive name of the test equipment.',
    `test_event_number` STRING COMMENT 'External reference number assigned to the test event by the testing facility.',
    `test_event_status` STRING COMMENT 'Current lifecycle status of the test event.. Valid values are `planned|in_progress|completed|passed|failed|cancelled`',
    `test_facility` STRING COMMENT 'Name of the laboratory or proving ground where the test was conducted.',
    `test_location` STRING COMMENT 'Geographic location (city, state, country) of the test facility.',
    `test_operator_name` STRING COMMENT 'Full name of the test operator.',
    `test_program` STRING COMMENT 'Name of the specific testing program or campaign (e.g., EPA Tier 3, Euro NCAP).',
    `test_sequence_number` STRING COMMENT 'Ordinal number of the test within a batch or campaign.',
    `test_timestamp` TIMESTAMP COMMENT 'Date and time when the physical compliance test was performed.',
    `test_type` STRING COMMENT 'Standardized test program or protocol applied (e.g., WLTP, NCAP).. Valid values are `WLTP|FTP-75|NEDC|RDE|NCAP|FMVSS`',
    `updated_by_user` STRING COMMENT 'User identifier who last modified the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the test event record.',
    CONSTRAINT pk_test_event PRIMARY KEY(`test_event_id`)
) COMMENT 'Transactional record capturing each physical compliance test event conducted for regulatory certification purposes. Covers emissions testing (WLTP, FTP-75, NEDC, RDE), crash safety testing (NCAP, FMVSS), noise testing (NVH/ECE R51), and fuel economy testing. Captures test date, test facility, test type, vehicle configuration tested, test result (pass/fail/conditional), measured values, and the certifying laboratory. Links to the homologation record or emissions certification being pursued.';

CREATE OR REPLACE TABLE `automotive_ecm`.`compliance`.`compliance_test_result` (
    `compliance_test_result_id` BIGINT COMMENT 'Unique identifier for the compliance test result record.',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Compliance test results for emission components and safety parts must reference the specific part tested. Substance compliance audits (REACH, RoHS) and safety certification require tracing test result',
    `test_event_id` BIGINT COMMENT 'Identifier of the parent compliance test event to which this result belongs.',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Compliance test results are associated with specific vehicle programs for regulatory reporting (CAFE, WLTP, NCAP fleet averages). Program-level compliance dashboards and regulatory submissions require',
    `calibration_status` STRING COMMENT 'Indicates whether the test equipment was calibrated at the time of measurement.. Valid values are `calibrated|uncalibrated|pending`',
    `comments` STRING COMMENT 'Free‑text notes or observations related to the measurement.',
    `compliance_regulation_code` STRING COMMENT 'Code identifying the specific regulation or standard applied (e.g., EPA_2023_CO2).',
    `data_source_system` STRING COMMENT 'System of record that supplied the measurement data.. Valid values are `SAP_QM|MES|PLM|Custom`',
    `is_outlier` BOOLEAN COMMENT 'True if the measurement is flagged as a statistical outlier.',
    `jurisdiction` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code of the regulatory jurisdiction.',
    `lab_location_code` STRING COMMENT 'Code representing the facility where the test was performed.',
    `limit_unit` STRING COMMENT 'Unit of the regulatory limit; typically matches the measurement unit.. Valid values are `g/km|mg/km|dB|mm|kg|%`',
    `measured_value` DECIMAL(18,2) COMMENT 'Numeric result of the measurement for the parameter.',
    `measurement_method` STRING COMMENT 'Technique used to obtain the measurement.. Valid values are `lab|in_vehicle|simulation`',
    `measurement_pressure_kpa` DECIMAL(18,2) COMMENT 'Ambient or chamber pressure during the measurement, expressed in kilopascals.',
    `measurement_temperature_c` DECIMAL(18,2) COMMENT 'Ambient or chamber temperature during the measurement, expressed in degrees Celsius.',
    `measurement_uncertainty` DECIMAL(18,2) COMMENT 'Estimated uncertainty associated with the measured value.',
    `parameter_code` STRING COMMENT 'Standardized code or identifier for the measured parameter.',
    `parameter_name` STRING COMMENT 'Descriptive name of the measured parameter (e.g., CO2, NOx, crash deformation zone).',
    `pass_fail_status` STRING COMMENT 'Indicates whether the measured value meets the regulatory limit.. Valid values are `pass|fail|conditional`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the result record was initially created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the result record.',
    `regulatory_limit` DECIMAL(18,2) COMMENT 'Maximum allowable value for the parameter as defined by the applicable regulation.',
    `test_batch_number` STRING COMMENT 'Identifier for the batch of specimens or vehicles tested together.',
    `test_phase` STRING COMMENT 'Specific phase of the compliance test (e.g., cold start, WLTP low speed).. Valid values are `cold_start|hot_start|wl_tp_low|wl_tp_medium|wl_tp_high|wl_tp_extra_high`',
    `test_result_status` STRING COMMENT 'Current lifecycle status of the result record.. Valid values are `recorded|reviewed|approved`',
    `test_timestamp` TIMESTAMP COMMENT 'Date and time when the measurement was taken.',
    `uncertainty_unit` STRING COMMENT 'Unit of the measurement uncertainty, matching the measurement unit.. Valid values are `g/km|mg/km|dB|mm|kg|%`',
    `unit_of_measure` STRING COMMENT 'Unit in which the measured value is expressed.. Valid values are `g/km|mg/km|dB|mm|kg|%`',
    CONSTRAINT pk_compliance_test_result PRIMARY KEY(`compliance_test_result_id`)
) COMMENT 'Detailed test result record for each measured parameter within a compliance test event. Captures parameter name (CO2 g/km, NOx mg/km, crash deformation zone, noise dB), measured value, regulatory limit, pass/fail status, test phase (cold start, hot start, WLTP low/medium/high/extra-high), and measurement uncertainty. Enables granular traceability of test outcomes against specific regulatory thresholds for each parameter tested.';

CREATE OR REPLACE TABLE `automotive_ecm`.`compliance`.`regulatory_requirement` (
    `regulatory_requirement_id` BIGINT COMMENT 'System-generated unique identifier for each regulatory requirement record.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Specify the jurisdiction for each regulatory requirement.',
    `compliance_deadline` DATE COMMENT 'Latest date by which Automotive must achieve compliance.',
    `compliance_requirement_summary` STRING COMMENT 'Brief summary of the key compliance obligations imposed by the regulation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the regulatory requirement record was first created in the system.',
    `effective_date` DATE COMMENT 'Date on which the regulation becomes effective.',
    `expiry_date` DATE COMMENT 'Date on which the regulation is no longer applicable (if applicable).',
    `is_global` BOOLEAN COMMENT 'True if the regulation applies across all markets; false if market‑specific.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether compliance with the regulation is mandatory (true) or optional (false).',
    `issuing_body` STRING COMMENT 'Organization that issued the regulation (e.g., NHTSA, EPA, UNECE, IATF).',
    `last_review_date` DATE COMMENT 'Date when the regulation was last reviewed for updates or changes.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this record.',
    `market` STRING COMMENT 'Geographic market or jurisdiction to which the regulation applies.. Valid values are `US|EU|CA|JP|CN|KR`',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or comments.',
    `powertrain_type` STRING COMMENT 'Powertrain technologies to which the regulation applies.. Valid values are `ICE|EV|HEV|PHEV|FCEV`',
    `reference_document_number` STRING COMMENT 'Official document number or docket identifier used by the issuing body.',
    `regulation_code` STRING COMMENT 'Official code or identifier assigned by the issuing body (e.g., "FMVSS 208", "ECE R94").',
    `regulation_type` STRING COMMENT 'High‑level classification of the regulation purpose.. Valid values are `safety|emissions|fuel_economy|equipment|environment|homologation`',
    `regulatory_requirement_name` STRING COMMENT 'Human‑readable name or title of the regulation (e.g., "Federal Motor Vehicle Safety Standard 208").',
    `regulatory_requirement_status` STRING COMMENT 'Current lifecycle state of the regulation.. Valid values are `active|superseded|proposed|withdrawn`',
    `scope_description` STRING COMMENT 'Narrative description of the regulations applicability and scope.',
    `source_document_url` STRING COMMENT 'Link to the official regulation document or web page.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the regulatory requirement record.',
    `vehicle_category` STRING COMMENT 'Vehicle segment covered by the regulation. [ENUM-REF-CANDIDATE: passenger|light_truck|heavy_truck|commercial|motorcycle|electric|hybrid — 7 candidates stripped; promote to reference product]',
    `version` STRING COMMENT 'Version or revision identifier of the regulation (e.g., "v2.1").',
    CONSTRAINT pk_regulatory_requirement PRIMARY KEY(`regulatory_requirement_id`)
) COMMENT 'Reference master defining all applicable regulatory requirements and standards that Automotive must comply with across jurisdictions. Captures regulation name, issuing body (NHTSA, EPA, CARB, UNECE, IATF, ISO), regulation code (e.g., FMVSS 208, ECE R94, Euro 6d), effective date, applicability scope (market, vehicle category, powertrain type), compliance deadline, and current status (active, superseded, proposed). Serves as the regulatory obligation register.';

CREATE OR REPLACE TABLE `automotive_ecm`.`compliance`.`jurisdiction` (
    `jurisdiction_id` BIGINT COMMENT 'System-generated unique identifier for the jurisdiction record.',
    `parent_jurisdiction_id` BIGINT COMMENT 'Identifier of the parent jurisdiction for hierarchical grouping (e.g., state belongs to a country).',
    `cafe_target_gpm` DECIMAL(18,2) COMMENT 'Corporate Average Fuel Economy target for the jurisdiction expressed in grams per mile.',
    `compliance_documentation_url` STRING COMMENT 'Link to the repository of official compliance documents for the jurisdiction.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the jurisdiction record was first created in the system.',
    `currency_code` STRING COMMENT 'Default currency used for financial reporting in this jurisdiction.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date when the jurisdiction became active for Automotives compliance tracking.',
    `emissions_standard_tier` STRING COMMENT 'Applicable emissions certification tier (e.g., EPA Tier 2, Euro 6, WLTP) for vehicles sold in this jurisdiction.',
    `epa_emission_limit_g_per_km` DECIMAL(18,2) COMMENT 'Maximum permissible emissions level for vehicles under EPA standards in this jurisdiction.',
    `expiry_date` DATE COMMENT 'Date when the jurisdiction record is retired or no longer applicable (nullable).',
    `homologation_process_time_days` STRING COMMENT 'Typical number of calendar days required to complete homologation.',
    `is_eu_member` BOOLEAN COMMENT 'Indicates whether the jurisdiction is a member of the European Union.',
    `iso_country_code` STRING COMMENT 'Three‑letter ISO country code representing the jurisdictions primary country.. Valid values are `^[A-Z]{3}$`',
    `jurisdiction_description` STRING COMMENT 'Free‑form text providing additional context or notes about the jurisdiction.',
    `jurisdiction_name` STRING COMMENT 'Official name of the regulatory jurisdiction (e.g., United States, European Union).',
    `jurisdiction_status` STRING COMMENT 'Current lifecycle status of the jurisdiction record.. Valid values are `active|inactive|pending|retired|suspended`',
    `jurisdiction_type` STRING COMMENT 'Classification of the jurisdiction based on its governmental level.. Valid values are `federal|state|national|supranational|regional|local`',
    `market_entry_requirements` STRING COMMENT 'Key regulatory and administrative conditions required for market entry (e.g., certification documents, testing procedures).',
    `ncap_rating_required` STRING COMMENT 'Minimum NCAP safety rating required for vehicles sold in the jurisdiction.',
    `recall_reporting_requirement` STRING COMMENT 'Regulatory requirement for vehicle recall reporting in the jurisdiction.',
    `region_code` STRING COMMENT 'Code used to group jurisdictions into broader regions (e.g., NA for North America, EU for Europe).',
    `regulatory_body_website` STRING COMMENT 'Web address of the primary regulatory authority.',
    `safety_standard_framework` STRING COMMENT 'Safety regulation framework governing vehicle homologation (e.g., FMVSS, UNECE, NCAP).',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'Typical statutory tax rate applied to vehicle sales in the jurisdiction.',
    `unece_type_approval_code` STRING COMMENT 'Code representing UNECE type approval classification for the jurisdiction.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the jurisdiction record.',
    `wltp_test_cycle` STRING COMMENT 'Specific WLTP test cycle applicable (e.g., WLTP 2020).',
    CONSTRAINT pk_jurisdiction PRIMARY KEY(`jurisdiction_id`)
) COMMENT 'Reference master for regulatory jurisdictions in which Automotive operates and sells vehicles. Captures jurisdiction name, jurisdiction type (federal, state, national, supranational), country or region code, primary regulatory body, applicable emissions standard tier, applicable safety standard framework, and market entry requirements. Used to map vehicles and certifications to the correct regulatory regime for each sales market.';

CREATE OR REPLACE TABLE `automotive_ecm`.`compliance`.`obligation` (
    `obligation_id` BIGINT COMMENT 'System-generated unique identifier for the compliance obligation record.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Add jurisdiction reference to obligations for regional compliance tracking.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Connect obligations to the specific regulatory requirement they fulfill.',
    `vehicle_program_id` BIGINT COMMENT 'Identifier of the vehicle program or model line to which the obligation applies.',
    `actual_certification_date` DATE COMMENT 'Date on which certification was actually obtained.',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance obligation record was first created in the system.',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the compliance obligation record.',
    `certification_body` STRING COMMENT 'External agency or authority that issues the certification (e.g., EPA, NHTSA).',
    `compliance_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) reflecting overall compliance health for the obligation.',
    `corrective_action_due_date` DATE COMMENT 'Deadline for completing corrective actions.',
    `corrective_action_plan` STRING COMMENT 'Planned actions to remediate non‑compliance.',
    `effective_from` DATE COMMENT 'Date when the compliance obligation becomes effective.',
    `effective_until` DATE COMMENT 'Date when the compliance obligation expires or is no longer applicable.',
    `emission_value` DECIMAL(18,2) COMMENT 'Measured emission metric (e.g., g/km CO₂) associated with the obligation.',
    `evidence_document_path` STRING COMMENT 'File system or URL path to supporting evidence files.',
    `fuel_economy_value` DECIMAL(18,2) COMMENT 'Measured fuel economy (e.g., mpg or L/100km) relevant to the obligation.',
    `is_critical` BOOLEAN COMMENT 'Flag indicating whether the obligation is deemed critical for vehicle launch.',
    `is_regulatory` BOOLEAN COMMENT 'True if the obligation is mandated by external regulation; false if internal policy.',
    `last_review_date` DATE COMMENT 'Date when the obligation was last reviewed for status or changes.',
    `model_year` STRING COMMENT 'Model year of the vehicle program for which the regulatory requirement is scoped.',
    `next_review_date` DATE COMMENT 'Planned date for the next compliance review.',
    `non_compliance_reason` STRING COMMENT 'Root cause description for a non‑compliant status.',
    `notes` STRING COMMENT 'Free‑form comments or additional information about the obligation.',
    `obligation_number` STRING COMMENT 'Business identifier assigned to the regulatory obligation, often used in internal tracking and external filings.',
    `obligation_status` STRING COMMENT 'Current lifecycle status of the compliance obligation.. Valid values are `pending|in_progress|certified|waived|non_compliant`',
    `priority` STRING COMMENT 'Business priority assigned to the obligation.. Valid values are `low|medium|high`',
    `responsible_engineering_group` STRING COMMENT 'Human‑readable name of the engineering group leading the compliance effort.',
    `risk_level` STRING COMMENT 'Assessed risk associated with non‑compliance for this obligation.. Valid values are `low|medium|high|critical`',
    `target_certification_date` DATE COMMENT 'Planned date by which certification is expected to be achieved.',
    `test_date` DATE COMMENT 'Date on which the regulatory test was performed.',
    `test_facility` STRING COMMENT 'Name of the laboratory or site where testing occurred.',
    `test_method` STRING COMMENT 'Standardized method or protocol used for the test (e.g., WLTP, SAE J1979).',
    `test_result` STRING COMMENT 'Outcome of the regulatory test associated with the obligation.. Valid values are `pass|fail|pending`',
    `waiver_reason` STRING COMMENT 'Explanation why the obligation was waived, if applicable.',
    CONSTRAINT pk_obligation PRIMARY KEY(`obligation_id`)
) COMMENT 'Operational record linking a specific vehicle program or model year to its applicable regulatory requirements by jurisdiction. Captures the obligation status (pending, in-progress, certified, waived, non-compliant), target certification date, responsible engineering team, and associated homologation record or emissions certification. Enables compliance program managers to track which regulatory obligations are open, in-flight, or closed for each vehicle program.';

CREATE OR REPLACE TABLE `automotive_ecm`.`compliance`.`zev_credit` (
    `zev_credit_id` BIGINT COMMENT 'System-generated unique identifier for each ZEV credit record.',
    `homologation_record_id` BIGINT COMMENT 'Foreign key linking to compliance.homologation_record. Business justification: ZEV credits are earned based on the certification of zero-emission vehicles, which is captured in homologation_record. zev_credit.source_record_reference is a denormalized STRING that references the s',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Link ZEV credit transactions to jurisdiction for regional credit accounting.',
    `model_id` BIGINT COMMENT 'Foreign key linking to vehicle.model. Business justification: ZEV credits under California ZEV program and similar regulations are earned per qualifying vehicle model sold. Linking to vehicle.model enables fleet-average ZEV compliance calculations, credit genera',
    `party_id` BIGINT COMMENT 'Identifier of the external party involved in a credit transfer or retirement.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: zev_credit.compliance_program is a denormalized STRING identifying the regulatory program under which the ZEV credit was earned or traded (e.g., California ZEV mandate, EPA GHG program). The regulator',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: ZEV credits are earned based on production of zero-emission vehicles from specific vehicle programs. Credit generation reporting and CARB compliance require linking each credit to the vehicle program ',
    `counterparty_role` STRING COMMENT 'Role of the counterparty in the credit transaction.. Valid values are `buyer|seller|regulator|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the credit record was first created in the lakehouse.',
    `credit_basis` STRING COMMENT 'Basis on which the credit was earned, such as vehicle sales volume, powertrain type, or fleet volume.. Valid values are `vehicle_sales|powertrain_type|fleet_volume`',
    `credit_price_usd` DECIMAL(18,2) COMMENT 'Monetary valuation of a single credit in U.S. dollars, if applicable for trading.',
    `credit_quantity` DECIMAL(18,2) COMMENT 'Number of credits (can be fractional) associated with the transaction.',
    `credit_status` STRING COMMENT 'Current lifecycle status of the credit record.. Valid values are `earned|banked|transferred|retired|pending|cancelled`',
    `credit_transaction_number` STRING COMMENT 'External business identifier for the credit transaction, used in regulatory filings and audits.',
    `credit_type` STRING COMMENT 'Category of credit earned or managed, indicating zero‑emission vehicle (ZEV) or greenhouse‑gas (GHG) credit.. Valid values are `ZEV|TZEV|AT_PZEV|GHG`',
    `credit_vintage_year` STRING COMMENT 'Calendar year in which the credit was originally earned.',
    `effective_date` DATE COMMENT 'Date the credit becomes effective for compliance accounting.',
    `expiration_date` DATE COMMENT 'Date the credit expires if not used or retired.',
    `model_year` STRING COMMENT 'Model year of the vehicle or powertrain that generated the credit.',
    `notes` STRING COMMENT 'Free‑form comments or audit notes related to the credit transaction.',
    `powertrain_type` STRING COMMENT 'Technology classification of the powertrain associated with the credit.. Valid values are `BEV|PHEV|HEV|ICE`',
    `region` STRING COMMENT 'Geographic region or jurisdiction code where the credit is reported.',
    `regulatory_body` STRING COMMENT 'Regulatory authority governing the credit (e.g., CARB, EPA).. Valid values are `CARB|EPA|NHTSA|EU|UN|OTHER`',
    `retirement_reason` STRING COMMENT 'Reason why a credit was retired (e.g., compliance fulfillment, voluntary surrender).',
    `source_system` STRING COMMENT 'Originating IT system that supplied the credit record (e.g., SAP, PLM).',
    `transaction_date` DATE COMMENT 'Date the credit event (earn, transfer, retirement) occurred.',
    `transaction_reference_number` STRING COMMENT 'External reference number for the credit transfer or retirement filing.',
    `transaction_type` STRING COMMENT 'High‑level classification of the credit event: earn, transfer, or retire.. Valid values are `earn|transfer|retire`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the credit record.',
    `version_number` STRING COMMENT 'Optimistic concurrency control version for the credit record.',
    CONSTRAINT pk_zev_credit PRIMARY KEY(`zev_credit_id`)
) COMMENT 'Master record for Zero Emission Vehicle (ZEV) and greenhouse gas (GHG) compliance credits earned, purchased, transferred, or retired under CARB ZEV mandate and EPA GHG credit programs. Captures credit type (ZEV, TZEV, AT PZEV, GHG), model year, credit quantity, credit vintage, earning basis (vehicle sales volume, powertrain type), credit status (earned, banked, transferred, retired), and counterparty for credit transfers. Supports CARB ZEV mandate compliance and EPA GHG credit banking strategy.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ADD CONSTRAINT `fk_compliance_homologation_record_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `automotive_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ADD CONSTRAINT `fk_compliance_homologation_record_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `automotive_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `automotive_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`recall_campaign` ADD CONSTRAINT `fk_compliance_recall_campaign_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ADD CONSTRAINT `fk_compliance_test_event_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `automotive_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ADD CONSTRAINT `fk_compliance_test_event_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ADD CONSTRAINT `fk_compliance_compliance_test_result_test_event_id` FOREIGN KEY (`test_event_id`) REFERENCES `automotive_ecm`.`compliance`.`test_event`(`test_event_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_requirement` ADD CONSTRAINT `fk_compliance_regulatory_requirement_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `automotive_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` ADD CONSTRAINT `fk_compliance_jurisdiction_parent_jurisdiction_id` FOREIGN KEY (`parent_jurisdiction_id`) REFERENCES `automotive_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `automotive_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ADD CONSTRAINT `fk_compliance_zev_credit_homologation_record_id` FOREIGN KEY (`homologation_record_id`) REFERENCES `automotive_ecm`.`compliance`.`homologation_record`(`homologation_record_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ADD CONSTRAINT `fk_compliance_zev_credit_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `automotive_ecm`.`compliance`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ADD CONSTRAINT `fk_compliance_zev_credit_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `automotive_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= TAGS =========
ALTER SCHEMA `automotive_ecm`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `automotive_ecm`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` SET TAGS ('dbx_subdomain' = 'certification_management');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ALTER COLUMN `homologation_record_id` SET TAGS ('dbx_business_glossary_term' = 'Homologation Record Identifier (HRI)');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ALTER COLUMN `configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Model Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ALTER COLUMN `powertrain_variant_id` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Variant Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ALTER COLUMN `approval_name` SET TAGS ('dbx_business_glossary_term' = 'Homologation Approval Name (HAN)');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ALTER COLUMN `approval_number` SET TAGS ('dbx_business_glossary_term' = 'Homologation Approval Number (HAN)');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ALTER COLUMN `approval_status_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Status Date (ASD)');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ALTER COLUMN `approval_type` SET TAGS ('dbx_business_glossary_term' = 'Homologation Approval Type (HAT)');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ALTER COLUMN `approval_type` SET TAGS ('dbx_value_regex' = 'type_approval|type_certification|type_test|type_homologation');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ALTER COLUMN `certification_document_url` SET TAGS ('dbx_business_glossary_term' = 'Certification Document URL (CD_URL)');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ALTER COLUMN `co2_emissions_g_per_km` SET TAGS ('dbx_business_glossary_term' = 'CO2 Emissions (grams per kilometer) (CO2_g/km)');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes (CN)');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ALTER COLUMN `document_version` SET TAGS ('dbx_business_glossary_term' = 'Document Version (DOC_VER)');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (ED)');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXP_D)');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ALTER COLUMN `fuel_consumption_l_per_100km` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumption (liters per 100 km) (FC_L/100km)');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ALTER COLUMN `homologation_record_status` SET TAGS ('dbx_business_glossary_term' = 'Homologation Record Status (HRS)');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ALTER COLUMN `homologation_record_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revoked|expired');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body (RB)');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'NHTSA|EPA|EURO_NCAP|UNECE|CARB|DOT');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ALTER COLUMN `test_cycle` SET TAGS ('dbx_business_glossary_term' = 'Test Cycle Standard (TCS)');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ALTER COLUMN `test_cycle` SET TAGS ('dbx_value_regex' = 'WLTP|NEDC|EPA|ECE|Euro_5|Euro_6');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date (TD)');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ALTER COLUMN `test_lab` SET TAGS ('dbx_business_glossary_term' = 'Testing Laboratory Name (TLN)');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier (UBU)');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ALTER COLUMN `vehicle_type` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Type (VT)');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ALTER COLUMN `vehicle_type` SET TAGS ('dbx_value_regex' = 'passenger|commercial|truck|suv|motorcycle|utility');
ALTER TABLE `automotive_ecm`.`compliance`.`homologation_record` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (CBU)');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` SET TAGS ('dbx_subdomain' = 'certification_management');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission ID');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `apqp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Apqp Plan Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `vin_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Related Vin Registry Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `cafe_value` SET TAGS ('dbx_business_glossary_term' = 'Corporate Average Fuel Economy (CAFE) Value');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `document_path` SET TAGS ('dbx_business_glossary_term' = 'Submission Document Path');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `document_version` SET TAGS ('dbx_business_glossary_term' = 'Document Version');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `emission_standard` SET TAGS ('dbx_business_glossary_term' = 'Emission Standard');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `fee_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Submission Fee Gross Amount');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `fee_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Submission Fee Net Amount');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `fee_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Submission Fee Tax Amount');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'gasoline|diesel|hybrid|electric|hydrogen');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical Submission');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `is_urgent` SET TAGS ('dbx_business_glossary_term' = 'Is Urgent Submission');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_body_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Code');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_body_code` SET TAGS ('dbx_value_regex' = 'NHTSA|EPA|CARB|UNECE|Euro_NCAP|DOT');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_body_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Name');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_submission_status` SET TAGS ('dbx_value_regex' = 'submitted|acknowledged|approved|rejected|under_review');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `reviewer_comments` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `status_change_date` SET TAGS ('dbx_business_glossary_term' = 'Status Change Date');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_category` SET TAGS ('dbx_business_glossary_term' = 'Submission Category');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_category` SET TAGS ('dbx_value_regex' = 'domestic|export|both');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Reference Number');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_value_regex' = 'type_approval|certificate_of_conformity|recall_notice|cafe_report|safety_compliance_report');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`compliance`.`recall_campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`compliance`.`recall_campaign` SET TAGS ('dbx_subdomain' = 'certification_management');
ALTER TABLE `automotive_ecm`.`compliance`.`recall_campaign` ALTER COLUMN `recall_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for compliance_recall_campaign');
ALTER TABLE `automotive_ecm`.`compliance`.`recall_campaign` ALTER COLUMN `configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`recall_campaign` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Model Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`recall_campaign` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`recall_campaign` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`recall_campaign` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` SET TAGS ('dbx_subdomain' = 'testing_operations');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `test_event_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Test Event ID');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `homologation_id` SET TAGS ('dbx_business_glossary_term' = 'Homologation Record ID');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `powertrain_variant_id` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Variant Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `ambient_humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Ambient Humidity (%)');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `ambient_pressure_kpa` SET TAGS ('dbx_business_glossary_term' = 'Ambient Pressure (kPa)');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `ambient_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature (°C)');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'pending|issued|rejected|withdrawn');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `is_retest` SET TAGS ('dbx_business_glossary_term' = 'Retest Indicator');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `measured_unit` SET TAGS ('dbx_business_glossary_term' = 'Measured Unit');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Test Value');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Test Event Notes');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `pass_fail_flag` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Flag');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `result` SET TAGS ('dbx_business_glossary_term' = 'Test Result');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `retest_reason` SET TAGS ('dbx_business_glossary_term' = 'Retest Reason');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `test_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Test Batch Number');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `test_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Test Category');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `test_category` SET TAGS ('dbx_value_regex' = 'emissions|crash|noise|fuel_economy|range|charging');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `test_condition` SET TAGS ('dbx_business_glossary_term' = 'Test Condition Description');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `test_equipment_name` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment Name');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `test_event_number` SET TAGS ('dbx_business_glossary_term' = 'Test Event Number');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `test_event_status` SET TAGS ('dbx_business_glossary_term' = 'Test Event Status');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `test_event_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|passed|failed|cancelled');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `test_facility` SET TAGS ('dbx_business_glossary_term' = 'Testing Facility Name');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `test_location` SET TAGS ('dbx_business_glossary_term' = 'Testing Facility Location');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `test_operator_name` SET TAGS ('dbx_business_glossary_term' = 'Test Operator Name');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `test_operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `test_operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `test_program` SET TAGS ('dbx_business_glossary_term' = 'Test Program Name');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `test_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Test Sequence Number');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `test_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Timestamp');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Compliance Test Type');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'WLTP|FTP-75|NEDC|RDE|NCAP|FMVSS');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `automotive_ecm`.`compliance`.`test_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` SET TAGS ('dbx_subdomain' = 'testing_operations');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `compliance_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Test Result ID');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `test_event_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Test Event ID');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'calibrated|uncalibrated|pending');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Result Comments');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `compliance_regulation_code` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation Code');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'SAP_QM|MES|PLM|Custom');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `is_outlier` SET TAGS ('dbx_business_glossary_term' = 'Outlier Indicator');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `lab_location_code` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Location Code');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `limit_unit` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Limit Unit');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `limit_unit` SET TAGS ('dbx_value_regex' = 'g/km|mg/km|dB|mm|kg|%');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'lab|in_vehicle|simulation');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `measurement_pressure_kpa` SET TAGS ('dbx_business_glossary_term' = 'Measurement Pressure (kPa)');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `measurement_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Measurement Temperature (°C)');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `measurement_uncertainty` SET TAGS ('dbx_business_glossary_term' = 'Measurement Uncertainty');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `parameter_code` SET TAGS ('dbx_business_glossary_term' = 'Test Parameter Code');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Test Parameter Name');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `regulatory_limit` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Limit');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `test_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Test Batch Number');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `test_phase` SET TAGS ('dbx_business_glossary_term' = 'Test Phase');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `test_phase` SET TAGS ('dbx_value_regex' = 'cold_start|hot_start|wl_tp_low|wl_tp_medium|wl_tp_high|wl_tp_extra_high');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `test_result_status` SET TAGS ('dbx_business_glossary_term' = 'Test Result Record Status');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `test_result_status` SET TAGS ('dbx_value_regex' = 'recorded|reviewed|approved');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `test_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Timestamp');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `uncertainty_unit` SET TAGS ('dbx_business_glossary_term' = 'Uncertainty Unit');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `uncertainty_unit` SET TAGS ('dbx_value_regex' = 'g/km|mg/km|dB|mm|kg|%');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `automotive_ecm`.`compliance`.`compliance_test_result` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'g/km|mg/km|dB|mm|kg|%');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_requirement` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_requirement` SET TAGS ('dbx_subdomain' = 'regulatory_framework');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Identifier');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `compliance_requirement_summary` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement Summary');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `is_global` SET TAGS ('dbx_business_glossary_term' = 'Global Applicability Flag');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `market` SET TAGS ('dbx_business_glossary_term' = 'Market');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `market` SET TAGS ('dbx_value_regex' = 'US|EU|CA|JP|CN|KR');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `powertrain_type` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Type');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `powertrain_type` SET TAGS ('dbx_value_regex' = 'ICE|EV|HEV|PHEV|FCEV');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulation_code` SET TAGS ('dbx_business_glossary_term' = 'Regulation Code');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulation_type` SET TAGS ('dbx_business_glossary_term' = 'Regulation Type');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulation_type` SET TAGS ('dbx_value_regex' = 'safety|emissions|fuel_economy|equipment|environment|homologation');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_requirement_name` SET TAGS ('dbx_business_glossary_term' = 'Regulation Name');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_requirement_status` SET TAGS ('dbx_business_glossary_term' = 'Regulation Lifecycle Status');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_requirement_status` SET TAGS ('dbx_value_regex' = 'active|superseded|proposed|withdrawn');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `source_document_url` SET TAGS ('dbx_business_glossary_term' = 'Source Document URL');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `vehicle_category` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Category');
ALTER TABLE `automotive_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Regulation Version');
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` SET TAGS ('dbx_subdomain' = 'regulatory_framework');
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Identifier');
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `parent_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Jurisdiction Identifier');
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `cafe_target_gpm` SET TAGS ('dbx_business_glossary_term' = 'CAFE Target (g/mi)');
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `compliance_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Compliance Documentation URL');
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `emissions_standard_tier` SET TAGS ('dbx_business_glossary_term' = 'Emissions Standard Tier');
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `epa_emission_limit_g_per_km` SET TAGS ('dbx_business_glossary_term' = 'EPA Emission Limit (g/km)');
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `homologation_process_time_days` SET TAGS ('dbx_business_glossary_term' = 'Homologation Process Time (Days)');
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `is_eu_member` SET TAGS ('dbx_business_glossary_term' = 'EU Membership Flag');
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `iso_country_code` SET TAGS ('dbx_business_glossary_term' = 'ISO Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `iso_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `jurisdiction_description` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Description');
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `jurisdiction_name` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Name');
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `jurisdiction_status` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Status');
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `jurisdiction_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired|suspended');
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `jurisdiction_type` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Type');
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `jurisdiction_type` SET TAGS ('dbx_value_regex' = 'federal|state|national|supranational|regional|local');
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `market_entry_requirements` SET TAGS ('dbx_business_glossary_term' = 'Market Entry Requirements');
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `ncap_rating_required` SET TAGS ('dbx_business_glossary_term' = 'NCAP Rating Requirement');
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `recall_reporting_requirement` SET TAGS ('dbx_business_glossary_term' = 'Recall Reporting Requirement');
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `regulatory_body_website` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Website URL');
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `safety_standard_framework` SET TAGS ('dbx_business_glossary_term' = 'Safety Standard Framework');
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `tax_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Standard Tax Rate (Percent)');
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `unece_type_approval_code` SET TAGS ('dbx_business_glossary_term' = 'UNECE Type Approval Code');
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `automotive_ecm`.`compliance`.`jurisdiction` ALTER COLUMN `wltp_test_cycle` SET TAGS ('dbx_business_glossary_term' = 'WLTP Test Cycle');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` SET TAGS ('dbx_subdomain' = 'regulatory_framework');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation ID');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program ID (VEHICLE_PROGRAM_ID)');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `actual_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Certification Date (ACTUAL_CERTIFICATION_DATE)');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `audit_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp (AUDIT_CREATED_TIMESTAMP)');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `audit_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp (AUDIT_UPDATED_TIMESTAMP)');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body (CERTIFICATION_BODY)');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score (COMPLIANCE_SCORE)');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date (CORRECTIVE_ACTION_DUE_DATE)');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CORRECTIVE_ACTION_PLAN)');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From (EFFECTIVE_FROM)');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until (EFFECTIVE_UNTIL)');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `emission_value` SET TAGS ('dbx_business_glossary_term' = 'Emission Value (EMISSION_VALUE)');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `evidence_document_path` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document Path (EVIDENCE_DOCUMENT_PATH)');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `fuel_economy_value` SET TAGS ('dbx_business_glossary_term' = 'Fuel Economy Value (FUEL_ECONOMY_VALUE)');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical (IS_CRITICAL)');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `is_regulatory` SET TAGS ('dbx_business_glossary_term' = 'Is Regulatory (IS_REGULATORY)');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (LAST_REVIEW_DATE)');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year (MODEL_YEAR)');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date (NEXT_REVIEW_DATE)');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `non_compliance_reason` SET TAGS ('dbx_business_glossary_term' = 'Non‑Compliance Reason (NON_COMPLIANCE_REASON)');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_number` SET TAGS ('dbx_business_glossary_term' = 'Obligation Number (OBLIGATION_NUMBER)');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Obligation Status (STATUS)');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|certified|waived|non_compliant');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority (PRIORITY)');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `responsible_engineering_group` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineering Group (RESPONSIBLE_ENGINEERING_GROUP)');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level (RISK_LEVEL)');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `target_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Target Certification Date (TARGET_CERTIFICATION_DATE)');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date (TEST_DATE)');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `test_facility` SET TAGS ('dbx_business_glossary_term' = 'Test Facility (TEST_FACILITY)');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `test_method` SET TAGS ('dbx_business_glossary_term' = 'Test Method (TEST_METHOD)');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Test Result (TEST_RESULT)');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|pending');
ALTER TABLE `automotive_ecm`.`compliance`.`obligation` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason (WAIVER_REASON)');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` SET TAGS ('dbx_subdomain' = 'regulatory_framework');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `zev_credit_id` SET TAGS ('dbx_business_glossary_term' = 'Zero Emission Vehicle Credit ID');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `homologation_record_id` SET TAGS ('dbx_business_glossary_term' = 'Homologation Record Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Model Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `counterparty_role` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Role');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `counterparty_role` SET TAGS ('dbx_value_regex' = 'buyer|seller|regulator|none');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `credit_basis` SET TAGS ('dbx_business_glossary_term' = 'Credit Basis');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `credit_basis` SET TAGS ('dbx_value_regex' = 'vehicle_sales|powertrain_type|fleet_volume');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `credit_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Credit Price (USD)');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `credit_quantity` SET TAGS ('dbx_business_glossary_term' = 'Credit Quantity');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `credit_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Status');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `credit_status` SET TAGS ('dbx_value_regex' = 'earned|banked|transferred|retired|pending|cancelled');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `credit_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Transaction Number');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `credit_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Type (ZEV, TZEV, AT PZEV, GHG)');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `credit_type` SET TAGS ('dbx_value_regex' = 'ZEV|TZEV|AT_PZEV|GHG');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `credit_vintage_year` SET TAGS ('dbx_business_glossary_term' = 'Credit Vintage Year');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `powertrain_type` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Type');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `powertrain_type` SET TAGS ('dbx_value_regex' = 'BEV|PHEV|HEV|ICE');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'CARB|EPA|NHTSA|EU|UN|OTHER');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_business_glossary_term' = 'Retirement Reason');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference Number');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'earn|transfer|retire');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `automotive_ecm`.`compliance`.`zev_credit` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
